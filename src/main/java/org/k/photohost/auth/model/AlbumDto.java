package org.k.photohost.auth.model;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

public class AlbumDto {

    @NotNull
    private int id;

    @NotNull
    private String name;

    @NotNull
    private User user;

    @NotNull
    private Set<Photo> photos = new LinkedHashSet<>(0);

    @NotNull
    private Date date;

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public User getUser() {
        return user;
    }

    public Set<Photo> getPhotos() {
        return photos;
    }

    public Date getDate() {
        return date;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setPhotos(Set<Photo> photos) {
        this.photos = photos;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public AlbumDto(String name, User user, Set<Photo> photos, Date date) {
        this.name = name;
        this.user = user;
        this.photos = photos;
        this.date = date;
    }

    public AlbumDto(String name, User user, Set<Photo> photos) {
        this.name = name;
        this.user = user;
        this.photos = photos;
    }

    public AlbumDto() {
    }
}
