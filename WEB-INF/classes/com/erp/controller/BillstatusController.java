package com.erp.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erp.bean.Billtype;
import com.erp.bean.Job;
import com.erp.bean.Loanbill;
import com.erp.bean.Pbillstatus;
import com.erp.bean.User;
import com.erp.service.BillstatusService;
import com.erp.service.BilltypeService;
import com.erp.service.UserService;


@Controller
@RequestMapping(value = "/billstatus")
public class BillstatusController {
	private org.slf4j.Logger logger =LoggerFactory.getLogger(BillstatusController.class); 
	@Autowired
	private BillstatusService billstatusService;
	public Pbillstatus getBillstatusbycode(String billstatuscode){
		logger.debug("-------------------------");
		Pbillstatus vo = billstatusService.getBillstatusbycode(billstatuscode);
		return vo;
	}
		
}
