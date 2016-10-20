package com.codyy.oc.admin.entity;

import java.util.Date;

/**
 * 设备寄送
 * @author zhangshuangquan
 *
 */
public class EquipmentDelivery {
	
	private String equipmentDeliveryId;
	
	private String maintenanceOrderId;
	
	private String name;
	
	private Date  deliveryTime;
	
	private String expressCompany;
	
	private String expressNum;
	
	public String getExpressCompany() {
		return expressCompany;
	}

	public void setExpressCompany(String expressCompany) {
		this.expressCompany = expressCompany;
	}

	public String getExpressNum() {
		return expressNum;
	}

	public void setExpressNum(String expressNum) {
		this.expressNum = expressNum;
	}

	public String getEquipmentDeliveryId() {
		return equipmentDeliveryId;
	}

	public void setEquipmentDeliveryId(String equipmentDeliveryId) {
		this.equipmentDeliveryId = equipmentDeliveryId;
	}

	public String getMaintenanceOrderId() {
		return maintenanceOrderId;
	}

	public void setMaintenanceOrderId(String maintenanceOrderId) {
		this.maintenanceOrderId = maintenanceOrderId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getDeliveryTime() {
		return deliveryTime;
	}

	public void setDeliveryTime(Date deliveryTime) {
		this.deliveryTime = deliveryTime;
	}
	
	
	

}
