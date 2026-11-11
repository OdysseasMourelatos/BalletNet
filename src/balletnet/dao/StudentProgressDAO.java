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

            int indexInGroup = 0;
            for (Student student : students) {
                String progressID = String.format("PRG-%03d", progressCounter++);
                Double attendanceRate = 75.0;
                String readinessLevel = "Υπό εξέλιξη";
                String personalComments = "";
                boolean isExamReady = false;

                if ("GRP-01".equals(group.getGroupID())) {
                    // Intermediate Foundation (RAD) - 10 μαθήτριες (5/10 Exam Ready)
                    switch (indexInGroup) {
                        case 0: // Μαρία Γεωργίου (#ST-104)
                            attendanceRate = 92.0;
                            readinessLevel = "Προχωρημένη";
                            personalComments = "Εξαιρετική τοποθέτηση κορμού, έτοιμη για την εξέταση.";
                            isExamReady = true;
                            break;
                        case 1: // Ιωάννα Παπαδοπούλου (#ST-108)
                            attendanceRate = 72.0;
                            readinessLevel = "Υπό εξέλιξη";
                            personalComments = "Χρειάζεται σταθερότητα στις στροφές και επιπλέον εξάσκηση στο allegro.";
                            isExamReady = false;
                            break;
                        case 2: // Χριστίνα Οικονόμου (#ST-112)
                            attendanceRate = 96.0;
                            readinessLevel = "Προχωρημένη";
                            personalComments = "Άψογη τεχνική σε pirouettes και pointe work, έτοιμη για συμμετοχή στις εξετάσεις.";
                            isExamReady = true;
                            break;
                        case 3:
                            attendanceRate = 88.0;
                            readinessLevel = "Προχωρημένη";
                            personalComments = "Πολύ καλή μουσικότητα και ακρίβεια στις ασκήσεις μπάρας.";
                            isExamReady = true;
                            break;
                        case 4:
                            attendanceRate = 68.0;
                            readinessLevel = "Υπό εξέλιξη";
                            personalComments = "Χρειάζεται ενδυνάμωση στους αστραγάλους για ασφαλή στήριξη στις pointe.";
                            isExamReady = false;
                            break;
                        case 5:
                            attendanceRate = 92.0;
                            readinessLevel = "Προχωρημένη";
                            personalComments = "Σταθερές ισορροπίες στο fondu και εξαιρετική έκφραση στο adagio.";
                            isExamReady = true;
                            break;
                        case 6:
                            attendanceRate = 64.0;
                            readinessLevel = "Αρχάρια";
                            personalComments = "Απουσίες που επηρέασαν την αφομοίωση των enchaînements.";
                            isExamReady = false;
                            break;
                        case 7:
                            attendanceRate = 84.0;
                            readinessLevel = "Υπό εξέλιξη";
                            personalComments = "Συνεχής πρόοδος, να δοθεί έμφαση στην ταχύτητα του petit allegro.";
                            isExamReady = false;
                            break;
                        case 8:
                            attendanceRate = 90.0;
                            readinessLevel = "Προχωρημένη";
                            personalComments = "Πλήρης ετοιμότητα και συνέπεια στην παρακολούθηση της ύλης.";
                            isExamReady = true;
                            break;
                        case 9:
                            attendanceRate = 76.0;
                            readinessLevel = "Υπό εξέλιξη";
                            personalComments = "Καλή διάθεση, απαιτείται επανάληψη στις θέσεις των χεριών (port de bras).";
                            isExamReady = false;
                            break;
                    }
                } else if ("GRP-02".equals(group.getGroupID())) {
                    // Grade 3 Ballet (RAD) - 7 μαθήτριες (3/7 Exam Ready)
                    switch (indexInGroup) {
                        case 0:
                            attendanceRate = 90.0;
                            readinessLevel = "Προχωρημένη";
                            personalComments = "Σωστή στάση σώματος και καθαρό battement tendu.";
                            isExamReady = true;
                            break;
                        case 1:
                            attendanceRate = 85.0;
                            readinessLevel = "Προχωρημένη";
                            personalComments = "Πολύ καλός ρυθμός και ευλυγισία, έτοιμη για την εξέταση.";
                            isExamReady = true;
                            break;
                        case 2:
                            attendanceRate = 70.0;
                            readinessLevel = "Υπό εξέλιξη";
                            personalComments = "Χρειάζεται επανάληψη στις βασικές ασκήσεις κέντρου.";
                            isExamReady = false;
                            break;
                        case 3:
                            attendanceRate = 88.0;
                            readinessLevel = "Προχωρημένη";
                            personalComments = "Εξαιρετική παρουσία και πειθαρχία στην τάξη.";
                            isExamReady = true;
                            break;
                        case 4:
                            attendanceRate = 65.0;
                            readinessLevel = "Υπό εξέλιξη";
                            personalComments = "Αρκετές απουσίες, να εντατικοποιηθεί η εξάσκηση στα άλματα.";
                            isExamReady = false;
                            break;
                        case 5:
                            attendanceRate = 75.0;
                            readinessLevel = "Υπό εξέλιξη";
                            personalComments = "Βελτιώνεται σταθερά, χρειάζεται λίγο χρόνο ακόμα για τεχνική ωριμότητα.";
                            isExamReady = false;
                            break;
                        case 6:
                            attendanceRate = 80.0;
                            readinessLevel = "Υπό εξέλιξη";
                            personalComments = "Καλή αντίληψη του χώρου, να δουλευτεί το stretching.";
                            isExamReady = false;
                            break;
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
                    null
                ));

                indexInGroup++;
            }
        }
    }

    public List<StudentProgress> getStudentsProgress() {
        return studentsProgress;
    }

    public List<StudentProgress> getStudentsProgressByCourse(CourseGroup courseGroup) {
        List<StudentProgress> courseStudentsProgress = new ArrayList<>();
        if (courseGroup == null) {
            return courseStudentsProgress;
        }
        for (StudentProgress studentProgress : studentsProgress) {
            if (studentProgress.getCourseGroup() != null && 
                studentProgress.getCourseGroup().getGroupID().equals(courseGroup.getGroupID())) {
                courseStudentsProgress.add(studentProgress);
            }
        }
        return courseStudentsProgress;
    }

    public int getNumberOfStudentsReadyForExam(CourseGroup courseGroup) {
        int totalReady = 0;
        if (courseGroup == null) {
            return totalReady;
        }
        for (StudentProgress sp : getStudentsProgressByCourse(courseGroup)) {
            if (sp.isExamReady()) {
                totalReady++;
            }
        }
        return totalReady;
    }
}