
import java.io.File;
import java.io.IOException;
import java.net.UnknownHostException;
import java.util.Date;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.analysis.util.CharArraySet;
import org.apache.lucene.document.DateTools;
import org.apache.lucene.document.DateTools.Resolution;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;
import org.springframework.data.cassandra.core.CassandraOperations;
import org.springframework.data.cassandra.core.CassandraTemplate;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.datastax.driver.core.querybuilder.Select;

public class JobIndexer 
{	
		public static final String INDEX_DIR = "D:\\JobIndexes";
		
		private static Cluster cluster; 
		private static Session session; 
		 
		static void connectToCassandra(String[] hosts,String keyspace)
		{
			  cluster = Cluster.builder().addContactPoints(hosts).build(); 
			  session = cluster.connect(keyspace); 
		}
		 
		 
		 public static void main(String[] args) throws UnknownHostException { 
		 
		  //Connecting to Cassandra
		  connectToCassandra(new String[]{"10.20.4.106"}, "caerusdb");
		 
		
		  CassandraOperations cassandraOps = new CassandraTemplate(session); 
		
		  File indexDir = new File(INDEX_DIR);
			
			if (!indexDir.exists()) 
			{
				System.out.println("Creating Directory...");
				indexDir.mkdir(); 
			}		
			String[] myFiles= indexDir.list();
					
			if(myFiles.length > 0)
			{
			System.out.println("Deleting files...");
							
			for (String fileName : myFiles) 
			{
				File myFile = new File(indexDir, fileName);
				System.out.println(myFile);
				myFile.delete();
			}
		   }
			
			  @SuppressWarnings("deprecation")
			   StandardAnalyzer standardAnalyzer = new StandardAnalyzer(Version.LUCENE_CURRENT,CharArraySet.EMPTY_SET);  
			   @SuppressWarnings("deprecation")
			  
			   IndexWriterConfig indexWriterConfig = new IndexWriterConfig(Version.LUCENE_CURRENT, standardAnalyzer);
			
			   try{
				   IndexWriter indexWriter = new IndexWriter(FSDirectory.open(indexDir), indexWriterConfig);
				   
					
				   System.out.println("Indexing to directory '" + indexDir + "'...");  
				   
				   
				 //Creating indexes for published jobs
    			   int indexForJobsCount = JobIndexer.createJobIndexes(cassandraOps, indexWriter);
    			   System.out.println(indexForJobsCount + " job records have been indexed successfully");
				   
    			 //Creating indexes for published internships
    			  int indexForInternshipCount = JobIndexer.createInternshipIndexes(cassandraOps, indexWriter);
    			   System.out.println(indexForInternshipCount + " internship records have been indexed successfully");  
				   
			
			     indexWriter.close();  
			   
			   }
			   
			   catch (Exception e) {
				   
				   e.printStackTrace();
				   
			   }
			   
			   finally{
				   
				   session.close();
				   cluster.close();
			   }
		 } 
		 
		 
		 /**
		  * 
		  * @param cassandraOps
		  * @param indexWriter
		  * @return jobCount
		  * @throws IOException
		  */
		 private static int createJobIndexes(CassandraOperations cassandraOps, IndexWriter indexWriter) throws IOException{
			 
			 int jobCount=0;
			 
			 Select selectJob = QueryBuilder.select("job_id_and_firm_id", "primary_skills", "secondary_skills", "location", "functional_area",  "industry", 
					 "posted_on", "job_title", "description","job_type").from("job_dtls"); 
				
			   selectJob.where(QueryBuilder.eq("status", "Published"));
			   
			   com.datastax.driver.core.ResultSet rs = cassandraOps.query(selectJob);
			   
			   for (Row row : rs) {
				   
				   Document document = new Document();
				     
				     /**
				      * Adding fields to document starts
				      */
				     document.add(new TextField("job_id_and_firm_id", row.getString("job_id_and_firm_id"), Field.Store.YES)) ;
				     //System.out.println("Testing"+row.getString("job_id_and_firm_id"));
				     
				     //List<String> localPrimarySkills;
					    
				     if(null!=row.getList("primary_skills", String.class))
				     {
				    	/* localPrimarySkills=row.getList("primary_skills", String.class);
				    	 if(localPrimarySkills.contains("["))
				    	 {
				    		 if(localPrimarySkills.contains("]"))
					    	 {
					    		 localPrimarySkills=localPrimarySkills.replace("]","");
					    	 }
				    		 
				    		 localPrimarySkills=localPrimarySkills.replace("[","");
				    	 }
				    	 */
				    	 Field primarySkillField=new Field("primary_skills_for_jobs", row.getList("primary_skills", String.class).toString(), Field.Store.YES,Field.Index.ANALYZED);
				    	 document.add(primarySkillField) ;  
				     }
				     
				     else
				    	  document.add(new TextField("primary_skills_for_jobs",row.getList("primary_skills", String.class).toString(), Field.Store.YES)) ;  
				     
				     String localSecondarySkills="";
					    
				 if(null!=row.getList("secondary_skills", String.class))
				     {
					 /* localSecondarySkills=row.getList("secondary_skills", String.class);
				    	 if(localSecondarySkills.contains("["))
				    	 {
				    		 if(localSecondarySkills.contains("]"))
					    	 {
				    			 localSecondarySkills=localSecondarySkills.replace("]","");
					    	 }
				    		 
				    		 localSecondarySkills=localSecondarySkills.replace("[","");
				    	 }*/
				    	 
				    	 Field secondarySkillField=new Field("secondary_skills_for_jobs",row.getList("secondary_skills", String.class).toString(), Field.Store.YES,Field.Index.ANALYZED);
				    	 document.add(secondarySkillField) ; 
					  
				     }
				     
				     else
				    	  document.add(new TextField("secondary_skills_for_jobs",row.getList("secondary_skills", String.class).toString(), Field.Store.YES)) ;  
				     
				     
				     if(null!=row.getString("location"))
					     document.add(new TextField("location_for_jobs", row.getString("location"), Field.Store.YES));  
					     else
						 document.add(new TextField("location_for_jobs", " ", Field.Store.YES)) ;
				     
				     
				     if(null!=row.getString("functional_area"))
					     document.add(new TextField("functional_area", row.getString("functional_area"), Field.Store.YES));  
					     else
						 document.add(new TextField("functional_area", " ", Field.Store.YES)) ;
				     
				     
				     if(null!=row.getString("industry"))
					     document.add(new TextField("industry", row.getString("industry"), Field.Store.YES));  
					     else
						 document.add(new TextField("industry", " ", Field.Store.YES)) ;
				     
				     if(null!=row.getString("job_type"))
					     document.add(new TextField("job_type", row.getString("job_type"), Field.Store.YES));  
					     else
						 document.add(new TextField("job_type", " ", Field.Store.YES)) ;
				       	
				     
				     if(null!=row.getString("job_title"))
				     	{
					    	 Field jobTitleField= new Field("job_title",row.getString("job_title"), Field.Store.YES,Field.Index.ANALYZED);
					    	 document.add(jobTitleField) ; 
				     	}
					     else
					     {
					    	 document.add(new TextField("job_title", " ", Field.Store.YES)) ;
					     }
				        if( row.getDate("posted_on")!=null)
				            
				        { 
				        	float boost = 25.0f;
				        	
				        	 Date postedOnDate = row.getDate("posted_on");
				        	 Date currentDate = new Date();
				        	 
				        	 long postedOnTime = postedOnDate.getTime();
				        	 long currentTime = currentDate.getTime();
				        	 long differenceInTime = currentTime - postedOnTime;
				        	 //Calculating difference in days
				        	 long differenceInDays = differenceInTime / (1000 * 60 * 60 * 24);
				        	 
				        	 //Setting a higher boost to most recently posted jobs
				        	 if(differenceInDays>0)
				        	 {
				        		boost =  (1.0f/differenceInDays) * (float) 20;
				        	 } 
				        	String postedOn = DateTools.dateToString(row.getDate("posted_on"), Resolution.SECOND);
				        	
				        	Field dateField= new Field("job_posted_on", postedOn, Field.Store.YES,Field.Index.NOT_ANALYZED);
		     	        	dateField.setBoost(boost);
					        document.add(dateField);
				        }	
				        else
				        	document.add(new Field("job_posted_on","0", Field.Store.YES,Field.Index.NOT_ANALYZED));
				        
				        if(null!=row.getString("description"))
				        {
				        	Field jobDescriptionField= new Field("job_description",row.getString("description"), Field.Store.YES,Field.Index.ANALYZED);
					    	document.add(jobDescriptionField) ;
				        }
				        else
				        {
				        	document.add(new TextField("job_description"," ", Field.Store.YES)) ;
				        }
			         
			      
			         indexWriter.addDocument(document);  
			         jobCount++;
				
			}
			return jobCount;
			 
		 }
	
