package com.erp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erp.bean.Grant;
import com.erp.bean.User;
import com.erp.dao.GrantMapper;
import com.erp.service.GrantService;
@Service
public class GrantServiceImpl implements GrantService {
	@Autowired
	private GrantMapper grantMapper;

	public List<Grant> getGrantList(User user) {
		return grantMapper.getGrantList(user);
	}

	public void deleteGrant(int id) {
		grantMapper.deleteGrant(id);
	}

	public void insertGrant(Grant grant) {
		grantMapper.insertGrant(grant);
	}

	public List<Grant> check(Grant grant) {
		return grantMapper.check(grant);
	}

	public List<Grant> getGrantsByGrantedPsn(int userid) {
		return grantMapper.getGrantsByGrantedPsn(userid);
	}
}
