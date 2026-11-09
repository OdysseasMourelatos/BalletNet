package balletnet.dao;

import java.util.ArrayList;
import java.util.List;

import balletnet.models.CourseGroup;
import balletnet.models.Student;
import balletnet.models.Syllabus;
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

        int studentIndex = 0;
        for (Student student : students) {
            if (studentIndex < 10) {
                courseGroups.get(0).getStudents().add(student);
            } else {
                courseGroups.get(1).getStudents().add(student);
            }
            studentIndex++;
        }
        
        courseGroups.get(0).getTeachers().add(teachers.get(0)); // Assign first teacher to first group
        courseGroups.get(1).getTeachers().add(teachers.get(0)); // Assign first teacher to second group as well

        courseGroups.get(0).setSyllabus(new Syllabus(
            "SYL-01", "Intermediate Foundation (RAD)", 75.0, 60.0, 50.0, 40.0, 56.0, "Ιδιαίτερη έμφαση στο échappé sur les pointes και στις ισορροπίες στο fondu.", "GRP-01"
        ));
        courseGroups.get(1).setSyllabus(new Syllabus(
            "SYL-02", "Grade 3 Ballet Syllabus", 35.0, 40.0, 20.0, 0.0, 24.0, "Επανάληψη βασικών ασκήσεων μπάρας και προετοιμασία.", "GRP-02"
        ));
    }
}
