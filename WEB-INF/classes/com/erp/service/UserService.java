package com.erp.service;

import java.util.List;

import com.erp.bean.Job;
import com.erp.bean.User;

public interface UserService {
	public List<String> getUserBilltype(String usercode);
	User login(User user);
	public List<Job> getBilltype(User user);
	public void updatepassword(User user);
	public String getUser_role(int job);
	public void updateDefaultrole(User user);
	public User getUserById(int userid);
	public List<User> getUserBydeptId(User u);
}
