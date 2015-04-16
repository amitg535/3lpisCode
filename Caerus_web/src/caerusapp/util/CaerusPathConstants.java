/**
 * 
 */
package caerusapp.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * This class sets all the index locations in the application on server startup 
 * For Reference : applicationContext.xml
 * @author TrishnaR
 */
public class CaerusPathConstants 
{
	public static String jobIndexes;
	public static String studentIndexes;
	public static String keywordIndexes;
	public static String suggesterIndexes;
	public static String defaultImagePath;
	public static String employerKeywordIndexes;
	public static String employerSuggesterIndexes;
	public static String skillIndexes;
	public static String skillSuggesterIndexes;
	
	
	/**
	 * This method sets all the index locations in the application.
	 * @author TrishnaR
	 */
	@SuppressWarnings("unused")
	private void loadProperties()
	{
		Properties properties = new Properties();
		try 
		{
		      	ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
				InputStream inputStream = classLoader.getResourceAsStream("config.properties");
				properties.load(inputStream);
				
				CaerusPathConstants.jobIndexes = properties.getProperty("jobIndexes");
				CaerusPathConstants.studentIndexes = properties.getProperty("studentIndexes");
				CaerusPathConstants.keywordIndexes = properties.getProperty("keywordIndexes");
				CaerusPathConstants.suggesterIndexes = properties.getProperty("suggesterIndexes");
				CaerusPathConstants.defaultImagePath = properties.getProperty("defaultImagePath");
				CaerusPathConstants.employerKeywordIndexes = properties.getProperty("employerKeywordIndexes");
				CaerusPathConstants.employerSuggesterIndexes = properties.getProperty("employerSuggesterIndexes");
				CaerusPathConstants.skillIndexes = properties.getProperty("skillIndexes");
				CaerusPathConstants.skillSuggesterIndexes = properties.getProperty("skillSuggesterIndexes");
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}

	}
}
