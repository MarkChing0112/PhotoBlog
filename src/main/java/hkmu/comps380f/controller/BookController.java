package hkmu.comps380f.controller;

import hkmu.comps380f.dao.BookService;
//import hkmu.comps380f.dao.CommentService;
import hkmu.comps380f.dao.CommentService;
import hkmu.comps380f.dao.UserManagementService;
import hkmu.comps380f.exception.CommentNotFound;
import hkmu.comps380f.exception.PhotoNotFound;
import hkmu.comps380f.exception.BookNotFound;
//import hkmu.comps380f.model.Comment;
import hkmu.comps380f.model.Photo;
import hkmu.comps380f.model.Book;
import hkmu.comps380f.view.DownloadingView;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import org.yaml.snakeyaml.tokens.CommentToken;

import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/Books")
public class BookController {

    @Resource
    private BookService bService;
    @Resource
    private CommentService cService;
    UserManagementService umService;
    // Controller methods, Form-backing object, ...
    @GetMapping(value = {"","/home"})
    public String home(ModelMap model){
        model.addAttribute("bookDatabase", bService.getBooks());
        return  "home";
    }
    @GetMapping(value = { "/list"})
    public String list(ModelMap model) {
        model.addAttribute("bookDatabase", bService.getBooks());
//        model.addAttribute("ticketUsers", umService.getTicketUsers());
        return "BooksList";
    }
//    @GetMapping(value = {"/list/user/{username}"})
//    public String list(ModelMap model, @PathVariable("username") String username) {
//        model.addAttribute("bookDatabase", bService.getBooksByUser(username));
////        model.addAttribute("ticketUsers", umService.getTicketUsers());
//        return "BooksList";
//    }
    @GetMapping("/create")
    public ModelAndView create() {
        return new ModelAndView("CreateBook", "bookForm", new Form());
    }

    @PostMapping("/create")
    public View create(Form form, Principal principal) throws IOException {
        long bookId = bService.createBook(principal.getName(),
                form.getSubject(), form.getBody(), form.getPhotos());
        return new RedirectView("/Books/view/" + bookId, true);
    }
    public static class Form {
        private String subject;
        private String body;
        private List<MultipartFile> photos;
        // Getters and Setters of customerName, subject, body, attachments

        public String getSubject() {
            return subject;
        }

        public void setSubject(String subject) {
            this.subject = subject;
        }

        public String getBody() {
            return body;
        }

        public void setBody(String body) {
            this.body = body;
        }

        public List<MultipartFile> getPhotos() {
            return photos;
        }

        public void setPhotos(List<MultipartFile> photos) {
            this.photos = photos;
        }
    }
    public static class CommentForm{

        private String body;

        public String getBody() {
            return body;
        }

        public void setBody(String body) {
            this.body = body;
        }
    }


    @GetMapping("/view/{bookId}")
    public String view(@PathVariable("bookId") long bookId,
                       ModelMap model)
            throws BookNotFound {
        Book book = bService.getBook(bookId);
        model.addAttribute("bookId", bookId);
        model.addAttribute("book", book);
        return "PhotoDetail-user";
    }

    @GetMapping("/{bookId}/photo/{photo:.+}")
    public View download(@PathVariable("bookId") long bookId,
                         @PathVariable("photo") UUID photoId)
            throws BookNotFound, PhotoNotFound {
        Photo photo = bService.getPhoto(bookId, photoId);
        return new DownloadingView(photo.getName(),
                    photo.getMimeContentType(), photo.getContents());
    }

    @GetMapping("/delete/{bookId}")
    public String deleteBook(@PathVariable("bookId") long bookId)
            throws BookNotFound {
        bService.delete(bookId);
        return "redirect:/Books/list";
    }

    @GetMapping("/{bookId}/delete/{photo:.+}")
    public String deleteAttachment(@PathVariable("bookId") long bookId,
                                   @PathVariable("photo") UUID photoId)
            throws BookNotFound, PhotoNotFound {
        bService.deleteBook(bookId, photoId);
        return "redirect:/Books/view/" + bookId;
    }

    @ExceptionHandler({BookNotFound.class, PhotoNotFound.class})
    public ModelAndView error(Exception e) {
        return new ModelAndView("error", "message", e.getMessage());
    }

    @GetMapping("/edit/{bookId}")
    public ModelAndView showEdit(@PathVariable("bookId") long bookId,
                                 Principal principal, HttpServletRequest request)
            throws BookNotFound {
        Book book = bService.getBook(bookId);
        if (book == null
                || (!request.isUserInRole("ROLE_ADMIN")
                && !principal.getName().equals(book.getCustomerName()))) {
            return new ModelAndView(new RedirectView("/Books/list", true));
        }
        ModelAndView modelAndView = new ModelAndView("EditBook");
        modelAndView.addObject("book", book);
        Form bookForm = new Form();
        bookForm.setSubject(book.getSubject());
        bookForm.setBody(book.getBody());
        modelAndView.addObject("bookForm", bookForm);
        return modelAndView;
    }
    @PostMapping("/edit/{bookId}")
    public String edit(@PathVariable("bookId") long bookId, Form form,
                       Principal principal, HttpServletRequest request)
            throws IOException, BookNotFound {
        Book book = bService.getBook(bookId);
        if (book == null
                || (!request.isUserInRole("ROLE_ADMIN")
                && !principal.getName().equals(book.getCustomerName()))) {
            return "redirect:/Books/list";
        }
        bService.updateBook(bookId, form.getSubject(),
                form.getBody(), form.getPhotos());
        return "redirect:/Books/view/" + bookId;
    }

    @GetMapping("/detail/{bookId}")
    public ModelAndView detail(@PathVariable("bookId") long bookId,
                       ModelMap model)
        throws BookNotFound {
        Book book = bService.getBook(bookId);

        model.addAttribute("bookId", bookId);
        model.addAttribute("book", book);

        return new ModelAndView("PhotoDetail-user", "Commentform", new CommentForm());
    }
    @PostMapping("/detail/{bookId}")
    public View detail(CommentForm form,Principal principal,@PathVariable("bookId") long bookId)
            throws IOException {
        cService.createComment(principal.getName(),form.getBody());
        return new RedirectView("/Books/detail/" + bookId, true);
    }
//    @GetMapping("/create/{bookId}/comment")
//    public ModelAndView createComment(@PathVariable("bookId") long bookId, ModelMap model, Principal principal,
//                                      HttpServletRequest request)
//        throws CommentNotFound {
//        Book book = bService.getBook(bookId);
//        if (book == null
//                && !principal.getName().equals(book.getCustomerName())) {
//            return new ModelAndView(new RedirectView("/Books/detail", true));
//        }
//        model.addAttribute("bookId",bookId);
//        return new ModelAndView("CreateComment", "CommentFrom", new CommentForm());
//    }
//    @PostMapping("/create/{bookId}/comment")
//    public View createComment(CommentForm form, Principal principal,@PathVariable("bookId") long bookId)
//            throws IOException {
//        Book book = bService.getBook(bookId);
//        if (book == null
//                || (!request.isUserInRole("ROLE_ADMIN")
//                && !principal.getName().equals(book.getCustomerName()))) {
//            return new ModelAndView(new RedirectView("/Books/list", true));
//        }
//        cService.createComment(principal.getName(),form.getBody());
//        return new RedirectView("/Books/detail/" + bookId, true);
//    }
}

