/**
 * 
 */
package caerusapp.web.employer;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.export;
import static net.sf.dynamicreports.report.builder.DynamicReports.field;
import static net.sf.dynamicreports.report.builder.DynamicReports.report;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.dynamicreports.jasper.builder.export.JasperPdfExporterBuilder;
import net.sf.dynamicreports.report.base.expression.AbstractSimpleExpression;
import net.sf.dynamicreports.report.builder.component.ImageBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.ListType;
import net.sf.dynamicreports.report.constant.PageOrientation;
import net.sf.dynamicreports.report.constant.PageType;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.dynamicreports.report.definition.ReportParameters;
import net.sf.dynamicreports.report.exception.DRException;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.student.PortfolioDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CandidateCommonFeature;
import caerusapp.web.DynamicReportTemplates;

/**
 * This class is used by the employer to generate reports
 * @author RavishaG
 *
 */

@Controller
public class EmployerGenerateReportController {
	

	@ModelAttribute("jobDetailsDom")
	public JobDetailsDom getJobDetailsDomObject() 
	{
		return new JobDetailsDom();
	}
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	// Autowiring service component
	@Autowired
	IEmployerJobPostManager employerJobPostManager;
	
	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	IStudentManager studentManager;

	
	/**
	 * This method is used to display the generate reports page
	 * @author RavishaG
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return ModelAndView
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_GENERATE_REPORT, method=RequestMethod.GET)
	public String generateReports(Model model, HttpServletResponse httpServletResponse)
	{
		// Adding values to the model and view object
		model.addAttribute("jobDetailsDom",getJobDetailsDomObject());
		model.addAttribute("getMethod",true);
		
		return "employer/employer_generate_reports";
	}
	
	/**
	 * This method is used by the employer to generate reports
	 * @author RavishaG
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return ModelAndView
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_GENERATE_REPORT, method=RequestMethod.POST)
	public ModelAndView employerGenerateReports(@ModelAttribute("jobDetailsDom") JobDetailsDom jobDetailsDom, BindingResult bindingResult, Model model, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String emailId = auth.getName();
		
		// The modelAndView object contains the model(data) and the view(employer_generate_reports)
		ModelAndView modelAndView = new ModelAndView("employer/employer_generate_reports");
		
		logger.info(CaerusLoggerConstants.EMPLOYER_GENERATE_JOB_RESPONSES_REPORT);
		
		List<JobDetailsDom> jobsList = new ArrayList<JobDetailsDom>();
		
		// Retrieving job details
		{
			jobsList = employerJobPostManager.getJobsDetails(jobDetailsDom,emailId);
		}
	
		// Adding values to the model and view object
		modelAndView.addObject("jobsList",jobsList);
		
		return modelAndView;
	}
	
	/**
	 * This method is used by employer to download a report
	 * @author RavishaG
	 * @param jobIdAndFirmId
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return null
	 * @throws IOException
	 * @throws FileNotFoundException
	 * @throws JRException
	 * @throws ParseException
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_DOWNLOAD_REPORT)                                                                                                                                                                                                                                                                                                                                                                           
	public void downloadReport(@RequestParam("jobIdAndFirmId") String jobIdAndFirmId, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws IOException,FileNotFoundException, JRException, ParseException
	{
		//Fetching job details from the database
		JobDetailsDom postJob = employerJobPostManager.findJobDetails(jobIdAndFirmId);			
		
		//Set the posted-on date without timestamp
		postJob.setPostedOn(CaerusCommonUtility.parseTimestampToDate(postJob.getPostedOn()));
		
		HttpSession session = httpServletRequest.getSession(true);
		
		String companyName = (String) session.getAttribute("compName");
		
		//Fetch employer logo
		byte[] employerLogo = employerManager.getEmployerLogo(companyName);
		
		InputStream employerLogoStream = null;
		
		if(employerLogo != null && employerLogo.length > 0)
		{
			employerLogoStream = new ByteArrayInputStream(employerLogo); 
		}
		
		String corporateName = companyName.replace(".", "").replace(" ", "");
		
		//Setting the report name
		String pdfFileName = "Job_Responses_Report_"+corporateName+".pdf";
		
		ServletContext servletContext = httpServletRequest.getSession().getServletContext();
		String contextPath = servletContext.getRealPath(File.separator);

		File pdfFile = new File(contextPath + pdfFileName);
		
		JasperPdfExporterBuilder pdfExporter = export.pdfExporter(pdfFile);
		
		String filePath = servletContext.getRealPath("/images/login_bg.png");	
		
		String title = "Job Responses Report";
		
		EmployerGenerateReportController jobResponsesReport = new EmployerGenerateReportController();
		
		// Setting the report structure
		try
		{
			StyleBuilder textStyle = stl.style(DynamicReportTemplates.columnStyle).setBorder(stl.pen1Point());
			
			ImageBuilder image = cmp.image(jobResponsesReport.new ImageExpression()).setFixedDimension(60,60);
			
			report()
			.setPageFormat(PageType.A4, PageOrientation.LANDSCAPE)
			.setTemplate(DynamicReportTemplates.reportTemplate)
			.fields(field("image", String.class))
			.setColumnStyle(textStyle)
			.columnGrid(ListType.HORIZONTAL_FLOW)
			.columns(col.componentColumn("Image", image),
			  	col.column("First Name", "firstNameColumn",  type.stringType()).setFixedWidth(80),
			  	col.column("Last Name", "lastNameColumn", type.stringType()).setFixedWidth(80),
			  	col.column("Email Id", "emailIdColumn", type.stringType()).setFixedWidth(166),
			  	col.column("Mobile Number", "mobileNumberColumn", type.stringType()).setFixedWidth(101),
			  	col.column("University Name", "universityNameColumn", type.stringType()).setFixedWidth(155),
			  	col.column("I-Score", "iScoreColumn", type.doubleType()).setFixedWidth(50),
			  	col.column("Zip Code", "zipCodeColumn", type.stringType()).setFixedWidth(50),
			  	col.column("City",  "cityColumn", type.stringType()).setFixedWidth(80))
			.title(DynamicReportTemplates.createTitleComponent(title.toUpperCase(),postJob,filePath,employerLogoStream))
			.pageFooter(DynamicReportTemplates.footerComponent)
			.setDataSource(createDataSource(httpServletRequest,jobIdAndFirmId))
			.toPdf(pdfExporter);
			
			//Sending the PDF file (report) in response as a download object
			httpServletResponse.setContentType("application/pdf");

			httpServletResponse.addHeader("Content-Disposition", "attachment; filename="+ pdfFileName);
			
			FileInputStream fileInputStream = new FileInputStream(pdfFile);
			
			int bytes;
			
			OutputStream responseOutputStream = httpServletResponse.getOutputStream();
			
			while ((bytes = fileInputStream.read()) != -1) {

				responseOutputStream.write(bytes);

			}	
			
			try
			{
				responseOutputStream.flush();
				responseOutputStream.close();			
			}
			
			catch(IOException e)
			{
				e.printStackTrace();
			}
			
			logger.info(CaerusLoggerConstants.DOWNLOAD_REPORT);
		}	
		
		catch(DRException e)
		{
			e.printStackTrace();
		}
		
		return;
			
	}
	
	

	/**
	 * This method is used to display images in the report
	 * @author RavishaG
	 */
	 public class ImageExpression extends AbstractSimpleExpression<InputStream> {
			
