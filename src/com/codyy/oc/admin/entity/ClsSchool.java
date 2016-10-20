package com.codyy.oc.admin.entity;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.annotation.ExcelColumn;
import com.codyy.commons.annotation.ExcelHeader;
import com.codyy.commons.utils.LongShortSerializer;

/**
 * 
 * @author zhangshuangquan
 * 学校
 *
 */
@ExcelHeader(headerName="学校列表")
public class ClsSchool {

	private String clsSchoolId;           //===学校id
                                            
	private String baseAreaId;            //===区域id
 
  	private String projectId;             //===项目id

    @ExcelColumn(columnName="学校名称")
	private String schoolName;            //===学校名称

    @ExcelColumn(columnName="学校区域")
    private String areaPath;             //区域名称

	private String contact;               //===联系人

	private String phone;                 //===联系电话
 
	private String deleteFlag=CommonsConstant.FLAG_NO ;			// === 删除状态             
	
	@ExcelColumn(columnName="项目名称")
	private String projectName;           //===项目名称
	
	@ExcelColumn(columnName="项目经理")
	private String managerName;           //===项目经理
	
	@ExcelColumn(columnName="教室数")
	private String classCount;            //教室数
	
	@ExcelColumn(columnName="工程师数")
	private String engineerCount;         //工程师数
	
	@ExcelColumn(columnName="勘查进度")
	private String explorationProcess; 
	
	@ExcelColumn(columnName="安装进度")
	private String installProcess;
	
	@ExcelColumn(columnName="调试进度")
	private String inspectProcess;               //调试进度
	
	@JsonSerialize(using=LongShortSerializer.class)
	private Date updateTime;
	
	@ExcelColumn(columnName="更新时间")
	private String updateTimes;
	
    private String engineer;          //工程师
    
    private Date  createTime;       //创建时间
    
    private BaseArea baseArea;//封装区域对象
    
    private Project project;//封装对应的项目
    
    
	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public BaseArea getBaseArea() {
		return baseArea;
	}

	public void setBaseArea(BaseArea baseArea) {
		this.baseArea = baseArea;
	}

	public String getClsSchoolId() {
		return clsSchoolId;
	}

	public void setClsSchoolId(String clsSchoolId) {
		this.clsSchoolId = clsSchoolId;
	}

	public String getBaseAreaId() {
		return baseAreaId;
	}

	public void setBaseAreaId(String baseAreaId) {
		this.baseAreaId = baseAreaId;
	}

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getClassCount() {
		return classCount;
	}

	public void setClassCount(String classCount) {
		this.classCount = classCount;
	}

	public String getEngineerCount() {
		return engineerCount;
	}

	public void setEngineerCount(String engineerCount) {
		this.engineerCount = engineerCount;
	}

	public String getInspectProcess() {
		inspectProcess = (inspectProcess == null ? null : (inspectProcess.startsWith(".")?("0"+inspectProcess):inspectProcess));
		return inspectProcess;
	}

	public void setInspectProcess(String inspectProcess) {
		this.inspectProcess = inspectProcess;
	}

	public String getEngineer() {
		return engineer;
	}

	public void setEngineer(String engineer) {
		this.engineer = engineer;
	}

	public String getAreaPath() {
		return areaPath;
	}

	public void setAreaPath(String areaPath) {
		this.areaPath = areaPath;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
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

	public String getExplorationProcess() {
		explorationProcess = (explorationProcess == null ? null :(explorationProcess.startsWith(".")?("0"+explorationProcess):explorationProcess));
		return explorationProcess;
	}

	public void setExplorationProcess(String explorationProcess) {
		this.explorationProcess = explorationProcess;
	}

	public String getInstallProcess() {
		installProcess = (installProcess == null ? null :(installProcess.startsWith(".")?("0"+installProcess):installProcess));
		return installProcess;
	}

	public void setInstallProcess(String installProcess) {
		this.installProcess = installProcess;
	}
	
}