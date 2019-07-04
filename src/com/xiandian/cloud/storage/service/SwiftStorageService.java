/*
 * Copyright (c) 2014, 2016, XIANDIAN and/or its affiliates. All rights reserved.
 * XIANDIAN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 */
package com.xiandian.cloud.storage.service;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.sym.Name;
import com.xiandian.cloud.storage.cons.Constants;
import com.xiandian.cloud.storage.sh.SwiftDFS;
import com.xiandian.cloud.storage.sh.bean.FileBean;
import com.xiandian.cloud.storage.util.ComparatorFile;

/**
 * swift对应的存储api
 * 
 * @author 云计算应用与开发项目组
 * @since  V2.0
 * 
 */
@Service
public class SwiftStorageService   {
	
	
	private static final Comparator<? super Object> comparator = null;




	/**
	 * 创建用户对应的容器，垃圾站
	 * 
	 * @param email
	 */
	public void createContainer(String username) {
		SwiftDFS swiftdfs= new SwiftDFS();
		swiftdfs.createContainer(username);
		swiftdfs.createContainer(Constants.GARBAGE_PREFIX + username);
	}

	/**
	 * 取得路径下的所有文件
	 */
	public List getAllStoredList(String username, String path) {
		SwiftDFS swiftdfs = new SwiftDFS();
		String up =null;
		up = username+"/"+path;
		List list =swiftdfs.getFile(up);
		ComparatorFile comparator = new ComparatorFile();  
        if (!list.isEmpty()) {  
            synchronized (list) {  
                Collections.sort(list, comparator);  
            }  
  
        }  
		return list;
	}
	/**改的 上传文件的3**/
	public boolean createFile(String username,String path,String name,String filepath){
		SwiftDFS swiftdfs=new SwiftDFS();
		boolean flag=swiftdfs.createFile(username, path, name, filepath);
		
		return flag;}
	
	

	
	
	
	
