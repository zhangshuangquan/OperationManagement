package com.codyy.oc.admin.dao;

import java.util.List;
import java.util.Map;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.Project;
import com.codyy.oc.admin.entity.RegionalResource;

public interface RegionalResourceMapper {
    
    /**
     * @author lichen
    * @Title: insertAreaResource
    * @Description: (添加区域区域资源)
    * @param @param record
    * @param @return    设定文件
    * @return int    返回类型
    * @throws
     */
    public Integer insertAreaResource(RegionalResource record);
    
    /**
     * @author lichen
    * @Title: selectAreaResourcePageList
    * @Description: (多条件进行查询)
    * @param @param page
    * @param @return    设定文件
    * @return List<RegionalResource>    返回类型
    * @throws
     */
    public List<RegionalResource> selectAreaResourcePageList(Page page);
    
    
    /**
     * @author lichen
    * @Title: deleteByPrimaryKey
    * @Description: (根据区域的id来删除指定的区域信息)
    * @param @param regionalResourceId
    * @param @return    设定文件
    * @return int    返回类型
    * @throws
     */
    public int deleteByPrimaryKey(String regionalResourceId);
    
    
    /**
     * @author lichen
    * @Title: getCount
    * @Description: (获得每个资源对应的所有项目的个数)
    * @param @return    设定文件
    * @return Integer    返回类型
    * @throws
     */
    public Integer getCount();
    
    /**
     * @author lichen
    * @Title: selcProjPageList
    * @Description: (点击查询分页)
    * @param @param page
    * @param @return    设定文件
    * @return List<Project>    返回类型  在对应的mapper.xml中resultMap返回的type必须是RegionalResource对象
    * @throws
     */
    public List<Project> selcProjPageList(Page page);
    
    
    /**
     * @author lichen
    * @Title: selcRegResById
    * @Description: (根据资源的id来查出对应的资源对象信息用于编辑操作)
    * @param @param RegionalResourceId
    * @param @return    设定文件
    * @return RegionalResource    返回类型
    * @throws
     */
    public RegionalResource selcRegResById(String RegionalResourceId);
    
  
    /**
     * @author lichen
    * @Title: updateRegResource
    * @Description: (编辑指定用户的资源信息)
    * @param @param regionalResource
    * @param @return    设定文件
    * @return Integer    返回类型
    * @throws
     */
    public int updateRegResource(RegionalResource regionalResource);
    
    
    /**
     * @author lichen
    * @Title: selcProById
    * @Description: (根据资源的id来获得对应本资源的所有项目)
    * @param @param RegionalResourceId
    * @param @return    设定文件
    * @return List<Project>    返回类型
    * @throws
     */
    public List<Project> selcProById(String RegionalResourceId);
    
    /**
     * @author lichen
    * @Title: exportRegionalResource
    * @Description: (根据条件导出表的信息)
    * @param @param map
    * @param @return    设定文件
    * @return List<RegionalResource>    返回类型
    * @throws
     */
    public List<RegionalResource> exportRegionalResource(Map<String, Object> map);
}