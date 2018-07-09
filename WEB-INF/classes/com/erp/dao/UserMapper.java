package com.erp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.erp.bean.Job;
import com.erp.bean.User;

public interface UserMapper {
	User login(User user);

	List<Job> getBilltype(User user);

	void updatepassword(User user);

	String getUser_role(int job);

	void updateDefaultrole(User user);

	User getUserById(int userid);

	List<User> getUserBydeptId(User user);
}
