package com.xiandian.cloud.storage.dao;

import org.springframework.stereotype.Repository;

import com.xiandian.cloud.storage.domain.GroupLink;

@Repository
public class GroupLinkDao extends BaseDao<GroupLink>{
	public void joinGroup(int groupid,int usersid){
		GroupLink gl = new GroupLink();		
		gl.setGroupid(groupid);
		gl.setUsersid(usersid);
		save(gl);
	}
}
