package com.erp.bean;

public class Vendor {
	private int pk_cubs;
	private String vendorname;
	private int pk_project;
	private String bank;
	private String account;
	private String vendorcode;
	
	public String getVendorcode() {
		return vendorcode;
	}
	public void setVendorcode(String vendorcode) {
		this.vendorcode = vendorcode;
	}
	public int getPk_cubs() {
		return pk_cubs;
	}
	public void setPk_cubs(int pk_cubs) {
		this.pk_cubs = pk_cubs;
	}
	public String getVendorname() {
		return vendorname;
	}
	public void setVendorname(String vendorname) {
		this.vendorname = vendorname;
	}
	public int getPk_project() {
		return pk_project;
	}
	public void setPk_project(int pk_project) {
		this.pk_project = pk_project;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	

}
