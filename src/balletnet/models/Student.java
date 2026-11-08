package balletnet.models;

public class Student extends User {
    private String studentID;
    private int age;

    public Student(String userID, String username, String password, 
                   String firstName, String lastName, String email, 
                   String studentID, int age) {
        super(userID, username, password, firstName, lastName, email, Role.STUDENT);
        this.studentID = studentID;
        this.age = age;
    }

    public String getStudentID() { 
        return studentID; 
    }

    public void setStudentID(String studentID) {
        this.studentID = studentID; 
    }

    public int getAge() {
        return age; 
    }

    public void setAge(int age) { 
        this.age = age; 
    }
}
