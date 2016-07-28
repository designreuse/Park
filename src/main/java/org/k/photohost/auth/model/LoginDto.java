package org.k.photohost.auth.model;

import org.hibernate.validator.constraints.Email;

import javax.validation.constraints.NotNull;

public class LoginDto {

    @NotNull
    @Email
    private String email;

    @NotNull
    private String password;

    public LoginDto() {
    }

    public LoginDto(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
