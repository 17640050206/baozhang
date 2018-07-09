package com.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erp.bean.User;
import com.erp.bean.Workflow;
import com.erp.dao.WorkflowMapper;
import com.erp.service.WorkflowService;
@Service
public class WorkflowServiceImpl implements WorkflowService {
	@Autowired
	private WorkflowMapper workflowMapper;

	public List<Workflow> getBtdListExce(User user) {
		return workflowMapper.getBtdListExce(user);
	}

	public List<Workflow> getBtdList(User user) {
		return workflowMapper.getBtdList(user);
	}

	public List<Workflow> searchFlowBills(Map<String, Object> searchPara) {
		return workflowMapper.searchFlowBills(searchPara);
	}

	public List<Workflow> getFlowlistByBillid(int billid) {
		return workflowMapper.getFlowlistByBillid(billid);
	}

	public void insert(Workflow workflow) {
		workflowMapper.insert1(workflow);
	}

	public void updateFlow(Workflow w) {
		workflowMapper.updateFlow(w);
	}

	public Workflow getFlowById(int pk_pubwork) {
		return workflowMapper.getFlowById(pk_pubwork);
	}

	public void deleteFlow(int pk_loanbill) {
		workflowMapper.deleteFlow(pk_loanbill);
	}

	public int getCount(Map<String, Object> searchPara) {
		return workflowMapper.getCount(searchPara);
	}
}
