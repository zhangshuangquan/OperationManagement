package com.codyy.oc.admin.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ExcelAnnocationUtils;
import com.codyy.commons.utils.OracleKeyWordUtils;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.ClsClassroomMapper;
import com.codyy.oc.admin.dao.ClsSchoolMapper;
import com.codyy.oc.admin.dao.MaintenanceOrderMapper;
import com.codyy.oc.admin.dao.ProjectMapper;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.ClsClassroom;
import com.codyy.oc.admin.entity.ClsSchool;
import com.codyy.oc.admin.entity.ClsSchoolRUser;
import com.codyy.oc.admin.view.ClsSchoolSearch;
import com.codyy.oc.admin.view.StringExceptionHandler;

@Service
public class SchoolService {

	 @Autowired
	 private ClsSchoolMapper clsSchoolMapper;
	 
	 @Autowired
	 private ProjectMapper projectMapper;
	 
	 @Autowired
	 private AdminUserManagerService  adminUserManagerService;
	 
	 @Autowired
	 private ClsClassroomMapper classroomMapper;
	 
	 @Autowired
     private MaintenanceOrderMapper  mOrderMapper;
	 

	 /**
	  * 
	 * @Title: getProjectByArea
	 * @Description: (获取学校列表)
	 * @param @param projectId
	 * @param @param areaId
	 * @param @return
	 * @return List<ClsSchool>    
	 * @throws
	  */
	 public List<ClsSchool> getProjectByArea(String projectId,String areaId){
		 return clsSchoolMapper.getSchoolList(projectId, areaId);
	 }


    /**
     * 
    	* @author zhangshuangquan
    	* @Title: getEngineerList
    	* @Description: (获取学校可选的工程师)
    	* @param projectId    设定文件
    	* @return Map<String,Object>   返回类型
    	* @throws
     */
	public List<AdminUser> getEngineerList(String projectId) {
		if(projectId!=null&&!"-1".equals(projectId)){
		  List<AdminUser> engineerPro=projectMapper.getEngineerList(projectId);
		  return engineerPro;
		}
		return null;
	}


	/**
	 * 
		* @author zhangshuangquan
		* @Title: getSchoolByProjectId
		* @Description: (根据项目id获取相关学校并在项目列表中分页 显示)
		* @param projectId  start   end设定文件
		* @return Page    分页
		* @throws
	 */
	public Page getSchoolByProjectId(String projectId, Page page, String sortDesc) {
	    Map<String,Object> map=new HashMap<String, Object>();
	    map.put("sortDesc", sortDesc);
	    map.put("projectId",projectId);
		page.setMap(map);
	    List<ClsSchool>  school=clsSchoolMapper.getSchoolByProjectIdPageList(page);
	    page.setData(school);
		return page;
	}

	/**
	 * 
		* @author zhangshuangquan
		* @Title: getClassByProjectId
		* @Description: (在项目列表中显示教室并分页)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */

	public Page getClassByProjectId(String projectId, Page page, String sortDesc) {
		    Map<String,Object> map=new HashMap<String, Object>();
		    map.put("projectId",projectId);
		    map.put("sortDesc",sortDesc);
		    page.setMap(map);
		    List<ClsClassroom>  classrooms=classroomMapper.getClassRoomsByProjectIdPageList(page);
		    page.setData(classrooms);
			return page;
	}

    /**
     * 
    	* @author zhangshuangquan
    	* @Title: addSchool
    	* @Description: (添加学校)
    	* @param ClsSchool    设定文件
    	* @return ResultJson    返回类型
    	* @throws
     */
	public ResultJson addSchool(ClsSchool school) {
	  try{
		if(school!=null){
			boolean flag=false;
			school.setCreateTime(new Date());
			school.setUpdateTime(new Date());
			String uuid = UUIDUtils.getUUID();
			school.setClsSchoolId(uuid);
			List<ClsSchoolRUser>  clsSchoolRUsers=null;
			if(StringUtils.isNotBlank(school.getEngineer())){
				String[] str=school.getEngineer().split(",");
				clsSchoolRUsers=new ArrayList<ClsSchoolRUser>();
				for(int i=0;i<str.length;i++){
					ClsSchoolRUser cSchoolRUser=new ClsSchoolRUser();
				    cSchoolRUser.setSchoolRUserId(UUIDUtils.getUUID());
				    cSchoolRUser.setClsSchoolId(school.getClsSchoolId());
				    cSchoolRUser.setAdminUserId(str[i]);
				    clsSchoolRUsers.add(cSchoolRUser);
				}
				flag=true;
			}
				clsSchoolMapper.addSchool(school);
				if(flag){
				 clsSchoolMapper.addSchoolRUser(clsSchoolRUsers);
				}
				
				//更新进度
				clsSchoolMapper.updateExplorationPress(uuid);
				clsSchoolMapper.updateInstallPress(uuid);
				clsSchoolMapper.updateInspectPress(uuid);
				
				
				 return new ResultJson(true,"添加成功!");	
		}else {
			return new ResultJson(false,"添加失败!");
		}
	  }catch(Exception e){
			return StringExceptionHandler.handlerException(e);
		}
	}

