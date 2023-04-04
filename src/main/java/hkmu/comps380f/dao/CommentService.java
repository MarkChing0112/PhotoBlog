package hkmu.comps380f.dao;

import hkmu.comps380f.exception.BookNotFound;
import hkmu.comps380f.exception.CommentNotFound;
import hkmu.comps380f.exception.PhotoNotFound;
import hkmu.comps380f.model.Comment;
import hkmu.comps380f.model.TicketUser;
import jakarta.annotation.Resource;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

public class CommentService {
    @Resource
    private BookRepository bRepo;
    @Resource
    private BookUserRepository buRepo;
    @Resource
    private CommentRepository cRepo;

    @Transactional
    public List<Comment> getComments() {
        return cRepo.findAll();
    }
    @Transactional
    public List<Comment> getCommentsByUser(String username){
        return cRepo.findCommentsByCustomerName(username);
    }
    @Transactional
    public Comment getComment(long bid)
            throws CommentNotFound {
        Comment comment = cRepo.findById(bid).orElse(null);
        if (comment == null) {
            throw new CommentNotFound(bid);
        }
        return comment;
    }

    @Transactional
    public UUID createComment(String customerName, String subject,
                              String body, List<MultipartFile> photos)
            throws IOException {
        TicketUser customers = buRepo.findById(customerName).orElse(null);
        if (customers == null){
            throw new RuntimeException("User " + customerName + " not found.");
        }
        Comment comment = new Comment();
//        Book book = new Book();
//        book.setCustomer(customer);
//        book.setSubject(subject);
//        book.setBody(body);

        comment.setCustomer(customers);
        comment.setBody(body);

        Comment savedComment = cRepo.save(comment);
        customers.getComments().add(savedComment);
        return savedComment.getId();
    }

    @Transactional
    public void delete(long bid) throws CommentNotFound {
        Comment deletedComment = cRepo.findById(bid).orElse(null);
        if (deletedComment == null) {
            throw new CommentNotFound(bid);
        }
        cRepo.delete(deletedComment);
    }

    @Transactional
    public void deleteComment(long commentId)
            throws BookNotFound, PhotoNotFound {
        Comment comment = cRepo.findById(commentId).orElse(null);
        if (comment == null) {
            throw new CommentNotFound(commentId);
        }
    }
}

