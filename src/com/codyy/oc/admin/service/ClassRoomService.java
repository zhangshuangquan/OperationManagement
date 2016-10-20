package com.codyy.oc.admin.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ExcelAnnocationUtils;
import com.codyy.commons.utils.OracleKeyWordUtils;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.AttachmentMapper;
import com.codyy.oc.admin.dao.ClassroomInspectDetailMapper;
import com.codyy.oc.admin.dao.ClsClassroomMapper;
import com.codyy.oc.admin.dao.ClsSchoolMapper;
import com.codyy.oc.admin.dao.EnvironmentSurveyMapper;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.entity.ClassroomInspectDetail;
import com.codyy.oc.admin.entity.ClsClassroom;
import com.codyy.oc.admin.entity.EnvironmentSurvey;
import com.codyy.oc.admin.entity.Type;
import com.codyy.oc.admin.view.ClsClassRoomEnvirView;
import com.codyy.oc.admin.view.ClsClassRoomInspectView;
import com.codyy.oc.admin.view.ClsClassroomSearch;
import com.codyy.oc.admin.view.StringExceptionHandler;

@Service
public class ClassRoomService {

	 @Autowired
	 private ClsClassroomMapper classroomMapper;
	
	 @Autowired
	 private ClassroomInspectDetailMapper classroomInspectDetailMapper;
	 

	 @Autowired
	 private EnvironmentSurveyMapper   environmentSurvryMapper;
	 
	 @Autowired
	 private AttachmentMapper  attachmentMapper;
	 
	 @Autowired
	 private ClsSchoolMapper clsSchoolMapper;
	 

	
	 public ResultJson addClassRoom(ClsClassroom classroom){
		 try{
			 String name=classroom.getRoomName().trim();
			 String uuid = UUIDUtils.getUUID();
			 classroom.setClsClassroomId(uuid);
			 classroom.setCreateTime(new Date());
			 classroom.setUpdateTime(new Date());
			 classroom.setRoomName(name);
			 classroomMapper.insertSelective(classroom);
			 classroomInspectDetailMapper.insertByClassroomId(uuid);
			 //更新进度
			 classroomMapper.updateExplorationPress(uuid);
			 classroomMapper.updateInstallPress(uuid);
			 classroomMapper.updateInspectPress(uuid);
			 return new ResultJson(true);
		 }catch(Exception e){
			 e.printStackTrace();
			 return new ResultJson(false);
		 }
	 }
	 
	
	 public ResultJson editClassRoom(ClsClassroom classroom,List<Attachment> classRoomDetailList){
		 try{
			 if(null!=classRoomDetailList && classRoomDetailList.size()>0){
				 //先删除再添加
				 classroom.setType("CLASSROOM_DETAIL");
				 classroomMapper.updateByPrimaryKeySelective(classroom);
				 Type type = new Type();
				 type.setClassRoomId(classroom.getClsClassroomId());
				 type.setType("CLASSROOM_DETAIL");
				 attachmentMapper.delClassRoomDetail(type);
				 attachmentMapper.insertQualification(classRoomDetailList); 
			 }else{
				 //如果全删完即只执行删除操作
				 classroom.setType("CLASSROOM_DETAIL");
				 classroomMapper.updateByPrimaryKeySelective(classroom);
				 Type type = new Type();
				 type.setClassRoomId(classroom.getClsClassroomId());
				 type.setType("CLASSROOM_DETAIL");
				 attachmentMapper.delClassRoomDetail(type);
			 }
			
			 //更新进度
			 classroomMapper.updateInstallPress(classroom.getClsClassroomId());
			 
			 return new ResultJson(true);
		 }catch(Exception e){
			 e.printStackTrace();
			 return new ResultJson(false);
		 }
	 }
	 
	 
	 public ResultJson editClassRooms(ClsClassroom classroom){
		 try{
			 String name=classroom.getRoomName().trim();
			 classroom.setRoomName(name);
			 classroomMapper.updateByPrimaryKeySelective(classroom);
			 return new ResultJson(true);
		 }catch(Exception e){
			 e.printStackTrace();
			 return new ResultJson(false);
		 }
	 }
	 
