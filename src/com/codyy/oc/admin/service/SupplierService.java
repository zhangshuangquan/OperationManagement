package com.codyy.oc.admin.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ExcelAnnocationUtils;
import com.codyy.commons.utils.OracleKeyWordUtils;
import com.codyy.commons.utils.ResultJson;
import com.codyy.oc.admin.dao.AttachmentMapper;
import com.codyy.oc.admin.dao.SupplierMapper;
import com.codyy.oc.admin.dao.SupplierRProjectMapper;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.entity.Project;
import com.codyy.oc.admin.entity.Supplier;
import com.codyy.oc.admin.entity.SupplierRProject;
import com.codyy.oc.admin.view.SupplierSearch;

@Service
public class SupplierService {

	@Autowired
	private SupplierMapper supplierMapper;
	
	@Autowired
	private AttachmentMapper qualificationMapper;
	
	@Autowired
	private SupplierRProjectMapper supplierRProjectMapper;
	
	/**
	 * @author lichen
	* @Title: insertSuppRProject
	* @Description: (添加集成商与项目之间的关系表数据)
	* @param @param supplierRProject
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public Integer insertSuppRProject(SupplierRProject supplierRProject){
		
		return supplierRProjectMapper.insertSuppRProject(supplierRProject);
	}
	
	
	
	/**
	 * @author lichen
	* @Title: insertSupplier
	* @Description: (执行集成商的添加操作)
	* @param @param supplier
	* @param @return    设定文件
	* @return Integer    返回类型
	* @throws
	 */
	public ResultJson insertSupplier(Supplier supplier,SupplierRProject sRProject,List<Attachment> qLi){
		try{
			 if("第一联系人".equals(supplier.getContactPersonNameOne())){
				 supplier.setContactPersonNameOne("");
			 }
			 if("职位".equals(supplier.getContactPersonJobOne())){
				 supplier.setContactPersonJobOne("");
			 }
			 if("联系方式".equals(supplier.getContactPersonPhoneOne())){
				 supplier.setContactPersonPhoneOne("");
			 }
			 if("第二联系人".equals(supplier.getContactPersonNameTwo())){
				 supplier.setContactPersonNameTwo("");
			 }
			 if("职位".equals(supplier.getContactPersonJobTwo())){
				 supplier.setContactPersonJobTwo("");
			 }
			 if("联系方式".equals(supplier.getContactPersonPhoneTwo())){
				 supplier.setContactPersonPhoneTwo("");
			 }
			 if("第三联系人".equals(supplier.getContactPersonNameThree())){
				 supplier.setContactPersonNameThree("");
			 }
			 if("职位".equals(supplier.getContactPersonJobThree())){
				 supplier.setContactPersonJobThree("");
			 }
			 if("联系方式".equals(supplier.getContactPersonPhoneThree())){
				 supplier.setContactPersonPhoneThree("");
			 }
			//1.保存供应商
			  supplier.setCreate_Time(new Date());//封装新增用户创建时间
			  supplierMapper.insertSupplier(supplier); 		
			//2.保存供应商项目关联
			  if(sRProject.getProjIdList()!=null && sRProject.getProjIdList().size()>0){
				  supplierRProjectMapper.insertSuppRProject(sRProject); 
			  }
			 
			//3.保存供应商资质关系
			  if(qLi!=null && qLi.size()>0){
				  qualificationMapper.insertQualification(qLi); 
			  }  
			  return new ResultJson(true);
		}catch(Exception e){
			
				e.printStackTrace();
				return new ResultJson(false);
		}
		
	}
	
	/**
	 * @author lichen
	* @Title: selcSupplierList
	* @Description: (进行集成商列表查询)
	* @param @param page
	* @param @return    设定文件
	* @return List<Supplier>    返回类型
	* @throws
	 */
	public List<Supplier> selcSupplierList(Page page,String name,String baseAreaId,String qualification,String leftData,String rightData,String contactName,String contactPhone){
	   //封装参数
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("name", OracleKeyWordUtils.oracleKeyWordReplace(name));
		map.put("baseAreaId", baseAreaId);
		map.put("qualification", qualification);
		map.put("leftData", OracleKeyWordUtils.oracleKeyWordReplace(leftData));//放置%搜索
		map.put("rightData", OracleKeyWordUtils.oracleKeyWordReplace(rightData));
		map.put("contactName", OracleKeyWordUtils.oracleKeyWordReplace(contactName));
		map.put("contactPhone", OracleKeyWordUtils.oracleKeyWordReplace(contactPhone));
		page.setMap(map);
		return supplierMapper.selcSupplierPageList(page);
	}
	
	
	 /**
	  * @author lichen
	 * @Title: delSupplierById
	 * @Description: (根据集成商的id来删除对应的集成商)
	 * @param @param supplierId
	 * @param @return    设定文件
	 * @return Integer    返回类型
	 * @throws
	  */
	 public void delSupplierById(String supplierId){
		 
		 qualificationMapper.deleteQualiBysuId(supplierId);//删除集成商对应的所有资质
		 supplierRProjectMapper.delSupplRProjBySuId(supplierId);//删除本集成商对应集成商项目表中所有项目
		 supplierMapper.delSupplierById(supplierId);//删除集成商基本信息表
	 }
	 
