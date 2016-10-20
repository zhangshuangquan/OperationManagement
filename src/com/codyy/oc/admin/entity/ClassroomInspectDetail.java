package com.codyy.oc.admin.entity;

import java.util.Date;

public class ClassroomInspectDetail {
    private String classroomInspectDetailId;

    private String classroomInspectId;

    private String clsClassroomId;

    private String result;

    private Date updateTime;
    
    private ClassroomInspect classroomInspect;//明细详情
    
    public ClassroomInspect getClassroomInspect() {
		return classroomInspect;
	}

	public void setClassroomInspect(ClassroomInspect classroomInspect) {
		this.classroomInspect = classroomInspect;
	}

	public String getClassroomInspectDetailId() {
        return classroomInspectDetailId;
    }

    public void setClassroomInspectDetailId(String classroomInspectDetailId) {
        this.classroomInspectDetailId = classroomInspectDetailId;
    }

    public String getClassroomInspectId() {
        return classroomInspectId;
    }

    public void setClassroomInspectId(String classroomInspectId) {
        this.classroomInspectId = classroomInspectId;
    }

    public String getClsClassroomId() {
        return clsClassroomId;
    }

    public void setClsClassroomId(String clsClassroomId) {
        this.clsClassroomId = clsClassroomId;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}