    /**
     * 
    	* @author zhangshuangquan
    	* @Title: getSchoolList
    	* @Description: (展示学校列表)
    	* @param @return    设定文件
    	* @return String    返回类型
    	* @throws
     */
	public Page getSchoolLists(ClsSchoolSearch clsSchoolSearch,Page page,String sortDesc) {
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("projectAreaId", "".equals(clsSchoolSearch.getProjectAreaId())?null:clsSchoolSearch.getProjectAreaId());
		map.put("clsSchoolAreaId","".equals(clsSchoolSearch.getClsSchoolAreaId())?null:clsSchoolSearch.getClsSchoolAreaId());
		map.put("clsSchoolName",OracleKeyWordUtils.oracleKeyWordReplace(clsSchoolSearch.getClsSchoolName()));
		map.put("projectName",OracleKeyWordUtils.oracleKeyWordReplace(clsSchoolSearch.getProjectName()));
		map.put("sortDesc",sortDesc.trim());
		map.put("explorationDesc", clsSchoolSearch.getExplorationDesc());
		map.put("installDesc", clsSchoolSearch.getInstallDesc());
		map.put("updateDesc", clsSchoolSearch.getUpdateDesc());
		page.setMap(map);
		List<ClsSchool> clsSchools=clsSchoolMapper.getSchoolPageList(page);
		page.setData(clsSchools);
		return page;
	}
    
	/**
	 * 
		* @author zhangshuangquan
		* @Title: exportSchoolList
		* @Description: (导出全部学校列表)
		* @param ClsSchoolSearch
		* @return HSSFWorkbook    返回类型
		* @throws
	 */
	public HSSFWorkbook exportSchoolList(ClsSchoolSearch clsSchoolSearch,String sortDesc) {
		 Map<String,Object> map = new HashMap<String, Object>();
		 map.put("projectName", OracleKeyWordUtils.oracleKeyWordReplace(clsSchoolSearch.getProjectName()));
		 map.put("clsSchoolName", OracleKeyWordUtils.oracleKeyWordReplace(clsSchoolSearch.getClsSchoolName()));
		 map.put("projectAreaId","".equals(clsSchoolSearch.getProjectAreaId())?null:clsSchoolSearch.getProjectAreaId());
		 map.put("clsSchoolAreaId","".equals(clsSchoolSearch.getClsSchoolAreaId())?null:clsSchoolSearch.getClsSchoolAreaId());
		 map.put("projectName", OracleKeyWordUtils.oracleKeyWordReplace(clsSchoolSearch.getProjectName().trim()));
		 map.put("clsSchoolName", OracleKeyWordUtils.oracleKeyWordReplace(clsSchoolSearch.getClsSchoolName().trim()));
		 map.put("sortDesc", sortDesc);
		 map.put("explorationDesc", clsSchoolSearch.getExplorationDesc());
		 map.put("installDesc", clsSchoolSearch.getInstallDesc());
		 map.put("updateDesc", clsSchoolSearch.getUpdateDesc());
		 List<ClsSchool> clsSchools=clsSchoolMapper.exportSchoolList(map);
		 for (ClsSchool cls: clsSchools) {
			 cls.getUpdateTimes();
			 cls.getExplorationProcess();
			 cls.getInspectProcess();
			 cls.getInstallProcess();
		}
		return ExcelAnnocationUtils.exportExcelData(ClsSchool.class,clsSchools);
	}

    /**
     * 
    	* @author zhangshuangquan
    	* @Title: getSchoolById
    	* @Description: (编辑学校时通过学校id获得学校信息)
    	* @param schoolId    设定文件
    	* @return Map    返回类型
    	* @throws
     */
	public Map<String,Object> getSchoolById(String schoolId,String projectId) {
		if(StringUtils.isNotBlank(schoolId)){
			Map<String,Object> map=new HashMap<String, Object>();
			ClsSchool school=clsSchoolMapper.getSchoolById(schoolId);
			List<AdminUser>  engs=projectMapper.getEngineerList(projectId);
			List<AdminUser>  eng=clsSchoolMapper.getEngineerBySchoolId(schoolId);
			map.put("schools",school);
			map.put("engs",engs);
			map.put("eng",eng);
		    return map;
		}
		return null;
	}


