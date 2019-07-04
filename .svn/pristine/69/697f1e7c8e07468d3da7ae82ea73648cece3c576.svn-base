package com.xiandian.cloud.storage.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.xiandian.cloud.storage.domain.Group;

@Repository
public class GroupDao extends BaseDao<Group>{
	public List<Group> getAll()
	{
		String hql = "from Group order by name";
		return find(hql);
	}
	
	public List<Group> getGroup(int userid)
	{
		String hql = "from Group where userid=?";
		return find(hql,new Object[]{userid});
	}
	
	public List<Group> getGroupById(int id){
		String hql = "from Group where id=?";
		return find(hql,new Object[]{id});
	}
	  
	
	public void addGroup(int userid,String name,String date){
		Group g = new Group();
		g.setName(name);
		g.setUserid(userid);
		g.setDate(date);
		save(g);
	}
	
	public List findGroupMember(int groupid){
		String sql = "select username,t_user.id as id from t_user left join t_grouplink on t_user.id = t_grouplink.usersid where groupid = ?";
		return findSql(sql, new Object[]{groupid});
	}
	
	public List findGroupByUserId(int userid){
		String sql = "select groupid from t_grouplink where usersid = ?";
		return findSql(sql, new Object[]{userid});
	}
}
