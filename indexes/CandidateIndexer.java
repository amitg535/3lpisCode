
import java.io.File;
import java.net.UnknownHostException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.analysis.util.CharArraySet;
import org.apache.lucene.document.DateTools;
import org.apache.lucene.document.DateTools.Resolution;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.DoubleField;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.LongField;
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

public class CandidateIndexer 
{	
		public static final String INDEX_DIR = "D:\\StudentIndexes";
		
		private static Cluster cluster; 
		private static Session session; re
		 
		static void connectToCassandra(String[] hosts,String keyspace)
		{
			  cluster = Cluster.builder().addContactPoints(hosts).build(); 
			  session = cluster.connect(keyspace); 
		}
		 
		 
		 public static void main(String[] args) throws UnknownHostException { 
		 
		  //Connecting to Cassandra
		  connectToCassandra(new String[]{"10.20.13.152"}, "caerusdb");
		 
		
		  CassandraOperations cassandraOps = new CassandraTemplate(session); 
		 
		 
		   Select selectStudent = QueryBuilder.select().from("student_details"); 
		   
		   com.datastax.driver.core.ResultSet rs = cassandraOps.query(selectStudent);
		   
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
			   IndexWriter indexWriter;
			
			   try{
				   indexWriter = new IndexWriter(FSDirectory.open(indexDir), indexWriterConfig);
					
				   System.out.println("Indexing to directory '" + indexDir + "'...");  
				   
				   
				   int indexedDocumentCount = 0;   
				
			   
			   for (Row row : rs) {
				   
				   /** Iterating Result Set to fetch Individual Values and Adding to Document*/
			         Document document = new Document();  
			         document.add(new TextField("email_id", row.getString("email_id"), Field.Store.YES));
			         
			         if(null!=row.getString("first_name"))
				         document.add(new TextField("first_name", row.getString("first_name"), Field.Store.YES));
			         
			         if(null!=row.getString("last_name"))
				         document.add(new TextField("last_name", row.getString("last_name"), Field.Store.YES));
			        
			         if(null!=row.getList("primary_skills", String.class))
			        	 document.add(new Field("primary_skills", row.getList("primary_skills", String.class).toString(), Field.Store.YES,Field.Index.ANALYZED));
			        
			         if(null!=row.getList("secondary_skills", String.class))
			        	 document.add( new Field("secondary_skills", row.getList("secondary_skills", String.class).toString(), Field.Store.YES,Field.Index.ANALYZED));
			         
			         if(null!=row.getString("profile_name"))
			        	 document.add( new Field("resume_heading", row.getString("profile_name"), Field.Store.YES,Field.Index.ANALYZED));
			         
			         if(null != row.getString("resumename"))
             				document.add(new TextField("resume_name", row.getString("resumename"), Field.Store.YES));
			         
			         if(null!=row.getMap("university_map", String.class, String.class)){
			        	 
			        	Map<String,String> universityMap = sortMapObject(row.getMap("university_map", String.class, String.class));
						
			        	// Finding the last entry in the map to find count of entries
						Entry<String, String> universityEntry = getLastMapEntry(universityMap);
							
						if(universityEntry != null)
						{
							String[] lastEntry = universityEntry.getKey().split("_");
							String index = lastEntry[0];
							int i = Integer.parseInt(index);
			        	 
							for(int j = 1; j <= i; j++)
							{
								for (Entry<String, String> entry : row.getMap("university_map", String.class, String.class).entrySet()) 
								{
								// Creating index on university name to search candidates by university name	
								document.add(new Field("university_name", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));
					        		
					        		int a = Character.getNumericValue(entry.getKey().charAt(0));
					        		 
					        		// Adding entries to indexes
									if(a == j)
									{
						        		 if(entry.getKey().contains(a+"_universityName")){
											
											document.add( new Field(a+"_universityName", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));      
											
										}
						        		 
										if(entry.getKey().contains(a+"_universityGpaFrom")){
																		
											document.add( new Field(a+"_universityGpaFrom", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));    
											
										}
										
										if(entry.getKey().contains(a+"_universityGpaTo")){
											
											document.add( new Field(a+"_universityGpaTo", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));    
											
										}
										
										if(entry.getKey().contains(a+"_universityYearFrom")){
											
											document.add( new Field(a+"_universityYearFrom", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));     
											
										}
										
										if(entry.getKey().contains(a+"_universityYearTo")){
											
											document.add( new Field(a+"_universityYearTo", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));      
											
										}
										
										if(entry.getKey().contains(a+"_universityMonthFrom")){
											
											document.add( new Field(a+"_universityMonthFrom", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));     
											
										}
										if(entry.getKey().contains(a+"_universityMonthTo")){
											
											document.add( new Field(a+"_universityMonthTo", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));   
											
										}
										
										if(entry.getKey().contains(a+"_universityCourseType")){
											
											document.add( new Field(a+"_universityCourseType", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));   
											
										}
										
										if(entry.getKey().contains(a+"_universityCourseName")){
											
											document.add( new Field(a+"_universityCourseName", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));   
											 
										}
										
									}
								
								}
							}
							
								// Adding count of entries to indexes
								document.add( new LongField("universityCount",i, Field.Store.YES));
						}
			        	 
			         }
			         
			         if(null!=row.getMap("school_map", String.class, String.class)){
			        	
			        	 for (Entry<String, String> entry : row.getMap("school_map", String.class, String.class).entrySet()) {
			        		 
							if(entry.getKey().contains("schoolName")){
								
								document.add( new Field("schoolName", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));      
							}
							if(entry.getKey().contains("schoolState")){
								
								document.add( new Field("schoolState", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));      
							}
							if(entry.getKey().contains("schoolGpaFrom")){
								
								document.add( new Field("schoolGpaFrom", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));      
							}
							if(entry.getKey().contains("schoolGpaTo")){
								
								document.add( new Field("schoolGpaTo", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));      
							}
							if(entry.getKey().contains("schoolPassingYear")){
								
								document.add( new Field("schoolPassingYear", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));      
							}
							if(entry.getKey().contains("schoolPassingMonth")){
	
								document.add( new Field("schoolPassingMonth", entry.getValue().toString(), Field.Store.YES,Field.Index.ANALYZED));      
							}
							
						}
			         }
			         
			         if(null!=row.getString("about_your_self"))
			        	 document.add(new Field("about_your_self", row.getString("about_your_self"), Field.Store.YES,Field.Index.ANALYZED));

			         if(null!=row.getString("city"))
			         document.add(new TextField("city", row.getString("city"), Field.Store.YES));
			         
			         if(null!=row.getString("state"))
			         document.add(new TextField("state", row.getString("state"), Field.Store.YES));
			         
			         
			         if(0 != row.getInt("video_profile_view_count"))
			        	 document.add(new LongField("video_profile_view_count", row.getInt("video_profile_view_count"), Field.Store.YES));
			         
			         // if(row.getBool("profile_visibility"))
			         document.add(new TextField("profile_visibility", String.valueOf(row.getBool("profile_visibility")), Field.Store.YES));
			         
			         document.add(new TextField("photo_verified_flag", String.valueOf(row.getBool("photo_verified_flag")), Field.Store.YES));
			         
			         if(null!=row.getDate("last_updated"))
			         {
			        	 float boost = 25.0f;
				        	
			        	 Date profileLastUpdatedDate = row.getDate("last_updated");
			        	 Date currentDate = new Date();
			        	 
			        	 long postedOnTime = profileLastUpdatedDate.getTime();
			        	 long currentTime = currentDate.getTime();
			        	 long differenceInTime = currentTime - postedOnTime;
			        	 
			        	 //Calculating difference in days
			        	 long differenceInDays = differenceInTime / (1000 * 60 * 60 * 24);

			        	 /**  Setting Higher Boosts to Recently Posted Jobs */
			        	 if(differenceInDays>0)
			        	 {
			        		boost =  (1.0f/differenceInDays) * 20;
			        	 } 
			        	
			        	 String profileLastUpdated = DateTools.dateToString(profileLastUpdatedDate, Resolution.SECOND);
			    
				        Field dateField= new Field("last_updated",profileLastUpdated, Field.Store.YES,Field.Index.ANALYZED); 
				        dateField.setBoost(boost);
				        document.add(dateField);
			         }
			         if(0!=row.getDouble("i_score"))
			        	 document.add(new DoubleField("i_score", row.getDouble("i_score"), Field.Store.YES));
			        
			         if(null!=row.getString("photoname"))
				         document.add(new TextField("photoname", row.getString("photoname"), Field.Store.YES));
			         if(null!=row.getMap("viewed_by_companies_map",String.class,Date.class))
			         {
				         document.add(new LongField("viewed_by_companies_map_count",row.getMap("viewed_by_companies_map",String.class,Date.class).size(), Field.Store.YES));
			         }
			         if(null!=row.getString("date_of_birth"))
				         document.add(new TextField("date_of_birth", row.getString("date_of_birth"), Field.Store.YES));
			      		if(null!=row.getString("date_of_birth"))
			      		{
			        	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 
			        	    Date birthDate = null;
			        	    try {
			        	    	birthDate = df.parse(row.getString("date_of_birth"));
			        	    } catch (ParseException e) {
			        	        e.printStackTrace();
			        	    }
			        	 //create calendar object for birth day
			             Calendar birthDay = Calendar.getInstance();
			             birthDay.setTimeInMillis(birthDate.getTime());
			             //create calendar object for current day
			             long currentTime = System.currentTimeMillis();
			             Calendar now = Calendar.getInstance();
			             now.setTimeInMillis(currentTime);
			             int years;
			             int months;
			             //Get difference between years
			             years= now.get(Calendar.YEAR) - birthDay.get(Calendar.YEAR);
			             int currMonth = now.get(Calendar.MONTH) + 1;
			             int birthMonth = birthDay.get(Calendar.MONTH) +1 ;
			             //Get difference between months
			             months = currMonth - birthMonth;
			             //if month difference is in negative then reduce years by one and calculate the number of months.
			             if (months < 0)
			             {
			                years--;
			                months = 12 - birthMonth + currMonth;
			                if (now.get(Calendar.DATE) < birthDay.get(Calendar.DATE))
			                   months--;
			             } else if (months == 0 && now.get(Calendar.DATE) < birthDay.get(Calendar.DATE))
			             {
			                years--;
			                months = 11;
			             }
			             int age=years*12+months;
			             document.add(new LongField("age",age, Field.Store.YES));
			         }
			      
			         indexWriter.addDocument(document);  
			         indexedDocumentCount++;
				
			}
			   
			   indexWriter.close();  
			   System.out.println(indexedDocumentCount + " records have been indexed successfully"); 
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
		  * This method is used to sort a map
		  * @param mapCollectionObject
		  * @return
		  */
		 public static Map<String, String> sortMapObject(Map<String, String> mapCollectionObject) {

				// TreeMap stores data in a sorted order
				Map<String, String> sortMap = new TreeMap<String, String>(
						mapCollectionObject);

				return sortMap;

			}
	
		/**
		 * This method is used to find the last entry of a sorted map
		 * @param map
		 * @return
		 */
		 public static <String,String1> Map.Entry<String1,String1> getLastMapEntry(Map<String1,String1> map) {
				
			    Iterator<Map.Entry<String1,String1>> iterator = map.entrySet().iterator();
			    Map.Entry<String1,String1> result = null;
			    
			    while (iterator.hasNext()) {
			        result = iterator.next();
			    }
			    
			    return result;
			}
		 
	}