	/**
	 * 
		* @author zhangshuangquan
		* @Title: editSchool
		* @Description: (编辑学校)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	public Map<String,Object> editSchool(ClsSchool school) {
		Map<String,Object>  map = new HashMap<String, Object>();
		try {

		if(school!=null){
			if(StringUtils.isNotBlank(school.getEngineer())){
				String[] str=school.getEngineer().split(",");
				List<ClsSchoolRUser>  clsSchoolRUsers=new ArrayList<ClsSchoolRUser>();
				for(int i=0;i<str.length;i++){
					ClsSchoolRUser cSchoolRUser=new ClsSchoolRUser();
				    cSchoolRUser.setSchoolRUserId(UUIDUtils.getUUID());
				    cSchoolRUser.setClsSchoolId(school.getClsSchoolId());
				    cSchoolRUser.setAdminUserId(str[i]);
				    clsSchoolRUsers.add(cSchoolRUser);
				}
				int i=clsSchoolMapper.checkSchoolEngineer(school.getClsSchoolId());
				if(i>0){
					
						int result=clsSchoolMapper.deleteSchoolRUser(school.getClsSchoolId());
						if(result>0){
							int j=clsSchoolMapper.updateSchool(school);
							if(j>0){
								 clsSchoolMapper.addSchoolRUser(clsSchoolRUsers);
								 map.put("result",new ResultJson(true,"编辑成功!"));
								 return map;
								}
							}
					
				}else{
					
						clsSchoolMapper.updateSchool(school);
					    clsSchoolMapper.addSchoolRUser(clsSchoolRUsers);
						map.put("result",new ResultJson(true,"编辑成功!"));
					    return map;
					
				}
				
			}else{
				//工程师为空
				int i=clsSchoolMapper.checkSchoolEngineer(school.getClsSchoolId());
				if(i>0){
					
						clsSchoolMapper.deleteSchoolRUser(school.getClsSchoolId());
						clsSchoolMapper.updateSchool(school);
						map.put("result",new ResultJson(true,"编辑成功!"));
						return map;
					
				}else{
					
						clsSchoolMapper.updateSchool(school);
						map.put("result",new ResultJson(true,"编辑成功!"));
						return map;
					
					
				}
			}
		}else{
			 map.put("result",new ResultJson(false,"编辑失败!"));
			 return map;
		}
		} catch (Exception e) {
			map.put("result",StringExceptionHandler.handlerException(e));
			return map;
		}
		return null;
	}


	/**
	 * 
		* @author zhangshuangquan
		* @Title: getClassRoomBySchoolId
		* @Description: (在学校列表中展示相应教室信息并分页显示)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	public Page getClassRoomBySchoolId(String schoolId, Page page,String sortDesc) {
		Map<String,Object> map = new HashMap<String, Object>();
		 map.put("clsSchoolId", schoolId);
		 map.put("sortDesc",sortDesc);
		 page.setMap(map);
		 List<ClsClassroom> classrooms =clsSchoolMapper.getClassRoomBySchoolIdPageList(page);
		 page.setData(classrooms);
		 return page;
	
	}

    /**
     * 
    	* @author zhangshuangquan
    	* @Title: getEngineerBySchoolId
    	* @Description: (在学校列表中显示该学校的工程师并分页)
    	* @param String schoolId, Page page   
    	* @return Page    返回类型
    	* @throws
     */
	public Page getEngineerBySchoolId(String schoolId, Page page) {
		Map<String,Object> map = new HashMap<String, Object>();
		 map.put("clsSchoolId", schoolId);
		 page.setMap(map);
		 List<AdminUser> engineers =clsSchoolMapper.getEngineerBySchoolIdPageList(page);
		 page.setData(engineers);
		 return page;
	}

    /**
     * 
    	* @author zhangshuangquan
    	* @Title: deleteSchoolById
    	* @Description: (通过学校id逻辑删除学校)
    	* @param clsSchoolId    设定文件
    	* @return ResultJson    返回类型
    	* @throws
     */
	public ResultJson deleteSchoolById(String clsSchoolId) {
		if(StringUtils.isNotBlank(clsSchoolId)){
			//检测该学校时候有工单
			if(mOrderMapper.checkWorkOrderBySchoolId(clsSchoolId)>0){
				return new ResultJson(false,"该学校下存在售后保障记录无法删除！");
			}
			//检测学校中是否有工程师
			if(clsSchoolMapper.checkSchoolEngineer(clsSchoolId)>0||clsSchoolMapper.checkClassroom(clsSchoolId)>0){
				return  new ResultJson(false,"该学校已经分配工程师或已经存在教室！");
			}else {
				ClsSchool cs = clsSchoolMapper.getSchoolById(clsSchoolId);
				int i=clsSchoolMapper.deleteSchoolById(clsSchoolId);
				if(i>0){
					//更新进度
					projectMapper.updateExplorationPress(cs.getProjectId());
					projectMapper.updateInstallPress(cs.getProjectId());
					projectMapper.updateInspectPress(cs.getProjectId());
					
					return  new ResultJson(true,"删除成功！");
				}
			}
		}else {
			return  new ResultJson(false,"删除失败！");
		}
		return null;
	}
	
}
