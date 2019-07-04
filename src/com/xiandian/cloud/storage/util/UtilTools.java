/*
 * Copyright (c) 2014, 2016, XIANDIAN and/or its affiliates. All rights reserved.
 * XIANDIAN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 */
package com.xiandian.cloud.storage.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.tika.Tika;
import org.apache.tika.metadata.Metadata;
import org.openstack4j.api.OSClient.OSClientV2;
import org.openstack4j.openstack.OSFactory;

import com.xiandian.cloud.storage.cons.Constants;

/**
 * 工具类，提供公共方法
 * 
 * @author 云计算应用与开发项目组
 * @since  V2.0
 * 
 */
public class UtilTools {

	public static String COFING_FILE = "/config/xiandian.properties";
	public static Properties p;
	
	public static String AUTHURL = UtilTools.getConfig().getProperty("AUTHURL");
	public static String USERNAME = UtilTools.getConfig().getProperty("USERNAME");
	public static String PASSWORD = UtilTools.getConfig().getProperty("PASSWORD");
	public static String TENANTID = UtilTools.getConfig().getProperty("TENANTID");
	public static String TENANTNAME = UtilTools.getConfig().getProperty("TENANTNAME");

	public static Properties getConfig() {
		if (p == null) {
			p = new Properties();
			try {
				p.load(Thread.currentThread().getContextClassLoader()
						.getResourceAsStream(COFING_FILE));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return p;
	}

	/**
	 * 将即将进行数据分析的文件转换为txt格式
	 * @param filepath
	 * @param realPath
	 * @throws Exception
	 */
	public static void constrTxt(String filepath,String realPath) throws Exception {
		Tika tika = new Tika();
		Metadata metadata = new Metadata();
		File file = new File(
				filepath);
		String fileStr = tika
				.parseToString(new FileInputStream(file), metadata,(int)file.length());
		int length = 0; 
		char[] buffer = new char[2048];
		BufferedReader br = new BufferedReader(new StringReader(fileStr));
		File files =new File(realPath+Constants.CONSTRTXTPATH);
		if(!files.exists()){
			files.createNewFile();
		}
		Writer out = new BufferedWriter(new OutputStreamWriter(  
                new FileOutputStream(files), "utf-8"));	
		while ((length = br.read(buffer)) != -1) { 
			out.write(new String(buffer, 0, length));
		}
		out.flush();
		out.close();
	}
	
	
	/**
	 * 默认是utf-8编码
	 * 
	 * @param str
	 * @return
	 */
	public static String converStr(String str) {
		return converStr(str, "UTF-8");
	}

	/**
	 * 
	 * @param str
	 * @param encode
	 * @return
	 */
	public static String converStr(String str, String encode) {
		if (str == null || str.equals("null")) {
			return "";
		}
		try {
			byte[] tmpbyte = str.getBytes("ISO8859_1");
			if (encode != null) {
				// 如果指定编码方式
				str = new String(tmpbyte, encode);
			} else {
				// 用系统默认的编码
				str = new String(tmpbyte);
			}
			return str;
		} catch (Exception e) {
		}
		return str;
	}
	
	public static String timeTostrHMS(Date date) {
		String strDate = "";
		if (date != null) {
			SimpleDateFormat format = new SimpleDateFormat(
					"yyyy-MM-dd HH:mm:ss");
			strDate = format.format(date);
		}
		return strDate;
	}


	public static String convertFileSize(long filesize) 
	{ 
		String strUnit="Bytes"; 
		String strAfterComma=""; 
		int intDivisor=1; 
		if(filesize>=1024*1024) 
	
		{ 
		strUnit = "MB"; 
		intDivisor=1024*1024; 
		} 
		else if(filesize>=1024) 
		{ 
		strUnit = "KB"; 
		intDivisor=1024; 
		} 
		if(intDivisor==1) return filesize + " " + strUnit; 
		strAfterComma = "" + 100 * (filesize % intDivisor) / intDivisor ; 
		if(strAfterComma=="") strAfterComma=".0"; 
		return filesize / intDivisor + "." + strAfterComma + " " + strUnit; 
	} 
	
	public static String replaceStr(String str) {
		str = str.replaceAll("%2F", "/");
		return str;
	}

	private static String imgeArray[] = { "bmp", "dib", "gif", "jfif", "jpe",
			"jpeg", "jpg", "png", "tif", "tiff", "ico" };

	private static String docArray[] = { "doc", "docx", "ppt", "pptx", "xls",
			"xlsx", "txt", "pdf", "csv", "xml", "sql" };

	private static String aviArray[] = { "avi", "wmv", "rmvb", "rm", "mp4",
			"mpg", "mkv", "swf", "flv", "asf", "mov" };

	private static String mp3Array[] = { "mp3", "wav", "mod", "mid", "cda",
			"ogg", "mod", "ra" };

	public static boolean isImage(String name) {
		int index = name.lastIndexOf(".");
		if (index == -1) {
			return false;
		}
		String tmpName = name.substring(index + 1, name.length());
		int len = imgeArray.length;
		for (int i = 0; i < len; i++) {
			if (imgeArray[i].equals(tmpName.toLowerCase())) {
				return true;
			}
		}
		return false;
	}

	public static boolean isDoc(String name) {
		int index = name.lastIndexOf(".");
		if (index == -1) {
			return false;
		}
		String tmpName = name.substring(index + 1, name.length());
		int len = docArray.length;
		for (int i = 0; i < len; i++) {
			if (docArray[i].equals(tmpName.toLowerCase())) {
				return true;
			}
		}
		return false;
	}

	public static boolean isMediea(String name) {
		int index = name.lastIndexOf(".");
		if (index == -1) {
			return false;
		}
		String tmpName = name.substring(index + 1, name.length());
		int len = aviArray.length;
		for (int i = 0; i < len; i++) {
			if (aviArray[i].equals(tmpName.toLowerCase())) {
				return true;
			}
		}
		return false;
	}

	public static boolean isMp3(String name) {
		int index = name.lastIndexOf(".");
		if (index == -1) {
			return false;
		}
		String tmpName = name.substring(index + 1, name.length());
		int len = mp3Array.length;
		for (int i = 0; i < len; i++) {
			if (mp3Array[i].equals(tmpName.toLowerCase())) {
				return true;
			}
		}
		return false;
	}
	
	// 循环遍历目录结构中的文件并添加至tar的输出流
			public static void addFiles(String rootPath, ZipOutputStream tout,
					String folderPath) {
				File srcPath = new File(rootPath + folderPath);
				int length = srcPath.listFiles().length;
				byte[] buf = new byte[1024]; // 设定读入缓冲区尺寸
				File[] files = srcPath.listFiles();
				try {
					for (int i = 0; i < length; i++) {
						if (files[i].isFile()) {
							System.out.println("file:" + files[i].getName());
							String filename = srcPath.getPath() + File.separator
									+ files[i].getName();
							// 打开需压缩文件作为文件输入流
							FileInputStream fin = new FileInputStream(filename); // filename是文件全路径
							ZipEntry tarEn = new ZipEntry(files[i].getName()); // 此处必须使用new
																		// TarEntry(File
																		// file);
//							tarEn.setName(folderPath + File.separator
//									+ files[i].getName()); // 此处需重置名称，默认是带全路径的，否则打包后会带全路径
							tout.putNextEntry(tarEn);
							int num;
							while ((num = fin.read(buf)) != -1) {
								tout.write(buf, 0, num);
							}
							tout.closeEntry();
							fin.close();
						} else {
							System.out.println(files[i].getPath());
							addFiles(rootPath, tout, folderPath + File.separator
									+ files[i].getName());
						}
					}
				} catch (FileNotFoundException e) {
					System.out.println(e);
				} catch (IOException e) {
					System.out.println(e);
				}

			}
			
		// 生成tar并压缩成tar.gz
			public static void WriteToTarGzip(String rootPath, String folderPath,
					String targzipFilePath) {
				byte[] buf = new byte[1024]; // 设定读入缓冲区尺寸
				try {
					targzipFilePath = rootPath + targzipFilePath;
					// 建立压缩文件输出流
					FileOutputStream fout = new FileOutputStream(targzipFilePath);
					// 建立tar压缩输出流
					ZipOutputStream tout = new ZipOutputStream(fout);
					addFiles(rootPath, tout, folderPath);
					tout.close();
					fout.close();

					// 建立压缩文件输出流
//					FileOutputStream gzFile = new FileOutputStream(targzipFilePath);
//					// 建立gzip压缩输出流
//					ZipOutputStream gzout = new ZipOutputStream(gzFile);
//					// 打开需压缩文件作为文件输入流
//					FileInputStream tarin = new FileInputStream(targzipFilePath); // targzipFilePath是文件全路径
//					int len;
//					while ((len = tarin.read(buf)) != -1) {
//						gzout.write(buf, 0, len);
//					}
//					gzout.close();
//					gzFile.close();
//					tarin.close();

				} catch (FileNotFoundException e) {
					System.out.println(e);
				} catch (IOException e) {
					System.out.println(e);
				}

//				File tarfile = new File(targzipFilePath);
//				tarfile.delete();
			}
			
			/**
			 * 删除某个文件夹下的所有文件夹和文件
			 * 
			 * @param delpath
			 *            String
			 * @throws FileNotFoundException
			 * @throws IOException
			 * @return boolean
			 */
			public static boolean deletefile(String delpath) throws Exception {
				try {

					File file = new File(delpath);
					// 当且仅当此抽象路径名表示的文件存在且 是一个目录时，返回 true
					if (!file.isDirectory()) {
						file.delete();
					} else if (file.isDirectory()) {
						String[] filelist = file.list();
						for (int i = 0; i < filelist.length; i++) {
							File delfile = new File(delpath + "\\" + filelist[i]);
							if (!delfile.isDirectory()) {
								delfile.delete();
							} else if (delfile.isDirectory()) {
								deletefile(delpath + "\\" + filelist[i]);
							}
						}
						file.delete();
					}

				} catch (FileNotFoundException e) {
				}
				return true;
			}
			
			
			public static String matchsPath (String path,String mathch){
				if (path == null)
				{
					path = Constants.RESOURCE_FILE+"/"+mathch.trim();
				}else{
					path = Constants.RESOURCE_FILE+"/"+mathch.trim()+path.trim();
				}
				
				boolean contains = path.contains(Constants.RESOURCE_FILE+"/"+mathch.trim());
				
				return contains?path:Constants.RESOURCE_FILE+"/"+mathch.trim();
			}
}
