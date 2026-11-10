package balletnet.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import balletnet.models.CourseGroup;
import balletnet.models.Student;
import balletnet.models.StudentProgress;
import balletnet.models.Teacher;

public class StudentProgressDAO {
    private static final List<StudentProgress> studentsProgress = new ArrayList<>();

    static {
        CourseGroupDAO courseGroupDAO = new CourseGroupDAO();
        List<CourseGroup> courseGroups = courseGroupDAO.getCourseGroups();

        int progressCounter = 1;
        Date defaultEvaluationDate = new Date(System.currentTimeMillis());

        for (CourseGroup group : courseGroups) {
            List<Student> students = group.getEnrolledStudents();
            List<Teacher> teachers = group.getTeachers();
            Teacher primaryTeacher = !teachers.isEmpty() ? teachers.get(0) : null;

            for (Student student : students) {
                String progressID = String.format("PRG-%03d", progressCounter++);
                Double attendanceRate = 70.0;
                String readinessLevel = "Υπό εξέλιξη";
                String personalComments = "";
                boolean isExamReady = false;

                // Στοχευμένα dummy δεδομένα για το πρώτο τμήμα βάσει UI mockup
                if ("GRP-01".equals(group.getGroupID())) {
                    if ("STU-01".equals(student.getStudentID())) { // Μαρία Γεωργίου (#ST-104)
                        attendanceRate = 92.0;
                        readinessLevel = "Προχωρημένη";
                        personalComments = "Εξαιρετική τοποθέτηση κορμού, έτοιμη για την εξέταση.";
                        isExamReady = true;
                    } else if ("STU-02".equals(student.getStudentID())) { // Ιωάννα Παπαδοπούλου (#ST-108)
                        attendanceRate = 72.0;
                        readinessLevel = "Υπό εξέλιξη";
                        personalComments = "Χρειάζεται σταθερότητα στις στροφές και επιπλέον εξάσκηση στο allegro.";
                        isExamReady = false;
                    } else if ("STU-03".equals(student.getStudentID())) { // Χριστίνα Οικονόμου (#ST-112)
                        attendanceRate = 96.0;
                        readinessLevel = "Προχωρημένη";
                        personalComments = "Πολύ καλή τεχνική, έτοιμη για συμμετοχή στις εξετάσεις.";
                        isExamReady = true;
                    }
                }

                studentsProgress.add(new StudentProgress(
                    progressID,
                    attendanceRate,
                    readinessLevel,
                    personalComments,
                    isExamReady,
                    defaultEvaluationDate,
                    student,
                    group,
                    primaryTeacher,
                    null //
                ));
            }
        }
    }
}