package org.k.photohost.auth.dao;

import org.k.photohost.auth.model.Album;
import org.k.photohost.auth.model.User;

import java.util.List;

public interface AlbumDao {

    Album findById(int id);

    List<Album> findByUser(User user);

    void save(Album album);

    Object getUserAlbums(String username);

}
