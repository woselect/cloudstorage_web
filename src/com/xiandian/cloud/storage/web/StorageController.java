/*
 * Copyright (c) 2014, 2016, XIANDIAN and/or its affiliates. All rights reserved.
 * XIANDIAN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 */
package com.xiandian.cloud.storage.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.smartcardio.ATR;

import jj2000.j2k.util.StringFormatException;
import net.sf.json.JSONArray;

import org.openstack4j.api.OSClient.OSClientV3;
import org.openstack4j.model.common.Identifier;
import org.openstack4j.model.storage.object.SwiftContainer;
import org.openstack4j.model.storage.object.SwiftObject;
import org.openstack4j.openstack.OSFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sun.org.apache.bcel.internal.generic.NEW;
import com.xiandian.cloud.analysis.tokizen.utils.WordCount;
import com.xiandian.cloud.storage.bean.MessageBean;
import com.xiandian.cloud.storage.cons.Constants;
import com.xiandian.cloud.storage.domain.User;
import com.xiandian.cloud.storage.service.SwiftStorageService;
import com.xiandian.cloud.storage.service.UserService;
import com.xiandian.cloud.storage.sh.SwiftDFS;
import com.xiandian.cloud.storage.sh.bean.FileBean;
import com.xiandian.cloud.storage.sh.util.DateUtil;
import com.xiandian.cloud.storage.util.Code;
import com.xiandian.cloud.storage.util.UtilTools;

/**
 * 为存贮封装的调用API
 * 
 * @author 云计算应用与开发项目组
 * @since V2.0
 * 
 */
@Controller
public class StorageController extends BaseController {
	private WebApplicationContext wac = ContextLoader
			.getCurrentWebApplicationContext();
	private String beanName = UtilTools.getConfig().getProperty("storage");

	@Autowired
	private UserService userService;
	
	@Autowired
	private SwiftStorageService swiftStorageService;


	/**
	 * 取得主页的文件
	 * 
	 * @param request
	 * @param response
	 * @param path
	 * @return
	 */
	@RequestMapping("/home")
	public ModelAndView home(HttpServletRequest request,
			HttpServletResponse response, String path) {
		ModelAndView view = new ModelAndView();
		User user = getSessionUser(request);
		path = UtilTools.converStr(path);
		List list = swiftStorageService.getAllStoredList(user.getUsername(), path);
		view.addObject("path", path);
		view.addObject("search", "false");
		view.addObject("list", list);
		view.setViewName("/main");
		view.addObject("type", 0);
		return view;
	}

