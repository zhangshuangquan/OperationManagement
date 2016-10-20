package com.codyy.oc.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.oc.admin.dao.SignMapper;
import com.codyy.oc.admin.view.MapView;

@Controller
@RequestMapping("/admin/map/")
public class MapController {
	@Autowired
	private SignMapper signmap;
	
	@RequestMapping("map1")
	public String  map1(HttpServletRequest request, Model model ){
		return "/admin/map/map1";
	}
	
	@RequestMapping("map1date")
	@ResponseBody
	public List<MapView>   map1date(HttpServletRequest request, Model model ){
		List<MapView> points = signmap.getSingMap("4c3b29062aa0496584a45d45a0104ba9");
		return points;
	}
	
	@RequestMapping("map2")
	public String  map2(HttpServletRequest request, Model model ){
		return "/admin/map/map2";
	}
	
	@RequestMapping("map3")
	public String  map3(HttpServletRequest request, Model model ){
		return "/admin/map/map3";
	}
	
	@RequestMapping("map4")
	public String  map4(HttpServletRequest request, Model model ){
		return "/admin/map/map4";
	}
	
	@RequestMapping("map5")
	public String  map5(HttpServletRequest request, Model model ){
		return "/admin/map/map5";
	}
	
	@RequestMapping("map6")
	public String  map6(HttpServletRequest request, Model model ){
		return "/admin/map/map6";
	}
	
}
