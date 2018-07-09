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

import com.erp.bean.Grant;
import com.erp.bean.Job;
import com.erp.bean.Loanbill;
import com.erp.bean.User;
import com.erp.bean.Workflow;
import com.erp.service.BillstatusService;
import com.erp.service.BilltypeService;
import com.erp.service.GrantService;
import com.erp.service.LoanbillService;
import com.erp.service.UserService;
import com.erp.service.WorkflowService;

@Controller
@RequestMapping(value = "/workflow")
public class WorkflowController {
	
	@Autowired
	private WorkflowService woekflowservice;
	@Autowired
	private UserService userService;
	@Autowired
	private BilltypeService billtypeService;
	@Autowired
	private BillstatusService billstatusService;
	@Autowired
	private LoanbillService loanbillService;
	@Autowired
	private GrantService grantService;
		@ResponseBody
		@RequestMapping("/getBtdListExce.do")
		public Object getBtdListExce(HttpServletRequest request,HttpSession session){
			Map<String,Object> map = new HashMap<String,Object>();
			try {
				User user = (User) session.getAttribute("loginUser");
				List<Workflow> list = new ArrayList<Workflow>();
				list  = woekflowservice.getBtdListExce(user);
				if(list.size()>0){
					map.put("state", "true");
					map.put("list", list);
				}else{
					map.put("state", "false");
					map.put("error", "无退单信息");
				}
					
			} catch (Exception e) {
				System.err.println(e.getMessage());
				map.put("state", "false");
				map.put("error", "服务器错误");
			}
			return map;
		}
		
			@RequestMapping("/getBtdList.do")
			public String getBtdList(HttpServletRequest request,HttpSession session,Model model){
				User user = (User) session.getAttribute("loginUser");
				List<Workflow> list =  woekflowservice.getBtdList(user);
						model.addAttribute("beans", list);
				return "message_btdxx";
			}
			
			@RequestMapping("/toApprovePage.do")
			public String toApprovePage(HttpServletRequest request,HttpSession session,Model model){
				User user = (User)session.getAttribute("loginUser");
				List<Workflow> beans = new ArrayList<Workflow>();
				List<Job> joblst = userService.getBilltype(user);
				Job job = joblst.get(0);
				String billtype = job.getBilltype();
				int level = job.getLevel();
				Map<String, Object> searchPara = new HashMap<String, Object>();
				String currentPage = request.getParameter("currentPage")==null||"".equals(request.getParameter("currentPage"))?"1":request.getParameter("currentPage").trim();
				String range = request.getParameter("range")==null||"".equals(request.getParameter("range"))?"6":request.getParameter("range").trim();
				String billno = request.getParameter("billno")==null||"".equals(request.getParameter("billno"))?null:request.getParameter("billno").trim();
				 Calendar c = Calendar.getInstance();  
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
				String dateto = format.format(new Date());
				String datefrom = null;
				int pageSize = 15;
				int current = Integer.parseInt(currentPage);
				if(current<1){
					current=1;
				}
				
				
				if("6".equals(range)){
					  datefrom = "1996-06-07";
				}else if("1".equals(range)){
					 c.add(Calendar.DAY_OF_MONTH, -6);    //得到前一周
					  datefrom = format.format(c.getTime());
				}else if("2".equals(range)){
				    c.add(Calendar.MONTH, -1);    //得到前一个月    
				  datefrom = format.format(c.getTime());
				}else if("3".equals(range)){
					 c.add(Calendar.MONTH, -3);    //得到前3个月    
					  datefrom = format.format(c.getTime());
				}else if("4".equals(range)){
					 c.add(Calendar.MONTH, -6);    //得到前6个月    
					  datefrom = format.format(c.getTime());
				}else if("5".equals(range)){
					 c.add(Calendar.YEAR, -1);    //得到前一年
					  datefrom = format.format(c.getTime());
				}
				searchPara.put("billno", billno);
				searchPara.put("datefrom", datefrom);
				searchPara.put("dateto", dateto);
				String[] types = billtype.split(",");
				String type = "";
				for(int i =0;i<types.length;i++){
					if(i!=types.length-1){
						type+="'"+types[i]+"',";
					}else{
						type+="'"+types[i]+"'";
					}
				}
				searchPara.put("billtype", type);
				searchPara.put("level", level-1);
				List<Workflow> beans1 = woekflowservice.searchFlowBills(searchPara); 
				if(beans1.size()>0){
					beans.addAll(beans1);
				}
				List<Grant> grants  =  grantService.getGrantsByGrantedPsn(user.getUserid());
				for(Grant obj:grants){
					User u = userService.getUserById(obj.getPk_psn());
					Map<String, Object> searchPara1 = new HashMap<String, Object>();
					searchPara1.put("billno", billno);
					searchPara1.put("datefrom", obj.getDatefrom());
					searchPara1.put("dateto", obj.getDateto());
					searchPara1.put("billtype", "'"+obj.getBilltypecode()+"'");
					searchPara1.put("level", level-1);
					
					Workflow w = new Workflow();
					w.setChecknote(u.getUser_name()+"授权审批单据:");
					w.setBillno("grant");
					List<Workflow> beans2 = woekflowservice.searchFlowBills(searchPara1);
					if(beans2.size()>0){
						beans.add(w);
						beans.addAll(beans2);
					}
				}
				for(Workflow vo:beans){
					if(!"grant".equals(vo.getBillno()))
					{
						String billtypename = billtypeService.getBilltypebycode(vo.getBilltypecode()).getBilltypename();
						vo.setBilltypename(billtypename);
						Loanbill bill = loanbillService.getLoanbillById(vo.getBillid());
						vo.setPsnname(bill.getPsnname());
						String pbillstatusname = billstatusService.getBillstatusbycode(bill.getPbillstatus()).getPbillstatusname();
						vo.setPbillstatusname(pbillstatusname);
						User senderman = userService.getUserById(vo.getSenderman());
						vo.setSendermanname(senderman.getUser_name());
						vo.setDigest(bill.getDigest());
						vo.setLzje(bill.getLzje());
					}
				}
				int totalPage =0;
				List<Workflow> lst = new ArrayList<Workflow>();
				if(beans.size()>0){
					int count = beans.size();
					totalPage = count%pageSize==0?count/pageSize:count/pageSize+1;
					if(current>totalPage&&totalPage!=0){
						current=totalPage;
					}
					if(current*pageSize>count){
                        for(int i=(current-1)*pageSize;i<count;i++){
							lst.add(beans.get(i));
						}
					}else{
						for(int i=(current-1)*pageSize;i<pageSize*current;i++){
							lst.add(beans.get(i));
						}
					}
				}
				model.addAttribute("beans", lst); // 把结果集放入request
				model.addAttribute("totalPage", totalPage);
				model.addAttribute("range", range);
				model.addAttribute("currentPage",totalPage==0?0:Integer.parseInt(currentPage)<1?1:Integer.parseInt(currentPage)>totalPage?totalPage:Integer.parseInt(currentPage));
				return "listCmerApprovedBills";
			}
			
