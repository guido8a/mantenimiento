package reportes

import bitacora.Actividad
import bitacora.Oficio
import bitacora.Responsable
import com.itextpdf.html2pdf.HtmlConverter
import com.lowagie.text.Document
import com.lowagie.text.Element
import com.lowagie.text.Image
import com.lowagie.text.PageSize
import com.lowagie.text.Paragraph
import com.lowagie.text.html.simpleparser.HTMLWorker
import com.lowagie.text.pdf.PdfImportedPage
import com.lowagie.text.pdf.PdfPCell
import com.lowagie.text.pdf.PdfPTable
import com.lowagie.text.pdf.PdfReader
import com.lowagie.text.pdf.PdfWriter
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.Font
import org.apache.poi.ss.usermodel.IndexedColors
import org.apache.poi.ss.util.CellRangeAddress
import org.apache.poi.xssf.usermodel.*
import seguridad.Departamento
import seguridad.Persona
import seguridad.Sesn

import java.awt.Color
import java.text.SimpleDateFormat

class ReportesController {
    def dbConnectionService

    def reporteUsuariosPerfiles () {

        def unidades = Departamento.list([sort: 'nombre'])
        def usuarios = Persona.findAllByDepartamentoInList(unidades)
        def sesiones = Sesn.findAllByUsuarioInList(usuarios, [sort: "usuario.departamento.nombre", order: "asc"])

        def iniRow = 0
        def iniCol = 1

        def curRow = iniRow
        def curCol = iniCol

        try {
            XSSFWorkbook wb = new XSSFWorkbook()
            XSSFSheet sheet = wb.createSheet("usuarios")

            def estilos = getEstilos(wb)
            CellStyle styleHeader = estilos.styleHeader
            CellStyle styleTabla = estilos.styleTabla
            CellStyle styleFooter = estilos.styleFooter
            CellStyle styleFooterCenter = estilos.styleFooterCenter
            CellStyle styleNumber = estilos.styleNumber
            CellStyle styleDate = estilos.styleDate

            def titulo = "Reporte de Usuarios y Perfiles"
            def subtitulo = ""

            curRow = setTitulos(sheet, estilos, iniRow, iniCol, titulo, subtitulo)
            XSSFRow rowHeader = sheet.createRow((short) curRow)
            curRow++

            XSSFCell cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("N°")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 1000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("NOMBRE")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 6000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("USUARIO")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 2000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("UNIDAD")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 10000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("CARGO")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 6000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("PERFIL")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 5000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("ACTIVO")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 3000)
            curCol++


            def totalCols = curCol

            joinTitulos(sheet, iniRow, iniCol, totalCols, false)

            def totalPriorizado = 0
            def total1 = 0
            def total2 = 0
            def total3 = 0
            def total4 = 0
            def ordinal = 1

            sesiones.each { d ->
                curCol = iniCol
                XSSFRow tableRow = sheet.createRow((short) curRow)
                XSSFCell cellTabla = tableRow.createCell((short) curCol)

                cellTabla = tableRow.createCell((short) curCol)
                cellTabla.setCellValue(ordinal++)
                cellTabla.setCellStyle(styleTabla)
                curCol++
                cellTabla = tableRow.createCell((short) curCol)
                cellTabla.setCellValue(d?.usuario?.nombre + " " + d?.usuario?.apellido)
                cellTabla.setCellStyle(styleTabla)
                curCol++
                cellTabla = tableRow.createCell((short) curCol)
                cellTabla.setCellValue(d?.usuario?.login)
                cellTabla.setCellStyle(styleTabla)
                curCol++
                cellTabla = tableRow.createCell((short) curCol)
                cellTabla.setCellValue(d?.usuario?.departamento?.nombre)
                cellTabla.setCellStyle(styleTabla)
                curCol++
                cellTabla = tableRow.createCell((short) curCol)
                cellTabla.setCellValue(d?.usuario?.cargo)
                cellTabla.setCellStyle(styleTabla)
                curCol++
                cellTabla = tableRow.createCell((short) curCol)
                cellTabla.setCellValue(d?.perfil?.nombre)
                cellTabla.setCellStyle(styleTabla)
                curCol++
                if(d?.usuario?.estaActivo == 1){
                    cellTabla = tableRow.createCell((short) curCol)
                    cellTabla.setCellValue("SI")
                    cellTabla.setCellStyle(styleTabla)
                    curCol++
                }else{
                    cellTabla = tableRow.createCell((short) curCol)
                    cellTabla.setCellValue("NO")
                    cellTabla.setCellStyle(styleTabla)
                    curCol++
                }
                curRow++
            }

            sheet.addMergedRegion(new CellRangeAddress(
                    curRow, //first row (0-based)
                    curRow, //last row  (0-based)
                    iniCol, //first column (0-based)
                    iniCol + 3 //last column  (0-based)
            ))

            def output = response.getOutputStream()
            def header = "attachment; filename=" + "reporte_usuarios_perfiles.xlsx"
            response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
            response.setHeader("Content-Disposition", header)
            wb.write(output)
            output.flush()

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }


//    def setTitulos(XSSFSheet sheet, estilos, int iniRow, int iniCol, String titulo, String subtitulo) {
//        CellStyle styleYachay = estilos.styleYachay
//        CellStyle styleTitulo = estilos.styleTitulo
//        CellStyle styleSubtitulo = estilos.styleSubtitulo
//        CellStyle styleFecha = estilos.styleFecha
//
//        def curRow = iniRow
//
//        XSSFRow rowYachay = sheet.createRow((short) curRow)
//        XSSFCell cellYachay = rowYachay.createCell((short) iniCol)
//        cellYachay.setCellValue("BITÁCORA")
//        cellYachay.setCellStyle(styleYachay)
//        curRow++
//
//        XSSFRow rowTitulo = sheet.createRow((short) curRow)
//        XSSFCell cellTitulo = rowTitulo.createCell((short) iniCol)
//        cellTitulo.setCellValue(titulo)
//        cellTitulo.setCellStyle(styleTitulo)
//        curRow++
//
//        if (subtitulo && subtitulo != "") {
//            XSSFRow rowSubtitulo = sheet.createRow((short) curRow)
//            XSSFCell cellSubtitulo = rowSubtitulo.createCell((short) iniCol + 3)
//            cellSubtitulo.setCellValue(subtitulo)
//            cellSubtitulo.setCellStyle(styleTitulo)
//            curRow++
//        }
//
//        XSSFRow rowFecha = sheet.createRow((short) curRow)
//        XSSFCell cellFecha = rowFecha.createCell((short) iniCol + 1)
//        cellFecha.setCellValue("Fecha del reporte: " + new Date().format("dd-MM-yyyy HH:mm"))
//        cellFecha.setCellStyle(styleFecha)
//        curRow++
//
//        return curRow
//    }

/*
    public static joinTitulos(Sheet sheet, int iniRow, int iniCol, int totalCols) {
        joinTitulos(sheet, iniRow, iniCol, totalCols, true)
    }
*/

//    public static joinTitulos(Sheet sheet, int iniRow, int iniCol, int totalCols, boolean subtitulo) {
//    def joinTitulos(XSSFSheet sheet, int iniRow, int iniCol, int totalCols, boolean subtitulo) {
//        sheet.addMergedRegion(new CellRangeAddress(
//                iniRow, //first row (0-based)
//                iniRow, //last row  (0-based)
//                iniCol, //first column (0-based)
//                totalCols  //last column  (0-based)
//        ))
//        sheet.addMergedRegion(new CellRangeAddress(
//                iniRow + 1, //first row (0-based)
//                iniRow + 1, //last row  (0-based)
//                iniCol, //first column (0-based)
//                totalCols   //last column  (0-based)
//        ))
//        if (subtitulo) {
//            sheet.addMergedRegion(new CellRangeAddress(
//                    iniRow + 2, //first row (0-based)
//                    iniRow + 2, //last row  (0-based)
//                    iniCol, //first column (0-based)
//                    totalCols   //last column  (0-based)
//            ))
//            sheet.addMergedRegion(new CellRangeAddress(
//                    iniRow + 3, //first row (0-based)
//                    iniRow + 3, //last row  (0-based)
//                    iniCol + 1, //first column (0-based)
//                    iniCol + 2   //last column  (0-based)
//            ))
//        } else {
//            sheet.addMergedRegion(new CellRangeAddress(
//                    iniRow + 2, //first row (0-based)
//                    iniRow + 2, //last row  (0-based)
//                    iniCol + 1, //first column (0-based)
//                    iniCol + 2   //last column  (0-based)
//            ))
//        }
//    }


//    def getEstilos(XSSFWorkbook wb) {
//
//        XSSFCreationHelper createHelper = wb.getCreationHelper();
//        def numberFormat = createHelper.createDataFormat().getFormat('#,##0.00')
//        def dateFormat = createHelper.createDataFormat().getFormat("dd-MM-yyyy")
//
//        Font fontYachay = wb.createFont()
//        fontYachay.setFontHeightInPoints((short) 12)
//        fontYachay.setBold(true)
//
//        Font fontTitulo = wb.createFont()
//        fontTitulo.setFontHeightInPoints((short) 12)
//        fontTitulo.setBold(true)
//
//        Font fontSubtitulo = wb.createFont()
//        fontSubtitulo.setFontHeightInPoints((short) 12)
//        fontSubtitulo.setBold(true)
//
//        Font fontHeader = wb.createFont()
//        fontHeader.setFontHeightInPoints((short) 9)
//        fontHeader.setColor(new XSSFColor(new java.awt.Color(255, 255, 255)))
//        fontHeader.setBold(true)
//
//        Font fontTabla = wb.createFont()
//        fontTabla.setFontHeightInPoints((short) 9)
//
//        Font fontSubtotal = wb.createFont()
//        fontSubtotal.setFontHeightInPoints((short) 9)
//        fontSubtotal.setBold(true)
//
//        Font fontFecha = wb.createFont()
//        fontFecha.setFontHeightInPoints((short) 9)
//
//        Font fontFooter = wb.createFont()
//        fontFooter.setFontHeightInPoints((short) 9)
//        fontFooter.setBold(true)
//
//        CellStyle styleYachay = wb.createCellStyle()
//        styleYachay.setFont(fontYachay)
//        styleYachay.setAlignment(CellStyle.ALIGN_CENTER)
//        styleYachay.setVerticalAlignment(CellStyle.VERTICAL_CENTER)
//
//        CellStyle styleTitulo = wb.createCellStyle()
//        styleTitulo.setFont(fontTitulo)
//        styleTitulo.setAlignment(CellStyle.ALIGN_CENTER)
//        styleTitulo.setVerticalAlignment(CellStyle.VERTICAL_CENTER)
//
//        CellStyle styleSubtitulo = wb.createCellStyle()
//        styleSubtitulo.setFont(fontSubtitulo)
//        styleSubtitulo.setAlignment(CellStyle.ALIGN_CENTER)
//        styleSubtitulo.setVerticalAlignment(CellStyle.VERTICAL_CENTER)
//
//        CellStyle styleHeader = wb.createCellStyle()
//        styleHeader.setFont(fontHeader)
//        styleHeader.setAlignment(CellStyle.ALIGN_CENTER)
//        styleHeader.setVerticalAlignment(CellStyle.VERTICAL_CENTER)
//        styleHeader.setFillForegroundColor(new XSSFColor(new java.awt.Color(50, 96, 144)));
//        styleHeader.setFillPattern(CellStyle.SOLID_FOREGROUND)
//        styleHeader.setWrapText(true);
//        styleHeader.setBorderBottom(CellStyle.BORDER_THIN);
//        styleHeader.setBottomBorderColor(IndexedColors.BLACK.getIndex());
//        styleHeader.setBorderLeft(CellStyle.BORDER_THIN);
//        styleHeader.setLeftBorderColor(IndexedColors.BLACK.getIndex());
//        styleHeader.setBorderRight(CellStyle.BORDER_THIN);
//        styleHeader.setRightBorderColor(IndexedColors.BLACK.getIndex());
//        styleHeader.setBorderTop(CellStyle.BORDER_THIN);
//        styleHeader.setTopBorderColor(IndexedColors.BLACK.getIndex());
//
//        CellStyle styleFecha = wb.createCellStyle()
//        styleFecha.setVerticalAlignment(CellStyle.VERTICAL_CENTER)
//        styleFecha.setFont(fontFecha)
//        styleFecha.setWrapText(true);
//
//        CellStyle styleTabla = wb.createCellStyle()
//        styleTabla.setVerticalAlignment(CellStyle.VERTICAL_CENTER)
//        styleTabla.setFont(fontTabla)
//        styleTabla.setWrapText(true);
//        styleTabla.setBorderBottom(CellStyle.BORDER_THIN);
//        styleTabla.setBottomBorderColor(IndexedColors.BLACK.getIndex());
//        styleTabla.setBorderLeft(CellStyle.BORDER_THIN);
//        styleTabla.setLeftBorderColor(IndexedColors.BLACK.getIndex());
//        styleTabla.setBorderRight(CellStyle.BORDER_THIN);
//        styleTabla.setRightBorderColor(IndexedColors.BLACK.getIndex());
//        styleTabla.setBorderTop(CellStyle.BORDER_THIN);
//        styleTabla.setTopBorderColor(IndexedColors.BLACK.getIndex());
//
//        CellStyle styleDate = styleTabla.clone()
//        styleDate.setDataFormat(dateFormat);
//
//        CellStyle styleNumber = styleTabla.clone()
//        styleNumber.setDataFormat(numberFormat);
//
//        CellStyle styleSubtotal = styleTabla.clone()
//        styleSubtotal.setFont(fontSubtotal)
//        styleSubtotal.setAlignment(CellStyle.ALIGN_CENTER)
//        styleSubtotal.setFillForegroundColor(new XSSFColor(new java.awt.Color(111, 169, 237)));
//        styleSubtotal.setFillPattern(CellStyle.SOLID_FOREGROUND)
//
//        CellStyle styleSubtotalNumber = styleSubtotal.clone()
//        styleSubtotalNumber.setAlignment(CellStyle.ALIGN_RIGHT)
//        styleSubtotalNumber.setDataFormat(numberFormat);
//
//        CellStyle styleFooterText = styleTabla.clone()
//        styleFooterText.setFont(fontFooter)
//        styleFooterText.setFillForegroundColor(new XSSFColor(new java.awt.Color(200, 200, 200)));
//        styleFooterText.setFillPattern(CellStyle.SOLID_FOREGROUND)
//
//        CellStyle styleFooterCenter = styleFooterText.clone()
//        styleFooterCenter.setAlignment(CellStyle.ALIGN_RIGHT)
//
//        CellStyle styleFooter = styleFooterText.clone()
//        styleFooter.setDataFormat(numberFormat);
//
//        return [styleYachay    : styleYachay, styleTitulo: styleTitulo, styleSubtitulo: styleSubtitulo, styleHeader: styleHeader,
//                styleNumber    : styleNumber, styleFooter: styleFooter, styleDate: styleDate,
//                styleSubtotal  : styleSubtotal, styleSubtotalNumber: styleSubtotalNumber, styleTabla: styleTabla,
//                styleFooterText: styleFooterText, styleFooterCenter: styleFooterCenter, styleFecha: styleFecha]
//    }


//
//    def receta() {
//        def cn = dbConnectionService.getConnection()
//
//        def fondoTotal = new java.awt.Color(250, 250, 240);
//        def baos = new ByteArrayOutputStream()
//        def name = "receta_${cita?.paciente?.apellido}_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
//        def titulo = new java.awt.Color(40, 140, 180)
//        com.itextpdf.text.Font fontTitulo = new com.itextpdf.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 12, com.lowagie.text.Font.BOLD, titulo);
//       com.itextpdf.text.Font fontThTiny = new com.itextpdf.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.BOLD);
//        com.itextpdf.text.Font fontThTiny3 = new com.itextpdf.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 9, com.lowagie.text.Font.BOLD);
//        com.itextpdf.text.Font fontThTiny4 = new com.itextpdf.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 9, com.lowagie.text.Font.NORMAL);
//        com.itextpdf.text.Font fontThTiny2 = new com.itextpdf.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.NORMAL);
//        com.itextpdf.text.Font fontThTiny5 = new com.itextpdf.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.ITALIC);
//        com.itextpdf.text.Font times8normal = new com.itextpdf.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 9, com.lowagie.text.Font.BOLD);
//
//        Document document
//        document = new Document(PageSize.A4.rotate());
//        document.setMargins(28, 30, altura, 55)  //se 28 equivale a 1 cm: izq, derecha, arriba y abajo
//        def pdfw = PdfWriter.getInstance(document, baos);
//
//        document.open();
//        PdfContentByte cb = pdfw.getDirectContent();
//        document.addTitle("Receta");
//        document.addSubject("Generado por el sistema Médico");
//        document.addKeywords("reporte, medico, receta");
//        document.addAuthor("Médico");
//        document.addCreator("Tedein SA");
//
//        PdfPTable tablaDetalles = null
//
//        def printTratamiento = {
//            def band
//
//            def tablaTratamientoDetalles1 = new PdfPTable(5);
//            tablaTratamientoDetalles1.setWidthPercentage(100);
//            tablaTratamientoDetalles1.setWidths(arregloEnteros([5, 41, 8, 5, 41]))
//
//            def tablaTratamientoDetalles2 = new PdfPTable(5);
//            tablaTratamientoDetalles2.setWidthPercentage(100);
//            tablaTratamientoDetalles2.setWidths(arregloEnteros([5, 41, 8, 5, 41]))
//
//            tratamientos.eachWithIndex {p, q->
//
////                println "convierte de números a letras"
//                def numerosALetras
//                if(p?.cantidad == 1){
//                    numerosALetras = 'UNO'
//                } else {
//                    numerosALetras = NumberToLetterConverter.convertNumberToLetter(p?.cantidad ?: 0)
//                }
//
//                if(q <= 4){
//                    band = '1'
//                }else{
//                    band = '2'
//                }
//
//                if(q <= 4){
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph(p?.medicina?.padre?.descripcion  ?: '' + " ( ${p?.medicina?.padre?.descripcion ?: ''} )", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph(p?.medicina?.padre?.descripcion  ?: '' + " ( ${p?.medicina?.padre?.descripcion ?: ''} )", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph((q + 1)?.toString() + ".-", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph((p?.medicina?.descripcion ?: '') + " " + (p?.medicina?.concentracion ?:''), fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph((q + 1)?.toString() + ".-", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph((p?.medicina?.descripcion ?: '') + " " + (p?.medicina?.concentracion ?:''), fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph((p?.medicina?.forma ?: '') + " # " + p?.cantidad?.toString() + " (" + numerosALetras + ")", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph(p?.descripcion  ?: '', fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//
//                    tablaTratamientoDetalles1.setSpacingAfter(10f);
//                }else{
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph(p?.medicina?.padre?.descripcion  ?: '' + " ( ${p?.medicina?.padre?.descripcion ?: ''} )", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph(p?.medicina?.padre?.descripcion  ?: '' + " ( ${p?.medicina?.padre?.descripcion ?: ''} )", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph((q + 1)?.toString() + ".-", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph((p?.medicina?.descripcion ?: '') + " " + (p?.medicina?.concentracion ?:''), fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph((q + 1)?.toString() + ".-", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph((p?.medicina?.descripcion ?: '') + " " + (p?.medicina?.concentracion ?:''), fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph((p?.medicina?.forma ?: '') + " # " + p?.cantidad?.toString() + " (" + numerosALetras + ")", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph(p?.descripcion  ?: '', fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//
//                    tablaTratamientoDetalles2.setSpacingAfter(10f);
//                }
//            }
//
//            addCellTabla(tablaDetalles, tablaTratamientoDetalles1, [border: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 5, pl: 0])
//
//            if(tratamientos.size() > 4){
//                addCellTabla(tablaDetalles, tablaTratamientoDetalles2, [border: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 5, pl: 0])
//            }
//        }
//
//        SimpleDateFormat fmtEsp = new SimpleDateFormat('EEEE, dd-MMMM-yyyy', new Locale("es", "ES"));
//
//        def printTratamientoFin = {
//
//            def tablaTratamientoDetallesFin = new PdfPTable(5);
//            tablaTratamientoDetallesFin.setWidthPercentage(100);
//            tablaTratamientoDetallesFin.setWidths(arregloEnteros([5, 41, 8, 5, 41]))
//
//            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
//            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("${cita?.tratamiento ?: ''}", fontThTiny5), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//
//            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
//            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//            if(citaProxima){
//                addCellTabla(tablaTratamientoDetallesFin, new Paragraph("PRÓXIMA CITA: ${citaProxima ? fmtEsp.format(citaProxima) : ''}" + " a las " + "${(citaHora? citaHora + ' horas': '')}", times8normal),
//                        [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//            }else{
//                addCellTabla(tablaTratamientoDetallesFin, new Paragraph("PRÓXIMA CITA: NO TIENE ASIGNADA UNA PRÓXIMA CITA" , times8normal),
//                        [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//            }
//            addCellTabla(tablaDetalles, tablaTratamientoDetallesFin, [border: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 5, pl: 0])
//
//            tablaTratamientoDetallesFin.setSpacingAfter(10f);
//        }
//
//        tablaDetalles = new PdfPTable(4);
//        tablaDetalles.setWidthPercentage(100);
//        tablaDetalles.setWidths(arregloEnteros([6, 20, 62, 12]))
//
//        printTratamiento();
//        printTratamientoFin();
//        document.add(tablaDetalles)
//        document.close();
//        pdfw.close()
//        byte[] b = baos.toByteArray();
//
//        encabezadoYnumeracion(b, name, "", "${name}.pdf", cita?.persona?.empresa?.direccion, empr, cita, diagnosticos, edadCalculada, edad)
//    }


    def reporteInforme() {

        def oficio = Oficio.get(params.id)
        def actividades = Actividad.findAllByPeriodo(oficio?.periodo)
        def modulos = []

//        def baos = new ByteArrayOutputStream()
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        def name = "informe_" + new Date().format("dd_MM_yyyy_hhmm") ;
        com.lowagie.text.Font titleFont = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 14, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font titleFont3 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 12, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font titleFont3Normal = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 12, com.lowagie.text.Font.NORMAL);
        com.lowagie.text.Font titleFont2 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 16, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font font10 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 10, com.lowagie.text.Font.NORMAL);
        com.lowagie.text.Font font10Bold= new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 10, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font font11 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font font11Normal = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.NORMAL);

        def paramsHead = [border: Color.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellLeft = [border: Color.WHITE, valign: Element.ALIGN_MIDDLE]
        def prmsCellLeftAT = [border: Color.WHITE, align : Element.ALIGN_JUSTIFIED, valign: Element.ALIGN_TOP]
        def prmsCellRight = [border: Color.BLACK, align : Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE, bordeBot: "1"]
        def prmsCellCenter = [border: Color.BLACK, align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, bordeBot: "1"]

        Document document
        document = new Document(PageSize.A4);
        document.setMargins(70, 70, 100, 50);
        def pdfw = PdfWriter.getInstance(document, baos);

        document.open();
        document.addTitle("informe_" + new Date().format("dd_MM_yyyy"));
        document.addSubject("Generado por el sistema Mantenimiento");
        document.addKeywords("reporte, mantenimiento ,informe");
        document.addAuthor("Mantenimiento");
        document.addCreator("Tedein SA");

        Paragraph headersTitulo = new Paragraph();
//        addEmptyLine(headersTitulo, 1)
        headersTitulo.setAlignment(Element.ALIGN_CENTER);
//        headersTitulo.add(new Paragraph( '', titleFont2));
//        addEmptyLine(headersTitulo, 2);
        headersTitulo.add(new Paragraph("INFORME TÉCNICO N° " + (oficio?.periodo?.numero ?: ''), titleFont));
        addEmptyLine(headersTitulo, 1);
        headersTitulo.add(new Paragraph("Contrato N°: " + (oficio?.contrato?.numero ?: ''), titleFont3));
//        headersTitulo.add(new Paragraph("Quito, " + fechaConFormato(new Date(), "dd MMMM yyyy").toUpperCase(), titleFont3));
        addEmptyLine(headersTitulo, 1);
        headersTitulo.add(new Paragraph(oficio?.contrato?.objeto, titleFont3Normal));
        addEmptyLine(headersTitulo, 1);
        headersTitulo.add(new Paragraph("Informe técnico del período del " + fechaConFormato(oficio?.periodo?.fechads, "dd MMMM yyyy") + " al " + fechaConFormato(oficio?.periodo?.fechahs, "dd MMMM yyyy"), font11));
        addEmptyLine(headersTitulo, 1);

        document.add(headersTitulo)

        def tablaModulos = new PdfPTable(2);
        tablaModulos.setWidthPercentage(100);
        tablaModulos.setWidths(arregloEnteros([1, 99]))

        addCellTabla(tablaModulos, new Paragraph("", font10), prmsCellLeft)
        addCellTabla(tablaModulos, new Paragraph("Soporte a usuarios en el uso de módulos de", font10), prmsCellLeft)
        actividades.each { a->
            modulos.add(a?.moduloSistema)
        }
        modulos.unique().each {
            addCellTabla(tablaModulos, new Paragraph("", font10), prmsCellLeft)
            addCellTabla(tablaModulos, new Paragraph("          * " + (it?.descripcion ?: ''), font10), prmsCellLeft)
        }

        def tablaTexto = new PdfPTable(1);
        tablaTexto.setWidthPercentage(100);
        tablaTexto.setWidths(arregloEnteros([100]))
        tablaTexto.setSpacingBefore(20)
        addCellTabla(tablaTexto, new Paragraph("Actividades realizadas de soporte", font11Normal), prmsCellLeft)
        addCellTabla(tablaTexto, new Paragraph("", font11Normal), prmsCellLeft)
        addCellTabla(tablaTexto, new Paragraph("", font11Normal), prmsCellLeft)

        def tablaActividades = new PdfPTable(2);
        tablaActividades.setWidthPercentage(100f);
        tablaActividades.setWidths(arregloEnteros([5, 95]))

        actividades.eachWithIndex { actividad, q->
            addCellTabla(tablaActividades, new Paragraph((q + 1)?.toString() + ".", font10), prmsCellLeftAT)
            addCellTabla(tablaActividades, new Paragraph( ( actividad?.descripcion  ?: ''), font10), prmsCellLeftAT)
            addCellTabla(tablaActividades, new Paragraph( "", font10), prmsCellLeftAT)
            addCellTabla(tablaActividades, new Paragraph( "Fecha: " + ( actividad?.fecha?.format("dd-MM-yyyy")  ?: ''), font10Bold), prmsCellLeftAT)
            addCellTabla(tablaActividades, new Paragraph( "", font10), prmsCellLeftAT)
            addCellTabla(tablaActividades, new Paragraph( "Solicitado por: " + ( (actividad?.usuario?.apellido ?: '') + " " +  (actividad?.usuario?.nombre ?: '')), font10Bold), prmsCellLeftAT)
            addCellTabla(tablaActividades, new Paragraph( "", font10Bold), prmsCellLeftAT)
            addCellTabla(tablaActividades, new Paragraph( "", font10Bold), prmsCellLeftAT)
        }

        document.add(tablaModulos)
        document.add(tablaTexto)
        document.add(tablaActividades)

        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
//        response.setContentType("application/pdf")
//        response.setHeader("Content-disposition", "attachment; filename=" + name)
//        response.setContentLength(b.length)
//        response.getOutputStream().write(b)

//        encabezadoYnumeracion(b, name, "", "${name}.pdf", "", "", "", "", "", "")
        encabezadoYnumeracion(b, name, "", "${name}.pdf", "", "", "", "", "", "")
    }

    private static void addEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }



    private static void addCellTabla(PdfPTable table, paragraph, params) {
        PdfPCell cell = new PdfPCell(paragraph);
        if (params.height) {
            cell.setFixedHeight(params.height.toFloat());
        }
        if (params.border) {
            cell.setBorderColor(params.border);
        }
        if (params.bg) {
            cell.setBackgroundColor(params.bg);
        }
        if (params.colspan) {
            cell.setColspan(params.colspan);
        }
        if (params.align) {
            cell.setHorizontalAlignment(params.align);
        }
        if (params.valign) {
            cell.setVerticalAlignment(params.valign);
        }
        if (params.w) {
            cell.setBorderWidth(params.w);
            cell.setUseBorderPadding(true);
        }
        if (params.bwl) {
            cell.setBorderWidthLeft(params.bwl.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwb) {
            cell.setBorderWidthBottom(params.bwb.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwr) {
            cell.setBorderWidthRight(params.bwr.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwt) {
            cell.setBorderWidthTop(params.bwt.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bcl) {
            cell.setBorderColorLeft(params.bcl);
            cell.setUseVariableBorders(true);
        }
        if (params.bcb) {
            cell.setBorderColorBottom(params.bcb);
            cell.setUseVariableBorders(true);
        }
        if (params.bcr) {
            cell.setBorderColorRight(params.bcr);
            cell.setUseVariableBorders(true);
        }
        if (params.bct) {
            cell.setBorderColorTop(params.bct);
            cell.setUseVariableBorders(true);
        }
        if (params.padding) {
            cell.setPadding(params.padding.toFloat());
        }
        if (params.pl) {
            cell.setPaddingLeft(params.pl.toFloat());
        }
        if (params.pr) {
            cell.setPaddingRight(params.pr.toFloat());
        }
        if (params.pt) {
            cell.setPaddingTop(params.pt.toFloat());
        }
        if (params.pb) {
            cell.setPaddingBottom(params.pb.toFloat());
        }
        if (params.bordeTop) {
            cell.setBorderWidthTop(1)
            cell.setBorderWidthLeft(0)
            cell.setBorderWidthRight(0)
            cell.setBorderWidthBottom(0)
            cell.setPaddingTop(7);
        }
        if (params.bordeBot) {
            cell.setBorderWidthBottom(1)
            cell.setBorderWidthLeft(0)
            cell.setBorderWidthRight(0)
            cell.setPaddingBottom(7)

            if (!params.bordeTop) {
                cell.setBorderWidthTop(0)
            }
        }
        table.addCell(cell);
    }

    private String fechaConFormato(fecha, formato) {
        def meses = ["", "Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
        def mesesLargo = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
        def strFecha = ""
        if (fecha) {
            switch (formato) {
                case "MMM-yy":
                    strFecha = meses[fecha.format("MM").toInteger()] + "-" + fecha.format("yy")
                    break;
                case "dd-MM-yyyy":
                    strFecha = "" + fecha.format("dd-MM-yyyy")
                    break;
                case "dd-MMM-yyyy":
                    strFecha = "" + fecha.format("dd") + "-" + meses[fecha.format("MM").toInteger()] + "-" + fecha.format("yyyy")
                    break;
                case "dd MMMM yyyy":
                    strFecha = "" + fecha.format("dd") + " de " + mesesLargo[fecha.format("MM").toInteger()] + " de " + fecha.format("yyyy")
                    break;
                default:
                    strFecha = "Formato " + formato + " no reconocido"
                    break;
            }
        }
        return strFecha
    }

    private String fechaConFormato(fecha) {
        return fechaConFormato(fecha, "MMM-yy")
    }

    private static int[] arregloEnteros(array) {
        int[] ia = new int[array.size()]
        array.eachWithIndex { it, i ->
            ia[i] = it.toInteger()
        }
        return ia
    }

    def encabezadoYnumeracion (f, tituloReporte, subtitulo, nombreReporte, textoFooter, empresa, cita, diagnosticos, edadCalculada, edad) {

        def titulo = new java.awt.Color(30, 140, 160)
        com.lowagie.text.Font fontTitulo = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 12, com.lowagie.text.Font.BOLD, titulo);
        com.lowagie.text.Font fontTitulo16 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 16, com.lowagie.text.Font.BOLD, titulo);
        com.lowagie.text.Font fontTitulo8 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 8, com.lowagie.text.Font.NORMAL, titulo);
        com.lowagie.text.Font fontTitulo8d = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 8, com.lowagie.text.Font.NORMAL, titulo);

        def path = "/var/mantenimiento/logo.jpeg"
        Image logo = Image.getInstance(path);
        def longitud = logo.getHeight()
        logo.scalePercent( (70/longitud * 75).toInteger() )
        logo.setAlignment(Image.MIDDLE | Image.TEXTWRAP)

        def baos = new ByteArrayOutputStream()

        PdfPTable tablaFooter = new PdfPTable(3);
        tablaFooter.setWidthPercentage(100);
        tablaFooter.setWidths(arregloEnteros([45, 10, 45]))

        addCellTabla(tablaFooter, new Paragraph("", fontTitulo8), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaFooter, new Paragraph(textoFooter, fontTitulo8), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaFooter, new Paragraph("", fontTitulo8), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])

        com.lowagie.text.Document document = new com.lowagie.text.Document(com.lowagie.text.PageSize.A4);
//        document.setMargins(36, 36, 36, 100)

        def pdfw = com.lowagie.text.pdf.PdfWriter.getInstance(document, baos);

//        com.lowagie.text.HeaderFooter footer1 = new com.lowagie.text.HeaderFooter( new com.lowagie.text.Phrase(textoFooter, new com.lowagie.text.Font(fontTitulo8)), false);
//        footer1.setBorder(com.lowagie.text.Rectangle.NO_BORDER);
//        footer1.setBorder(com.lowagie.text.Rectangle.TOP);
//        footer1.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        document.setFooter(footer1);

        document.open();

        com.lowagie.text.pdf.PdfContentByte cb = pdfw.getDirectContent();

        PdfReader reader = new PdfReader(f);
        for (int i = 1; i <= reader.getNumberOfPages(); i++) {

            int rotation = reader.getPageRotation(i);
            float pageWidth = reader.getPageSizeWithRotation(i).getWidth();
            float pageHeight = reader.getPageSizeWithRotation(i).getHeight();

            document.newPage();
            PdfImportedPage page = pdfw.getImportedPage(reader, i);

            if (rotation == 0) {
                cb.addTemplate(page, 0,0);
            } else if (rotation == 90) {
                cb.addTemplate(page, 0, -1f, 1f, 0, 0, pageHeight);
            } else if (rotation == 180) {
                cb.addTemplate(page, 1f, 0, 0, -1f, pageWidth, pageHeight);
            } else if (rotation == 270) {
                cb.addTemplate(page, 0, -1f, 1f, 0, 0, pageHeight);
            }

            def ed = encabezado(logo)
            numeracion(i,reader.getNumberOfPages()).writeSelectedRows(0, -1, -1, 50, cb)
            document.add(ed)
        }

        document.close();
        byte[] b = baos.toByteArray();

        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + nombreReporte)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)

//        ITextRenderer renderer = new ITextRenderer();
//        renderer.setDocumentFromString(content);
//        renderer.layout();
//        renderer.createPDF(baos);

//        ITextRenderer renderer = new ITextRenderer();
//        renderer.setDocumentFromString(content);
//        renderer.layout();
//        renderer.createPDF(baos);
//        byte[] data = baos.toByteArray();
//
//        response.setHeader("Content-disposition", "attachment;filename=report.pdf")
//        response.setContentType("application/pdf")
//        OutputStream out = response.getOutputStream();
//
//        out.write(b);
//        out.flush();
//        out.close()


    }

    def numeracion(x, y) {
        com.lowagie.text.Font fontTd08 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 8, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font fontTd09 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 9, com.lowagie.text.Font.BOLD);

        PdfPTable table = new PdfPTable(3)
        table.setWidthPercentage(100);
        table.setWidths(arregloEnteros([10,80,10]))
        table.setTotalWidth(600);
        table.getDefaultCell().setFixedHeight(50);
        table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_RIGHT);
        table.getDefaultCell().setVerticalAlignment(Element.ALIGN_TOP);
        addCellTabla(table, new Paragraph("", fontTd08), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_TOP])
        addCellTabla(table, new Paragraph("Mz#2924, Sol#30, Mucho Lote#2, PB-Pascuales. Guayaquil - Rio Coca E8-138 y los Shyris, Telf: 02-5019108, Quito. Email: informacion@tedein.com.ec", fontTd08), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_TOP])
        addCellTabla(table, new Paragraph("", fontTd08), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_TOP])

        addCellTabla(table, new Paragraph("", fontTd08), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_TOP])
        addCellTabla(table, new Paragraph(String.format("Página %d de %d", x, y), fontTd09), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_TOP])
        addCellTabla(table, new Paragraph("", fontTd08), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_TOP])

        return table;
    }

    def encabezado (logo) {

        PdfPTable tablaDetalles = new PdfPTable(3);
        tablaDetalles.setWidthPercentage(100);
        tablaDetalles.setWidths(arregloEnteros([30, 40, 30]))
        tablaDetalles.setTotalWidth(600);
//        tablaDetalles.setSpacingAfter(10f);
//        tablaDetalles.setSpacingBefore(10f);

        com.lowagie.text.Font fontThTiny = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.BOLD);

        PdfPTable tablaImagen = new PdfPTable(3);
        tablaImagen.setWidthPercentage(100);
        tablaImagen.setWidths(arregloEnteros([1,98,1]))
        addCellTabla(tablaImagen, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaImagen, logo, [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_MIDDLE, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaImagen, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

        addCellTabla(tablaDetalles, tablaImagen, [border: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 3, pl: 0])

        return tablaDetalles
    }

    def reporteOficio() {

        def oficio = Oficio.get(params.id)
        def actividades = Actividad.findAllByPeriodo(oficio?.periodo)
        def modulos = []

        def baos = new ByteArrayOutputStream()
        def name = "oficio_" + new Date().format("dd_MM_yyyy_hhmm") ;
        com.lowagie.text.Font titleFont = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 14, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font titleFont3 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 12, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font titleFont3Normal = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 12, com.lowagie.text.Font.NORMAL);
        com.lowagie.text.Font titleFont2 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 16, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font font10 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 10, com.lowagie.text.Font.NORMAL);
        com.lowagie.text.Font font10Bold= new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 10, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font font11 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font font11Normal = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.NORMAL);
        com.lowagie.text.Font font12 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 12, com.lowagie.text.Font.NORMAL);
        com.lowagie.text.Font font12Bold = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 12, com.lowagie.text.Font.BOLD);


