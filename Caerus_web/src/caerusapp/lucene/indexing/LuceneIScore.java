package caerusapp.lucene.indexing;


import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.MatchAllDocsQuery;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.SortField;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import caerusapp.domain.student.StudentDom;
import caerusapp.util.CaerusPathConstants;

/**
 * @author TrishnaR
 * This class is used to calculate student I-Scores
 *
 */
public class LuceneIScore {
	
	public static List<StudentDom> getCandidateIScore() throws Exception
	{
		
		String SRC_FOLDER = CaerusPathConstants.studentIndexes;
		
		File indexDir = new File(SRC_FOLDER);
		Directory directory = null;
		List<StudentDom> studentList = new ArrayList<StudentDom>();
	
		try
		{
			directory = FSDirectory.open(indexDir);	
			
			@SuppressWarnings("deprecation")
			IndexReader indexReader = IndexReader.open(directory);
	    	IndexSearcher indexSearcher = new IndexSearcher(indexReader);     
			TopDocs topDocs = null;
			
			//Sorting documents on I-Score
		    SortField sortField = new SortField("i_score", SortField.Type.DOUBLE,true);
		    Sort sort = new Sort(sortField);      
		    Query query=new MatchAllDocsQuery();
		   
		    try 
		    {
		    	topDocs = indexSearcher.search(query,15,sort);
		    } 
		    catch (IOException e) 
		    {
		    	e.printStackTrace();
		    }
		           
		   ScoreDoc[] hits = topDocs.scoreDocs;
		         for (ScoreDoc scoreDoc : hits) 
		         {
		        	 int docId = scoreDoc.doc;
		        	 Document document;
					    try 
					    {
					    	document = indexSearcher.doc(docId);
						   
					    	StudentDom student = new StudentDom();
						    if(document.get("email_id")!=null)
						    	student.setEmailID(document.get("email_id"));
						    if(document.get("first_name")!=null)
						    	student.setFirstName(document.get("first_name"));
						    if(document.get("last_name")!=null)
						    	student.setLastName(document.get("last_name"));
						    if(document.get("i_score")!=null)
						    	student.setiScore(Double.parseDouble(document.get("i_score")));
						    if(document.get("university_name")!=null)
						    	student.setUniversityName(document.get("university_name"));
						    
						    if(document.get("photo_verified_flag") != null && document.get("photo_verified_flag").equals("true"))
						    {
						    	if(document.get("photoname")!=null)
						    		student.setPhotoName(document.get("photoname"));
						    }
						    
						    studentList.add(student);
						    
					    }
					    catch (FileNotFoundException fnfe){
					    	System.out.println("Indexes not found at "+indexDir);
					    }
					    catch (IOException e)
					    {	
					    	e.printStackTrace();
					    }
					    
		         }
		}
		catch(Exception exception)
		{
			System.out.println(("Indexes not found at "+SRC_FOLDER));
		}
		
		
			return studentList;
	}
}

