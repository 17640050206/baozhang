package com.erp.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erp.bean.Pubmessage;
import com.erp.bean.User;
import com.erp.service.PubmessageService;
import com.erp.service.UserService;

@Controller
@RequestMapping(value = "/pubmessage")
public class PubmessageController {
	
	@Autowired
	private PubmessageService pubmessageService;
	@Autowired
	private UserService  userService;
	
	@ResponseBody
	@RequestMapping("/getpubmessage.do")
	public Object getpubmessage(){
		 Map<String,Object> map = new HashMap<String,Object>();
		try {
			List<Pubmessage> msgList= pubmessageService.getpubmessage();
			if(msgList!=null&&msgList.size()>0){
				map.put("state", "true");
				map.put("msgList", msgList);
			}else{
				map.put("state", "false");
				map.put("error", "暂无公告");
			}
		} catch (Exception e) {
			System.err.println(e.getMessage());
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/getMessagebyid.do")
	public Object getMessagebyid(HttpServletRequest request){
		 Map<String,Object> map = new HashMap<String,Object>();
		try {
			int pk_messageinfo = Integer.parseInt(request.getParameter("pk").trim());
			Pubmessage msg= pubmessageService.getMessagebyid(pk_messageinfo);
			User user = userService.getUserById(msg.getPk_psn());
			msg.setPsnname(user.getUser_name());
			msg.setDeptname(user.getDeptname());
			if(msg!=null){
				map.put("state", "true");
				map.put("msg", msg);
			}
		} catch (Exception e) {
			System.err.println(e.getMessage());
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	
	
	@RequestMapping("/getallmessage.do")
	public String getallmessage(Model model,HttpServletRequest request){
		List<Pubmessage> msg= pubmessageService.getallmessage();
		model.addAttribute("beans", msg); 
		return "message_xxgl";
	}
	@RequestMapping("/getallmessage1.do")
	public String getallmessage1(Model model,HttpServletRequest request){
		List<Pubmessage> msg= pubmessageService.getallmessage();
		model.addAttribute("beans", msg); 
		return "message_xxgl1";
	}
	
	
	
	@ResponseBody
	@RequestMapping("/insertMessage.do")
	public Object insertMessage(HttpServletRequest request,HttpSession session){
		 Map<String,Object> map = new HashMap<String,Object>();
		try {
			User user = (User) session.getAttribute("loginUser");
			int pk_psn= user.getUserid();
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String senddate = format.format(new Date());
			int deptid= user.getDeptid();
			String title = new String(new String(request.getParameter("title").trim().getBytes("ISO-8859-1"),"utf-8"));
			String content = new String(new String(request.getParameter("content").trim().getBytes("ISO-8859-1"),"utf-8"));
			Pubmessage msg = new Pubmessage();
			msg.setTitle(title);
			msg.setPk_psn(pk_psn);
			msg.setDeptid(deptid);
			msg.setSenddate(senddate);
			msg.setContext(content);
			SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String ts = format1.format(new Date());
			msg.setTs(ts);
			pubmessageService.insertMessage(msg);
			map.put("state", "true");
		} catch (Exception e) {
			System.err.println(e.getMessage());
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	
		
}
