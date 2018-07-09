package com.erp.bean;

import java.math.BigDecimal;

public class Borrowitem {
	private int pk_borrow;
	private String billno;
	private int pk_loanbill;
	private BigDecimal jkje;
	private BigDecimal ycxje;
	private BigDecimal wcxje;
	private BigDecimal ybje;
	private String digest;
	private int dr;
	public int getPk_borrow() {
		return pk_borrow;
	}
	public void setPk_borrow(int pk_borrow) {
		this.pk_borrow = pk_borrow;
	}
	public BigDecimal getJkje() {
		return jkje;
	}
	public void setJkje(BigDecimal jkje) {
		this.jkje = jkje;
	}
	public BigDecimal getYcxje() {
		return ycxje;
	}
	public void setYcxje(BigDecimal ycxje) {
		this.ycxje = ycxje;
	}
	public BigDecimal getWcxje() {
		return wcxje;
	}
	public void setWcxje(BigDecimal wcxje) {
		this.wcxje = wcxje;
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
	public int getDr() {
		return dr;
	}
	public void setDr(int dr) {
		this.dr = dr;
	}
	public String getBillno() {
		return billno;
	}
	public void setBillno(String billno) {
		this.billno = billno;
	}
	public int getPk_loanbill() {
		return pk_loanbill;
	}
	public void setPk_loanbill(int pk_loanbill) {
		this.pk_loanbill = pk_loanbill;
	}
	
	
}
