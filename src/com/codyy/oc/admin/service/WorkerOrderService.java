package com.codyy.oc.admin.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codyy.commons.page.Page;
import com.codyy.commons.utils.ExcelAnnocationUtils;
import com.codyy.commons.utils.OracleKeyWordUtils;
import com.codyy.commons.utils.ResultJson;
import com.codyy.commons.utils.UUIDUtils;
import com.codyy.oc.admin.dao.AttachmentMapper;
import com.codyy.oc.admin.dao.MaintenanceOrderMapper;
import com.codyy.oc.admin.entity.AdminUser;
import com.codyy.oc.admin.entity.Attachment;
import com.codyy.oc.admin.entity.EquipmentDelivery;
import com.codyy.oc.admin.entity.MaintenanceOrder;
import com.codyy.oc.admin.entity.UserROrder;
import com.codyy.oc.admin.view.ProblemRMainTenance;
import com.codyy.oc.admin.view.SearchSchoolInfoView;
import com.codyy.oc.admin.view.StringExceptionHandler;
import com.codyy.oc.admin.view.UserSearchModel;
import com.codyy.oc.admin.view.WorkOrderSearch;
import com.codyy.oc.admin.view.WorkOrderView;

@Service
public class WorkerOrderService {

	@Autowired
	private MaintenanceOrderMapper  mOrderMapper;
	
	@Autowired
	private AttachmentMapper  attachmentMapper;
	

