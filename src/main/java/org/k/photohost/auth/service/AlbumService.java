package org.k.photohost.auth.service;

import org.k.photohost.auth.dao.AlbumDao;
import org.k.photohost.auth.model.Album;
import org.k.photohost.auth.model.Photo;
import org.k.photohost.auth.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.Set;

@Service
@Component
public class AlbumService implements IAlbumService{

    @Autowired
    AlbumDao albumDao;

    @Transactional
    @Override
    public Object getUserAlbums(String username) {
        return albumDao.getUserAlbums(username);
    }

    @Transactional
    @Override
    public Album findAlbumById(int id){
        return albumDao.findAlbumById(id);
    }

    @Transactional
    @Override
    public Album createAlbum(String name, User user, Set<Photo> photos, Date date,
                             String effects, int speed, int effectSpeed, boolean randomOrder){
        Album album = new Album(name, user, photos, date, effects, speed, effectSpeed, randomOrder);
        albumDao.save(album);
        return album;
    }

    @Transactional
    @Override
    public void createAlbum(Album album){
        albumDao.save(album);
    }

    @Transactional
    @Override
    public void updateAlbum(Album album){
        albumDao.updateAlbum(album);
    }
}
