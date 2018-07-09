package com.erp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.erp.bean.Pubmessage;
import com.erp.dao.PubmessageMapper;
import com.erp.service.PubmessageService;
@Service
public class PubmessageServiceImpl implements PubmessageService {

	@Autowired
	private PubmessageMapper pubmessageMapper;
	public List<Pubmessage> getpubmessage() {
		return pubmessageMapper.getpubmessage();
	}
	public Pubmessage getMessagebyid(int pk_messageinfo) {
		return pubmessageMapper.getMessagebyid(pk_messageinfo);
	}
	public List<Pubmessage> getallmessage() {
		return pubmessageMapper.getallmessage();
	}
	public void insertMessage(Pubmessage msg) {
		pubmessageMapper.insertMessage(msg);
	}

}
