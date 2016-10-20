package com.codyy.oc.admin.dao;

import java.util.List;
import java.util.Map;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.entity.Sign;
import com.codyy.oc.admin.view.MapView;
import com.codyy.oc.admin.view.ShowNewSignMessageView;
import com.codyy.oc.admin.view.SignDetailView;

public interface SignMapper {
    int deleteByPrimaryKey(String signId);

    int insert(Sign record);

    int insertSelective(Sign record);

    Sign selectByPrimaryKey(String signId);

    int updateByPrimaryKeySelective(Sign record);

    int updateByPrimaryKey(Sign record);
    
    /**
     * @author lichen
    * @Title: showNewSign
    * @Description: (对签到信息的查询分页操作)
    * @param @return    设定文件
    * @return List<ShowNewSignMessageView>    返回类型
    * @throws
     */
    public List<ShowNewSignMessageView> showNewSignPageList(Page page);
    
    /**
     * @author lichen
    * @Title: selcSignDetailPageList
    * @Description: (获取指定的用户所有签到信息详情)
    * @param @param page
    * @param @return    设定文件
    * @return List<SignDetailView>    返回类型
    * @throws
     */
    public List<SignDetailView> selcSignDetailPageList(Page page);
    
    /**
     * @author lichen
    * @Title: exportAllSign
    * @Description: (导出所有最新签到资源)
    * @param @param map
    * @param @return    设定文件
    * @return List<ShowNewSignMessageView>    返回类型
    * @throws
     */
    public List<ShowNewSignMessageView> exportAllSign(Map<String,Object> map);
    
    /**
     * @author lichen
    * @Title: exportDetailSignById
    * @Description: (导出指定用户的所有项目信息)
    * @param @param map
    * @param @return    设定文件
    * @return List<SignDetailView>    返回类型
    * @throws
     */
    public List<SignDetailView> exportDetailSignById(Map<String,Object> map);
    
    /**
     * @author lichen
    * @Title: getSignPic
    * @Description:(获得签到上传图片的集合)
    * @param @param signId
    * @param @return    设定文件
    * @return List<Attachment>    返回类型
    * @throws
     */
    public List<Attachment> getSignPic(String signId);
    
    /**
     * 
    * @Title: getSingMap
    * @Description: 根据单号获取签到信息
    * @param @param orderId
    * @param @return
    * @return List<MapView>    
    * @throws
     */
    public List<MapView> getSingMap(String orderId);
}