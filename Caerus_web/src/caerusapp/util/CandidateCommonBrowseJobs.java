package caerusapp.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.collections.CollectionUtils;
import org.apache.lucene.queryparser.classic.ParseException;

import caerusapp.lucene.indexing.SimpleDBSearcher;
import caerusapp.service.student.IStudentJobsManager;

public class CandidateCommonBrowseJobs {

	public static Map<String,Map<String,Integer>> getBrowseJobsSection(IStudentJobsManager studentJobsManager, String emailId) throws IOException, ParseException
	{
		Map<String, Map<String,String>> jobDetails = SimpleDBSearcher.searchIndex(new File(CaerusPathConstants.jobIndexes));
		List<String> appliedJobIds = new ArrayList<String>();
		Map<String,Map<String,Integer>> resultCountMap = new HashMap<String,Map<String,Integer>>();
		List<String> keys = new ArrayList<String>();
		
		//Get the jobs applied by the candidate
		if(emailId!= null && !emailId.isEmpty())
		{
			appliedJobIds = studentJobsManager.getAppliedJobIds(emailId);
		
			/*if(null != appliedJobIdMap && appliedJobIdMap.size() > 0){
				appliedJobIds = new ArrayList<String>(appliedJobIdMap.keySet());
			}*/
			
			// Removing applied jobIds
			if(null != jobDetails && jobDetails.size() > 0){
				keys = new ArrayList<String>(jobDetails.keySet());
				Map<String,String> jobIds = new HashMap<String,String>();
				
				if(null != keys && keys.size() > 0)
				{
					for (String key : keys) {
						jobIds = jobDetails.get(key);
						if(null != jobIds && jobIds.size() > 0){
							jobIds.keySet().removeAll(appliedJobIds);
							jobDetails.put(key, jobIds);
						}
					}
				}
				
				//int i = 0;
				for (Entry<String,Map<String,String>> jobDetail : jobDetails.entrySet()) {
					Map<String,Integer> sortedMap = new HashMap<String,Integer>();
				    //Map<String,Integer> sortedSubMap = new HashMap<String,Integer>();
					
					//Getting count of each functional area,job Type,industry,location separately
					sortedMap.putAll(CollectionUtils.getCardinalityMap(jobDetail.getValue().values()));
					sortedMap = CaerusCommonUtil.sortMapOnValues(sortedMap);
					if(sortedMap != null && sortedMap.size() > 0)
					{
						/*// Sending 5 values to jsp page
						if(sortedMap.size() > 5)
						{
							for (Entry<String,Integer> entry : sortedMap.entrySet()) {
								if(i >=0 && i <5)
								{
									sortedSubMap.put(entry.getKey(),entry.getValue());
								}
								i++;
							}
						}
						else
							sortedSubMap = sortedMap;
						
						sortedSubMap = CaerusCommonUtil.sortMapOnValues(sortedMap);*/
						resultCountMap.put(jobDetail.getKey(),sortedMap);
					}
					
				}
			}
			
		}
		
		else {
			
						if(null != jobDetails && jobDetails.size() > 0){
							keys = new ArrayList<String>(jobDetails.keySet());
							Map<String,String> jobIds = new HashMap<String,String>();
							
							if(null != keys && keys.size() > 0)
							{
								for (String key : keys) {
									jobIds = jobDetails.get(key);
									if(null != jobIds && jobIds.size() > 0){
										jobDetails.put(key, jobIds);
										
									}
								}
							}
							
							int i = 0;
							for (Entry<String,Map<String,String>> jobDetail : jobDetails.entrySet()) {
								Map<String,Integer> sortedMap = new HashMap<String,Integer>();
							    //Map<String,Integer> sortedSubMap = new HashMap<String,Integer>();
								
								//Getting count of each functional area,job Type,industry,location separately
								sortedMap.putAll(CollectionUtils.getCardinalityMap(jobDetail.getValue().values()));
								sortedMap = CaerusCommonUtil.sortMapOnValues(sortedMap);
								if(sortedMap != null && sortedMap.size() > 0)
								{
									/*// Sending 5 values to jsp page
									if(sortedMap.size() > 5)
									{
										for (Entry<String,Integer> entry : sortedMap.entrySet()) {
											if(i >=0 && i <5)
											{
												sortedSubMap.put(entry.getKey(),entry.getValue());
											}
											i++;
										}
									}
									else
										sortedSubMap = sortedMap;
									
									sortedSubMap = CaerusCommonUtil.sortMapOnValues(sortedMap);*/
									resultCountMap.put(jobDetail.getKey(),sortedMap);
								}
								
							}
						}
			
		}
		
		return resultCountMap;
	}
	
}
