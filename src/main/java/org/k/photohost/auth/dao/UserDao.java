package org.k.photohost.auth.dao;

import org.k.photohost.auth.model.Photo;
import org.k.photohost.auth.model.User;
import org.k.photohost.auth.model.UserRole;
import org.k.photohost.auth.model.VerificationToken;

import java.util.List;

public interface UserDao {

    User findByEmail(String username);
    void newUserAccount(User user);

    void saveToken(VerificationToken token);

    void saveUserRole(UserRole userRole);

    VerificationToken findByToken(String token);

    void setActive(User user, boolean vereficated);

    void savePhoto(Photo photo);

    void deletePhoto(String url);

    Photo findPhotoByUrl(String url);

    List<Photo> getPhotosOfUser(org.springframework.security.core.userdetails.User user);
}
