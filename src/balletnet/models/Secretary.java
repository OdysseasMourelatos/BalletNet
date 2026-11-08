package balletnet.models;

public class Secretary extends User {

    private String secretaryID;

    public Secretary(String userID, String username, String password, String firstName, String lastName, String email, String secretaryID) {
        super(userID, username, password, firstName, lastName, email, Role.SECRETARY);
        this.secretaryID = secretaryID;
    }

    public String getSecretaryID() { 
        return secretaryID; 
    }

    public void setSecretaryID(String secretaryID) {
        this.secretaryID = secretaryID; 
    }
}