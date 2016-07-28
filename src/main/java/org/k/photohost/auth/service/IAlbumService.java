package org.k.photohost.auth.service;

import org.k.photohost.auth.model.Album;
import org.k.photohost.auth.model.Photo;
import org.k.photohost.auth.model.User;

import java.util.Date;
import java.util.Set;

public interface IAlbumService {

    Object getUserAlbums(String username);

    Album findAlbumById(int id);

    Album createAlbum(String name, User user, Set<Photo> photos, Date date,
                      String effects, int speed, int effectSpeed, boolean randomOrder);

    void createAlbum(Album album);

    void updateAlbum(Album album);
}
