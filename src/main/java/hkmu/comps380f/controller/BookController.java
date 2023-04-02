package hkmu.comps380f.controller;

import hkmu.comps380f.dao.BookService;
import hkmu.comps380f.dao.UserManagementService;
import hkmu.comps380f.exception.AttachmentNotFound;
import hkmu.comps380f.exception.BookNotFound;
import hkmu.comps380f.model.Attachment;
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

import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/Books")
public class BookController {

    @Resource
    private BookService bService;
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
        return new ModelAndView("add", "bookForm", new Form());
    }

    @PostMapping("/create")
    public View create(Form form, Principal principal) throws IOException {
        long bookId = bService.createBook(principal.getName(),
                form.getSubject(), form.getBody(), form.getAttachments());
        return new RedirectView("/Books/view/" + bookId, true);
    }
    public static class Form {
        private String subject;
        private String body;
        private List<MultipartFile> attachments;
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

        public List<MultipartFile> getAttachments() {
            return attachments;
        }

        public void setAttachments(List<MultipartFile> attachments) {
            this.attachments = attachments;
        }
    }



    @GetMapping("/view/{bookId}")
    public String view(@PathVariable("bookId") long bookId,
                       ModelMap model)
            throws BookNotFound {
        Book book = bService.getBook(bookId);
        model.addAttribute("bookId", bookId);
        model.addAttribute("book", book);
        return "view";
    }

    @GetMapping("/{bookId}/attachment/{attachment:.+}")
    public View download(@PathVariable("bookId") long bookId,
                         @PathVariable("attachment") UUID attachmentId)
            throws BookNotFound, AttachmentNotFound {
        Attachment attachment = bService.getAttachment(bookId, attachmentId);
        return new DownloadingView(attachment.getName(),
                    attachment.getMimeContentType(), attachment.getContents());
    }

    @GetMapping("/delete/{bookId}")
    public String deleteBook(@PathVariable("bookId") long bookId)
            throws BookNotFound {
        bService.delete(bookId);
        return "redirect:/Books/list";
    }

    @GetMapping("/{bookId}/delete/{attachment:.+}")
    public String deleteAttachment(@PathVariable("bookId") long bookId,
                                   @PathVariable("attachment") UUID attachmentId)
            throws BookNotFound, AttachmentNotFound {
        bService.deleteAttachment(bookId, attachmentId);
        return "redirect:/Books/view/" + bookId;
    }

    @ExceptionHandler({BookNotFound.class, AttachmentNotFound.class})
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
        ModelAndView modelAndView = new ModelAndView("edit");
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
                form.getBody(), form.getAttachments());
        return "redirect:/Books/view/" + bookId;
    }

}

