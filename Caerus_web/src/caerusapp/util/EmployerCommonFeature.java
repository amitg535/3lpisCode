package caerusapp.util;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import caerusapp.domain.student.StudentDom;
import caerusapp.lucene.indexing.EmployerGetRecommendedProfiles;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentManager;

/**
 * This class contains common features for employers
 * @author RavishaG
 *
 */
public class EmployerCommonFeature {
	
	static File indexDirectory = new File(CaerusPathConstants.studentIndexes);
	

	/**
	 * This method is used to get recommended video profiles for employers
	 * @param employerManager
	 * @param studentManager
	 * @param corporateEmailId
	 * @return
	 * @throws Exception
	 */
	public static List<StudentDom> getRecommendedVideoProfiles(IEmployerManager employerManager, IStudentManager studentManager, String corporateEmailId) throws Exception
	{
		Map<Object,String> employerSearchHistoryMap = employerManager.getEmployerSearchHistory(corporateEmailId);
		
		Map<Object,String> reverseEmployerSearchHistoryMap = new HashMap<Object, String>();
		
		if(employerSearchHistoryMap != null)
		{
			reverseEmployerSearchHistoryMap = CaerusCommonUtil.sortMapOnKeyInDescendingOder(employerSearchHistoryMap);
		}
		
		Map<Object,String> reverseEmployerSearchHistorySubMap = new HashMap<Object, String>();
		
		List<String> keywordValue = new ArrayList<String>();
		
		int i=0;
		
		if(reverseEmployerSearchHistoryMap.size()>10)
		{				 
			for (Entry<Object,String> entry : reverseEmployerSearchHistoryMap.entrySet()) {
				
				if(i >= 0 && i < 10) 
					{ 
						 reverseEmployerSearchHistorySubMap.put(entry.getKey(), entry.getValue());
						 
						 keywordValue.add(entry.getValue());
						 
					}
				 i++;
			    }
			   
		}
		else
		{
			for (Entry<Object,String> entry : reverseEmployerSearchHistoryMap.entrySet()) {

						 reverseEmployerSearchHistorySubMap.put(entry.getKey(), entry.getValue());
						 
						 keywordValue.add(entry.getValue());
						 
					 }
				
		}

		Map<String,Integer> keywordCountMap = new HashMap<String, Integer>();
		
		Map<String,Integer> keywordCountSubMap = new HashMap<String, Integer>();
		
		for (String string : keywordValue) {
			
			keywordCountMap.put(string, Collections.frequency(keywordValue, string));
		}
		
		int j=0;
		
		if(keywordCountMap.size() >3)
		{
			keywordCountMap = CaerusCommonUtil.sortMapOnValues(keywordCountMap);
			
			for (Entry<String,Integer> entry : keywordCountMap.entrySet()) {
				
				if(j >= 0 && j < 3) 
				{ 
					keywordCountSubMap.put(entry.getKey(),entry.getValue());					
				}
				
				j++;
			}
			
			keywordCountSubMap = CaerusCommonUtil.sortMapOnValues(keywordCountSubMap);
		
		}
		
		else
		{
			keywordCountSubMap = CaerusCommonUtil.sortMapOnValues(keywordCountMap);
		}
		
		String emailIdString = "";

		Map<String,List<String>> candidateList = EmployerGetRecommendedProfiles.searchIndex(indexDirectory, keywordCountSubMap);

		
		for (Entry<String,List<String>> entry : candidateList.entrySet()) {
			
			List<String> emailIdList = entry.getValue();
	
			emailIdString = CaerusCommonUtility.getCassandraInQueryString(emailIdList);
			
		}
		
		List<StudentDom> studentDetailsList = null;
		
		if(emailIdString != "")
		{
			studentDetailsList = studentManager.getCandidateListByEmailId(emailIdString);
			
			studentDetailsList = CaerusCommonUtility.sortListByVideoProfileCount(studentDetailsList);
		}
		
		return studentDetailsList;
	}

}