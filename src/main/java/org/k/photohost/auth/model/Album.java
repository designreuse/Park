package org.k.photohost.auth.model;

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "albums", catalog = "auth")
public class Album {

    @Id
    @GeneratedValue
    @Column(nullable = false)
    private int id;

    @Column(nullable = false)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "email", nullable = false)
    private User user;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "album_photo", catalog = "auth",
            joinColumns = {@JoinColumn(name = "id", nullable = false)},
            inverseJoinColumns = {@JoinColumn(name = "url", nullable = false)})
    private Set<Photo> photos = new LinkedHashSet<>(0);

    @Column(nullable = false)
    private Date date;

    @Column
    private String effects;

    @Column
    private int speed;

    @Column
    private int effectSpeed;

    @Column
    private boolean randomOrder;

    public Album() {
    }

    public Album(String name, User user, String effects) {
        this.name = name;
        this.user = user;
        this.effects = effects;
    }

    public Album(String name, User user, Set<Photo> photos, Date date,
                 String effects, int speed, int effectSpeed, boolean randomOrder) {
        this.name = name;
        this.user = user;
        this.photos = photos;
        this.date = date;
        this.effects = effects;
        this.speed = speed;
        this.effectSpeed = effectSpeed;
        this.randomOrder = randomOrder;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Set<Photo> getPhotos() {
        return photos;
    }

    public void setPhotos(Set<Photo> photos) {
        this.photos = photos;
    }

    public String getEffects() {
        return effects;
    }

    public void setEffects(String effects) {
        this.effects = effects;
    }

    public int getSpeed() {
        return speed;
    }

    public void setSpeed(int speed) {
        this.speed = speed;
    }

    public int getEffectSpeed() {
        return effectSpeed;
    }

    public void setEffectSpeed(int effectSpeed) {
        this.effectSpeed = effectSpeed;
    }

    public boolean isRandomOrder() {
        return randomOrder;
    }

    public void setRandomOrder(boolean randomOrder) {
        this.randomOrder = randomOrder;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Album album = (Album) o;

        if (id != album.id) return false;
        if (!name.equals(album.name)) return false;
        return date.equals(album.date);

    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + name.hashCode();
        result = 31 * result + date.hashCode();
        return result;
    }

    @Override
    public String toString() {
        return "Album{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", date=" + date +
                '}';
    }

}
