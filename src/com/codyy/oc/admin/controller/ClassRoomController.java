package com.codyy.oc.admin.controller;

import java.io.OutputStream;

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
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.ClsClassroom;
import com.codyy.oc.admin.service.ClassRoomService;
import com.codyy.oc.admin.view.ClsClassroomSearch;

@Controller
@RequestMapping("/admin/classroom/")
public class ClassRoomController {

	@Autowired
	private ClassRoomService classroomservice;
	
	/**
	 * 
	* @Title: toadd
	* @Description: (添加教室页面)
	* @param @return
	* @return String    
	* @throws
	 */
	@RequestMapping("toadd")
	public String toadd(){
		return "/admin/classroomManager/addclassroom";
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
		return "/admin/classroomManager/classroomlist";
	}
	
	/**
	 * 
	* @Title: finishadd
	* @Description: (添加教室)
	* @param @param classroom
	* @param @return
	* @return ResultJson    
	* @throws
	 */
	@ResponseBody
	@RequestMapping("finishadd")
	public ResultJson finishadd(ClsClassroom classroom,HttpServletRequest request){
		AdminUser adminUser = (AdminUser) request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
		classroom.setCreateUser(adminUser.getAdminUserId());
		return classroomservice.addClassRoom(classroom);
	}
	
	/**
	 * 
	* @Title: finishedit
	* @Description: (编辑教室)
	* @param @param classroom
	* @param @return
	* @return ResultJson    
	* @throws
	 */
	@ResponseBody
	@RequestMapping("finishedit")
	public ResultJson finishedit(ClsClassroom classroom,HttpServletRequest request){
		return classroomservice.editClassRooms(classroom);
	}
	
	/**
	 * 
	* @Title: delClassroom
	* @Description: (删除教室)
	* @param @param classroomId
	* @param @return
	* @return ResultJson    
	* @throws
	 */
	@ResponseBody
	@RequestMapping("delclassroom")
	public ResultJson delClassroom(String classroomId){
		return classroomservice.delClassRoom(classroomId);
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
	* @Title: viewClassroom
	* @Description: (查看教室信息)
	* @param @param classroomId
	* @param @param model
	* @param @return
	* @return String    
	* @throws
	 */
	@RequestMapping("viewclassroom")
	public String viewClassroom(String classroomId,Model model){
		model.addAttribute("classroom", classroomservice.getClassRoomById(classroomId));
		return "/admin/classroomManager/viewclassroom";
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
		model.addAttribute("classroom", classroomservice.getClassRoomById(classroomId));
		return "/admin/classroomManager/viewclassroomdetail";
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
		return "/admin/classroomManager/editclassroom";
	}
	
	/**
	 * 
	* @Title: exportProjectList
	* @Description: (导出教室列表)
	* @param @param clsClassroomSearch
	* @param @param response
	* @return void    
	* @throws
	 */
	@RequestMapping("exportclassroomlist")
	public void exportProjectList(ClsClassroomSearch clsClassroomSearch,HttpServletResponse response,String sortDesc){
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment; filename=exportclassroomList.xls");
		try {
			OutputStream out = response.getOutputStream();
			HSSFWorkbook workbook=classroomservice.exportClassroomList(clsClassroomSearch,sortDesc);
			workbook.write(out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
