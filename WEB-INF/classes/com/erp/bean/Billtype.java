package com.erp.bean;

public class Billtype {
	private int pk_billtype;
	private String billtypename;
	private String billtypecode;
	public String getBilltypename() {
		return billtypename;
	}
	public void setBilltypename(String billtypename) {
		this.billtypename = billtypename;
	}
	public String getBilltypecode() {
		return billtypecode;
	}
	public void setBilltypecode(String billtypecode) {
		this.billtypecode = billtypecode;
	}
	public int getPk_billtype() {
		return pk_billtype;
	}
	public void setPk_billtype(int pk_billtype) {
		this.pk_billtype = pk_billtype;
	}
	

}
