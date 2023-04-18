package hkmu.comps380f.controller;

import hkmu.comps380f.dao.BookService;
import hkmu.comps380f.dao.UserManagementService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import java.io.IOException;
import java.security.Principal;

@Controller
@RequestMapping("/user")
public class UserManagementController {
    @Resource
    UserManagementService umService;

    @Resource
    private BookService bService;

    public static class Form {
        private String username;  private String password;  private String[] roles;

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public String[] getRoles() {
            return roles;
        }

        public void setRoles(String[] roles) {
            this.roles = roles;
        }
    }

    public static class descriptionForm {
        private String description;

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }
    }
    @GetMapping("/create")
    public ModelAndView create() {

        return new ModelAndView("CreateUser", "ticketUser", new Form());
    }
    @PostMapping("/create")
    public String create(Form form) throws IOException {
        umService.createTicketUser(form.getUsername(), form.getPassword(), form.getRoles());
        return "redirect:/login";
    }
    @GetMapping({"", "/", "/list"})
    public String list(ModelMap model) {
        model.addAttribute("ticketUsers", umService.getTicketUsers());
        return "UserList";
    }
    @GetMapping("/delete/{username}")
    public String deleteTicket(@PathVariable("username") String username) {
        umService.delete(username);
        return "redirect:/user/list";
    }


    @GetMapping("/profile")
    public ModelAndView profile(ModelMap model, Principal principal){
        model.addAttribute("bookDatabase", bService.getBooksByUser(principal.getName()));
        model.addAttribute("User", umService.getTicketUser(principal.getName()));
        return new ModelAndView("profile", "descriptionForm", new descriptionForm());
    }

    @PostMapping("/profile")
    public View profile(Principal principal, descriptionForm form) throws IOException{

        umService.createDescription(principal.getName(), form.getDescription());
        return new RedirectView("/user/profile", true);
    }


}

