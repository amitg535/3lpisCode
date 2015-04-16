/**
 * 
 */
package caerusapp.dao.common;



import java.util.ArrayList;	
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cassandra.core.RowMapper;
import org.springframework.data.cassandra.core.CassandraOperations;

import caerusapp.domain.common.MessageDom;
import caerusapp.util.CaerusCommonUtility;

import com.datastax.driver.core.Row;
import com.datastax.driver.core.exceptions.DriverException;
import com.datastax.driver.core.querybuilder.Insert;
import com.datastax.driver.core.querybuilder.QueryBuilder;

/**
 * This class is used to implement corporate-candidate message system functions
 * @author pallavid
 *
 */
public class MessageDao implements IMessageDao {
	
	@Autowired
	CassandraOperations cassandraOperations;
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	  * This class is used to Map the ResultSet values to Domain/Value Objects.
	  */
	public static class MessageDetailMapperReg implements
	RowMapper<MessageDom> {
	

		
		@Override
		public MessageDom mapRow(Row rs, int arg1) throws DriverException {
			MessageDom message = new MessageDom();
			message.setMessageId(rs.getString("message_id"));
			message.setFirstMessage(rs.getBool("is_first_message"));
			message.setJobIdAndFirmId(rs.getString("job_id_and_firm_id"));
			message.setMessage(rs.getString("message"));
			message.setPostedOn(rs.getDate("posted_on").toString());
			message.setPrevMessageId(rs.getString("prev_message_id"));
			message.setRead(rs.getBool("is_read"));
			message.setReceiverEmailId(rs.getString("receiver_email_id"));
			message.setSenderEmailId(rs.getString("sender_email_id"));
			message.setCandidateName(rs.getString("candidate_name"));
			message.setCompanyName(rs.getString("company_name"));
			message.setJobTitle(rs.getString("job_title"));
			message.setMessageSubject(rs.getString("subject"));
			
			return message;
		}
	


	
}
	/**
	  * This class is used to Map the ResultSet values to Domain/Value Objects.
	  */
	public static class MessageDetailMapperReg1 implements
	RowMapper<MessageDom> {
	
		@Override
		public MessageDom mapRow(Row rs, int arg1) throws DriverException {

			MessageDom message = new MessageDom();
			message.setMessageId(rs.getString("message_id"));
			message.setFirstMessage(rs.getBool("is_first_message"));
			message.setFirstMessageId(rs.getString("first_message_id"));
			return message;
		}
	
}
	
	/**
	 * This method is used to add a new message
	 * @param message
	 */
	
