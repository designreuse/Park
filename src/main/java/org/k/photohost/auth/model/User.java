package org.k.photohost.auth.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "users", catalog = "auth")
public class User {

    @Column(nullable = false, length = 60)
    private String password;

    @Column(nullable = false)
    private boolean verified;

    @Id
    @Column(nullable = false, unique = true, length = 50)
    private String email;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    private Set<UserRole> userRoles = new HashSet<>(0);

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    private Set<Photo> photos = new HashSet<>(0);

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    private Set<Album> albums = new HashSet<>(0);

    public User(){}

    public User(String email, String password, boolean verified, Set<UserRole> userRoles) {
        this.password = password;
        this.email = email;
        this.verified = verified;
        this.userRoles = userRoles;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public boolean isVerified() {
        return verified;
    }

    public Set<UserRole> getUserRoles() {
        return userRoles;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setVerified(boolean verified) {
        this.verified = verified;
    }

    public void setUserRoles(Set<UserRole> userRoles) {
        this.userRoles = userRoles;
    }

    @Override
    public boolean equals(Object obj) {
        if(this == obj) return true;
        if(obj == null || this.getClass() != obj.getClass()) return false;

        User user = (User) obj;

        if(verified != user.verified) return false;
        if(!password.equals(user.password)) return false;
        if(!email.equals(user.email)) return false;
        return userRoles.equals(user.userRoles);
    }

    @Override
    public int hashCode() {
        int result = email.hashCode();
        result = 31 * result + password.hashCode();
        result = 31 * result + (verified ? 1 : 0);
        result = 31 * result + userRoles.hashCode();
        return result;
    }

    @Override
    public String toString() {
        return "User{" +
                "email='" + email + "'" +
                ", password='" + password + "'" +
                ", verified=" + verified +
                ", userRoles=" + userRoles + "}";
    }
}
