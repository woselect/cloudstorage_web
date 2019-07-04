package com.xiandian.cloud.storage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xiandian.cloud.storage.dao.GroupDao;
import com.xiandian.cloud.storage.dao.GroupLinkDao;
import com.xiandian.cloud.storage.domain.Group;

@Service
public class GroupService {
	@Autowired
	private GroupDao groupDao;
	@Autowired
	private GroupLinkDao groupLinkDao;

	public List<Group> getall(){
		return groupDao.getAll();
	}
	
	public List<Group> getGroup(int userid){
		
		return groupDao.getGroup(userid);
		
	}
	
	public List<Group> getGroupById(int id){
		
		return groupDao.getGroupById(id);
		
	}
	
	public void addGroup(int userid,String name,String date){
		groupDao.addGroup(userid, name, date);
	}
	
	public void joinGroup(int groupid,int usersid){
		groupLinkDao.joinGroup(groupid, usersid);
	}
	

	public List findGroupMember(int groupid){
		return groupDao.findGroupMember(groupid);
	}
	
	public List findGroupByUserId(int userid){
		return groupDao.findGroupByUserId(userid);
	}
}
