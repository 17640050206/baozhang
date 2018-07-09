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

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erp.bean.Billtype;
import com.erp.bean.Job;
import com.erp.bean.Loanbill;
import com.erp.bean.User;
import com.erp.service.UserService;

@Controller
@RequestMapping(value = "/user")
public class UserController {
	private org.slf4j.Logger logger =LoggerFactory.getLogger(BillstatusController.class); 
	@Autowired
	private UserService userService;
	
	
	@RequestMapping("/rmLoginAction.do")
	public String rmLoginAction(User user,HttpSession session){
		session.removeAttribute("loginUser");
		session.removeAttribute("user_role");
		session.removeAttribute("default_role");
		return "index";
	}
	@ResponseBody
	@RequestMapping("/login.do")
	public Object login(User user,HttpSession session){
		logger.debug("------------------------------------------");
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			User cust= userService.login(user);
			if(cust!=null){
				User cust1 = userService.getUserById(cust.getUserid());
				session.setAttribute("loginUser", cust1);
				session.setAttribute("user_role", cust.getUser_role());
				session.setAttribute("default_role", cust.getDefault_role()==null||"".equals(cust.getDefault_role())?cust.getUser_role().substring(0, 1):cust.getDefault_role());
				cust.setDefault_role(session.getAttribute("default_role").toString());
				map.put("state", "true");
				map.put("user", cust);
			}else{
				map.put("state", "false");
				map.put("error", "用户名或密码错误");
			}
		} catch (Exception e) {
			System.err.println(e.getMessage());
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	@ResponseBody
	@RequestMapping("/updatepassword.do")
	public Object updatepassword(HttpServletRequest request,HttpSession session){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			
				User user = (User) session.getAttribute("loginUser");
				String pass = user.getPassword().trim();
				String old_passeword = request.getParameter("old_password").trim();
				String new_password = request.getParameter("new_password").trim();
				String confirm_password = request.getParameter("confirm_password").trim();
				if(!pass.equals(old_passeword)){
					map.put("state", "false");
					map.put("error", "原密码输入错误");
				}
				else{
					user.setPassword(new_password);
					userService.updatepassword(user);
					map.put("state", "true");
					map.put("msg", "修改成功！");
				}
		} catch (Exception e) {
			System.err.println(e.getMessage());
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	@ResponseBody
	@RequestMapping("/billtype.do")
	public Object billtype(HttpSession session){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			User user = (User) session.getAttribute("loginUser");
			List<Job> job= userService.getBilltype(user);
			List<String> jobs = new ArrayList<String>();
			if(job!=null){
				for(Job j:job){
					String bill = j.getBilltypebz();
					String[] bills = bill.split(",");
					for(int i=0;i<bills.length;i++){
						if(!jobs.contains(bills[i])){
							jobs.add(bills[i]);
						}
					}
				}
				map.put("state", "true");
				map.put("bills", jobs);
			}else{
				map.put("state", "false");
				map.put("error", "该用户没有报账单权限");
			}
		} catch (Exception e) {
			System.err.println(e.getMessage());
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	
	
	@ResponseBody
	@RequestMapping("/changeDefRole.do")
	public Object changeDefRole(HttpServletRequest request,HttpSession session){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
				String role = request.getParameter("role").trim();
				User user = (User) session.getAttribute("loginUser");
				user.setDefault_role(role);
				userService.updateDefaultrole(user);
				session.removeAttribute("default_role");
				session.setAttribute("default_role", user.getDefault_role());
				map.put("state", "true");
				map.put("msg", "默认门户设置成功！");
		} catch (Exception e) {
			System.err.println(e.getMessage());
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	public User getUserById(int userid){
		return userService.getUserById(userid);
	}
	
	@ResponseBody
	@RequestMapping("/getPeopleList.do")
	public Object getPeopleList(HttpServletRequest request,HttpSession session){
		Map<String,Object> map = new HashMap<String,Object>();
		User user = (User) session.getAttribute("loginUser");
		List<Job> joblst= userService.getBilltype(user);
		String deptid = request.getParameter("deptid").trim();
		Job job = joblst.get(0);
		int level = job.getLevel();
		User u = new User();
		u.setLevel(level);
		u.setDeptid(Integer.parseInt(deptid));
		try {
			
			List<User> list = new ArrayList<User>();
			list = userService.getUserBydeptId(u);
				map.put("state", "true");
				map.put("peoplelist", list);
      } catch (Exception e) {
			System.err.println(e.getMessage());
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
		
}
