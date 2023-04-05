package hkmu.comps380f.dao;

import hkmu.comps380f.exception.BookNotFound;
import hkmu.comps380f.exception.CommentNotFound;
import hkmu.comps380f.exception.PhotoNotFound;
import hkmu.comps380f.model.Comment;
import hkmu.comps380f.model.TicketUser;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
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
    public Comment getComment(long book_id)
            throws CommentNotFound {
        Comment comment = cRepo.findById(book_id).orElse(null);
        if (comment == null) {
            throw new CommentNotFound(book_id);
        }
        return comment;
    }

    @Transactional
    public UUID createComment(String customerName, String body)
            throws IOException {
        TicketUser customer = buRepo.findById(customerName).orElse(null);

        if (customer == null){
            throw new RuntimeException("User " + customerName + " not found.");
        }
        Comment comment = new Comment();


        comment.setCustomer(customer);
        comment.setBody(body);

        Comment savedComment = cRepo.save(comment);
        customer.getComments().add(savedComment);
        return savedComment.getId();
    }

    @Transactional
    public void delete(long book_id) throws CommentNotFound {
        Comment deletedComment = cRepo.findById(book_id).orElse(null);
        if (deletedComment == null) {
            throw new CommentNotFound(book_id);
        }
        cRepo.delete(deletedComment);
    }

    @Transactional
    public void deleteComment(long book_id)
            throws BookNotFound, PhotoNotFound {
        Comment comment = cRepo.findById(book_id).orElse(null);
        if (comment == null) {
            throw new CommentNotFound(book_id);
        }
    }
}

