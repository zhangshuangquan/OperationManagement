package com.codyy.oc.admin.view;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.codyy.oc.admin.entity.Equipment;
/**
 * 
 * @author lichen----售后详情列表显示
 *
 */
public class OrderDetailView {

	private String orderId;
	private String orderConcat;
	private String orderPhone;
	private Date orderCall;
	private Date orderProcess;
	private Date orderTask;
	private Date orderDoor;
	private Date orderSolve;
	private Date orderVisit;
	private String orderRemark;
	private String orderAddr;
	private String schoolName;
	private String schoolConcat;
	private String schoolPhone;
	private String schoolArea;
	private String projectName;
	private String projectArea;
	private String projectManager;
	private String projectConcat;
	private String order_Num;
	private String problem;
	private String problemSolving;
	private String realName;//创建用户的真实姓名
	private String createUserId;//创建工单的用户id

	public String getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	private List<Equipment> equpList = new ArrayList<Equipment>();
	
	private List<ProblemTypeView> problemTypeList = new ArrayList<ProblemTypeView>();
	
	public List<ProblemTypeView> getProblemTypeList() {
		return problemTypeList;
	}
	public void setProblemTypeList(List<ProblemTypeView> problemTypeList) {
		this.problemTypeList = problemTypeList;
	}
	public String getProblem() {
		return problem;
	}
	public void setProblem(String problem) {
		this.problem = problem;
	}
	public String getProblemSolving() {
		return problemSolving;
	}
	public void setProblemSolving(String problemSolving) {
		this.problemSolving = problemSolving;
	}
	public String getOrder_Num() {
		return order_Num;
	}
	public void setOrder_Num(String order_Num) {
		this.order_Num = order_Num;
	}
	
	
	
	public List<Equipment> getEqupList() {
		return equpList;
	}
	public void setEqupList(List<Equipment> equpList) {
		this.equpList = equpList;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getOrderConcat() {
		return orderConcat;
	}
	public void setOrderConcat(String orderConcat) {
		this.orderConcat = orderConcat;
	}
	public String getOrderPhone() {
		return orderPhone;
	}
	public void setOrderPhone(String orderPhone) {
		this.orderPhone = orderPhone;
	}
	public Date getOrderCall() {
		return orderCall;
	}
	public void setOrderCall(Date orderCall) {
		this.orderCall = orderCall;
	}
	public Date getOrderProcess() {
		return orderProcess;
	}
	public void setOrderProcess(Date orderProcess) {
		this.orderProcess = orderProcess;
	}
	public Date getOrderTask() {
		return orderTask;
	}
	public void setOrderTask(Date orderTask) {
		this.orderTask = orderTask;
	}
	public Date getOrderDoor() {
		return orderDoor;
	}
	public void setOrderDoor(Date orderDoor) {
		this.orderDoor = orderDoor;
	}
	public Date getOrderSolve() {
		return orderSolve;
	}
	public void setOrderSolve(Date orderSolve) {
		this.orderSolve = orderSolve;
	}
	public Date getOrderVisit() {
		return orderVisit;
	}
	public void setOrderVisit(Date orderVisit) {
		this.orderVisit = orderVisit;
	}
	public String getOrderRemark() {
		return orderRemark;
	}
	public void setOrderRemark(String orderRemark) {
		this.orderRemark = orderRemark;
	}
	public String getOrderAddr() {
		return orderAddr;
	}
	public void setOrderAddr(String orderAddr) {
		this.orderAddr = orderAddr;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	public String getSchoolConcat() {
		return schoolConcat;
	}
	public void setSchoolConcat(String schoolConcat) {
		this.schoolConcat = schoolConcat;
	}
	public String getSchoolPhone() {
		return schoolPhone;
	}
	public void setSchoolPhone(String schoolPhone) {
		this.schoolPhone = schoolPhone;
	}
	public String getSchoolArea() {
		return schoolArea;
	}
	public void setSchoolArea(String schoolArea) {
		this.schoolArea = schoolArea;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getProjectArea() {
		return projectArea;
	}
	public void setProjectArea(String projectArea) {
		this.projectArea = projectArea;
	}
	public String getProjectManager() {
		return projectManager;
	}
	public void setProjectManager(String projectManager) {
		this.projectManager = projectManager;
	}
	public String getProjectConcat() {
		return projectConcat;
	}
	public void setProjectConcat(String projectConcat) {
		this.projectConcat = projectConcat;
	}
	
}
