package caerusapp.web.university;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.command.university.UniversityDetailsCom;
import caerusapp.domain.student.StudentDom;
import caerusapp.domain.university.UniversityDetailsDom;
import caerusapp.service.student.IStudentManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusLoggerConstants;
  
/**
 * This class is used to handle the manage connections feature of the university entity
 * @author RavishaG
 *
 */

@Controller
public class UniversityManageConnectionsController {
	
	// Auto-wiring service components
	@Autowired
	IUniversityManager universityManager;
	@Autowired
	IStudentManager studentManager;
	@Autowired
	ServletContext servletContext;
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * This method is used to load the manage connections page
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UNIVERSITY_MANAGE_CONNECTIONS)
	public ModelAndView universityManageConnections(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse ) 
	{
		logger.info(CaerusLoggerConstants.MANAGE_CONNECTIONS);
		
		// The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView("university/university_manage_connections");
		
		 List<Integer> batchList = new ArrayList<Integer>();

		//Getting a session from request
		HttpSession session = httpServletRequest.getSession();
		
		// Retrieving university name from the database
		String universityName= (String) session.getAttribute("univName");
		
		// Retreiving the details of students belonging to the university
		UniversityDetailsDom studentDataList = universityManager.getStudentsOfUniversity(universityName);
		
		// check if students exist for the university, then add them to modelAndView object
		if(studentDataList != null)
		{
			modelAndView.addObject("studentDataList", studentDataList);
		}
		
		int currentYear = Calendar.getInstance().get(Calendar.YEAR);
		currentYear += 2;
		int previousYear = currentYear - 10;
		
		for(int i = (currentYear); i >= previousYear; i--)
		{
			batchList.add(currentYear);
			currentYear--;
		}
		
		// Adding the batchList in which the students should pass out / have passed out
		modelAndView.addObject("batch", batchList);
		
		String studentEmailID = "";
		List<String> emailIdList = new ArrayList<String>();
		
		Map<String,String> registeredStudentsMap = new HashMap<String, String>();		
		
		if(studentDataList != null)
		{
			registeredStudentsMap = studentDataList.getRegisteredStudents();
		
			// check if registered students exist, then get their details and add it to the modelAndView object
			if(registeredStudentsMap != null)
			{
				for(Entry<String, String> entry : registeredStudentsMap.entrySet())
				{
					emailIdList.add(entry.getKey());
				}
				
			}
		}
		
		List<StudentDom> studentDetailsList = null;
		
		studentEmailID = CaerusCommonUtility.getCassandraInQueryString(emailIdList);
		
		if(studentEmailID != "")
		{
			studentDetailsList = studentManager.getCandidateListByEmailId(studentEmailID);
		}
		
		if(studentDetailsList != null)
		{	
			for (StudentDom student : studentDetailsList) {
				
				for (Entry<String, String> entry : registeredStudentsMap.entrySet()) {
					
					if(student.getEmailID().equals(entry.getKey()))
					{
						student.setBatch(entry.getValue());
					}
					
				}
				
			}
			modelAndView.addObject("student", studentDetailsList);
		}
		
		// returning the modelAndview object
		 return modelAndView;
		 
	}
	

	/**
	 * This method is used to upload the excel sheet consisting of student data by the university user(placement oficer)/ admin
	 * @param universityDetailsCmd
	 * @param httpServletRequest
	 * @param httServletResponse
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping(method = RequestMethod.POST, value=CaerusAnnotationURLConstants.UNIVERSITY_UPLOAD_FILE)
	public ModelAndView uploadConnectionsFile(@ModelAttribute("uploadedFile") UniversityDetailsCom universityDetailsCmd, HttpServletRequest httpServletRequest, HttpServletResponse httServletResponse)  throws ServletException, IOException
	{
		// The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView("university/university_manage_connections");
		
		//Getting a session from request
		HttpSession session = httpServletRequest.getSession();
		
		// Retrieving university name from the database
		String universityName= (String) session.getAttribute("univName");
  
	    // Uploading a file
	    CommonsMultipartFile multipartFileResume = universityDetailsCmd.getUploadFile();
	
		Map<String,Map<String,String>> students= new HashMap<String,Map<String,String>>();
		
	    String fileResume = "";
	    List<Integer> batchList = new ArrayList<Integer>();

		Map<String,String> existingStudents = new HashMap<String,String>();
		Map<String,String> notExistingStudents = new HashMap<String,String>();
		Map<String,Map<String,String>> existingStudentsMap = new HashMap<String,Map<String,String>>();
		List<String> existingStudentsList = new ArrayList<String>();
	    
		// check if a file is uploaded
		if (multipartFileResume != null) 
		{
			fileResume = multipartFileResume.getOriginalFilename(); // getting the filename
		
			InputStream inputStreamResume = null;
			String extension = CaerusCommonUtil.getFileExtension(fileResume);
			
			// if no file is chosen, add an error message to the modelAndView object
			if(extension == null)
			{
				modelAndView.addObject("errorMessage","Choose a File");
			}
			
			// check if the file is of the appropriate extension
			else if(extension.equals("xls"))
			{
					// Exception handling
					try 
					{
						if (multipartFileResume.getSize() > 0) 
							{
								inputStreamResume = multipartFileResume.getInputStream();
								
								// Add the uploaded file to the database
								universityManager.uploadFile(inputStreamResume);
								
								inputStreamResume.close();

							}
		
					} 
					catch (IOException e) 
					{
						e.printStackTrace();
		
					}   
					
			// Exception handling		
			try
			{
				multipartFileResume = universityDetailsCmd.getUploadFile();
				inputStreamResume = multipartFileResume.getInputStream();
				
				// Finding the excel workbook from the uploaded file
			    HSSFWorkbook workbook = new HSSFWorkbook(inputStreamResume);
			    
			    // Finding the worksheet from the workbook
			    HSSFSheet worksheet = workbook.getSheetAt(0);
			    
			    int count = worksheet.getPhysicalNumberOfRows();
			    int i=1; 
			    List<Integer> rowNoEmailId = new ArrayList<Integer>();
			    List<Integer> rowNoBatch = new ArrayList<Integer>();
			    List<Integer> rowNoDuplicateId = new ArrayList<Integer>();
			    List<String> validEmailIdList = new ArrayList<String>();
			    Map<String,String> registeredStudents = new HashMap<String,String>();
			    Map<String,String> unRegisteredStudents = new HashMap<String,String>();
			    HashMap<String,String> validEntries = new HashMap<String,String>();
			    
			    Row header = worksheet.getRow(0);
			    String studentEmailId=null;
	        	String batch=null;
	        	boolean validBatch=false;
	        	boolean validEmailId= false;
			    	
				    String header1 = header.getCell(0).getStringCellValue();
				    String header2 = header.getCell(1).getStringCellValue();
	
				    // check if the uploaded sheet matches the template pattern
			        if (header1.equals("EmailId") && header2.equals("Batch") )
			        { 
			           while(count>1)
			          {
			        	boolean flag = false;
			        	HSSFCell cellA1=null;
			        	HSSFCell cellA2=null;	
			        	
			        	HSSFRow row1 = worksheet.getRow(i);
			        	if(row1!=null)
			        	{
			        		cellA1= row1.getCell(0);
			        		cellA2 = row1.getCell(1);
			        	}
			        	if(cellA1!=null)
			        	{
			        		studentEmailId = cellA1.getStringCellValue();
			        		
			        		// Getting the values from the cell and check if it is valid
			        		if(studentEmailId!=null)
			        		{
			        			validEmailId = CaerusCommonUtil.isValidEmailId(studentEmailId);
			        			 if(validEmailId)
			        			 {
			        				 // check if there are no duplicate values in the sheet
			        				 if(validEmailIdList.contains(studentEmailId))
			        				 {
			        					 HSSFRow rowNumber = worksheet.getRow(i);
			        					 rowNoDuplicateId.add(rowNumber.getRowNum()+1); 
			        					 modelAndView.addObject("duplicateMsg","Duplicate EmailId at Row No : "+rowNoDuplicateId);
			        				 }
			        				 else
			        				 {
			        					 validEmailIdList.add(studentEmailId);
			        					 flag = true;
			        				 }
			        			 }
			        			 
			        			 // if the emailId is not valid, add an error message to the modelAndView object
			        			 else
			        			{
			        				HSSFRow rowNumber = worksheet.getRow(i);
			        				rowNoEmailId.add(rowNumber.getRowNum()+1);
			        				modelAndView.addObject("invalidEmailId","Invalid EmailId at Row No: "+rowNoEmailId);
			        			}
			        		
			        			}
			        		}	
			        	
			        	if(cellA2!=null)
			        	{
			        		cellA2.setCellType(Cell.CELL_TYPE_STRING);
			        		batch = cellA2.getStringCellValue();
			        		
			        		// Getting the values from the cell and check if it is valid
			        		if(batch!=null)
			        		{
			        		 validBatch = CaerusCommonUtil.isValidBatch(batch);
			        		 
			        		 // if the batch is not valid, add an error message to the modelAndView object
			        		if(validBatch == false)
			        		{
			        			HSSFRow rowNumber = worksheet.getRow(i);
		        				rowNoBatch.add(rowNumber.getRowNum()+1);
		        				modelAndView.addObject("invalidBatch","Invalid Batch at Row No: "+rowNoBatch);
			        		}
			        		}
			        	}
			        	
			        	// check if there are no duplicate values in the sheet and the batch is valid
			        	if(validBatch && flag)
					    {
			        		validEntries.put(studentEmailId, batch);	
					    }
			        	
			        	// Adding values to the modelAndView object
			        	modelAndView.addObject("uploadFile",fileResume);
			        	++i;
			        	--count;	
			          }
			           
			           
				        if(universityName != null && validEntries != null )	
			        	{
				        	// check if students entered in the sheet already exist under some other university
							existingStudentsMap = universityManager.checkExistingStudents(validEntries);
							
					    	existingStudents= existingStudentsMap.get("existingStudents");
					    	notExistingStudents = existingStudentsMap.get("notExistingStudents");
					    	
					    	// check if the students are registered with Imploy or not
					    	if(notExistingStudents == null || notExistingStudents.isEmpty())
					    	{
					    		students = universityManager.checkRegisteredStudent(universityName,validEntries);
					    	}
					    	else
					    	{	
					    		students = universityManager.checkRegisteredStudent(universityName,notExistingStudents);
					    	}
					    	registeredStudents= students.get("registeredStudents");
					    	unRegisteredStudents = students.get("unRegisteredStudents");
					    	
					    	// check if there are any registered students and add them to the registered students map
			        		if(registeredStudents != null && !registeredStudents.isEmpty())
			        		{
			        				universityManager.addRegisteredStudentToMap(universityName,registeredStudents);	
			        		}
			        		
			        		// check if there are any unregistered students and add them to the unregistered students map
			        		if(unRegisteredStudents != null && !unRegisteredStudents.isEmpty())
			        		{
			        				universityManager.addUnRegisteredStudentToMap(universityName, unRegisteredStudents);	
			        		}
			        		
			        	}
				        
				        if(existingStudents != null && !existingStudents.isEmpty())
		        		{
		        			for (Entry<String,String> entry: existingStudents.entrySet()) {
		        				existingStudentsList.add(entry.getKey());
							}
		        			
		        			modelAndView.addObject("existingStudentsList",existingStudentsList);
		        		}
				        logger.info(CaerusLoggerConstants.UPLOAD_STUDENT_DATASHEET);
			           
			        }
			        else
			        {
			        	  modelAndView.addObject("errorTemplate", "Please refer Template Format");
			        }
			        
			       
			}
			catch (FileNotFoundException ex) 
			{
				ex.printStackTrace();
			}
			catch (IOException e) 
			{
				e.printStackTrace();
			}
			
		}
		
		else
		{
			modelAndView.addObject("errorMsg","Choose a file(.xls)");
		}
			
		}

		// Retrieving the students details from the database
		UniversityDetailsDom studentDataList = universityManager.getStudentsOfUniversity(universityName);
		
		if(studentDataList != null)
		{
			modelAndView.addObject("studentDataList", studentDataList);
		}
		
		int currentYear = Calendar.getInstance().get(Calendar.YEAR);
		currentYear +=2;
		int previousYear = currentYear - 10;
		
		for(int i = (currentYear); i >= previousYear; i--)
		{
			batchList.add(currentYear);
			currentYear--;
		}
		
		modelAndView.addObject("batch", batchList);
		
		String studentEmailID = "";
		
		List<String> emailIdList = new ArrayList<String>();
		
		Map<String,String> registeredStudentsMap = studentDataList.getRegisteredStudents();
		
		if(registeredStudentsMap != null)
		{
			modelAndView.addObject("registeredStudentsCount",registeredStudentsMap.size());
		
			for(Entry<String, String> entry : registeredStudentsMap.entrySet())
			{
				emailIdList.add(entry.getKey());
			}
		
		}
		
		studentEmailID = CaerusCommonUtility.getCassandraInQueryString(emailIdList);
	
		List<StudentDom> studentDetailsList = null;
		
		if(studentEmailID != "")
		{
			studentDetailsList = studentManager.getCandidateListByEmailId(studentEmailID);
		}
		
		if(studentDetailsList != null)
		{	
			for (StudentDom student : studentDetailsList) {
				
				for (Entry<String, String> entry : registeredStudentsMap.entrySet()) {
					
					if(student.getEmailID().equals(entry.getKey()))
					{
						student.setBatch(entry.getValue());
					}
					
				}
				
			}
			modelAndView.addObject("student", studentDetailsList);
		}
			
		// returning the modelAndView object
		return  modelAndView;
		
	}
	
	
	/**
	 * This method is used to download the template by a university user(placement officer)/admin
	 * @param httpServletRequest 
	 * @param httpServletResponse
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UNIVERSITY_DOWNLOAD_TEMPLATE)
	public void downloadTemplate(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException,IOException
	{
		// Getting the file from within the folder
		File rootDir = new File( servletContext.getRealPath("/WEB-INF/classes/template.xls") );
		String filename = "template.xls";
		
		   OutputStream out = httpServletResponse.getOutputStream();
		   FileInputStream in;
		
		   // Exception handling
		   try {
			   in = new FileInputStream(rootDir.toString());
			   httpServletResponse.setContentType("application/vnd.ms-excel");
			   httpServletResponse.addHeader("content-disposition", "attachment; filename=" + filename);
			   
			   
			   	int octet;
			 	 while ((octet = in.read()) != -1)
			    out.write(octet);

			   in.close();
			   out.close();
			   logger.info(CaerusLoggerConstants.DOWNLOAD_TEMPLATE);
		   	} 
		   catch (FileNotFoundException e) {
			
			e.printStackTrace();
		}
		  
	}
	

	/**
	 * This method is used to delete any registered or unregistered student by a university user(placement officer)/admin
	 * @param httpServletRequest
	 * @param httpServletResponse
	 */
	@RequestMapping(value= CaerusAnnotationURLConstants.UNIVERSITY_DELETE_STUDENTS, method = RequestMethod.POST)
	public void deleteStudents(@RequestBody HashMap<String,String> deleteStudentsMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception
	{
		//Getting a session from request
		HttpSession session = httpServletRequest.getSession();
		
		// Retrieving university name from the database
		String universityName= (String) session.getAttribute("univName");
		
		HashMap<String,String> validEntries = new HashMap<String,String>();
		Map<String,String> registeredStudents = new HashMap<String,String>();
	    Map<String,String> unRegisteredStudents = new HashMap<String,String>();
	    Map<String,Map<String,String>> students= new HashMap<String,Map<String,String>>();

	    //function modified on 28-07-2014 to accomodate deletion of multiple Candidates from Thin Client 
	    if(null!=deleteStudentsMap|| deleteStudentsMap.size()!=0)
	    	try{
	    		validEntries= deleteStudentsMap;
	    	}
	      catch(NullPointerException e){
	    	  e.printStackTrace();
	      }
	    
	    		
		if(universityName != null && validEntries != null )	
    	{
			// check if the students are registered with Imploy or not
	    	students = universityManager.checkRegisteredStudent(universityName,validEntries);	
	    	
	    	registeredStudents= students.get("registeredStudents");
	    	unRegisteredStudents = students.get("unRegisteredStudents");
	    	
	    	// delete the student from the registered students map
    		if(registeredStudents != null && !registeredStudents.isEmpty())
    		{
    			universityManager.deleteRegisteredStudent(universityName,validEntries);
    		}
    		
    		// delete the student from the unregistered students map
    		if(unRegisteredStudents != null && !unRegisteredStudents.isEmpty())
    		{
    			universityManager.deleteUnRegisteredStudent(universityName, validEntries);
    		}
    		
    		logger.info(CaerusLoggerConstants.DELETE_CONNECTION);
    	}

	}
	
	/**
	 * @return universityLoginCmd
	 */
	@ModelAttribute("universityLoginCmd")
	 public UniversityDetailsCom getUniversityDetailsCom() {
	  return new UniversityDetailsCom();
	 }

	/**
	 * This method is used to load the page with the model attribute object
	 * @param model
	 * @return
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_ADD_CONNECTIONS,method = RequestMethod.GET)
	public String getCategory(Model model)
	{
		model.addAttribute("universityLoginCmd",getUniversityDetailsCom());
		return "university_manage_connections";
	} 
	
	/**
	 * This method is used to add students to the existing sheet by a university user(placement officer)/ admin
	 * @param universityDetailsCmd
	 * @param result
	 * @param model
	 * @return
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_ADD_CONNECTIONS,method = RequestMethod.POST)
	public ModelAndView addConnections(@ModelAttribute("universityLoginCmd") UniversityDetailsCom universityDetailsCmd,BindingResult result,Model model, HttpServletRequest httpServletRequest)
	{
		// The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView("university/university_manage_connections");
		
		//Getting a session from request
		HttpSession session = httpServletRequest.getSession();
		
		// Retrieving university name from the database
		String universityName= (String) session.getAttribute("univName");
		
		UniversityDetailsDom studentDataList = new UniversityDetailsDom();
		List<Integer> batchList = new ArrayList<Integer>();
		List<String> existingStudentsList = new ArrayList<String>();
		
		Map<String,String> registeredStudents = new HashMap<String,String>();
	    Map<String,String> unRegisteredStudents = new HashMap<String,String>();
		Map<String,String> validEntries = new HashMap<String,String>();
		Map<String,String> registeredEntries = new HashMap<String,String>();
		Map<String,String> unregisteredEntries = new HashMap<String,String>();
		Map<String,String> existingStudents = new HashMap<String,String>();
		Map<String,String> notExistingStudents = new HashMap<String,String>();
		Map<String,Map<String,String>> existingStudentsMap = new HashMap<String,Map<String,String>>();
		
		String emailId = universityDetailsCmd.getEmailAddress();
		String batch = universityDetailsCmd.getBatch();
		
		Map<String,Map<String,String>> students= new HashMap<String,Map<String,String>>();

		// Retrieving student details from the database
		studentDataList = universityManager.getStudentsOfUniversity(universityName);
			
		if(studentDataList != null)
		{			
			 registeredEntries = studentDataList.getRegisteredStudents();
			 unregisteredEntries = studentDataList.getUnregisteredStudents();		
		}
		
		if(null!=emailId && null!=batch && !emailId.isEmpty() && !batch.isEmpty())
		{
			boolean validEmailId = CaerusCommonUtil.isValidEmailId(emailId);
			if(validEmailId)
			{	
				// Adding values 
				if(unregisteredEntries == null || registeredEntries == null || unregisteredEntries.isEmpty() || registeredEntries.isEmpty())
				{
					validEntries.put(emailId, batch);
				}
				
				if(registeredEntries != null && unregisteredEntries != null && !registeredEntries.isEmpty() && !unregisteredEntries.isEmpty())
				{
					// Check for duplicate values
					if(registeredEntries.containsKey(emailId) || unregisteredEntries.containsKey(emailId))
					{ 
						modelAndView.addObject("duplicate","Entry Already Exists");
					}
					else
					{
						validEntries.put(emailId, batch);
					}
				}	
				
			}
			else
			{
				modelAndView.addObject("invalid","Invalid Email Id");
			}
			
			if(universityName != null && validEntries != null )	
        	{
				// check if the students are registered with Imploy or not
				existingStudentsMap = universityManager.checkExistingStudents(validEntries);
				
		    	existingStudents= existingStudentsMap.get("existingStudents");
		    	notExistingStudents = existingStudentsMap.get("notExistingStudents");
		    	
		    	if(notExistingStudents == null)
		    	{
		    		students = universityManager.checkRegisteredStudent(universityName,validEntries);
		    	}
		    	else
		    	{	
		    		students = universityManager.checkRegisteredStudent(universityName,notExistingStudents);
		    	}
		    	
				registeredStudents= students.get("registeredStudents");
		    	unRegisteredStudents = students.get("unRegisteredStudents");
		    	
		    	// Adding the student to registered students map
        		if(registeredStudents != null && !registeredStudents.isEmpty() && (existingStudents == null || existingStudents.isEmpty()))
        		{
    				universityManager.addRegisteredStudentToMap(universityName,registeredStudents);	
        		}
        		
        		// Adding the student to unregistered students map
        		if(unRegisteredStudents != null && !unRegisteredStudents.isEmpty())
        		{
    				universityManager.addUnRegisteredStudentToMap(universityName, unRegisteredStudents);
    				//Indicates an invitation is being sent to the Candidate
    				modelAndView.addObject("invitedStudents",unRegisteredStudents);
    			
        		}
        		
        		
        		logger.info(CaerusLoggerConstants.ADD_CONNECTION);
        	}
			
			if(existingStudents != null)
    		{
    			for (String entry: existingStudents.keySet()) {
    				existingStudentsList.add(entry);
				}

    			modelAndView.addObject("existingStudents",existingStudentsList);
    		}
			
			
		}
		
		else
		{
			modelAndView.addObject("error","Enter data");
		}
		
		// Retrieving student details from the database
		studentDataList = universityManager.getStudentsOfUniversity(universityName);
		
		if(studentDataList != null)
		{
			modelAndView.addObject("studentDataList", studentDataList);
		}
		
		int currentYear = Calendar.getInstance().get(Calendar.YEAR);
		currentYear +=2;
		int previousYear = currentYear - 10;
		
		for(int i = (currentYear); i >= previousYear; i--)
		{
			batchList.add(currentYear);
			currentYear--;
		}
		
		modelAndView.addObject("batch", batchList);
		
		String studentEmailID = "";
		List<String> emailIdList = new ArrayList<String>();
		
		Map<String,String> registeredStudentsMap = new HashMap<String,String>();
		
		if(studentDataList!=null)
			registeredStudentsMap = studentDataList.getRegisteredStudents();
		
		if(registeredStudentsMap != null)
		{
			for(Entry<String, String> entry : registeredStudentsMap.entrySet())
			{
				emailIdList.add(entry.getKey());
			}
			
		}
		
		List<StudentDom> studentDetailsList = null;
		
		studentEmailID = CaerusCommonUtility.getCassandraInQueryString(emailIdList);
		
		if(studentEmailID != "")
		{
			studentDetailsList = studentManager.getCandidateListByEmailId(studentEmailID);
		}
		
		if(studentDetailsList != null)
		{	
			for (StudentDom student : studentDetailsList) {
				
				for (Entry<String, String> entry : registeredStudentsMap.entrySet()) {
					
					if(student.getEmailID().equals(entry.getKey()))
					{
						student.setBatch(entry.getValue());
					}
					
				}
				
			}
			modelAndView.addObject("student", studentDetailsList);
		}
		
		 // returning the modelAndView object
        return modelAndView;
		
	}
	
}
