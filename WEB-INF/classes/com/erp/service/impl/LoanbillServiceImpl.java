package com.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erp.bean.Borrowitem;
import com.erp.bean.Cashbill;
import com.erp.bean.Expitem;
import com.erp.bean.Loanbill;
import com.erp.bean.Paydetail;
import com.erp.bean.Project;
import com.erp.bean.Vendor;
import com.erp.dao.LoanbillMapper;
import com.erp.service.LoanbillService;

@Service
public class LoanbillServiceImpl implements LoanbillService {

	@Autowired
	private LoanbillMapper loanbillmapper;
	public List<Loanbill> searchBill(Map<String, Object> searchPara) {
		return loanbillmapper.searchBill(searchPara);
	}
	public Loanbill getLoanbillById(int billid) {
		return loanbillmapper.getLoanbillById(billid);
	}
	public void insert(Loanbill vo) {
		loanbillmapper.insert(vo);
	}
	public int getPKbybillno(String vbillno) {
		return loanbillmapper.getPKbybillno(vbillno);
	}
	public void insertPaydetail(Paydetail detail) {
		loanbillmapper.insertPaydetail(detail);
	}
	public Project getProjectByBm(String xmbm) {
		return loanbillmapper.getProjectByBm(xmbm);
	}
	public Vendor getVendor(Vendor v) {
		return loanbillmapper.getVendor(v);
	}
	public List<Paydetail> getPaydetailVos(int pk_loanbill) {
		return loanbillmapper.getPaydetailVos(pk_loanbill);
	}
	public void updatePbillstatus(Loanbill billid) {
		loanbillmapper.updatePbillstatus(billid);
	}
	public void deleteBill(int pk_loanbill) {
		loanbillmapper.deleteBill(pk_loanbill);
	}
	public void insertExpitem(Expitem item) {
		loanbillmapper.insertExpitem(item);
	}
	public List<Expitem> getExpitemVos(int pk_loanbill) {
		return loanbillmapper.getExpitemVos(pk_loanbill);
	}
	public void updateBill(Loanbill loanbill) {
		loanbillmapper.updateBill(loanbill);
	}
	public void deletePaydetails(int pk_loanbill) {
		loanbillmapper.deletePaydetails(pk_loanbill);
	}
	public void deleteExpitems(int pk_loanbill) {
		loanbillmapper.deleteExpitems(pk_loanbill);
	}
	public void insertBorroeitem(Borrowitem item) {
		loanbillmapper.insertBorroeitem( item);
	}
	public List<Borrowitem> getBorrowitemVos(int pk_loanbill) {
		return loanbillmapper.getBorrowitemVos( pk_loanbill);
	}
	public void deleteBorrowitems(int pk_loanbill) {
		loanbillmapper.deleteBorrowitems( pk_loanbill);
	}
	public Borrowitem getZyjeByBillno(String billno) {
		return loanbillmapper.getZyjeByBillno(billno);
	}
	public Loanbill getLoanbillByno(String billno) {
		return loanbillmapper.getLoanbillByno(billno);
	}
	public Cashbill getYhjeByBillno(String billno) {
		return loanbillmapper.getYhjeByBillno(billno);
	}
	public void insertCashbill(Cashbill item) {
		loanbillmapper.insertCashbill(item);
	}
	public List<Cashbill> getCashbillVos(int pk_loanbill) {
		return loanbillmapper.getCashbillVos(pk_loanbill);
	}
	public void deleteCashbills(int pk_loanbill) {
		loanbillmapper.deleteCashbills(pk_loanbill);
	}
	public int getCount(Map<String, Object> searchPara) {
		return loanbillmapper.getCount(searchPara);
	}
	public List<Loanbill> searchBillExap(Map<String, Object> searchPara) {
		return loanbillmapper.searchBillExap(searchPara);
	}

}
