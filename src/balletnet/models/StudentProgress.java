package balletnet.models;

import java.sql.Date;

public class StudentProgress {
    private String progressID;
    private Double attendanceRate;
    private String readinessLevel;
    private String personalComments;
    private boolean isExamReady;
    private Date evaluationDate;

    private Student student;
    private CourseGroup courseGroup;
    private Teacher teacher;
    private ExamSession examSession;

    public StudentProgress(String progressID, Double attendanceRate, String readinessLevel, 
                           String personalComments, boolean isExamReady, Date evaluationDate, 
                           Student student, CourseGroup courseGroup, Teacher teacher, ExamSession examSession) {
        this.progressID = progressID;
        this.attendanceRate = attendanceRate;
        this.readinessLevel = readinessLevel;
        this.personalComments = personalComments;
        this.isExamReady = isExamReady;
        this.evaluationDate = evaluationDate;
        this.student = student;
        this.courseGroup = courseGroup;
        this.teacher = teacher;
        this.examSession = examSession;
    }

    public String getProgressID() {
        return progressID;
    }

    public void setProgressID(String progressID) {
        this.progressID = progressID;
    }

    public Double getAttendanceRate() {
        return attendanceRate;
    }

    public void setAttendanceRate(Double attendanceRate) {
        this.attendanceRate = attendanceRate;
    }

    public String getReadinessLevel() {
        return readinessLevel;
    }

    public void setReadinessLevel(String readinessLevel) {
        this.readinessLevel = readinessLevel;
    }

    public String getPersonalComments() {
        return personalComments;
    }

    public void setPersonalComments(String personalComments) {
        this.personalComments = personalComments;
    }

    public boolean isExamReady() {
        return isExamReady;
    }

    public void setExamReady(boolean isExamReady) {
        this.isExamReady = isExamReady;
    }

    public Date getEvaluationDate() {
        return evaluationDate;
    }

    public void setEvaluationDate(Date evaluationDate) {
        this.evaluationDate = evaluationDate;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public CourseGroup getCourseGroup() {
        return courseGroup;
    }

    public void setCourseGroup(CourseGroup courseGroup) {
        this.courseGroup = courseGroup;
    }

    public Teacher getTeacher() {
        return teacher;
    }

    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }

    public ExamSession getExamSession() {
        return examSession;
    }

    public void setExamSession(ExamSession examSession) {
        this.examSession = examSession;
    }
}