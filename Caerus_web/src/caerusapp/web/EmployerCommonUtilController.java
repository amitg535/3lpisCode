/**
 * 
 */
package caerusapp.web;

import java.util.ArrayList;
import java.util.List;

import org.apache.lucene.search.suggest.Lookup.LookupResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import caerusapp.lucene.indexing.AutoSuggest;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.util.CaerusAnnotationURLConstants;

/**
 * This class is used to implement common Employer Functions
 * @author PallaviD
 *
 */

@Controller
public class EmployerCommonUtilController
{
	
	@Autowired
	IEmployerJobPostManager employerJobPostManager;
	
	/**
	 * This method is used to get City and State for Zipcode
	 * @param EmployerJobPost  (jobDetails)
	 */
	 @RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_GET_CITY)
	 @ResponseBody
	 public String returnCityStateName(@RequestParam("zipCode") String zipCode )
	 {
		 String city="";
		 String state="";
			if (null!=zipCode){
				city = employerJobPostManager.getCity(zipCode);
				state = employerJobPostManager.getState(zipCode);
			}
			return city+" ("+state+")";
		 
	 }
	 
	 /**
		 * This method is used to get Suggested Words
		 */
		 @RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_GET_SUGGESTED_WORDS)
		 @ResponseBody
		 public List<String> returnSuggestedWords(@RequestParam("enteredText") String enteredText )
		 {
			
			 AutoSuggest autoSuggest = new AutoSuggest();
			 List<String> returnedWords=new ArrayList<String>();
			 
			 try{
				 
				 //Fetching keyword suggestions for the entered text by User
				 List<LookupResult>suggestedWords=autoSuggest.returnSuggestedWords(enteredText);
				 
				 String word="";
				 //List of LookUpResult to List of String Conversion
				 if(null!=suggestedWords || suggestedWords.size()!=0)
				 {
					 for(int i=0; i<suggestedWords.size();i++)
					 {
						 word=suggestedWords.get(i).key.toString();
						 //Removing Unwanted Character Sequence Returned by Lucene (Highlighted Text)
						 word=word.replaceAll("<b>", "");
						 word=word.replaceAll("</b>", "");
						 returnedWords.add(word);
						 
					 }
					 
				 }
				
				 
			 }
			 catch(Exception e)
			 {
				 e.printStackTrace();
			 }
			
			 return returnedWords;	 
		 }
		
}
