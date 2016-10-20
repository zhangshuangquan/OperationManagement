package com.codyy.oc.admin.dao;

import com.codyy.oc.admin.entity.SupplierRProject;

public interface SupplierRProjectMapper {
	
	/**
	 * @author lichen
	* @Title: insertSuppRProject
	* @Description: (向集成商项目关系表中添加关系数据)
	* @param @param supplierRProject
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer insertSuppRProject(SupplierRProject supplierRProject);
	
	/**
	 * @author lichen
	* @Title: delSupplRProjBySuId
	* @Description: (根据传来的集成商的id来删除本集成商在项目集成商关系表的所有对应项目)
	* @param @param supplyId
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer delSupplRProjBySuId(String supplyId);
	
    /*int deleteByPrimaryKey(String supplierRProjectId);

    int insert(SupplierRProject record);

    int insertSelective(SupplierRProject record);

    SupplierRProject selectByPrimaryKey(String supplierRProjectId);

    int updateByPrimaryKeySelective(SupplierRProject record);

    int updateByPrimaryKey(SupplierRProject record);*/
}