	@Override
	public void addMessage(MessageDom message) {
		
	//Generating message id from sender's email id		
	String[] tokens = message.getSenderEmailId().split("@"); 
				
	String userName = tokens[0]; 
				
	String messageId=userName.concat(UUID.randomUUID().toString().replace("-", ""));
	System.out.println("messageId"+messageId);
				
	Date currentDate = new Date();
	int messageForCandidateJobCount = 0;
	
	 //Check if any message exists against job_id_and_firm_id for particular user
	
	if(message.getJobIdAndFirmId() != null)
	{
		String sql = "Select count(1) from message_details where job_id_and_firm_id='"+message.getJobIdAndFirmId()+"' and receiver_email_id='"+message.getReceiverEmailId()+"' ALLOW FILTERING";
		messageForCandidateJobCount = Integer.valueOf(cassandraOperations.queryForObject(sql, Long.class).toString());
	}
	
	if(messageForCandidateJobCount !=0){
			
			List<MessageDom> messageForJobList = new ArrayList<MessageDom>();
			//Select and sort to retrieve most recent message for current job_id_and_firm_id and receiver
			
			String sql11= "Select *  from message_details where job_id_and_firm_id='"+ message.getJobIdAndFirmId()+"'and receiver_email_id='"+message.getReceiverEmailId()+"' ALLOW FILTERING";
			messageForJobList = (List<MessageDom>) cassandraOperations.query(sql11, new MessageDetailMapperReg());//check
			
			if(messageForJobList.size() != 0){
				
				List<MessageDom> sortedMessageList = CaerusCommonUtility.sortListByDateReverse(messageForJobList, "MessageDom");
				//Set properties of current message 
				message.setPrevMessageId(sortedMessageList.get(0).getMessageId());
				message.setFirstMessageId(sortedMessageList.get(0).getMessageId());
				message.setFirstMessage(false);
				
			}
			
		}
	
	//Initiating new message chain, first message insert in message_details table and setting first_message_id as null String
	if(message.isFirstMessage()==true){
		
		try{
			
			Insert insertMessage = QueryBuilder.insertInto("message_details").values(new String[]{"message_id"
					, "prev_message_id", "sender_email_id",  "receiver_email_id", "job_id_and_firm_id", "message", "is_read"
					, "is_first_message", "first_message_id", "company_name", "candidate_name", "job_title", "posted_on","subject"
			}, new Object[]{messageId, message.getPrevMessageId(), message.getSenderEmailId(), message.getReceiverEmailId(),
					message.getJobIdAndFirmId(), message.getMessage(), false, message.isFirstMessage(), "null", 
					message.getCompanyName(), message.getCandidateName(), message.getJobTitle(), currentDate.getTime(),message.getMessageSubject()
			});
			cassandraOperations.execute(insertMessage);
		
			logger.info("Initiating new message chain");
		}
		
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	if(message.isFirstMessage()==false){
		
		try{
			
			// Retrieving message_id and first _message_id from previous message 
			String sqlQuery1="Select message_id, is_first_message, first_message_id from message_details where message_id='"+message.getPrevMessageId()+"'";
			
		    MessageDom previousMessage= cassandraOperations.queryForObject(sqlQuery1, new MessageDetailMapperReg1());
		  	
		    
		    //If previous message was first message assign it's message_id as first_message_id of new message else assign first_message_id of previous message to current message
			if(previousMessage.isFirstMessage()==true){
				
				Insert insertMessage = QueryBuilder.insertInto("message_details").values(
						new String[]{"prev_message_id", "message_id", "sender_email_id",  "receiver_email_id", "job_id_and_firm_id", "message", "is_read", "is_first_message", "first_message_id", "company_name", "candidate_name", "job_title", "posted_on","subject"},
						new Object[]{message.getPrevMessageId(), messageId, message.getSenderEmailId(), message.getReceiverEmailId(), message.getJobIdAndFirmId(), message.getMessage(), message.isRead(), message.isFirstMessage(), previousMessage.getMessageId(), message.getCompanyName(), message.getCandidateName(), message.getJobTitle(),currentDate.getTime(),message.getMessageSubject()}
						
						);
				cassandraOperations.execute(insertMessage);
			
			}
			
			
			else {
				
				Insert insertMessage = QueryBuilder.insertInto("message_details").values(
						new String[]{"prev_message_id", "message_id", "sender_email_id",  "receiver_email_id", "job_id_and_firm_id", "message", "is_read", "is_first_message", "first_message_id", "company_name", "candidate_name", "job_title", "posted_on","subject"},
						new Object[]{message.getPrevMessageId(), messageId, message.getSenderEmailId(), message.getReceiverEmailId(), message.getJobIdAndFirmId(), message.getMessage(), message.isRead(), message.isFirstMessage(), previousMessage.getFirstMessageId(), 
								message.getCompanyName(), message.getCandidateName(), message.getJobTitle(), currentDate.getTime(),message.getMessageSubject()});
				
				cassandraOperations.execute(insertMessage);
				
			}
			
			//Updating relay list on generation of first reply to the new message
			if (null==previousMessage.getFirstMessageId()||previousMessage.getFirstMessageId().equalsIgnoreCase("null")){
				
				String insertMessageRelay = "insert into message_relay (message_id, msg_relay_list) values('"+previousMessage.getMessageId()+"', ['"+messageId+"'])";
				cassandraOperations.execute(insertMessageRelay);
				
			}
		
			
			// Updating relay list of first message for subsequent replies
			else{
				
				String query = "update message_relay set msg_relay_list = msg_relay_list + ['"+messageId+"'] where message_id='"+previousMessage.getFirstMessageId()+"'";
				cassandraOperations.execute(query);
					
				
			}
			
		}
		
		catch(Exception e){
			e.printStackTrace();
		}
	
	}
		
	}
	
	
	/**
	 * This method is used to retrieve inbox messages
	 * @param userEmailId
	 * @param userRole
	 * @return List<List<MessageDom>> messageInboxList
	 */
    @SuppressWarnings("unchecked")
	public List<List<MessageDom>> getMessage(String userEmailId, String userRole){
		
		List<List<MessageDom>> messageInboxList = new ArrayList<List<MessageDom>>();
		List<String> messageIdList = new ArrayList<String>();
		List<String> deleteMessageIdList = new ArrayList<String>();
		
		
		  //Retrieve Original Message Ids (First most messages from corporate) for user
		if(userRole.equalsIgnoreCase("ROLE_CORPORATE")){
			
			//Retrieve list of message uuid where is first=true and sendermaild=userEmailId
		   String sqlQuery1="Select message_id from message_details where sender_email_id='"+userEmailId+"' and is_first_message=true ALLOW FILTERING";
			messageIdList = cassandraOperations.queryForList(sqlQuery1, String.class);
			
		
		}
		
		if(userRole.equalsIgnoreCase("ROLE_STUDENT")){
			
 			String sqlQuery="Select message_id from message_details where receiver_email_id='"+userEmailId+"' and is_first_message=true ALLOW FILTERING";
			//Retrieve list of message uuid where is first=true and receivermailid=userEmailId
			 messageIdList =cassandraOperations.queryForList(sqlQuery, String.class);
	
		}
		
		
		 // Retrieve Deleted Message Ids for User
		 
		
		//If delete relay exists for user
		String sqlQuery1="Select count(1) from message_delete where user_email_id='"+userEmailId+"'";
		int deleteMessageCount = Integer.valueOf(cassandraOperations.queryForObject(sqlQuery1,  Long.class).toString());
		
		if(deleteMessageCount!=0){
			
			try {
				//Retrieve deleted message relay
				String sqlQuery2="Select msg_delete_list from message_delete where user_email_id='"+userEmailId+"'";
				deleteMessageIdList = cassandraOperations.queryForObject(sqlQuery2, List.class);
			}
			catch(NullPointerException | IllegalArgumentException ex){
				deleteMessageIdList = new ArrayList<String>();
			}
			
		}
		
		
		//Iterate Original Message Id List to check whether Message Relay Exists for that Id
		List<String>messageIdForInboxQueryList = new ArrayList<String>();
		for(int i = 0; i < messageIdList.size(); i++){
			
			
				
			String messageId=messageIdList.get(i);
			//for each Original Message Id message check relay 
			String sql = "Select count(1) from message_relay where message_id='"+messageId+"'";
			int messageCount = Integer.valueOf(cassandraOperations.queryForObject(sql, Long.class).toString());
			
			//no reply generated for Original Message
			if(messageCount==0){
				
				List<String> messageIdForInboxList = new ArrayList<String>();
				messageIdForInboxList.add(messageId);
					
				MessageDom message = new MessageDom();
				List<MessageDom> messageRelayList=new ArrayList<MessageDom>();
				
				//Deleted message relay exists for user
				if(deleteMessageIdList.size()!=0){
				
				 
					//Current message Not Id is in Deleted Message Relay	
					if(!deleteMessageIdList.contains(messageId)){
						
						String inboxMessageId=messageIdForInboxList.get(0);
						String sql11= "Select message_id, is_first_message, is_read, job_id_and_firm_id, message, posted_on, prev_message_id, receiver_email_id, sender_email_id, job_title, company_name, candidate_name, subject from message_details where message_id='"+inboxMessageId+"'";
						message = cassandraOperations.queryForObject(sql11, new MessageDetailMapperReg());
					
						messageRelayList.add(message);
							
						messageInboxList.add(messageRelayList);
						
					}
					
					else{
						messageIdForInboxList.remove(messageId);
					}
											
			}
				else{
					
					String inboxMessageId=messageIdForInboxList.get(0);
					String sql11= "Select message_id, is_first_message, is_read, job_id_and_firm_id, message, posted_on, prev_message_id, receiver_email_id, sender_email_id, job_title, company_name, candidate_name, subject from message_details where message_id='"+inboxMessageId+"'";
					message = cassandraOperations.queryForObject(sql11, new MessageDetailMapperReg());
					
					messageRelayList.add(message);
					messageInboxList.add(messageRelayList);
				}
		
			}
			
			else{
				
				//Creating InboxList for each relay
				 
				List<String> messageIdForInboxList = new ArrayList<String>();

				//Adding original message id for inbox list
				messageIdForInboxList.add(messageId);
				
				//for each original message uuid retrieve it's corresponding relay of messages
				String sql1 = "select msg_relay_list from message_relay where message_id='"+messageId+"'";
				messageIdForInboxQueryList = cassandraOperations.queryForObject(sql1, List.class);
						
				Iterator<String> itr = messageIdForInboxQueryList.iterator();
			      while(itr.hasNext()) {
			    	    messageIdForInboxList.add(itr.next());
			         
			      }
				
				MessageDom message = new MessageDom();
				List<MessageDom> messageRelayList=new ArrayList<MessageDom>();
				
								
				for(int j = 0; j < messageIdForInboxList.size(); j++){
					
					if(deleteMessageIdList.size()!=0){

						//check deleted messages from inbox list	 
						if(!deleteMessageIdList.contains(messageIdForInboxList.get(j))){
							 
						String inboxMessageId=messageIdForInboxList.get(j);
						String sql11= "Select message_id, is_first_message, is_read, job_id_and_firm_id, message, posted_on, prev_message_id, receiver_email_id, sender_email_id, job_title, company_name, candidate_name, subject from message_details where message_id='"+inboxMessageId+"'";
						message = cassandraOperations.queryForObject(sql11, new MessageDetailMapperReg());
						
						messageRelayList.add(message);
							 
						 }
						 else{
							//remove deleted messages from inbox list
							 messageIdForInboxList.remove(messageIdForInboxList.get(j));
							 
						 }
					}
					 
					 else{
						 String inboxMessageId=messageIdForInboxList.get(j);
							String sql11= "Select message_id, is_first_message, is_read, job_id_and_firm_id, message, posted_on, prev_message_id, receiver_email_id, sender_email_id, job_title, company_name, candidate_name, subject from message_details where message_id='"+inboxMessageId+"'";
							message = cassandraOperations.queryForObject(sql11, new MessageDetailMapperReg()); 
									
							messageRelayList.add(message);
					 }
				}
				if(messageRelayList.size()!=0){
					messageInboxList.add(messageRelayList);
					Collections.reverse(messageRelayList);	
				}
			}
			} 
		
		return messageInboxList;
		
	}
	

	/**
	 * Thismethod is used to delete inbox messages
	 * @param userEmailId
	 * @param deletedMessageList
	 */
	public void deleteMessage(String userEmailId, ArrayList<String> deletedMessageList){
		
	try{
			String sql = "select count(1) from message_delete where user_email_id='"+userEmailId+"'";
			int count = Integer.valueOf(cassandraOperations.queryForObject(sql, Long.class).toString());
			
			if (count==0){
				
				Insert insertIntoMessageDelete = QueryBuilder.insertInto("message_delete").values(new String[]{"user_email_id", "msg_delete_list"}, new Object[]{userEmailId, deletedMessageList});
				cassandraOperations.execute(insertIntoMessageDelete);
			}
			
			else {
				
				for (int i=0; i<deletedMessageList.size(); i++){
					String query = "update message_delete set msg_delete_list = msg_delete_list+ ['"+deletedMessageList.get(i)+"'] where user_email_id='"+userEmailId+"'";
					cassandraOperations.execute(query);
					
				}
			}
		}
		
		catch(Exception e){
			e.printStackTrace();			
		}
	}
	
	/**
	 * This method is used to change status of message to read 
	 * @param readMessageList
	 */
	public void readMessage(ArrayList<String> readMessageList){
		try{
			
			for (String messageId : readMessageList) {

				String query = "update message_details set is_read=true where message_id='"+messageId+"'";
				cassandraOperations.execute(query);
				
			}
		}
		
		catch(Exception e){
			e.printStackTrace();			
		}
	}

}
