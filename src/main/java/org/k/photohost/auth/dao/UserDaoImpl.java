package org.k.photohost.auth.dao;

import org.hibernate.SessionFactory;
import org.k.photohost.auth.model.Photo;
import org.k.photohost.auth.model.User;
import org.k.photohost.auth.model.UserRole;
import org.k.photohost.auth.model.VerificationToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class UserDaoImpl extends PhotoDaoImpl implements UserDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @SuppressWarnings("unchecked")
    public User findByEmail(String email) {
        List<User> users = sessionFactory.getCurrentSession()
                .createQuery("from User where email = :email")
                .setParameter("email", email)
                .list();
        return users.size() > 0 ? users.get(0) : null;
    }

    @Override
    public void newUserAccount(User user) {
        sessionFactory.getCurrentSession().save(user);
    }

    @Override
    public void saveToken(VerificationToken token) {
        sessionFactory.getCurrentSession().save(token);
    }

    @Override
    public void saveUserRole(UserRole userRole){
        sessionFactory.getCurrentSession().save(userRole);
    }

    @Override
    @SuppressWarnings("unchecked")
    public VerificationToken findByToken(String token) {
        List<VerificationToken> tokens = sessionFactory.getCurrentSession()
                .createQuery("from VerificationToken where token = :token")
                .setParameter("token", token)
                .list();
        return tokens.size() > 0 ? tokens.get(0) : null;
    }

    @Override
    public void setActive(User user, boolean verefied){
        user.setVerified(verefied);
        sessionFactory.getCurrentSession()
                .createQuery("update User set verified = :verified" + " where email = :email")
                .setParameter("email", user.getEmail())
                .setParameter("verified", user.isVerified())
                .executeUpdate();
    }
}