	/**
	 * 
		* @author zhangshuangquan
		* @Title: addAfterSale
		* @Description: (添加售后保障记录)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	public ResultJson addAfterSale(MaintenanceOrder mOrder, String engineer,
			String[] equipTime, String[] equipMsg, String[] expressCompanyStr,String[] expressNumStr,String[] problemType) {
	   try {
		
	    boolean flag = false;
	    boolean result = false;
		mOrder.setMaintenanceOrderId(UUIDUtils.getUUID());
		mOrder.setCreateTime(new Date());
		String[] str = engineer.split(",");
		List<UserROrder> userROrders = null;
       if(StringUtils.isNotBlank(engineer)){
    	   userROrders = new ArrayList<UserROrder>();
    	 //工程师与工单
   		 for(int i=0;i<str.length;i++){
   	     	UserROrder userROrder = new UserROrder();
   	     	userROrder.setAdminUserId(str[i]);
   	     	userROrder.setMaintenanceOrderId(mOrder.getMaintenanceOrderId());
   	     	userROrder.setUserROrderId(UUIDUtils.getUUID());
   	     	userROrders.add(userROrder);
   		 }
   		flag=true;
       }
       List<EquipmentDelivery> eDeliveries=null;  
       if(equipMsg.length>0||equipTime.length>0 || expressCompanyStr.length>0 || expressNumStr.length>0){
    	   if(equipMsg.length==0){
       	     equipMsg=new String[equipTime.length];
       	   }
    	   if(expressCompanyStr.length==0){
    		 expressCompanyStr= new String[equipTime.length];
    	   }
    	   if(expressNumStr.length==0){
    		   expressNumStr=new String[equipTime.length];
    	   }
       	   if(equipTime.length==0){
       		 equipTime=new String[equipMsg.length];
       	   }
		    eDeliveries = new ArrayList<EquipmentDelivery>();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			for(int i=0;i<equipTime.length;i++){
				if("".equals(equipMsg[i])&&"".equals(equipTime[i])){
			         continue;
			   }else{
				EquipmentDelivery eqDelivery = new EquipmentDelivery();
				eqDelivery.setEquipmentDeliveryId(UUIDUtils.getUUID());
				eqDelivery.setMaintenanceOrderId(mOrder.getMaintenanceOrderId());
				  if("".equals(equipMsg[i])||equipMsg[i]==null){
						eqDelivery.setName("");
					  }else{
						eqDelivery.setName(equipMsg[i]);
					  }
				  if("".equals(expressCompanyStr[i])||expressCompanyStr[i]==null){
						eqDelivery.setExpressCompany("");
					  }else{
						eqDelivery.setExpressCompany(expressCompanyStr[i]);
					  }
				  if("".equals(expressNumStr[i])||expressNumStr[i]==null){
						eqDelivery.setExpressNum("");
					  }else{
						eqDelivery.setExpressNum(expressNumStr[i]);
					  }
				  
					  try {
						if("".equals(equipTime[i])||equipTime[i]==null){
						  eqDelivery.setDeliveryTime(null);
						}else{
							eqDelivery.setDeliveryTime(sdf.parse(equipTime[i]));
						}
					
					  } catch (ParseException e) {
						return StringExceptionHandler.handlerException(e);
					  }
				 eDeliveries.add(eqDelivery);
				 result=true;
			   }
			 
			}
			
       }
       
    
       
       
        String orderNum=mOrderMapper.getOrderNum();//生成工单编号  
        mOrder.setOrderNum(orderNum);
		int i=mOrderMapper.insertSelective(mOrder);//必须先添加主表才可添加其他依赖的关系表(不然无主键)
		
		if(i>0){
			
			   List<ProblemRMainTenance> ProblemRMainTenanceList = new ArrayList<ProblemRMainTenance>();
		       if(problemType.length>0){
		    	   
		    	   for(int k=0; k<problemType.length; k++){
		    		   ProblemRMainTenance problemRMainTenance = new ProblemRMainTenance();
		    		   problemRMainTenance.setProblemRMainTenanceId(UUIDUtils.getUUID());
		    		   problemRMainTenance.setMaintennanceOrderId(mOrder.getMaintenanceOrderId());
		    		   problemRMainTenance.setProblemType(problemType[k]);
		    		   ProblemRMainTenanceList.add(problemRMainTenance);
		    	   }
		    	   
		    	   mOrderMapper.insertProblemType(ProblemRMainTenanceList);//添加本工单存在的问题类型
		       }
		       
			if(flag){
				 mOrderMapper.addUserROrder(userROrders);
			}
			if(result){
				 mOrderMapper.addEquipDelivery(eDeliveries);
			}
				
			
			 return new ResultJson(true,"添加成功！");
		}	} catch (Exception e) {
			return StringExceptionHandler.handlerException(e);
		}
		return null;
	}

	/**
	 * 
		* @author zhangshuangquan
		* @Title: getWorkOrderList
		* @Description: (分页显示工单列表)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	public Page getWorkOrderList(WorkOrderSearch workOrderSearch, Page page) {
		 Map<String,Object> map = new HashMap<String, Object>();
		 map.put("projectAreaId", workOrderSearch.getProjectAreaId());
		 map.put("clsSchoolAreaId", workOrderSearch.getClsSchoolAreaId());
		 map.put("projectName", OracleKeyWordUtils.oracleKeyWordReplace(workOrderSearch.getProjectName().trim()));
		 map.put("clsSchoolName", OracleKeyWordUtils.oracleKeyWordReplace(workOrderSearch.getClsSchoolName().trim()));
		 map.put("contact",OracleKeyWordUtils.oracleKeyWordReplace(workOrderSearch.getContact().trim()));
		 map.put("phone",OracleKeyWordUtils.oracleKeyWordReplace(workOrderSearch.getPhone().trim()));
		 map.put("repair",OracleKeyWordUtils.oracleKeyWordReplace(workOrderSearch.getRepair().trim()));
		 map.put("isState", workOrderSearch.getIsState());
		 map.put("type","baozhang");
		 page.setMap(map);
		 List<WorkOrderView> maOrders = mOrderMapper.getWorkOrderPageList(page);
		 page.setData(maOrders);
		 return page;
	}

	/**
	 * 
		* @author zhangshuangquan
		* @Title: exportWorkOrderList
		* @Description: (导出工单列表)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	public HSSFWorkbook exportWorkOrderList(WorkOrderSearch workOrderSearch) {
		 Map<String,Object> map = new HashMap<String, Object>();
		 map.put("projectAreaId", workOrderSearch.getProjectAreaId());
		 map.put("clsSchoolAreaId", workOrderSearch.getClsSchoolAreaId());
		 map.put("projectName", OracleKeyWordUtils.oracleKeyWordReplace(workOrderSearch.getProjectName()));
		 map.put("clsSchoolName", OracleKeyWordUtils.oracleKeyWordReplace(workOrderSearch.getClsSchoolName()));
		 map.put("contact",OracleKeyWordUtils.oracleKeyWordReplace(workOrderSearch.getContact()));
		 map.put("phone",OracleKeyWordUtils.oracleKeyWordReplace(workOrderSearch.getPhone()));
		 map.put("repair",OracleKeyWordUtils.oracleKeyWordReplace(workOrderSearch.getRepair()));
		 map.put("isState", workOrderSearch.getIsState());
		 List<WorkOrderView> workOrderViews =mOrderMapper.exportWorkOrderList(map);
		 for (WorkOrderView workOrderView : workOrderViews) {
			 workOrderView.getMaxDateStr();
			 workOrderView.getRepair();
		 }
		 return ExcelAnnocationUtils.exportExcelData(WorkOrderView.class, workOrderViews);
	}

	/**
	 * 
		* @author zhangshuangquan
		* @Title: getWorkOrderById
		* @Description: (通过工单id获取编辑信息)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	public Map<String,Object> getWorkOrderById(String maintenanceOrderId) {
		if(StringUtils.isNotBlank(maintenanceOrderId)){
			Map<String,Object> map=new HashMap<String, Object>();
			WorkOrderView workOrderView=mOrderMapper.getWorkOrderById(maintenanceOrderId);
			String submitter=mOrderMapper.getOrderSumitter(maintenanceOrderId); 
			List<AdminUser>   engineers=mOrderMapper.getUserROrder(maintenanceOrderId);
		    List<EquipmentDelivery> equipmentDeliveries=mOrderMapper.getEquipDelivery(maintenanceOrderId);
		    Integer equipNum=0;
		    if(null!=equipmentDeliveries && equipmentDeliveries.size()>0){
		    	equipNum=equipmentDeliveries.size();
		    }
		    map.put("submitter", submitter);
		    map.put("equipNum", equipNum);//设备的个数
			map.put("workOrder",workOrderView);
			map.put("engineers",engineers);
			map.put("equip",equipmentDeliveries);
			return map;
		}
		return null;
	}

	/**
	 * 
		* @author zhangshuangquan
		* @Title: getEngineersById
		* @Description: (获取工程师)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	public List<AdminUser> getEngineersById(String id) {
		if(StringUtils.isNotBlank(id)){
			String[] s=id.split(",");
            List<String> strs=new ArrayList<String>();
			for (int i = 0; i < s.length; i++) {
				strs.add(s[i]);
			}
			List<AdminUser> adminUsers=mOrderMapper.getEngineersById(strs);
			return adminUsers;
		}
		return null;
	}

	/**
	 * 
		* @author zhangshuangquan
		* @Title: editAfterSaleRecord
		* @Description: (编辑售后保障记录)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	public ResultJson editAfterSaleRecord(MaintenanceOrder mOrder,
			String engineer, String[] equipTime, String[] equipMsg,String[] expressCompanyStr,String[] expressNumStr,String[] problemType) {
		    
		try {
			
			if(problemType.length>0 && null!=problemType){
				List<ProblemRMainTenance> problemList= new ArrayList<ProblemRMainTenance>();
				//先删除关联的问题类型
				mOrderMapper.deleProblemById(mOrder.getMaintenanceOrderId());
				//重新关联新的类型problemOrder
				for(String value : problemType){
					ProblemRMainTenance problemOrder = new ProblemRMainTenance();
					problemOrder.setProblemRMainTenanceId(UUIDUtils.getUUID());
					problemOrder.setMaintennanceOrderId(mOrder.getMaintenanceOrderId());
					problemOrder.setProblemType(value);
					problemList.add(problemOrder);
				}
				
				mOrderMapper.insertProblemType(problemList);
			}else{
				//删除所有问题类型
				mOrderMapper.deleProblemById(mOrder.getMaintenanceOrderId());
			}
			
			String[] str=engineer.split(",");
			List<UserROrder> userROrders=new ArrayList<UserROrder>();
			boolean flag = false;
			boolean result = false;
            if(StringUtils.isNotBlank(engineer)){
            	int m = mOrderMapper.checkUserROrder(mOrder.getMaintenanceOrderId());
            	if(m>0){
            		mOrderMapper.deleteUserROrder(mOrder.getMaintenanceOrderId());	
            	}
            	//工程师与工单
    			for(int i=0;i<str.length;i++){
    		     	UserROrder userROrder=new UserROrder();
    		     	userROrder.setAdminUserId(str[i]);
    		     	userROrder.setUserROrderId(UUIDUtils.getUUID());
    		     	userROrder.setMaintenanceOrderId(mOrder.getMaintenanceOrderId());
    		     	userROrders.add(userROrder);
    			}
    			flag = true;
            }else{
            	//判断是否有工程师
            	int i = mOrderMapper.checkUserROrder(mOrder.getMaintenanceOrderId());
            	if(i>0){
            		mOrderMapper.deleteUserROrder(mOrder.getMaintenanceOrderId());
            		flag = false;
            	} 
            }
            List<EquipmentDelivery>   eDeliveries=null;       
            if(equipMsg.length>0||equipTime.length>0 || expressCompanyStr.length>0 || expressNumStr.length>0){ 
            	if(equipMsg.length==0){
            	    equipMsg=new String[equipTime.length];
            	}
            	if(equipTime.length==0){
            		equipTime=new String[equipMsg.length];
            	}
            	if(expressCompanyStr.length==0){
            		expressCompanyStr= new String[equipTime.length];
            	}
            	if(expressNumStr.length==0){
            		expressNumStr = new String[expressCompanyStr.length];
            	}
            	int m = mOrderMapper.checkEquipDelivery(mOrder.getMaintenanceOrderId());
            	if(m > 0){
            		mOrderMapper.deleteEquipDelivery(mOrder.getMaintenanceOrderId());
            	}
		        eDeliveries = new ArrayList<EquipmentDelivery>();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				for(int i=0;i<equipTime.length;i++){
					if("".equals(equipMsg[i])&&"".equals(equipTime[i])){
					         continue;
					}else{
						EquipmentDelivery eqDelivery=new EquipmentDelivery();
						eqDelivery.setEquipmentDeliveryId(UUIDUtils.getUUID());
						eqDelivery.setMaintenanceOrderId(mOrder.getMaintenanceOrderId());
					
					  if("".equals(equipMsg[i])||equipMsg[i]==null){
						eqDelivery.setName("");
					  }else{
						eqDelivery.setName(equipMsg[i]);
					  }
					  
					  if("".equals(expressCompanyStr[i])||expressCompanyStr[i]==null){
							eqDelivery.setExpressCompany("");
						  }else{
							eqDelivery.setExpressCompany(expressCompanyStr[i]);
						  }
					  
					  if("".equals(expressNumStr[i])||expressNumStr[i]==null){
							eqDelivery.setExpressNum("");
						  }else{
							eqDelivery.setExpressNum(expressNumStr[i]);
						  }
					  
					  try {
						if("".equals(equipTime[i])||equipTime[i]==null){
						  eqDelivery.setDeliveryTime(null);
						}else{
							eqDelivery.setDeliveryTime(sdf.parse(equipTime[i]));
						}
					
					  } catch (ParseException e) {
						return StringExceptionHandler.handlerException(e);
					  }
					 eDeliveries.add(eqDelivery);
					 result = true;
				  }
				}
				
            }else{
            	//判断是否有设备寄送信息
            	int i = mOrderMapper.checkEquipDelivery(mOrder.getMaintenanceOrderId());
            	if(i>0){
            		mOrderMapper.deleteEquipDelivery(mOrder.getMaintenanceOrderId());
            		result = false;
            	}
            	 
            }
			int i = mOrderMapper.updateByPrimaryKeySelective(mOrder);
			if(i>0){
				if(flag){
					 mOrderMapper.addUserROrder(userROrders);
				}
				if(result){
					 mOrderMapper.addEquipDelivery(eDeliveries);	
				}
				return new ResultJson(true,"编辑成功！");
			}} catch (Exception e) {
				return StringExceptionHandler.handlerException(e);
			}
			return new ResultJson(false,"编辑失败！");
		
	}

	/**
	 * 
		* @author zhangshuangquan
		* @Title: delWorkOrder
		* @Description: (删除工单)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	public ResultJson delWorkOrder(String maintenanceOrderId) {
		if(StringUtils.isNotBlank(maintenanceOrderId)){
			int  i = mOrderMapper.getSignCountByOrderId(maintenanceOrderId);
			if (i > 0) {
				return new ResultJson(false, "此工单已关联签到记录，无法删除!");
			} else {
				String relationShipId = maintenanceOrderId;
				 mOrderMapper.deleteUserROrder(maintenanceOrderId);
				 mOrderMapper.deleteEquipDelivery(maintenanceOrderId);
				 attachmentMapper.deleteAttachment(relationShipId);
			     mOrderMapper.deleteWorkOrder(maintenanceOrderId);
				return new ResultJson(true,"删除成功！");
			}
			
		}
		return new ResultJson(false,"删除失败！");
	}

	/**
	 * 
		* @author zhangshuangquan
		* @Title: downloadAfterSale
		* @Description: (下载图片)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	public List<Attachment> downloadPicture(String maintenanceOrderId) {
		if(StringUtils.isNotBlank(maintenanceOrderId)){
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("maintenanceOrderId", maintenanceOrderId);
			map.put("type","image");
			List<Attachment> attachments = mOrderMapper.downloadPicture(map);
			return attachments;
		}
		return null;
	}

	/**
	 * 
		* @author zhangshuangquan
		* @Title: getPictures
		* @Description: (分页显示图片信息)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	public Page getPictures(String maintenanceOrderId, Page page) {
		 Map<String,Object> map = new HashMap<String, Object>();
		 map.put("maintenanceOrderId",maintenanceOrderId);
		 map.put("type","image");
		 page.setMap(map);
		 List<Attachment>  attachments = mOrderMapper.getPicturesPageList(page);
		 page.setData(attachments);
		 return page;
	}

	/**
	 * 
		* @author zhangshuangquan
		* @Title: 获取工单中的工程师
		* @Description: (这里用一句话描述这个方法的作用)
		* @param @return    设定文件
		* @return String    返回类型
		* @throws
	 */
	public Page getEngineerList(UserSearchModel userSearch,Page page) {
		boolean flag=true;
		Map<String,Object> map = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(userSearch.getProjectId())){
			map.put("projectId",userSearch.getProjectId());
			flag=false;
		}
		map.put("realName",OracleKeyWordUtils.oracleKeyWordReplace(userSearch.getRealName()));
		if(flag){
			map.put("state",userSearch.getState());
		}
		page.setMap(map);
		List<AdminUser> data = mOrderMapper.getEngineerPageList(page);
		page.setData(data);
		return page;
	}
	
	/**
	 * @author lichen
	* @Title: searchSchoolPageList
	* @Description: (搜索学校并实现区域地址回填)
	* @param @param page
	* @param @return    设定文件
	* @return List<SearchSchoolInfoView>    返回类型
	* @throws
	 */
	public Page searchSchoolPageList(Page page,String schoolArea,String projId,String schoolName){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("schoolArea", schoolArea);
		map.put("projId", projId);
		map.put("schoolName", OracleKeyWordUtils.oracleKeyWordReplace(schoolName));
		page.setMap(map);
		List<SearchSchoolInfoView> schoolObjList = mOrderMapper.searchSchoolPageList(page);
		page.setData(schoolObjList);
		return page;
	}
}
