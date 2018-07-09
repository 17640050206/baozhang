package com.erp.service;

import java.util.List;

import com.erp.bean.Pubmessage;

public interface PubmessageService {

	List<Pubmessage> getpubmessage();

	Pubmessage getMessagebyid( int pk_messageinfo);

	List<Pubmessage> getallmessage();

	void insertMessage(Pubmessage msg);

}
