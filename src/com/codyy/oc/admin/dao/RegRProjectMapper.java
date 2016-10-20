package com.codyy.oc.admin.dao;

import com.codyy.oc.admin.entity.RegRProject;

public interface RegRProjectMapper {
	
	
	/**
	 * @author 添加资源项目表关系信息
	* @Title: insertRegRProjectMapper
	* @Description: (这里用一句话描述这个方法的作用)
	* @param @param regRProject
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer insertRegRProject(RegRProject regRProject);
	
	
	/**
	 * @author lichen
	* @Title: delResouceRProjectByResId
	* @Description: (根据地区的资源id来删除资源项目关系表的对应所有记录)
	* @param @param REGIONAL_RESOURCE_ID
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer delResouceRProjectByResId(String regionalResourceId);
	
    /*int deleteByPrimaryKey(String regRProjectId);

    int insert(RegRProject record);

    int insertSelective(RegRProject record);

    RegRProject selectByPrimaryKey(String regRProjectId);

    int updateByPrimaryKeySelective(RegRProject record);

    int updateByPrimaryKey(RegRProject record);*/
}