			@ResponseBody
			@RequestMapping("/approvresult.do")
			public Object approvresult(HttpServletRequest request,HttpSession session){
				Map<String,Object> map = new HashMap<String,Object>();
				try {
					String billid1 = request.getParameter("billid").trim();
					int billid = Integer.parseInt(billid1);
					User user = (User) session.getAttribute("loginUser");
					List<Workflow> list = new ArrayList<Workflow>();
					list  = woekflowservice.getFlowlistByBillid(billid);
					if(list.size()>0){
						for(Workflow vo:list){
							int senderman = vo.getSenderman();
							int checkman = vo.getCheckman();
							User send = userService.getUserById(senderman);
							User check = userService.getUserById(checkman);
							vo.setSendermanname(send.getUser_name());
							if(vo.getCheckdate()==null){
								vo.setCheckdate("");
							}
							if(checkman!=0){
								vo.setPsnname(check.getUser_name());
							}
							if(vo.getPsnname()==null){
								vo.setPsnname("");
							}
							if(vo.getChecknote()==null){
								vo.setChecknote("");
							}
						}
						map.put("state", "true");
						map.put("list", list);
					}else{
						map.put("state", "false");
						map.put("error", "");
					}
						
				} catch (Exception e) {
					System.err.println(e.getMessage());
					map.put("state", "false");
					map.put("error", "服务器错误");
				}
				return map;
			}
			
			@ResponseBody
			@RequestMapping("/checkBill.do")
			public Object checkBill(HttpServletRequest request,HttpSession session){
				Map<String,Object> map = new HashMap<String,Object>();
				User user = (User) session.getAttribute("loginUser");
				List<Job> joblst= userService.getBilltype(user);
				Job job = joblst.get(0);
				int level = job.getLevel();
				try {
					String pk_pubwork = request.getParameter("pk_pubwork").trim();
					Workflow bean = woekflowservice.getFlowById(Integer.parseInt(pk_pubwork));
					if((""+bean.getLevel()).equals(""+level)){
						map.put("state", "false");
						map.put("error", "该单据此环节已被审批");
						return map;
					}
					String billno = bean.getBillno();
					String flag = request.getParameter("flag").trim();
					String checknote ="审批通过";
					int checkresult = 1;
					if("2".equals(flag)){
						checknote = new String(request.getParameter("checknote").trim().getBytes("ISO-8859-1"),"gbk");
						checkresult = 2;
					}
					Workflow w = new Workflow();
					SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String dateS = f.format(new Date());
					w.setPk_pubwork(Integer.parseInt(pk_pubwork));
					w.setBillid(bean.getBillid());
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
					String checkdate = format.format(new Date());
					w.setCheckdate(checkdate);
					w.setChecknote(checknote);
					w.setCheckman(user.getUserid());
					w.setCheckresult(checkresult);
					w.setIscheck("Y");
					
					w.setLevel(level);
					w.setTs(dateS);
					woekflowservice.updateFlow(w);
					if(level!=3){
						if("1".equals(flag)){
							Workflow f1 = new Workflow();
							f1.setBillid(bean.getBillid());
							f1.setBilltypecode(bean.getBilltypecode());
							f1.setBillno(billno);
							f1.setSenddate(checkdate);
							f1.setSenderman(user.getUserid());
							f1.setCheckresult(0);
							f1.setIscheck("");
							f1.setLevel(level);
							f1.setChecknote("");
							f1.setTs(dateS);
							woekflowservice.insert(f1);
						}
					}
					Loanbill bill = new Loanbill();
					bill.setPk_loanbill(bean.getBillid());
					if("2".equals(flag)){
						bill.setPbillstatus("6");
					}else if("1".equals(flag)){
						if(level==1){
							bill.setPbillstatus("4");
						}else if(level==3){
							bill.setPbillstatus("5");
						}else if(level==2){
							bill.setPbillstatus("4");
						}
					}
					loanbillService.updatePbillstatus(bill);
					map.put("state", "true");
				} catch (Exception e) {
					System.err.println(e.getMessage());
					map.put("state", "false");
					map.put("error", "服务器错误");
				}
				return map;
			}
			
}