		 private static int createInternshipIndexes(CassandraOperations cassandraOps, IndexWriter indexWriter) throws IOException{
			 /*private static final String QUERY_FOR_INTERNSHIP = "select internship_id_and_firm_id,primary_skills,secondary_skills,location," +
				",, from internship_dtls where status = \'Published\'";*/
			 
			 int internshipCount=0;
			 
			 Select selectJob = QueryBuilder.select("internship_id_and_firm_id", "primary_skills", "secondary_skills", "location", 
					 "posted_on", "internship_title", "description").from("internship_dtls"); 
				
			   selectJob.where(QueryBuilder.eq("status", "Published"));
			   
			   com.datastax.driver.core.ResultSet rs = cassandraOps.query(selectJob);
		         for (Row row : rs) {
				   
				   Document document = new Document();
				     
				     /**
				      * Adding fields to document starts
				      */
				     document.add(new TextField("internship_id_and_firm_id", row.getString("internship_id_and_firm_id"), Field.Store.YES)) ;
				     //System.out.println("Testing"+row.getString("internship_id_and_firm_id"));
				     
				     //List<String> localPrimarySkills;
					    
				     if(null!=row.getList("primary_skills", String.class))
				     {
				    	/* localPrimarySkills=row.getList("primary_skills", String.class);
				    	 if(localPrimarySkills.contains("["))
				    	 {
				    		 if(localPrimarySkills.contains("]"))
					    	 {
					    		 localPrimarySkills=localPrimarySkills.replace("]","");
					    	 }
				    		 
				    		 localPrimarySkills=localPrimarySkills.replace("[","");
				    	 }
				    	 */
				    	 Field primarySkillField=new Field("primary_skills_for_internships", row.getList("primary_skills", String.class).toString(), Field.Store.YES,Field.Index.ANALYZED);
				    	 document.add(primarySkillField) ;  
				     }
				     
				     else
				    	  document.add(new TextField("primary_skills_for_internships",row.getList("primary_skills", String.class).toString(), Field.Store.YES)) ;  
				     
				     //String localSecondarySkills="";
					    
				 if(null!=row.getList("secondary_skills", String.class))
				     {
				    	 /*localSecondarySkills=row.getString("secondary_skills");
				    	 if(localSecondarySkills.contains("["))
				    	 {
				    		 if(localSecondarySkills.contains("]"))
					    	 {
				    			 localSecondarySkills=localSecondarySkills.replace("]","");
					    	 }
				    		 
				    		 localSecondarySkills=localSecondarySkills.replace("[","");
				    	 }*/
				    	 
				    	 Field secondarySkillField=new Field("secondary_skills_for_internships",row.getList("secondary_skills", String.class).toString(), Field.Store.YES,Field.Index.ANALYZED);
				    	 document.add(secondarySkillField) ; 
					  
				     }
				     
				     else
				    	  document.add(new TextField("secondary_skills_for_internships",row.getList("secondary_skills", String.class).toString(), Field.Store.YES)) ;  
				     
				     
				     if(null!=row.getString("location"))
					     document.add(new TextField("location_for_internships", row.getString("location"), Field.Store.YES));  
					     else
						 document.add(new TextField("location_for_internships", " ", Field.Store.YES)) ;
				     
				     if(null!=row.getString("internship_title"))
				     	{
					    	 Field jobTitleField= new Field("internship_title",row.getString("internship_title"), Field.Store.YES,Field.Index.ANALYZED);
					    	 document.add(jobTitleField) ; 
				     	}
					     else
					     {
					    	 document.add(new TextField("internship_title", " ", Field.Store.YES)) ;
					     }
				        if( row.getDate("posted_on")!=null)
				            
				        { 
				        	float boost = 25.0f;
				        	
				        	 Date postedOnDate = row.getDate("posted_on");
				        	 Date currentDate = new Date();
				        	 
				        	 long postedOnTime = postedOnDate.getTime();
				        	 long currentTime = currentDate.getTime();
				        	 long differenceInTime = currentTime - postedOnTime;
				        	 //Calculating difference in days
				        	 long differenceInDays = differenceInTime / (1000 * 60 * 60 * 24);
				        	 
				        	 //Setting a higher boost to most recently posted jobs
				        	 if(differenceInDays>0)
				        	 {
				        		boost =  (1.0f/differenceInDays) * (float) 20;
				        	 } 
				        	String postedOn = DateTools.dateToString(row.getDate("posted_on"), Resolution.SECOND);
				        	
				        	Field dateField= new Field("internship_posted_on", postedOn, Field.Store.YES,Field.Index.NOT_ANALYZED);
		     	        	dateField.setBoost(boost);
					        document.add(dateField);
				        }	
				        else
				        	document.add(new Field("internship_posted_on","0", Field.Store.YES,Field.Index.NOT_ANALYZED));
				        
				        if(null!=row.getString("description"))
				        {
				        	Field jobDescriptionField= new Field("internship_description",row.getString("description"), Field.Store.YES,Field.Index.ANALYZED);
					    	document.add(jobDescriptionField) ;
				        }
				        else
				        {
				        	document.add(new TextField("internship_description"," ", Field.Store.YES)) ;
				        }
			         
			      
			         indexWriter.addDocument(document);  
			         internshipCount++;
				
			}
			return internshipCount;
			
	     }


}
