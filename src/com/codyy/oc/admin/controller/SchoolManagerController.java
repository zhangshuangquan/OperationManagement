package com.codyy.oc.admin.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ResultJson;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.ClsSchool;
import com.codyy.oc.admin.service.SchoolService;
import com.codyy.oc.admin.view.ClsSchoolSearch;

@Controller
@RequestMapping("/admin/schoolmanager/")
public class SchoolManagerController extends BaseController{
	
	@Autowired
	private SchoolService schoolservice;
	


	/**
	 * 
	* @Title: getSchoolList
	* @Description: （获取学校列表）
	* @param @param projectId
	* @param @param areaId
	* @param @return
	* @return List<ClsSchool>    
	* @throws
	 */
	@ResponseBody
	@RequestMapping("getschoollist")
	public List<ClsSchool> getSchoolList(String projectId,String areaId){
		return schoolservice.getProjectByArea(projectId, areaId);
	}
	
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toSchoolList
		* @Description: (学校列表展示页面)
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toschoollist")
	public String toSchoolList(){
		return "admin/schoolManager/schoolList";
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toAddSchool
		* @Description: (添加学校展示页面)
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toaddschool")
	public String toAddSchool(){
		return "admin/schoolManager/addSchool";
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: getEngineerList
		* @Description: (根据项目id获取工程师)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("getenginnerlist")
	public List<AdminUser> getEngineerList(String projectId){
		return schoolservice.getEngineerList(projectId);
		
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toShowSchool
		* @Description: (根据项目id获取学校)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toshowschool")
	public String toShowSchool(String projectId,HttpServletRequest request){
		if(StringUtils.isNotBlank(projectId)){
			request.setAttribute("projectId", projectId);
		}
		return "admin/schoolManager/showSchool";
		
	}
	/**
	 * 
		* @author zhangshuangquan
		* @Title: showSchool
		* @Description: (在项目列表中展示学校)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	
	@ResponseBody
	@RequestMapping("showschool")
	public Page showSchool(String projectId, Page page, String sortDesc){
		return schoolservice.getSchoolByProjectId(projectId,page,sortDesc);
		
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toShowClass
		* @Description: (在项目列表中展示教室)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toshowclass")
	public String toShowClass(String projectId,HttpServletRequest request){
		if(StringUtils.isNotBlank(projectId)){
			request.setAttribute("projectId",projectId);
		}
		return "admin/schoolManager/showClass";
		
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: showClass
		* @Description: (在项目列表中展示教室并分页)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("showclass")
	public Page showClass(String projectId, Page page, String sortDesc){
		return schoolservice.getClassByProjectId(projectId, page, sortDesc);
		
	}
    
	/**
	 * 
		* @author zhangshuangquan
		* @Title: addSchool
		* @Description: (添加学校)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("addschool")
	public ResultJson addSchool(ClsSchool school){
		return schoolservice.addSchool(school);
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: getSchoolList
		* @Description: (展示学校列表)
		* @param  clsSchoolSearch,start, end    设定文件
		* @return Page    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("getschoollists")
	public Page getSchoolLists(ClsSchoolSearch clsSchoolSearch,Page page, String sortDesc){
		return schoolservice.getSchoolLists(clsSchoolSearch, page, sortDesc);
		
	}
	
    /**
     * 
    	* @author zhangshuangquan
    	* @Title: exportSchoolList
    	* @Description: (导出学校列表)
    	* @param @return    设定文件
    	* @return String    返回类型
    	* @throws
     */
	@RequestMapping("exportschoollist")
	public  HSSFWorkbook exportSchoolList(ClsSchoolSearch clsSchoolSearch,HttpServletResponse response,String sortDesc){
		response.setContentType("application/x-msdownloas");
		response.setHeader("Content-Disposition", "attachment; filename=exportSchoolList.xls");
		
		try {
			OutputStream out = response.getOutputStream();
			HSSFWorkbook workbook=schoolservice.exportSchoolList(clsSchoolSearch,sortDesc);
			workbook.write(out);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
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

	@RequestMapping("toeditschool")
	public String toEditSchool(String schoolId,HttpServletRequest request,String projectId){
		request.setAttribute("edit",schoolservice.getSchoolById(schoolId,projectId));
		return "admin/schoolManager/editSchool";
		
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: editSchool
		* @Description: (编辑学校)
		* @param ClsSchool    设定文件
		* @return ResultJson    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("editschool")
	public Map<String,Object>  editSchool(ClsSchool clsSchool){
		return schoolservice.editSchool(clsSchool);
		
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toShowClassRoom
		* @Description: (在学校列表中展示该教室信息)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toshowclassroom")
	public String toShowClassRoom(String schoolId,HttpServletRequest request){
		if(StringUtils.isNotBlank(schoolId)){
			request.setAttribute("schoolId",schoolId);
		}
		return "admin/schoolManager/showClassRoom";
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: showClassRoom
		* @Description: (在学校列表中显示教室信息并分页)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@ResponseBody
    @RequestMapping("showclassroom")
	public Page showClassRoom(String clsSchoolId,Page page,String sortDesc){
		return schoolservice.getClassRoomBySchoolId(clsSchoolId,page,sortDesc);
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toShowEngineer
		* @Description: (在学校列表中显示工程师)
		* @param String schoolId,HttpServletRequest request    设定文件
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toshowengineer")
	public String toShowEngineer(String schoolId,HttpServletRequest request){
		if(StringUtils.isNotBlank(schoolId)){
			request.setAttribute("schoolId",schoolId);
		}
		return "admin/schoolManager/showEngineer";
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: showEngineer
		* @Description: (在学校列表中显示工程师并分页)
		* @param String schoolId,Page page
		* @return Page    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("showengineer")
	public Page showEngineer(String clsSchoolId,Page page){
		return schoolservice.getEngineerBySchoolId(clsSchoolId,page);
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: deleteSchoolById
		* @Description: (逻辑删除学校)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	@ResponseBody
	@RequestMapping("deleteschoolbyid")
	public ResultJson deleteSchoolById(String clsSchoolId){
		return schoolservice.deleteSchoolById(clsSchoolId);
	}
}
