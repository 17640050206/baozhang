package com.erp.dao;

import java.util.List;

import com.erp.bean.Grant;
import com.erp.bean.User;

public interface GrantMapper {

	List<Grant> getGrantList(User user);

	void deleteGrant(int id);

	void insertGrant(Grant grant);

	List<Grant> check(Grant grant);

	List<Grant> getGrantsByGrantedPsn(int userid);

}
