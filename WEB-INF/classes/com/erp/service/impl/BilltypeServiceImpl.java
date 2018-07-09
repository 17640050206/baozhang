package com.erp.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erp.bean.Billtype;
import com.erp.dao.BilltypeMapper;
import com.erp.service.BilltypeService;
@Service
public class BilltypeServiceImpl implements BilltypeService {
	@Autowired
	private BilltypeMapper billtypeMapper;


	public Billtype getBilltypebycode(String billtypecode) {
		return billtypeMapper.getBilltypebycode(billtypecode);
	}
	
}
