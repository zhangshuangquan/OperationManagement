package com.codyy.oc.admin.view;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class RepairView implements Serializable {

	private static final long serialVersionUID = -3572446089934311292L;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date taskAssginment;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date outdoors;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date quesResolve;
	private String problemResolve;
	private String orderId;//工单id
	
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public Date getTaskAssginment() {
		return taskAssginment;
	}
	public void setTaskAssginment(Date taskAssginment) {
		this.taskAssginment = taskAssginment;
	}
	public Date getOutdoors() {
		return outdoors;
	}
	public void setOutdoors(Date outdoors) {
		this.outdoors = outdoors;
	}
	public Date getQuesResolve() {
		return quesResolve;
	}
	public void setQuesResolve(Date quesResolve) {
		this.quesResolve = quesResolve;
	}
	public String getProblemResolve() {
		return problemResolve;
	}
	public void setProblemResolve(String problemResolve) {
		this.problemResolve = problemResolve;
	}
	
	
}
