package com.codyy.oc.admin.dao;

import java.util.List;

import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.entity.ClassroomInspectDetail;
import com.codyy.oc.admin.entity.EnvironmentSurvey;

public interface ClassroomInspectDetailMapper {
    int deleteByPrimaryKey(String classroomInspectDetailId);

    int insert(ClassroomInspectDetail record);

    int insertSelective(ClassroomInspectDetail record);

    ClassroomInspectDetail selectByPrimaryKey(String classroomInspectDetailId);

    int updateByPrimaryKeySelective(ClassroomInspectDetail record);

    int updateByPrimaryKey(ClassroomInspectDetail record);
    
    /**
     * 
    * @Title: insertByClassroomId
    * @Description: (根据教室ID插入检测明细ID)
    * @param @param id
    * @param @return
    * @return int    
    * @throws
     */
    int insertByClassroomId(String id);
    
    /**
     * 
    * @Title: getInspectListByClassroom
    * @Description: (获取教室的调试明细列表)
    * @param @param classroomId
    * @param @return
    * @return List<ClassroomInspectDetail>    
    * @throws
     */
    List<ClassroomInspectDetail> getInspectListByClassroom(String classroomId);
    
    /**
     * 
    * @Title: updateBatch
    * @Description: (批量更新调试记录详情)
    * @param @param classroomInspectDetails
    * @return void    
    * @throws
     */
    
    void updateClassroomInspectDetailBatch(List<ClassroomInspectDetail> classroomInspectDetails);

	Integer addEnvirSurvey(EnvironmentSurvey environmentSurvey,
			List<Attachment> attachments);

	void addAttachmnet(List<Attachment> attachments);
}