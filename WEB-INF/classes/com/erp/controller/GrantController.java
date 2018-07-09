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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erp.bean.Billtype;
import com.erp.bean.Grant;
import com.erp.bean.Job;
import com.erp.bean.Loanbill;
import com.erp.bean.Pbillstatus;
import com.erp.bean.User;
import com.erp.service.BillstatusService;
import com.erp.service.BilltypeService;
import com.erp.service.GrantService;
import com.erp.service.UserService;

@Controller
@RequestMapping(value = "/grant")
public class GrantController {
	@Autowired
	private GrantService grantService;
	@Autowired
	private UserService userService;
	@Autowired
	private BilltypeService billtypeService;
	@ResponseBody
	@RequestMapping("/getGrantList.do")
	public Object getGrantList(HttpSession session){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			User user = (User) session.getAttribute("loginUser");
			List<Grant> grant= grantService.getGrantList(user);
			if(grant!=null&&grant.size()>0){
				for(Grant vo:grant){
					User grantpsn = userService.getUserById(vo.getPk_grantpsn());
					String grantpsnname = grantpsn.getUser_name();
					String grantdept = grantpsn.getDeptname();
					String billtype = vo.getBilltypecode();
					Billtype billtype1 = billtypeService.getBilltypebycode(billtype);
					vo.setBilltypename(billtype1.getBilltypename());
					vo.setGrantdeptname(grantdept);
					vo.setPsndeptname(user.getDeptname());
					vo.setPsnname(user.getUser_name());
					vo.setGrantpsnname(grantpsnname);
				}
				map.put("state", "true");
				map.put("grantlist", grant);
			}else{
				map.put("state", "false");
				map.put("error", "无授权信息");
			}
		} catch (Exception e) {
			System.err.println(e.getMessage());
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	
	
	@ResponseBody
	@RequestMapping("/deleteGrant.do")
	public Object deleteGrant(HttpServletRequest request){
		Map<String,Object> map = new HashMap<String,Object>();
		try{
			String pks = request.getParameter("pk_grant").trim();
			String[] pk = pks.split(",");
			for(int i=0;i<pk.length;i++){
				grantService.deleteGrant(Integer.parseInt(pk[i]));
			}
			map.put("state", "true");
			map.put("msg", "删除成功");
		} catch (Exception e) {
			System.err.println(e.getMessage());
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/getBilltypeList.do")
	public Object getBilltypeList(HttpSession session){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			List<Billtype> list = new ArrayList<Billtype>();
			User user = (User) session.getAttribute("loginUser");
			List<Job> job= userService.getBilltype(user);
			if(job.size()>0){
				String types = job.get(0).getBilltype();
				String[] billtypes = types.split(",");
				for(int i=0;i<billtypes.length;i++){
					String type = billtypes[i];
					Billtype vo = billtypeService.getBilltypebycode(type);
					list.add(vo);
				}
				map.put("state", "true");
				map.put("typelist", list);
			}else{
				map.put("state", "false");
				map.put("error", "无授权信息");
			}
		} catch (Exception e) {
			System.err.println(e.getMessage());
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	
	
	
	@ResponseBody
	@RequestMapping("/insertGrant.do")
	public Object insertGrant(HttpSession session,HttpServletRequest request){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			User user = (User) session.getAttribute("loginUser");
			Grant grant = new Grant();
			String billtypecode = request.getParameter("billtype").trim();
	        String datefrom = request.getParameter("startdate").trim();
	        String dateto = request.getParameter("enddate").trim();
	        int pk_grantpsn = Integer.parseInt(request.getParameter("grantedman").trim());
	        int pk_psn = user.getUserid();
	        int psndept = user.getDeptid();
	        int grantpsndept = Integer.parseInt(request.getParameter("granddept").trim());
	        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        String ts = format.format(new Date());
	        grant.setBilltypecode(billtypecode);
	        grant.setDatefrom(datefrom);
	        grant.setDateto(dateto);
	        grant.setPk_psn(pk_psn);
	        grant.setPk_grantpsn(pk_grantpsn);
	        grant.setGrantpsndept(grantpsndept);
	        grant.setPsndept(psndept);
	        grant.setTs(ts);
	        grant.setDr(0);
	        User u = userService.getUserById(pk_grantpsn);
	        List<Job> job = userService.getBilltype(u);
	        String typemine = job.get(0).getBilltype();
	        List<Grant> grants = grantService.getGrantsByGrantedPsn(pk_grantpsn);
	        for(Grant g:grants){
	        	typemine+=","+g.getBilltypecode();
	        }
	        String[] codes = typemine.split(",");
	        for(int i=0;i<codes.length;i++){
	        	if(billtypecode.equals(codes[i])){
	        		map.put("state", "false");
					map.put("error", "该用户已经拥有对应单据权限！");
					return map;
	        	}
	        }
	        List<Grant> list = grantService.check(grant);
	        if(list.size()>0){
	        	map.put("state", "false");
				map.put("error", "相同时间段内同一类型单据不可重复授权！");
	        }else{
	        	grantService.insertGrant(grant);
	        	map.put("state", "true");
				map.put("message", "授权成功！");
	        }
		} catch (Exception e) {
			System.err.println(e.getMessage());
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
		
}
