package com.codyy.oc.admin.dao;

import java.util.List;
import java.util.Map;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.ClsClassroom;

public interface ClsClassroomMapper {
	int deleteByPrimaryKey(String clsClassroomId);

	int insert(ClsClassroom record);

	int insertSelective(ClsClassroom record);

	ClsClassroom selectByPrimaryKey(String clsClassroomId);

	int updateByPrimaryKeySelective(ClsClassroom record);

	int updateByPrimaryKey(ClsClassroom record);
	
	List<ClsClassroom> getClassRoomPageList(Page page);
	
	List<ClsClassroom> getClassRoomList(Map<String,Object> map);

	Integer getClassRoomCountByProjectId(Map<String, Object> map);

	List<ClsClassroom> getClassRoomsByProjectId(Map<String, Object> map);

	Integer getEnvirCountByRoomId(String classroomId);

	void deleteEnvirByRoomId(String classroomId);

	void deleteAttachByRoomId(String classroomId);

	List<ClsClassroom> getClassRoomsByProjectIdPageList(Page page);

	void updateExplorationPress(String clsClassroomId);//更新教室，学校，项目勘察进度

	void updateInstallPress(String clsClassroomId);//更新教室，学校，项目安装进度
	
	void updateInspectPress(String clsClassroomId);//更新教室，学校，项目调试进度
	
}