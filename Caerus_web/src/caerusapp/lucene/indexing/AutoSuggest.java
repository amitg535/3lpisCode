package caerusapp.lucene.indexing;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.search.suggest.DocumentDictionary;
import org.apache.lucene.search.suggest.Lookup;
import org.apache.lucene.search.suggest.Lookup.LookupResult;
import org.apache.lucene.search.suggest.analyzing.AnalyzingInfixSuggester;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;
import org.springframework.dao.EmptyResultDataAccessException;

import caerusapp.util.CaerusPathConstants;

/**
 * @author pallaviD
 * This Class is used to Auto Suggest Keywords on User Search Jobs/Internships on Home Page
 */
public class AutoSuggest
{
	public List<LookupResult> returnSuggestedWords(String enteredText)
	{
		//File containing Indexes for Searched Keywords and their Frequency
		 File indexDirectory = new File(CaerusPathConstants.keywordIndexes);
		 
		 //File created for AnalysingInfixSuggester containing it's own version of Indexes used to suggest Keywords
		 File suggesterDirectory = new File(CaerusPathConstants.suggesterIndexes);
		 
		 //Suggester Result 
		 List<LookupResult> results= null;
		
		try
		{
		
		   //Used to read pre-generated Indexes from indexDirectory
			FSDirectory fsDirectoryForKeywordIndexs = FSDirectory.open(indexDirectory); 
			
			//Creating DocumentDictionary to read Indexes
			DocumentDictionary documentDictionary = new DocumentDictionary(IndexReader.open(fsDirectoryForKeywordIndexs), "keyword", "keyword_count");
			
			//Open Suggester Directory
			FSDirectory fsDirectoryForSuggesterIndexes= FSDirectory.open(suggesterDirectory);
			
			//AnalyzingInfixSuggester - Analyses the input text and then suggests matches based on prefix matches to any tokens in the indexed text 
			AnalyzingInfixSuggester suggester = new AnalyzingInfixSuggester(Version.LUCENE_48, fsDirectoryForSuggesterIndexes, new StandardAnalyzer(Version.LUCENE_48));

			//Builds up a new internal Lookup representation based on the given documentDictionary
			 suggester.build(documentDictionary);
			
			 //LookUp Results containing Top 5 Matched Values
			 results = suggester.lookup(enteredText, true, 5);
			 
			 //Close Directories
			 suggester.close();
			 fsDirectoryForSuggesterIndexes.close();
			 fsDirectoryForKeywordIndexs.close();
		
		}
		catch(FileNotFoundException fnfe)
		{
			System.out.println("File not found");
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		if(null!=results||results.size()!=0)
		return results;
		
		else throw new EmptyResultDataAccessException(1);
	}
	
	
	/**
	 * @author BalajiI,RavishaG
	 * Returns Suggestions based on EnteredText. Autocomplete. E.G : j returns Java, Javascript, Jquery based on their respective Popularity. 
	 * @param enteredText
	 * @return List<LookupResult> (suggestedSkills)
	 */
	@SuppressWarnings("deprecation")
	public static List<LookupResult> suggestSkills(String enteredText, boolean employerSuggesterFlag)
	{
		String INDEX_DIRECTORY = "";
		String SUGGESTER_INDEXES = "";
		String INDEX_KEY = "";
		
		//File containing Indexes for Searched Keywords and their Frequency
		if(employerSuggesterFlag)
		{
			INDEX_DIRECTORY = CaerusPathConstants.employerKeywordIndexes;
			SUGGESTER_INDEXES = CaerusPathConstants.employerSuggesterIndexes;
			INDEX_KEY = "keyword";
		}
		else
		{
			INDEX_DIRECTORY = CaerusPathConstants.skillIndexes;
			SUGGESTER_INDEXES = CaerusPathConstants.skillSuggesterIndexes;
			INDEX_KEY = "skill";
		}
		
		File indexDirectory = new File(INDEX_DIRECTORY);
		 
		 //File created for AnalysingInfixSuggester containing its own version of Indexes used to suggest Keywords
		 File suggesterDirectory = new File(SUGGESTER_INDEXES);
		 
		 //Suggester Result 
		 List<LookupResult> results = new ArrayList<Lookup.LookupResult>();
		
		try
		{
		   //Used to read pre-generated Indexes from indexDirectory
			FSDirectory fsSkillsDirectory = FSDirectory.open(indexDirectory); 
			
			//Creating DocumentDictionary to read Indexes
			DocumentDictionary documentDictionary = new DocumentDictionary(IndexReader.open(fsSkillsDirectory), INDEX_KEY, "count");
			
			//Open Suggester Directory
			FSDirectory fsSkillSuggesterDirectory = FSDirectory.open(suggesterDirectory);
			
			//AnalyzingInfixSuggester - Analyses the input text and then suggests matches based on prefix matches to any tokens in the indexed text 
			AnalyzingInfixSuggester suggester = new AnalyzingInfixSuggester(Version.LUCENE_CURRENT, fsSkillSuggesterDirectory, new StandardAnalyzer(Version.LUCENE_CURRENT));

			//Builds up a new internal Lookup representation based on the given documentDictionary
			suggester.build(documentDictionary);
			
			//LookUp Results containing Top 5 Matched Values
			results = suggester.lookup(enteredText, true, 5);
			 
			//Close Directories
			suggester.close();
			fsSkillSuggesterDirectory.close();
			fsSkillsDirectory.close();
		}
		catch(FileNotFoundException fnfe)
		{
			fnfe.printStackTrace();
			System.out.println("File not found at "+INDEX_DIRECTORY);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return null == results ? new ArrayList<Lookup.LookupResult>() : results;
	}
	
}