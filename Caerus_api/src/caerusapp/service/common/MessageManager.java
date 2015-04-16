/**
 * 
 */
package caerusapp.service.common;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import caerusapp.dao.common.IMessageDao;
import caerusapp.domain.common.MessageDom;

/**
 * @author pallavid
 *
 */
public class MessageManager implements IMessageManager{

	@Autowired
	private IMessageDao messageDao;
	
	private static final long serialVersionUID = 1L;

	/**
	 * This method is used to add a new message
	 * @param message
	 */
	@Override
	public void addMessage(MessageDom message) {
		
		messageDao.addMessage(message);
	}

	
	/**
	 * This method is used to retrieve inbox messages
	 * @param userEmailId
	 * @param userRole
	 * @return List<List<MessageDom>>
	 */
	@Override
	public List<List<MessageDom>> getMessage(String userEmailId, String userRole) {
		
		return messageDao.getMessage(userEmailId,userRole);
	}
	
	/**
	 * This method is used to delete inbox messages
	 * @param userEmailId
	 * @param deletedMessageList
	 */
	@Override
	public void deleteMessage(String userEmailId,ArrayList<String> deletedMessageList) {
		messageDao.deleteMessage(userEmailId, deletedMessageList);
		
	}
	
	/**
	 *  This method is used to change status of message to read 
	 * @param readMessageList
	 */
	@Override
	public void readMessage(ArrayList<String> readMessageList) {
		messageDao.readMessage(readMessageList);
		
	}

	/**
	 * @return the messageDao
	 */
	public IMessageDao getMessageDao() {
		return messageDao;
	}
 
	/**
	 * 
	 * @param messageDao
	 */
	public void setMessageDao(IMessageDao messageDao) {
		this.messageDao = messageDao;
	}


}