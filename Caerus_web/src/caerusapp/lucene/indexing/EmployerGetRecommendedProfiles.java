/**
 * 
 */
package caerusapp.lucene.indexing;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.analysis.util.CharArraySet;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.SortField;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;

/**
 * This class is used to fetch Candidates for Employers based on various parameters
 * @author RavishaG
 *
 */
	public class EmployerGetRecommendedProfiles
	{

	 @SuppressWarnings("deprecation")
	 static Version luceneVersion = Version.LUCENE_CURRENT;
	 /**
	  * This method Fetches the candidate emailIds based on the provided parameters from an index file at the specified Location
	  * @param indexDirectory
	  * @param luceneQuery
	  * @return Set<String>(candidateEmailIdSet)
	  * @throws Exception
	  */
	 public static Map<String,List<String>> searchIndex(File indexDirectory, Map<String,Integer> luceneParameterMap) throws Exception
     {
    	 Map<String,List<String>> studentMap = new HashMap<String, List<String>>();
	     List<String> candidateEmailIdList = new ArrayList<String>();
	    
	     Directory directory = null;
	     int count = 0;
	        
	     try
	     {
	        directory = FSDirectory.open(indexDirectory);
	        
	      //Creating a custom list of stop words(common English words that are usually not useful for searching) 
		     List<String> stopWords = Arrays.asList("a", "an", "and", "are", "as", "at", "be", "but", "by",
		       "for", "if", "in", "into", "is",
		       "no", "not", "of", "on", "or", "such",
		       "that", "the", "their", "then", "there", "these",
		       "they", "this", "to", "was", "will", "with");
		     CharArraySet stopSet = new CharArraySet(luceneVersion,stopWords, false);   
	     
		        for (String key : luceneParameterMap.keySet())
		        {
		        	 List<String> newCandidateEmailIdList = new ArrayList<String>();
	         
			        @SuppressWarnings("deprecation")
			        IndexReader indexReader = IndexReader.open(directory);
			        IndexSearcher indexSearcher = new IndexSearcher(indexReader);       
			        StandardAnalyzer standardAnalyzer = new StandardAnalyzer(Version.LUCENE_CURRENT,stopSet);
			        QueryParser queryParser = new QueryParser(luceneVersion, "primary_skills", standardAnalyzer);
			        
			        queryParser.setAllowLeadingWildcard(false);
		 			Query query = queryParser.createPhraseQuery("primary_skills",key, 0);
			        
			        TopDocs topDocs = null;
		        
			        topDocs = indexSearcher.search(query, 2100000, new Sort(new SortField("video_profile_view_count",SortField.Type.LONG,true)));
		        
			        ScoreDoc[] hits = topDocs.scoreDocs;
			        System.out.println(hits.length + " Record(s) Found");
			
			        for (int i = 0; i < hits.length; i++) 
			        {
			    		int docId = hits[i].doc;
			            
			    		Document document = indexSearcher.doc(docId);
			           
			            if(count == 0)
			            {
			            	if(document.get("video_profile_view_count") != null)
			            	{
			            		candidateEmailIdList.add(document.get("email_id"));    
			            	}
			            }
			            
			            else
			            {
			            	if(candidateEmailIdList.size() != 0)
			            	{
				            	if(!(candidateEmailIdList.subList(0, 3).contains(document.get("email_id"))))
				            		{
					            		if(document.get("video_profile_view_count") != null)
					                	{
					            			newCandidateEmailIdList.add(document.get("email_id"));
					            		}
				            		}  
			            	}
			            }
		        	
			        }
		        
			        count++;
			        if(studentMap.size() == 0)
			        {
			        	if(candidateEmailIdList.size() > 3)
			        	{
			        		studentMap.put(key, candidateEmailIdList.subList(0, 3));
			        	}
			        	else
			        	{
			        		studentMap.put(key,candidateEmailIdList.subList(0, candidateEmailIdList.size()));
			        	}
			        }
			        
			        if(newCandidateEmailIdList.size() != 0)
			        {
			        	if(newCandidateEmailIdList.size() > 3)
			        	{
			        		studentMap.put(key, newCandidateEmailIdList.subList(0, 3));        		
			        	}
			        	else
			        	{
			        		studentMap.put(key, newCandidateEmailIdList.subList(0, newCandidateEmailIdList.size())); 
			        	}
			        }
			        
			        if(hits.length ==0)
			        {
			        	System.out.println("No Records Found");
			        }
			        	        
			        }
			           
	        
	     }
         catch(Exception indexNotFound)
         {
        	System.out.println("Indexes Not Found at the Specified Location "+indexDirectory);
         }
        
	         
	        return studentMap;
    }
}