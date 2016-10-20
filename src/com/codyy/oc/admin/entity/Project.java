package com.codyy.oc.admin.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.codyy.commons.CommonsConstant;


/**
 * 项目表
 * @author zhangshuangquan
 *
 */
public class Project {
	
	private String projectId;            //===项目Id
	private String projectName;          //===项目名称
	private String projectCode;          //===项目编号
	private String managerId;            //===项目经理
	private String deleteFlag = CommonsConstant.FLAG_NO ;			// === 删除状态
	private String createUserId;          //===项目创建人
	private String baseAreaId;            //地区编号
	
	private String supplyName;//提供商名字
	
	private BaseArea baseArea;//获得每个资源id对应的资源对象
	
	private Date   createTime;  //创建时间
	
	private String areaPath;
	
	private String managerName;
	private String managerContact;

	private Date planBeginTime;  //计划开始时间
	
	private Date planEndTime;    //计划结束时间
	
	private Date implementBeginTime;  //实施开始时间
	
	private Date implementEndTime;    //实施结束时间
	
	private Date updateTime;           //更新时间
	

	public String getManagerName() {
		return managerName;
	}
	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}
	public String getManagerContact() {
		return managerContact;
	}
	public void setManagerContact(String managerContact) {
		this.managerContact = managerContact;
	}
	public String getAreaPath() {
		return areaPath;
	}
	public void setAreaPath(String areaPath) {
		this.areaPath = areaPath;
	}
	public BaseArea getBaseArea() {
		return baseArea;
	}
	public void setBaseArea(BaseArea baseArea) {
		this.baseArea = baseArea;
	}
	public String getSupplyName() {
		return supplyName;
	}
	public void setSupplyName(String supplyName) {
		this.supplyName = supplyName;
	}
	private List<Project> proList = new ArrayList<Project>();//获得所有的项目列表
	
	public List<Project> getProList() {
		return proList;
	}
	public void setProList(List<Project> proList) {
		this.proList = proList;
	}
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getProjectCode() {
		return projectCode;
	}
	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}
	public String getManagerId() {
		return managerId;
	}
	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}
	public String getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	public String getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}
	public String getBaseAreaId() {
		return baseAreaId;
	}
	public void setBaseAreaId(String baseAreaId) {
		this.baseAreaId = baseAreaId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getPlanBeginTime() {
		return planBeginTime;
	}
	public void setPlanBeginTime(Date planBeginTime) {
		this.planBeginTime = planBeginTime;
	}
	public Date getPlanEndTime() {
		return planEndTime;
	}
	public void setPlanEndTime(Date planEndTime) {
		this.planEndTime = planEndTime;
	}
	public Date getImplementBeginTime() {
		return implementBeginTime;
	}
	public void setImplementBeginTime(Date implementBeginTime) {
		this.implementBeginTime = implementBeginTime;
	}
	public Date getImplementEndTime() {
		return implementEndTime;
	}
	public void setImplementEndTime(Date implementEndTime) {
		this.implementEndTime = implementEndTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
}
