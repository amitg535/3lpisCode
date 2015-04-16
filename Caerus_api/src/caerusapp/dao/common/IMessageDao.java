/**
 * 
 */
package caerusapp.dao.common;

import java.util.ArrayList;
import java.util.List;

import caerusapp.domain.common.MessageDom;

/**
 * @author pallavid
 *
 */
public interface IMessageDao {

	/**
	 * This method is used to add a new message
	 * @param message
	 */
	void addMessage(MessageDom message);
	

	/**
	 * This method is used to retrieve inbox messages
	 * @param userEmailId
	 * @param userRole
	 * @return List<List<MessageDom>>
	 */
	List<List<MessageDom>> getMessage(String userEmailId, String userRole);

	/**
	 * This method is used to delete inbox messages
	 * @param userEmailId
	 * @param deletedMessageList
	 */
	void deleteMessage(String userEmailId,ArrayList<String> deletedMessageList);

	/**
	 * This method is used to change status of message to read 
	 * @param readMessageList
	 */
	void readMessage(ArrayList<String> readMessageList);
	
	
}