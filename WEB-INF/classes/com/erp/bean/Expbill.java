package com.erp.bean;

import java.math.BigDecimal;

public class Expbill {
	private int billid;
	private String vbillno;
	private String billtypecode;
	private String billdate;
	private String digest;
	private BigDecimal lzje;
	private int voperatorid;
	private String vbillstatus;
	private String pbillstatus;
	private int deptid;
	private int dr;
	
	public int getDeptid() {
		return deptid;
	}
	public void setDeptid(int deptid) {
		this.deptid = deptid;
	}
	public int getDr() {
		return dr;
	}
	public void setDr(int dr) {
		this.dr = dr;
	}
	public int getBillid() {
		return billid;
	}
	public void setBillid(int billid) {
		this.billid = billid;
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
	public String getDigest() {
		return digest;
	}
	public void setDigest(String digest) {
		this.digest = digest;
	}
	public BigDecimal getLzje() {
		return lzje;
	}
	public void setLzje(BigDecimal lzje) {
		this.lzje = lzje;
	}
	public String getVbillstatus() {
		return vbillstatus;
	}
	public void setVbillstatus(String vbillstatus) {
		this.vbillstatus = vbillstatus;
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
	public int getVoperatorid() {
		return voperatorid;
	}
	public void setVoperatorid(int voperatorid) {
		this.voperatorid = voperatorid;
	}
	

}
