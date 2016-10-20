package com.codyy.oc.admin.view;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.codyy.commons.annotation.ExcelColumn;
import com.codyy.commons.annotation.ExcelHeader;
import com.codyy.commons.utils.ShortDateSerializer;

@ExcelHeader(headerName="环境勘查列表")
public class ClsClassRoomEnvirView {
	
	@ExcelColumn(columnName="教室名称")
    private String roomName;

	@ExcelColumn(columnName="教室类别")
    private String roomType;

    @ExcelColumn(columnName="学校区域")
	private String schoolArea;//学校区域
	
    @ExcelColumn(columnName="学校")
	private String clsSchoolName;//学校名称
	
   
	private String projectName;//项目名称

    @ExcelColumn(columnName="联系人")
    private String contactPersonName;

    @ExcelColumn(columnName="手机")
    private String contactPersonPhone;
    
    @ExcelColumn(columnName="状态")
   	private String explorationReport;
       
    @JsonSerialize(using=ShortDateSerializer.class)
    private Date updateTime;
    
    @ExcelColumn(columnName="勘查时间")
    private String updateTimeStr;
    
    private String explorationProcess; 
    
   
    
	public String getUpdateTimeStr() {
		if(updateTime != null){
			SimpleDateFormat time=new SimpleDateFormat("yyyy-MM-dd");
			updateTimeStr = time.format(updateTime);
		}
			return updateTimeStr;
	}

	public void setUpdateTimeStr(String updateTimeStr) {
		this.updateTimeStr = updateTimeStr;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public String getRoomType() {
		return roomType;
	}

	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}

	public String getSchoolArea() {
		return schoolArea;
	}

	public void setSchoolArea(String schoolArea) {
		this.schoolArea = schoolArea;
	}

	public String getClsSchoolName() {
		return clsSchoolName;
	}

	public void setClsSchoolName(String clsSchoolName) {
		this.clsSchoolName = clsSchoolName;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getContactPersonName() {
		return contactPersonName;
	}

	public void setContactPersonName(String contactPersonName) {
		this.contactPersonName = contactPersonName;
	}

	public String getContactPersonPhone() {
		return contactPersonPhone;
	}

	public void setContactPersonPhone(String contactPersonPhone) {
		this.contactPersonPhone = contactPersonPhone;
	}
	
	public String getExplorationReport() {
		if("0%".equals(explorationProcess)){
			explorationReport = "未完结";
		}else {
			explorationReport = "已完结";
		}
		return explorationReport;
	}

	public String getExplorationProcess() {
		return explorationProcess;
	}

	public void setExplorationProcess(String explorationProcess) {
		this.explorationProcess = explorationProcess;
	}

	public void setExplorationReport(String explorationReport) {
		this.explorationReport = explorationReport;
	}        
}
