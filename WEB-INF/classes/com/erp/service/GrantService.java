package com.erp.service;

import java.util.List;

import com.erp.bean.Grant;
import com.erp.bean.User;

public interface GrantService {

	List<Grant> getGrantList(User user);

	void deleteGrant(int id);

	void insertGrant(Grant grant);

	List<Grant> check(Grant grant);

	List<Grant> getGrantsByGrantedPsn(int userid);

}
