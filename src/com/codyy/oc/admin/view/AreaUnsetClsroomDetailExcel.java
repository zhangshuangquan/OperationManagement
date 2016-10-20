package com.codyy.oc.admin.view;

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

import com.codyy.commons.utils.StringUtils;

public class AreaUnsetClsroomDetailExcel extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook wb, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HSSFSheet sheet = wb.createSheet("未创建课表的主讲教室");
		HSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        sheet.setDefaultColumnStyle(0, style);
        sheet.setDefaultColumnStyle(1, style);
        sheet.setDefaultColumnStyle(2, style);
        sheet.setDefaultColumnStyle(3, style);
        
        sheet.setColumnWidth(0, 15*256);
        sheet.setColumnWidth(1, 15*256);
        sheet.setColumnWidth(2, 15*256);
        sheet.setColumnWidth(3, 15*256);

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
       
       col1.setCellValue("学校名称");
       col2.setCellValue("主讲教室名称");
       col3.setCellValue("联系人");
       col4.setCellValue("电话");
		
		@SuppressWarnings("unchecked")
		List<AreaExcptClsroomDetailView> data = (List<AreaExcptClsroomDetailView>)model.get("data");
		AreaExcptClsroomDetailView viewObj = null;
		int rowNum = 2;
		for(int i = 0;i<data.size();i++){
			viewObj = data.get(i);
			
			getCell(sheet, i+rowNum, 0).setCellValue(StringUtils.replaceEscapeChar(viewObj.getSchoolName()));
			getCell(sheet, i+rowNum, 1).setCellValue(StringUtils.replaceEscapeChar(viewObj.getClassroomName()));
			getCell(sheet, i+rowNum, 2).setCellValue(StringUtils.replaceEscapeChar(viewObj.getContactPerson()));
			getCell(sheet, i+rowNum, 3).setCellValue(viewObj.getContactPhone());
		}
		
	}
	
	

}
