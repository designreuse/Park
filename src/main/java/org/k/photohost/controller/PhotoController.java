package org.k.photohost.controller;

import org.k.photohost.auth.dao.AlbumDao;
import org.k.photohost.auth.model.Photo;
import org.k.photohost.auth.service.ICustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;

@Controller
public class PhotoController {

    @Autowired
    private ICustomUserDetailsService customUserDetailsService;

    @Autowired
    private AlbumDao albumDao;

    @GetMapping("/photo")
    public String photo(Model model) {
        return "photo/home";
    }

    @GetMapping("/edit")
    public String editPhoto(Model model) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        ArrayList<String> list = new ArrayList<>();
        List<Photo> photolist = customUserDetailsService.getPhotosOfUser(user);
        for(int i = 0; i < photolist.size(); i++){
            list.add(photolist.get(i).getUrl());
        }
        model.addAttribute("list", list);
        return "photo/edit";
    }

    @PostMapping("/submit")
    public @ResponseBody String savePhoto(@RequestParam("photoUrl") String photoUrl){
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        customUserDetailsService.savePhoto(user.getUsername(), photoUrl);
        return "";
    }

    @PostMapping("/deletePhoto")
    public @ResponseBody String deletePhoto(@RequestParam("photoUrl") String photoUrl){
        customUserDetailsService.deletePhoto(photoUrl);
        return "";
    }

}