package com.erp.service;

import java.util.List;
import java.util.Map;

import com.erp.bean.User;
import com.erp.bean.Workflow;

public interface WorkflowService {

	List<Workflow> getBtdListExce(User user);

	List<Workflow> getBtdList(User user);

	List<Workflow> searchFlowBills(Map<String, Object> searchPara);

	List<Workflow> getFlowlistByBillid(int billid);

	void insert(Workflow workflow);

	void updateFlow(Workflow w);

	Workflow getFlowById(int pk_pubwork);

	void deleteFlow(int pk_loanbill);

	int getCount(Map<String, Object> searchPara);


}
