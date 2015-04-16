package caerusapp.util;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import caerusapp.domain.common.CareerPathLevelDom;
import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.common.MessageDom;
import caerusapp.domain.common.UpcomingEventsDom;
import caerusapp.domain.employer.EmployerCampusJobPostDom;
import caerusapp.domain.employer.EmployerEventDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.domain.university.UniversityDetailsDom;
import caerusapp.domain.university.UniversityEventDom;
//import caerusapp.domain.university.UniversityLoginDom;

/**
 * This class has common utility methods
 *
 */
public class CaerusCommonUtility {

	public static Log logger = LogFactory.getLog("CaerusCommonUtility");
	
	/**
	 * This method is used to convert String into Date 
	 * @author PallaviD
	 *  @param dateString
	 * @param dateFormat
	 * @return Date
	 */
	public static Date stringToDate(String dateString,String dateFormat)
	{
		Date date = null;
			try
			{
				SimpleDateFormat formatter = new SimpleDateFormat(dateFormat);
				formatter.applyPattern(dateFormat);
				date = formatter.parse(dateString);
			}
			catch(Exception e)
			{
				logger.warn("Date Parse Exception in CaerusCommonUtil stringToDate()");	
			}
		return date;
	}	
	
	/***
	 * This method is used to convert Time stamp to Date
	 * @author RavishaG
	 * @param timestamp
	 * @return String
	 * @throws ParseException
	 */
	public static String parseTimestampToDate(String timestamp) throws ParseException
	{
		DateFormat formatter = new SimpleDateFormat("E MMM dd HH:mm:ss Z yyyy");
		Calendar cal = Calendar.getInstance();

		 Date date1 = (Date)formatter.parse(timestamp);
		 cal.setTime(date1);
		 String formatedDate = cal.get(Calendar.DATE) + "-" + (cal.get(Calendar.MONTH) + 1) + "-" + cal.get(Calendar.YEAR);
		
		return formatedDate;
	}

	
	/**This method is used to sort Map 
	 * @author BalajiI,TrishnaR
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
				return ((Comparable) ((Map.Entry) (o2)).getValue()).compareTo(((Map.Entry) (o1)).getValue());
			}
		});
		Map sortedMap = new LinkedHashMap();
		for (Iterator it = list.iterator(); it.hasNext();) {
			Map.Entry entry = (Map.Entry) it.next();
			sortedMap.put(entry.getKey(), entry.getValue());
		}
		return sortedMap;
	}
	
	/***
	 * This method is used to write input stream to file 
	 * @author RavishaG
	 * @param inputStreamObject
	 * @return File
	 */
	
