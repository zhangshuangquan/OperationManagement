package com.codyy.oc.admin.entity;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.codyy.commons.annotation.ExcelColumn;
import com.codyy.commons.annotation.ExcelHeader;
import com.codyy.commons.utils.LongShortSerializer;
import com.codyy.commons.utils.ShortDateSerializer;

@ExcelHeader(headerName="教室列表")
public class ClsClassroom {
	private String clsClassroomId;

	@ExcelColumn(columnName="教室名称")
    private String roomName;

	@ExcelColumn(columnName="教室类别")
    private String roomType;

    @ExcelColumn(columnName="学校区域")
	private String schoolArea;//学校区域
	
    @ExcelColumn(columnName="学校")
	private String clsSchoolName;//学校名称
	
    @ExcelColumn(columnName="项目")
	private String projectName;//项目名称
	
	private String projectArea;//项目地址
	
	private String projectId;//项目ID
	
    private String clsSchoolId;//学校ID

    private Date createTime;//创建时间

    private String createUser;//创建人

    @ExcelColumn(columnName="联系人")
    private String contactPersonName;

    @ExcelColumn(columnName="手机")
    private String contactPersonPhone;

    private String teamviewid;

    private String teamviewpsd;

    private String zxktService;

    private String zxktUserNamePsd;

    private String dbcjVersion;

    private String projectVersion;

    private String implementationProgress;

    private Date implementationTimeBegin;

    private Date implementationTimeEnd;

    private String zcsbNum;

    private String productWarrantyPeriod;

    private String jgptAddress;

    private String jgptService;

    private String jgptNamePsd;

    private String serviceInfo;

    private String netInfo;

    private String blackboard;

    private String platform;

    private String bbtInfo;

    private String isSign;

    private String status;

    private String isTrain;

    private String trainTeacher;

    private String isCheck;

    private Date trainTime;

    private String isStart;
    
    private String remark;
    
	private String testerName;

	private Date testerTime;

	private String testerRemark;

	private String helpTesterName;

	private Date helpTesterTime;

	private String helpTesterRemark;

	private String helpTesterResult;

	@ExcelColumn(columnName="环境勘查报告")
	private String explorationReport;
	
	private String explorationProcess; 
	
	@ExcelColumn(columnName="安装进度")
	private String installProcess;
	
	@ExcelColumn(columnName="调试进度")
	private String inspectProcess;
	
	
	@JsonSerialize(using=LongShortSerializer.class)
	private Date updateTime;//最新环境勘察时间
	
	@ExcelColumn(columnName="更新时间")
	private String updateTimes;
	
	@JsonSerialize(using=ShortDateSerializer.class)
	private Date explorationTime;  //勘查时间
	
	private String installUser; //安装工程师ID
	
	private String installUserName; //安装工程师名称
	
	private String type;//更新类型 CLASSROOM_INSPECT：调试 CLASSROOM_DETAIL ： 安装
	
	
    public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getInstallUserName() {
		return installUserName;
	}

	public void setInstallUserName(String installUserName) {
		this.installUserName = installUserName;
	}

	public String getInstallUser() {
		return installUser;
	}

