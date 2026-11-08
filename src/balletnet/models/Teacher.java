package balletnet.models;

public class Teacher extends User {

    private String teacherID;
    private String specialization;

    public Teacher(String userID, String username, String password, String firstName, String lastName, String email, String teacherID, String specialization) {
        super(userID, username, password, firstName, lastName, email, Role.TEACHER);
        this.teacherID = teacherID;
        this.specialization = specialization;
    }

    public String getTeacherID() { 
        return teacherID; 
    }

    public void setTeacherID(String teacherID) {
        this.teacherID = teacherID; 
    }

    public String getSpecialization() {
        return specialization; 
    }

    public void setSpecialization(String specialization) { 
        this.specialization = specialization; 
    }
}
