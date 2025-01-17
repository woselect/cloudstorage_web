/*
 * Copyright (c) 2014, 2016, XIANDIAN and/or its affiliates. All rights reserved.
 * XIANDIAN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 */
package com.xiandian.cloud.storage.cons;

/**
 * 整个应用通用常量类
 * 
 * @author 云计算应用与开发项目组
 * @since  V2.0
 * 
 */
public class CommonConstant
{	
   /**
    * 用户对象放到Session中的键名称
    */
   public static final String USER_CONTEXT = "USER_CONTEXT";
   
   public static final String USER_ROLE = "USER_ROLE";
   
   public static final String USER_GROUP = "USER_GROUP";
   //垃圾箱前缀
   public static final String GARBAGE_PREFIX= "garbage_";
   //分页大小
   public static final int PAGE_SIZE = 10;
   
   //文件分类
   public static final int FILE_TYPE1 = 1;//图片
   public static final int FILE_TYPE2 = 2;//文档
   public static final int FILE_TYPE3 = 3;//视频
   public static final int FILE_TYPE4 = 4;//音乐
   public static final int FILE_TYPE5 = 5;//其他
   //消息提示
   public static final String SUCCESS_1 = "登录成功";
   public static final String SUCCESS_2 = "注册成功";
   public static final String SUCCESS_3 = "文件夹创建成功";
   public static final String SUCCESS_4 = "上传成功";
   public static final String SUCCESS_5 = "删除成功";
   public static final String SUCCESS_6 = "更新成功";
   public static final String SUCCESS_7 = "重命名成功";
   public static final String SUCCESS_8 = "复制成功";
   public static final String SUCCESS_9 = "移动成功";
   //错误信息
   public static final String ERROR_1 = "登录用户名不对";
   public static final String ERROR_2 = "登录密码不对";
   public static final String ERROR_3 = "用户名已经注册";
   public static final String ERROR_4 = "文件夹已经存在";
   public static final String ERROR_5 = "文件已经存在";
   public static final String ERROR_6 = "删除失败";
   public static final String ERROR_7 = "原密码不对";
   public static final String ERROR_8 = "不能将文件移动到自身";
   public static final String ERROR_9 = "不能将文件复制到自身";
}
