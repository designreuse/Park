package org.k.photohost.auth.dao;

import org.hibernate.SessionFactory;
import org.k.photohost.auth.model.Album;
import org.k.photohost.auth.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public class AlbumDaoImpl implements AlbumDao {

    @Autowired
    SessionFactory sessionFactory;

    @Override
    @SuppressWarnings("unchecked")
    public Album findAlbumById(int id) {
        List<Album> list = sessionFactory.getCurrentSession().createQuery("from Album where id = :id")
                .setParameter("id", id)
                .list();
        return list.size() > 0 ? list.get(0) : null;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Album> findByUser(User user){
        String username = user.getEmail();
        return sessionFactory.getCurrentSession().createQuery("from Album where email = :email")
                .setParameter("email", username)
                .list();
    }

    @Override
    public void save(Album album) {
        sessionFactory.getCurrentSession().save(album);
    }

    @Override
    public void updateAlbum(Album album){
        sessionFactory.getCurrentSession().createQuery("delete Album where id = :id").setParameter("id", album.getId());
        sessionFactory.getCurrentSession().save(album);
    }

    @Override
    public Object getUserAlbums(String username){
        return sessionFactory.getCurrentSession().createQuery("from Album where email = :email")
                .setParameter("email", username)
                .list();
    }
}
