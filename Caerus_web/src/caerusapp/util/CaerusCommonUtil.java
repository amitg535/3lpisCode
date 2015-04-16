package caerusapp.util;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import com.google.common.base.Splitter;

/**
 * This class is used to add functions that are common to all entities (candidate, university, employer) and hence can be used by calling the function name in the controllers
 *
 */
public class CaerusCommonUtil {

	/** Logger for this class and subclasses */
	public static Log logger = LogFactory.getLog("CaerusCommonUtil");


	/**
	 * This method is used to fetch the current System date in dd-mm-yyyy format
	 * @return date
	 */
	public static String getCurrentDateFormatDDMMYYYY() {

		DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");

		Calendar cal = Calendar.getInstance();
		
		// Getting the system date and formatting it as per given format
		return dateFormat.format(cal.getTime());

	}

	/**
	 * This method is used to check if emailId is in the correct format
	 * @param strEmailId
	 * @return boolean
	 */
	public static boolean isValidEmailId(String strEmailId) {

		String emailPattern = ".+@.+\\.[a-z]+";

		// check if the input string matches the defined pattern, then return true
		if (strEmailId.matches(emailPattern)) {

			return true;
		}

		return false;

	}

	/**
	 * This method is used to check if the year of passing of a candidate falls within the specified limits
	 * @param batch
	 * @return boolean
	 */
	public static boolean isValidBatch(String batch) {

		int batch1 = Integer.parseInt(batch); 
		int year = Calendar.getInstance().get(Calendar.YEAR);
		
		// check if the input string falls within the defined limits, then return true
		if (batch1 >= 2005 & batch1 <= (year+2)) {

			return true;
		}

		return false;

	}


	/**
	 * This method is used to check if special characters exist in an input string
	 * @param strInput
	 * @return boolean
	 */
	
	public static boolean isSpecialCharactersExist(String strInput) {

		Pattern pattern = Pattern.compile("[/,:<>!~@#$%^&()=?()\"|!\\[#$]");

		Matcher matcher = pattern.matcher(strInput);

		// check if the input string matches the defined format, then return true
		if (matcher.matches()) {

			return true;

		}

		return false;

	}

	/**
	 * This method is used to check if numeric values exist in an input string
	 * @param strInput
	 * @return boolean
	 */
	public static boolean isNumericValue(String strInput) {

		String numberPattern = "^[0-9 +-]*$";

		// check if the input string matches the defined format, then return true
		if (strInput.matches(numberPattern)) {

			return true;
		}

		return false;

	}

	/**
	 * This method is used to check if white spaces exist in an input string
	 * @param strInput
	 * @return boolean
	 */
	public static boolean isWhiteSpaceExist(String strInput) {

		for (int i = 0; i < strInput.length(); i++) {

			// check if the input string contains a white space, then return true
			if (strInput.charAt(i) == ' ') {

				return true;
			}

		}

		return false;

	}

	/**
	 * This method is used to sort a map object
	 * @param mapCollectionObject
	 * @return sortMap
	 */
	public static Map<String, String> sortMapObject(
			Map<String, String> mapCollectionObject) {

		// TreeMap stores data in a sorted order
		Map<String, String> sortMap = new TreeMap<String, String>(
				mapCollectionObject);

		return sortMap;

	}

	
	/**
	 * This method is used to convert a list of string object to a string object
	 * @param formulaExpressionList
	 * @return strFormula
	 */

	public static String getExpressionListAsString(
			List<String> formulaExpressionList) {

		List<String> formulaList = new ArrayList<String>(formulaExpressionList);

		String strFormula = "";

		Iterator<String> iterator = formulaList.iterator();

		// Iterating through the list of string object
		while (iterator.hasNext()) {

			strFormula += iterator.next();

		}

		return strFormula;

	}
	

	/**
	 * This method is used to get the extension of an uploaded file
	 * @author BalajiI
	 * @param fileName
	 * @return fileExtension
	 */
	public static  final String getFileExtension(String fileName)
	{
		String fileExtension=null;
		
			// check if file name is not null, then find the extension
			if( fileName!=null && !fileName.equals("") )
			{
			int indexOfSeparator= fileName.lastIndexOf(".");
			fileExtension= fileName.substring(indexOfSeparator+1,fileName.length());
			}
			
			return fileExtension;
		
	}
	
	
	