	public static File writeInputStreamToFile(InputStream inputStreamObject)
	{
		OutputStream outputStream = null;
		File tempFile = null;
		
		try {
			
			try {
				
				tempFile = File.createTempFile("qrcodeImage",".jpg");
				
			} catch (IOException e1) {
				
			}
	        
			outputStream = new FileOutputStream(tempFile);
	 
			int read = 0;
			byte[] bytes = new byte[1024];
	 
			while ((read = inputStreamObject.read(bytes)) != -1) {
				outputStream.write(bytes, 0, read);
			}
	 
		} catch (IOException e) {
			e.printStackTrace();
		} 
		finally {
			
			if (inputStreamObject != null) {
				try {
					inputStreamObject.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
			if (outputStream != null) {
				try {
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
	 
			}
		}
	
	return tempFile;
	}
	
	
	
	
	/**
	 * This method is used to Remove a String from a List
	 * @author PallaviD
	 * @param inputList
	 * @param redundantString
	 * @return List<String> (Formatted List)
	 */
	public static List<String> removeRedundantStringFromList(List<String> inputList,String redundantString)
	{
		if(inputList.contains(redundantString))
		{
			inputList.remove(inputList.indexOf(redundantString));
		}
		
		return inputList;
	}	
	
	/**
	 * This method is used to get last element of Map
	 * @author RavishaG
	 * @param Map<String1,String1> map
	 * @return Entry<String1,String1>
	 */
	public static <String,String1> Map.Entry<String1,String1> getLastMapEntry(Map<String1,String1> map) {
		
	    Iterator<Map.Entry<String1,String1>> iterator = map.entrySet().iterator();
	    Map.Entry<String1,String1> result = null;
	    
	    while (iterator.hasNext()) {
	        result = iterator.next();
	    }
	    
	    return result;
	}
	
	/**
	 * This method is used to sort a list in descending order based on date
	 * @author ravishag
	 * @param unsortedList
	 * @return list
	 */
	@SuppressWarnings("unchecked")
	public static List sortListByDateReverse(List unsortedList, String className) {
		
		@SuppressWarnings("rawtypes")
		List sortedList = new ArrayList();
		
		if(className.equals("UniversityDetailsDom"))
		{
			Collections.sort(unsortedList, new Comparator<UniversityDetailsDom>(){
				public int compare(UniversityDetailsDom o1, UniversityDetailsDom o2) {
					  
					  String dateFormat = "dd-MM-yyyy";
					  Date d1 = CaerusCommonUtility.stringToDate(o1.getPostedOn(),dateFormat);
					  Date d2 =  CaerusCommonUtility.stringToDate(o2.getPostedOn(),dateFormat);
					   
					  int compareTo = 0;
					  if(d1 != null && d2 != null)
						  compareTo = d2.compareTo(d1);
					  
				      return compareTo;
				  }
			});
		
			List<UniversityDetailsDom> list = new LinkedList<UniversityDetailsDom>(unsortedList);
			
			// Putting sorted values in a list
			for (Iterator<UniversityDetailsDom> it = list.iterator(); it.hasNext();) {
				sortedList.add((UniversityDetailsDom) it.next());
				
			}
		}
		
		if(className.equals("EmployerCampusJobPostDom"))
		{
			Collections.sort(unsortedList, new Comparator<EmployerCampusJobPostDom>(){
				public int compare(EmployerCampusJobPostDom o1, EmployerCampusJobPostDom o2) {
					  String dateFormat = CaerusAPIStringConstants.DISPLAY_DATE_FORMAT;
					  
					  Date d1 = CaerusCommonUtility.stringToDate(o1.getPostedOn(),dateFormat);
					  Date d2 = CaerusCommonUtility.stringToDate(o2.getPostedOn(),dateFormat);
					  
					  int compareValue = 0;
					  
					  if(null != d1 && null != d2)
				       compareValue = d2.compareTo(d1);
					  
					  return compareValue;
				  }
			});
		
			List<EmployerCampusJobPostDom> list = new LinkedList<EmployerCampusJobPostDom>(unsortedList);
			
			// Putting sorted values in a list
			for (Iterator<EmployerCampusJobPostDom> it = list.iterator(); it.hasNext();) {
				sortedList.add((EmployerCampusJobPostDom) it.next());
				
			}
		}
		
		if(className.equals("EmployerEventDom"))
		{
			Collections.sort(unsortedList, new Comparator<EmployerEventDom>(){
				public int compare(EmployerEventDom o1, EmployerEventDom o2) {
					  
					  String dateFormat = "E MMM dd HH:mm:ss Z yyyy";
					
					  Date d1 = CaerusCommonUtility.stringToDate(o1.getStartDate(),dateFormat);
					  Date d2 =  CaerusCommonUtility.stringToDate(o2.getStartDate(),dateFormat);
					  
					  Integer d = 0;
					 
					  
					  if(d1 != null && d2 != null)
						  d = d2.compareTo(d1);
						  
				      return d;
				  }
			});
		
			List<EmployerEventDom> list = new LinkedList<EmployerEventDom>(unsortedList);
			
			// Putting sorted values in a list
			for (Iterator<EmployerEventDom> it = list.iterator(); it.hasNext();) {
				sortedList.add((EmployerEventDom) it.next());
				
			}
		}
		
		if(className.equals("UniversityEventDom"))
		{
			Collections.sort(unsortedList, new Comparator<UniversityEventDom>(){
				public int compare(UniversityEventDom o1, UniversityEventDom o2) {
					  
					  String dateFormat = "E MMM dd HH:mm:ss Z yyyy";
					
					  Date d1 = CaerusCommonUtility.stringToDate(o1.getStartDate(),dateFormat);
					  Date d2 =  CaerusCommonUtility.stringToDate(o2.getStartDate(),dateFormat);
					  
				      return d2.compareTo(d1);
				  }
			});
		
			List<UniversityEventDom> list = new LinkedList<UniversityEventDom>(unsortedList);
			
			// Putting sorted values in a list
			for (Iterator<UniversityEventDom> it = list.iterator(); it.hasNext();) {
				sortedList.add((UniversityEventDom) it.next());
				
			}
		}
		
		if(className.equals("JobDetailsDom"))
		{
			Collections.sort(unsortedList, new Comparator<JobDetailsDom>(){
				public int compare(JobDetailsDom o1, JobDetailsDom o2) {
					String dateFormat = "E MMM dd HH:mm:ss Z yyyy";
					
					  
					  Date d1 = CaerusCommonUtility.stringToDate(o1.getPostedOn(),dateFormat);
					  Date d2 = CaerusCommonUtility.stringToDate(o2.getPostedOn(),dateFormat);
					  
					  int compareValue = 0;
					  
					  if(null != d1 && null != d2)
				       compareValue = d2.compareTo(d1);
					  
					  return compareValue;
				  }
			});
		
			List<JobDetailsDom> list = new LinkedList<JobDetailsDom>(unsortedList);
			
			// Putting sorted values in a list
			for (Iterator<JobDetailsDom> it = list.iterator(); it.hasNext();) {
				sortedList.add((JobDetailsDom) it.next());
				
			}
		}
		
		if(className.equals("UpcomingEventsDom"))
		{
			Collections.sort(unsortedList, new Comparator<UpcomingEventsDom>(){
				public int compare(UpcomingEventsDom o1, UpcomingEventsDom o2) {
					  
					  String dateFormat = "E MMM dd HH:mm:ss Z yyyy";
					
					  Date d1 = CaerusCommonUtility.stringToDate(o1.getStartDate(),dateFormat);
					  Date d2 =  CaerusCommonUtility.stringToDate(o2.getStartDate(),dateFormat);
					  
				      return d2.compareTo(d1);
				  }
			});
		
			List<UpcomingEventsDom> list = new LinkedList<UpcomingEventsDom>(unsortedList);
			
			// Putting sorted values in a list
			for (Iterator<UpcomingEventsDom> it = list.iterator(); it.hasNext();) {
				sortedList.add((UpcomingEventsDom) it.next());
				
			}
		}
		
		
		if(className.equals("MessageDom"))
		{
			Collections.sort(unsortedList, new Comparator<MessageDom>(){
				public int compare(MessageDom o1, MessageDom o2) {
					  
					  String dateFormat = "E MMM dd HH:mm:ss Z yyyy";
					
					  Date d1 = CaerusCommonUtility.stringToDate(o1.getPostedOn(),dateFormat);
					  Date d2 =  CaerusCommonUtility.stringToDate(o2.getPostedOn(),dateFormat);
					  
				      return d2.compareTo(d1);
				  }
			});
		
			List<MessageDom> list = new LinkedList<MessageDom>(unsortedList);
			
			// Putting sorted values in a list
			for (Iterator<MessageDom> it = list.iterator(); it.hasNext();) {
				sortedList.add((MessageDom) it.next());
				
			}
		}
		
		//Asc order sorting
		if(className.equals("CareerPathLevelDom"))
		{
			Collections.sort(unsortedList, new Comparator<CareerPathLevelDom>(){
				public int compare(CareerPathLevelDom o1, CareerPathLevelDom o2) {
					  
					  String dateFormat = "yyyy-MM-dd HH:mm:ss";
					  Date d1 = CaerusCommonUtility.stringToDate(o1.getInsertionTime(),dateFormat);
					  Date d2 =  CaerusCommonUtility.stringToDate(o2.getInsertionTime(),dateFormat);
					   
					  int compareTo = 0;
					  if(d1 != null && d2 != null)
						  compareTo = d1.compareTo(d2);
					  
				      return compareTo;
				  }
			});
		
			List<CareerPathLevelDom> list = new LinkedList<CareerPathLevelDom>(unsortedList);
			
			// Putting sorted values in a list
			for (Iterator<CareerPathLevelDom> it = list.iterator(); it.hasNext();) {
				sortedList.add((CareerPathLevelDom) it.next());
				
			}
			
			
		}
		
		return sortedList;
	}
	
	/**
	 * This method is used to get the difference in number of days between two dates 
	 * @param dateFormatString
	 * @param startDate
	 * @return String(dateDifference) 
	 */
	public static String getDifferenceInDays(String dateFormatString , String startDate)
	{
	    String dateDifference = "";

	    //HH converts hour in 24 hours format (0-23), day calculation
		SimpleDateFormat format = new SimpleDateFormat(dateFormatString);
 
		String dateStop = format.format(new Date());
		Date d1 = null;
		Date d2 = null;
 
		try 
		{
			d1 = format.parse(startDate);
			d2 = format.parse(dateStop);
 
			long difference = d2.getTime() - d1.getTime();
			long diffHours = difference / (60 * 60 * 1000) % 24;
			long diffDays = difference / (24 * 60 * 60 * 1000);
			long diffMinutes = difference / (60 * 1000) % 60;

			/** To Display the Number of Days since the job was posted */
				if(diffDays >= 1)
				{	
					dateDifference = diffDays+" Day(s) Ago";
				}
				else
				{
					if(diffHours >= 1)
					{
						dateDifference = diffHours + " Hour(s) Ago ";
					}
					else
					{
						dateDifference = diffMinutes+" Minute(s) Ago";
					}
				}
				
		} 
		catch (Exception e) 
		{
			logger.error(e.getStackTrace());
		}
	    
	   return dateDifference;
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
	

	@SuppressWarnings("unchecked")
	public static List sortListByVideoProfileCount(List unsortedList) {
		
		List sortedList = new ArrayList();
		
			Collections.sort(unsortedList, new Comparator<StudentDom>(){
				
				public int compare(StudentDom o1, StudentDom o2) {
					
					if(o2.getViewVideoProfileCount() == null)
					{
						o2.setViewVideoProfileCount(0);
					}
					
					if(o1.getViewVideoProfileCount() == null)
					{
						o1.setViewVideoProfileCount(0);
					}
					
					return o2.getViewVideoProfileCount().compareTo(o1.getViewVideoProfileCount());
					 
						
				  }
			});
		
			List<StudentDom> list = new LinkedList<StudentDom>(unsortedList);
			
			// Putting sorted values in a list
			for (Iterator<StudentDom> it = list.iterator(); it.hasNext();) {
				sortedList.add((StudentDom) it.next());
				
			}
		
		return sortedList;
	}
	
	
	@SuppressWarnings("unchecked")
	public static List sortListOnAppliedDate(List unsortedList, String className) {
		
		List sortedList = new ArrayList();
		
		if(className.equals("JobDetailsDom"))
		{
			Collections.sort(unsortedList, new Comparator<JobDetailsDom>(){
				public int compare(JobDetailsDom o1, JobDetailsDom o2) {
					  
					String dateFormat = "yyyy-MM-dd";
					  
				      return o2.getAppliedOn().compareTo(o1.getAppliedOn());
				  }
			});
		
			List<JobDetailsDom> list = new LinkedList<JobDetailsDom>(unsortedList);
			
			// Putting sorted values in a list
			for (Iterator<JobDetailsDom> it = list.iterator(); it.hasNext();) {
				sortedList.add((JobDetailsDom) it.next());
				
			}
		}
		return sortedList;
	}

	/**
	 * This method Compresses the Uploaded JPEG Image and returns a byte array with Compressed Image
	 * @author BalajiI
	 * @param originalImage
	 * @return byte[](Compressed Image)
	 */
	public static byte[] compressImage(byte[] originalImage)
	{
		InputStream inputStream = new ByteArrayInputStream(originalImage);
   		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();

   		byte[] compressedImageInBytes = new byte[originalImage.length];
   		
   		try
	   	{
	   		ImageOutputStream imageOutputStream = ImageIO.createImageOutputStream(byteArrayOutputStream);
	
	        float quality = 0.4f;
	 
	        // create a BufferedImage as the result of decoding the supplied InputStream
	        BufferedImage image = ImageIO.read(inputStream);
	 
	        // get all image writers for JPG format
	        Iterator<ImageWriter> writers = ImageIO.getImageWritersByFormatName("jpg");
	        
	        if (!writers.hasNext())
	            throw new IllegalStateException("No writers found");
	 
	        ImageWriter writer = (ImageWriter) writers.next();
	        writer.setOutput(imageOutputStream);
	        
	        ImageWriteParam param = writer.getDefaultWriteParam();
	 
	        // compress to a given quality
	        param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
	        param.setCompressionQuality(quality);
	        //param.setDestinationType(ImageTypeSpecifier.)
	 
	        // appends a complete image stream containing a single image and associated stream and image metadata and thumbnails to the output
	        writer.write(null, new IIOImage(image, null, null), param);
	        
	        compressedImageInBytes = byteArrayOutputStream.toByteArray();
   		}
   		catch(Exception ex)
   		{
   			ex.printStackTrace();
   		}
        return compressedImageInBytes;
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
	 * This method is used to calculate differences between current date and an upcoming date.
	 * @author TrishnaR
	 * @param dateFormatString
	 * @param date
	 * @return dateDifference(Long)
	 */
	public static StringBuilder calculateDateDifference(String dateFormatString,Long date)
	{
		StringBuilder dateDifference = new StringBuilder();
	
	    //HH converts hour in 24 hours format (0-23), day calculation
		SimpleDateFormat format = new SimpleDateFormat(dateFormatString);
	
		String todayDate = format.format(new Date());
		Date d1 = null;
		//Date d2 = null;
	
		try 
		{
			d1 = format.parse(todayDate);
			
			long difference = date - d1.getTime();
			long differenceInHours = difference / (60 * 60 * 1000) % 24;
			long differenceInDays = difference / (24 * 60 * 60 * 1000);
			long differenceInMinutes = difference / (60 * 1000) % 60;
	
			/**
			 * to display the duration in which the event starts or ends
			 */
			if(differenceInDays>=1)
			{
				if(differenceInDays>1)
				{
					dateDifference.append(differenceInDays+" days ");
				}
				else
				{
					dateDifference.append(differenceInDays+" day ");
				}
			}
			
			if(differenceInHours>=1)
			{
				if(differenceInHours>1)
				{
					dateDifference.append(differenceInHours+" hours ");
				}
				else
				{
					dateDifference.append(differenceInHours+" hour ");
				}
			}
			
			if(differenceInMinutes>=1)
			{
				if(differenceInMinutes>1)
				{
					dateDifference.append(differenceInMinutes+" minutes ");
				}
				else
				{
					dateDifference.append(differenceInMinutes+" minutes ");
				}
			}
				
		} 
		catch (Exception e) 
		{
			logger.error(e.getStackTrace());
		}
	    
	   return dateDifference;
	}

	/**
	 * This method is used to generate the capitalized String for a given input String. 
	 * For eg. If the input is (apple inc.) ,the method returns (Apple Inc.)
	 * @author TrishnaR
	 * @param string
	 * @return capitalizedString
	 */
	public static String getCapitalizedString(String lowercasedString) {
	
		String capitalizedString = "";
		if(lowercasedString!=null && lowercasedString.length()!=0)
		{
			String[] lowercasedWords = lowercasedString.split(" ");
			for (int i = 0; i < lowercasedWords.length; i++) {
				capitalizedString += (String.valueOf(lowercasedWords[i].charAt(0)).toUpperCase().concat(lowercasedWords[i].substring(1,lowercasedWords[i].length()))).concat(" ");
			}
			
		}
		return capitalizedString;
	}
	
	/**
	 * This method is used to generate the String for Cassandra In Query.
	 * @author TrishnaR
	 * @param list
	 * @return String (Cassandra In Query String)
	 */
	public static String getCassandraInQueryString(List<String> list)
	{
		  StringBuilder cassandraInQuerySB = new StringBuilder();
		  String cassandraInQueryString = "";
		  //Iterating over the input list
		  for(int i = list.size()-1 ; i >= 0; i--)
		  {
		   cassandraInQuerySB.append("'").append(list.get(i)).append("',");
		  }
		  //Removing an extra comma at the end of the String
		  if(cassandraInQuerySB.length() > 0) 
		   cassandraInQueryString = cassandraInQuerySB.substring(0,cassandraInQuerySB.lastIndexOf(","));
	
		  return cassandraInQueryString;	
	}
	
	public static Map<String, Date> sortMapOnTimestampValue(Map<String, Date> originalMap) {
		 
		// Convert Map to List
		List<Map.Entry<String, Date>> list = 
			new LinkedList<Map.Entry<String, Date>>(originalMap.entrySet());
 
		// Sort list with comparator, to compare the Map values
		Collections.sort(list, new Comparator<Map.Entry<String, Date>>() {
			public int compare(Map.Entry<String, Date> o1,Map.Entry<String, Date> o2) {
				return (o1.getValue()).compareTo(o2.getValue());
			}
		});
 
		// Convert sorted map back to a Map
		Map<String, Date> sortedMap = new LinkedHashMap<String, Date>();
		for (Iterator<Map.Entry<String, Date>> it = list.iterator(); it.hasNext();) {
			Map.Entry<String, Date> entry = it.next();
			sortedMap.put(entry.getKey(), entry.getValue());
		}
		return sortedMap;
	}

	public static List<String> getAdminMasters() {
		return Arrays.asList(new String[]{"Company Types","Course Names","Course Types","Functional Areas","Industries","School States","University Names"});
	}
	

	public static long getDateDifferenceInMinutes(Date date1, Date date2) {
	    long diffInMillies = date2.getTime() - date1.getTime();
	    long minutes = TimeUnit.MILLISECONDS.toMinutes(diffInMillies);
	   
	    return minutes;
	}
	
	public static String changeDateFormat(String dateString,String existingDateFormat,String outputFormat){
		Date newDate = null;
		try {
			newDate = new SimpleDateFormat(existingDateFormat).parse(dateString.trim());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if(null != newDate){
			dateString = new SimpleDateFormat(outputFormat).format(newDate);
		}
		return dateString;
	}
	
	
	public static Long getDateDifferenceInLong(String dateFormatString , String startDate)
	{

	    //HH converts hour in 24 hours format (0-23), day calculation
		SimpleDateFormat format = new SimpleDateFormat(dateFormatString);
 
		String dateStop = format.format(new Date());
		Date d1 = null;
		Date d2 = null;
		long diffDays = 1L;
		
		try 
		{
			d1 = format.parse(startDate);
			d2 = format.parse(dateStop);
 
			long difference = d2.getTime() - d1.getTime();
		    diffDays = difference / (24 * 60 * 60 * 1000);

			
		} 
		catch (Exception e) 
		{
			logger.error(e.getStackTrace());
		}
	    
	   return diffDays;
	}
	
}