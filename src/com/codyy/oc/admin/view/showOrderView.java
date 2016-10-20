package com.codyy.oc.admin.view;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.codyy.commons.annotation.ExcelColumn;
import com.codyy.commons.annotation.ExcelHeader;
import com.codyy.commons.utils.ShortDateSerializer;
@ExcelHeader(headerName="现场维修列表")
public class showOrderView {
   
	@ExcelColumn(columnName="单号")
	private String order_Num;
	
	public String getOrder_Num() {
		return order_Num;
	}
	public void setOrder_Num(String order_Num) {
		this.order_Num = order_Num;
	}
	private String maintenance_Order_Id;
	@ExcelColumn(columnName="学校名称")
	private String school_name;
	@ExcelColumn(columnName="学校区域")
	private String schArea;
	@ExcelColumn(columnName="联系人")
	private String concat;
	@ExcelColumn(columnName="联系电话")
	private String phone;
	@ExcelColumn(columnName="项目")
	private String project_name;
	
	private String proArea;
	
	
	private String name;//原文件名
	private String attachment_Url;//新文件名
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAttachment_Url() {
		return attachment_Url;
	}
	public void setAttachment_Url(String attachment_Url) {
		this.attachment_Url = attachment_Url;
	}
	private String maxdatestr;
	
	@ExcelColumn(columnName="最新状态")
	private String maxdataStr;
	
	@JsonSerialize(using=ShortDateSerializer.class)
	private Date maxdate;
	
	
	@ExcelColumn(columnName="备注")
	private String remark;

	
	
	
	public String getMaxdataStr() {
		if(maxdate == null){
			maxdataStr = "";
		}else{
			SimpleDateFormat time=new SimpleDateFormat("yyyy-MM-dd");
			maxdataStr = time.format(maxdate)+"  "+maxdatestr;
		}
		return maxdataStr;
	}
	public void setMaxdataStr(String maxdataStr) {
		this.maxdataStr = maxdataStr;
	}
	public String getMaintenance_Order_Id() {
		return maintenance_Order_Id;
	}
	public void setMaintenance_Order_Id(String maintenance_Order_Id) {
		this.maintenance_Order_Id = maintenance_Order_Id;
	}
	public String getConcat() {
		return concat;
	}
	public void setConcat(String concat) {
		this.concat = concat;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getSchool_name() {
		return school_name;
	}
	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}
	public String getSchArea() {
		return schArea;
	}
	public void setSchArea(String schArea) {
		this.schArea = schArea;
	}
	public String getProject_name() {
		return project_name;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}
	public String getProArea() {
		return proArea;
	}
	public void setProArea(String proArea) {
		this.proArea = proArea;
	}
	public String getMaxdatestr() {
		return maxdatestr;
	}
	public void setMaxdatestr(String maxdatestr) {
		this.maxdatestr = maxdatestr;
	}
	public Date getMaxdate() {
		return maxdate;
	}
	public void setMaxdate(Date maxdate) {
		this.maxdate = maxdate;
	}
	
   
}
