/**
 * 
 */
package caerusapp.lucene.indexing;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.analysis.util.CharArraySet;
import org.apache.lucene.document.DateTools;
import org.apache.lucene.document.DateTools.Resolution;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.queryparser.classic.MultiFieldQueryParser;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanClause.Occur;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.SortField;
import org.apache.lucene.search.TermRangeQuery;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.BytesRef;
import org.apache.lucene.util.Version;

import caerusapp.command.student.StudentCom;
import caerusapp.domain.student.StudentDom;

/**
 * This class is used to fetch Candidates for Employers based on various parameters
 * @author BalajiI
 *
 */
public class EmployerSearchCandidateLucene
{
	private static final int MAX_HITS = 2147483647;

	@SuppressWarnings("deprecation")
	static Version luceneVersion = Version.LUCENE_CURRENT;
	/**
	 * This method Fetches the candidate emailIds based on the provided parameters from an index file at the specified Location
	 * @param indexDirectory
	 * @param luceneQuery
	 * @return Set<String>(candidateEmailIdSet)
	 * @throws Exception
	 */
    public static List<StudentDom> searchIndex(File indexDirectory, Map<String,String> luceneParameterMap, Date lastDate) throws Exception
    {
    	Set<String> candidateEmailIdSet = new HashSet<String>();
    	List<StudentDom> candidateDetailsList = new ArrayList<StudentDom>();
    	Directory directory = null;
        
    	try
        {
        	directory = FSDirectory.open(indexDirectory);
        	
        	//Creating a custom list of stop words(common English words that are usually not useful for searching) 
        	List<String> stopWords = Arrays.asList("a", "an", "and", "are", "as", "at", "be", "but", "by",
     			   "for", "if", "in", "into", "is",
     			   "no", "not", "of", "on", "or", "such",
     			   "that", "the", "their", "then", "there", "these",
     			   "they", "this", "to", "was", "will", "with", "university","college","school","institute","academy","state","technology");
        	CharArraySet stopSet = new CharArraySet(luceneVersion,stopWords, false);
        	
            MultiFieldQueryParser keySkillsQueryParser = null;
            QueryParser cityQueryParser = null;
            QueryParser universityNameQueryParser = null;
            QueryParser stateQueryParser = null;
            BooleanQuery booleanQuery = new BooleanQuery();
            
            if(null != lastDate)
        	{
            	String lowerTime = DateTools.dateToString(lastDate,Resolution.SECOND);
            	String upperTime = DateTools.dateToString(new Date(),Resolution.SECOND);
            	
            	TermRangeQuery termRangeQuery = new TermRangeQuery("last_updated",new BytesRef(lowerTime),new BytesRef(upperTime), true, true);
            	booleanQuery.add(new BooleanClause(termRangeQuery,Occur.MUST));
        	}
            
            for (String key : luceneParameterMap.keySet())
            {
            	if(key.equals("keySkills"))
            	{        		
            		HashMap<String,Float> boosts = new HashMap<String,Float>();
        			boosts.put("primary_skills", (float) 10 );
        			boosts.put("secondary_skills", (float) 7.5 );
        			boosts.put("about_your_self", (float) 9 );
        			boosts.put("resume_heading", (float) 8 );
        			boosts.put("work_description", (float) 6 );
        			boosts.put("city", (float) 7 );
        			
        			String[] fields = new String[] {"primary_skills","secondary_skills","about_your_self","resume_heading","work_description","city"};
        			keySkillsQueryParser = new MultiFieldQueryParser(luceneVersion, fields,new StandardAnalyzer(luceneVersion,stopSet),boosts);
            		
            		booleanQuery.add(keySkillsQueryParser.parse(luceneParameterMap.get(key)), BooleanClause.Occur.MUST);
            	}
            	
            	if(key.equals("city"))
            	{
            		cityQueryParser = new QueryParser(luceneVersion,"city", new StandardAnalyzer(luceneVersion,stopSet));  
            		 
            		booleanQuery.add(cityQueryParser.parse( luceneParameterMap.get(key)), BooleanClause.Occur.MUST);
            	}
            	
            	if(key.equals("universityName"))
            	{
            		universityNameQueryParser = new QueryParser(luceneVersion,"university_name",new StandardAnalyzer(luceneVersion,stopSet));  
            		
            		booleanQuery.add(universityNameQueryParser.parse(luceneParameterMap.get(key)), BooleanClause.Occur.MUST);
            	}
            	
            	if(key.equals("state"))
            	{
            		stateQueryParser = new QueryParser(luceneVersion,"state",new StandardAnalyzer(luceneVersion));  
            		 
            		booleanQuery.add(stateQueryParser.parse( luceneParameterMap.get(key)), BooleanClause.Occur.MUST);
            	}
    		}
            
            @SuppressWarnings("deprecation")
    		IndexReader indexReader = IndexReader.open(directory);
            IndexSearcher indexSearcher = new IndexSearcher(indexReader);       
            
            TopDocs topDocs = null;
            
             if(luceneParameterMap.containsKey("sortedParameter") && luceneParameterMap.get("sortedParameter").equalsIgnoreCase("Popular"))
            	topDocs = indexSearcher.search(booleanQuery, MAX_HITS ,new Sort(new SortField("viewed_by_companies_map_count",SortField.Type.LONG,true)));
            else if(luceneParameterMap.containsKey("sortedParameter") && luceneParameterMap.get("sortedParameter").equalsIgnoreCase("Age"))
            	topDocs = indexSearcher.search(booleanQuery, MAX_HITS ,new Sort(new SortField("age",SortField.Type.LONG,true)));
            else if(luceneParameterMap.containsKey("sortedParameter") && luceneParameterMap.get("sortedParameter").equalsIgnoreCase("Relevance"))
            	topDocs = indexSearcher.search(booleanQuery, MAX_HITS ,new Sort(new SortField("i_score",SortField.Type.LONG,true)));
            else 
            	topDocs = indexSearcher.search(booleanQuery, MAX_HITS ,new Sort(new SortField("last_updated",SortField.Type.STRING,true)));
            
            ScoreDoc[] hits = topDocs.scoreDocs;
            System.out.println(hits.length + " Record(s) Found");

            Long nonPublicProfiles = 0L;
            
            for (int i = 0; i < hits.length; i++) 
            {
                int docId = hits[i].doc;
                Document document = indexSearcher.doc(docId);
                
                if(null != document.get("profile_visibility") && !(document.get("profile_visibility").equals("false")))
                {
                	
                	 if(document.get("schoolName") != null && !document.get("schoolName").isEmpty())
	                 {
	                	candidateEmailIdSet.add(document.get("email_id"));
	                	
	                	StudentDom student = new StudentDom();
	                	
	                	student.setEmailID(document.get("email_id"));
	                	student.setFirstName(document.get("first_name"));
	                	student.setLastName(document.get("last_name"));
	                	student.setCity(document.get("city"));
	                	student.setState(document.get("state"));
	                	student.setAboutYourSelf(document.get("about_your_self"));
	                	
	                	Map<String, String> schoolMap = new HashMap<String,String>();
	                	
	                	// Setting school details
	                	schoolMap.put("schoolName",document.get("schoolName"));
	                	schoolMap.put("schoolState",document.get("schoolState"));
	                	schoolMap.put("schoolGpaFrom",document.get("schoolGpaFrom"));
	                	schoolMap.put("schoolGpaTo",document.get("schoolGpaTo"));
	                	schoolMap.put("schoolPassingYear",document.get("schoolPassingYear"));
	                	schoolMap.put("schoolPassingMonth",document.get("schoolPassingMonth"));
	                	
	                	student.setSchoolMap(schoolMap);
	                	
	                	Map<String, String> universityMap = new HashMap<String,String>();
	                	
	                	// Finding last university attended by a candidate
	                	String universityCount = document.get("universityCount");
	                	
	                	// Setting university details
	                	universityMap.put(universityCount+"_universityName",document.get(universityCount+"_universityName"));
	                	universityMap.put(universityCount+"_universityGpaFrom",document.get(universityCount+"_universityGpaFrom"));
	                	universityMap.put(universityCount+"_universityGpaTo",document.get(universityCount+"_universityGpaTo"));
	                	universityMap.put(universityCount+"_universityYearFrom",document.get(universityCount+"_universityYearFrom"));
	                	universityMap.put(universityCount+"_universityYearTo",document.get(universityCount+"_universityYearTo"));
	                	universityMap.put(universityCount+"_universityMonthFrom",document.get(universityCount+"_universityMonthFrom"));
	                	universityMap.put(universityCount+"_universityMonthTo",document.get(universityCount+"_universityMonthTo"));
	                	universityMap.put(universityCount+"_universityCourseType",document.get(universityCount+"_universityCourseType"));
	                	universityMap.put(universityCount+"_universityCourseName",document.get(universityCount+"_universityCourseName"));
	                	
	                	student.setUniversityMap(universityMap);
	                	
	                	List<String> primarySkills = new ArrayList<String>(Arrays.asList(document.get("primary_skills").replace("[", "").replace("]", "").split(",")));
	                	
	                	student.setPrimarySkills(primarySkills);
	                	student.setVideoName(document.get("videoname"));
	                	if(document.get("i_score") != null)
	                	{
	                		student.setiScore(Double.parseDouble(document.get("i_score")));
	                	}
	                	
	                	else
	                	{
	                		student.setiScore(0.0);
	                	}
	                	
	                	
	                	if(null != document.get("photo_verified_flag") && document.get("photo_verified_flag").equals("true"))
	                		student.setPhotoName(document.get("photoname"));
	                	else
	                		student.setPhotoName(null);
	                	
	                	
	                	if(document.get("video_profile_view_count") != null)
	                	{
	                		student.setViewVideoProfileCount(Integer.parseInt(document.get("video_profile_view_count")));
	                	}
	                	else
	                	{
	                		student.setViewVideoProfileCount(0);
	                	}
	                	if(null != document.get("resume_name"))
	                		student.setResumeName(document.get("resume_name"));
	                	
	                	
	                	candidateDetailsList.add(student);
	                	
	                }
                }
                else {
                	nonPublicProfiles++;
                }
            }
            if(hits.length == 0)
            {
            	System.out.println("No Records Found");
            }
            
            if(nonPublicProfiles > 0L)
            	System.out.println("Candidates with Private Profiles "+nonPublicProfiles);
       	
        }
        catch(Exception ex)
        {
        	ex.printStackTrace();
        }
        
    	 return candidateDetailsList;
    }
    
    
    public static Map<String,StudentCom> fetchSimilarCandidates(File indexDirectory, Map<String,String> luceneParameterMap,String previewedCandidateEmailId)
    {
    	Map<String,StudentCom> similarCandidates = new HashMap<String,StudentCom>();
    	Directory directory = null;
        
    	try
        {
        	directory = FSDirectory.open(indexDirectory);
        	
        	//Creating a custom list of stop words(common English words that are usually not useful for searching) 
        	List<String> stopWords = Arrays.asList("a", "an", "and", "are", "as", "at", "be", "but", "by",
     			   "for", "if", "in", "into", "is",
     			   "no", "not", "of", "on", "or", "such",
     			   "that", "the", "their", "then", "there", "these",
     			   "they", "this", "to", "was", "will", "with", "university","college","school","institute","academy","state");
        	CharArraySet stopSet = new CharArraySet(luceneVersion,stopWords, false);
        	
            MultiFieldQueryParser keySkillsQueryParser = null;
            QueryParser cityQueryParser = null;
            QueryParser universityNameQueryParser = null;
            QueryParser stateQueryParser = null;
            BooleanQuery booleanQuery = new BooleanQuery();
            
            for (String key : luceneParameterMap.keySet())
            {
            	if(key.equals("keySkills"))
            	{        		
            		HashMap<String,Float> boosts = new HashMap<String,Float>();
        			boosts.put("primary_skills", (float) 10 );
        			boosts.put("secondary_skills", (float) 7.5 );
        			boosts.put("about_your_self", (float) 9 );
        			boosts.put("resume_heading", (float) 8 );
        			boosts.put("work_description", (float) 6 );
        			
        			String[] fields = new String[] {"primary_skills","secondary_skills","about_your_self","resume_heading","work_description"};
        			keySkillsQueryParser = new MultiFieldQueryParser(luceneVersion, fields,new StandardAnalyzer(luceneVersion,stopSet),boosts);
            		
            		booleanQuery.add(keySkillsQueryParser.parse(luceneParameterMap.get(key)), BooleanClause.Occur.MUST);
            	}
            	
            	if(key.equals("city"))
            	{
            		cityQueryParser = new QueryParser(luceneVersion,"city", new StandardAnalyzer(luceneVersion,stopSet));  
            		 
            		booleanQuery.add(cityQueryParser.parse( luceneParameterMap.get(key)), BooleanClause.Occur.MUST);
            	}
            	
            	if(key.equals("universityName"))
            	{
            		universityNameQueryParser = new QueryParser(luceneVersion,"university_name",new StandardAnalyzer(luceneVersion,stopSet));  
            		
            		booleanQuery.add(universityNameQueryParser.parse(luceneParameterMap.get(key)), BooleanClause.Occur.MUST);
            	}
            	
            	if(key.equals("state"))
            	{
            		stateQueryParser = new QueryParser(luceneVersion,"state",new StandardAnalyzer(luceneVersion));  
            		 
            		booleanQuery.add(stateQueryParser.parse( luceneParameterMap.get(key)), BooleanClause.Occur.MUST);
            	}
    		}
            
            @SuppressWarnings("deprecation")
    		IndexReader indexReader = IndexReader.open(directory);
            IndexSearcher indexSearcher = new IndexSearcher(indexReader);       
            
            TopDocs topDocs = null;
            
            if(!luceneParameterMap.containsKey("keySkills"))
            	topDocs = indexSearcher.search(booleanQuery, MAX_HITS ,new Sort(new SortField("last_updated",SortField.Type.STRING,true)));
            
            else
            	topDocs = indexSearcher.search(booleanQuery, MAX_HITS ,new Sort(SortField.FIELD_SCORE));
            
            ScoreDoc[] hits = topDocs.scoreDocs;
            System.out.println(hits.length + " Record(s) Found");

            int maxSimilarCandidates = 20;
            /** Fetching only the top 20 records(relatedJobCount = 20) */
            if(hits.length > maxSimilarCandidates)
            {
            	hits = Arrays.copyOfRange(hits, 0, maxSimilarCandidates);
            }
            
            for (int i = 0; i < hits.length; i++) 
            {
                int docId = hits[i].doc;
                Document document = indexSearcher.doc(docId);
                
                if(document.get("university_name") != null || document.get("school_name") != null)
                {
                	if(!document.get("email_id").equals(previewedCandidateEmailId))
                	{
                		StudentCom studentDetails = new StudentCom();

                		studentDetails.setFirstName(document.get("first_name"));
                		studentDetails.setLastName(document.get("last_name"));

                		if(null != document.get("photo_verified_flag") && !(document.get("photo_verified_flag").equals("true")))
                			studentDetails.setPhotoName(document.get("photoname"));
	                	else
	                		studentDetails.setPhotoName(null);
                		
                		List<String> primarySkills = new ArrayList<String>(Arrays.asList(document.get("primary_skills").replace("[", "").replace("]", "").split(",")));
	                	
                		
                		if(!(primarySkills == null))
            			{
            			 StringBuilder sb = new StringBuilder();
            			 
            			   for(int m = 0; m < 2; m++)
            		       {
            		            sb.append(primarySkills.get(m)).append(","); //separating contents using semi colon
            		       }
            		      
            		     String strfromArrayList = sb.toString();
            		     
            		     strfromArrayList = strfromArrayList.substring(0,strfromArrayList.lastIndexOf(","));
            			
            		     studentDetails.setPrimarySkills1(strfromArrayList);
            			}
                		
                		if(similarCandidates.size() < 6)
                			similarCandidates.put(document.get("email_id"),studentDetails);
                	}
                }
            }
            if(hits.length == 0)
            {
            	System.out.println("No Records Found");
            }
       	
        }
        catch(Exception indexNotFound)
        {
        	System.out.println("Indexes Not Found at the Specified Location "+indexDirectory);
        }
        
    	 return similarCandidates;
    }
    
}