	 public ResultJson delClassRoom(String classroomId){
		 try{
			int i=classroomMapper.getEnvirCountByRoomId(classroomId);
			if(i>0){
				classroomMapper.deleteAttachByRoomId(classroomId);
				classroomMapper.deleteEnvirByRoomId(classroomId);
			}
			ClsClassroom cls = classroomMapper.selectByPrimaryKey(classroomId);
			classroomMapper.deleteByPrimaryKey(classroomId);
			
			//更新进度
			clsSchoolMapper.updateExplorationPress(cls.getClsSchoolId());
			clsSchoolMapper.updateInstallPress(cls.getClsSchoolId());
			clsSchoolMapper.updateInspectPress(cls.getClsSchoolId());
			
			 return new ResultJson(true);
		 }catch(Exception e){
			 e.printStackTrace();
			 return new ResultJson(false);
		 }
	 }
	 
	 
	 public Page getClassRoomList(ClsClassroomSearch search,Page page,String sortDesc){
		 Map<String,Object> map = new HashMap<String, Object>();

		 String projectAreaId=search.getProjectAreaId();
		 String clsSchoolAreaId=search.getClsSchoolAreaId();
		 if("".equals(projectAreaId)){
			 projectAreaId=null;
		 }
		 if("".equals(clsSchoolAreaId)){
			 
			 clsSchoolAreaId=null;
		 }
		 map.put("projectAreaId", projectAreaId);
		 map.put("clsSchoolAreaId", clsSchoolAreaId);
		 map.put("projectAreaId", "".equals(search.getProjectAreaId())?null:search.getProjectAreaId());
		 map.put("clsSchoolAreaId","".equals(search.getClsSchoolAreaId())?null:search.getClsSchoolAreaId());
		 map.put("projectName", OracleKeyWordUtils.oracleKeyWordReplace(search.getProjectName()));
		 map.put("clsSchoolName", OracleKeyWordUtils.oracleKeyWordReplace(search.getClsSchoolName()));
		 map.put("implementationProgress",search.getImplementationProgress());
		 map.put("isTrain", search.getIsTrain());
		 map.put("isStart", search.getIsStart());
		 map.put("sortDesc", sortDesc);
		 map.put("installDesc", search.getInstallDesc());
		 map.put("updateDesc", search.getUpdateDesc());
		 map.put("isExplore", search.getIsExplore()); //获取是否是 环境勘查的 教师列表
		 page.setMap(map);
		 List<ClsClassroom> ls = classroomMapper.getClassRoomPageList(page);
		 page.setData(ls);
		 return page;
	 }
	 
	 public ClsClassroom getClassRoomById(String classroomId){
		 return classroomMapper.selectByPrimaryKey(classroomId);
	 }
	 
	 /**
	  * 
	 * @Title: exportClassroomList
	 * @Description: (导出教室列表)
	 * @param @param search
	 * @param @return
	 * @return HSSFWorkbook    
	 * @throws
	  */
	 public HSSFWorkbook exportClassroomList(ClsClassroomSearch search,String sortDesc) {
		 Map<String,Object> map = new HashMap<String, Object>();

		 String projectAreaId=search.getProjectAreaId();
		 String clsSchoolAreaId=search.getClsSchoolAreaId();
		 if("".equals(projectAreaId)){
			 projectAreaId=null;
		 }
		 if("".equals(clsSchoolAreaId)){
			 clsSchoolAreaId=null;
		 }
		 map.put("projectAreaId", projectAreaId);
		 map.put("clsSchoolAreaId", clsSchoolAreaId);
		 map.put("projectName", OracleKeyWordUtils.oracleKeyWordReplace(search.getProjectName()));
		 map.put("clsSchoolName", OracleKeyWordUtils.oracleKeyWordReplace(search.getClsSchoolName()));
		 map.put("projectAreaId","".equals(search.getProjectAreaId())?null:search.getProjectAreaId());
		 map.put("clsSchoolAreaId","".equals(search.getClsSchoolAreaId())?null:search.getClsSchoolAreaId());
		 map.put("projectName", OracleKeyWordUtils.oracleKeyWordReplace(search.getProjectName().trim()));
		 map.put("clsSchoolName", OracleKeyWordUtils.oracleKeyWordReplace(search.getClsSchoolName().trim()));
		 map.put("implementationProgress",search.getImplementationProgress());
		 map.put("isTrain", search.getIsTrain());
		 map.put("isStart", search.getIsStart());
		 map.put("sortDesc", sortDesc);
		 map.put("installDesc", search.getInstallDesc());
		 map.put("updateDesc", search.getUpdateDesc());
		 List<ClsClassroom> ls = classroomMapper.getClassRoomList(map);
		 for (ClsClassroom room : ls) {
			room.getUpdateTimes();
			room.getExplorationReport();
			room.getInspectProcess();
			room.getInstallProcess();
		}
		return ExcelAnnocationUtils.exportExcelData(ClsClassroom.class,ls);
	 }
	 
