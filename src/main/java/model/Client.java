package model;

import java.sql.Date;

public class Client {
    private int id;
    private String email;
    private String fullName;
    private Date birthDate;
    private String address;
    private String city;
    private String gender;
    private String occupation;
    private String deliveryMethod;

    public Client() {}

    public Client(int id, String email, String fullName, Date birthDate, String address, String city, String gender, String occupation, String deliveryMethod) {
        this.id = id;
        this.email = email;
        this.fullName = fullName;
        this.birthDate = birthDate;
        this.address = address;
        this.city = city;
        this.gender = gender;
        this.occupation = occupation;
        this.deliveryMethod = deliveryMethod;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public Date getBirthDate() { return birthDate; }
    public void setBirthDate(Date birthDate) { this.birthDate = birthDate; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public String getOccupation() { return occupation; }
    public void setOccupation(String occupation) { this.occupation = occupation; }
    public String getDeliveryMethod() { return deliveryMethod; }
    public void setDeliveryMethod(String deliveryMethod) { this.deliveryMethod = deliveryMethod; }
}

