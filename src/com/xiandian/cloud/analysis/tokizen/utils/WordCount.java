/*
 * Copyright (c) 2014, 2016, XIANDIAN and/or its affiliates. All rights reserved.
 * XIANDIAN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 */
package com.xiandian.cloud.analysis.tokizen.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import net.paoding.analysis.analyzer.PaodingAnalyzer;
import net.sf.json.JSONArray;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.Token;
import org.apache.lucene.analysis.TokenStream;

import sun.util.logging.resources.logging;

import com.xiandian.cloud.storage.cons.Constants;
import com.xiandian.cloud.storage.sh.LogUtil;
import com.xiandian.cloud.storage.sh.security.QStringUtil;

/**
 * 
 * 
 * @author 云计算应用与开发项目组
 * @since V2.0
 * @date 2017/2/20
 * 
 */

public class WordCount {
	private static void logger(String str){
		LogUtil logUtil = new LogUtil();
		logUtil.info(QStringUtil.timeTostrHMS(new Date())+"-"+str);
	}
	public static class TokenizerMapper extends
			Mapper<Object, Text, Text, IntWritable> {
		private final static IntWritable one = new IntWritable(1); //定义一个one常量，值为“1”
		private Text word = new Text();

		public void map(Object key, Text value, Context context)
				throws IOException, InterruptedException {
			Analyzer analyzer = new PaodingAnalyzer(); //创建庖丁分词器
			String indexStr = value.toString();	//获取输入文本的一行数据
			StringReader reader = new StringReader(indexStr); 
			TokenStream ts = analyzer.tokenStream(indexStr, reader);//分词,attributesource,input
			Token t = ts.next();//逐个获得分词
			while (t != null) {
				word.set(t.termText());//设置word值为分词
				context.write(word, one);//向文本中写入,分词和“1”
				t = ts.next();//处理下一个分词
			}
		}
	}
	
	/**
	 * 
	 * 将Map数据进行Reduce聚合
	 *
	 */
	public static class IntSumReducer extends
			Reducer<Text, IntWritable, Text, IntWritable> {
		
		private IntWritable result = new IntWritable();
		
		public void reduce(Text key, Iterable<IntWritable> values,
				Context context) throws IOException, InterruptedException {
			int sum = 0;
			for (IntWritable val : values) {//map传过来的是key:word（分词）,values:1 遍历key表中的1个数
				sum += val.get();//实现累加
			}
			result.set(sum);
			context.write(key, result);//将key：word（分词）和value：result（累加的结果，出现的次数）写入context
//			System.out.println(key);
		}
	}

	/**
	 * 删除数据计算的文本文件
	 * 
	 * @param dir
	 * @return
	 */
	private static boolean deleteDir(File dir) {
		if (dir.isDirectory()) {
			String[] children = dir.list();//列出文件夹内的所有文件
			for (int i = 0; i < children.length; i++) {
				boolean success = deleteDir(new File(dir, children[i]));
				if (!success) {
					return false;
				}
			}
		}
		return dir.delete();//删除文件夹内的文件
	}

	/**
	 * 将计算结果转换为json格式
	 * 
	 * @param type
	 * @param filepath
	 * @param programPath
	 * @return
	 * @throws Exception
	 */
	public static JSONArray Json(final String type, String filepath,
		String programPath, int number) throws Exception {
		String[] str = { filepath, programPath + Constants.WORDCOUNTPATH };//filepath本地文件+路径，programPaht工程路径
		Configuration conf = new Configuration();
		String[] otherArgs = new GenericOptionsParser(conf, str)
				.getRemainingArgs();
		if (otherArgs.length < 2) {//如果少于两个路径
			System.err.println("Usage: wordcount <in> [<in>...] <out>");
			System.exit(2);
		}
		Job job = Job.getInstance(conf, "word count");//创建job
		job.setJarByClass(WordCount.class);//指定MapReduce主类
		logger("执行Map操作");
		job.setMapperClass(TokenizerMapper.class);//指定map操作类
		logger("执行Reduce操作");
		job.setCombinerClass(IntSumReducer.class);//指定combiner操作类
		job.setReducerClass(IntSumReducer.class);//指定reduce操作类
		job.setOutputKeyClass(Text.class);//设置输出键的类型
		job.setOutputValueClass(IntWritable.class);//设置输出值得类型
		for (int i = 0; i < otherArgs.length - 1; ++i) {
			FileInputFormat.addInputPath(job, new Path(otherArgs[i]));//获得输入路径
		}
		FileOutputFormat.setOutputPath(job, new Path(
				otherArgs[otherArgs.length - 1]));//获得输出路径
		if (job.waitForCompletion(true)) {//等待作业完成
			HashMap<String, Object> map = null;
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			try {
				File f = new File(otherArgs[otherArgs.length - 1]
						+ "\\part-r-00000");//在输出目录内创建输出的文件
				if (f.isFile() && f.exists()) {
					InputStreamReader read = new InputStreamReader(
							new FileInputStream(f), "utf-8");
					BufferedReader reader = new BufferedReader(read);
					String line;
					
					while ((line = reader.readLine()) != null) {
						int indexOf = line.indexOf("\t");
						String pref = line.substring(0, indexOf);

						if (pref.length() > 1) {
							String suff = line
									.substring(indexOf, line.length());
							map = new HashMap<String, Object>();
							
							if (Constants.ANALYSISVIEW_1.equals(type)) {//匹配返回页面的类型
								map.put("text", pref.trim());
								map.put("size", Integer.parseInt(suff.trim()));
							} else if (Constants.ANALYSISVIEW_2.equals(type)) {
								map.put("x", pref.trim()+":"+suff.trim());
								map.put("y", Integer.parseInt(suff.trim()));
							} else if (Constants.ANALYSISVIEW_3.equals(type)) {
								map.put("text", pref.trim());
								map.put("count", Integer.parseInt(suff.trim()));
							}
							
							list.add(map);//将map放到到list容器中
						}
						
					}
					
					read.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				File fdir = new File(otherArgs[otherArgs.length - 1]);//获取输出目录
				deleteDir(fdir);//删除输出目录
			}
			Collections.sort(list, new Comparator<HashMap<String, Object>>() {
				public int compare(HashMap<String, Object> o1,
						HashMap<String, Object> o2) {
					int i = 0;
					if (Constants.ANALYSISVIEW_1.equals(type)) {//根据匹配到的返回类型将list内的map内的数据根据size大小排序
						i = ((Integer) o2.get("size")).compareTo((Integer) o1
								.get("size"));
					} else if (Constants.ANALYSISVIEW_2.equals(type)) {
						i = ((Integer) o2.get("y")).compareTo((Integer) o1
								.get("y"));
					} else if (Constants.ANALYSISVIEW_3.equals(type)) {
						i = ((Integer) o2.get("count")).compareTo((Integer) o1
								.get("count"));
					}
					return i;
				}
			});
			if (Constants.ANALYSISVIEW_1.equals(type)) {//根据匹配到的返回类型,取出前number的数据
				if (list.size() > number) {
					list = list.subList(0, number);
				}
			}
			if (Constants.ANALYSISVIEW_2.equals(type)) {
				if (list.size() > number) {
					list = list.subList(0, number);
				}
			}
			if (Constants.ANALYSISVIEW_3.equals(type)) {
				if (list.size() > number) {
					list = list.subList(0, number);
				}
			}
			logger("执行JSON数据格式转换");
			JSONArray array = JSONArray.fromObject(list);//将list数据封装为josn格式的数据
			return array;//返回json数据
		}
		return null;
	}
}
