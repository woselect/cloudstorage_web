/*
 * Copyright (c) 2014, 2016, XIANDIAN and/or its affiliates. All rights reserved.
 * XIANDIAN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 */
package com.xiandian.cloud.storage.util;

/**
 * 
 * @author 云计算应用与开发项目组
 * @since V2.0
 * 
 */
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

	public static String longToString(String dateFormat,Long millSec) {
		SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
	    Date date= new Date(millSec);
	    return sdf.format(date);
	}
	public static String DateToString(String dateFormat,Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
		return sdf.format(date);
	}
	
	public static String cstToHMS(Date cst) {
		SimpleDateFormat datefarmat =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return datefarmat.format(cst).toString();
	}
}
