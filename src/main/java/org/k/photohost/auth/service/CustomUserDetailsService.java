package org.k.photohost.auth.service;

import org.k.photohost.auth.dao.UserDao;
import org.k.photohost.auth.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.*;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;

@Service("userDetailsService")
@Component
public class CustomUserDetailsService implements UserDetailsService, ICustomUserDetailsService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Transactional(readOnly = true)
    @Override
    public UserDetails loadUserByUsername(final String email) throws UsernameNotFoundException{
        org.k.photohost.auth.model.User user = userDao.findByEmail(email);
        List<GrantedAuthority> authorities = buildUserAuthority(user.getUserRoles());
        return buildUserForAuthentication(user, authorities);
    }

    @Transactional(readOnly = true)
    @Override
    public org.k.photohost.auth.model.User findUserByEmail(String email){
        return userDao.findByEmail(email);
    }

    @Transactional
    @Override
    public void savePhoto(String email, String url) throws UsernameNotFoundException{
        org.k.photohost.auth.model.User user = userDao.findByEmail(email);
        Photo photo = new Photo(url, user);
        userDao.savePhoto(photo);
    }

    @Transactional
    @Override
    public Photo findPhotoByUrl(String url){
        return userDao.findPhotoByUrl(url);
    }
    @Transactional

    @Override
    public void deletePhoto(String url){
        userDao.deletePhoto(url);
    }

    @Transactional
    @Override
    public org.k.photohost.auth.model.User registerNewUserAccount(final UserDto accountDto) throws Exception {
        if (emailExist(accountDto.getEmail())) {
            throw new Exception("There is an account with that email adress: " + accountDto.getEmail());
        }
        org.k.photohost.auth.model.User user = new org.k.photohost.auth.model.User();

        user.setEmail(accountDto.getEmail());
        user.setPassword(passwordEncoder.encode(accountDto.getPassword()));
        user.setVerified(false);
        Set<UserRole> userRoles = new HashSet<UserRole>();
        UserRole userRole = new UserRole(user, "ROLE_USER");
        userRoles.add(userRole);
        user.setUserRoles(userRoles);
        userDao.newUserAccount(user);
        userDao.saveUserRole(userRole);
        return user;
    }

    @Transactional
    @Override
    public List<Photo> getPhotosOfUser(User user){
        return userDao.getPhotosOfUser(user);
    }

    @Transactional
    @Override
    public void saveToken(VerificationToken token) {
        userDao.saveToken(token);
    }

    @Transactional(readOnly = true)
    @Override
    public VerificationToken findToken(String token) {
        return userDao.findByToken(token);
    }

    @Transactional
    @Override
    public void setActive(org.k.photohost.auth.model.User user, boolean verified){
        userDao.setActive(user, verified);
    }

    private List<GrantedAuthority> buildUserAuthority(Set<UserRole> userRoles){
        Set<GrantedAuthority> authorities = new HashSet<GrantedAuthority>();
        for(UserRole userRole : userRoles){
            authorities.add(new SimpleGrantedAuthority(userRole.getRole()));
        }
        return new ArrayList<GrantedAuthority>(authorities);
    }

    private User buildUserForAuthentication(org.k.photohost.auth.model.User user, List<GrantedAuthority> authorities){
        return new User(user.getEmail(), user.getPassword(), user.isVerified(), true, true, true, authorities);
    }

    private boolean emailExist(final String email) {
        final org.k.photohost.auth.model.User user = userDao.findByEmail(email);
        if (user != null) {
            return true;
        }
        return false;
    }
}
