package balletnet.dao;

import java.util.ArrayList;
import java.util.List;

import balletnet.models.*;


/**
 * UserService provides all the necessary methods related to users.
 * In future lesson we will change the code in order to provide data from a Database.
 *  
 * @version 1.0
 */
public class UserDAO {

    /**
	 * This method returns a List with all Users
	 * 
	 * @return List<User>
	 */
	public List<User> getUsers() {

		List<User> users = new ArrayList<User>();
		

        // Mock users according to Ballet Net entity constructor
        users.add(new User(
            "SEC-01", 
            "salexiou", 
            "1111", 
            "Σοφία", 
            "Αλεξίου", 
            "secretariat@balletarts.gr", 
            Role.SECRETARY
        ));

        users.add(new User(
            "TEA-01", 
            "ekyriakidou", 
            "2222", 
            "Ελένη", 
            "Κυριακίδου", 
            "eleni.kyr@balletarts.gr", 
            Role.TEACHER
        ));

        users.add(new User(
            "STU-01", 
            "mgeorgiou", 
            "3333", 
            "Μαρία", 
            "Γεωργίου", 
            "maria.georgiou@balletarts.gr", 
            Role.STUDENT
        ));
		return users;

	} //End of getUsers

    /**
	 * This method is used to authenticate a user.     
	 * 
	 * @param username, String the username
	 * @param password, String the password
	 * @return User, the User Object 
	 * @throws Exception, if the credentials are not valid or an error occurs.
	 */
    public User authenticate(String username, String password) throws Exception {
    
        List<User> users = getUsers();

		for (User user: users) {

			if (user.getUsername().equals(username) && user.getPassword().equals(password)) {
				return user; // credentials are valid, so return the User object
			}

		}
		//credentials are Wrong, so throw an error
		throw new Exception("Wrong username or password");

    } // End of authenticate

    
} //End of class