

//package keyword.example;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.analysis.util.CharArraySet;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.IntField;
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


/**
 * @author PallaviD
 *
 */
public class LuceneKeywordIndexer {
	
	public static final String INDEX_DIR = "D:\\KeywordIndexes";
	
	private static Cluster cluster; 
	private static Session session; 
	static void connectToCassandra(String[] hosts,String keyspace)
	{
		  cluster = Cluster.builder().addContactPoints(hosts).build(); 
		  session = cluster.connect(keyspace); 
	}
	 
		
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		//Connecting to Cassandra
		  connectToCassandra(new String[]{"10.20.13.152"}, "caerusdb");
		 
		
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
					
						
	        	try
	        	{  
	        			   
	        			   StandardAnalyzer analyzer = new StandardAnalyzer(Version.LUCENE_CURRENT,CharArraySet.EMPTY_SET);  
	        			   IndexWriterConfig indexWriterConfig = new IndexWriterConfig(Version.LUCENE_CURRENT, analyzer);
	        			   IndexWriter indexWriter = new IndexWriter(FSDirectory.open(indexDir), indexWriterConfig);
	        			   
	        			   System.out.println("Indexing to directory '" + indexDir + "'...");  
	        			  
	        			   //Creating indexes for keywords
	        			   int indexForKeywordsCount = LuceneKeywordIndexer.createKeywordIndexes(cassandraOps, indexWriter);
	        			   System.out.println(indexForKeywordsCount + " keyword records have been indexed successfully");
	        			   	        			  
	        			   indexWriter.close();  
	        	} 
	        	catch (Exception e)
	        	{  
	        		e.printStackTrace();  
	        	} 
		

	}
	
	
	
	private static int createKeywordIndexes(CassandraOperations cassandraOps, IndexWriter indexWriter) throws IOException {
		
		int keywordCount=0;
		Select selectKeywordRecords = QueryBuilder.select("keyword", "keyword_count").from("keyword_master"); 
			
		   
		   com.datastax.driver.core.ResultSet rs = cassandraOps.query(selectKeywordRecords);
		   
		   for (Row row : rs) {
			   
			   Document document = new Document();
			   
			   document.add(new Field("keyword", row.getString("keyword"), Field.Store.YES,Field.Index.ANALYZED)) ;
			   
			   document.add(new IntField("keyword_count", row.getInt("keyword_count"), Field.Store.YES)) ;
			   
			   indexWriter.addDocument(document);  
			   keywordCount++;
			   
		   }
		
		
		return keywordCount;
	}

}