	public void setInstallUser(String installUser) {
		this.installUser = installUser;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getTesterName() {
		return testerName;
	}

	public void setTesterName(String testerName) {
		this.testerName = testerName;
	}

	public Date getTesterTime() {
		return testerTime;
	}

	public void setTesterTime(Date testerTime) {
		this.testerTime = testerTime;
	}

	public String getTesterRemark() {
		return testerRemark;
	}

	public void setTesterRemark(String testerRemark) {
		this.testerRemark = testerRemark;
	}

	public String getHelpTesterName() {
		return helpTesterName;
	}

	public void setHelpTesterName(String helpTesterName) {
		this.helpTesterName = helpTesterName;
	}

	public Date getHelpTesterTime() {
		return helpTesterTime;
	}

	public void setHelpTesterTime(Date helpTesterTime) {
		this.helpTesterTime = helpTesterTime;
	}

	public String getHelpTesterRemark() {
		return helpTesterRemark;
	}

	public void setHelpTesterRemark(String helpTesterRemark) {
		this.helpTesterRemark = helpTesterRemark;
	}

	public String getHelpTesterResult() {
		return helpTesterResult;
	}

	public void setHelpTesterResult(String helpTesterResult) {
		this.helpTesterResult = helpTesterResult;
	}

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public String getProjectArea() {
		return projectArea;
	}

	public void setProjectArea(String projectArea) {
		this.projectArea = projectArea;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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

	public String getClsClassroomId() {
        return clsClassroomId;
    }

    public void setClsClassroomId(String clsClassroomId) {
        this.clsClassroomId = clsClassroomId;
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

    public String getClsSchoolId() {
        return clsSchoolId;
    }

    public void setClsSchoolId(String clsSchoolId) {
        this.clsSchoolId = clsSchoolId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCreateUser() {
        return createUser;
    }

    public void setCreateUser(String createUser) {
        this.createUser = createUser;
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

    public String getTeamviewid() {
        return teamviewid;
    }

    public void setTeamviewid(String teamviewid) {
        this.teamviewid = teamviewid;
    }

    public String getTeamviewpsd() {
        return teamviewpsd;
    }

    public void setTeamviewpsd(String teamviewpsd) {
        this.teamviewpsd = teamviewpsd;
    }

    public String getZxktService() {
        return zxktService;
    }

    public void setZxktService(String zxktService) {
        this.zxktService = zxktService;
    }

    public String getZxktUserNamePsd() {
        return zxktUserNamePsd;
    }

    public void setZxktUserNamePsd(String zxktUserNamePsd) {
        this.zxktUserNamePsd = zxktUserNamePsd;
    }

    public String getDbcjVersion() {
        return dbcjVersion;
    }

    public void setDbcjVersion(String dbcjVersion) {
        this.dbcjVersion = dbcjVersion;
    }

    public String getProjectVersion() {
        return projectVersion;
    }

    public void setProjectVersion(String projectVersion) {
        this.projectVersion = projectVersion;
    }

    public String getImplementationProgress() {
        return implementationProgress;
    }

    public void setImplementationProgress(String implementationProgress) {
        this.implementationProgress = implementationProgress;
    }

    public Date getImplementationTimeBegin() {
        return implementationTimeBegin;
    }

    public void setImplementationTimeBegin(Date implementationTimeBegin) {
        this.implementationTimeBegin = implementationTimeBegin;
    }

    public Date getImplementationTimeEnd() {
        return implementationTimeEnd;
    }

    public void setImplementationTimeEnd(Date implementationTimeEnd) {
        this.implementationTimeEnd = implementationTimeEnd;
    }

    public String getZcsbNum() {
		return zcsbNum;
	}

	public void setZcsbNum(String zcsbNum) {
		this.zcsbNum = zcsbNum;
	}

	public String getProductWarrantyPeriod() {
        return productWarrantyPeriod;
    }

    public void setProductWarrantyPeriod(String productWarrantyPeriod) {
        this.productWarrantyPeriod = productWarrantyPeriod;
    }

    public String getJgptAddress() {
        return jgptAddress;
    }

    public void setJgptAddress(String jgptAddress) {
        this.jgptAddress = jgptAddress;
    }

    public String getJgptService() {
        return jgptService;
    }

    public void setJgptService(String jgptService) {
        this.jgptService = jgptService;
    }

    public String getJgptNamePsd() {
        return jgptNamePsd;
    }

    public void setJgptNamePsd(String jgptNamePsd) {
        this.jgptNamePsd = jgptNamePsd;
    }

    public String getServiceInfo() {
        return serviceInfo;
    }

    public void setServiceInfo(String serviceInfo) {
        this.serviceInfo = serviceInfo;
    }

    public String getNetInfo() {
        return netInfo;
    }

    public void setNetInfo(String netInfo) {
        this.netInfo = netInfo;
    }

    public String getBlackboard() {
        return blackboard;
    }

    public void setBlackboard(String blackboard) {
        this.blackboard = blackboard;
    }

    public String getPlatform() {
        return platform;
    }

    public void setPlatform(String platform) {
        this.platform = platform;
    }

    public String getBbtInfo() {
        return bbtInfo;
    }

    public void setBbtInfo(String bbtInfo) {
        this.bbtInfo = bbtInfo;
    }

    public String getIsSign() {
		return isSign;
	}

	public void setIsSign(String isSign) {
		this.isSign = isSign;
	}

	public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getIsTrain() {
        return isTrain;
    }

    public void setIsTrain(String isTrain) {
        this.isTrain = isTrain;
    }

    public String getTrainTeacher() {
        return trainTeacher;
    }

    public void setTrainTeacher(String trainTeacher) {
        this.trainTeacher = trainTeacher;
    }

    public String getIsCheck() {
        return isCheck;
    }

    public void setIsCheck(String isCheck) {
        this.isCheck = isCheck;
    }

   

    public Date getTrainTime() {
		return trainTime;
	}

	public void setTrainTime(Date trainTime) {
		this.trainTime = trainTime;
	}

	public String getIsStart() {
        return isStart;
    }

    public void setIsStart(String isStart) {
        this.isStart = isStart;
    }

	public String getInspectProcess() {
		inspectProcess = (inspectProcess == null ? null :(inspectProcess.startsWith(".")?("0"+inspectProcess):inspectProcess));
		return inspectProcess;
	}

	public void setInspectProcess(String inspectProcess) {
		this.inspectProcess = inspectProcess;
	}

	public String getExplorationProcess() {
		explorationProcess =  (explorationProcess == null ? null : (explorationProcess.startsWith(".")?("0"+explorationProcess):explorationProcess));
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

	public String getExplorationReport() {
		if("100%".equals(explorationProcess)){
			explorationReport = "已完结";
		}else {
			explorationReport = "未完结";
		}
		return explorationReport;
	}

	public void setExplorationReport(String explorationReport) {
		this.explorationReport = explorationReport;
	}

	public Date getExplorationTime() {
		return explorationTime;
	}

	public void setExplorationTime(Date explorationTime) {
		this.explorationTime = explorationTime;
	}
	
	
}