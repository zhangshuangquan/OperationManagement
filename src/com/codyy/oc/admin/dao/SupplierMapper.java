package com.codyy.oc.admin.dao;

import java.util.List;
import java.util.Map;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.Project;
import com.codyy.oc.admin.entity.Supplier;

public interface SupplierMapper {
	
	/**
	 * @author lichen
	* @Title: insertSupplier
	* @Description: (添加集成商)
	* @param @param supplier
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer insertSupplier(Supplier supplier);

	/**
	 * @author lichen
	* @Title: selcSupplierPageList
	* @Description: (查询集成商列表)
	* @param @param page
	* @param @return    设定文件
	* @return List<Supplier>    返回类型
	* @throws
	 */
    public List<Supplier> selcSupplierPageList(Page page);
    
    /**
     * @author lichen
    * @Title: delSupplierById
    * @Description: (根据集成商的id来删除对应的集成商)
    * @param @param supplierId
    * @param @return    设定文件
    * @return Integer    返回类型
    * @throws
     */
    public Integer delSupplierById(String supplierId);
    
    
    /**
     * @author lichen
    * @Title: selcSuppById
    * @Description: (根据集成商的id来获得对应集成商的基本信息对象)
    * @param @param supplierId
    * @param @return    设定文件
    * @return Supplier    返回类型
    * @throws
     */
    public Supplier selcSuppById(String supplierId);
    
    
    /**
     * @author lichen
    * @Title: selcProjListBySuId
    * @Description: (根据集成商的id来获取本集成商已选的所有项目集合)
    * @param @param supplierId
    * @param @return    设定文件
    * @return List<Project>    返回类型
    * @throws
     */
    public List<Project> selcProjListBySuId(String supplierId);
    
    
    /**
     * @author lichen
    * @Title: updateSupplier
    * @Description: (修改集成商的基本信息)
    * @param @param supplier
    * @param @return    设定文件
    * @return Integer    返回类型
    * @throws
     */
    public Integer updateSupplier(Supplier supplier);
    
    
    /**
     * @author lichen
    * @Title: supplierProPageList
    * @Description: (点击合作项目个数来获得集成商合作项目列表)
    * @param @param page
    * @param @return    设定文件
    * @return List<Project>    返回类型
    * @throws
     */
    public List<Project> supplierProPageList(Page page);
    
    
    /**
     * @author lichen
    * @Title: contactPersonList
    * @Description: (根据集成商的id来获取对应的集成商的对象信息)
    * @param @param supplierId
    * @param @return    设定文件
    * @return Supplier    返回类型
    * @throws
     */
    public Supplier contactPersonList(String supplierId);
    
    /**
     * @author lichen 
    * @Title: getExportSupplierList
    * @Description: (导出集成商的多重查询的列表)
    * @param @param map
    * @param @return    设定文件
    * @return List<Supplier>    返回类型
    * @throws
     */
    public List<Supplier> getExportSupplierList(Map<String, Object> map);
    
	/*int deleteByPrimaryKey(String supplierId);

    int insertSelective(Supplier record);

    Supplier selectByPrimaryKey(String supplierId);

    int updateByPrimaryKeySelective(Supplier record);

    int updateByPrimaryKey(Supplier record);*/
}