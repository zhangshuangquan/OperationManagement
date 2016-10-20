package com.codyy.oc.admin.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ResultJson;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.MaintenanceOrder;
import com.codyy.oc.admin.service.MaintenanceOrderService;
import com.codyy.oc.admin.service.WorkerOrderService;
import com.codyy.oc.admin.view.MgOrderView;
import com.codyy.oc.admin.view.OrderDetailView;
import com.codyy.oc.admin.view.ProblemTypeView;
import com.codyy.oc.admin.view.UserSearchModel;
import com.codyy.oc.admin.view.WorkOrderSearch;

@Controller
@RequestMapping("/admin/workorder/")
public class WorkOderController {
	
	@Autowired
	private  WorkerOrderService  workerOrderService;
	
	@Autowired
	private MaintenanceOrderService maintenanceOrderService;
	
	/**
	 * 对前台传递的Date进行格式化规定
	 * @param binder
	 */
	@InitBinder  
	 public void initBinder(WebDataBinder binder) {  
	     SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	     dateFormat.setLenient(false);  
	     binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
	}

	/**
	 * 
		* @author zhangshuangquan
		* @Title: toShowOrderList
		* @Description: (去展示工单页面)
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toshoworderlist")
	public  String  toShowOrderList(){
		return "admin/workOrderManager/workOrderList";
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toAddAfterSale
		* @Description: (添加售后保障记录页面)
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toaddaftersale")
	public  String toAddAfterSale(HttpServletRequest request){
		AdminUser adminUser = (AdminUser) request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
		request.setAttribute("realName", adminUser.getRealName());
		//获得所有问题类型信息
		List<ProblemTypeView> problemTypeViewList =maintenanceOrderService.selecProblemType();
		request.setAttribute("problemTypeViewList", problemTypeViewList);
		return "admin/workOrderManager/addAfterSaleRecord";
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: addAfterSale
		* @Description: (添加售后保障记录)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("addaftersale")
	public ResultJson addAfterSale(MaintenanceOrder mOrder,String engineer,String[] equipTime,String[] equipMsg,String[] expressCompanyStr,String[] expressNumStr, String[] problemType,HttpServletRequest request){
		AdminUser adminUser = (AdminUser) request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
		mOrder.setCreateUser(adminUser.getAdminUserId());
		return workerOrderService.addAfterSale(mOrder,engineer,equipTime,equipMsg,expressCompanyStr,expressNumStr,problemType);
		
	}
	/**
		* @author zhangshuangquan
		* @Title: getWorkOrderList
		* @Description: (获取工单列表并分页)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("getworkorderlist")
	public Page getWorkOrderList(WorkOrderSearch workOrderSearch,Page page){
		return workerOrderService.getWorkOrderList(workOrderSearch,page);
		
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: 
		* @Description: (这里用一句话描述这个方法的作用)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	
	@RequestMapping("exportworkorderlist")
	public void  exportWorkOrderList(WorkOrderSearch workOrderSearch,HttpServletResponse response){
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment; filename=exportWorkOrderList.xls");
		try {
			OutputStream out = response.getOutputStream();
			HSSFWorkbook  workbook = workerOrderService.exportWorkOrderList(workOrderSearch);
			workbook.write(out);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	/**
	 * @return 
	 * 
		* @author zhangshuangquan
		* @Title: 
		* @Description: (编辑工单页面)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toeditworkorder")
	public String toEditWorkOrder(String maintenanceOrderId,Model model,HttpServletRequest request){
		model.addAttribute("data", workerOrderService.getWorkOrderById(maintenanceOrderId));
		MgOrderView managerOrderView=maintenanceOrderService.getManagerByOrderId(maintenanceOrderId);
		//问题类型集合
		List<ProblemTypeView> problemTypeList=maintenanceOrderService.getProbTypeByOrderId(maintenanceOrderId);
		List<ProblemTypeView> allProblemList=maintenanceOrderService.selecProblemType();//所有问题类型
		request.setAttribute("allProblemList", allProblemList);
		request.setAttribute("managerOrderView", managerOrderView);
		String proTy="";
		if(null!=problemTypeList && problemTypeList.size()>0){
			for(ProblemTypeView problemTypeView : problemTypeList){
				proTy+=problemTypeView.getProblemId()+",";
			}
			proTy=proTy.substring(0,proTy.length()-1);
		}
		request.setAttribute("problemTypeList", proTy);
	    return "admin/workOrderManager/editAfterSaleRecord";
	}
	
	
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toShowEngineerList
		* @Description: (跳转到展示工程师页面)
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toshowengineerlist")
	public String toShowEngineerList(@RequestParam(required=false) String projectId,Model model){
		if(StringUtils.isNotBlank(projectId)){
		     model.addAttribute("projectId",projectId);
		}
		return "admin/workOrderManager/showEngineerList";
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: getEngineers
		* @Description: (获取工程师)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("getengineers")
	public List<AdminUser>  getEngineers(String id){
		return workerOrderService.getEngineersById(id);	
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: 
		* @Description: (这里用一句话描述这个方法的作用)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("editworkorder")
	public ResultJson  editWorkOrder(MaintenanceOrder mOrder,String engineer,String[] equipTime,String[] equipMsg,String[] expressCompanyStr,String[] expressNumStr,String[] problemType){
		return workerOrderService.editAfterSaleRecord(mOrder,engineer,equipTime,equipMsg,expressCompanyStr,expressNumStr,problemType);
		
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: viewWorkOrder
		* @Description: (查看工单)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("viewworkorder")
	public String viewWorkOrder(String maintenanceOrderId,Model model,HttpServletRequest request){
		//根据传来的单号来获取单号中的所有信息的详情
		OrderDetailView orderDetailView= maintenanceOrderService.getDetail(maintenanceOrderId);
		List<AdminUser>   engineers =maintenanceOrderService.getUserROrder(maintenanceOrderId);
		request.setAttribute("engineers", engineers);
		request.setAttribute("orderDetailView", orderDetailView);
		request.setAttribute("equipList",  orderDetailView.getEqupList());
		request.setAttribute("problemTypeList",orderDetailView.getProblemTypeList());//存储本工单存在的问题
		request.setAttribute("realName", orderDetailView.getRealName());
	    return "admin/workOrderManager/viewAfterSaleRecord";
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: delWorkOrder
		* @Description: (删除工单)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("delworkorder")
	public ResultJson delWorkOrder(String maintenanceOrderId){
		return workerOrderService.delWorkOrder(maintenanceOrderId);
		
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toviewpicture
		* @Description: (查看图片)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toviewpicture")
	public String  toViewPicture(String maintenanceOrderId,Model model){
		model.addAttribute("picture",workerOrderService.downloadPicture(maintenanceOrderId));
		return "admin/workOrderManager/viewPicture";
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toDownloadPicture
		* @Description: (下载图片页面)
		* @Title: wnloadPicture
		* @Description: (下载图片页面)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("todownloadpicture")
	public String todownloadPicture(String maintenanceOrderId,Model model){
		model.addAttribute("id", maintenanceOrderId);
		return "admin/workOrderManager/downloadPicture";
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: downloadPicture
		* @Description: (分页显示要下载的图片)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("downloadpicture")
	public Page downloadPicture(String maintenanceOrderId,Page page){
		return workerOrderService.getPictures(maintenanceOrderId,page);
		
	}
	
	@ResponseBody
	@RequestMapping("getengineerlist")
	public Page getEngineerList(UserSearchModel userSearch,Page page){
		return workerOrderService.getEngineerList(userSearch,page);
	}
	
	/**
	 * @author lichen
	* @Title: jumpToSchoolList
	* @Description: (这里用一句话描述这个方法的作用)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptoschoollist")
	public String jumpToSchoolList(String SchoolBaseAreaId,String projId,HttpServletRequest request){
		request.setAttribute("SchoolBaseAreaId", SchoolBaseAreaId);
		request.setAttribute("projId", projId);
		return "admin/workOrderManager/showSchoolList";
	}
	
	/**
	 * @author lichen
	* @Title: searchSchoolPageList
	* @Description: (搜索学校并实现区域信息的回填)
	* @param @param page
	* @param @return    设定文件
	* @return Page    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("searchschoolpagelist")
	public Page searchSchoolPageList(Page page,String schoolArea,String projId,String schoolName){
		return workerOrderService.searchSchoolPageList(page,schoolArea,projId,schoolName);
	}
}
