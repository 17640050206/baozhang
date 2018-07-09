package com.erp.service;

import java.util.List;
import java.util.Map;

import com.erp.bean.Borrowitem;
import com.erp.bean.Cashbill;
import com.erp.bean.Expitem;
import com.erp.bean.Loanbill;
import com.erp.bean.Paydetail;
import com.erp.bean.Project;
import com.erp.bean.Vendor;

public interface LoanbillService {

	List<Loanbill> searchBill(Map<String, Object> searchPara);

	Loanbill getLoanbillById(int billid);

	void insert(Loanbill vo);

	int getPKbybillno(String vbillno);

	void insertPaydetail(Paydetail detail);

	Project getProjectByBm(String xmbm);

	Vendor getVendor(Vendor v);

	List<Paydetail> getPaydetailVos(int pk_loanbill);

	void updatePbillstatus(Loanbill bill);

	void deleteBill(int pk_loanbill);

	void insertExpitem(Expitem item);

	List<Expitem> getExpitemVos(int pk_loanbill);

	void updateBill(Loanbill loanbill);

	void deletePaydetails(int pk_loanbill);

	void deleteExpitems(int pk_loanbill);

	void insertBorroeitem(Borrowitem item);

	List<Borrowitem> getBorrowitemVos(int pk_loanbill);

	void deleteBorrowitems(int pk_loanbill);

	Borrowitem getZyjeByBillno(String billno);

	Loanbill getLoanbillByno(String billno);

	Cashbill getYhjeByBillno(String billno);

	void insertCashbill(Cashbill item);

	List<Cashbill> getCashbillVos(int pk_loanbill);

	void deleteCashbills(int pk_loanbill);

	int getCount(Map<String, Object> searchPara);

	List<Loanbill> searchBillExap(Map<String, Object> searchPara);




	
}
