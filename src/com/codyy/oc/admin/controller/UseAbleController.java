package com.codyy.oc.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.dao.CommonsMapper;

@Controller
@RequestMapping("/admin/use/")
public class UseAbleController extends BaseController {
	
	@Autowired
	private CommonsMapper commonsmap;
	
	
	/**
	 * 
	* @Title: count
	* @Description: 统计页面
	* @param @param request
	* @param @param adUser
	* @param @return
	* @return String    
	* @throws
	 */
	@RequestMapping("count")
	public String  count(HttpServletRequest request, Model model ){
		List<String> count = commonsmap.getCount();
		List<String> zhoucount = commonsmap.getZhouCount();
		model.addAttribute("count", count);
		model.addAttribute("zhoucount", zhoucount);
		return "/admin/use/count";
	}
	
}
