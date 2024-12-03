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

    // Getters và Setters
}
