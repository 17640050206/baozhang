package com.erp.bean;

public class Pubmessage {
	private int pk_messageinfo;
	private String title;
	private String context;
	private int pk_psn;
	private String senddate;
	private int deptid;
	private String deptname;
	private String psnname;
	private String ts;
	
	public String getTs() {
		return ts;
	}
	public void setTs(String ts) {
		this.ts = ts;
	}
	public String getDeptname() {
		return deptname;
	}
	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}
	public String getPsnname() {
		return psnname;
	}
	public void setPsnname(String psnname) {
		this.psnname = psnname;
	}
	public int getPk_messageinfo() {
		return pk_messageinfo;
	}
	public void setPk_messageinfo(int pk_messageinfo) {
		this.pk_messageinfo = pk_messageinfo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public int getPk_psn() {
		return pk_psn;
	}
	public void setPk_psn(int pk_psn) {
		this.pk_psn = pk_psn;
	}
	public String getSenddate() {
		return senddate;
	}
	public void setSenddate(String senddate) {
		this.senddate = senddate;
	}
	public int getDeptid() {
		return deptid;
	}
	public void setDeptid(int deptid) {
		this.deptid = deptid;
	}

}
