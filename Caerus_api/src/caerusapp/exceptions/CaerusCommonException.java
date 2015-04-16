package caerusapp.exceptions;

public class CaerusCommonException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1365925642920295799L;
	
	
	private String message;

	public CaerusCommonException() {
	}

	public CaerusCommonException(String message) {
		this.message = message;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message.toString();
	}

}