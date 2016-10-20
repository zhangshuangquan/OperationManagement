package com.codyy.oc.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ExcelAnnocationUtils;
import com.codyy.commons.utils.OracleKeyWordUtils;
import com.codyy.commons.utils.ResultJson;
import com.codyy.oc.admin.dao.AttachmentMapper;
import com.codyy.oc.admin.dao.RegRProjectMapper;
import com.codyy.oc.admin.dao.RegionalResourceMapper;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.entity.Project;
import com.codyy.oc.admin.entity.RegRProject;
import com.codyy.oc.admin.entity.RegionalResource;
import com.codyy.oc.admin.view.RegionalResourceSearch;

@Service
public class RegionalResourceService {

	 @Autowired
	 private RegionalResourceMapper regionalResourceMapper;
	 
	 @Autowired
	 private RegRProjectMapper regRProjectMapper;
	 
	 @Autowired
	 private AttachmentMapper qualificationMapper;
	
	 /**
	  * @author lichen
	 * @Title: insertAreaResource
	 * @Description: (添加资源模块的实现)
	 * @param @param record
	 * @param @return    设定文件
	 * @return Integer    返回类型
	 * @throws
	  */
	 public ResultJson insertAreaResource(RegionalResource record,RegRProject regRProject,List<Attachment> attachMentList){
		 
		 try{
			 regionalResourceMapper.insertAreaResource(record);//添加地区资源信息
			 if(regRProject!=null && regRProject.getProjectIdList().size()>0){
				 regRProjectMapper.insertRegRProject(regRProject);//添加地区与项目关系  
			 }
			 if(attachMentList!=null && attachMentList.size()>0){
				  qualificationMapper.insertQualification(attachMentList); 
			  }
			 return new ResultJson(true);
		 }catch(Exception e){
			 e.printStackTrace();
			 return new ResultJson(false);
		 }
		 
	 }
	 
	 /**
	  * @author lichen
	 * @Title: selectAreaResourcePageList
	 * @Description: (进行多个条件的搜索查询)
	 * @param @param page
	 * @param @return    设定文件
	 * @return List<RegionalResource>    返回类型
	 * @throws
	  */
	 public List<RegionalResource> selectAreaResourcePageList(String baseAreaId,String name,String type,String contactPersonName,String contactPersonPhone,String projectName,Page page){
		 Map<String,Object> map = new HashMap<String,Object>();//变量名map必须和Page类中声明的Map属性一致
		 map.put("baseAreaId", baseAreaId);
		 map.put("name", OracleKeyWordUtils.oracleKeyWordReplace(name));
		 map.put("type", type);
		 map.put("contactPersonName", OracleKeyWordUtils.oracleKeyWordReplace(contactPersonName));
		 map.put("contactPersonPhone", OracleKeyWordUtils.oracleKeyWordReplace(contactPersonPhone));//避免输入%进行查询
		 map.put("projectName", OracleKeyWordUtils.oracleKeyWordReplace(projectName));
		 page.setMap(map);//将需要处理的条件查询参数进行封装
		 return regionalResourceMapper.selectAreaResourcePageList(page);
	 }
	 
	 /**
	  * @author lichen
	 * @Title: deleteByPrimaryKey
	 * @Description: (根据id来删除对应的资源记录)
	 * @param @param regionalResourceId
	 * @param @return    设定文件
	 * @return int    返回类型
	 * @throws
	  */
	
	 @RequestMapping("deletearearesource")
	 public void deleteByPrimaryKey(String regionalResourceId){
		  
		 regRProjectMapper.delResouceRProjectByResId(regionalResourceId);//删除id对应的资源表与项目关系表中的所有记录
		 regionalResourceMapper.deleteByPrimaryKey(regionalResourceId);//删除区域资源基本信息
	 }
	 
	 /**
	  * @author lichen
	 * @Title: selcProjPageList
	 * @Description: (查询用户对应的项目名)
	 * @param @param resourceUser_Id
	 * @param @param page
	 * @param @return    设定文件
	 * @return List<Project>    返回类型
	 * @throws
	  */
	 public List<Project> selcProjPageList( String supplier_Id,Page page){
		 
		 Map<String,Object> map = new HashMap<String,Object>();
		 map.put("areaResurce_Id", supplier_Id);
		 page.setMap(map);
		 List<Project> proList=regionalResourceMapper.selcProjPageList(page);
		 return proList;
	 }
	 
	 
	 /**
	  * @author lichen
	 * @Title: selcRegResById
	 * @Description: (根据区域资源的id来获取对应资源对象的所有信息)
	 * @param @param RegionalResourceId
	 * @param @return    设定文件
	 * @return RegionalResource    返回类型
	 * @throws
	  */
	 public RegionalResource selcRegResById(String RegionalResourceId){
		 
		return regionalResourceMapper.selcRegResById(RegionalResourceId); 
	 }
	 
	 
	 /**
	  * @author lichen
	 * @Title: updateRegResource
	 * @Description: (这里用一句话描述这个方法的作用)
	 * @param @param regionalResource
	 * @param @return    设定文件
	 * @return Integer    返回类型
	 * @throws
	  */
	 public ResultJson updateRegResource(RegionalResource regionalResource,RegRProject regRProject,List<Attachment> qualifiList){
		 try{
			 
			 regionalResourceMapper.updateRegResource(regionalResource);//先修改用户的基本信息
			  regRProjectMapper.delResouceRProjectByResId(regionalResource.getRegionalResourceId());//删除本用户关联的所有项目
			  if(regRProject.getProjectIdList()!=null && regRProject.getProjectIdList().size()>0){
				  regRProjectMapper.insertRegRProject(regRProject);//重新进行添加操作  
			  }
			  qualificationMapper.deleteQualiBysuId(regionalResource.getRegionalResourceId());//根据区域资源的id删除已上传的所有文件
			  if(qualifiList!=null && qualifiList.size()>0){
			  qualificationMapper.insertQualification(qualifiList);//重新添加新的资源
			  }
			  return new ResultJson(true);
		 }catch(Exception e){
			 
			 e.printStackTrace();
			 return new ResultJson(false);
		 }
		  
	 }
	 
	 
	 /**
	  * @author lichen
	 * @Title: selcProById
	 * @Description: (根据资源的id来获取对应资源的所有项目列表)
	 * @param @param RegionalResourceId
	 * @param @return    设定文件
	 * @return List<Project>    返回类型
	 * @throws
	  */
	public List<Project> selcProById(String RegionalResourceId){
		
		 return regionalResourceMapper.selcProById(RegionalResourceId);
	 }
	
	/**
	 * @author lichen
	* @Title: exportResourceList
	* @Description: (导出资源列表)
	* @param @param resourceSearch
	* @param @return    设定文件
	* @return HSSFWorkbook    返回类型
	* @throws
	 */
	public HSSFWorkbook exportResourceList(RegionalResourceSearch resourceSearch){
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("baseAreaId", resourceSearch.getBaseAreaId());
		map.put("name", resourceSearch.getName());
		map.put("type", resourceSearch.getType());
		map.put("contactPersonName", resourceSearch.getContactPersonName());
		map.put("contactPersonPhone",resourceSearch.getContactPersonPhone());
		map.put("projectName", resourceSearch.getProjectName());
		List<RegionalResource> reList = regionalResourceMapper.exportRegionalResource(map);
		
		return ExcelAnnocationUtils.exportExcelData(RegionalResource.class, reList);
	}
}
