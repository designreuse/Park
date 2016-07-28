package org.k.photohost.auth.model;

import javax.persistence.*;

@Entity
@Table(name = "user_roles", catalog = "auth", uniqueConstraints = @UniqueConstraint(columnNames = {"role", "email"}))
public class UserRole {

    @Id
    @Column(name = "user_role_id", unique = true, nullable = false)
    @GeneratedValue
    private int userRoleId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "email", nullable = false)
    private User user;

    @Column(nullable = false)
    private String role;

    public UserRole(){}

    public UserRole(User user, String role) {
        this.user = user;
        this.role = role;
    }

    public int getUserRoleId() {
        return userRoleId;
    }

    public User getUser() {
        return user;
    }

    public String getRole() {
        return role;
    }

    public void setUserRoleId(int userRoleId) {
        this.userRoleId = userRoleId;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public int hashCode() {
        int result = userRoleId;
        result = 31 * result + role.hashCode();
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == this) return true;
        if (obj == null || obj.getClass() != this.getClass()) return false;

        UserRole userRole = (UserRole) obj;

        if (userRoleId != userRole.userRoleId) return false;
        return role.equals(userRole.role);
    }

    @Override
    public String toString() {
        return "{UserRole{" +
                "userRoleId=" + userRoleId +
                ", role='" + role + "'" +
                "}";
    }
}
