package caerusapp.util;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.imageio.stream.FileImageOutputStream;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import com.sun.mail.smtp.SMTPTransport;

/**
 * This class is used to define methods for sending mails to the users
 * @author KarthikeyanK
 * 
 */
@Component
public class MailUtil {
	final static String username = "Admin@imploy.me";
	final static String password = "Quinnox1234";
	
	/**
	 * This method is used to get properties from the message.properties class and set them in senderReceiverProperties
	 * @return
	 * @throws IOException
	 */
	public static Map<String,Properties> getPropertiesMap() throws IOException
	{	
		Properties mailProperty = new Properties();
		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		
		// Getting properties from config.properties
		InputStream str = classLoader.getResourceAsStream("config.properties");
		mailProperty.load(str);

		Properties senderReceiverProperties = new Properties();
		
		// Setting properties in senderReceiverProperties
		senderReceiverProperties.put("mail.smtp.user", mailProperty.getProperty("caerus.mail.from.address"));
		senderReceiverProperties.put("mail.smtp.port", mailProperty.getProperty("caerus.mail.port"));
		senderReceiverProperties.put("mail.smtp.host", mailProperty.getProperty("caerus.mail.host"));
		senderReceiverProperties.put("mail.smtp.auth", "true");
		senderReceiverProperties.put("mail.smtp.starttls.enable", "true");
		senderReceiverProperties.put("mail.smtp.debug", "true");
		
		Map<String,Properties> propertiesMap = new HashMap<String,Properties>();
		propertiesMap.put("mailProperty", mailProperty);
		propertiesMap.put("senderReceiverProperties", senderReceiverProperties);
		
		return propertiesMap;
	}
	/**
	 * This method is used to authenticate a user
	 * @author KarthikeyanK
	 * 
	 */
	private static class SMTPAuthenticator extends javax.mail.Authenticator {

		public PasswordAuthentication getPasswordAuthentication() {

			Properties messageProperty = new Properties();
			ClassLoader classLoader = Thread.currentThread()
					.getContextClassLoader();
			InputStream str = classLoader
					.getResourceAsStream("config.properties");
			String username = "";
			String password = "";
			
			// Exception handling
			try {
				messageProperty.load(str);
				
				// Authenticating user's password and username
				username = messageProperty.getProperty("caerus.mail.username");
				password = messageProperty.getProperty("caerus.mail.password");
			} catch (IOException e) {
				e.printStackTrace();
			}

			return new PasswordAuthentication(username, password);
		}
	}

		
	/**
	 * @author PallaviD
	 * sendMailToUsers can be used as a common mail sending function in future
	 */
	@Async("taskExecutor")
	public void sendMailToUsers(String to, String content, String mailSubject) throws IOException 
	{
		// Getting propertiesMap object
		Map<String, Properties> propertiesMap = getPropertiesMap();

		boolean sessionDebug = false;
		InternetAddress fromAddress = null;
		InternetAddress toAddress = null;
		
		String subject = mailSubject;

		// Exception handling
		try 
		{
			Session mailSession = Session.getInstance(propertiesMap.get("senderReceiverProperties"), new javax.mail.Authenticator() {
				  @Override
				  protected PasswordAuthentication getPasswordAuthentication() {
				  return new PasswordAuthentication(username, password);
				  }});
			MimeMessage simpleMessage = new MimeMessage(mailSession);
			mailSession.setDebug(sessionDebug);
			fromAddress = new InternetAddress(username);
			
			simpleMessage.setFrom(fromAddress);
			toAddress = new InternetAddress(to);
			simpleMessage.setRecipient(Message.RecipientType.TO, toAddress);
			simpleMessage.setSubject(subject);
			simpleMessage.setText(content, "utf-8", "html");
			
			Transport.send(simpleMessage);

						
		} 
		catch (MessagingException e)
		{
			
			e.printStackTrace();
		}
			
	}
	
	/**
	 * This method is used to mail Candidate's Detailed profile.
	 * @author TrishnaR
	 * @param corporateEmailId
	 * @param profileContent
	 * @param subject
	 * @throws IOException
	 */
	@Async
	public void sendCandidateProfile(String corporateEmailId,Map<String, Object> profileContent, String subject) throws IOException {
		
		// Getting propertiesMap object
				Map<String, Properties> propertiesMap = getPropertiesMap();
				
				boolean sessionDebug = false;
				InternetAddress fromAddress = null;
				InternetAddress toAddress = null;
				
				String text = (String) propertiesMap.get("mailProperty").get("caerus.mail.message");

				// Exception handling
				try {
					Authenticator auth = new SMTPAuthenticator();
					Session mailSession = Session.getInstance(propertiesMap.get("senderReceiverProperties"), auth);
					Message simpleMessage = new MimeMessage(mailSession);
					mailSession.setDebug(sessionDebug);
					fromAddress = new InternetAddress((String) propertiesMap.get("senderReceiverProperties").get("mail.smtp.user"));
					simpleMessage.setFrom(fromAddress);
					toAddress = new InternetAddress(corporateEmailId);
					simpleMessage.setRecipient(Message.RecipientType.TO, toAddress);
					simpleMessage.setSubject(subject);
							
					// Setting the content of the mail
					String textContent = profileContent.get("textContent").toString();
					String contextPath = profileContent.get("contextPath").toString(); 
					
					byte[] imageContent = (byte[]) profileContent.get("imageContent");
					String cid=profileContent.get("cid").toString();
					 
					 File f=new File(contextPath+"image.jpeg");
			         FileImageOutputStream fos = new FileImageOutputStream(f);
			         fos.write(imageContent);
			         fos.close();
			         MimeMultipart multipart = new MimeMultipart("related");
			         
					    // HTML part
					    MimeBodyPart textPart = new MimeBodyPart();
					    textPart.setText(textContent, "US-ASCII", "html");
					    multipart.addBodyPart(textPart);

					    // Image part
					    MimeBodyPart imagePart = new MimeBodyPart();
					    imagePart.attachFile(f);
					    imagePart.setContentID("<" + cid + ">");
					    imagePart.setDisposition(MimeBodyPart.INLINE);
					    multipart.addBodyPart(imagePart);
					    
			         simpleMessage.getDisposition();
			         simpleMessage.setContent(multipart);
			         
					SMTPTransport t = (SMTPTransport) mailSession.getTransport("smtp");
					
					// Setting the host, username and password
					t.connect((String) propertiesMap.get("senderReceiverProperties").get("mail.smtp.host"), (String) propertiesMap.get("mailProperty").get("caerus.mail.username"), (String) propertiesMap.get("mailProperty").get("caerus.mail.password"));
					SMTPTransport.send(simpleMessage);
								
					f.delete();
					
				} catch (MessagingException e) {
					
					e.printStackTrace();
				}
			
			}
	
	
	
	}
	