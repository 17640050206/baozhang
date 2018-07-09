package com.erp.bean;

public class Job {
	private String jobcode;
	private String billtypebz;
	private String billtype;
	private int jobid;
	private String user_role;
	private String job_name;
	private int level;
	
	public String getBilltypebz() {
		return billtypebz;
	}
	public void setBilltypebz(String billtypebz) {
		this.billtypebz = billtypebz;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getJobcode() {
		return jobcode;
	}
	public void setJobcode(String jobcode) {
		this.jobcode = jobcode;
	}
	public String getBilltype() {
		return billtype;
	}
	public void setBilltype(String billtype) {
		this.billtype = billtype;
	}
	public int getJobid() {
		return jobid;
	}
	public void setJobid(int jobid) {
		this.jobid = jobid;
	}
	public String getUser_role() {
		return user_role;
	}
	public void setUser_role(String user_role) {
		this.user_role = user_role;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}

}
