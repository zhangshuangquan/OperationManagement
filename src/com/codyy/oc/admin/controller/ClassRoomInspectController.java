package com.codyy.oc.admin.controller;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.entity.ClassroomInspectDetail;
import com.codyy.oc.admin.entity.ClsClassroom;
import com.codyy.oc.admin.entity.EnvironmentSurvey;
import com.codyy.oc.admin.entity.Type;
import com.codyy.oc.admin.service.AttachmentService;
import com.codyy.oc.admin.service.ClassRoomService;
import com.codyy.oc.admin.view.ClsClassroomSearch;

/**
 * 
 * @author codyy
 * 调试状态Controller
 */
@Controller
@RequestMapping("/admin/classroominspect/")
public class ClassRoomInspectController {

	@Autowired
	private ClassRoomService classroomservice;
	@Autowired
	private AttachmentService attachmentService;
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
	* @Title: classroomlist
	* @Description: (教室列表页面)
	* @param @return
	* @return String    
	* @throws
	 */
	@RequestMapping("classroomlist")
	public String classroomlist(){
		return "/admin/classroomInspectManager/classroomlist";
	}
	
	/**
	 * 
	* @Title: getClassRoomList
	* @Description: (分页获取教室列表)
	* @param @param search
	* @param @param page
	* @param @return
	* @return Page    
	* @throws
	 */
	@ResponseBody
	@RequestMapping("getclassroomlist")
	public Page getClassRoomList(ClsClassroomSearch search,Page page,String sortDesc){
		return classroomservice.getClassRoomList(search,page,sortDesc);
	}
	
	/**
	 * 
	* @Title: viewClassroomdetail
	* @Description: (查看教室详情信息)
	* @param @param classroomId
	* @param @param model
	* @param @return
	* @return String    
	* @throws
	 */
	@RequestMapping("viewclassroomdetail")
	public String viewClassroomdetail(String classroomId,Model model,HttpServletRequest request){
		
		Type type = new Type();
		type.setClassRoomId(classroomId);
		type.setType(Type.CLASSROOM_DETAIL);
		List<Attachment> attachList =attachmentService.classRoomDetailBycId(type);
		request.setAttribute("attList", attachList);
		model.addAttribute("classroom", classroomservice.getClassRoomById(classroomId));
		return "/admin/classroomInspectManager/viewclassroomdetail";
	}
	
	/**
	 * 
	* @Title: toeditclassroom
	* @Description: (编辑教室页面)
	* @param @param classroomId
	* @param @param model
	* @param @return
	* @return String    
	* @throws
	 */
	@RequestMapping("toeditclassroom")
	public String toeditclassroom(String classroomId,Model model){
		model.addAttribute("classroom", classroomservice.getClassRoomById(classroomId));
		return "/admin/classroomInspectManager/editclassroom";
	}
	
	/**
	 * 
	* @Title: finishedit
	* @Description: (编辑安装进展)
	* @param @param classroom
	* @param @param request
	* @param @return
	* @return ResultJson    
	* @throws
	 */
	@ResponseBody
	@RequestMapping("finisheditdetail")
	public ResultJson finisheditdetail(ClsClassroom classroom,Boolean updateUser,HttpServletRequest request,String[] newFileName,String[] oraginalFileName,String[] picDesc){
		List<Attachment> classRoomDetailList = new ArrayList<Attachment>();
		
		//当添加记录不填写描述的处理    删除所有后三个全为null即不进入本条件
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
		
		
		if(newFileName!=null && newFileName.length>0 && oraginalFileName!=null && oraginalFileName.length>0){
			
			for(int i=0; i<newFileName.length; i++){//将所有的文件的新名赋值到对象
				
				Attachment classRoomDetail = new Attachment();
				classRoomDetail.setRelationShipId(classroom.getClsClassroomId());
				classRoomDetail.setAttachment_Url(newFileName[i]);
				classRoomDetail.setName(oraginalFileName[i]);
				if(picDesc!=null&&picDesc.length>0){
				   classRoomDetail.setRemark(picDesc[i].trim());	
				}
				classRoomDetail.setType(Type.CLASSROOM_DETAIL);
				classRoomDetail.setCreate_time(new Date());
				classRoomDetailList.add(classRoomDetail);
			}
			
		}
		
		if(updateUser!=null && updateUser){
			//如果为真，则修改安装人为当前登录人，否则保持原样
			AdminUser adminUser = (AdminUser) request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
			classroom.setInstallUser(adminUser.getAdminUserId());
		}else{
			classroom.setInstallUser(null);
		}
		
		return classroomservice.editClassRoom(classroom,classRoomDetailList);
	}
	
