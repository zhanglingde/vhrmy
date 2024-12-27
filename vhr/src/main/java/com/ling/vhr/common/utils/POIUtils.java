package com.ling.vhr.common.utils;

import com.ling.vhr.modules.emp.model.Employee;
import com.ling.vhr.modules.emp.model.Nation;
import com.ling.vhr.modules.emp.model.PoliticsStatus;
import com.ling.vhr.modules.system.basic.domain.Department;
import com.ling.vhr.modules.system.basic.model.JobLevel;
import com.ling.vhr.modules.system.basic.model.Position;
import org.apache.poi.hpsf.DocumentSummaryInformation;
import org.apache.poi.hpsf.SummaryInformation;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
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
        HSSFCellStyle dateCellStyle = workbook.createCellStyle();      // 创建日期样式
        dateCellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy"));

        HSSFSheet sheet = workbook.createSheet("员工信息表");
        // 设置列宽度
        sheet.setColumnWidth(0, 5 * 256);
        sheet.setColumnWidth(1, 12 * 256);
        sheet.setColumnWidth(2, 10 * 256);
        sheet.setColumnWidth(3, 5 * 256);
        sheet.setColumnWidth(4, 12 * 256);
        sheet.setColumnWidth(5, 20 * 256);
        sheet.setColumnWidth(6, 10 * 256);
        sheet.setColumnWidth(7, 10 * 256);
        sheet.setColumnWidth(8, 16 * 256);
        sheet.setColumnWidth(9, 12 * 256);
        sheet.setColumnWidth(10, 15 * 256);
        sheet.setColumnWidth(11, 20 * 256);
        sheet.setColumnWidth(12, 16 * 256);
        sheet.setColumnWidth(13, 14 * 256);
        sheet.setColumnWidth(14, 14 * 256);
        sheet.setColumnWidth(15, 12 * 256);
        sheet.setColumnWidth(16, 8 * 256);
        sheet.setColumnWidth(17, 20 * 256);
        sheet.setColumnWidth(18, 20 * 256);
        sheet.setColumnWidth(19, 15 * 256);
        sheet.setColumnWidth(20, 8 * 256);
        sheet.setColumnWidth(21, 25 * 256);
        sheet.setColumnWidth(22, 14 * 256);
        sheet.setColumnWidth(23, 15 * 256);
        sheet.setColumnWidth(24, 15 * 256);
        //6. 创建标题行
        HSSFRow r0 = sheet.createRow(0);
        HSSFCell c0 = r0.createCell(0);
        c0.setCellValue("编号");
        c0.setCellStyle(headerStyle);
        HSSFCell c1 = r0.createCell(1);
        c1.setCellValue("姓名");
        c1.setCellStyle(headerStyle);
        HSSFCell c2 = r0.createCell(2);
        c2.setCellValue("工号");
        c2.setCellStyle(headerStyle);
        HSSFCell c3 = r0.createCell(3);
        c3.setCellValue("性别");
        c3.setCellStyle(headerStyle);
        HSSFCell c4 = r0.createCell(4);
        c4.setCellValue("出生日期");
        c4.setCellStyle(headerStyle);
        HSSFCell c5 = r0.createCell(5);
        c5.setCellValue("身份证号");
        c5.setCellStyle(headerStyle);
        HSSFCell c6 = r0.createCell(6);
        c6.setCellValue("婚姻状态");
        c6.setCellStyle(headerStyle);
        HSSFCell c7 = r0.createCell(7);
        c7.setCellValue("民族");
        c7.setCellStyle(headerStyle);
        HSSFCell c8 = r0.createCell(8);
        c8.setCellValue("籍贯");
        c8.setCellStyle(headerStyle);
        HSSFCell c9 = r0.createCell(9);
        c9.setCellValue("政治面貌");
        c9.setCellStyle(headerStyle);
        HSSFCell c10 = r0.createCell(10);
        c10.setCellValue("邮箱");
        c10.setCellStyle(headerStyle);
        HSSFCell c11 = r0.createCell(11);
        c11.setCellValue("电话号码");
        c11.setCellStyle(headerStyle);
        HSSFCell c12 = r0.createCell(12);
        c12.setCellValue("联系地址");
        c12.setCellStyle(headerStyle);
        HSSFCell c13 = r0.createCell(13);
        c13.setCellValue("所属部门");
        c13.setCellStyle(headerStyle);
        HSSFCell c14 = r0.createCell(14);
        c14.setCellValue("职称");
        c14.setCellStyle(headerStyle);
        HSSFCell c15 = r0.createCell(15);
        c15.setCellValue("职位");
        c15.setCellStyle(headerStyle);
        HSSFCell c16 = r0.createCell(16);
        c16.setCellValue("聘用形式");
        c16.setCellStyle(headerStyle);
        HSSFCell c17 = r0.createCell(17);
        c17.setCellValue("最高学历");
        c17.setCellStyle(headerStyle);
        HSSFCell c18 = r0.createCell(18);
        c18.setCellValue("所属专业");
        c18.setCellStyle(headerStyle);
        HSSFCell c19 = r0.createCell(19);
        c19.setCellValue("毕业院校");
        c19.setCellStyle(headerStyle);
        HSSFCell c20 = r0.createCell(20);
        c20.setCellValue("在职状态");
        c20.setCellStyle(headerStyle);
        HSSFCell c21 = r0.createCell(21);
        c21.setCellValue("入职日期");
        c21.setCellStyle(headerStyle);
        HSSFCell c22 = r0.createCell(22);
        c22.setCellValue("转正日期");
        c22.setCellStyle(headerStyle);
        HSSFCell c23 = r0.createCell(23);
        c23.setCellValue("合同起始日期");
        c23.setCellStyle(headerStyle);
        HSSFCell c24 = r0.createCell(24);
        c24.setCellValue("合同终止日期");
        c24.setCellStyle(headerStyle);

        for (int i = 0; i < list.size(); i++) {
            Employee employee = list.get(i);
            HSSFRow row = sheet.createRow(i + 1);
            row.createCell(0).setCellValue(employee.getId());
            row.createCell(1).setCellValue(employee.getName());
            row.createCell(2).setCellValue(employee.getWorkId());
            row.createCell(3).setCellValue(employee.getGender());
            HSSFCell cell4 = row.createCell(4);
            cell4.setCellValue(employee.getBirthday());
            cell4.setCellStyle(dateCellStyle);
            row.createCell(5).setCellValue(employee.getIdCard());
            row.createCell(6).setCellValue(employee.getWedlock());
            row.createCell(7).setCellValue(employee.getNation().getName());
            row.createCell(8).setCellValue(employee.getNativePlace());
            row.createCell(9).setCellValue(employee.getPoliticsStatus().getName());
            row.createCell(10).setCellValue(employee.getEmail());
            row.createCell(11).setCellValue(employee.getPhone());
            row.createCell(12).setCellValue(employee.getAddress());
            row.createCell(13).setCellValue(employee.getDepartment().getDepartmentName());
            row.createCell(14).setCellValue(employee.getJobLevel().getName());
            row.createCell(15).setCellValue(employee.getPosition().getName());
            row.createCell(16).setCellValue(employee.getEngageForm());
            row.createCell(17).setCellValue(employee.getTiptopDegree());
            row.createCell(18).setCellValue(employee.getSpecialty());
            row.createCell(19).setCellValue(employee.getSchool());
            row.createCell(20).setCellValue(employee.getWorkState());
            HSSFCell cell21 = row.createCell(21);
            cell21.setCellValue(employee.getBeginDate());
            cell21.setCellStyle(dateCellStyle);
            HSSFCell cell22 = row.createCell(22);
            cell22.setCellValue(employee.getConversionTime());
            cell22.setCellStyle(dateCellStyle);
            HSSFCell cell23 = row.createCell(23);
            cell23.setCellStyle(dateCellStyle);
            cell23.setCellValue(employee.getBeginContract());
            HSSFCell cell24 = row.createCell(24);
            cell24.setCellStyle(dateCellStyle);
            cell24.setCellValue(employee.getEndContract());
        }
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        HttpHeaders headers = new HttpHeaders();
        try {
            // 防止中文乱码
            String filename = new String("员工表.xls".getBytes("UTF-8"), "ISO-8859-1");
            headers.setContentDispositionFormData("attachment", filename);
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            workbook.write(baos);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return new ResponseEntity<byte[]>(baos.toByteArray(), headers, HttpStatus.CREATED);
    }

    /**
     * Excel 解析成 员工数据集合
     * @param file
     * @param nations
     * @param politicsStatuses
     * @param jobLevels
     * @param positions
     * @param departments
     * @return
     */
    public static List<Employee> excel2Employee(MultipartFile file, List<Nation> nations, List<PoliticsStatus> politicsStatuses, List<JobLevel> jobLevels, List<Position> positions, List<Department> departments) {
        List<Employee> list = new ArrayList<>();
        Employee employee = null;
        try {
            //1. 创建一个 workbook 对象
            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
            //2. 获取 workbook 中表单的数量
            int numberOfSheets = workbook.getNumberOfSheets();
            for (int i = 0; i < numberOfSheets; i++) {
                //3. 获取表单
                HSSFSheet sheet = workbook.getSheetAt(i);
                //4. 获取表单中的行数
                int physicalNumberOfRows = sheet.getPhysicalNumberOfRows();
                for (int j = 0; j < physicalNumberOfRows; j++) {
                    // 5. 跳过标题行
                    if (j == 0) {
                        continue;
                    }
                    HSSFRow row = sheet.getRow(j);
                    if (row == null || row.getCell(0) == null) {
                        continue;       // 防止数据中间有空行
                    }

                    //7. 获取列数
                    int physicalNumberOfCells = row.getPhysicalNumberOfCells();
                    employee = new Employee();
                    for (int k = 0; k < physicalNumberOfCells; k++) {
                        HSSFCell cell = row.getCell(k);
                        switch (cell.getCellType()) {
                            case STRING:
                                String cellValue = cell.getStringCellValue();
                                switch (k) {
                                    case 1:
                                        employee.setName(cellValue);
                                        break;
                                    case 2:
                                        employee.setWorkId(cellValue);
                                        break;
                                    case 3:
                                        employee.setGender(cellValue);
                                        break;
                                    case 5:
                                        employee.setIdCard(cellValue);
                                        break;
                                    case 6:
                                        employee.setWedlock(cellValue);
                                        break;
                                    case 7:
                                        int nationIndex = nations.indexOf(new Nation(cellValue));
                                        employee.setNationId(nations.get(nationIndex).getId());
                                        break;
                                    case 8:
                                        employee.setNativePlace(cellValue);
                                        break;
                                    case 9:
                                        int politicsIndex = politicsStatuses.indexOf(new PoliticsStatus(cellValue));
                                        employee.setPoliticId(politicsStatuses.get(politicsIndex).getId());
                                        break;
                                    case 10:
                                        employee.setEmail(cellValue);
                                        break;
                                    case 11:
                                        employee.setPhone(cellValue);
                                        break;
                                    case 12:
                                        employee.setAddress(cellValue);
                                        break;
                                    case 13:
                                        int departmentIndex = departments.indexOf(new Department(cellValue));
                                        employee.setDepartmentId(departments.get(departmentIndex).getId());
                                        break;
                                    case 14:
                                        int jobLevelIndex = jobLevels.indexOf(new JobLevel(cellValue));
                                        employee.setJobLevelId(jobLevels.get(jobLevelIndex).getId());
                                        break;
                                    case 15:
                                        int positionIndex = positions.indexOf(new Position(cellValue));
                                        employee.setPosId(positions.get(positionIndex).getId());
                                        break;
                                    case 16:
                                        employee.setEngageForm(cellValue);
                                        break;
                                    case 17:
                                        employee.setTiptopDegree(cellValue);
                                        break;
                                    case 18:
                                        employee.setSpecialty(cellValue);
                                        break;
                                    case 19:
                                        employee.setSchool(cellValue);
                                        break;
                                    case 20:
                                        employee.setWorkState(cellValue);
                                        break;
                                }
                                break;
                            default:{
                                switch (k) {
                                    case 4:
                                        employee.setBirthday(cell.getDateCellValue());
                                        break;
                                    case 21:
                                        employee.setBeginDate(cell.getDateCellValue());
                                        break;
                                    case 22:
                                        employee.setConversionTime(cell.getDateCellValue());
                                        break;
                                    case 23:
                                        employee.setBeginContract(cell.getDateCellValue());
                                        break;
                                    case 24:
                                        employee.setEndContract(cell.getDateCellValue());
                                        break;
                                }

                            }
                            break;
                        }
                    }
                    list.add(employee);
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
        return list;
    }
}
