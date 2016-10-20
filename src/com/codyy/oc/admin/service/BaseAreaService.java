package com.codyy.oc.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.oc.admin.dao.BaseAreaMapper;
import com.codyy.oc.admin.view.SelectModel;



@Service
public class BaseAreaService {

	@Autowired
	private BaseAreaMapper baseAreaMapper;

	

	public List<SelectModel> getBaseAreaByParentId(String parentId){
		Map<String,String> map = new HashMap<String,String>();
		map.put("parentId", parentId);
		return baseAreaMapper.getBaseAreaByParentId(map);
	}



	public List<SelectModel> getBaseArea(String id) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("id", id);
		return baseAreaMapper.getBaseArea(id);
	}


	
	
	
	/**
	 * 根据ID获取行政区
	 * 
	 * @author Gwang
	 * @param id
	 * @return
	 *//*
	public BaseArea getAreaById(String id) {
		return baseAreaMapper.selectByPrimaryKey(id);
	}

	*//**
	 * 根据父级ID获取行政区
	 * 
	 * @author Gwang
	 * @param parentId
	 * @return
	 *//*
	public List<BaseArea> getAreaByparentId(String parentId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("parentId", parentId);
		List<BaseArea> areas = baseAreaMapper.getAreaByparentId(map);
		if (areas != null && areas.size() > 0) {
			for (BaseArea area : areas) {
				int count = baseAreaMapper.getChildCount(area.getBaseAreaId());
				area.setChilds(count > 0 ? true : false);
			}
		}
		return areas;
	}

	*//**
	 * 获取所有子行政区
	 * 
	 * @author Gwang
	 * @param areaId
	 * @return
	 *//*
	public List<BaseArea> getChildrenAreaByParentId(String areaId) {
		return baseAreaMapper.getChildrenAreaByParentId(areaId);
	}

	*//**
	 * 根据名称或代码查询行政区
	 * 
	 * @author Gwang
	 * @param map
	 * @return
	 *//*
	public BaseArea getAreaByProperty(Map<String, Object> map) {
		return baseAreaMapper.getAreaByProperty(map);
	}

	*//**
	 * 根据行政区获取超级管理员
	 * 
	 * @author Gwang
	 * @param id
	 * @return
	 *//*
	public BaseUser getBaseUserByAreaId(String id) {
		return baseUserMapper.getBaseUserByAreaId(id);
	}

	*//**
	 * 保存行政区
	 * 
	 * @author Gwang
	 * @param area
	 *//*
	public ResultJson areaCreate(BaseArea area, BaseUser baseUser) {
		String id = UUIDUtils.getUUID();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("parentId", area.getParentId());
		Integer sort = baseAreaMapper.getMaxSortByParentId(map);
		area.setBaseAreaId(id);
		area.setSort(sort == null ? 1 : (sort + 1));
		setAreaParentsInfo(area);
		baseAreaMapper.insertSelective(area);
		baseUser.setBaseAreaId(id);
		baseUser.setLocked(CommonsConstant.FLAG_NO);
		baseUser.setAdminFlag(CommonsConstant.FLAG_YES);
		ResultJson resultJson = baseUserService.addOrgBaseUser(baseUser);
		if (resultJson.isResult()) {
			resultJson.setMessage(id);
		}else{
			throw new RuntimeException(resultJson.getMessage());
		}
		return resultJson;
	}

	*//**
	 * 修改行政区
	 * 
	 * @author Gwang
	 * @param area
	 *//*
	public ResultJson areaEdit(BaseArea area, BaseUser baseUser, boolean isEditName) {
		baseAreaMapper.updateByPrimaryKey(area);
		if (isEditName) {
			updateChildrenAreaInfo(area.getBaseAreaId());
		}
		return baseUserService.updateOrgUser(baseUser);
	}

	*//**
	 * 删除行政区
	 * 
	 * @author Gwang
	 * @param id
	 *//*
	public void areaDelete(String id) {
		baseUserMapper.deleteBaseUserByAreaId(id);
		baseAreaMapper.deleteByPrimaryKey(id);
	}

	*//**
	 * 
	 * getAreaByChildId:(根据区域ID查询其所有上级的区域)
	 * 
	 * @param baseAreaId
	 * @return
	 * @author zhangtian
	 *//*
	public List<BaseArea> getAreaByChildId(String baseAreaId) {
		return baseAreaMapper.getAreaByChildId(baseAreaId);
	}

	*//**
	 * 设置区域父级信息
	 * 
	 * @author Gwang
	 * @param baseArea
	 *//*
	public void setAreaParentsInfo(BaseArea baseArea) {
		String pAreaId = baseArea.getParentId();
		String areaId = baseArea.getBaseAreaId();
		String areaName = baseArea.getAreaName();
		if (StringUtils.isBlank(pAreaId)) {
			baseArea.setAreaIdPath(areaId);
			baseArea.setAreaPath(areaName);
		} else {
			StringBuffer path = new StringBuffer();
			StringBuffer idPath = new StringBuffer();
			List<BaseArea> pAreas = baseAreaMapper.getAreaByChildId(pAreaId);
			if (pAreas != null && pAreas.size() > 0) {
				for (BaseArea area : pAreas) {
					path.append("-" + area.getAreaName());
					idPath.append("," + area.getBaseAreaId());
				}
				baseArea.setAreaPath(path.deleteCharAt(0).toString() + "-" + areaName);
				baseArea.setAreaIdPath(idPath.deleteCharAt(0).toString() + "," + areaId);
			}
		}
	}

	*//**
	 * 修改子行政区信息
	 * 
	 * @author Gwang
	 * @param areaId
	 *//*
	public void updateChildrenAreaInfo(String areaId) {
		List<BaseArea> cAreas = baseAreaMapper.getChildrenAreaByParentId(areaId);
		if (cAreas != null && cAreas.size() > 0) {
			for (BaseArea area : cAreas) {
				setAreaParentsInfo(area);
				baseAreaMapper.updateByPrimaryKeySelective(area);
			}
		}
	}

	*//**
	 * 行政区排序
	 * 
	 * @author Gwang
	 * @param areas
	 *//*
	public void updateAreaSort(List<BaseArea> areas) {
		baseAreaMapper.updateSortBatch(areas);
	}

	*//**
	 * 修改区域地图信息
	 * 
	 * @author Gwang
	 * @param area
	 *//*
	public void updateAreaMap(BaseArea area) {
		baseAreaMapper.updateByPrimaryKeySelective(area);
	}
*/
}
