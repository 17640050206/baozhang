package com.erp.dao;

import com.erp.bean.Billtype;
import com.erp.bean.Pbillstatus;

public interface BillstatusMapper {

	Billtype getBilltypebycode(String billtypecode);

	Pbillstatus getBillstatusbycode(String billstatuscode);

}
