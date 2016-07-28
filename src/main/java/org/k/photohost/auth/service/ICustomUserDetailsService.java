package org.k.photohost.auth.service;

import org.k.photohost.auth.model.Photo;
import org.k.photohost.auth.model.User;
import org.k.photohost.auth.model.UserDto;
import org.k.photohost.auth.model.VerificationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface ICustomUserDetailsService {

    @Transactional(readOnly = true)
    User findUserByEmail(String email);

    @Transactional(readOnly = true)
    void savePhoto(String email, String url) throws UsernameNotFoundException;

    @Transactional
    Photo findPhotoByUrl(String url);

    @Transactional
    void deletePhoto(String url);

    User registerNewUserAccount(UserDto userDto) throws Exception;

    void saveToken(VerificationToken token);

    @Transactional(readOnly = true)
    VerificationToken findToken(String token);

    @Transactional
    void setActive(User user, boolean verified);

    @Transactional
    List<Photo> getPhotosOfUser(org.springframework.security.core.userdetails.User user);
}
