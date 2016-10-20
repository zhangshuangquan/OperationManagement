package com.codyy.oc.admin.view;

import com.codyy.commons.annotation.ExcelColumn;
import com.codyy.commons.annotation.ExcelHeader;


@ExcelHeader(headerName="调试状态列表")
public class ClsClassRoomInspectView {
	
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
    
    @ExcelColumn(columnName="安装进度")
	private String installProcess;
	
	@ExcelColumn(columnName="调试进度")
	private String inspectProcess;
	
	

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

	public String getInstallProcess() {
		installProcess = (installProcess == null ? null :(installProcess.startsWith(".")?("0"+installProcess):installProcess));
		return installProcess;
	}

	public void setInstallProcess(String installProcess) {
		this.installProcess = installProcess;
	}

	public String getInspectProcess() {
		inspectProcess = (inspectProcess == null ? null :(inspectProcess.startsWith(".")?("0"+inspectProcess):inspectProcess));
		return inspectProcess;
	}

	public void setInspectProcess(String inspectProcess) {
		this.inspectProcess = inspectProcess;
	}    
}