	/**
	 * This method is used to sort a map in descending order based on the values in the map
	 * @author ravishag,BalajiI
	 * @param unsortedMap
	 * @return sortedMap in Descending Order
	 */
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map sortMapOnValues(Map unsortedMap) {
		 
		List list = new LinkedList(unsortedMap.entrySet());
 
		// sort list based on comparator
		Collections.sort(list, new Comparator()
		{
			public int compare(Object o1, Object o2) 
			{
				return ((Comparable) ((Map.Entry) (o2)).getValue())
                                       .compareTo(((Map.Entry) (o1)).getValue());
			}
		});
		
		Map sortedMap = new LinkedHashMap();
		
		// Putting sorted values in a map
		for (Iterator it = list.iterator(); it.hasNext();) {
			Map.Entry entry = (Map.Entry) it.next();
			sortedMap.put(entry.getKey(), entry.getValue());
		}
		
		return sortedMap;
	}

	
	
	
	/**
	 * This method is used to take a list of string object having values at index 0 and convert it to a list of string object with string values at different indexes
	 * @author BalajiI
	 * @param inputList
	 * @return outputList
	 */
	public static List<String> stringToListCandidateProfile(
			List<String> inputList) {
		
		List<String> outputList=new ArrayList<String>();
		
		// Iterating through the input object
		for (String primarySkill : inputList) 
		{
		
			// check if the string contains a ',', then split it
			if(primarySkill.contains(","))
			{
				String []localArray=primarySkill.split(",");
				for(String string:localArray)
				{
					outputList.add(string);
				}
			}
		
			// adding values to the output object
			if(!primarySkill.contains(","))
			{
				outputList.add(primarySkill);
			}
			
		}
		
		return outputList;
	}
	
	
	/**
	 * This method is used to sort a map in descending order based on the keys in the map
	 * @author RavishaG
	 * @param unsortedMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Map sortMapOnKeyInDescendingOder(Map unsortedMap) {
		 
		List list = new LinkedList(unsortedMap.entrySet());
 
		// sort list based on comparator
		Collections.sort(list, new Comparator()
		{
			public int compare(Object o1, Object o2) 
			{
				return ((Comparable) ((Map.Entry) (o2)).getKey())
                                       .compareTo(((Map.Entry) (o1)).getKey());
			}
		});
		
		Map sortedMap = new LinkedHashMap();
		
		// Putting sorted values in a map
		for (Iterator it = list.iterator(); it.hasNext();) {
			Map.Entry entry = (Map.Entry) it.next();
			sortedMap.put(entry.getKey(), entry.getValue());
		}
		
		return sortedMap;
	}

	public static List<String> removeExtraneousBracketsFromList(List<String> redundantList){
		String resurrectedSecondarySkills = redundantList.toString().trim().replace("]", "").replace("[", "");
		return Arrays.asList(resurrectedSecondarySkills.split(","));
	}
	
	public static final List<String> getEligibleBatches(){
		return Arrays.asList(new String[]{"Spring-2013","Winter-2013","Spring-2014","Winter-2014","Spring-2015","Winter-2015"});
	}
	
	/***
	 * This method is used to convert Time stamp to Date
	 * @author RavishaG
	 * @param timestamp
	 * @return String
	 * @throws ParseException
	 */
	public static String changeDateFormat(String sourceFormat,String outputFormat,String timestamp) throws ParseException
	{
		DateFormat formatter = new SimpleDateFormat(sourceFormat);
		Calendar cal = Calendar.getInstance();

		 Date date1 = (Date)formatter.parse(timestamp);
		 cal.setTime(date1);
		 
		 String formattedDate = cal.get(Calendar.YEAR) + "-" + cal.get(Calendar.MONTH) + "-" +cal.get(Calendar.DATE);
		 
		// String formatedDate = cal.get(Calendar.DATE) + "-" + (cal.get(Calendar.MONTH) + 1) + "-" + cal.get(Calendar.YEAR);
		
		return formattedDate;
	}
	
