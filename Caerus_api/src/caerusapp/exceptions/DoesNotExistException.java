package caerusapp.exceptions;

public class DoesNotExistException extends RuntimeException{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1000089621552579248L;
	
	private String message;

	public DoesNotExistException() {
	}
	
	public DoesNotExistException(String message) {
		this.message=message;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message.toString();
	}

	
}