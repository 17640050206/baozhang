package com.erp.dao;

import java.util.List;
import java.util.Map;

import com.erp.bean.User;
import com.erp.bean.Workflow;

public interface WorkflowMapper {

	List<Workflow> getBtdListExce(User user);

	List<Workflow> getBtdList(User user);

	List<Workflow> searchFlowBills(Map<String, Object> searchPara);

	List<Workflow> getFlowlistByBillid(int billid);


	void insert1(Workflow workflow);

	void updateFlow(Workflow w);

	Workflow getFlowById(int pk_pubwork);

	void deleteFlow(int pk_loanbill);

	int getCount(Map<String, Object> searchPara);

}