	      private static final long serialVersionUID = 1L;
	
	      @Override
	
	      public InputStream evaluate(ReportParameters reportParameters) {
	
	    	  InputStream is = null;
	         
	         try 
	         { 
	        	 ByteArrayOutputStream baos = new ByteArrayOutputStream();
	        	 //Rendering the image
				 ImageIO.write((RenderedImage) reportParameters.getValue("image"), "png", baos);
				 
				 //Converting from ByteArrayOutputStream to InputStream
				 is = new ByteArrayInputStream(baos.toByteArray());
			 }
	         
	         catch (IOException e)
	         {
				e.printStackTrace();
	         }

	         return is;
	
	      }
	
	   }
	
	
	
	/**
	 * This method is used to get the details of candidates applied for a job
	 * @author RavishaG
	 * @param jobIdAndFirmId
	 * @return List
	 */
	private List<StudentDom> getResponsesForJob(String jobIdAndFirmId)
	{
		Map<String,String> appliedStudentsMap = employerJobPostManager.getAppliedCandidateEmailIds(jobIdAndFirmId);
		List<StudentDom> candidateList = new ArrayList<StudentDom>();
		
		// Iterating through student list to find emailIds
		String appliedStudentEmailIds = "";
		List<String> emailIdList = new ArrayList<String>();
		
		if(appliedStudentsMap != null && appliedStudentsMap.size() > 0)
			emailIdList = new ArrayList<String>(appliedStudentsMap.keySet());
		
		if(emailIdList != null)
		{	
			appliedStudentEmailIds = CaerusCommonUtility.getCassandraInQueryString(emailIdList);
		}
		
		// Retrieving student details
		if(appliedStudentEmailIds.length()>0)
		{
			candidateList = studentManager.getCandidateListByEmailId(appliedStudentEmailIds);
		}
		
		return candidateList;
	}
	
