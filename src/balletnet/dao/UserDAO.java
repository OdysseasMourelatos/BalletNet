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

    private static final List<User> users = new ArrayList<>();

    static {
        // --- 1. Γραμματεία ---
        users.add(new Secretary(
            "U01", "salexiou", "1111", 
            "Σοφία", "Αλεξίου", "secretariat@balletarts.gr", 
            "SEC-01"
        ));
        users.add(new Secretary(
            "U02", "nkostopoulou", "1112", 
            "Νίκη", "Κωστοπούλου", "niki.kost@balletarts.gr", 
            "SEC-02"
        ));

        // --- 2. Δασκάλες ---
        users.add(new Teacher(
            "U03", "ekyriakidou", "2222", 
            "Ελένη", "Κυριακίδου", "eleni.kyr@balletarts.gr", 
            "TEA-01", "RAD Classical Ballet"
        ));
        users.add(new Teacher(
            "U04", "ddimitriou", "2223", 
            "Δέσποινα", "Δημητρίου", "despina.dim@balletarts.gr", 
            "TEA-02", "Vaganova & Contemporary Ballet"
        ));

        // --- 3. Οι 3 Επώνυμες Μαθήτριες (που εμφανίζονται στα UIs & Modals) ---
        users.add(new Student(
            "U05", "mgeorgiou", "3333", 
            "Μαρία", "Γεωργίου", "maria.georgiou@balletarts.gr", 
            "STU-01", 17
        ));
        users.add(new Student(
            "U06", "ipapadopoulou", "3334", 
            "Ιωάννα", "Παπαδοπούλου", "ioanna.pap@balletarts.gr", 
            "STU-02", 16
        ));
        users.add(new Student(
            "U07", "coikonomou", "3335", 
            "Χριστίνα", "Οικονόμου", "christina.oik@balletarts.gr", 
            "STU-03", 16
        ));

        // --- 4. Υπόλοιπες 14 Μαθήτριες (Σύνολο 17) ---
        String[] firstNames = {
            "Άννα", "Κατερίνα", "Ευαγγελία", "Δανάη", "Μελίνα", 
            "Νεφέλη", "Αλεξάνδρα", "Λυδία", "Ηλιάνα", "Βασιλική", 
            "Κωνσταντίνα", "Ζωή", "Μαρίνα", "Άρτεμις"
        };
        String[] lastNames = {
            "Βασιλείου", "Δημοπούλου", "Νικολάου", "Σταματίου", "Μακρή", 
            "Αθανασιάδη", "Αντωνίου", "Κωνσταντίνου", "Παναγοπούλου", "Μιχαηλίδη", 
            "Θεοδώρου", "Σπυροπούλου", "Ράπτη", "Καρρά"
        };

        for (int i = 0; i < 14; i++) {
            int num = i + 4; // STU-04 έως STU-17
            String stuId = String.format("STU-%02d", num);
            String uId = String.format("U%02d", i + 8);
            String username = "student" + num;
            String email = "student" + num + "@balletarts.gr";
            users.add(new Student(uId, username, "3333", firstNames[i], lastNames[i], email, stuId, 15 + (i % 3)));
        }
    }

    /**
     * This method returns a List with all Users
     * 
     * @return List<User>
     */
    public List<User> getUsers() {
        return users;
    }

    /**
	 * This method is used to authenticate a user.     
	 * 
	 * @param username, String the username
	 * @param password, String the password
	 * @return User, the User Object 
	 * @throws Exception, if the credentials are not valid or an error occurs.
	 */
    public User authenticate(String username, String password) throws Exception {

		for (User user: users) {

			if (user.getUsername().equals(username) && user.getPassword().equals(password)) {
				return user; // credentials are valid, so return the User object
			}

		}
		//credentials are Wrong, so throw an error
		throw new Exception("Wrong username or password");

    } // End of authenticate

    /**
     * This method returns a List with all Students
     * 
     * @return List<Student>
     */
    public List<Student> getStudents() {
        List<Student> students = new ArrayList<>();
        for (User user : users) {
            if (user instanceof Student) {
                students.add((Student) user);
            }
        }
        return students;
    }

    /**
     * This method returns a List with all Teachers
     * 
     * @return List<Teacher>
     */
    public List<Teacher> getTeachers() {
        List<Teacher> teachers = new ArrayList<>();
        for (User user : users) {
            if (user instanceof Teacher) {
                teachers.add((Teacher) user);
            }
        }
        return teachers;
    }

} //End of class