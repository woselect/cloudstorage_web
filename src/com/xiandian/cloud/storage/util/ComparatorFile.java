/*
 * Copyright (c) 2014, 2016, XIANDIAN and/or its affiliates. All rights reserved.
 * XIANDIAN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 */
package com.xiandian.cloud.storage.util;

import java.util.Comparator;

import com.xiandian.cloud.storage.sh.bean.FileBean;

/**
 * 文件夹与文件排序的实现类
 * 
 * @author 云计算应用与开发项目组
 * @since V2.0
 * 
 */
public class ComparatorFile implements Comparator<FileBean> {

	public ComparatorFile() {
	}

	public int compare(FileBean f1, FileBean f2) {

		boolean f1dir = f1.isIsdirectory();
		boolean f2dir = f2.isIsdirectory();

		if (f1dir && f2dir) {
			return 0;
		} else if (!f1dir && f2dir) {
			return 1;
		} else if (f1dir && !f2dir) {
			return -1;
		} else if (!f1dir && !f2dir) {
			return 0;
		}
		return 0;
	}

}