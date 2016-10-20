package com.codyy.oc.admin.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.SecurityUtil;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.BaseController;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.AdminUserPermission;
import com.codyy.oc.admin.service.AdminUserManagerService;
import com.codyy.oc.admin.service.AdminUserPermissionService;
import com.codyy.oc.admin.view.UserSearchModel;

@Controller
@RequestMapping("/admin/adminuser/")
public class AdminUserManagerController extends BaseController {
	
	@Autowired
	private AdminUserManagerService adminUserManagerService;
	
	@Autowired
	private AdminUserPermissionService adminUserPermissionService;
	
	
	/**
	 * @author lichen
	* @Title: insertAdminUser
	* @Description: (这里用一句话描述这个方法的作用)
	* @param @param request
	* @param @param adUser    设定文件
	* @return void    返回类型
	* @throws
	 */
	//@RequestMapping("insertAdminUser")
	@ResponseBody
	@RequestMapping("insertadminuser")
	public ResultJson  insertAdminUser(HttpServletRequest request, AdminUser adUser ){
		
		if("".equals(adUser.getAdminUserId())){//添加用户操作自动生成id
			
			adUser.setAdminUserId(UUIDUtils.getUUID());//自动生成id
		}
		adUser.setCreateTime(new Date());//记录当前时间
		adUser.setPassword(SecurityUtil.MD5String(adUser.getPassword()));//密码进行MD5加密
	
		//如果用户做修改操作的时候即用户名是存在的    即不用自动生成    若修改则不用创建id
			AdminUserPermission adminUser = new AdminUserPermission();
			if(!"".equals(adUser.getFunctionList())){
				adminUser.setFunctionList(adUser.getFunctionList());
			}else{
				adminUser.setFunctionList(null);
			}
			adminUser.setAdminUserId(adUser.getAdminUserId());
		return adminUserManagerService.insertAdminUsers(adUser,adminUser);
	
		
		
	}
	
	/**
	 * @author lichen
	* @Title: updateUserAdmin
	* @Description: (更新用户)
	* @param @param request
	* @param @param adUser    设定文件
	* @return void    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("updateuseradmin")
	public ResultJson updateUserAdmin(HttpServletRequest request, AdminUser adUser){
		
		String userId=adUser.getAdminUserId();
		
		adUser.setCreateTime(new Date());//记录当前时间
           //用户不输入密码即密码不进行修改
		if("".equals(adUser.getPassword())){
			
			
			
		}else{
			//用户修改密码
			adUser.setPassword(SecurityUtil.MD5String(adUser.getPassword()));//密码进行MD5加密
		}
		
		AdminUserPermission adminUser = new AdminUserPermission();
		if(!"".equals(adUser.getFunctionList())){
			adminUser.setFunctionList(adUser.getFunctionList());
		}else{
			adminUser.setFunctionList(null);
		}
		
		adminUser.setAdminUserId(adUser.getAdminUserId());
		return adminUserManagerService.updateAdminsUser(userId,adUser,adminUser);//修改用户详情列表的信息

	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toAddAdminUser
		* @Description: (去添加用户)
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toaddadminuser")
	public String toAddAdminUser(){
		return "admin/administrator/addAdministrator";
	}
	
	/**
	 * @author lichen
	* @Title: getselcAdminUserById
	* @Description: (这里用一句话描述这个方法的作用)
	* @param @param userId
	* @param @return    设定文件
	* @return AdminUser    返回类型
	* @throws
	 */
	@RequestMapping("getselbyid")
	public ModelAndView getselcAdminUserById(String userId){
	
		System.out.println("getselcAdminUserById……");
		AdminUser adUser=adminUserManagerService.getselcAdminUserById(userId);
		ModelAndView model = new ModelAndView("/admin/administrator/updateAdministrator");
		model.addObject("user", adUser);
	    return model;	
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: toAdminList
		* @Description: (跳转到orgUserList.jsp页面)
		* @return String    返回类型
		* @throws
	 */
	@RequestMapping("toadminlist")
	public String toAdminList(){
		return "admin/administrator/showAdministratorList";		
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: getAdminList
		* @Description: (查询用户列表)
		* @return Page   
	 */
	@ResponseBody
	@RequestMapping("getadminlist")
	public Page getAdminList(Page page,UserSearchModel userSearch){
		return adminUserManagerService.getAdminList(page, userSearch);
		
	}
	
	/**
	 * 
		* @author zhangshuangquan
		* @Title: deleteAdminUserById
		* @Description: (删除用户)
		* @return Page   
	 */
	@ResponseBody
	@RequestMapping("deleteadminuserbyid")
	public ResultJson deleteAdminUserById(@RequestParam String adminUserId){
		return adminUserManagerService.deleteAdminUserById(adminUserId);
		
		
	}
	
	/**
	 * @author lichen
	* @Title: selUserName
	* @Description: (验证用户名唯一)
	* @param @param userName
	* @param @return    设定文件
	* @return List<AdminUser>    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("selUserName")
	public List<AdminUser> selUserName(String userName){
		
		return adminUserManagerService.selUserName(userName);
	}
	
	@ResponseBody
	@RequestMapping("checkseluptename")
	public List<AdminUser> checkSelUpteName(AdminUser adminUser){
		
		return adminUserManagerService.checkSelUpteName(adminUser);
	}
}
