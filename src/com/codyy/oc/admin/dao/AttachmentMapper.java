package com.codyy.oc.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.entity.Type;
import com.codyy.oc.admin.entity.UploadAndroidApk;

public interface AttachmentMapper {
   
	/**
	 * @author lichen
	* @Title: insertQualification
	* @Description: (上传文件来添加资质表信息)
	* @param @param qua
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer insertQualification(@Param(value="quaLi") List<Attachment> quaLi);
	
	/**
	 * @author lichen
	* @Title: deleteQualiBysuId
	* @Description: (根据集成商的id来删除对应资质表中的所有信息)
	* @param @param supplierId
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer deleteQualiBysuId(String supplierId);
	
	
	/**
	 * @author lichen
	* @Title: delClassRoomDetail
	* @Description: (根据教室的编号和开发进度对应的类型来删除开发进度对应附件表中的所有附件)
	* @param @param type
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer delClassRoomDetail(Type type);
	/**
	 * @author lichen
	* @Title: qualifiListBySuId
	* @Description: (根据集成商的id来获取对应的所有资质)
	* @param @param supplierId
	* @param @return    设定文件
	* @return List<Qualification>    返回类型
	* @throws
	 */
	public List<Attachment> qualifiListBySuId(String supplierId);
	
	/**
	 * @author lichen
	* @Title: qualificatListPageList
	* @Description: (根据集成商的id来查出对应的资质集合的分页列表)
	* @param @param page
	* @param @return    设定文件
	* @return List<Qualification>    返回类型
	* @throws
	 */
	public List<Attachment> qualificatListPageList(Page page);

    /**
     * @author lichen
    * @Title: addAttachment
    * @Description: (插入操作)
    * @param @param attachments    设定文件
    * @return void    返回类型
    * @throws
     */
	public void addAttachment(List<Attachment> attachments);

	public void deleteAttachment(String relationShipId);
	/**
	 * @author lichen
	* @Title: deleteAttachments
	* @Description: (删除对应的保障单)
	* @param @param relationShipId    设定文件
	* @return void    返回类型
	* @throws
	 */
	public void deleteAttachments(String relationShipId);

	public List<Attachment> getAttachByRelationshipId(String envirSurveyId);

	/**
	 * @author lichen
	* @Title: deleteAttachmentByPicName
	* @Description: (删除指定的图片)
	* @param @param attachment
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer deleteAttachmentByPicName(Attachment attachment);

	
	/**
	 * @author lichen
	* @Title: classRoomDetailBycId
	* @Description: (根据教室的id和type封装的对象来获取教室对应的安装进度)
	* @param @param classRoomId
	* @param @return    设定文件
	* @return List<Attachment>    返回类型
	* @throws
	 */
	public List<Attachment> classRoomDetailBycId(Type classRoomType);

	public List<Attachment> getAttachByRelationshipIdsPageList(Page page);
	/**
	 * @author lichen
	* @Title: insertApk
	* @Description: (更新版本)
	* @param @param apk
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer insertApk(UploadAndroidApk apk);
}