package com.codyy.oc.admin.entity;

import java.util.ArrayList;
import java.util.List;

public class SupplierRProject {
    private String supplierRProjectId;

    private String projectId;

    private String supplierId;
    
    private List<String> projIdList = new ArrayList<String>();//存放集成商选中项目对应项目id的集合
    

    public List<String> getProjIdList() {
		return projIdList;
	}

	public void setProjIdList(List<String> projIdList) {
		this.projIdList = projIdList;
	}

	public String getSupplierRProjectId() {
        return supplierRProjectId;
    }

    public void setSupplierRProjectId(String supplierRProjectId) {
        this.supplierRProjectId = supplierRProjectId;
    }

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public String getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(String supplierId) {
        this.supplierId = supplierId;
    }

	@Override
	public String toString() {
		return "SupplierRProject [supplierRProjectId=" + supplierRProjectId
				+ ", projectId=" + projectId + ", supplierId=" + supplierId
				+ ", projIdList=" + projIdList + ", toString()="
				+ super.toString() + "]";
	}
    
    
}