        def paramsHead = [border: Color.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellLeft = [border: Color.WHITE, valign: Element.ALIGN_MIDDLE]
        def prmsCellJustificado = [border: Color.WHITE, valign: Element.ALIGN_TOP, align: Element.ALIGN_JUSTIFIED]
        def prmsCellLeftAT = [border: Color.WHITE, valign: Element.ALIGN_TOP]
        def prmsCellRightTT = [border: Color.WHITE, align : Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def prmsCellLeftTT = [border: Color.WHITE, align : Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def prmsCellCenter = [border: Color.BLACK, align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, bordeBot: "1"]

        Document document
        document = new Document(PageSize.A4);
        document.setMargins(70, 70, 100, 50);
        def pdfw = PdfWriter.getInstance(document, baos);

        document.open();
        document.addTitle("oficio_" + new Date().format("dd_MM_yyyy"));
        document.addSubject("Generado por el sistema Mantenimiento");
        document.addKeywords("reporte, mantenimiento ,oficio");
        document.addAuthor("Mantenimiento");
        document.addCreator("Tedein SA");

//        Paragraph headersTitulo = new Paragraph();
//        headersTitulo.setAlignment(Element.ALIGN_CENTER);
//        headersTitulo.add(new Paragraph("Oficio N°: " + (oficio?.numero ?: ''), titleFont));
//        addEmptyLine(headersTitulo, 1);
//        headersTitulo.add(new Paragraph("Quito, " + fechaConFormato(new Date(), "dd MMMM yyyy").toUpperCase(), titleFont3));
//        addEmptyLine(headersTitulo, 1);
//        headersTitulo.add(new Paragraph(oficio?.contrato?.objeto, titleFont3Normal));
//        addEmptyLine(headersTitulo, 1);
//        headersTitulo.add(new Paragraph("Informe técnico del período del " + fechaConFormato(oficio?.periodo?.fechads, "dd MMMM yyyy") + " al " + fechaConFormato(oficio?.periodo?.fechahs, "dd MMMM yyyy"), font11));
//        addEmptyLine(headersTitulo, 1);
//
//        document.add(headersTitulo)

        def tablaTitulo = new PdfPTable(2);
        tablaTitulo.setWidthPercentage(100);
        tablaTitulo.setWidths(arregloEnteros([12,88]))
        addCellTabla(tablaTitulo, new Paragraph("Oficio N°: ", font12), prmsCellLeftTT)
        addCellTabla(tablaTitulo, new Paragraph(oficio?.numero ?: '', font12Bold), prmsCellLeftTT)
        addCellTabla(tablaTitulo, new Paragraph("", font12Bold), prmsCellLeftTT)
        addCellTabla(tablaTitulo, new Paragraph("Quito, " + fechaConFormato(new Date(), "dd MMMM yyyy"), font12), prmsCellRightTT)

        def tablaCabecera = new PdfPTable(1);
        tablaCabecera.setWidthPercentage(100);
        tablaCabecera.setWidths(arregloEnteros([100]))
        addCellTabla(tablaCabecera, new Paragraph("Señor " + ((Responsable.findByContrato(oficio?.contrato)?.titulo ?: '')), font10), prmsCellLeft)
        addCellTabla(tablaCabecera, new Paragraph(( (Responsable.findByContrato(oficio?.contrato)?.apellido ?: '')  +  " "  + (Responsable.findByContrato(oficio?.contrato)?.nombre ?: '')), font10Bold), prmsCellLeft)
        addCellTabla(tablaCabecera, new Paragraph("Administrador del contrato N° ${oficio?.contrato?.numero} : " + ' "' + oficio?.contrato?.objeto + '" ', font10), prmsCellLeft)
        addCellTabla(tablaCabecera, new Paragraph("", font10), prmsCellLeft)
        addCellTabla(tablaCabecera, new Paragraph("", font10), prmsCellLeft)
        addCellTabla(tablaCabecera, new Paragraph("Presente,", font10), prmsCellLeft)
        addCellTabla(tablaCabecera, new Paragraph("", font10), prmsCellLeft)
        addCellTabla(tablaCabecera, new Paragraph("", font10), prmsCellLeft)
        addCellTabla(tablaCabecera, new Paragraph("De mi consideración:", font10), prmsCellLeft)
        addCellTabla(tablaCabecera, new Paragraph("", font10), prmsCellLeft)
        addCellTabla(tablaCabecera, new Paragraph("", font10), prmsCellLeft)
//        addCellTabla(tablaCabecera, new Paragraph(HtmlConverter.convertToElements(oficio?.texto), font10), prmsCellLeft)
//        addCellTabla(tablaCabecera, new Paragraph( oficio?.texto?.encodeAsHTML(), font10), prmsCellJustificado)
//        addCellTabla(tablaCabecera, new Paragraph( "${raw(oficio?.texto)}", font10), prmsCellJustificado)
//        addCellTabla(tablaCabecera, new Paragraph( "${util.renderHTML(html:  oficio?.texto)}", font10), prmsCellJustificado)
//        addCellTabla(tablaCabecera, new Paragraph( oficio?.texto?.decodeHTML(), font10), prmsCellJustificado)
//        addCellTabla(tablaCabecera, new Paragraph( "${oficio?.texto?.encodeAsHTML()}", font10), prmsCellJustificado)
        addCellTabla(tablaCabecera, new Paragraph("", font10), prmsCellLeft)
        addCellTabla(tablaCabecera, new Paragraph("", font10), prmsCellLeft)
        addCellTabla(tablaCabecera, new Paragraph("Atentamente,", font10), prmsCellLeft)

//        HtmlConverter.convertToElements(oficio?.texto)

//        StringReader strReader = new StringReader(oficio?.texto);
//        def a = HTMLWorker.parseToList(strReader, null)
//
//        a.each {
//            println("it " + it)
//            addCellTabla(tablaCabecera, it, prmsCellLeft)
//        }


        def tablaFirma = new PdfPTable(1);
        tablaFirma.setWidthPercentage(100);
        tablaFirma.setWidths(arregloEnteros([100]))

        document.add(tablaTitulo)
        document.add(tablaCabecera)
        document.add(tablaFirma)
        document.close();

        pdfw.close()
        byte[] b = baos.toByteArray();

        encabezadoYnumeracion(b, name, "", "${name}.pdf", "", "", "", "", "", "")
    }


}
