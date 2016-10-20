package com.codyy.oc.admin.view;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.codyy.commons.annotation.ExcelColumn;
import com.codyy.commons.annotation.ExcelHeader;
import com.codyy.commons.utils.LongShortSerializer;

/**
 * 项目列表视图
 * 
 * @author zhangshuangquan
 *
 */
@ExcelHeader(headerName="项目列表")
public class ProjectView {

	private String projectId;
	
	@ExcelColumn(columnName="项目编号")
	private String projectCode;
	
	@ExcelColumn(columnName="项目名称")
	private String projectName;
	
	@ExcelColumn(columnName="项目区域")
	private String areaName;
	
	@ExcelColumn(columnName="项目经理")
	private String managerName;
	
	@ExcelColumn(columnName="学校数")
	private String schoolCount;

	@ExcelColumn(columnName="教室数")
	private String classCount;
	
	@ExcelColumn(columnName="勘查进度")
	private String explorationProcess; 
	
	@ExcelColumn(columnName="安装进度")
	private String installProcess;
	
	@ExcelColumn(columnName="调试进度")
	private String inspectProcess;
	
	@JsonSerialize(using=LongShortSerializer.class)
	private Date updateTime;
	
	@ExcelColumn(columnName="更新时间")
	private String updateTimes;
	
	@ExcelColumn(columnName="工程师")
	private String engineerCount;
	
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public String getProjectCode() {
		return projectCode;
	}
	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public String getManagerName() {
		return managerName;
	}
	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}
	public String getSchoolCount() {
		return schoolCount;
	}
	public void setSchoolCount(String schoolCount) {
		this.schoolCount = schoolCount;
	}
	public String getClassCount() {
		return classCount;
	}
	public void setClassCount(String classCount) {
		this.classCount = classCount;
	}
	public String getInspectProcess() {
		inspectProcess = (inspectProcess == null ? null : (inspectProcess.startsWith(".")?("0"+inspectProcess):inspectProcess));
		return inspectProcess;
	}
	public void setInspectProcess(String inspectProcess) {
		this.inspectProcess = inspectProcess;
	}
	public String getEngineerCount() {
		return engineerCount;
	}
	public void setEngineerCount(String engineerCount) {
		this.engineerCount = engineerCount;
	}
	public String getExplorationProcess() {
		explorationProcess = (explorationProcess == null ? null : (explorationProcess.startsWith(".")?("0"+explorationProcess):explorationProcess));
		return explorationProcess;
	}
	public void setExplorationProcess(String explorationProcess) {
		this.explorationProcess = explorationProcess;
	}
	public String getInstallProcess() {
		installProcess = (installProcess == null ? null : (installProcess.startsWith(".")?("0"+installProcess):installProcess));
		return installProcess;
	}
	public void setInstallProcess(String installProcess) {
		this.installProcess = installProcess;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getUpdateTimes() {
		if (updateTime == null) {
			updateTimes = "";
		} else {
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
			updateTimes = sdf.format(updateTime);
		}
		return updateTimes;
	}
	public void setUpdateTimes(String updateTimes) {
		this.updateTimes = updateTimes;
	}
}
