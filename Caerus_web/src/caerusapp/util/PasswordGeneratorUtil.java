package caerusapp.util;

/**
 * This class is used to generate a password for a newly registered user at Imploy
 * @author KarthikeyanK
 * 
 */
public class PasswordGeneratorUtil {

	/**
	 * This method is used to generate a random new password for a newly registered user at Imploy
	 * @author KarthikeyanK
	 * @return String
	 */
	public static String randomStringGenerator() {

		// Defining the password length
		final int PASSWORD_LENGTH = 8;

		StringBuffer sb = new StringBuffer();

		// Iterating through the length of the password and generating random strings
		for (int x = 0; x < PASSWORD_LENGTH; x++) {

			if (x == 2) {

				sb.append((char) ((int) (Math.random() * 15) + 33));

			} else if (x == 5) {

				sb.append((char) ((int) (Math.random() * 10) + 48));

			} else {

				sb.append((char) ((int) (Math.random() * 26) + 65));

			}
		}
		
		return sb.toString();
	}

}