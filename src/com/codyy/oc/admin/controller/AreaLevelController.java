package com.codyy.oc.admin.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.utils.ResultJson;
import com.codyy.oc.admin.entity.BaseConfigAreaLevel;
import com.codyy.oc.admin.service.AreaLevelService;

/**
 * ClassName: AreaLevelController date: 2015-3-25 下午7:44:08
 * 
 * @author Gwang
 * @version
 * @since JDK 1.7
 */
@Controller
@RequestMapping("admin/system/areaLevel")
public class AreaLevelController {
	
	@Autowired
	private AreaLevelService areaLevelService;
	
	@RequestMapping("index")
	public String index(HttpServletRequest request){
		request.setAttribute("areaLevels", areaLevelService.getAll());
		return "admin/system/areaLevelManager/areaLevel_list";
	}
	
	@ResponseBody
	@RequestMapping("getAreaLevel")
	public BaseConfigAreaLevel getAreaLevel(@RequestParam(required = true)String id){
		return areaLevelService.getById(id);
	}
	
	@ResponseBody
	@RequestMapping("addAreaLevel")
	public ResultJson addAreaLevel(BaseConfigAreaLevel areaLevel){
		if(StringUtils.isBlank(areaLevel.getLevelTitle()) || 
				StringUtils.isBlank(areaLevel.getMobileTitle()) || 
				areaLevel.getAreaLevel() == null){
			return new ResultJson(false,"参数错误！");
		}
		try {
			BaseConfigAreaLevel sel = new BaseConfigAreaLevel();
			sel.setLevelTitle(areaLevel.getLevelTitle());
			if(areaLevelService.getByAreaLevel(sel) != null){
				return new ResultJson(false,"电脑-级别名称已存在！");
			}
			sel = new BaseConfigAreaLevel();
			sel.setMobileTitle(areaLevel.getMobileTitle());
			if(areaLevelService.getByAreaLevel(sel) != null){
				return new ResultJson(false,"手机-级别名称已存在！");
			}
			sel = new BaseConfigAreaLevel();
			sel.setAreaLevel(areaLevel.getAreaLevel());
			if(areaLevelService.getByAreaLevel(sel) != null){
				return new ResultJson(false,"级别等级已存在！");
			}
			areaLevelService.addAreaLevel(areaLevel);
			return new ResultJson(true);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResultJson(false,"添加行政区级别错误！");
		}
	}
	
	@ResponseBody
	@RequestMapping("editAreaLevel")
	public ResultJson editAreaLevel(BaseConfigAreaLevel areaLevel){
		if(StringUtils.isBlank(areaLevel.getBaseConfigAreaLevelId()) || 
				StringUtils.isBlank(areaLevel.getLevelTitle()) || 
				StringUtils.isBlank(areaLevel.getMobileTitle()) || 
				areaLevel.getAreaLevel() == null){
			return new ResultJson(false,"参数错误！");
		}
		try {
			BaseConfigAreaLevel selres = null;
			BaseConfigAreaLevel sel = new BaseConfigAreaLevel();
			sel.setLevelTitle(areaLevel.getLevelTitle());
			selres = areaLevelService.getByAreaLevel(sel);
			if(selres != null && !selres.getBaseConfigAreaLevelId().equals(areaLevel.getBaseConfigAreaLevelId())){
				return new ResultJson(false,"电脑-级别名称已存在！");
			}
			sel = new BaseConfigAreaLevel();
			sel.setMobileTitle(areaLevel.getMobileTitle());
			selres = areaLevelService.getByAreaLevel(sel);
			if(selres != null && !selres.getBaseConfigAreaLevelId().equals(areaLevel.getBaseConfigAreaLevelId())){
				return new ResultJson(false,"手机-级别名称已存在！");
			}
			sel = new BaseConfigAreaLevel();
			sel.setAreaLevel(areaLevel.getAreaLevel());
			selres = areaLevelService.getByAreaLevel(sel);
			if(selres != null && !selres.getBaseConfigAreaLevelId().equals(areaLevel.getBaseConfigAreaLevelId())){
				return new ResultJson(false,"级别等级已存在！");
			}
			areaLevelService.editAreaLevel(areaLevel);
			return new ResultJson(true);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResultJson(false,"修改行政区级别错误！");
		}
	}
	
	@ResponseBody
	@RequestMapping("deleteAreaLevel")
	public ResultJson deleteAreaLevel(@RequestParam(required = true)String id){
		try {
			areaLevelService.deleteAreaLevel(id);
			return new ResultJson(true);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResultJson(false,"删除行政区级别错误！");
		}
	}

}
