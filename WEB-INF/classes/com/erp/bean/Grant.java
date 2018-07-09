package com.erp.bean;

public class Grant {
	private int pk_grant;
	private String billtypecode;
	private String datefrom;
	private String dateto;
	private int pk_psn;
	private int pk_grantpsn;
	private int dr;
	private String ts;
	private int psndept;
	private int grantpsndept;
	private String psnname;
	private String grantpsnname;
	private String psndeptname;
	private String grantdeptname;
	private String billtypename;
	
	public String getPsnname() {
		return psnname;
	}
	public void setPsnname(String psnname) {
		this.psnname = psnname;
	}
	public String getGrantpsnname() {
		return grantpsnname;
	}
	public void setGrantpsnname(String grantpsnname) {
		this.grantpsnname = grantpsnname;
	}
	public String getPsndeptname() {
		return psndeptname;
	}
	public void setPsndeptname(String psndeptname) {
		this.psndeptname = psndeptname;
	}
	public String getGrantdeptname() {
		return grantdeptname;
	}
	public void setGrantdeptname(String grantdeptname) {
		this.grantdeptname = grantdeptname;
	}
	public String getBilltypename() {
		return billtypename;
	}
	public void setBilltypename(String billtypename) {
		this.billtypename = billtypename;
	}
	public int getPk_grant() {
		return pk_grant;
	}
	public void setPk_grant(int pk_grant) {
		this.pk_grant = pk_grant;
	}
	public String getBilltypecode() {
		return billtypecode;
	}
	public void setBilltypecode(String billtypecode) {
		this.billtypecode = billtypecode;
	}
	public String getDatefrom() {
		return datefrom;
	}
	public void setDatefrom(String datefrom) {
		this.datefrom = datefrom;
	}
	public String getDateto() {
		return dateto;
	}
	public void setDateto(String dateto) {
		this.dateto = dateto;
	}
	public int getPk_psn() {
		return pk_psn;
	}
	public void setPk_psn(int pk_psn) {
		this.pk_psn = pk_psn;
	}
	public int getPk_grantpsn() {
		return pk_grantpsn;
	}
	public void setPk_grantpsn(int pk_grantpsn) {
		this.pk_grantpsn = pk_grantpsn;
	}
	public int getDr() {
		return dr;
	}
	public void setDr(int dr) {
		this.dr = dr;
	}
	public String getTs() {
		return ts;
	}
	public void setTs(String ts) {
		this.ts = ts;
	}
	public int getPsndept() {
		return psndept;
	}
	public void setPsndept(int psndept) {
		this.psndept = psndept;
	}
	public int getGrantpsndept() {
		return grantpsndept;
	}
	public void setGrantpsndept(int grantpsndept) {
		this.grantpsndept = grantpsndept;
	}
	
	
}
