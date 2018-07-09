package com.erp.bean;

import java.math.BigDecimal;
import java.util.List;

public class Loanbill {
	private int pk_loanbill;
	private String billtypecode;
	private String vbillno;
	private String billtypename;
	private String psnname;
	private String pbillstatusname;
	private String billdate;
	private BigDecimal lzje;
	private int pk_psn;
	private int deptid;
	private String deptname;
	private String digest;
	private int dr;
	private String pbillstatus;
	private String year;
	private String month;
	private String email;
	private String mobile;
	private String zffs;
	private String account;
	private String bank;
	private String transferdate;
	private String appreason;
	private String xmbm;
	private String xmmc;
	private int pk_project;
	private int pk_pubwork;
	private List<Paydetail> paydetails;
	private List<Expitem> expitems;
	private List<Borrowitem> borrowitems;
	private List<Cashbill> cashbills;
	private BigDecimal zyje;
	private String ts;
	
	
	public String getTs() {
		return ts;
	}
	public void setTs(String ts) {
		this.ts = ts;
	}
	public BigDecimal getZyje() {
		return zyje;
	}
	public void setZyje(BigDecimal zyje) {
		this.zyje = zyje;
	}
	public int getPk_pubwork() {
		return pk_pubwork;
	}
	public void setPk_pubwork(int pk_pubwork) {
		this.pk_pubwork = pk_pubwork;
	}
	public int getPk_project() {
		return pk_project;
	}
	public void setPk_project(int pk_project) {
		this.pk_project = pk_project;
	}
	public String getXmbm() {
		return xmbm;
	}
	public void setXmbm(String xmbm) {
		this.xmbm = xmbm;
	}
	public String getXmmc() {
		return xmmc;
	}
	public void setXmmc(String xmmc) {
		this.xmmc = xmmc;
	}
	
	
	
	public List<Cashbill> getCashbills() {
		return cashbills;
	}
	public void setCashbills(List<Cashbill> cashbills) {
		this.cashbills = cashbills;
	}
	public List<Borrowitem> getBorrowitems() {
		return borrowitems;
	}
	public void setBorrowitems(List<Borrowitem> borrowitems) {
		this.borrowitems = borrowitems;
	}
	public List<Expitem> getExpitems() {
		return expitems;
	}
	public void setExpitems(List<Expitem> expitems) {
		this.expitems = expitems;
	}
	public List<Paydetail> getPaydetails() {
		return paydetails;
	}
	public void setPaydetails(List<Paydetail> paydetails) {
		this.paydetails = paydetails;
	}
	public String getTransferdate() {
		return transferdate;
	}
	public void setTransferdate(String transferdate) {
		this.transferdate = transferdate;
	}
	public String getAppreason() {
		return appreason;
	}
	public void setAppreason(String appreason) {
		this.appreason = appreason;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getZffs() {
		return zffs;
	}
	public void setZffs(String zffs) {
		this.zffs = zffs;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getDeptname() {
		return deptname;
	}
	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getPk_loanbill() {
		return pk_loanbill;
	}
	public void setPk_loanbill(int pk_loanbill) {
		this.pk_loanbill = pk_loanbill;
	}
	public String getVbillno() {
		return vbillno;
	}
	public void setVbillno(String vbillno) {
		this.vbillno = vbillno;
	}
	public String getBilldate() {
		return billdate;
	}
	public void setBilldate(String billdate) {
		this.billdate = billdate;
	}
	public BigDecimal getLzje() {
		return lzje;
	}
	public void setLzje(BigDecimal lzje) {
		this.lzje = lzje;
	}
	public String getDigest() {
		return digest;
	}
	public void setDigest(String digest) {
		this.digest = digest;
	}
	public int getDr() {
		return dr;
	}
	public void setDr(int dr) {
		this.dr = dr;
	}
	public String getPbillstatus() {
		return pbillstatus;
	}
	public void setPbillstatus(String pbillstatus) {
		this.pbillstatus = pbillstatus;
	}
	public String getBilltypecode() {
		return billtypecode;
	}
	public void setBilltypecode(String billtypecode) {
		this.billtypecode = billtypecode;
	}
	public int getPk_psn() {
		return pk_psn;
	}
	public void setPk_psn(int pk_psn) {
		this.pk_psn = pk_psn;
	}
	public int getDeptid() {
		return deptid;
	}
	public void setDeptid(int deptid) {
		this.deptid = deptid;
	}
	public String getBilltypename() {
		return billtypename;
	}
	public void setBilltypename(String billtypename) {
		this.billtypename = billtypename;
	}
	public String getPsnname() {
		return psnname;
	}
	public void setPsnname(String psnname) {
		this.psnname = psnname;
	}
	public String getPbillstatusname() {
		return pbillstatusname;
	}
	public void setPbillstatusname(String pbillstatusname) {
		this.pbillstatusname = pbillstatusname;
	}
	
	
}
