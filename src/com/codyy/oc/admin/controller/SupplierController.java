package com.codyy.oc.admin.controller;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.entity.ContactPerson;
import com.codyy.oc.admin.entity.Project;
import com.codyy.oc.admin.entity.Supplier;
import com.codyy.oc.admin.entity.SupplierRProject;
import com.codyy.oc.admin.service.QualificationService;
import com.codyy.oc.admin.service.SupplierRProjectService;
import com.codyy.oc.admin.service.SupplierService;
import com.codyy.oc.admin.view.SupplierSearch;

@Controller
@RequestMapping("/admin/supplier/")
public class SupplierController {

	@Autowired
	private SupplierService supplierService;
	
	@Autowired
	private SupplierRProjectService supplierRProjectService;
	
	@Autowired
	private QualificationService qualificationService;
	/**
	 * @author lichen
	* @Title: jumpToSupplierList
	* @Description: (跳转到提供商列表界面)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptosupplierlist")
	public String jumpToSupplierList(){
		
		return "admin/supplierResource/supplierList";
	}
	
	/**
	 * @author lichen
	* @Title: jumpToAddSupplier
	* @Description: (跳转到添加供应商界面)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptoaddsupplier")
	public String jumpToAddSupplier(){
		
		return "admin/supplierResource/addSupplier";
	}
	
	/**
	 * @author lichen
	* @Title: jumpToEditSupplier
	* @Description: (编辑系统集成商)
	* @param @param supplyId
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptoeditsupplier")
	public String jumpToEditSupplier(HttpServletRequest request,String supplyId){
		//根据id来获得集成商的所有基本信息，并存放至request的域对象中
		Supplier supplier =supplierService.selcSuppById(supplyId);
		//根据集成商的id来查询本用户对应的资质表中的所有资质
		List<Attachment> quaList =qualificationService.qualifiListBySuId(supplyId);
		request.setAttribute("quaList", quaList);
		request.setAttribute("supplyer", supplier);
		return "admin/supplierResource/editSupplier";
	}
	
	
	/**
	 * @author lichen
	* @Title: jumpToSupplierDetail
	* @Description: (这里用一句话描述这个方法的作用)
	* @param @param request
	* @param @param supplyId
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptosupplierdetail")
	public String jumpToSupplierDetail(HttpServletRequest request,String supplyId){
		//根据id来获得集成商的所有基本信息，并存放至request的域对象中
				Supplier supplier =supplierService.selcSuppById(supplyId);
				//根据集成商的id来查询本用户对应的资质表中的所有资质
				List<Attachment> quaList =qualificationService.qualifiListBySuId(supplyId);
				if(null!=quaList && quaList.size()>0){
					request.setAttribute("showStatus", "y");
				}else{
					request.setAttribute("showStatus", "n");
				}
				request.setAttribute("quaList", quaList);
				request.setAttribute("supplyer", supplier);
				return "admin/supplierResource/supplierDetail";
		
	}
	
	
	/**
	 * @author lichen
	* @Title: jumpToShowQualification
	* @Description: (根据id来显示指定供应商资质列表(有分页))
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumpToShowQualification")
	public String jumpToShowQualification(HttpServletRequest request,String supplier_Id){
		
		request.setAttribute("supplierId", supplier_Id );
		//将集成商的id显示到跳转的指定页面  然后ajax实现分页列表显示
		return "admin/supplierResource/qualificationList";
	}
	
	/**
	 * @author lichen
	* @Title: jumpToProjectList
	* @Description: (由编辑集成商页面跳转到项目选择页面)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptoprojectlist")
	public String jumpToProjectList(){
		
		return "admin/resource/editProjectList";
	}
	
	
	/**
	 * @author lichen
	* @Title: updateSupper
	* @Description: (修改集成商的信息)
	* @param     设定文件
	* @return void    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("updateSupper")
	public ResultJson updateSupper(String projectList, Supplier supplier,String[] newFileName, String[] oraginalFileName){
		
	List<Attachment> qualifiList = new ArrayList<Attachment>();
	  
	    if(newFileName!=null && oraginalFileName!=null){
	    	
	    	for(int i=0; i<newFileName.length; i++){//将所有的文件的新名赋值到对象
				Attachment qualifi = new Attachment();
				qualifi.setRelationShipId(supplier.getSupplierId());
				qualifi.setAttachment_Url(newFileName[i]);
				qualifi.setName(oraginalFileName[i]);
				qualifi.setCreate_time(new Date());
				qualifiList.add(qualifi);
			}
	    }
		   
		
		//将修改后的本集成商对应的所有项目集合添加到集成商项目表关系表中
		List<String> projList = new ArrayList<String>();
		if(projectList!=null){
			String[] pList=projectList.split(",");
			for(int i=0; i<pList.length; i++){
				
				projList.add(pList[i]);
			}
		}
		
		SupplierRProject supplierRProject = new SupplierRProject();
		supplierRProject.setProjIdList(projList);
		supplierRProject.setSupplierId(supplier.getSupplierId());
		
		//修改集成商的基本信息
		return supplierService.updateSupplier(supplier,qualifiList,supplierRProject);
	}
	
	/**
	 * @author lichen
	* @Title: insertSupplier
	* @Description: (进行集成商的添加操作)
	* @param @param supplier
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	@ResponseBody  //返回值Integer处理
	@RequestMapping("insertsupplier")
	public ResultJson insertSupplier(HttpServletRequest request,Supplier supplier,String areaId,String projListString,String[] newFileName, String[] oraginalFileName){
       
		//给集成商的id赋值为UUid
		supplier.setSupplierId(UUIDUtils.getUUID());
		AdminUser adminUser = (AdminUser) request.getSession().getAttribute(AdminUser.ADMIN_SESSION_USER);
		//将创建用户加入
		supplier.setCreate_User(adminUser.getAdminUserId());
		supplier.setBaseAreaId(areaId);
		List<String> projectList = new ArrayList<String>();
		if(StringUtils.isNotBlank(projListString.trim())){
			String[] projList =projListString.split(",");
			for(int i=0; i<projList.length; i++){
				projectList.add(projList[i]);
			}
		}
		
		SupplierRProject supplierRProject = new SupplierRProject();
		supplierRProject.setSupplierId(supplier.getSupplierId());//将本用户加入集成商项目关系表
		supplierRProject.setProjIdList(projectList);//将本用户选中的所有项目id进行封装
		
		List<Attachment> qualifiList = new ArrayList<Attachment>();
		if(newFileName!=null && newFileName.length>0 && oraginalFileName!=null && oraginalFileName.length>0 ){
			for(int i=0; i<newFileName.length; i++){//将所有的文件的新名赋值到对象
				Attachment qualifi = new Attachment();
				qualifi.setRelationShipId(supplier.getSupplierId());
				qualifi.setAttachment_Url(newFileName[i]);
				qualifi.setName(oraginalFileName[i]);
				qualifi.setCreate_time(new Date());
				qualifiList.add(qualifi);
			}
		}
		
		
		return supplierService.insertSupplier(supplier,supplierRProject,qualifiList);//将集成商基本信息加入集成商表中
		
	}
	
	
	/**
	 * @author lichen
	* @Title: selcSupplierList
	* @Description: (对集成商的列表进行查询)
	* @param @param page
	* @param @return    设定文件
	* @return Page    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("selcsupplierlist")
	public Page selcSupplierList(Page page,String name,String baseAreaId,String qualification,String leftData,String rightData,String contactName,String contactPhone){
		
	 page.setData(supplierService.selcSupplierList(page,name,baseAreaId,qualification,leftData,rightData,contactName,contactPhone));
	 return page;
	}
	
	/**
	 * @author lichen
	* @Title: delSupplierById
	* @Description: (删除集成商的所有信息)
	* @param @param supplierId
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("delsupplierbyid")
	 public void delSupplierById(String supplierId){
		
		supplierService.delSupplierById(supplierId);//删除集成商基本信息表
	 }
	
	/**
	 * @author lichen
	* @Title: selcProjListBySuId
	* @Description: (根据集成商的id来获取其已选的所有项目集合)
	* @param @param supplierId
	* @param @return    设定文件
	* @return List<Project>    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("selcprojlistbysuid")
	public List<Project> selcProjListBySuId(String supplyId){
		
		return supplierService.selcProjListBySuId(supplyId);
	}
	
	/**
	 * @author lichen
	* @Title: selbyContent
	* @Description: (按条件对集成商的资源进行查询)
	* @param     设定文件
	* @return void    返回类型
	* @throws
	 */
	/*@RequestMapping("selbyContent")
	public void selbyContent(String name,String baseAreaId,String qualification,String leftData,String rightData,String contactName,String contactPhone){
		System.out.println("selbyContent……");
		System.out.println("name="+name+" ,baseAreaId="+baseAreaId+" ,qualification="+qualification+" ,leftData="+leftData+" ,rightData="+rightData+" ,contactName="+contactName+" ,contactPhone="+contactPhone);
	}*/
	
	
	/**
	 * @author lichen
	* @Title: jumpToProjList
	* @Description: (点击项目总数按钮来获取所有的合作项目个数窗口)
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptoprojlist")
	public String jumpToProjList(HttpServletRequest request,String supplier_Id){
		
		//System.out.println("supplierId="+supplier_Id);
		request.setAttribute("uId", supplier_Id);
		return "admin/supplierResource/showSupplierProjectList";
	}
	
	/**
	 * @author lichen
	* @Title: selcSupplierPriList
	* @Description: (获得集成商的所有合作项目列表)
	* @param @param page
	* @param @param supplier_Id
	* @param @return    设定文件
	* @return Page    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("selcsupplierprilist")
	public Page selcSupplierPriList(Page page, String supplier_Id){
		
		page.setData(supplierService.supplierProList(page, supplier_Id));
		return page;
	}
	
	/**
	 * @author lichen
	* @Title: contactPersonList
	* @Description: (这里用一句话描述这个方法的作用)
	* @param @param supplierId
	* @param @return    设定文件
	* @return List<ContactPerson>    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("contactpersonlist")
	public List<ContactPerson> contactPersonList(String supplier_Id){

		Supplier supplier =supplierService.contactPersonList(supplier_Id);
		List<ContactPerson> contactPersonList = new ArrayList<ContactPerson>();
		if(null!=supplier){
			String contactPersonNameOne=supplier.getContactPersonNameOne();
			String contactPersonJobOne=supplier.getContactPersonJobOne();
			String contactPersonPhoneOne=supplier.getContactPersonPhoneOne();
			String contactPersonNameTwo=supplier.getContactPersonNameTwo();
			String contactPersonJobTwo=supplier.getContactPersonJobTwo();
			String contactPersonPhoneTwo=supplier.getContactPersonPhoneTwo();
			String contactPersonNameThree=supplier.getContactPersonNameThree();
			String contactPersonJobThree=supplier.getContactPersonJobThree();
			String contactPersonPhoneThree=supplier.getContactPersonPhoneThree();
			
			if(contactPersonNameOne!=null || contactPersonJobOne!=null || contactPersonPhoneOne!=null){
				
				contactPersonList.add(new ContactPerson(contactPersonNameOne,contactPersonJobOne,contactPersonPhoneOne,"第一联系人"));
			}
			
	        if(contactPersonNameTwo!=null || contactPersonJobTwo!=null || contactPersonPhoneTwo!=null){
	        	
				contactPersonList.add(new ContactPerson(contactPersonNameTwo,contactPersonJobTwo,contactPersonPhoneTwo,"第二联系人"));
			}
	        
	        if(contactPersonNameThree!=null || contactPersonJobThree!=null || contactPersonPhoneThree!=null){
				
				contactPersonList.add(new ContactPerson(contactPersonNameThree,contactPersonJobThree,contactPersonPhoneThree,"第三联系人"));
			}
			
		}
		
        return contactPersonList;
		
	}
	
	/**
	 * @author lichen
	* @Title: jumpToContactPersonList
	* @Description: (跳转到联系人显示页面)
	* @param @param supplier_Id
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	@RequestMapping("jumptocontactpersonlist")
	public String jumpToContactPersonList(HttpServletRequest request, String supplier_Id){
		
		request.setAttribute("supplier_Id", supplier_Id);
		return "admin/supplierResource/suppContactPerson";
	}
	
	/**
	 * @author lichen
	* @Title: exportSupplierList
	* @Description: (导出多条件查询的集成商列表)
	* @param     设定文件
	* @return void    返回类型
	* @throws
	 */
	@RequestMapping("exportSupplierList")
	public void exportSupplierList(SupplierSearch supplierSearch,HttpServletResponse response){
		
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment; filename=exportSupplierList.xls");
		try {
			OutputStream out = response.getOutputStream();
			HSSFWorkbook workbook=supplierService.exportSupplierList(supplierSearch);
			workbook.write(out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @author lichen
	* @Title: getQualiListBySuId
	* @Description: (根据集成商的id来实现对应资质集合的分页列表显示)
	* @param @param page
	* @param @param supplier_Id
	* @param @return    设定文件
	* @return Page    返回类型
	* @throws
	 */
	@ResponseBody
	@RequestMapping("getqualilistbysuid")
	public Page getQualiListBySuId(Page page,String supplier_Id){
		
		List<Attachment> quaList = qualificationService.qualificatListPageList(supplier_Id, page);
		page.setData(quaList);
		return page;
	}

}
