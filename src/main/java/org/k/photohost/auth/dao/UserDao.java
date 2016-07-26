package org.k.photohost.auth.dao;

import org.k.photohost.auth.model.Photo;
import org.k.photohost.auth.model.User;
import org.k.photohost.auth.model.UserRole;
import org.k.photohost.auth.model.VerificationToken;

import java.util.List;

public interface UserDao extends PhotoDao {

    User findByEmail(String username);

    void newUserAccount(User user);

    void saveToken(VerificationToken token);

    void saveUserRole(UserRole userRole);

    VerificationToken findByToken(String token);

    void setActive(User user, boolean vereficated);

}
