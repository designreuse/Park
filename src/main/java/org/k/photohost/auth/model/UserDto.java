package org.k.photohost.auth.model;

import org.hibernate.validator.constraints.Email;
import org.k.photohost.validation.PasswordMatches;
import javax.validation.constraints.NotNull;

@PasswordMatches
public class UserDto {

    @NotNull
    private String password;

    @NotNull
    private String confirmPassword;

    @NotNull
    @Email
    private String email;

    public UserDto(){}

    public UserDto(String email, String password) {
        this.password = password;
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}
