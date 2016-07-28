package org.k.photohost.controller;

import org.k.photohost.auth.model.LoginDto;
import org.k.photohost.auth.model.User;
import org.k.photohost.auth.model.UserDto;
import org.k.photohost.auth.model.VerificationToken;
import org.k.photohost.auth.service.ICustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

@Controller
public class AuthController {

    @Autowired
    private ICustomUserDetailsService customUserDetailsService;

    @Autowired
    private JavaMailSender mailSender;

    @GetMapping("/login")
    public String loginForm(Model model) {
        model.addAttribute("loginDto", new LoginDto());
        return "auth/login";
    }

    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("loginDto") LoginDto loginDto){
        List<AuthenticationProvider> list = new ArrayList<AuthenticationProvider>();
        list.add(new DaoAuthenticationProvider());
        ProviderManager manager = new ProviderManager(list);
        UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(loginDto.getEmail(), loginDto.getPassword());
        SecurityContextHolder.getContext().setAuthentication(manager.authenticate(auth));
        return "auth/edit";
    }

    @GetMapping("/signup")
    public String signupForm(Model model) {
        model.addAttribute("userDto", new UserDto());
        return "auth/signup";
    }

    @PostMapping("/signup")
    public String registerNewUser(HttpServletRequest request, @Valid @ModelAttribute("userDto") UserDto userDto){
        try {
            User user = customUserDetailsService.registerNewUserAccount(userDto);
            VerificationToken token = new VerificationToken(user);
            customUserDetailsService.saveToken(token);
            sendMail(user, token);
            String message = "Thanks for signing up on Photohost! " +
                    "We just sent you a confirmation email to " + userDto.getEmail();
            request.setAttribute("message", message);
        }catch (Exception e){
            request.setAttribute("message", e.getMessage());
        }
        return "auth/signup";
    }

    @GetMapping("/confirm")
    public String confirmEmail(Model model, HttpServletRequest request, @RequestParam("token") String token){
        try {
            VerificationToken verificationToken = customUserDetailsService.findToken(token);
            customUserDetailsService.setActive(verificationToken.getUser(), true);
            request.setAttribute("message", "Account have been verified");
        }catch (Exception e){
            request.setAttribute("message", e.getMessage());
            throw e;
        }
        return "forward:/login";
    }

    private void sendMail(User user, VerificationToken token) throws MessagingException {
        MimeMessage mailMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mailMessage, true);
        helper.setFrom("Photohost");
        helper.setTo(user.getEmail());
        String confirmationLink = "http://localhost:8080/confirm?token=" + token.getToken();
        helper.setText("<html><body>Confirmation link <a href=\"" + confirmationLink + "\"><i>" +
                confirmationLink + "</i></body></html>", true);
        helper.setSubject("Confirmation link");
        mailSender.send(mailMessage);
    }

    private String getPrincipal(){
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = null;
        if (principal instanceof UserDetails) {
            username = ((UserDetails)principal).getUsername();
        } else {
            username = principal.toString();
        }
        return username;
    }

}