	 /**
	  * 
	 * @Title: exportClassroomListInspect
	 * @Description: (导出调试状态列表)
	 * @param @param search
	 * @param @return
	 * @return HSSFWorkbook    
	 * @throws
	  */
	 public HSSFWorkbook exportClassroomListInspect(ClsClassroomSearch search,String sortDesc) {
		 if("".equals(search.getProjectAreaId())){
			 search.setProjectAreaId(null);
		 }
		 if("".equals(search.getClsSchoolAreaId())){
			 search.setClsSchoolAreaId(null);
		 }
		 Map<String,Object> map = new HashMap<String, Object>();
		 map.put("projectAreaId", search.getProjectAreaId());
		 map.put("clsSchoolAreaId", search.getClsSchoolAreaId());
		 map.put("projectName", OracleKeyWordUtils.oracleKeyWordReplace(search.getProjectName().trim()));
		 map.put("clsSchoolName", OracleKeyWordUtils.oracleKeyWordReplace(search.getClsSchoolName().trim()));
		 map.put("sortDesc", sortDesc);
		 List<ClsClassroom> ls = classroomMapper.getClassRoomList(map);
		 List<ClsClassRoomInspectView> vs = new ArrayList<ClsClassRoomInspectView>();
		 for (ClsClassroom c : ls) {
			 ClsClassRoomInspectView v = new ClsClassRoomInspectView();
			 v.setRoomName(c.getRoomName());
			 v.setRoomType(c.getRoomType());
			 v.setSchoolArea(c.getSchoolArea());
			 v.setClsSchoolName(c.getClsSchoolName());
			 v.setProjectName(c.getProjectName());
			 v.setContactPersonName(c.getContactPersonName());
			 v.setContactPersonPhone(c.getContactPersonPhone());
			 v.setInstallProcess(c.getInstallProcess());
			 v.setInspectProcess(c.getInspectProcess());
			 vs.add(v);
		 }
		return ExcelAnnocationUtils.exportExcelData(ClsClassRoomInspectView.class,vs);
	 }
	
	 /**
	  * 
	 * @Title: exportClassroomListInspect
	 * @Description: (导出环境勘察列表)
	 * @param @param search
	 * @param @return
	 * @return HSSFWorkbook    
	 * @throws
	  */
	 public HSSFWorkbook exportClassroomListEnvir(ClsClassroomSearch search) {
		 Map<String,Object> map = new HashMap<String, Object>();
		 String projectAreaId=search.getProjectAreaId();
		 String clsSchoolAreaId=search.getClsSchoolAreaId();
		 if("".equals(projectAreaId)){
			 projectAreaId=null; 
		 }
		 if("".equals(clsSchoolAreaId)){
			 clsSchoolAreaId=null;
		 }
		 map.put("projectAreaId", projectAreaId);
		 map.put("clsSchoolAreaId", clsSchoolAreaId);
		 map.put("projectName", OracleKeyWordUtils.oracleKeyWordReplace(search.getProjectName()));
		 map.put("clsSchoolName", OracleKeyWordUtils.oracleKeyWordReplace(search.getClsSchoolName()));
		 map.put("implementationProgress", search.getImplementationProgress());
		 map.put("isTrain", search.getIsTrain());
		 map.put("isStart", search.getIsStart());
		 map.put("isExplore", search.getIsExplore());
		 List<ClsClassroom> ls = classroomMapper.getClassRoomList(map);
		 List<ClsClassRoomEnvirView> vs = new ArrayList<ClsClassRoomEnvirView>();
		 for (ClsClassroom c : ls) {
			 ClsClassRoomEnvirView v = new ClsClassRoomEnvirView();
			 v.setRoomName(c.getRoomName());
			 v.setRoomType(c.getRoomType());
			 v.setSchoolArea(c.getSchoolArea());
			 v.setClsSchoolName(c.getClsSchoolName());
			 v.setProjectName(c.getProjectName());
			 v.setContactPersonName(c.getContactPersonName());
			 v.setContactPersonPhone(c.getContactPersonPhone());
			 v.setExplorationReport(c.getExplorationReport());
			 v.setUpdateTime(c.getExplorationTime());
			 v.getUpdateTimeStr();
			 vs.add(v);
		 }
		return ExcelAnnocationUtils.exportExcelData(ClsClassRoomEnvirView.class,vs);
	 }
	
	 public List<ClassroomInspectDetail> getInspectListByClassroom(String classroomId){
		return classroomInspectDetailMapper.getInspectListByClassroom(classroomId);
	 }
	 
	 
	 public ResultJson finisheditclassroominspect(ClsClassroom classroom,List<ClassroomInspectDetail> classroomInspectDetails,List<Attachment> classRoomInspectList){
		 classroom.setType("CLASSROOM_INSPECT");
		 classroomMapper.updateByPrimaryKeySelective(classroom);
		 classroomInspectDetailMapper.updateClassroomInspectDetailBatch( classroomInspectDetails);
		 Type type = new Type();
		 type.setClassRoomId(classroom.getClsClassroomId());
		 type.setType("CLASSROOM_INSPECT");
		 attachmentMapper.delClassRoomDetail(type);
		 //attachmentMapper.insertQualification(classRoomInspectList);
		 if(classRoomInspectList!=null&&classRoomInspectList.size()>0){
			 attachmentMapper.addAttachment(classRoomInspectList); 
		 }
		 
		 //更新进度
		 classroomMapper.updateInspectPress(classroom.getClsClassroomId());
		 return new ResultJson(true);
	 }