	/**
	 * 上传文件
	 * 
	 * @param request
	 * @param response
	 * @param file
	 */
	@RequestMapping("/uploadfile")
	@ResponseBody
	public Object uploadfile(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "qqfile", required = true) MultipartFile file) {
		try {
			if (!file.isEmpty()) {
				byte[] bytes = file.getBytes();
				String upath = request.getSession().getServletContext()
						.getRealPath("/");
				String uuid = UUID.randomUUID().toString();
				String path = "upload/" + uuid + file.getOriginalFilename();
				FileOutputStream fos = new FileOutputStream(upath + path);
				fos.write(bytes);
				fos.close();
				return new MessageBean(true, Constants.SUCCESS_4, path);
			} else {
				return new MessageBean(false, Constants.ERROR_6);
			}
		} catch (Exception e) {
			return new MessageBean(false, Constants.ERROR_6);
		}
	}
    /**改的上传文件2 **/
	@RequestMapping("/createfile")
	@ResponseBody
	public Object createfile(HttpServletRequest request ,HttpServletResponse response,
			String path,String name, String filepath){
		    User user = getSessionUser(request);
		    SwiftStorageService service=new SwiftStorageService();
		    String userPath =request.getSession().getServletContext().getRealPath("/");
		    boolean flag=service.createFile(user.getUsername(),path,name,userPath+filepath);
		    
		    
		
		return new MessageBean(flag,flag ? Constants.SUCCESS_3 : Constants.ERROR_5);}
	
	
	
	
	
	
	
	
	/**改的创建目录的方法2**/
   @RequestMapping("/createdir")
   @ResponseBody
   public Object createdir(HttpServletRequest request,HttpServletResponse response,
		   String  path,String name){
	User user=getSessionUser(request);
	String username=user.getUsername();
	SwiftStorageService swift=new SwiftStorageService();
	boolean b=swift.createdirr(username,path,name);
    if (b) {
		System.out.println("文件创建成功！");
		return  new MessageBean(true,"文件创建成功！");
	} else {
		System.out.println("文件创建失败！");
		return new MessageBean(false,"文件创建失败！");
	}
	   
	}
	
	
	
	
	
	
	
	
	
	/**改的搜索方法2**/
	@RequestMapping(value="/search")
	public ModelAndView search(HttpServletRequest request,HttpServletResponse response,String key){
		System.out.println("搜索");
		System.out.println("key555"+key);
		ModelAndView view=new ModelAndView();
		User user=getSessionUser(request);
		List  list=SwiftStorageService.getSearchList(user.getUsername(),key);
		for(int i=0;i<list.size();i++){
			FileBean fb=(FileBean) list.get(i);
			System.out.println("fb.getLastmodified():"+fb.getLastmodified());
			System.out.println("fb.getLength():"+fb.getLength());
			System.out.println("fb.getName():"+fb.getName());
			System.out.println("fb.getPath():"+fb.getPath());
			
		}
		view.addObject("list",list);
		view.setViewName("search");
		if(view.isEmpty()){
			System.out.println("是空的！");
		}else{
			System.out.println("不是空的！");
		}
		
		return view;
	}
	/**改的文档的方法1**/
	@RequestMapping("/category")
	public ModelAndView category(HttpServletRequest request,HttpServletResponse response, int type){
		ModelAndView view=new ModelAndView();
		User user=getSessionUser(request);
		System.out.println("获得分类信息......");
		List list=SwiftStorageService.getCategorylist(user.getUsername(), type);
		view.addObject("search","false");
		view.addObject("list",list);
		view.setViewName("/category");
		view.addObject("type",type);
		
		return view;}
	
	/**改的删除的方法2**/
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(HttpServletRequest request, HttpServletResponse response,@RequestBody List<Map<String,Object>> list){
		User user=getSessionUser(request);
		String username=user.getUsername();
		SwiftStorageService service=new SwiftStorageService();
		service.deleteFile(username,list);
		return new MessageBean(true,"删除成功咯2");
		}
	
	/**改的重命名的方法2**/
	@RequestMapping("/rename")
	@ResponseBody
	public Object rename(HttpServletRequest request,HttpServletResponse response,
			String path, String name,boolean isDir){
		User user=getSessionUser(request);
		String username=user.getUsername();
		SwiftStorageService service=new SwiftStorageService();
		System.out.println("用户名username:"+username);
		System.out.println("地址path:"+path);
		System.out.println("改的文件名name:"+name);
		System.out.println("是否是目录isDir:"+isDir);
		service.rename(username,path,name,isDir);
		return new MessageBean(true,"重命名成功");
		}
	
	/**改的 复制或者移动 的方法2**/
	@RequestMapping("/copyormove")
	@ResponseBody
	public Object copyormove (HttpServletRequest request,HttpServletResponse response,
			String filePath, String fileName,String oper,String sourcePath){
		HttpSession session=request.getSession();//创建
		session.setAttribute("sourceFilePath", filePath);//sourceFilePath的属性值为filePath，在main.jsp中取出来
		session.setAttribute("sourceFileName", fileName);
		session.setAttribute("operFlag", oper);
		session.setAttribute("sourcePath", sourcePath);//保存当前位置
		return new MessageBean(true, "操作成功！");
		}
	
	
	
	
	
	
	
	/**改的粘贴的方法2**/
   @RequestMapping("/paste")
   @ResponseBody
   public Object paste(HttpServletRequest request, HttpServletResponse response,
		   String oldpath,String newpath){
	  HttpSession session=request.getSession();
	  User user=getSessionUser(request);
	  String userName =user.getUsername();
	  String [] strs =oldpath.split(",");
	  int len =strs.length;
	  if (len <1) {
		return null;//表明没有选中文件粘贴
	} else {
		for (int i = 0; i < strs.length; i++) {
			String[] temp = strs[i].split(">");
			System.out.println("path"+temp[0]);
			System.out.println("isDir"+temp[1]);
			swiftStorageService.paste(userName,temp[0],newpath,temp[1]);
			
		}
		session.setAttribute("operFlag", "");//设置operFlag的属性值为空，在main.jsp中取出来
	}
	   
	return new MessageBean(true, "粘贴成功！！22");
	}
	
	/**改的移动的方法2**/
	@RequestMapping("/move")
	@ResponseBody
	public Object move(HttpServletRequest request,HttpServletResponse response,
			String oldpath, String newpath){
		User user =getSessionUser(request);
		String userName=user.getUsername();
		HttpSession session=request.getSession();
		SwiftStorageService service=new SwiftStorageService();
		String [] strs =oldpath.split(",");
		int len =strs.length;
		if (len < 1) {
			return null;//表明没有选中文件移动
		} else {
			for (int i = 0; i < strs.length; i++) {
				String [] temp =strs[i].split(">");
				System.out.println("原路径path："+temp[0]);
				System.out.println("是否是目录isDir:"+temp[1]);
				service.move(userName,temp[0],newpath,temp[1]);
			}
			session.setAttribute("operFlag", "");//设置 operFlag的值为 ""
			return new MessageBean(true, "移动成功！");
		}
		
		
		}

	
	
	
	
	/**改的下载的方法2**/
	@RequestMapping("/download")
	public void download(HttpServletRequest request ,HttpServletResponse response,
			String paths){
		User user=getSessionUser(request);
		String userName=user.getUsername();
	    try {
	    	String [] strs =paths.split(",");
	    	int len = strs.length;
	    	if(len <1)//表面没有选中文件下载
	    		return;
	    	
	    	response.setContentType("text/html;charset=UTF-8");
	    	request.setCharacterEncoding("UTF-8");
			BufferedInputStream inputStream =null;
			BufferedOutputStream outputStream =null;
			String path=request.getSession().getServletContext().getRealPath("/");
			String contextpath=path +"export";
			
			if (len ==1) {//下载一个文件、
				String filepath =strs[0];
				filepath =UtilTools.converStr(filepath);
				byte [] b=swiftStorageService.download(userName,filepath);
				String [] strings=filepath.split("/");
				String filename =strings[strings.length-1];//除去文件路径，只剩文件名
				response.setContentType("application/octet-stream");
				response.setHeader("Content-disposition", "attachment;filename="+new String(filename.getBytes("UTF-8"),"ISO8859-1"));
				
				outputStream = new BufferedOutputStream(response.getOutputStream());
				outputStream.write(b);
				outputStream.close();
			} else {//下载多个文件
				String [] strings =strs[0].split("/");
				String temp =strings[strings.length-1];//获得第一要下载的文件名
				String [] str =temp.split("\\.");
				String rootname =contextpath +File.separator+str[0];//设置下载的文件名
				File rFile =new File(rootname);
				rFile.mkdir();
				for (int i = 0; i < len; i++) {
					String filepath =strs[i];
					filepath =UtilTools.converStr(filepath);
					byte [] b =swiftStorageService.download(userName,filepath);
					String [] splitStrings=filepath.split("/");
					String myfilename =splitStrings[splitStrings.length-1];
					String destpath =rootname +File.separator +myfilename;
					File destFile =new File(destpath);
					destFile.createNewFile();
					BufferedOutputStream buff= new BufferedOutputStream(new FileOutputStream(destFile));
				    buff.write(b);
				    buff.flush();
				    buff.close();
				}
				//打包        
				File tarFile = new File(rootname+".zip"); 
				tarFile.createNewFile();
				UtilTools.WriteToTarGzip(contextpath+File.separator, str[0], str[0]+".zip");
				
				//下载
				response.setContentType("application/octet-stream");
				String downloadFileName =new String(str[0].getBytes("ISO-8859-1"),"UTF-8");
				response.setHeader("Content-disposition", "attachment;Filename="+new String(downloadFileName.getBytes("UTF-8"),"ISO-8859-1"));
				outputStream =new BufferedOutputStream(response.getOutputStream());
				long k =0;
				byte [] b = new byte[1024];
				FileInputStream fis =new FileInputStream(tarFile);
				BufferedInputStream buff = new BufferedInputStream(fis);
				while (k<tarFile.length()) {   
					int j = buff.read(b, 0, 1024);
					k += j;
					outputStream.write(b);
				}
				outputStream.flush();
				outputStream.close();
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	
	/**改的垃圾箱的方法1**/
	@RequestMapping("/garbage")
	public ModelAndView garbage(HttpServletRequest request,HttpServletResponse response){
		ModelAndView view =new ModelAndView();
		User user=getSessionUser(request);
		List list=swiftStorageService.getGarbageList(user.getUsername());
		view.addObject("search","false");
		view.addObject("list",list);
		view.setViewName("/garbage");
		view.addObject("type",7);//来自head.jsp
		return view;
		}
	
	/**改的还原文件、文件夹的方法2**/
	@RequestMapping("/recovery")
	@ResponseBody
	public Object recovery(HttpServletRequest request,HttpServletResponse response,
			String filepath){
		User user=getSessionUser(request);
		String username=user.getUsername();
		String [] strs =filepath.split(",");
		int len =strs.length;
		if (len < 1) {//表明没有选中文件移动
			return null;
		} else {
			for (int i = 0; i < strs.length; i++) {
				String [] temp =strs[i].split(">");
				System.out.println("path:"+temp[0]);
				System.out.println("isDir"+temp[1]);
				SwiftStorageService.backGarbageFile(username,temp[0],temp[1]);
			}
			return new MessageBean(true, "恢复文件成功！");
		}
		
	}
	
	
	
	/**清空回收站的方法2**/
	@RequestMapping("/delAll")
	@ResponseBody
	public Object delAll(HttpServletRequest request,HttpServletResponse response){
		System.out.println("开始清空回收站..............");
		User user=getSessionUser(request);
		String username= user.getUsername();
		swiftStorageService.delAll(username);
		return beanName;
		}
	
	
	
	
	
	
	
	
	
	
	

	
	/**
	 * 数据分析返回云词界面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/analysis1")
	public ModelAndView analysis1(HttpServletRequest request,
			HttpServletResponse response ) {
				ModelAndView view = new ModelAndView();
				view.setViewName("/analysis1");
				return view;
	}

	/**
	 * 数据分析返回柱状界面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/analysis2")
	public ModelAndView analysis2(HttpServletRequest request,
			HttpServletResponse response ) {
				ModelAndView view = new ModelAndView();
				view.setViewName("/analysis2");
				return view;
	}
	
	/**
	 * 数据分析返回气泡界面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/analysis3")
	public ModelAndView analysis3(HttpServletRequest request,
			HttpServletResponse response ) {
				ModelAndView view = new ModelAndView();
				view.setViewName("/analysis3");
				return view;
	}

}
