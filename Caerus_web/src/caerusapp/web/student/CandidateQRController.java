package caerusapp.web.student;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.glxn.qrgen.QRCode;
import net.glxn.qrgen.image.ImageType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;

@Controller
public class CandidateQRController {

	@Autowired
	IStudentManager studentManager;
	
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_QRCODE)
	void showQRCode(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String serverName = request.getServerName();
		int serverPort = request.getServerPort();
		String emailId = request.getParameter("emailId");

		String url = "http://" + serverName + ":" + serverPort+ "/candidate_detail_view_qrCode.htm?studentEmailId=".concat(emailId);

		//QRCode To PNG
		ByteArrayOutputStream out = QRCode.from(url).to(ImageType.PNG).withSize(200, 200).stream();

		response.setContentType("image/png");
		response.setContentLength(out.size());

		byte[] bytes = out.toByteArray();

		InputStream qrcodeImage = new ByteArrayInputStream(bytes);

		// Storing The QR code in database
		studentManager.uploadQRCodeImage(qrcodeImage, emailId);

		OutputStream outputStream = null;
		try {
			outputStream = response.getOutputStream();
			outputStream.write(out.toByteArray());
			outputStream.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		finally {
			outputStream.close();
		}

		}
	}
	

