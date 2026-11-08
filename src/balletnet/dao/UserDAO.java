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

        // Mock users according to Ballet Net entity constructor
        List<User> users = new ArrayList<User>();

        users.add(new Secretary(
            "U01", 
            "salexiou", 
            "1111", 
            "Σοφία", 
            "Αλεξίου", 
            "secretariat@balletarts.gr", 
            "SEC-01" // secretaryID
        ));

        users.add(new Secretary(
            "U02", 
            "nkostopoulou", 
            "1112", 
            "Νίκη", 
            "Κωστοπούλου", 
            "niki.kost@balletarts.gr", 
            "SEC-02" // secretaryID
        ));

        users.add(new Teacher(
            "U03", 
            "ekyriakidou", 
            "2222", 
            "Ελένη", 
            "Κυριακίδου", 
            "eleni.kyr@balletarts.gr", 
            "TEA-01", // teacherID
            "RAD Classical Ballet" // specialization
        ));

        users.add(new Teacher(
            "U04", 
            "ddimitriou", 
            "2223", 
            "Δέσποινα", 
            "Δημητρίου", 
            "despina.dim@balletarts.gr", 
            "TEA-02", // teacherID
            "Vaganova & Contemporary Ballet" // specialization
        ));

        users.add(new Student(
            "U05", 
            "mgeorgiou", 
            "3333", 
            "Μαρία", 
            "Γεωργίου", 
            "maria.georgiou@balletarts.gr", 
            "STU-01", // studentID
            17 // age (Integer)
        ));

        users.add(new Student(
            "U06", 
            "ipapadopoulou", 
            "3334", 
            "Ιωάννα", 
            "Παπαδοπούλου", 
            "ioanna.pap@balletarts.gr", 
            "STU-02", // studentID
            16 // age (Integer)
        ));

        return users;
    } // End of getUsers

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