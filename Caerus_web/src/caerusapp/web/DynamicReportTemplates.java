package caerusapp.web;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.tableOfContentsCustomizer;
import static net.sf.dynamicreports.report.builder.DynamicReports.template;

import java.awt.Color;
import java.io.InputStream;
import java.util.Locale;

import net.sf.dynamicreports.report.builder.ReportTemplateBuilder;
import net.sf.dynamicreports.report.builder.component.ComponentBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.builder.tableofcontents.TableOfContentsCustomizerBuilder;
import net.sf.dynamicreports.report.constant.HorizontalAlignment;
import net.sf.dynamicreports.report.constant.VerticalAlignment;
import caerusapp.domain.common.JobDetailsDom;

/**
 * This class is used to define styling for dynamic Reports
 * @author RavishaG
 */
public class DynamicReportTemplates {
	
	
	public static final StyleBuilder rootStyle;
	public static final StyleBuilder boldStyle;
	public static final StyleBuilder italicStyle;
	public static final StyleBuilder boldCenteredStyle;
	public static final StyleBuilder simpleStyle;
	public static final StyleBuilder bold12CenteredStyle;
	public static final StyleBuilder bold18CenteredStyle;
	public static final StyleBuilder bold22CenteredStyle;
	public static final StyleBuilder bold26CenteredStyle;
	public static final StyleBuilder columnStyle;
	public static final StyleBuilder columnTitleStyle;
	public static final StyleBuilder groupStyle;
	public static final StyleBuilder subtotalStyle;
	public static final StyleBuilder headerBackgroundStyle;
	
	public static final ReportTemplateBuilder reportTemplate;
	public static ComponentBuilder<?, ?> dynamicReportsComponent;
	public static final ComponentBuilder<?, ?> footerComponent;

	static 
	{
		rootStyle           = stl.style().setPadding(2).setFontSize(12);
		boldStyle           = stl.style(rootStyle).bold();
		italicStyle         = stl.style(rootStyle).italic();
		boldCenteredStyle   = stl.style(boldStyle)
		                         .setAlignment(HorizontalAlignment.CENTER, VerticalAlignment.MIDDLE);
		simpleStyle   = stl.style().setHorizontalAlignment(HorizontalAlignment.LEFT).setFontSize(14).bold().italic().setForegroundColor(new Color(255,255,255)).setVerticalAlignment(VerticalAlignment.MIDDLE);
		bold12CenteredStyle = stl.style(boldCenteredStyle)
		                         .setFontSize(12);
		bold18CenteredStyle = stl.style(boldCenteredStyle)
		                         .setFontSize(18);
		bold22CenteredStyle = stl.style(boldCenteredStyle)
                             .setFontSize(22).setForegroundColor(new Color(255,71,70));
		bold26CenteredStyle = stl.style(boldCenteredStyle)
                	.setFontSize(26);
		columnStyle         = stl.style(rootStyle).setAlignment(HorizontalAlignment.LEFT,VerticalAlignment.MIDDLE).setBorder(stl.penThin()).setBackgroundColor(new Color(255,255,255)).setLeftIndent(5);
		columnTitleStyle    = stl.style(columnStyle)
		                         .setBorder(stl.penThin())
		                         .setHorizontalAlignment(HorizontalAlignment.CENTER)
		                         .setBackgroundColor(new Color(69, 217, 224));
		groupStyle          = stl.style(boldStyle)
		                         .setHorizontalAlignment(HorizontalAlignment.LEFT);
		subtotalStyle       = stl.style(boldStyle)
		                         .setTopBorder(stl.penThin());
		headerBackgroundStyle   = stl.style().setBackgroundColor(new Color(0,0,0));
		
		StyleBuilder crosstabGroupStyle      = stl.style(columnTitleStyle);
		StyleBuilder crosstabGroupTotalStyle = stl.style(columnTitleStyle)
		                                          .setBackgroundColor(new Color(170, 170, 170));
		StyleBuilder crosstabGrandTotalStyle = stl.style(columnTitleStyle)
		                                          .setBackgroundColor(new Color(140, 140, 140));
		StyleBuilder crosstabCellStyle       = stl.style(columnStyle)
		                                          .setBorder(stl.penThin());

		TableOfContentsCustomizerBuilder tableOfContentsCustomizer = tableOfContentsCustomizer()
			.setHeadingStyle(0, stl.style(rootStyle).bold());

		reportTemplate = template()
		                   .setLocale(Locale.ENGLISH)
		                   .setColumnStyle(columnStyle)
		                   .setColumnTitleStyle(columnTitleStyle)
		                   .setGroupStyle(groupStyle)
		                   .setGroupTitleStyle(groupStyle)
		                   .setSubtotalStyle(subtotalStyle)
		                   .highlightDetailEvenRows()
		                   .highlightDetailOddRows()
		                   .crosstabHighlightEvenRows()
		                   .setCrosstabGroupStyle(crosstabGroupStyle)
		                   .setCrosstabGroupTotalStyle(crosstabGroupTotalStyle)
		                   .setCrosstabGrandTotalStyle(crosstabGrandTotalStyle)
		                   .setCrosstabCellStyle(crosstabCellStyle)
		                   .setTableOfContentsCustomizer(tableOfContentsCustomizer);

		dynamicReportsComponent = cmp.horizontalList();

		footerComponent = cmp.pageXofY()
		                     .setStyle(
		                     	stl.style(boldCenteredStyle)
		                     	   .setTopBorder(stl.pen1Point()));
	}
	
	
	/**
	 * Creates custom component which is possible to add to any report band component
	 */
	public static ComponentBuilder<?, ?> createTitleComponent(String label,JobDetailsDom postJob,String filepath,InputStream employerLogoStream) {
		
		String jobDetails = "Job Id - ".concat(postJob.getJobId()).concat(", Job Title - ").concat(postJob.getJobTitle()).concat(", Posted On - ").concat(postJob.getPostedOn());
		
		return cmp.horizontalList()
		        .add(dynamicReportsComponent,
		        		cmp.horizontalList(cmp.verticalList(cmp.image(filepath).setHorizontalAlignment(HorizontalAlignment.LEFT)).setFixedDimension(120, 60),
		    		    cmp.verticalList(cmp.text(label).setStyle(bold22CenteredStyle).setHorizontalAlignment(HorizontalAlignment.CENTER)).setFixedWidth(520),
		    		    cmp.verticalList(cmp.image(employerLogoStream).setHorizontalAlignment(HorizontalAlignment.RIGHT).setDimension(80, 80)).setFixedDimension(182,60))
		        	 )
		        .newRow()
		        .add(cmp.text(jobDetails).setStyle(simpleStyle).setHorizontalAlignment(HorizontalAlignment.CENTER).setHorizontalAlignment(HorizontalAlignment.CENTER).setHeight(25))
		        .setStyle(headerBackgroundStyle)
		        .newRow()
		        .add(cmp.verticalGap(10));
		        
	}

	
}