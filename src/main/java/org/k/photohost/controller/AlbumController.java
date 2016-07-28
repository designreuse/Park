package org.k.photohost.controller;

import org.k.photohost.auth.model.Album;
import org.k.photohost.auth.model.AlbumDto;
import org.k.photohost.auth.model.Photo;
import org.k.photohost.auth.service.IAlbumService;
import org.k.photohost.auth.service.ICustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
public class AlbumController {

    @Autowired
    ICustomUserDetailsService customUserDetailsService;

    @Autowired
    IAlbumService albumService;

    @GetMapping("/album")
    public String showAlbums(Model model){
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        org.k.photohost.auth.model.User userModel = customUserDetailsService.findUserByEmail(user.getUsername());
        ArrayList<String> list = new ArrayList<>();
        List<Photo> photolist = customUserDetailsService.getPhotosOfUser(user);
        for(int i = 0; i < photolist.size(); i++){
            list.add(photolist.get(i).getUrl());
        }
        model.addAttribute("list", list);
        Album album = new Album("New album", userModel, new LinkedHashSet<Photo>(0), new Date(), "", 0, 0, false);
        albumService.createAlbum(album);
        model.addAttribute("newAlbum", album);
        return "photo/album";
    }

    @GetMapping("/slideShow/{albumId}")
    public String showSettings(@PathVariable("albumId") int id, Model model){
        model.addAttribute("album", albumService.findAlbumById(id));
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("albumsList", albumService.getUserAlbums(user.getUsername()));
        return "photo/slideShow";
    }

    @PostMapping("/saveAlbum")
    public @ResponseBody
    String saveAlbum(@RequestParam("savedSorting") String savedSorting, @RequestParam("name") String name,
                     @RequestParam("effects") String effects, @RequestParam("speed") int speed,
                     @RequestParam("effectSpeed") int effectSpeed, @RequestParam("randomOrder") boolean randomOrder,
                     @RequestParam("id") int id){
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        org.k.photohost.auth.model.User userModel = customUserDetailsService.findUserByEmail(user.getUsername());
        Set<Photo> photos = new LinkedHashSet<>();
        for(String url : savedSorting.split("$_")) {photos.add(customUserDetailsService.findPhotoByUrl(url));}
        Album album = albumService.findAlbumById(id);
        album.setDate(new Date());
        album.setEffects(effects);
        album.setEffectSpeed(effectSpeed);
        album.setName(name);
        album.setPhotos(photos);
        album.setUser(userModel);
        album.setRandomOrder(randomOrder);
        album.setSpeed(speed);
        albumService.updateAlbum(album);
        return "";
    }

}
