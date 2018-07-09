package com.erp.bean;

import java.math.BigDecimal;

public class Cashbill {
	private int pk_cashbill;
	private int pk_loanbill;
	private String billno;
	private String account;
	private BigDecimal ybje;
	private String digest;
	private BigDecimal jkje;
	private BigDecimal yhje;
	private BigDecimal whje;
	private int deptid;
	private int dr;
	
	
	public int getDr() {
		return dr;
	}
	public void setDr(int dr) {
		this.dr = dr;
	}
	public int getDeptid() {
		return deptid;
	}
	public void setDeptid(int deptid) {
		this.deptid = deptid;
	}
	public BigDecimal getWhje() {
		return whje;
	}
	public void setWhje(BigDecimal whje) {
		this.whje = whje;
	}
	public BigDecimal getJkje() {
		return jkje;
	}
	public void setJkje(BigDecimal jkje) {
		this.jkje = jkje;
	}
	public BigDecimal getYhje() {
		return yhje;
	}
	public void setYhje(BigDecimal yhje) {
		this.yhje = yhje;
	}
	public int getPk_cashbill() {
		return pk_cashbill;
	}
	public void setPk_cashbill(int pk_cashbill) {
		this.pk_cashbill = pk_cashbill;
	}
	public int getPk_loanbill() {
		return pk_loanbill;
	}
	public void setPk_loanbill(int pk_loanbill) {
		this.pk_loanbill = pk_loanbill;
	}
	public String getBillno() {
		return billno;
	}
	public void setBillno(String billno) {
		this.billno = billno;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public BigDecimal getYbje() {
		return ybje;
	}
	public void setYbje(BigDecimal ybje) {
		this.ybje = ybje;
	}
	public String getDigest() {
		return digest;
	}
	public void setDigest(String digest) {
		this.digest = digest;
	}
	

}
