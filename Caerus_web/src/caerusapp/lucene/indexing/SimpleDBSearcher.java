package caerusapp.lucene.indexing;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.analysis.util.CharArraySet;
import org.apache.lucene.document.DateTools;
import org.apache.lucene.document.DateTools.Resolution;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.queryparser.classic.MultiFieldQueryParser;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanClause.Occur;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.SortField;
import org.apache.lucene.search.SortField.Type;
import org.apache.lucene.search.TermRangeQuery;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.BytesRef;
import org.apache.lucene.util.Version;

import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusStringConstants;

/**
 * This class is used to fetch Jobs/Internships from Lucene Indexes 
 * @author TrishnaR
 */
public class SimpleDBSearcher {
	
	//Maximum number of records to be fetched
	private static final int MAX_HITS = 2147483647; //max integer value for java
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());


	/**
	 *  This method is used to fetch Jobs/Internships from Lucene Indexes 
	 * @param indexLocation
	 * @param searchParametersMap
	 * @param searchCriterion
	 * @return List<String> (jobIdList)
	 * @throws Exception
	 */
	public static List<String> searchIndex(File indexLocation, Map<String, String> searchParametersMap, String searchCriterion) throws Exception
	{
		@SuppressWarnings("deprecation")
		Version luceneVersion = Version.LUCENE_CURRENT;
		Directory directory = null;
		try
		{
			directory = FSDirectory.open(indexLocation);
		}
		catch(Exception exception)
		{
			throw new FileNotFoundException("Indexes not found at "+indexLocation);
		}
		
    	MultiFieldQueryParser multiFieldQueryParserForKeyword = null;
    	MultiFieldQueryParser multiFieldQueryParserForLocation = null;
    	QueryParser queryParserFunctionalArea = null;
    	QueryParser queryParserIndustry = null;
    	QueryParser queryParserJobType = null;
    	BooleanQuery booleanQuery = new BooleanQuery();
    	TermRangeQuery termRangeQuery = null;

    	//To get the date 90 days back(lowerDate)
    	Date ninetyDaysBack = CaerusCommonUtil.getDateByDifference(90);

    	String upperDate = DateTools.dateToString(new Date(),Resolution.SECOND);
    	String lowerDate = DateTools.dateToString(ninetyDaysBack,Resolution.SECOND);
    	 
    	if(searchCriterion.equalsIgnoreCase(CaerusStringConstants.RECOMMENDED_JOBS))
    	{
    		/** Retrieving Recommended Jobs posted within the last 20 days */
        	Date twentyDaysBack = CaerusCommonUtil.getDateByDifference(20);
    		lowerDate = DateTools.dateToString(twentyDaysBack,Resolution.SECOND);
    	}
    	
    	
    	//if(searchCriterion.equalsIgnoreCase(CaerusStringConstants.JOBS))
    		termRangeQuery = new TermRangeQuery("job_posted_on",new BytesRef(lowerDate),new BytesRef(upperDate), true, true);

    	if(searchCriterion.equalsIgnoreCase(CaerusStringConstants.INTERNSHIPS))
    		termRangeQuery = new TermRangeQuery("internship_posted_on",new BytesRef(lowerDate),new BytesRef(upperDate), true, true);
    	
    	//Filtering results in the range of days
    	booleanQuery.add(new BooleanClause(termRangeQuery,Occur.MUST));
    	
    	//Creating a custom list of stop words(common English words that are usually not useful for searching) 
    	List<String> stopWords = Arrays.asList("a", "an", "and", "are", "as", "at", "be", "but", "by",
    			   "for", "if", "in", "into", "is",
    			   "no", "not", "of", "on", "or", "such",
    			   "that", "the", "their", "then", "there", "these",
    			   "they", "this", "to", "was", "will", "with","time");
    	CharArraySet stopSet = new CharArraySet(luceneVersion,stopWords, false);
    	
    	//Iterating over the search parameters specified by the user
    	for (String key : searchParametersMap.keySet())
    	{
    		if(key.equals("keyword") && !searchParametersMap.get("keyword").isEmpty())
    		{
    			if(searchCriterion.equalsIgnoreCase(CaerusStringConstants.JOBS) || searchCriterion.equalsIgnoreCase(CaerusStringConstants.RECOMMENDED_JOBS))
    			{
    					//Setting the boosts for search parameters
		    			HashMap<String,Float> boosts = new HashMap<String,Float>();
		    			boosts.put("primary_skills_for_jobs", (float) 10 );
		    			boosts.put("secondary_skills_for_jobs", (float) 7.5 );
		    			boosts.put("job_title", (float) 10 );
		    			boosts.put("job_description", (float) 5 );
		    			boosts.put("location_for_jobs", (float) 5);
		    			
		    			String[] fields = new String[] {"primary_skills_for_jobs","secondary_skills_for_jobs","job_title","job_description","location_for_jobs"};
		    			multiFieldQueryParserForKeyword = new MultiFieldQueryParser(luceneVersion, fields,new StandardAnalyzer(luceneVersion),boosts);
    	    	} 
    			
    			if(searchCriterion.equalsIgnoreCase(CaerusStringConstants.INTERNSHIPS))
    			{
    				//Setting the boosts for search parameters
    				HashMap<String,Float> boosts = new HashMap<String,Float>();
	    			boosts.put("primary_skills_for_internships", (float) 10);
	    			boosts.put("secondary_skills_for_internships", (float) 7.5 );
	    			boosts.put("internship_title", (float) 10 );
	    			boosts.put("internship_description", (float) 5 );
	    			
					String[] fields = new String[] {"primary_skills_for_internships","secondary_skills_for_internships","internship_title","internship_description"};
					multiFieldQueryParserForKeyword = new MultiFieldQueryParser(luceneVersion, fields,new StandardAnalyzer(luceneVersion),boosts);
    			}
    			
    			booleanQuery.add(multiFieldQueryParserForKeyword.parse(searchParametersMap.get(key)), BooleanClause.Occur.MUST);
    	      }
    		
    		
    		if(key.equals("location") && !searchParametersMap.get("location").isEmpty())
    		{
    			if(searchCriterion.equalsIgnoreCase(CaerusStringConstants.JOBS))
    			{
    	    		multiFieldQueryParserForLocation = new MultiFieldQueryParser(luceneVersion,new String[] {"location_for_jobs","job_title"}, new StandardAnalyzer(luceneVersion));
    	    	} 
    			
    			if(searchCriterion.equalsIgnoreCase(CaerusStringConstants.INTERNSHIPS))
    			{
    				multiFieldQueryParserForLocation = new MultiFieldQueryParser(luceneVersion,new String[] {"location_for_internships","internship_title"}, new StandardAnalyzer(luceneVersion));
    			}
    			 booleanQuery.add(multiFieldQueryParserForLocation.parse(searchParametersMap.get(key)), BooleanClause.Occur.MUST);
    	      }
    		
    		
    		if(key.equals("industry") && !searchParametersMap.get("industry").isEmpty())
    		  {
    			 queryParserIndustry = new QueryParser(luceneVersion, "industry",  new StandardAnalyzer(luceneVersion,stopSet));
    			 booleanQuery.add(queryParserIndustry.parse(searchParametersMap.get(key)), BooleanClause.Occur.MUST);
    	      }
    		
    		if(key.equals("functionalArea") && !searchParametersMap.get("functionalArea").isEmpty())
    		{
    			 queryParserFunctionalArea = new QueryParser(luceneVersion, "functional_area",  new StandardAnalyzer(luceneVersion));
    			 booleanQuery.add(queryParserFunctionalArea.parse(searchParametersMap.get(key)), BooleanClause.Occur.MUST);
    	    }
    		
    		if(key.equals("jobType") && !searchParametersMap.get("jobType").isEmpty())
    		{
    			queryParserJobType = new QueryParser(luceneVersion, "job_type",  new StandardAnalyzer(luceneVersion,stopSet));
    			booleanQuery.add(queryParserJobType.parse(searchParametersMap.get(key)), BooleanClause.Occur.MUST);
    	    }
    	}
    	
    	@SuppressWarnings("deprecation")
    	IndexReader indexReader = IndexReader.open(directory);
    	IndexSearcher indexSearcher = new IndexSearcher(indexReader);     
    	TopDocs topDocs = null;
    	/**
    	 * If the search parameter contains keyword,the sorting is done on the FIELD_SCORE(document relevance) 
    	 * else sorted on recent records
    	 */
    	
    	if(!searchCriterion.equalsIgnoreCase(CaerusStringConstants.RECOMMENDED_JOBS))
    	{
    		if(!searchParametersMap.containsKey("keyword"))
	    	{
		    	if(searchCriterion.equalsIgnoreCase(CaerusStringConstants.JOBS))
		    		topDocs = indexSearcher.search(booleanQuery, MAX_HITS, new Sort(new SortField("job_posted_on",Type.STRING,true)));
		    	
		    	if(searchCriterion.equalsIgnoreCase(CaerusStringConstants.INTERNSHIPS))
		    		topDocs = indexSearcher.search(booleanQuery, MAX_HITS, new Sort(new SortField("internship_posted_on",Type.STRING,true)));
		    	
	    	}
	    	else
	    		topDocs = indexSearcher.search(booleanQuery, MAX_HITS, new Sort(SortField.FIELD_SCORE));
    	}
    	else
    		topDocs = indexSearcher.search(booleanQuery, MAX_HITS, new Sort(new SortField("job_posted_on",Type.STRING,true)));
    	
    	List<String> jobIdList = new ArrayList<String>();
        ScoreDoc[] hits = topDocs.scoreDocs;
       
        System.out.println("Lucene Search Fetched :"+hits.length + " Record(s) ");
        
        for (ScoreDoc scoreDoc : hits) 
        {
        	int docId = scoreDoc.doc;
            Document d = indexSearcher.doc(docId);
            
            if(searchCriterion.equalsIgnoreCase(CaerusStringConstants.JOBS) || searchCriterion.equalsIgnoreCase(CaerusStringConstants.RECOMMENDED_JOBS))
            {
            	jobIdList.add(d.get("job_id_and_firm_id"));
            }
            
            if(searchCriterion.equalsIgnoreCase(CaerusStringConstants.INTERNSHIPS))
            {
            	jobIdList.add(d.get("internship_id_and_firm_id"));
            } 
		}
        
        if(hits.length == 0)
        {
        	System.out.println("No Records Found ");
        }
        
        indexReader.close();

    	return jobIdList;
    }
	
	/**
	 * Fetches Jobs related to the One previewed based on primary and secondary skills and within 15 days' time duration(i.e Jobs that have been published before 15 days wont appear)
	 * @param jobSkills
	 * @param indexLocation
	 * @return Set<String>(jobIds)
	 * @throws ParseException
	 * @throws IOException
	 */
	public static Set<String> fetchRelatedJobs(String jobSkills,File indexLocation) throws ParseException, IOException
	{
		@SuppressWarnings("deprecation")
		Version luceneVersion = Version.LUCENE_CURRENT;
		Directory directory = null;
			try
			{
				directory = FSDirectory.open(indexLocation);
			}
			catch(Exception exception)
			{
				throw new FileNotFoundException("Indexes not found at "+indexLocation);
			}

		/** Fetch only jobs posted in the last 15 days(lowerBoundaryDays=15)*/ 
		
    	//To get the date 15 days back(lowerDate)
    	Date fifteenDaysBack = CaerusCommonUtil.getDateByDifference(15);
    	
    	String upperDate=DateTools.dateToString(new Date(),Resolution.SECOND);
    	String lowerDate=DateTools.dateToString(fifteenDaysBack,Resolution.SECOND);	 
    	 
    	TermRangeQuery termRangeQuery = new TermRangeQuery("job_posted_on",new BytesRef(lowerDate),new BytesRef(upperDate), true, true);
		
		MultiFieldQueryParser multiFieldQueryParser = null;
		
		//Setting the boosts for search parameters
		HashMap<String,Float> boosts = new HashMap<String,Float>();
		boosts.put("primary_skills_for_jobs", (float) 10 );
		boosts.put("secondary_skills_for_jobs", (float) 7.5 );
		boosts.put("job_title", (float) 10 );
		boosts.put("job_description", (float) 5 );
		
		String[] fields = new String[] {"primary_skills_for_jobs","secondary_skills_for_jobs","job_title","job_description"};
		multiFieldQueryParser = new MultiFieldQueryParser(luceneVersion, fields,new StandardAnalyzer(luceneVersion),boosts);
		
		
		BooleanQuery booleanQuery = new BooleanQuery();
		
		booleanQuery.add(multiFieldQueryParser.parse(jobSkills), BooleanClause.Occur.MUST);
		//booleanQuery.add(new BooleanClause(termRangeQuery,Occur.MUST));
    	
    	@SuppressWarnings("deprecation")
    	IndexReader indexReader = IndexReader.open(directory);
    	IndexSearcher indexSearcher = new IndexSearcher(indexReader);     
    	TopDocs topDocs = null;

    	/** Sorting Jobs based on posted date(Newer ones on Top) */
    	topDocs = indexSearcher.search(booleanQuery, MAX_HITS, new Sort(new SortField("job_posted_on",Type.STRING,true)));
    	
    	Set<String> jobIds = new HashSet<String>();
        ScoreDoc[] hits = topDocs.scoreDocs;
       
        System.out.println(hits.length + " Record(s) Found");
        
        int relatedJobCount = 100;
        /** Fetching only the top 5 records(relatedJobCount = 5) */
        if(hits.length > relatedJobCount)
        {
        	hits = Arrays.copyOfRange(hits, 0, relatedJobCount);
        }
        
        for (ScoreDoc scoreDoc : hits) 
        {
        	int docId = scoreDoc.doc;
            Document d = indexSearcher.doc(docId);
            jobIds.add(d.get("job_id_and_firm_id"));
		}
        
        if(hits.length == 0)
        {
        	System.out.println("No Records Found ");
        }
        indexReader.close();
        
    	return jobIds;
	}

	/**
	 * This method is used to find jobs and internships in the past 60 days
	 * @author RavishaG
	 * @param indexDir
	 * @return Map<String,List<String>>
	 * @throws IOException
	 */
	public Map<String,List<String>> searchIndexForRecentJobs(File indexDir) throws IOException 
	{
		Directory directory = null;
			
		try
		{
			directory = FSDirectory.open(indexDir);
		}
		catch(Exception exception)
		{
			throw new FileNotFoundException("Indexes not found at "+indexDir);
		}
		
		//To get the date 60 days back(lowerDate)
    	Date sixtyDaysBack = CaerusCommonUtil.getDateByDifference(60);
    	
    	String upperDate=DateTools.dateToString(new Date(),Resolution.SECOND);
    	String lowerDate=DateTools.dateToString(sixtyDaysBack,Resolution.SECOND);	 
    	 
    	TermRangeQuery termRangeQuery = new TermRangeQuery("job_posted_on",new BytesRef(lowerDate),new BytesRef(upperDate), true, true);
    	
		BooleanQuery booleanQuery = new BooleanQuery();
		
		booleanQuery.add(new BooleanClause(termRangeQuery,Occur.MUST));
    	
    	@SuppressWarnings("deprecation")
    	IndexReader indexReader = IndexReader.open(directory);
    	IndexSearcher indexSearcher = new IndexSearcher(indexReader);     
    	TopDocs topDocs = null;

    	/** Sorting Jobs based on posted date(Newer ones on Top) */
    	topDocs = indexSearcher.search(booleanQuery, MAX_HITS, new Sort(new SortField("job_posted_on",Type.STRING,true)));
    	
    	Map<String,List<String>> jobAndInternshipIds = new HashMap<String,List<String>>();
    	List<String> jobIdList = new ArrayList<String>();
    	
        ScoreDoc[] hits = topDocs.scoreDocs;
       
        System.out.println(hits.length + " Job Record(s) Found");
        
        for (ScoreDoc scoreDoc : hits) 
        {
        	int docId = scoreDoc.doc;
            Document document = indexSearcher.doc(docId);
            jobIdList.add(document.get("job_id_and_firm_id"));
		}
        
        jobAndInternshipIds.put("jobs", jobIdList);
        
        if(hits.length == 0)
        {
        	System.out.println("No Records Found ");
        }
        
        TermRangeQuery termRangeQueryForInternships = new TermRangeQuery("internship_posted_on",new BytesRef(lowerDate),new BytesRef(upperDate), true, true);
    	
		BooleanQuery booleanQueryForInternship = new BooleanQuery();
		
		booleanQueryForInternship.add(new BooleanClause(termRangeQueryForInternships,Occur.MUST));
    	
    	TopDocs topDocsForInternship = null;

    	/** Sorting Jobs based on posted date(Newer ones on Top) */
    	topDocsForInternship = indexSearcher.search(booleanQueryForInternship, MAX_HITS, new Sort(new SortField("internship_posted_on",Type.STRING,true)));
    	
    	List<String> internshipIdList = new ArrayList<String>();
        ScoreDoc[] hitsForInternship = topDocsForInternship.scoreDocs;
       
        System.out.println(hitsForInternship.length + " Internship Record(s) Found");
        
        for (ScoreDoc scoreDoc : hitsForInternship) 
        {
        	int docId = scoreDoc.doc;
            Document document = indexSearcher.doc(docId);
            internshipIdList.add(document.get("internship_id_and_firm_id"));
		}
        
        if(hits.length == 0)
        {
        	System.out.println("No Records Found ");
        }
        
        jobAndInternshipIds.put("internship", internshipIdList);
        
        indexReader.close();
        
    	return jobAndInternshipIds;
		
	}
	
	/**
	 * This method is used to fetch functional area, industry, job type and location from the database
	 * @author RavishaG
	 * @param indexDir
	 * @return Map<String,List<String>>
	 * @throws IOException
	 */
	public static Map<String,Map<String,String>> searchIndex(File indexDir) throws IOException {
		Directory directory = null;
			
		@SuppressWarnings("deprecation")
		Version luceneVersion = Version.LUCENE_CURRENT;
		
		try
		{
			directory = FSDirectory.open(indexDir);
		}
		catch(Exception exception)
		{
			throw new FileNotFoundException("Indexes not found at "+indexDir);
		}
		
		BooleanQuery booleanQuery = new BooleanQuery();
		
		//To get the date 90 days back(lowerDate)
    	String upperDate = DateTools.dateToString(new Date(),Resolution.SECOND);
    	String lowerDate = DateTools.dateToString(CaerusCommonUtil.getDateByDifference(90),Resolution.SECOND);
    	 
    	TermRangeQuery termRangeQuery = new TermRangeQuery("job_posted_on",new BytesRef(lowerDate),new BytesRef(upperDate), true, true);
    	booleanQuery.add(termRangeQuery,Occur.MUST);
		
    	@SuppressWarnings("deprecation")
    	IndexReader indexReader = IndexReader.open(directory);
    	IndexSearcher indexSearcher = new IndexSearcher(indexReader);     
    	TopDocs topDocs = null;

    	topDocs = indexSearcher.search(booleanQuery, MAX_HITS);
    	
    	Map<String,Map<String,String>> jobDetails = new HashMap<String,Map<String,String>>();
    	Map<String,String> functionalAreas = new HashMap<String,String>();
    	Map<String,String> industries = new HashMap<String,String>();
    	Map<String,String> locations = new HashMap<String,String>();
    	Map<String,String> jobTypes = new HashMap<String,String>();
    	
        ScoreDoc[] hits = topDocs.scoreDocs;
       
        System.out.println(hits.length + " Job Record(s) Found");
        
        for (ScoreDoc scoreDoc : hits) 
        {
        	int docId = scoreDoc.doc;
            Document document = indexSearcher.doc(docId);
            functionalAreas.put(document.get("job_id_and_firm_id"),document.get("functional_area"));
            industries.put(document.get("job_id_and_firm_id"),document.get("industry"));
            locations.put(document.get("job_id_and_firm_id"),document.get("location_for_jobs"));
            jobTypes.put(document.get("job_id_and_firm_id"),document.get("job_type"));
		}
        
        jobDetails.put(CaerusStringConstants.FUNCTIONAL_AREA, functionalAreas);
        jobDetails.put(CaerusStringConstants.INDUSTRY, industries);
        jobDetails.put(CaerusStringConstants.LOCATION, locations);
        jobDetails.put(CaerusStringConstants.JOB_TYPE, jobTypes);
        
        if(hits.length == 0)
        {
        	System.out.println("No Records Found ");
        }
        
        indexReader.close();
        
    	return jobDetails;
	}
	
	/**
	 * This method is used to fetch popular jobs of companies belonging to the same industry type
	 * @author RavishaG
	 * @param industry
	 * @param indexLocation
	 * @return Map<String,String>
	 * @throws ParseException
	 * @throws IOException
	 */
	public static Map<String,Map<String,String>> fetchPopularJobsOfSameIndustry(String industry,File indexLocation) throws ParseException, IOException
	{
		@SuppressWarnings("deprecation")
		Version luceneVersion = Version.LUCENE_CURRENT;
		Directory directory = null;
		try
		{
			directory = FSDirectory.open(indexLocation);
		}
		catch(Exception exception)
		{
			throw new FileNotFoundException("Indexes not found at "+indexLocation);
		}

		/** Fetch only jobs posted in the last 45 days(lowerBoundaryDays=45)*/ 
		
    	//To get the date 15 days back(lowerDate)
    	Date fourtyFiveDaysBack = CaerusCommonUtil.getDateByDifference(45);
    	
    	String upperDate=DateTools.dateToString(new Date(),Resolution.SECOND);
    	String lowerDate=DateTools.dateToString(fourtyFiveDaysBack,Resolution.SECOND);	 
    	 
    	//Creating a custom list of stop words(common English words that are usually not useful for searching) 
    	List<String> stopWords = Arrays.asList("a", "an", "and", "are", "as", "at", "be", "but", "by",
    			   "for", "if", "in", "into", "is",
    			   "no", "not", "of", "on", "or", "such",
    			   "that", "the", "their", "then", "there", "these",
    			   "they", "this", "to", "was", "will", "with","time");
    	CharArraySet stopSet = new CharArraySet(luceneVersion,stopWords, false);
    	
    	TermRangeQuery termRangeQuery = new TermRangeQuery("job_posted_on",new BytesRef(lowerDate),new BytesRef(upperDate), true, true);
		
		QueryParser queryParser = null;
		
		queryParser = new QueryParser(luceneVersion, "industry", new StandardAnalyzer(luceneVersion,stopSet));
		BooleanQuery booleanQuery = new BooleanQuery();
		
		booleanQuery.add(queryParser.parse(industry), BooleanClause.Occur.MUST);
		booleanQuery.add(new BooleanClause(termRangeQuery,Occur.MUST));
    	
    	@SuppressWarnings("deprecation")
    	IndexReader indexReader = IndexReader.open(directory);
    	IndexSearcher indexSearcher = new IndexSearcher(indexReader);     
    	TopDocs topDocs = null;

    	topDocs = indexSearcher.search(booleanQuery, MAX_HITS);
    	
    	Map<String,Map<String,String>> popularJobs = new HashMap<String,Map<String,String>>();
        ScoreDoc[] hits = topDocs.scoreDocs;
       
        System.out.println(hits.length + " Record(s) Found");
        
        for (ScoreDoc scoreDoc : hits) 
        {
        	int docId = scoreDoc.doc;
            final Document document = indexSearcher.doc(docId);
            popularJobs.put(document.get("job_id_and_firm_id"),new HashMap<String,String>(){{put(document.get("firm_name"),document.get("job_title"));}});
		}
        
        if(hits.length == 0)
        {
        	System.out.println("No Records Found ");
        }
        indexReader.close();
        
    	return popularJobs;
	}

	
}