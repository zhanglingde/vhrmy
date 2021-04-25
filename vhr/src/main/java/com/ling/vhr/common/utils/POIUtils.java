package com.ling.vhr.common.utils;

import com.ling.vhr.modules.emp.model.Employee;
import org.apache.poi.hpsf.DocumentSummaryInformation;
import org.apache.poi.hpsf.SummaryInformation;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.springframework.http.ResponseEntity;

import java.util.List;

/**
 * @author zhangling  2021/4/25 23:09
 */
public class POIUtils {
    public static ResponseEntity<byte[]> employee2Excel(List<Employee> list) {

        //1.创建一个 Excel文档
        HSSFWorkbook workbook = new HSSFWorkbook();
        //2. 创建文档摘要(文档基本信息：创建时间，作者等)
        workbook.createInformationProperties();
        //3. 获取并配置文档
        DocumentSummaryInformation docInfo = workbook.getDocumentSummaryInformation();
        // 文档类别
        docInfo.setCategory("员工信息");
        // 文档管理员
        docInfo.setManager("ling");
        // 设置公司信息
        docInfo.setCompany("奥乐康");
        //4. 获取文档摘要信息
        SummaryInformation summInfo = workbook.getSummaryInformation();
        //文档标题
        summInfo.setTitle("员工信息表");
        //文档作者
        summInfo.setAuthor("ling");
        // 文档备注
        summInfo.setComments("本文档由 zhangling 提供");

        // 5. 创建样式
        // 创建标题行的样式
        HSSFCellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setFillForegroundColor(IndexedColors.YELLOW.index); // 背景颜色
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);//填充模式

        HSSFSheet sheet = workbook.createSheet("员工信息表");
        //6. 创建标题行
        HSSFRow r0 = sheet.createRow(0);
        HSSFCell c0 = r0.createCell(0);
        c0.setCellValue("编号");
        c0.setCellStyle(headerStyle);



        return null;
    }
}