	/**
	 * 
	* @Title: toeditclassroomdetail
	* @Description: (编辑安装进展页面)
	* @param @param classroomId
	* @param @param model
	* @param @return
	* @return String    
	* @throws
	 */
	@RequestMapping("toeditclassroomdetail")
	public String toeditclassroomdetail(String classroomId,Model model,HttpServletRequest request){
		model.addAttribute("classroom", classroomservice.getClassRoomById(classroomId));
		Type type = new Type();
		type.setClassRoomId(classroomId);
		type.setType(Type.CLASSROOM_DETAIL);
		List<Attachment> attachList =attachmentService.classRoomDetailBycId(type);
		request.setAttribute("attList", attachList);
		AdminUser adminUser = (AdminUser) request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
		request.setAttribute("realName", adminUser.getRealName());
		return "/admin/classroomInspectManager/editclassroomdetail";
	}
	
	/**
	 * 
	* @Title: exportProjectList
	* @Description: (导出调试状态列表)
	* @param @param clsClassroomSearch
	* @param @param response
	* @return void    
	* @throws
	 */
	@RequestMapping("exportclassroominspectlist")
	public void exportProjectList(ClsClassroomSearch clsClassroomSearch,HttpServletResponse response,String sortDesc){
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment; filename=exportclassinspectList.xls");
		try {
			OutputStream out = response.getOutputStream();
			HSSFWorkbook workbook=classroomservice.exportClassroomListInspect(clsClassroomSearch,sortDesc);
			workbook.write(out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	* @Title: viewclassroominspect
	* @Description: (查看调试详情)
	* @param @param classroomId
	* @param @param model
	* @param @return
	* @return String    
	* @throws
	 */
	///////
	@RequestMapping("viewclassroominspect")
	public String viewclassroominspect(String classroomId,Model model,HttpServletRequest request){
		Type type = new Type();
		type.setClassRoomId(classroomId);
		type.setType(Type.CLASSROOM_INSPECT);
		List<Attachment> attachList =attachmentService.classRoomDetailBycId(type);
		request.setAttribute("attList", attachList);
		model.addAttribute("classroom", classroomservice.getClassRoomById(classroomId));
		model.addAttribute("classroominspect", classroomservice.getInspectListByClassroom(classroomId));
		return "/admin/classroomInspectManager/viewclassroominspect";
	}
	
	/**
	 * 
	* @Title: toeditclassroominspect
	* @Description: (编辑调试项页面)
	* @param @param classroomId
	* @param @param model
	* @param @return
	* @return String    
	* @throws
	 */
	@RequestMapping("toeditclassroominspect")
	public String toeditclassroominspect(String classroomId,Model model,HttpServletRequest request){
		
		Type type = new Type();
		type.setClassRoomId(classroomId);
		type.setType(Type.CLASSROOM_INSPECT);
		List<Attachment> attachList =attachmentService.classRoomDetailBycId(type);
		request.setAttribute("attList", attachList);
		model.addAttribute("classroom", classroomservice.getClassRoomById(classroomId));
		model.addAttribute("classroominspect", classroomservice.getInspectListByClassroom(classroomId));
		return "/admin/classroomInspectManager/editclassroominspect";
	}
	
	/**
	 * 
	* @Title: finisheditclassroominspect
	* @Description: (完成编辑调试项)
	* @param @param classroomId
	* @param @param model
	* @param @return
	* @return String    
	* @throws
	 */
	
	
	@ResponseBody
	@RequestMapping("finisheditclassroominspect")
	public ResultJson finisheditclassroominspect(ClsClassroom classroom,HttpServletRequest request,String[] classroomInspectDetailId,String[] picDesc,String[] newFileName,String[] oraginalFileName){
		List<ClassroomInspectDetail> classroomInspectDetails = new ArrayList<ClassroomInspectDetail>();
		for (String id : classroomInspectDetailId) {
			ClassroomInspectDetail cd = new ClassroomInspectDetail();
			cd.setClassroomInspectDetailId(id);
			cd.setResult(request.getParameter("result"+id));
			classroomInspectDetails.add(cd);
		}
		List<Attachment> classRoomInspectList=null;
		if(newFileName!=null){
		  classRoomInspectList = new ArrayList<Attachment>();
		
		 for(int i=0; i<newFileName.length; i++){//将所有的文件的新名赋值到对象
			
			Attachment classRoomInspect = new Attachment();
			classRoomInspect.setRelationShipId(classroom.getClsClassroomId());
			classRoomInspect.setAttachment_Url(newFileName[i]);
			classRoomInspect.setName(oraginalFileName[i]);
			if(picDesc!=null&&picDesc.length>0){
				classRoomInspect.setRemark(picDesc[i].trim());
			}
			classRoomInspect.setType(Type.CLASSROOM_INSPECT);
			classRoomInspect.setCreate_time(new Date());
			classRoomInspect.setAttachmentId(UUIDUtils.getUUID());
			classRoomInspectList.add(classRoomInspect);
		}
		}
		return classroomservice.finisheditclassroominspect(classroom, classroomInspectDetails,classRoomInspectList);
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toShowEnvironment
		* @Description: (去展示环境勘察页面)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toshowenvironment")
	public String toShowEnvironment(String classroomId,Model model){
		model.addAttribute("classroom",classroomservice.getClassRoomById(classroomId));
		Map<String,Object>	map = classroomservice.getEnvirSurvey(classroomId);
		if (map != null){
			model.addAttribute("eSurvey",map.get("eSurvey"));
		    model.addAttribute("attachments",map.get("attach"));
		}
		return "admin/classroomInspectManager/viewenvironmentreport";
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
	@RequestMapping("getattachments")
	public Page  getAttachments(String classroomId,Page page){
		return classroomservice.getEnvirSurveys(classroomId,page);
		
	}
	
	
	
	
	
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toEditEnvironment
		* @Description: (去编辑环境勘察页面)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toeditenvironment")
	public String toEditEnvironment(String classroomId,Model model){
		model.addAttribute("classroom",classroomservice.getClassRoomById(classroomId));
	    Map<String,Object>  map = classroomservice.getEnvirSurvey(classroomId);
	    if(map != null){
	       model.addAttribute("eSurvey",map.get("eSurvey"));
	       model.addAttribute("attachments",map.get("attach"));
	    }
		return "admin/classroomInspectManager/editenvironmentreport";
		
	}
	/**
	 * 
		* @author zhangshuangquan
		* @Title: editEnvironmentReport
		* @Description: (编辑环境勘察报告)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("editenvironmentreport")
	public ResultJson editEnvironmentReport(EnvironmentSurvey environmentSurvey,String[] picDesc,String[] newFileName, String[] oraginalFileName){
		return classroomservice.editEnvirSurvey(environmentSurvey,picDesc,newFileName,oraginalFileName);
		
	}
	
	@RequestMapping("toeditpicture")
	public String toeditpicture(String classRoomId,HttpServletRequest request){
		Type type = new Type();
		type.setClassRoomId(classRoomId);
		type.setType(Type.CLASSROOM_DETAIL);
		List<Attachment> attachList = attachmentService.classRoomDetailBycId(type);
		request.setAttribute("attList", attachList);
		return "admin/classroomInspectManager/editPicture";
		
	}
	
	@RequestMapping("toviewpicture")
	public String toviewpicture(String classRoomId,HttpServletRequest request){
		Type type = new Type();
		type.setClassRoomId(classRoomId);
		type.setType(Type.CLASSROOM_DETAIL);
		List<Attachment> attachList = attachmentService.classRoomDetailBycId(type);
		request.setAttribute("attList", attachList);
		return "admin/classroomInspectManager/viewPicture";
	}
	
	@RequestMapping("toeditphoto")
	public String toeditphoto(){
		return "admin/classroomInspectManager/editPhoto";
	}
	
	@RequestMapping("toviewphoto")
	public String toviewphoto(String flag, String identify, String classroomId, String envirSurveyId, Model model){
		if("back".equals(flag)){
			JSONArray attachList = null;
			if("envir".equals(identify)){
				List<Attachment> attachments = attachmentService.getAttachByRelationshipId(envirSurveyId);
			    attachList = JSONArray.fromObject(attachments);
			}
			if("detail".equals(identify)){
				Type type = new Type();
				type.setClassRoomId(classroomId);
				type.setType(Type.CLASSROOM_DETAIL);
				List<Attachment> attachments = attachmentService.classRoomDetailBycId(type);
				attachList = JSONArray.fromObject(attachments);
			}
			if("inspect".equals(identify)){
				Type type = new Type();
				type.setClassRoomId(classroomId);
				type.setType(Type.CLASSROOM_INSPECT);
				List<Attachment> attachments = attachmentService.classRoomDetailBycId(type);
				attachList = JSONArray.fromObject(attachments);
			}
			model.addAttribute("attachment", attachList);
			model.addAttribute("flag", flag);
		}
		model.addAttribute("flag", flag);
		return "admin/classroomInspectManager/viewPhoto";
	}
}
