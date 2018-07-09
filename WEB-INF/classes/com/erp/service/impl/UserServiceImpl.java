package com.erp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erp.bean.Job;
import com.erp.bean.User;
import com.erp.dao.UserMapper;
import com.erp.service.UserService;
@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private UserMapper userMapper;
	public List<String> getUserBilltype(String usercode) {
		return null;
	}

	public User login(User user) {
		return userMapper.login(user);
	}

	public List<Job> getBilltype(User user) {
		return userMapper.getBilltype(user);
	}

	public void updatepassword(User user) {
		userMapper.updatepassword(user);
	}

	public String getUser_role(int job) {
		return userMapper.getUser_role(job);
	}

	public void updateDefaultrole(User user) {
		userMapper.updateDefaultrole(user);
	}

	public User getUserById(int userid) {
		return userMapper.getUserById(userid);
	}

	public List<User> getUserBydeptId(User user) {
		return userMapper.getUserBydeptId(user);
	}
	
}
