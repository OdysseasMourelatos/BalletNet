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
        courseGroups.add(new CourseGroup("GRP-01", "Intermediate Foundation(RAD)", 12, new ArrayList<>(), new ArrayList<>(), null));
        courseGroups.add(new CourseGroup("GRP-02", "Grade 3 Ballet (RAD)", 15, new ArrayList<>(), new ArrayList<>(), null));

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
        
        courseGroups.get(0).getTeachers().add(teachers.get(0));
        courseGroups.get(1).getTeachers().add(teachers.get(0));

        courseGroups.get(0).setSyllabus(new Syllabus(
            "SYL-01", "Intermediate Foundation (RAD)", 75.0, 60.0, 50.0, 40.0, 56.0, "Ιδιαίτερη έμφαση στο échappé sur les pointes και στις ισορροπίες στο fondu.", "GRP-01"
        ));
        courseGroups.get(1).setSyllabus(new Syllabus(
            "SYL-02", "Grade 3 Ballet Syllabus", 35.0, 40.0, 20.0, 0.0, 24.0, "Επανάληψη βασικών ασκήσεων μπάρας και προετοιμασία.", "GRP-02"
        ));
    }

    public List<CourseGroup> getCourseGroups() {
        return courseGroups;
    }

    public List<CourseGroup> getCourseGroupsByTeacher(Teacher teacher) {
        List<CourseGroup> groups = new ArrayList<>();
        for (CourseGroup courseGroup: courseGroups) {
            List<Teacher> teachers = courseGroup.getTeachers();
            for (Teacher t: teachers) {
                if (t.getTeacherID().equals(teacher.getTeacherID())) {
                    groups.add(courseGroup);
                    break;
                }
            }
        }
        return groups;
    }

    public static void main(String[] args) {
        List<CourseGroup> groups = new ArrayList<>();
        for (CourseGroup courseGroup: courseGroups) {
            List<Teacher> teachers = courseGroup.getTeachers();
            for (Teacher t: teachers) {
                if (t.getTeacherID().equals("TEA-01")) {
                    groups.add(courseGroup);
                    break;
                }
            }
        }
        for (CourseGroup group : groups) {
            System.out.println(group.getLevel());
        }
    }
}
