package caerusapp.web.student;

import java.awt.Dimension;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zefer.pd4ml.PD4ML;

import caerusapp.domain.student.StudentDom;
import caerusapp.service.student.StudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;

/**
 * This class is used to Download a candidate's resume.
 * @author TrishnaR
 * 
 */
@Controller
public class CandidateResumeDownloadController
{

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	@Autowired
	private StudentManager studentManager;
	/**
	 * This method is used to Download a candidate's resume.
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_DOWNLOAD_RESUME)
	public void handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception, SecurityException,
			ServletException {

		/**Spring security authentication containing the logged in user details*/
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String emailId = auth.getName(); // get logged in username

		String firstName="",lastName="";
		
		// Retrieving logged in student details from the database
		StudentDom student = studentManager.getDetailsByEmailId(emailId);
		
		firstName = student.getFirstName();
		lastName = student.getLastName();
		String pdfFileName = firstName+"_"+lastName+"_Resume.pdf";

		ServletContext servletContext = request.getSession().getServletContext();
		String contextPath = servletContext.getRealPath(File.separator);

		File pdfFile = new File(contextPath + pdfFileName);

		java.io.FileOutputStream fos = new java.io.FileOutputStream(pdfFile);

		String serverName = request.getServerName();

		int serverPort = request.getServerPort();

		String apppath = "/candidate_resume_builder.htm";

		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(1000);
		
		String fullPath = "http://" + serverName + ":" + serverPort + apppath+ ";jsessionid=" + session.getId();

		Document doc= Jsoup.connect(fullPath).get();
		Element head_cont = doc.head();

		Elements remove_dis = doc.select("div.sections.disable");

		remove_dis.remove();

		String template = request.getParameter("template");

		doc.getElementById(template).attr("Style", "display: block;");
		
		Element content = doc.getElementById(template);
		doc.getElementById("text-Simple").remove();
		doc.getElementById("text-Expertize").remove();
		doc.getElementById("text-Executive").remove();

		doc.getElementById("buttonSimple").remove();
		doc.getElementById("buttonExpertize").remove();
		doc.getElementById("buttonExecutive").remove();

		doc.getElementById("contentSimpleDone").remove();
		doc.getElementById("contentExpertiseDone").remove();
		doc.getElementById("contentExecutiveDone").remove();

		doc.getElementById("buttonSimpleExpertise").remove();
		doc.getElementById("expertisecoment").remove();
		doc.getElementById("doneSimple").remove();

		doc.getElementById("editExpertise").remove();
		doc.getElementById("divExpertise").remove();

		doc.getElementById("editExecutive").remove();
		doc.getElementById("executiveComent").remove();
		doc.getElementById("doneExecutive").remove();

		String headOpen = "<!DOCTYPE html><html lang=\"en\">";

		String headContent = head_cont.outerHtml();

		String headClose = "<body style=\"background:#fff;\">";

		String divOpen = content.outerHtml();

		String htmlClose = "</div></body></html>";

		String bar = headOpen + headContent + headClose + divOpen + htmlClose;

		String var = bar.replaceAll("hide", "show");

		InputStream is = new ByteArrayInputStream(var.getBytes());

		InputStreamReader irs = new InputStreamReader(is);

		PD4ML html = new PD4ML();

		Dimension dim = new Dimension(595, 842);

		html.clearCache();

		html.setPageSize(dim);

		//html.enableDebugInfo();

		html.setHtmlWidth(1050);

		html.adjustHtmlWidth();

		html.useTTF("java:fonts", true);

		html.protectPhysicalUnitDimensions();

		html.useHttpRequest(request, response);

		html.render(irs, fos);

		fos.close();

		//Sending a PDF file in response
		response.setContentType("application/pdf");

		response.addHeader("Content-Disposition", "attachment; filename="
				+ pdfFileName);

		response.setContentLength((int) pdfFile.length());

		FileInputStream fileInputStream = new FileInputStream(pdfFile);

		OutputStream responseOutputStream = response.getOutputStream();

		int bytes;

		while ((bytes = fileInputStream.read()) != -1) {

			responseOutputStream.write(bytes);

		}

		responseOutputStream.flush();

		responseOutputStream.close();

		logger.info(CaerusLoggerConstants.DOWNLOAD_RESUME);
		
	}

}
