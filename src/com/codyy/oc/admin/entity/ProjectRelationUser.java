package com.codyy.oc.admin.entity;


/**
 * 项目-工程师
 * @author zhangshuangquan
 *
 */
public class ProjectRelationUser {
	
	private String projectRelationUserId;
	private String projectId;
	private String adminUserId;

	public String getProjectRelationUserId() {
		return projectRelationUserId;
	}
	public void setProjectRelationUserId(String projectRelationUserId) {
		this.projectRelationUserId = projectRelationUserId;
	}
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public String getAdminUserId() {
		return adminUserId;
	}
	public void setAdminUserId(String adminUserId) {
		this.adminUserId = adminUserId;
	}

	
	

}
