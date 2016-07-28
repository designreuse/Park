package org.k.photohost.auth.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "photo", catalog = "auth")
public class Photo {

    @Id
    @Column(nullable = false)
    private String url;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "email", nullable = false)
    private User user;

    @ManyToMany(fetch = FetchType.LAZY, mappedBy = "photos")
    private Set<Album> albums = new LinkedHashSet<>(0);

    public Photo() {
    }

    public Photo(String url, User user) {
        this.url = url;
        this.user = user;
    }

    public String getUrl() {
        return url;
    }

    public User getUser() {
        return user;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
