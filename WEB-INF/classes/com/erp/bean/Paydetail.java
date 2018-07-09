package com.erp.bean;

public class Paydetail {
	private int pk_paydetail;
	private String vendorcode;
	private String vendorname;
	private String digest;
	private String fkje;
	private int dr;
	private int pk_loanbill;
	private String bankname;
	private String account;
	private String bank;
	
	
	
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getVendorcode() {
		return vendorcode;
	}
	public void setVendorcode(String vendorcode) {
		this.vendorcode = vendorcode;
	}
	public String getVendorname() {
		return vendorname;
	}
	public void setVendorname(String vendorname) {
		this.vendorname = vendorname;
	}
	public String getBankname() {
		return bankname;
	}
	public void setBankname(String bankname) {
		this.bankname = bankname;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public int getPk_loanbill() {
		return pk_loanbill;
	}
	public void setPk_loanbill(int pk_loanbill) {
		this.pk_loanbill = pk_loanbill;
	}
	public int getPk_paydetail() {
		return pk_paydetail;
	}
	public void setPk_paydetail(int pk_paydetail) {
		this.pk_paydetail = pk_paydetail;
	}
	public String getDigest() {
		return digest;
	}
	public void setDigest(String digest) {
		this.digest = digest;
	}
	public String getFkje() {
		return fkje;
	}
	public void setFkje(String fkje) {
		this.fkje = fkje;
	}
	public int getDr() {
		return dr;
	}
	public void setDr(int dr) {
		this.dr = dr;
	}
	

}