    /**改的创建目录3**/
	public boolean createdirr(String username, String path, String name) {
		// TODO Auto-generated method stub
		SwiftDFS swiftdfs=new SwiftDFS();
		String filepath="";
		if (path==null ||path.equals("")) {
			filepath=name+"/";
		} else {
			filepath=path+name+"/";
		}
		boolean flag=swiftdfs.createDir(username, filepath);
		
		return flag;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**改的搜索的3   取得搜索的文件**/

	public static List getSearchList(String username, String name) {
		SwiftDFS swiftdfs = new SwiftDFS();
		String up =null;
		up = username+"/";
		System.out.println("搜索文件---------"+username);
		List list =swiftdfs.searchFile(up, name);
		System.out.println("list大小："+list.size());
		ComparatorFile comparator = new ComparatorFile();  
        if (!list.isEmpty()) {  
            synchronized (list) {  
                Collections.sort(list, comparator);  
            }  
  
        }  
		return list;
	}
	/**改的我的文档2**/
	public static List getCategorylist(String username, int type) {
		// TODO Auto-generated method stub
		SwiftDFS  swiftdfs=new SwiftDFS();
		String up=null;
		up=username+"/";
		List list=swiftdfs.getCategoryStoredList(up, type);
		System.out.println("分类号："+type);
		return list;
	}
    /**改的删除的方法3**/
	public boolean deleteFile(String username, List<Map<String, Object>> list) {
		SwiftDFS swiftdfs=new SwiftDFS();
		for(Map<String , Object> map :list){
			String name=(String) map.get("name");
			String path=(String) map.get("path");
			String isDirStr=(String) map.get("isDir");  
			System.out.println("name:"+name);
			System.out.println("path:"+path);
			System.out.println("isDirStr:"+isDirStr);
			boolean isDir=isDirStr.equals("true")?true:false;
			swiftdfs.deleteFile(username, path, name, isDir);
		}
		return true;
		
	}
    /**改的重命名的方法 3**/
	public boolean rename(String username, String path, String name, boolean isDir) {
		// TODO Auto-generated method stub
		SwiftDFS swiftdfs=new SwiftDFS();
		String filepath=username+"/"+path;//重命名函数中只提供了老文件的path和新文件名，因此需要在老文件路径中添加容器信息
		if (isDir) {
			swiftdfs.renameDir(filepath, name);//重命名目录
		} else {
			swiftdfs.renameFile(filepath, name);//重命名文件
		}
		return true;
		
	}
    /**改的粘贴的方法3
     *  粘贴文件、目录
	 * 原文件包括容器名、路径名和文件名
	 * 目标文件包括容器名、路径名和文件名
	 * SwiftDFS类中的copyDir有问题，该函数在拷贝的目录下存在目录和文件时，就会出错，因此，需自己写拷贝目录的方法
     **/
	public void paste(String userName, String oldpath, String newpath,
			String isDir) {
		SwiftDFS swiftdfs=new SwiftDFS();
		if (!isDir.equalsIgnoreCase("true")) {//先粘贴文件，再粘贴文件夹
			int i=oldpath.lastIndexOf("/");
			String fileName=oldpath.substring(i+1,oldpath.length());
			newpath=userName+"/"+newpath+fileName;
			oldpath=userName+"/"+oldpath;
			swiftdfs.copyFile(oldpath, newpath);
		} else {
			String temp=oldpath.substring(0,oldpath.length()-1);//去掉最后的/
			int j=temp.lastIndexOf("/");
			String dirName=oldpath.substring(j+1, oldpath.length()-1);//获得要复制的目录名，不包括最后的/
			/**可能有错**/createdirr(userName, newpath, dirName);//创建目录，然后再执行复制目录下文件的操作
			pasteDir(swiftdfs,userName,oldpath,newpath+dirName+"/");
			
			System.out.println("旧路径："+oldpath);
			System.out.println("粘贴newpath"+newpath);
		}
		
	}
    /**改的粘贴文件的方法 1 被paste 调用**/
	private void pasteDir(SwiftDFS swiftdfs, String userName, String sourcepath,
			String destpath) {
		// TODO Auto-generated method stub
		List list=swiftdfs.getFile(userName+"/"+sourcepath);
		for (int i = 0; i < list.size(); i++) {
			FileBean fBean=(FileBean) list.get(i);
			System.out.println("fb的名字是什么："+fBean.getPath());
			String path=fBean.getPath();
			String name= fBean.getName();
			if (!fBean.isIsdirectory()) {//是文件则复制文件
				//拷贝文件函数包括两个参数，第一个是原文件（包含容器名、路径名、文件名）第二个参数是目标文件（包含容器名、路径名和文件名）
				swiftdfs.copyFile(userName+"/"+path, userName+"/"+destpath+name);
			} else {//复制目录
				String temp=path.substring(0,path.length()-1);//去掉最后 的/
				int j=temp.lastIndexOf("/");
				String dirName=path.substring(j+1, path.length());//获得需要复制的目录名，不包括最后的/
		  /**可能有错**/createdirr(userName, destpath, dirName);//创建目录，然后再执行复制文件的操作
                pasteDir(swiftdfs, userName, path,destpath+dirName+"/");
			}
			
			
			
		}
	}
	
	
	/**改的移动的方法3
	 *  移动文件、目录
	 * 原文件包括容器名、路径名和文件名
	 * 目标文件包括容器名、路径名和文件名
	 * **/
	public void move(String userName, String oldpath, String newpath,
			String isdir) {
		// TODO Auto-generated method stub
		SwiftDFS swiftdfs=new SwiftDFS();
		if (!isdir.equalsIgnoreCase("true")) {//先粘贴文件，再粘贴文件夹
			int i =oldpath.lastIndexOf("/");//oldpath路径中包含容器名
			String fileName =oldpath.substring(i+1, oldpath.length());
			newpath =userName+"/"+newpath+fileName;
			oldpath =userName+"/"+oldpath;   
			swiftdfs.moveFile(oldpath, newpath);
			/**移动文件时，如果目标文件夹存在该文件，做覆盖处理时，如果不删除原有文件，原有文件任然会存在
			 * oldpath路径中包含了容器名、路径名和文件名，而删除文件方法中的path不包含容器名，因此需要去掉
			 * oldpath中的容器名
			 * **/
			int first =oldpath.indexOf("/");//找出第一个/的位置，然后从第一个/家务事后续的字符即为path
			swiftdfs.deleteFile(userName, oldpath.substring(first+1, oldpath.length()), fileName, false);
			
			//打印的信息
			System.out.println("********************");
			System.out.println("容器名userName"+userName);
			System.out.println("路径 path"+oldpath.substring(first+1, oldpath.length()));
			System.out.println("文件名 fileName"+fileName);
		} else {
			String temp=oldpath.substring(0, oldpath.length()-1);//去掉最后的/
			int j =temp.lastIndexOf("/");
			String dirName = oldpath.substring(j+1, oldpath.length()-1);//获得需要移动的目录名，不包括最后的/
	/*可能会出错*/createdirr(userName, newpath, dirName);
			moveDir(swiftdfs,userName,oldpath,newpath+dirName+"/");
			swiftdfs.deleteFile(userName, oldpath, dirName, true);
		}
		System.out.println("旧路径 oldpath："+oldpath);
		System.out.println("粘贴新路经newpath:"+newpath);
	}
    
	
	
	/**改的移动目录的方法 1
	 * 系统系统的移动目录方法有问题，移动目录前，先创建目录，然后再移动目录下的文件
	 * **/
	private void moveDir(SwiftDFS swiftdfs, String userName, String sourcepath,
			String destpath) {
		// TODO Auto-generated method stub
		List list=swiftdfs.getFile(userName+"/"+sourcepath);
		for (int i = 0; i < list.size(); i++) {
			FileBean fb=(FileBean) list.get(i);
			System.out.println("fb的名字是："+fb.getPath());//fb的路径
			String path =fb.getPath();
			String name =fb.getName();
			if (!fb.isIsdirectory()) {//是文件则移动文件
				//拷贝文件函数包括两个参数，第一个是原文件（含容器名、路径名和文件名） ,第二个参数是目标文件（含容器名、路径名和文件名）
				swiftdfs.moveFile(userName+"/"+path, userName+"/"+destpath+name);
				
			} else {//移动目录
				String temp =path.substring(0, path.length()-1);//去掉最后的/
				int j=temp.lastIndexOf("/");
				String dirName=path.substring(j+1, path.length()-1);//获得需要移动的目录名，不包括最后的/
				createdirr(userName, destpath, dirName);//创建目录，再移动文件
				moveDir(swiftdfs, userName, path, destpath+dirName+"/");
				swiftdfs.deleteFile(userName, path, dirName, true);

			}
		}	
	}
    
	
	/**改的下载文件3**/
	public byte[] download(String userName, String name) {
		// TODO Auto-generated method stub
		SwiftDFS swiftdfs= new SwiftDFS(); 
		String filepath =userName +"/" +name;//文件包括路径
		byte [] b=swiftdfs.downloadFile(filepath);
		return b;
	}
     
	
	
	
	/****改的垃圾箱的方法2**/
	public List getGarbageList(String username) {
		// TODO Auto-generated method stub
		SwiftDFS swiftdfs=new SwiftDFS();
		String up = null;
		up = "garbage_" +username;
		System.out.println("回收站名称："+up);
		List list=swiftdfs.getFile(up);
		ComparatorFile comparator=new ComparatorFile();
		if (!list.isEmpty()) {
			synchronized (list) {
				Collections.sort(list,comparator);
			}
		}
		
		return list;
	}

	
	/**复原文件、文件夹的方法3***/
	public static void backGarbageFile(String username, String path,
			String isDir) {
		// TODO Auto-generated method stub
		SwiftDFS swiftdfs =new SwiftDFS();
		boolean flag =true;
		if ("false".equalsIgnoreCase(isDir)) 
			flag =false;
		swiftdfs.backgarbagefile(username, path, flag);
		
	}


	
	/**改的清空回收站的方法3**/
	public void delAll(String username) {
		// TODO Auto-generated method stub
		SwiftDFS swiftdfs=new SwiftDFS();
		swiftdfs.deleteAllGarbageFile(username);
		
	}


	
	
	
	
	
	
	
	
	
	
	
}
