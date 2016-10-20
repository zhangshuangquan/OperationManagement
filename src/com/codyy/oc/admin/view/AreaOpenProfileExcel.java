package com.codyy.oc.admin.view;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.codyy.commons.CommonsConstant;
import com.codyy.commons.utils.StringUtils;


public class AreaOpenProfileExcel extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook wb, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HSSFSheet sheet = wb.createSheet("开课概况");
		HSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        sheet.setDefaultColumnStyle(0, style);
        sheet.setDefaultColumnStyle(1, style);
        sheet.setDefaultColumnStyle(2, style);
        sheet.setDefaultColumnStyle(3, style);
        sheet.setDefaultColumnStyle(4, style);
        sheet.setDefaultColumnStyle(5, style);
        sheet.setDefaultColumnStyle(6, style);
        sheet.setDefaultColumnStyle(7, style);
        
        sheet.setColumnWidth(0, 15*256);
        sheet.setColumnWidth(1, 15*256);
        sheet.setColumnWidth(2, 15*256);
        sheet.setColumnWidth(3, 15*256);
        sheet.setColumnWidth(4, 15*256);
        sheet.setColumnWidth(5, 15*256);
        sheet.setColumnWidth(6, 15*256);
        sheet.setColumnWidth(7, 15*256);

		//形成表格
        HSSFCellStyle headerStyle = wb.createCellStyle();   
        HSSFFont font = wb.createFont();  
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        headerStyle.setFont(font);
        
        String startDt = model.get("startDt").toString();
        String endDt = model.get("endDt").toString();
        HSSFCell startDtTitleCol = getCell(sheet, 0, 0);
        startDtTitleCol.setCellStyle(headerStyle);
        startDtTitleCol.setCellValue("起始日期：");
        HSSFCell startDtValCol = getCell(sheet, 0, 1);
        startDtValCol.setCellValue(startDt);
        HSSFCell endDtTitleCol = getCell(sheet, 0, 2);
        endDtTitleCol.setCellStyle(headerStyle);
        endDtTitleCol.setCellValue("结束日期：");       
        HSSFCell endDtValCol = getCell(sheet, 0, 3);
        endDtValCol.setCellValue(endDt);
        
        HSSFCell col1 = getCell(sheet, 1, 0);
        col1.setCellStyle(headerStyle);
        HSSFCell col2 = getCell(sheet, 1, 1);
        col2.setCellStyle(headerStyle);
        HSSFCell col3 = getCell(sheet, 1, 2);
        col3.setCellStyle(headerStyle);
        HSSFCell col4 = getCell(sheet, 1, 3);
        col4.setCellStyle(headerStyle);
        HSSFCell col5 = getCell(sheet, 1, 4);
        col5.setCellStyle(headerStyle);
        HSSFCell col6 = getCell(sheet, 1, 5);
        col6.setCellStyle(headerStyle);
        HSSFCell col7 = getCell(sheet, 1, 6);
        col7.setCellStyle(headerStyle);
        HSSFCell col8 = getCell(sheet, 1, 7);
        col8.setCellStyle(headerStyle);
       
        String classroomType = (String) model.get("classroomType");
        String classType = (String) model.get("classType");
        Boolean isLastArea = Boolean.valueOf(model.get("isLastArea").toString()); 
        String col1Val = "地区";
        if(isLastArea){
        	col1Val = "学校";
        }
        if(classroomType.equalsIgnoreCase(CommonsConstant.CLASSROOM_TYPE_MASTER) && classType.equals("")){
    	    col1.setCellValue(col1Val);
    	    col2.setCellValue("主讲教室总数");
    	    col3.setCellValue("开课主讲教室数");
            col4.setCellValue("主讲教室开课比例");
            col5.setCellValue("总开课节数");
            col6.setCellValue("应开课节数");
            col7.setCellValue("实开课节数");
            col8.setCellValue("开课节数比例");
        } else if(classroomType.equalsIgnoreCase(CommonsConstant.CLASSROOM_TYPE_MASTER) && classType.equals("Y")){
            col1.setCellValue(col1Val);
     	    col2.setCellValue("主讲教室总数");
     	    col3.setCellValue("开课主讲教室数");
            col4.setCellValue("主讲教室开课比例");
            col5.setCellValue("自主开课节数");
            col6.setCellValue("应开课节数");
            col7.setCellValue("实开课节数");
            col8.setCellValue("开课节数比例");
        } else if(classroomType.equalsIgnoreCase(CommonsConstant.CLASSROOM_TYPE_MASTER) && classType.equals("N")){
        	col1.setCellValue(col1Val);
      	    col2.setCellValue("主讲教室总数");
      	    col3.setCellValue("开课主讲教室数");
            col4.setCellValue("主讲教室开课比例");
            col5.setCellValue("计划开课节数");
            col6.setCellValue("应开课节数");
            col7.setCellValue("实开课节数");
            col8.setCellValue("开课节数比例");
        } else if(classroomType.equalsIgnoreCase(CommonsConstant.CLASSROOM_TYPE_RECEIVE) && classType.equals("")){
        	col1.setCellValue(col1Val);
      	    col2.setCellValue("接收教室总数");
      	    col3.setCellValue("听课接收教室数");
            col4.setCellValue("接收教室听课比例");
            col5.setCellValue("总听课节数");
            col6.setCellValue("应听课节数");
            col7.setCellValue("实听课节数");
            col8.setCellValue("听课节数比例");    	   
        } else if(classroomType.equalsIgnoreCase(CommonsConstant.CLASSROOM_TYPE_RECEIVE) && classType.equals("Y")){
        	col1.setCellValue(col1Val);
      	    col2.setCellValue("接收教室总数");
      	    col3.setCellValue("听课接收教室数");
            col4.setCellValue("接收教室听课比例");
            col5.setCellValue("自主听课节数");
            col6.setCellValue("应听课节数");
            col7.setCellValue("实听课节数");
            col8.setCellValue("听课节数比例");    	    	   
        } else if(classroomType.equalsIgnoreCase(CommonsConstant.CLASSROOM_TYPE_RECEIVE) && classType.equals("N")){
        	col1.setCellValue(col1Val);
      	    col2.setCellValue("接收教室总数");
      	    col3.setCellValue("听课接收教室数");
            col4.setCellValue("接收教室听课比例");
            col5.setCellValue("计划听课节数");
            col6.setCellValue("应听课节数");
            col7.setCellValue("实听课节数");
            col8.setCellValue("听课节数比例");    	
        }
		
		@SuppressWarnings("unchecked")
		List<AreaOpenProfileView> data = (List<AreaOpenProfileView>)model.get("data");
		AreaOpenProfileView viewObj = null;
		int rowNum = 2;
		DecimalFormat df=new DecimalFormat("#.##"); 
		for(int i = 0;i<data.size();i++){
			viewObj = data.get(i);
			
			//String rate = "0.0".equals(viewObj.getDownRate()) ? "0" : viewObj.getDownRate().replace(".0", "");
			
			getCell(sheet, i+rowNum, 0).setCellValue(StringUtils.replaceEscapeChar(viewObj.getAreaName()));
			getCell(sheet, i+rowNum, 1).setCellValue(viewObj.getClassroomCnt());
			getCell(sheet, i+rowNum, 2).setCellValue(viewObj.getDoClsroomCnt());
			getCell(sheet, i+rowNum, 3).setCellValue(df.format(viewObj.getDoClsroomRate())+"%");
			getCell(sheet, i+rowNum, 4).setCellValue(viewObj.getPlanCnt());
			getCell(sheet, i+rowNum, 5).setCellValue(viewObj.getRequiredCnt());
			getCell(sheet, i+rowNum, 6).setCellValue(viewObj.getDownCnt());
			getCell(sheet, i+rowNum, 7).setCellValue(df.format(viewObj.getDownRate())+"%");
		}
		
	}
	
	

}
