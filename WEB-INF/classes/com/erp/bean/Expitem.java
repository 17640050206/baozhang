package com.erp.bean;

public class Expitem {
	private int pk_expitem;
	private int pk_loanbill;
	private String area;
	private int daynum;
	private int hotelcost;
	private int transcost;
	private int othercost;
	private int sum;
	private String digest;
	private int dr;
	private String datefrom;
	
	public String getDatefrom() {
		return datefrom;
	}
	public void setDatefrom(String datefrom) {
		this.datefrom = datefrom;
	}
	public int getPk_expitem() {
		return pk_expitem;
	}
	public void setPk_expitem(int pk_expitem) {
		this.pk_expitem = pk_expitem;
	}
	public int getPk_loanbill() {
		return pk_loanbill;
	}
	public void setPk_loanbill(int pk_loanbill) {
		this.pk_loanbill = pk_loanbill;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public int getDaynum() {
		return daynum;
	}
	public void setDaynum(int daynum) {
		this.daynum = daynum;
	}
	public int getHotelcost() {
		return hotelcost;
	}
	public void setHotelcost(int hotelcost) {
		this.hotelcost = hotelcost;
	}
	public int getTranscost() {
		return transcost;
	}
	public void setTranscost(int transcost) {
		this.transcost = transcost;
	}
	public int getOthercost() {
		return othercost;
	}
	public void setOthercost(int othercost) {
		this.othercost = othercost;
	}
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
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
	
}
