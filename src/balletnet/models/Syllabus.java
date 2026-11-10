package balletnet.models;

public class Syllabus {
    private String syllabusID;
    private String title;
    private double barreProgress;
    private double centreProgress;
    private double allegroProgress;
    private double pointeProgress;
    private double completionPercentage;
    private String dailyLog;

    private String groupID;

    public Syllabus(String syllabusID, String title, double barreProgress, double centreProgress, double allegroProgress, double pointeProgress, double completionPercentage, String dailyLog, String groupID) {
        this.syllabusID = syllabusID;
        this.title = title;
        this.barreProgress = barreProgress;
        this.centreProgress = centreProgress;
        this.allegroProgress = allegroProgress;
        this.pointeProgress = pointeProgress;
        this.completionPercentage = completionPercentage;
        this.dailyLog = dailyLog;
        this.groupID = groupID;
    }

    public String getSyllabusID() {
        return syllabusID;
    }

    public void setSyllabusID(String syllabusID) {
        this.syllabusID = syllabusID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public double getBarreProgress() {
        return barreProgress;
    }

    public void setBarreProgress(double barreProgress) {
        this.barreProgress = barreProgress;
    }

    public double getCentreProgress() {
        return centreProgress;
    }

    public void setCentreProgress(double centreProgress) {
        this.centreProgress = centreProgress;
    }

    public double getAllegroProgress() {
        return allegroProgress;
    }

    public void setAllegroProgress(double allegroProgress) {
        this.allegroProgress = allegroProgress;
    }

    public double getPointeProgress() {
        return pointeProgress;
    }

    public void setPointeProgress(double pointeProgress) {
        this.pointeProgress = pointeProgress;
    }

    public double getCompletionPercentage() {
        return completionPercentage;
    }

    public void setCompletionPercentage(double completionPercentage) {
        this.completionPercentage = completionPercentage;
    }

    public String getDailyLog() {
        return dailyLog;
    }

    public void setDailyLog(String dailyLog) {
        this.dailyLog = dailyLog;
    }

    public String getGroupID() {
        return groupID;
    }

    public void setGroupID(String groupID) {
        this.groupID = groupID;
    }

    //Methods as defined in the class diagram
    public double calculateCompletion() {
        return (getBarreProgress() + getCentreProgress() + getAllegroProgress() + getPointeProgress()) / 4;
    }

}