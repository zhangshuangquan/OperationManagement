package com.codyy.oc.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.page.Page;
import com.codyy.oc.admin.dao.AttachmentMapper;
import com.codyy.oc.admin.entity.Attachment;

@Service
public class QualificationService {

	@Autowired
	private AttachmentMapper qualificationMapper;
	
	/**
	 * @author lichen
	* @Title: deleteQualiBysuId
	* @Description: (根据集成商的id来删除对应的所有的资质)
	* @param @param supplierId
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer deleteQualiBysuId(String relationShipId){
		return qualificationMapper.deleteQualiBysuId(relationShipId);
	}
	
	/**
	 * @author lichen
	* @Title: qualifiListBySuId
	* @Description: (根据集成商的id来查出对应的所有的资质集合)
	* @param @param supplierId
	* @param @return    设定文件
	* @return List<Qualification>    返回类型
	* @throws
	 */
	public List<Attachment> qualifiListBySuId(String supplierId){
		
		List<Attachment> attacheList =qualificationMapper.qualifiListBySuId(supplierId);
		return attacheList;
	}
	
	/**
	 *@author lichen
	* @Title: insertQuali
	* @Description: (插入集成商的资质)
	* @param @param qList
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer insertQuali(List<Attachment> qList){
		
		return qualificationMapper.insertQualification(qList);
		
	}
	
	/**
	 * @author lichen
	* @Title: qualificatListPageList
	* @Description: (根据集成商的id来查出其对应资质的分页列表)
	* @param @param page
	* @param @return    设定文件
	* @return List<Qualification>    返回类型
	* @throws
	 */
	public List<Attachment> qualificatListPageList(String supplierId,Page page){
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("relationShipId", supplierId);
		page.setMap(map);
		List<Attachment> quaList = qualificationMapper.qualificatListPageList(page);
		return quaList;
	}

}
