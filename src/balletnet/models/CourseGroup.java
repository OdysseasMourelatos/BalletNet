package balletnet.models;

import java.util.List;

public class CourseGroup {
    private String groupID;
    private String level;
    private int capacity;
    
    private List<Student> students;
    private List<Teacher> teachers;
    private Syllabus syllabus;

    public CourseGroup(String groupID, String level, int capacity, List<Student> students, List<Teacher> teachers, Syllabus syllabus) {
        this.groupID = groupID;
        this.level = level;
        this.capacity = capacity;
        this.students = students;
        this.teachers = teachers;
        this.syllabus = syllabus;
    }

    public String getGroupID() {
        return groupID;
    }

    public void setGroupID(String groupID) {
        this.groupID = groupID;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public List<Student> getStudents() {
        return students;
    }

    public void setStudents(List<Student> students) {
        this.students = students;
    }

    public List<Teacher> getTeachers() {
        return teachers;
    }

    public void setTeachers(List<Teacher> teachers) {
        this.teachers = teachers;
    }

    public Syllabus getSyllabus() {
        return syllabus;
    }

    public void setSyllabus(Syllabus syllabus) {
        this.syllabus = syllabus;
    }
}