	 /**
	  * @author lichen
	 * @Title: selcSuppById
	 * @Description: (根据集成商的id来获取对应的集成商对象)
	 * @param @param supplierId
	 * @param @return    设定文件
	 * @return Supplier    返回类型
	 * @throws
	  */
	 public Supplier selcSuppById(String supplierId){
		 
		 return supplierMapper.selcSuppById(supplierId);
	 }
	 
	 
	 /**
	  * @author lichen
	 * @Title: selcProjListBySuId
	 * @Description: (根据集成商的id来获取已选的所有项目集合)
	 * @param @param supplierId
	 * @param @return    设定文件
	 * @return List<Project>    返回类型
	 * @throws
	  */
	 public List<Project> selcProjListBySuId(String supplierId){
		 
		 return supplierMapper.selcProjListBySuId(supplierId);
	 }
	 
	 
	 /**
	  * @author lichen
	 * @Title: updateSupplier
	 * @Description: (这里用一句话描述这个方法的作用)
	 * @param @param supplier
	 * @param @return    设定文件
	 * @return Integer    返回类型
	 * @throws
	  */
	 public ResultJson updateSupplier(Supplier supplier,List<Attachment> qualifiList,SupplierRProject supplierRProject){
		 
		 try{
			 if("第一联系人".equals(supplier.getContactPersonNameOne())){
				 supplier.setContactPersonNameOne("");
			 }
			 if("职位".equals(supplier.getContactPersonJobOne())){
				 supplier.setContactPersonJobOne("");
			 }
			 if("联系方式".equals(supplier.getContactPersonPhoneOne())){
				 supplier.setContactPersonPhoneOne("");
			 }
			 if("第二联系人".equals(supplier.getContactPersonNameTwo())){
				 supplier.setContactPersonNameTwo("");
			 }
			 if("职位".equals(supplier.getContactPersonJobTwo())){
				 supplier.setContactPersonJobTwo("");
			 }
			 if("联系方式".equals(supplier.getContactPersonPhoneTwo())){
				 supplier.setContactPersonPhoneTwo("");
			 }
			 if("第三联系人".equals(supplier.getContactPersonNameThree())){
				 supplier.setContactPersonNameThree("");
			 }
			 if("职位".equals(supplier.getContactPersonJobThree())){
				 supplier.setContactPersonJobThree("");
			 }
			 if("联系方式".equals(supplier.getContactPersonPhoneThree())){
				 supplier.setContactPersonPhoneThree("");
			 }
			 
			  supplierMapper.updateSupplier(supplier);//修改集成商的基本信息
			  supplierRProjectMapper.delSupplRProjBySuId(supplier.getSupplierId());//删除集成商项目表中本集成商对应的所有项目的id
			  qualificationMapper.deleteQualiBysuId(supplier.getSupplierId());//根据用户的id来删除用户对应的所有资质
			  if(qualifiList!=null && qualifiList.size()>0){
				  qualificationMapper.insertQualification(qualifiList);//给指定用户添加集成商资质  
			  }
			  if(supplierRProject.getProjIdList()!=null && supplierRProject.getProjIdList().size()>0){
				  this.insertSuppRProject(supplierRProject);//给指定用户添加多个项目 
			  }
			  return new ResultJson(true);
		 }catch(Exception e){
			 
			 e.printStackTrace();
			 return new ResultJson(false);
		 }
		 
	 }
	 
	 /**
	  * @author lichen
	 * @Title: supplierProPageList
	 * @Description: (获得集成商合作项目列表)
	 * @param @param page
	 * @param @return    设定文件
	 * @return List<Project>    返回类型
	 * @throws
	  */
	 public List<Project> supplierProList(Page page,String supplier_Id){
		 
		 Map<String,Object> map = new HashMap<String,Object>();
		 map.put("supplierId", supplier_Id);
		 page.setMap(map);
		 return supplierMapper.supplierProPageList(page);
	 }
	 
	 /**
	  * @author lichen
	 * @Title: contactPersonList
	 * @Description: (根据集成商的id来获取集成商的所有联系人信息)
	 * @param @param supplierId
	 * @param @return    设定文件
	 * @return Supplier    返回类型
	 * @throws
	  */
	 public Supplier contactPersonList(String supplierId){
		 
		 return supplierMapper.contactPersonList(supplierId);
	 }
	 
	 /**
	  * @author lichen
	 * @Title: exportSupplierList
	 * @Description: (导出多重查询的集成商的列表)
	 * @param @return    设定文件
	 * @return HSSFWorkbook    返回类型
	 * @throws
	  */
	 public HSSFWorkbook exportSupplierList(SupplierSearch supplierSearch){
		 
		 Map<String, Object> map = new HashMap<String,Object>();
		 map.put("baseAreaId", supplierSearch.getBaseAreaId());
		 map.put("name", supplierSearch.getName());
		 map.put("qualification", supplierSearch.getQualification());
		 map.put("leftData", supplierSearch.getLeftData());
		 map.put("rightData",supplierSearch.getRightData());
		 map.put("contactName",supplierSearch.getContactName());
		 map.put("contactPhone", supplierSearch.getContactPhone());
		 
		 List<Supplier> suList =supplierMapper.getExportSupplierList(map);
		 return ExcelAnnocationUtils.exportExcelData(Supplier.class, suList);
	 }
}
