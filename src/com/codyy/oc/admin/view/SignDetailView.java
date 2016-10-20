package com.codyy.oc.admin.view;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.codyy.commons.annotation.ExcelColumn;
import com.codyy.commons.annotation.ExcelHeader;
import com.codyy.commons.utils.MediumDateSerializer;
@ExcelHeader(headerName="个人签到详情")
public class SignDetailView {

	private String admin_user_id;
	
	@ExcelColumn(columnName="姓名")
	private String username;
	
	@ExcelColumn(columnName="时间")
	private String sigTimeStr;
	
	
	
	public String getSigTimeStr() {
		return sigTimeStr;
	}
	public void setSigTimeStr(String sigTimeStr) {
		this.sigTimeStr = sigTimeStr;
	}
	@JsonSerialize(using=MediumDateSerializer.class)
	private Date sign_time;
	@ExcelColumn(columnName="地点")
	private String area_path;
	@ExcelColumn(columnName="项目")
	private String project_name;
	@ExcelColumn(columnName="状态")
	private String status;
	@ExcelColumn(columnName="工单")
	private String orderNum;
	@ExcelColumn(columnName="备注")
	private String remarks;
	
	private String maintenanceOrderId;
	
	private String realName;
	  
	private String signId;
	
	
	public String getSignId() {
		return signId;
	}
	public void setSignId(String signId) {
		this.signId = signId;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getMaintenanceOrderId() {
		return maintenanceOrderId;
	}
	public void setMaintenanceOrderId(String maintenanceOrderId) {
		this.maintenanceOrderId = maintenanceOrderId;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getAdmin_user_id() {
		return admin_user_id;
	}
	public void setAdmin_user_id(String admin_user_id) {
		this.admin_user_id = admin_user_id;
	}
	public Date getSign_time() {
		return sign_time;
	}
	public void setSign_time(Date sign_time) {
		//格式化日期
	   SimpleDateFormat time=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	   this.sigTimeStr=time.format(sign_time);
		this.sign_time = sign_time;
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
	
	
}