	 /**
	 * @param oraginalFileName 
	 * @param newFileName 
	  * 
	 	* @author zhangshuangquan
	 	* @Title: editEnvirSurvey
	 	* @Description: (编辑环境环境调查表)
	 	* @param @return    设定文件
	 	* @return String    返回类型
	 	* @throws
	  */
	public ResultJson editEnvirSurvey(EnvironmentSurvey environmentSurvey,String[] picDesc,String[] newFileName, String[] oraginalFileName) {
		try {

		String classroomId=environmentSurvey.getClsClassroomId();
		environmentSurvey.setUpdateTime(new Date());
	    boolean flag=true;
	    EnvironmentSurvey eSurvey=environmentSurvryMapper.getEnvirSurvey(classroomId);
	    String uuid = null;
		if(eSurvey==null){
			uuid = UUIDUtils.getUUID();
		}else {
			uuid = eSurvey.getEnvirSurveyId();
			flag=false;
		}
		environmentSurvey.setEnvirSurveyId(uuid);
		List<Attachment> attachments = null;
		if(newFileName != null&&newFileName.length>0){
			attachments = new ArrayList<Attachment>();
			for(int i=0; i<newFileName.length; i++){//将所有的文件的新名赋值到对象
				Attachment attachment = new Attachment();
				attachment.setAttachmentId(UUIDUtils.getUUID());
				if(flag){
					attachment.setRelationShipId(environmentSurvey.getEnvirSurveyId());	
				}else {
					attachment.setRelationShipId(environmentSurvey.getEnvirSurveyId());
				}
				attachment.setAttachment_Url(newFileName[i]);
				attachment.setName(oraginalFileName[i]);
				if(picDesc!=null&&picDesc.length>0){
					attachment.setRemark(picDesc[i].trim());
				}
				attachment.setCreateTime(new Date());
				attachment.setType("EnvironmentSurvey");
				attachments.add(attachment);
			}
		}
		if(flag){
		   environmentSurvryMapper.insertSelective(environmentSurvey);
	       if(newFileName!=null&&newFileName.length>0){
	    	   attachmentMapper.addAttachment(attachments); 
	       }
	       //更新进度
	       classroomMapper.updateExplorationPress(classroomId);
	       return new ResultJson(true, "编辑成功！");
		}else{
			environmentSurvryMapper.updateByPrimaryKeySelective(environmentSurvey);
			if(newFileName!=null&&newFileName.length>0){
				attachmentMapper.deleteAttachment(eSurvey.getEnvirSurveyId());
				attachmentMapper.addAttachment(attachments);
			}else{
				List<Attachment> attach=attachmentMapper.getAttachByRelationshipId(eSurvey.getEnvirSurveyId());
			    if(attach!=null&&attach.size()>0){
			    	attachmentMapper.deleteAttachment(eSurvey.getEnvirSurveyId());
			    }
			}
		    //更新进度
		    classroomMapper.updateExplorationPress(classroomId);
			return new ResultJson(true, "编辑成功！");
		}} catch (Exception e) {
			return  StringExceptionHandler.handlerException(e);
		}
	
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: getEnvirSurvey
		* @Description: (获得环境测试表以及应的附件)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	public Map<String,Object> getEnvirSurvey(String classroomId) {
		Map<String,Object>  map=new HashMap<String, Object>();
		EnvironmentSurvey  eSurvey = environmentSurvryMapper.getEnvirSurvey(classroomId);
	    if(eSurvey != null){
	    	List<Attachment> attachments = attachmentMapper.getAttachByRelationshipId(eSurvey.getEnvirSurveyId());
	    	map.put("eSurvey",eSurvey);
	    	map.put("attach",attachments);
	    }
		return map;
	}


	public Page getEnvirSurveys(String classroomId, Page page) {
		Map<String,Object>  map=new HashMap<String, Object>();
		EnvironmentSurvey  eSurvey=environmentSurvryMapper.getEnvirSurvey(classroomId);
		if(eSurvey!=null){
	     map.put("relationShipId", eSurvey.getEnvirSurveyId());
		 page.setMap(map);
		 List<Attachment> attachments=attachmentMapper.getAttachByRelationshipIdsPageList(page);
		 page.setData(attachments);
		 return page;
		}
		return null;
	}
}