	/**
	 * This method is used to return data to be added in the report
	 * @author RavishaG
	 * @param jobIdAndFirmId
	 * @return JRDataSource
	 * @throws IOException 
	 */
	private JRDataSource createDataSource(HttpServletRequest httpServletRequest, String jobIdAndFirmId) throws IOException 
	{			
		// Getting details of candidate responses
		List<StudentDom> candidateList = getResponsesForJob(jobIdAndFirmId);
		
		// Setting data to be displayed in the report in the datasource
		DRDataSource dataSource = new DRDataSource("image","firstNameColumn", "lastNameColumn", "emailIdColumn","mobileNumberColumn","universityNameColumn","iScoreColumn","zipCodeColumn","cityColumn");
		
		for(int i = candidateList.size()-1; i >= 0; i--)
		{
			String universityName = "";
			
			List<PortfolioDetailsDom> universityDetailsList = CandidateCommonFeature.getUniversityDetails(candidateList.get(i).getUniversityMap());
			if(universityDetailsList.size() != 0)
			{
				if(universityDetailsList != null && universityDetailsList.size() > 1)
				{
					universityName = universityDetailsList.get(universityDetailsList.size() -1).getUniversityName();
				}
				else
				{
					universityName = universityDetailsList.get(0).getUniversityName();
				}
			}
			
			byte[] blob = null;
			
			// read candidate's image
			if(candidateList.get(i).getPhotoName() != null)
				blob = candidateList.get(i).getPhotoData();
			
			BufferedImage img = null;
			
			// If student profile picture exists
			if(blob != null && blob.length > 1024)
			{
				 try
				 {
					 img = ImageIO.read(new ByteArrayInputStream(blob));
				 }
				 catch(Exception ex)
				 {
					 ex.printStackTrace();
				 }
				    
			}
			// If student profile picture does not exists
			else
			{
				ServletContext servletContext = httpServletRequest.getSession().getServletContext();
				
				String filePath = servletContext.getRealPath("/images/Not_available_icon1.png");	
				
			    FileInputStream fis = new FileInputStream(filePath);  
			    
			    //reading the image file
			    img = ImageIO.read(fis);   
			}
			
			candidateList.get(i).setUniversityName(universityName);
			dataSource.add(img,candidateList.get(i).getFirstName(),candidateList.get(i).getLastName(),candidateList.get(i).getEmailID(),candidateList.get(i).getMobileNumber(),candidateList.get(i).getUniversityName(),candidateList.get(i).getIScore(),candidateList.get(i).getZipCode(),candidateList.get(i).getCity());
		
		}
		
		return dataSource;
			
	}
	
	
}