package com.erp.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erp.bean.Billtype;
import com.erp.bean.Pbillstatus;
import com.erp.dao.BillstatusMapper;
import com.erp.service.BillstatusService;
@Service
public class BillstatusServiceImpl implements BillstatusService {

	@Autowired
	private BillstatusMapper billstatusMapper;
	public Pbillstatus getBillstatusbycode(String billstatuscode) {
		return billstatusMapper.getBillstatusbycode(billstatuscode);
	}

}
