package com.codyy.oc.admin.controller;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.service.MaintenanceOrderService;
import com.codyy.oc.admin.service.WorkerOrderService;
import com.codyy.oc.admin.view.AttachmentView;
import com.codyy.oc.admin.view.OrderDetailView;
import com.codyy.oc.admin.view.OrderReparingView;
import com.codyy.oc.admin.view.ProblemTypeView;
import com.codyy.oc.admin.view.RepairView;
import com.codyy.oc.admin.view.showOrderView;

@Controller
@RequestMapping("/admin/maintenanceorder/")
public class MaintenanceOrder {

	@Autowired
	private MaintenanceOrderService maintenanceOrderService;
	
	@Autowired
	private WorkerOrderService workerOrderService;
	
	/**
	 * @author lichen
	* @Title: jumpToReparingManageList
	* @Description: (跳转到现场维修列表)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptoreparingmanagelist")
	public String jumpToReparingManageList(){
		
        return "admin/reparingManagement/reparingManageList";
	}
	
	/**
	 * @author lichen
	* @Title: jumpToRepManageDetail
	* @Description: (跳转到维修详情)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptorepmanagedetail")
	public String jumpToRepManageDetail(String maintenanceOrderId,HttpServletRequest request){
		
		//根据传来的单号来获取单号中的所有信息的详情
		OrderDetailView orderDetailView = maintenanceOrderService.getDetail(maintenanceOrderId);
		List<AdminUser>   engineers = maintenanceOrderService.getUserROrder(maintenanceOrderId);
		request.setAttribute("engineers", engineers);
		request.setAttribute("orderDetailView", orderDetailView);
		request.setAttribute("equipList",  orderDetailView.getEqupList());
		request.setAttribute("problemTypeList",orderDetailView.getProblemTypeList());//存储本工单存在的问题
		request.setAttribute("realName", orderDetailView.getRealName());
		return "admin/reparingManagement/reparingManageDetail";
	}
	
	/**
	 * @author lichen
	* @Title: jumpToUpdateRepMange
	* @Description: (跳转到修改页面)
	* @param @param maintenanceOrderId
	* @param @param request
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptoupdaterepmange")
	public String jumpToUpdateRepMange(String maintenanceOrderId,HttpServletRequest request){
		//根据传来的单号来获取单号中的所有信息的详情
		OrderDetailView orderDetailView = maintenanceOrderService.getDetail(maintenanceOrderId);
		List<AdminUser>   engineers = maintenanceOrderService.getUserROrder(maintenanceOrderId);
		request.setAttribute("engineers", engineers);
		request.setAttribute("orderDetailView", orderDetailView);
		request.setAttribute("equipList",  orderDetailView.getEqupList());
		List<ProblemTypeView> checkedQuTyList = orderDetailView.getProblemTypeList();//存储本工单存在的问题
		request.setAttribute("checkedQuTyList", checkedQuTyList);
		request.setAttribute("realName", orderDetailView.getRealName());
		return "admin/reparingManagement/UpdateReparingManage";
	}
	
	
	/**
	 * @author lichen
	* @Title: updateRepair
	* @Description: (编辑现场维修)
	* @param @param repairView
	* @param @return    设定文件
	* @return ResultJson    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("updaterepair")
	public ResultJson updateRepair(RepairView repairView){
		
		return maintenanceOrderService.updateRepair(repairView);
	}
	
	/**
	 * @author lichen
	* @Title: jumpToUpLoadPic
	* @Description: (跳转到图片上传页面)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptouploadpic")
	public String jumpToUpLoadPic(String maintenanceOrderId,HttpServletRequest request){
		
		request.setAttribute("orderId", maintenanceOrderId);
		return "admin/reparingManagement/uploadPicture";
	}
	
	
	/**
	 * @author lichen
	* @Title: jumpToEditPicture
	* @Description: (跳转到图片编辑页面)
	* @param @param maintenanceOrderId
	* @param @param model
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptoeditpicture")
	public String jumpToEditPicture(String maintenanceOrderId,Model model){
		model.addAttribute("picture",workerOrderService.downloadPicture(maintenanceOrderId));
		return "admin/reparingManagement/EditPicture";
	}
	
	/**
	 * @author lichen
	* @Title: getMainOrderRepList
	* @Description: (查询并实现维修现场的分页)
	* @param @return    设定文件
	* @return Page    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("getmainorderreplist")
	public Page getMainOrderRepList(OrderReparingView orderView,Page page,HttpServletRequest request){
		AdminUser adminUser = (AdminUser) request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
		String userId=adminUser.getAdminUserId();
		List<showOrderView> orderViewList =maintenanceOrderService.reparingOrderPageList(page, orderView,userId);
		page.setData(orderViewList);
		return page;
	}
	
	
	/**
	 * @author lichen
	* @Title: exportReparingList
	* @Description: (导出现场维修列表)
	* @param @param orderView
	* @param @param response    设定文件
	* @return void    返回类型
	* @throws
	 */
	@RequestMapping("exportreparinglist")
    public void exportReparingList(OrderReparingView orderView,HttpServletResponse response,HttpServletRequest request){
		AdminUser adminUser = (AdminUser) request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
		String userId=adminUser.getAdminUserId();
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment; filename=exportReparingList.xls");
		try {
			OutputStream out = response.getOutputStream();
			HSSFWorkbook workbook=maintenanceOrderService.exportReparingList(orderView,userId);
			workbook.write(out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @author lichen
	* @Title: getOrderAttachmentById
	* @Description: (判断本工单是否上传过附件)
	* @param @param orderId
	* @param @return    设定文件
	* @return Attachment    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("getorderattachmentbyid")
	public Attachment getOrderAttachmentById(String orderId){
		
		return maintenanceOrderService.getOrderAttachmentById(orderId);
	}
	
	
	/**
	 * @author lichen
	* @Title: insertAttachment
	* @Description: (给工单添加附件)
	* @param @param attachment
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("insertattachment")
	 public Integer insertAttachment(Attachment attachment){
		 
		 return maintenanceOrderService.insertAttachment(attachment);
	 }
	
	/**
	 * @author lichen
	* @Title: delInsertAttachment
	* @Description: (覆盖已上传的附件)
	* @param @param attachment    设定文件
	* @return void    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("delInsertAttachment")
	public void delInsertAttachment(Attachment attachment){
		
		maintenanceOrderService.delInsertAttachment(attachment);
	}
	
	
	/**
	 * @author lichen
	* @Title: insertPicture
	* @Description: (实现图片以及对应描述的上传操作)
	* @param @param pictureDesc
	* @param @param oraginalFileName
	* @param @param newFileName
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("insertPicture")
	public ResultJson insertPicture(String[] newFileName, String[] oraginalFileName,String[] picDesc,String orderId){
		
		List<Attachment> qualifiList = new ArrayList<Attachment>();
		
		//如果是删除全部或为null的情况下则不予以赋值
		if(newFileName!=null && oraginalFileName!=null){
			
			if(picDesc.length==0){
				picDesc= new String[1];
				picDesc[0]="";
			}else{
				
				for(int i=0; i<picDesc.length; i++){
					if(null==picDesc[i] || "".equals(picDesc[i])){
						picDesc[i]="";
					}
				}
			}
		}
			
			
		
		
		if(oraginalFileName!=null && oraginalFileName.length>0 && newFileName!=null && newFileName.length>0){
			for(int i=0; i<newFileName.length; i++){//将所有的文件的新名赋值到对象
				Attachment qualifi = new Attachment();
				qualifi.setRelationShipId(orderId);
				qualifi.setAttachment_Url(newFileName[i]);
				qualifi.setName(oraginalFileName[i]);
				qualifi.setRemark(picDesc[i]);
				qualifi.setType("image");
				qualifi.setCreate_time(new Date());
				qualifi.setAttachmentId(UUIDUtils.getUUID());
				qualifiList.add(qualifi);
			}
		}
		
		
		
		return maintenanceOrderService.insertPicture(qualifiList);
	}
	
	/**
	 * @author lichen
	* @Title: deleteAttachmentByPicName
	* @Description: (删除指定的图片信息)
	* @param @param attachment
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("deleteattachmentbypicname")
	public ResultJson deleteAttachmentByPicName(Attachment attachment){
		
		return maintenanceOrderService.deleteAttachmentByPicName(attachment);
	}
	
	/**
	 * @author lichen
	* @Title: editPicMark
	* @Description: (对图片进行编辑操作)
	* @param @param attachmentView
	* @param @return    设定文件
	* @return ResultJson    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("editpicmark")
	public ResultJson editPicMark(AttachmentView attachmentView){
		
		return maintenanceOrderService.editPicMark(attachmentView);
	}
}