	/**
	 * This method is used to calculate the age
	 * @param birthDate
	 * @return int (age)
	 * 
	 */
	public static int getAge(String birthDate)
	{
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date birthDayDate = null;
		Date todayDate = null;
		
		try
		{
			birthDayDate = format.parse(birthDate);
			todayDate = format.parse(format.format(new Date()));
		}
		catch(Exception ex)
		{
			logger.error(ex.getStackTrace());
		}
		
		long difference = todayDate.getTime() - birthDayDate.getTime();
		long differenceInDays = difference / (24 * 60 * 60 * 1000);
		
		int age = 0;
		if(differenceInDays!=0)
		{
			age = (int) (differenceInDays /365);
		}
		return age;
	}
	
	
	/**
	 * This method is used to return the mail template sent to user during registration
	 * @author RavishaG
	 * @param authority
	 * @return Document
	 */
	public static Document registrationMailTemplate(String authority)
	{
		StringBuilder html = new StringBuilder();
		
		html.append("<!DOCTYPE html>");
		html.append("<html lang='en'>");
		html.append("<head>");
		html.append("<meta charset='utf-8'>");
		html.append("<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'>");
		html.append("<title>Candidate View Particular Job</title>");
		html.append("<meta name='description' content=''>");
		html.append("<meta name='author' content=''>");
		html.append("</head>");
		html.append("<body style='font-family:Tahoma; margin:0; padding:0; font-size:14px; line-height:1.8em;'>");
		html.append("<table width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc;border-bottom:0px solid #ccc; padding:5px;' align='center'>");
		html.append("<tr>");
		html.append("<td style='padding:15px; background:#f55b5b; color:#fff;text-transform:uppercase; text-align:center; font-size:26px;'><span style='font-style:italic;color:#fff94D; font-size:30px;'>Welcome </span> &nbsp To Imploy.Me </td>");
		html.append("</tr>");

		html.append("</table>");

		html.append("<table id='abc' width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc; padding:5px;border-top:0px solid #ccc;' align='center'>");
		html.append("<tr>");
		html.append("<td>");
		
		html.append("<table>");
		html.append("<tbody><tr>");
		if(authority.equals("BetaUser")){
			html.append("<td style='color: #0B99B3;font-size: 18px;padding-top: 20px;'>Dear <span id='userName'>,</td>");
			html.append("</tr>");
			html.append("<tr>");
			html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'>Thank you for registering with Imploy.ME BETA.<br>We are still in Beta Stage , evaluating feedback from our precious users.We will be soon sending you another e-mail informing your login credentials which you can use to explore our offerings.<br>Let us start the journey together.<br></td>");
			html.append("</tr>");
			html.append("<tr>");
			html.append("<td style='padding-top : 15px;'>");
			html.append("</td>");
			html.append("</tr>");
		}
			
		else{
		html.append("<td style='color: #0B99B3;font-size: 18px;padding-top: 20px;'>Dear User,</td>");
		html.append("</tr>");
		/*html.append("<tr>");
			
		html.append("<td style='color: #f55b5b;font-size: 16px;font-weight: normal;'>You have been given access to the Imploy application.</td>");
		html.append("</tr>");*/
		html.append("<tr>");
		html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'>Thanks for registering with imploy.me to explore the job opportunities and to network with thousands of companies .<br>Imploy.me will help you find the right job match , build your resumes online , and connect with your campus to explore more on recruitment , job fairs and seminars<br><span id='username'></span><br><span id='password'></span></td>");
		html.append("</tr>");
		/*html.append("<tr>");
		html.append("<td style='color: #4b4b4b;font-size: 14px;padding: 0.2em 0; font-style:italic; padding-bottom:15px;'>");
		html.append("<strong>Your Password is</strong><span>12345678</span></td>");
		html.append("</tr>");*/
		
		if(authority.equals("ROLE_STUDENT"))
		{
			html.append("<tr>");
			html.append("<td style='padding-top : 15px;'>");
			html.append("<a href='#' target='_blank' style='color:#fff49D;'><input type='button' value='Click here' style='height: 34px;padding: 0.25em 2.3em !important; margin-right: 0.5em;cursor: pointer;color: #000;overflow: visible;font-size: 14px;text-align: center;background: #8AECFD;-moz-border-radius: 2px;-webkit-border-radius: 2px;border-radius: 2px; border:none; border-bottom: 1px solid #242424;'/></a>to Activate your account");
			html.append("</td>");
			html.append("</tr>");
		}
		else
		{
			html.append("<tr>");
			html.append("<td style='padding-top : 15px;'>");
			html.append("<a href='#' target='_blank'>Click Here to Login</a>");
			html.append("</td>");
			html.append("</tr>");
		}
		
		
		}
		html.append("<tr>");
		html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top : 20px;'>Regards,<br>Imploy.me Team</td>");
		html.append("</tr>");
		html.append("<tr>");
		html.append("</tbody>");
		html.append("</table>");
		html.append("</td>");
		html.append("</tr>");
		html.append("</table>");
		html.append("</body>");
		html.append("</html>");
		
		Document document = null;
		try 
		{
			document = Jsoup.parse(html.toString());
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		if(authority.equals("BetaUser"))
		document.getElementById("userName").text(authority);
		
		return document;
		
	}
	
	public static Date getDateFromString(String dateString,String inputDateFormat){
	    SimpleDateFormat yourDateFormat = new SimpleDateFormat(inputDateFormat);
	    Date yourDate = null;
		try {
			yourDate = yourDateFormat.parse(dateString);
		} catch (ParseException e) {
			logger.error("Date Parse Exception in getDateFromString");
		}
		return yourDate;
	}

	public static Integer getYearFromDate(Date selectedDate) {
		 	Calendar cal = Calendar.getInstance();
		    cal.setTime(selectedDate);
		    int year = cal.get(Calendar.YEAR);
		    return year;
	}
	
	
	/**
	 * This method is used to return the mail template sent to user during registration
	 * @param authority
	 * @return Document
	 */
	public static Document eventUpdateMailTemplate()
	{
		StringBuilder html = new StringBuilder();
		
		html.append("<!DOCTYPE html>");
		html.append("<html lang='en'>");
		html.append("<head>");
		html.append("<meta charset='utf-8'>");
		html.append("<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'>");
		html.append("<title>Candidate View Particular Job</title>");
		html.append("<meta name='description' content=''>");
		html.append("<meta name='author' content=''>");
		html.append("</head>");
		html.append("<body style='font-family:Tahoma; margin:0; padding:0; font-size:14px; line-height:1.8em;'>");
		html.append("<table width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc;border-bottom:0px solid #ccc; padding:5px;' align='center'>");
		html.append("<tr>");
		html.append("<td style='padding:15px; background:#f55b5b; color:#fff;text-transform:uppercase; text-align:center; font-size:26px;'>Event Status Update </td>");
		html.append("</tr>");

		html.append("</table>");

		html.append("<table id='abc' width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc; padding:5px;border-top:0px solid #ccc;' align='center'>");
		html.append("<tr>");
		html.append("<td>");
		
		html.append("<table>");
		html.append("<tbody><tr>");
		html.append("<td style='color: #0B99B3;font-size: 18px;padding-top: 20px;'>Dear User,</td>");
		html.append("</tr>");
		html.append("<tr>");
		html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'><span id='username'></span><br></td>");
		html.append("</tr>");
		
		html.append("<tr>");
		html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top : 20px;'>Regards,<br>Imploy.me Team</td>");
		html.append("</tr>");
		html.append("<tr>");
		html.append("</tbody>");
		html.append("</table>");
		html.append("</td>");
		html.append("</tr>");
		html.append("</table>");
		html.append("</body>");
		html.append("</html>");
		
		Document document = null;
		try 
		{
			document = Jsoup.parse(html.toString());
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return document;
		
	}
	
	

	public static Date getDateByDifference(int numberOfDays)
	{
		Calendar calendar = Calendar.getInstance();
    	calendar.setTime(new Date());
    	calendar.add(Calendar.DAY_OF_YEAR, - numberOfDays);
    	Date oldDate = calendar.getTime();
    	
    	return oldDate == null ? new Date() : oldDate;
	}
	
	public static Date getFutureDate(int numberOfDays)
	{
		Calendar calendar = Calendar.getInstance();
    	calendar.setTime(new Date());
    	calendar.add(Calendar.DAY_OF_YEAR, + numberOfDays);
    	Date newDate = calendar.getTime();
    	
    	return newDate == null ? new Date() : newDate;
	}
	
	public static Set<String> readCSVOrTextFile(byte[] fileData) {
		BufferedReader br = null;
		String line = "";
		String splitCharacter = ",";
		Set<String> elements = new TreeSet<String>();
		InputStream inputStream = null;

		try {
			
			inputStream = new ByteArrayInputStream(fileData);
			br = new BufferedReader(new InputStreamReader(inputStream));
			while ((line = br.readLine()) != null) {
				line = line.replaceAll("\"", "").trim();
				elements.addAll(new TreeSet<String>(Splitter.on(splitCharacter).omitEmptyStrings().trimResults().splitToList(line)));
			}
	 
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return elements == null ? new HashSet<String>() : elements;
	  }
	
	
	public static Set<String> readExcelFiles(InputStream fileData) throws IOException{
		Set<String> excelElements = new TreeSet<String>();
		
		//Get the workbook instance for XLS file 
		HSSFWorkbook workbook = new HSSFWorkbook(fileData);
		 
		//Get first sheet from the workbook
		HSSFSheet sheet = workbook.getSheetAt(0);
		
		for (Row row : sheet) {
			for (Cell cell : row) {
				
				if(cell.getCellType() == Cell.CELL_TYPE_STRING)
	            {
						excelElements.add(cell.getStringCellValue().trim());
						System.out.print(cell.getStringCellValue() + "\t");
	            }
			}
		   System.out.println(" ");
		}
	   System.out.println("Read xls file Successfully");
	   return excelElements == null ? new TreeSet<String>() : excelElements;

	}

	public static Date getPastDate(int numberOfYears, String dateFormat) {
		Calendar cal  = Calendar.getInstance();
	    cal.add(Calendar.YEAR, -numberOfYears);
	    
	    Date date = cal.getTime();
	    
	    SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
	    
	    try {
			date = sdf.parse(new Date(cal.getTimeInMillis()).toString());
		} catch (ParseException e) {
			logger.error(CaerusStringConstants.DATE_FORMAT_EXCEPTION +" in getPastDate");
		}
	    
	    String result = sdf.format(new Date(cal.getTimeInMillis()));
	    
		return date;
	}
}