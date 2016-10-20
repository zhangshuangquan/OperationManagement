package com.codyy.oc.admin.view;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.codyy.commons.annotation.ExcelColumn;
import com.codyy.commons.annotation.ExcelHeader;
import com.codyy.commons.utils.MediumDateSerializer;
@ExcelHeader(headerName="人员状态表")
public class ShowNewSignMessageView {

	private String sign_id;//签到编号
	
	@ExcelColumn(columnName="姓名")
	private String username;
	@ExcelColumn(columnName="职位")
	private String position;
	
	public String getSign_id() {
		return sign_id;
	}
	public void setSign_id(String sign_id) {
		this.sign_id = sign_id;
	}
	@ExcelColumn(columnName="最近签到时间")
	private String newSignTime;
	
	
	public String getNewSignTime() {
		return newSignTime;
	}
	public void setNewSignTime(String newSignTime) {
		this.newSignTime = newSignTime;
	}
	
	@JsonSerialize(using=MediumDateSerializer.class)
	private Date sign_time;
	
	private String maintenanceOrderId;//工单id

	@ExcelColumn(columnName="最新状态")
	private String status;
	@ExcelColumn(columnName="最新位置")
	private String area_path;
	@ExcelColumn(columnName="项目")
	private String project_name;
	
	@ExcelColumn(columnName="工单")
	private String orderNum;//工单编号

	@ExcelColumn(columnName="备注")
	private String remarks;

	private String admin_user_id;
	
	
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public String getMaintenanceOrderId() {
		return maintenanceOrderId;
	}
	public void setMaintenanceOrderId(String maintenanceOrderId) {
		this.maintenanceOrderId = maintenanceOrderId;
	}
	public String getAdmin_user_id() {
		return admin_user_id;
	}
	public void setAdmin_user_id(String admin_user_id) {
		this.admin_user_id = admin_user_id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public Date getSign_time() {
		return sign_time;
	}
	
	public void setSign_time(Date sign_time) {
		
		//格式化日期
		SimpleDateFormat time=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		this.newSignTime=time.format(sign_time);
		
		this.sign_time = sign_time;
	}
	public String getProject_name() {
		return project_name;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}
	public String getArea_path() {
		return area_path;
	}
	public void setArea_path(String area_path) {
		this.area_path = area_path;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	
	
}
