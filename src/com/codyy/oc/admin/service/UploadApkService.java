package com.codyy.oc.admin.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.AttachmentMapper;
import com.codyy.oc.admin.entity.UploadAndroidApk;
@Service
public class UploadApkService {

	@Autowired
	private AttachmentMapper attachmentMapper;
	
	/**
	 * @author lichen
	* @Title: insertApk
	* @Description: (更新版本)
	* @param @param apk
	* @param @return    设定文件
	* @return ResultJson    返回类型
	* @throws
	 */
	public ResultJson insertApk(UploadAndroidApk apk){
		try{
			apk.setAndroidAppId(UUIDUtils.getUUID());
			apk.setCreateTime(new Date());
			attachmentMapper.insertApk(apk);
			return new ResultJson(true);
		}catch(Exception e){
			e.printStackTrace();
			return new ResultJson(false);
		}
		
	}
}
