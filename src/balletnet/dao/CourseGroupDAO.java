package balletnet.dao;

import java.util.ArrayList;
import java.util.List;

import balletnet.models.CourseGroup;
import balletnet.models.Student;
import balletnet.models.Teacher;

public class CourseGroupDAO {
    private static final List<CourseGroup> courseGroups = new ArrayList<>();

    static {
        courseGroups.add(new CourseGroup(
            "GRP-01", "Intermediate Foundation(RAD)", 12, 
            new ArrayList<>(), // Students will be added later
            new ArrayList<>(), // Teachers will be added later
            null // Syllabus will be added later
        ));
        courseGroups.add(new CourseGroup(
            "GRP-02", "Grade 3 Ballet (RAD)", 15, 
            new ArrayList<>(), // Students will be added later
            new ArrayList<>(), // Teachers will be added later
            null // Syllabus will be added later
        ));
    }
    
    public List<CourseGroup> getCourseGroups() {
        return courseGroups;
    }
    
    public void fillCourseGroupDetails() {
        UserDAO userDAO = new UserDAO();
        List<Student> students = userDAO.getStudents();
        List<Teacher> teachers = userDAO.getTeachers();

        for (Student student : students) {
            System.out.println("Student: " + student.getUsername() + ", Age: " + student.getAge());
        }
    }

    public static void main(String[] args) {
        CourseGroupDAO dao = new CourseGroupDAO();
        dao.fillCourseGroupDetails();
    }
}
