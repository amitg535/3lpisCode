package caerusapp.lucene.indexing;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.analysis.util.CharArraySet;
import org.apache.lucene.document.DateTools;
import org.apache.lucene.document.DateTools.Resolution;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.queryparser.classic.MultiFieldQueryParser;
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

/**
 * This class is used to search the indexes for jobs/internships from Home Page
 * @author TrishnaR
 *
 */
public class LuceneHomePageSearcher {
	
	//Maximum number of records to be fetched
	private static final int MAX_HITS = 100;
		
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 * 
	 * @param indexLocation
	 * @param searchKeyword
	 * @param searchCriterion
	 * @return List<String> (jobIdList)
	 * @throws Exception
	 */
	public List<String> searchIndex(File indexLocation, String searchKeyword, String searchCriterion) throws Exception
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
			
		MultiFieldQueryParser multiFieldQueryParser = null;
		TermRangeQuery termRangeQuery = null;
		BooleanQuery booleanQuery = new BooleanQuery();

    	//To get the date 90 days back(lowerDate)
    	Calendar calendar = Calendar.getInstance();
    	calendar.setTime(new Date());
    	calendar.add(Calendar.DAY_OF_YEAR, - 90);
    	Date ninetyDaysBack = calendar.getTime();
    	
    	String upperDate=DateTools.dateToString(new Date(),Resolution.SECOND);
    	String lowerDate=DateTools.dateToString(ninetyDaysBack,Resolution.SECOND);	 
    	 
    	if(searchCriterion.equalsIgnoreCase("jobs"))
    		termRangeQuery = new TermRangeQuery("job_posted_on",new BytesRef(lowerDate),new BytesRef(upperDate), true, true);
    	else
    		termRangeQuery = new TermRangeQuery("internship_posted_on",new BytesRef(lowerDate),new BytesRef(upperDate), true, true);
    	
    	//Creating a custom list of stop words(common English words that are usually not useful for searching) 
    	List<String> stopWords = Arrays.asList("a", "an", "and", "are", "as", "at", "be", "but", "by",
    			   "for", "if", "in", "into", "is",
    			   "no", "not", "of", "on", "or", "such",
    			   "that", "the", "their", "then", "there", "these",
    			   "they", "this", "to", "was", "will", "with");
    	
    	CharArraySet stopSet = new CharArraySet(luceneVersion,stopWords, false);
    	
    	if(searchCriterion.equalsIgnoreCase("jobs"))
    	{
    		//Setting the boosts for search parameters
	    	HashMap<String,Float> boosts = new HashMap<String,Float>();
			boosts.put("primary_skills_for_jobs", (float) 10 );
			boosts.put("secondary_skills_for_jobs", (float) 7.5 );
			boosts.put("job_title", (float) 10 );
			boosts.put("job_description", (float) 5 );
			boosts.put("location_for_jobs", (float) 8);
			boosts.put("functional_area", (float) 7);
			boosts.put("industry", (float) 7);
			
			String[] fields = new String[] {"primary_skills_for_jobs","secondary_skills_for_jobs","job_title",
											"job_description","location_for_jobs","functional_area","industry"};
			multiFieldQueryParser = new MultiFieldQueryParser(luceneVersion, fields,new StandardAnalyzer(luceneVersion,stopSet),boosts);
    	}
    	
    	if(searchCriterion.equalsIgnoreCase("internships"))
    	{
    		//Setting the boosts for search parameters
			HashMap<String,Float> boosts = new HashMap<String,Float>();
			boosts.put("primary_skills_for_internships", (float) 10);
			boosts.put("secondary_skills_for_internships", (float) 7.5 );
			boosts.put("internship_title", (float) 10 );
			boosts.put("internship_description", (float) 5 );
			boosts.put("location_for_internships", (float) 8);
			
			String[] fields = new String[] {"primary_skills_for_internships","secondary_skills_for_internships",
											"internship_title","internship_description","location_for_internships"};
			multiFieldQueryParser = new MultiFieldQueryParser(luceneVersion, fields,new StandardAnalyzer(luceneVersion,stopSet),boosts);
    	}
    	
    	booleanQuery.add(multiFieldQueryParser.parse(searchKeyword),BooleanClause.Occur.MUST);
    	
    	//Filtering results in the range of 90 days
    	booleanQuery.add(new BooleanClause(termRangeQuery,Occur.MUST));
    	
    	@SuppressWarnings("deprecation")
    	IndexReader indexReader = IndexReader.open(directory);
    	IndexSearcher indexSearcher = new IndexSearcher(indexReader); 
    	
    	TopDocs topDocs = indexSearcher.search(booleanQuery, MAX_HITS, new Sort(SortField.FIELD_SCORE));
    	
    	List<String> jobIdList = new ArrayList<String>();
        ScoreDoc[] hits = topDocs.scoreDocs;
       
        System.out.println(hits.length + " Record(s) Found");
        
        for (ScoreDoc scoreDoc : hits) 
        {
        	int docId = scoreDoc.doc;
            Document document = indexSearcher.doc(docId);
            
            if(searchCriterion.equalsIgnoreCase("jobs"))
            {
            	jobIdList.add(document.get("job_id_and_firm_id"));
            }
            
            if(searchCriterion.equalsIgnoreCase("internships"))
            {
            	jobIdList.add(document.get("internship_id_and_firm_id"));
            } 
		}
        
        if(hits.length ==0)
        {
        	System.out.println("No Records Found ");
        }
        
        indexReader.close();

    	return jobIdList;		
	}
	
}
