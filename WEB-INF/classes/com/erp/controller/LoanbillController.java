package com.erp.controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.erp.bean.Borrowitem;
import com.erp.bean.Cashbill;
import com.erp.bean.Expitem;
import com.erp.bean.Job;
import com.erp.bean.Loanbill;
import com.erp.bean.Paydetail;
import com.erp.bean.Pbillstatus;
import com.erp.bean.Project;
import com.erp.bean.User;
import com.erp.bean.Vendor;
import com.erp.bean.Workflow;
import com.erp.service.BillstatusService;
import com.erp.service.BilltypeService;
import com.erp.service.LoanbillService;
import com.erp.service.UserService;
import com.erp.service.WorkflowService;

@Controller
@RequestMapping(value = "/loanbill")
public class LoanbillController {
	
	@Autowired
	private LoanbillService loanbillService;
	@Autowired
	private BilltypeService billtypeService;
	@Autowired
	private BillstatusService billstatusService;
	@Autowired
	private WorkflowService workflowService;
	@Autowired
	private UserService userService;
	public static Map<String,Loanbill> bufferBill = new HashMap<String,Loanbill>();
	/**
	 * 转到已申请单据页面
	 */
	@RequestMapping(
			value = "/toSavedBillPage.do")
	public String toSavedBillPage(Model model, HttpServletRequest request,HttpSession session) {
		User user = (User)session.getAttribute("loginUser");
		int user_id = user.getUserid();
		Map<String, Object> searchPara = new HashMap<String, Object>();
		String currentPage = request.getParameter("currentPage")==null||"".equals(request.getParameter("currentPage"))?"1":request.getParameter("currentPage").trim();
		String year = request.getParameter("year")==null||"".equals(request.getParameter("year"))?null:request.getParameter("year").trim();
		String month = request.getParameter("month")==null||"".equals(request.getParameter("month"))?null:request.getParameter("month").trim();
		String pbillstatus = request.getParameter("pbillstatus")==null||"".equals(request.getParameter("pbillstatus"))||"1".equals(request.getParameter("pbillstatus"))?null:request.getParameter("pbillstatus").trim();
		String billno = request.getParameter("billno")==null||"".equals(request.getParameter("billno"))?null:request.getParameter("billno").trim();
		int pageSize = 15;
		searchPara.put("userid", user_id);
		searchPara.put("year", year);
		searchPara.put("month", month);
		searchPara.put("billno", billno);
		searchPara.put("pageSize", pageSize);
		int current = Integer.parseInt(currentPage);
		if(current<1){
			current=1;
		}
		
		if(!"1".equals(pbillstatus)){
			searchPara.put("pbillstatus", pbillstatus);
		}
		int count = loanbillService.getCount(searchPara);
		int totalPage = count%pageSize==0?count/pageSize:count/pageSize+1;
		if(current>totalPage&&totalPage!=0){
			current=totalPage;
		}
		searchPara.put("indexPage", (current-1)*pageSize);
		
		List<Loanbill> beans = loanbillService.searchBill(searchPara); // 按条件查询全部,带排序
		for(Loanbill vo:beans){
			String billtypename = billtypeService.getBilltypebycode(vo.getBilltypecode()).getBilltypename();
			String pbillstatusname = billstatusService.getBillstatusbycode(vo.getPbillstatus()).getPbillstatusname();
			vo.setBilltypename(billtypename);
			vo.setPbillstatusname(pbillstatusname);
			vo.setPsnname(user.getUser_name());
		}
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("currentPage",totalPage==0?0:Integer.parseInt(currentPage)<1?1:Integer.parseInt(currentPage)>totalPage?totalPage:Integer.parseInt(currentPage));
		model.addAttribute("beans", beans); // 把结果集放入request
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		if(pbillstatus!=null){
			model.addAttribute("pbillstatus",pbillstatus);
		}
		return "listCmerSavedBills";
	}
	@RequestMapping(
			value = "/savedBillPageExap.do")
	@ResponseBody
	public Object savedBillPageExap(Model model, HttpServletRequest request,HttpSession session) {
		User user = (User)session.getAttribute("loginUser");
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			int user_id = user.getUserid();
			Map<String, Object> searchPara = new HashMap<String, Object>();
			String statetype  = request.getParameter("statetype").trim();
			String pbillstatus="";
			if("dcl".equals(statetype)){
				pbillstatus = "'2'";
			}else if("spz".equals(statetype)){
				pbillstatus = "'4','3'";
			}
			searchPara.put("userid", user_id);
			searchPara.put("pbillstatus", pbillstatus);
			List<Loanbill> beans = loanbillService.searchBillExap(searchPara); // 按条件查询全部,带排序
			if(beans.size()>0){
				map.put("state", "true");
				map.put("beans", beans);
			}else{
				map.put("state", "false");
				if("dcl".equals(statetype)){
					map.put("error", "目前无待处理的保存态单据");
				}else if("spz".equals(statetype)){
					map.put("error", "目前无审批中的单据");
				}
				
			}
		} catch (Exception e) {
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	private Loanbill getLoanbillById(int billid){
		return loanbillService.getLoanbillById(billid);
	}
	
	@RequestMapping(
			value = "/addBill.do")
	public String addBill(Model model, HttpServletRequest request,HttpSession session) {
		Loanbill loanbillVo = new Loanbill();;
		String billtype = request.getParameter("pk_billtype");
		User user = (User)session.getAttribute("loginUser");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String billdate   = format.format(new Date());
		loanbillVo.setBilldate(billdate);
		loanbillVo.setBilltypecode(billtype);
		loanbillVo.setDeptid(user.getDeptid());
		loanbillVo.setDeptname(user.getDeptname());
		String year = billdate.substring(0,4);
		String month= billdate.substring(5,7);
		loanbillVo.setYear(year);
		loanbillVo.setMonth(month);
		loanbillVo.setPbillstatus("1");
		Pbillstatus pbillstatusname = billstatusService.getBillstatusbycode("1");
		loanbillVo.setPbillstatusname(pbillstatusname.getPbillstatusname());
		loanbillVo.setPk_psn(user.getUserid());
		loanbillVo.setPsnname(user.getUser_name());
		loanbillVo.setBilltypecode(billtype);
		loanbillVo.setEmail(user.getEmail());
		loanbillVo.setMobile(user.getMobile());
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateS = f.format(new Date());
		String s =  dateS.substring(8, 10);
		String s1 = dateS.substring(11, 13);
		String s2 = dateS.substring(14, 16);
		String s3 = dateS.substring(17, 19);
			String vbillno = billtype+year+month+s+s1+s2+s3;
			loanbillVo.setVbillno(vbillno);
		model.addAttribute("bean", loanbillVo);
		

		return billtype+"/insertBill"+billtype;
	}
	
	
	@RequestMapping(
			value = "/saveJK.do")
	public String saveJK(Model model,Loanbill vo, HttpServletRequest request,HttpSession session) {
		 if(bufferBill.get(vo.getVbillno())==null){
		vo.setDr(0);
		vo.setBilltypecode("JK");
		vo.setPbillstatus("2");
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateS = f.format(new Date());
		vo.setTs(dateS);
		loanbillService.insert(vo);
		int pk_loanbill = loanbillService.getPKbybillno(vo.getVbillno());
		vo.setPk_loanbill(pk_loanbill);
		Pbillstatus pbillstatusname = billstatusService.getBillstatusbycode("2");
		vo.setPbillstatusname(pbillstatusname.getPbillstatusname());
		bufferBill.put(vo.getVbillno(), vo);
		 }else{
			 vo = bufferBill.get(vo.getVbillno());
		 }
		model.addAttribute("bean", vo);
		model.addAttribute("action", "detail");
		return "JK/insertBillJK";
	}
		
	
	@RequestMapping(
			value = "/saveZJXB.do")
	public String saveZJXB(Model model,Loanbill vo, HttpServletRequest request,HttpSession session) {
		 if(bufferBill.get(vo.getVbillno())==null){
		vo.setDr(0);
		vo.setBilltypecode("ZJXB");
		vo.setPbillstatus("2");
		loanbillService.insert(vo);
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateS = f.format(new Date());
		vo.setTs(dateS);
		int pk_loanbill = loanbillService.getPKbybillno(vo.getVbillno());
		vo.setPk_loanbill(pk_loanbill);
		Pbillstatus pbillstatusname = billstatusService.getBillstatusbycode("2");
		vo.setPbillstatusname(pbillstatusname.getPbillstatusname());
		bufferBill.put(vo.getVbillno(), vo);
		 }else{
			 vo = bufferBill.get(vo.getVbillno());
		 }
		model.addAttribute("bean", vo);
		model.addAttribute("action", "detail");
		return "ZJXB/insertBillZJXB";
	}
	@RequestMapping(
			value = "/saveRCBZ.do")
	@ResponseBody
	public Object saveRCBZ(Model model,@RequestBody Loanbill loanbill, HttpServletRequest request,HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();	
		 try {
			 if(bufferBill.get(loanbill.getVbillno())==null){
			   loanbill.setDr(0);
				loanbill.setBilltypecode("RCBZ");
				loanbill.setPbillstatus("2");
				SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String dateS = f.format(new Date());
				loanbill.setTs(dateS);
				loanbillService.insert(loanbill);
				int pk_loanbill = loanbillService.getPKbybillno(loanbill.getVbillno());
				Pbillstatus pbillstatusname = billstatusService.getBillstatusbycode("2");
				loanbill.setPbillstatusname(pbillstatusname.getPbillstatusname());
				loanbill.setPk_loanbill(pk_loanbill);
				for(Paydetail detail:loanbill.getPaydetails()){
					if(detail!=null){
						detail.setDr(0);
						detail.setPk_loanbill(pk_loanbill);
					}
					loanbillService.insertPaydetail(detail);
				}
				List<Paydetail> list = loanbillService.getPaydetailVos(pk_loanbill);
				loanbill.setPaydetails(list);
				bufferBill.put(loanbill.getVbillno(), loanbill);
			 }else{
				 loanbill = bufferBill.get(loanbill.getVbillno());
			 }
				
				map.put("state", "true");
				map.put("bean", loanbill);
		} catch (Exception e) {
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	@RequestMapping(
			value = "/saveBill.do")
	@ResponseBody
	public Object saveBill(Model model,@RequestBody Loanbill loanbill, HttpServletRequest request,HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();	
		 try {
			 	if(bufferBill.get(loanbill.getVbillno())==null){
			 		loanbill.setDr(0);
				    String billtype=loanbill.getBilltypecode().trim();
					loanbill.setBilltypecode(billtype);
					loanbill.setPbillstatus("2");
					SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String dateS = f.format(new Date());
					loanbill.setTs(dateS);
					loanbillService.insert(loanbill);
					int pk_loanbill = loanbillService.getPKbybillno(loanbill.getVbillno());
					Pbillstatus pbillstatusname = billstatusService.getBillstatusbycode("2");
					loanbill.setPbillstatusname(pbillstatusname.getPbillstatusname());
					loanbill.setPk_loanbill(pk_loanbill);
					if("CL".equals(billtype)){
						for(Expitem item:loanbill.getExpitems()){
							if(item!=null){
								item.setDr(0);
								item.setPk_loanbill(pk_loanbill);
							}
							loanbillService.insertExpitem(item);
						}
						List<Expitem> list = loanbillService.getExpitemVos(pk_loanbill);
						loanbill.setExpitems(list);
					}
					if("JKHK".equals(billtype)){
						for(Borrowitem item:loanbill.getBorrowitems()){
							if(item!=null){
								item.setDr(0);
								item.setPk_loanbill(pk_loanbill);
							}
							loanbillService.insertBorroeitem(item);
							String billno = item.getBillno();
							Borrowitem borrow = loanbillService.getZyjeByBillno(billno);
							item.setYcxje(borrow.getYcxje());
							Loanbill bill = loanbillService.getLoanbillByno(billno);
							item.setWcxje(bill.getLzje().subtract(item.getYcxje()));
						}
						//List<Borrowitem> list = loanbillService.getBorrowitemVos(pk_loanbill);
						//loanbill.setBorrowitems(list);
					}
					if("ZJZF".equals(billtype)){
						for(Cashbill item:loanbill.getCashbills()){
							if(item!=null){
								item.setDr(0);
								item.setPk_loanbill(pk_loanbill);
							}
							loanbillService.insertCashbill(item);
							String billno = item.getBillno();
							Cashbill cashbill = loanbillService.getYhjeByBillno(billno);
							item.setYhje(cashbill.getYhje());
							Loanbill bill = loanbillService.getLoanbillByno(billno);
							item.setWhje(bill.getLzje().subtract(item.getYhje()));
						}
					}
					bufferBill.put(loanbill.getVbillno(), loanbill);
			 	}else{
			 		loanbill = bufferBill.get(loanbill.getVbillno());
			 	}
				
				map.put("state", "true");
				map.put("bean", loanbill);
		} catch (Exception e) {
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	@RequestMapping(
			value = "/getXmmc.do")
	@ResponseBody
	public Object getXmmc(HttpServletRequest request,HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();	
		 try {
			 String xmbm = request.getParameter("xmbm").trim();
			 Project xmmc = loanbillService.getProjectByBm(xmbm);
				if(xmmc!=null){
					map.put("state", "true");
					map.put("xmmc", xmmc);
				}else{
					map.put("state", "false");
					map.put("error", "无此项目");
				}
			
		} catch (Exception e) {
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	
	@RequestMapping(
			value = "/getVendor.do")
	@ResponseBody
	public Object getVendor(HttpServletRequest request,HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();	
		 try {
			 String vendorcode = request.getParameter("vendorcode").trim();
			 String pk_project = request.getParameter("pk_project").trim();
			 Vendor v = new Vendor();
			 v.setPk_project(Integer.parseInt(pk_project));
			 v.setVendorcode(vendorcode);
			 Vendor vendor = loanbillService.getVendor(v);
				if(vendor!=null){
					map.put("state", "true");
					map.put("vendor", vendor);
				}else{
					map.put("state", "false");
					map.put("error", "该项目中无此供应商");
				}
			
		} catch (Exception e) {
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	
	@RequestMapping(
			value = "/getBorrow.do")
	@ResponseBody
	public Object getBorrow(HttpServletRequest request,HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();	
		User user = (User)session.getAttribute("loginUser");
		 try {
			 String billno = request.getParameter("billno").trim();
			 Borrowitem vo = new Borrowitem();
			 Loanbill bill = loanbillService.getLoanbillByno(billno);
			 if(bill==null){
				 map.put("state", "false");
				 map.put("error", "无此借款单！");
				 return map;
			 }else{
				 if(bill.getPk_psn()==user.getUserid()){
					  if("5".equals(bill.getPbillstatus())){
						 Borrowitem borrow = loanbillService.getZyjeByBillno(billno);
						 if(borrow!=null){
							 if(borrow.getYcxje().toString().equals(bill.getLzje().toString())){
								 map.put("state", "false");
								 map.put("error", "此借款单已完全冲销！");
								 return map;
							 }
							 vo.setYcxje(borrow.getYcxje());
						     vo.setWcxje(bill.getLzje().subtract(vo.getYcxje()));
						 }else{
							 vo.setYcxje(new BigDecimal("0.00"));
						     vo.setWcxje(bill.getLzje());
						 }
						vo.setJkje(bill.getLzje());
					     map.put("state", "true");
						 map.put("borrow", vo);
					 }else{
						 map.put("state", "false");
						 map.put("error", "此借款单审批未通过！");
						 return map;
					 }
				 }else{
					 map.put("state", "false");
					 map.put("error", "此借款单非本人填报！");
					 return map;
				 }
			 }
		} catch (Exception e) {
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	@RequestMapping(
			value = "/getCashbill.do")
	@ResponseBody
	public Object getCashbill(HttpServletRequest request,HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();	
		User user = (User)session.getAttribute("loginUser");
		 try {
			 String billno = request.getParameter("billno").trim();
			 Cashbill vo = new Cashbill();
			 Loanbill bill = loanbillService.getLoanbillByno(billno);
			 if(bill==null){
				 map.put("state", "false");
				 map.put("error", "无此下拨资金申请单！");
				 return map;
			 }else{
				 if(bill.getDeptid()==user.getDeptid()){
					  if("5".equals(bill.getPbillstatus())){
						 Cashbill cashbill = loanbillService.getYhjeByBillno(billno);
						 if(cashbill!=null){
							 if(cashbill.getYhje().toString().equals(bill.getLzje().toString())){
								 map.put("state", "false");
								 map.put("error", "此申请单金额已完全下拨！");
								 return map;
							 }
							 vo.setYhje(cashbill.getYhje());
						     vo.setWhje(bill.getLzje().subtract(vo.getYhje()));
						 }else{
							 vo.setYhje(new BigDecimal("0.00"));
						     vo.setWhje(bill.getLzje());
						 }
						vo.setJkje(bill.getLzje());
						vo.setAccount(bill.getAccount());
					     map.put("state", "true");
						 map.put("cashbill", vo);
					 }else{
						 map.put("state", "false");
						 map.put("error", "此下拨资金申请单审批未通过！");
						 return map;
					 }
				 }else{
					 map.put("state", "false");
					 map.put("error", "此申请单非本部门申请！");
					 return map;
				 }
			 }
		} catch (Exception e) {
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	
	@RequestMapping(
			value = "/commit.do")
	@ResponseBody
	public Object commit(HttpServletRequest request,HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();	
		 try {
			 String billid = request.getParameter("billid").trim();
			 workflowService.deleteFlow(Integer.parseInt(billid));
			 Loanbill bill = loanbillService.getLoanbillById(Integer.parseInt(billid));
			 Workflow workflow = new Workflow();
			 workflow.setBillid(bill.getPk_loanbill());
			 workflow.setBillno(bill.getVbillno());
			 workflow.setBilltypecode(bill.getBilltypecode());
			 workflow.setSenderman(bill.getPk_psn());
			 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				String senddate   = format.format(new Date());
			 workflow.setSenddate(senddate);
			 workflow.setCheckresult(0);
			 workflow.setIscheck("");
			 workflow.setLevel(0);
			 workflow.setChecknote("");
			 SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			 String dateS = f.format(new Date());
			 workflow.setTs(dateS);
			 workflowService.insert(workflow);
			 bill.setPbillstatus("3");
			 loanbillService.updatePbillstatus(bill);
			 map.put("state", "true");
		} catch (Exception e) {
			map.put("state", "false");
			map.put("error", "服务器错误,提交失败！");
		}
		return map;
	}
	
	@RequestMapping(
			value = "/viewBill.do")
	public String viewBill(Model model, HttpServletRequest request,HttpSession session) {
		String action = request.getParameter("action").trim();
		String billtype = request.getParameter("billtype").trim();
		String pk_loanbill = request.getParameter("pk_loanbill").trim();
		String pk_pubwork = request.getParameter("pk_pubwork");
		Loanbill vo = loanbillService.getLoanbillById(Integer.parseInt(pk_loanbill));
		User user = userService.getUserById(vo.getPk_psn());
		String pbillstatusname = billstatusService.getBillstatusbycode(vo.getPbillstatus()).getPbillstatusname();
		vo.setPbillstatusname(pbillstatusname);
		vo.setDeptname(user.getDeptname());
		vo.setPsnname(user.getUser_name());
		vo.setEmail(user.getEmail());
		vo.setMobile(user.getMobile());
		if("RCBZ".equals(billtype)){
			Project pro = loanbillService.getProjectByBm(vo.getXmbm());
			vo.setXmmc(pro.getProjectname());
			List<Paydetail> list = loanbillService.getPaydetailVos(vo.getPk_loanbill());
			vo.setPaydetails(list);
		}
		if("CL".equals(billtype)){
			List<Expitem> list = loanbillService.getExpitemVos(vo.getPk_loanbill());
			vo.setExpitems(list);
		}
		if("JKHK".equals(billtype)){
			List<Borrowitem> list = loanbillService.getBorrowitemVos(vo.getPk_loanbill());
			for(Borrowitem o:list){
				String billno = o.getBillno();
				Borrowitem borrow = loanbillService.getZyjeByBillno(billno);
				o.setYcxje(borrow.getYcxje());
				Loanbill bill = loanbillService.getLoanbillByno(billno);
				o.setWcxje(bill.getLzje().subtract(o.getYcxje()));
				o.setJkje(bill.getLzje());
			}
			vo.setBorrowitems(list);
		}
		if("ZJZF".equals(billtype)){
			List<Cashbill> list = loanbillService.getCashbillVos(vo.getPk_loanbill());
			for(Cashbill o:list){
				String billno = o.getBillno();
				Cashbill cashbill = loanbillService.getYhjeByBillno(billno);
				o.setYhje(cashbill.getYhje());
				Loanbill bill = loanbillService.getLoanbillByno(billno);
				o.setWhje(bill.getLzje().subtract(o.getYhje()));
				o.setJkje(bill.getLzje());
			}
			vo.setCashbills(list);
		}
		if("savedView".equals(action)){
			if("2".equals(vo.getPbillstatus())){
				model.addAttribute("action", "savedView1");
			}else if("3".equals(vo.getPbillstatus())){
				model.addAttribute("action", "savedView2");
			}
			else if("4".equals(vo.getPbillstatus())){
				model.addAttribute("action", "savedView2");
			}
			else if("5".equals(vo.getPbillstatus())){
				model.addAttribute("action", "savedView2");
			}
			else if("6".equals(vo.getPbillstatus())){
				model.addAttribute("action", "savedView3");
			}
		}else{
			model.addAttribute("action", action);
		}
		if(pk_pubwork!=null&&!"".equals(pk_pubwork)){
			vo.setPk_pubwork(Integer.parseInt(pk_pubwork));
		}
		model.addAttribute("bean", vo);
		return billtype+"/insertBill"+billtype;
	}
	
	   
	@RequestMapping(
			value = "/deleteBill.do")
	@ResponseBody
	public Object deleteBill(HttpServletRequest request,HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();	
		 try {
			 String pk_loanbill = request.getParameter("pk_loanbill").trim();
			 String billtype = request.getParameter("billtype").trim();
			 loanbillService.deleteBill(Integer.parseInt(pk_loanbill));
			 workflowService.deleteFlow(Integer.parseInt(pk_loanbill));
			 if("RCBZ".equals(billtype)){
				 loanbillService.deletePaydetails(Integer.parseInt(pk_loanbill));
			 }
			 if("CL".equals(billtype)){
				 loanbillService.deleteExpitems(Integer.parseInt(pk_loanbill));
			 }
			 if("JKHK".equals(billtype)){
				 loanbillService.deleteBorrowitems(Integer.parseInt(pk_loanbill));
			 }
			 if("ZJZF".equals(billtype)){
				 loanbillService.deleteCashbills(Integer.parseInt(pk_loanbill));
			 }
			 map.put("state", "true");
		} catch (Exception e) {
			map.put("state", "false");
			map.put("error", "服务器错误,删除失败！");
		}
		return map;
	}
	@RequestMapping(
			value = "/updateBill.do")
	@ResponseBody
	public Object updateBill(Model model,@RequestBody Loanbill loanbill, HttpServletRequest request,HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();	
		 try {
				loanbillService.updateBill(loanbill);
				if("RCBZ".equals(loanbill.getBilltypecode().trim())){
					loanbillService.deletePaydetails(loanbill.getPk_loanbill());
					for(Paydetail detail:loanbill.getPaydetails()){
						if(detail!=null){
							detail.setDr(0);
							detail.setPk_loanbill(loanbill.getPk_loanbill());
						}
						loanbillService.insertPaydetail(detail);
					}
				}
				if("CL".equals(loanbill.getBilltypecode().trim())){
					loanbillService.deleteExpitems(loanbill.getPk_loanbill());
					for(Expitem detail:loanbill.getExpitems()){
						if(detail!=null){
							detail.setDr(0);
							detail.setPk_loanbill(loanbill.getPk_loanbill());
						}
						loanbillService.insertExpitem(detail);
					}
				}
				if("JKHK".equals(loanbill.getBilltypecode().trim())){
					loanbillService.deleteBorrowitems(loanbill.getPk_loanbill());
					for(Borrowitem detail:loanbill.getBorrowitems()){
						if(detail!=null){
							detail.setDr(0);
							detail.setPk_loanbill(loanbill.getPk_loanbill());
						}
						loanbillService.insertBorroeitem(detail);
					}
				}
				if("ZJZF".equals(loanbill.getBilltypecode().trim())){
					loanbillService.deleteCashbills(loanbill.getPk_loanbill());
					for(Cashbill detail:loanbill.getCashbills()){
						if(detail!=null){
							detail.setDr(0);
							detail.setPk_loanbill(loanbill.getPk_loanbill());
						}
						loanbillService.insertCashbill(detail);
					}
				}
				map.put("state", "true");
		} catch (Exception e) {
			map.put("state", "false");
			map.put("error", "服务器错误");
		}
		return map;
	}
	/**
	 * 上传图片
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	/*@RequestMapping(value="/uploadPic.do" ,method = RequestMethod.POST,produces="text/html")
	@ResponseBody 
	public String uploadPic(HttpServletRequest request) {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		List<MultipartFile> files= multipartRequest.getFiles("file");
		String sumpath="";
		//开始处理附件
		for(int j=0;j<files.size();j++){
			MultipartFile	file=files.get(j);
		String tFileName = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date());
		Random random = new Random();
		for(int i =0;i<3;i++){
			tFileName = tFileName+random.nextInt(10);
		}
		String suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		String pathLast=tFileName.substring(0,4)+"/"+tFileName.substring(4,6)+"/";
		
		String path = request.getSession().getServletContext().getRealPath("/")+"/upload/question_pic/"+pathLast+tFileName + suffix;
		File deskFile = new File(path);
		File parent = deskFile.getParentFile();
		if(null!=parent&&!parent.exists()){
			parent.mkdirs();
		}
		try {
			file.transferTo(new File(path));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		sumpath+=pathLast+tFileName + suffix+";";
		}
		return sumpath;
	}*/
}
