
package caerusapp.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.command.common.MessageCom;
import caerusapp.domain.common.MessageDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.common.MessageManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusStringConstants;
/**
 * This class is used to implement corporate-candidate message system functions
 * @author PallaviD
 *
 */

@Controller
public class CommonUtilController {
	
	@Autowired
	MessageManager messageManager;
	
	@Autowired
	IStudentManager studentManager;
	
	
	/**
	 * This method is used to add a new message 
	 * @param requestMessage
	 * @param httpServletRequest
	 * @return
	 */
	 @RequestMapping(method = RequestMethod.POST, value=CaerusAnnotationURLConstants.SEND_MESSAGE)
	 @ResponseBody
	 public void AddMessage(@RequestBody MessageCom requestMessage, HttpServletRequest httpServletRequest){
		
		 //Spring security authentication containing the logged in user details
		 Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		 String senderEmailId =  auth.getName(); //get logged in Email ID
		 
		 //Creating a domain object
		 MessageDom message =new MessageDom();
		
		 try {
			 
			 if(null!=requestMessage.getIsFirstMessage()&&requestMessage.getIsFirstMessage().equalsIgnoreCase("true"))
				 message.setFirstMessage(true);
			 	else  message.setFirstMessage(false);
			 
			
			 if(null!=requestMessage.getRead()&&requestMessage.getRead().equalsIgnoreCase("true"))
				 message.setRead(true);
				 else  message.setRead(false);
			 
			 message.setReceiverEmailId(requestMessage.getReceiverEmailId());
			 message.setSenderEmailId(senderEmailId);
			 message.setJobIdAndFirmId(requestMessage.getJobIdAndFirmId());
			 message.setMessage(requestMessage.getMessage());
			 message.setPrevMessageId(requestMessage.getPrevMessageId());
			 message.setCandidateName(requestMessage.getCandidateName());
			 message.setCompanyName(requestMessage.getCompanyName());
			 message.setJobTitle(requestMessage.getJobTitle());
			 
			 messageManager.addMessage(message);
		 }
		 catch(Exception e){
			 e.printStackTrace();
		 }
		 
	 }
	 
	 /**
	  * This method is used to retrieve inbox for corporate/candidate
	  * @return modelAndView
	  */
	 @RequestMapping(method = RequestMethod.GET, value=CaerusAnnotationURLConstants.MESSAGE_INBOX)
	 @ResponseBody
	 public ModelAndView getInbox(){
		 
	   //Spring security authentication containing the logged in user details
	   Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	   String userEmailId =  auth.getName(); //get logged in Email ID
		 
	   String authority = auth.getAuthorities().toString();
	   authority = authority.replace("[", "").replace("]", "");
		 
		ModelAndView modelAndView = new ModelAndView("common/user_message_inbox");
		List<List<MessageDom>> messageInboxList = messageManager.getMessage(userEmailId,authority);
		
		int i = 0;
		
		StudentDom studentDom = new StudentDom();
		
		for (List<MessageDom> messageDetails : messageInboxList) {
			
			if(authority.equals("ROLE_CORPORATE"))
			{
				if(userEmailId.equals(messageDetails.get(i).getReceiverEmailId()))
				{
					studentDom = studentManager.getDetailsByEmailId(messageDetails.get(i).getSenderEmailId());
				}
				else
				{
					studentDom = studentManager.getDetailsByEmailId(messageDetails.get(i).getReceiverEmailId());
				}
				
			}
			
			messageDetails.get(i).setPhotoName(studentDom.getPhotoName());
			
		}
		
		modelAndView.addObject("dateFormat",CaerusStringConstants.STANDARD_DATE_FORMAT);
		
		modelAndView.addObject("messageInboxList",messageInboxList);
		modelAndView.addObject("messageInboxListSize",messageInboxList.size());
		
		return modelAndView;
		 
	 }
	 
		@RequestMapping(method = RequestMethod.POST, value=CaerusAnnotationURLConstants.DELETE_MESSAGE)
		@ResponseBody
		public void deleteMessage(@RequestBody ArrayList<String> deletedMessageList, HttpServletRequest request, HttpServletResponse httpServletResponse) throws ServletException, IOException 
		{
			//Spring security authentication containing the logged in user details
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String userEmailId = auth.getName();
			       
	        messageManager.deleteMessage(userEmailId, deletedMessageList);
					
		}
		
		@RequestMapping(method = RequestMethod.POST, value=CaerusAnnotationURLConstants.READ_MESSAGE)
		@ResponseBody
		public void readMessage(@RequestBody Map<String,String> readMessageMap, HttpServletRequest request, HttpServletResponse httpServletResponse) throws ServletException, IOException 
		{
			//Spring security authentication containing the logged in user details
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String userEmailId = auth.getName();
			
			ArrayList<String> readMessageList = new ArrayList<String>();
			
			//Exclude messages where logged in user is not a message receiver
			Iterator<Map.Entry<String,String>> iter = readMessageMap.entrySet().iterator();
			while (iter.hasNext()) {
			    Map.Entry<String,String> entry = iter.next();
			    if(!userEmailId.equalsIgnoreCase(entry.getValue())){
			        iter.remove();
			    }
			    else {
			    	readMessageList.add(entry.getKey());
			    }
			}
			
			try {
				if(readMessageList.size() != 0){
					messageManager.readMessage(readMessageList);
					HttpSession session =request.getSession();
					long currentUnreadMessageCount =  Long.parseLong(session.getAttribute("newMessageCount").toString());
					if(currentUnreadMessageCount != 0) {
						session.setAttribute("newMessageCount", currentUnreadMessageCount-1);	
					}
					
				}
				
				
			}
			
			catch(Exception e){
				
				e.printStackTrace();
			}
			
			
			
		}

	/**
	 * 
	 * @return messageManager
	 */
	public MessageManager getMessageManager() {
		return messageManager;
	}

	/**
	 * 
	 * @param messageManager
	 */
	public void setMessageManager(MessageManager messageManager) {
		this.messageManager = messageManager;
	}

}
