package hkmu.comps380f.dao;

import hkmu.comps380f.exception.CommentNotFound;
import hkmu.comps380f.exception.PhotoNotFound;
import hkmu.comps380f.exception.BookNotFound;
import hkmu.comps380f.model.Comment;
import hkmu.comps380f.model.Photo;
import hkmu.comps380f.model.Book;
import hkmu.comps380f.model.TicketUser;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
public class BookService {
    @Resource
    private BookRepository bRepo;
    @Resource
    private BookUserRepository buRepo;
    @Resource
    private PhotoRepository pRepo;
    @Resource
    private CommentRepository cRepo;

    @Transactional
    public List<Book> getBooks() {
        return bRepo.findAll();
    }
    @Transactional
    public List<Book> getBooksByUser(String username){
        return bRepo.findBooksByCustomerName(username);
    }
    @Transactional
    public Book getBook(long id)
            throws BookNotFound {
        Book book = bRepo.findById(id).orElse(null);
        if (book == null) {
            throw new BookNotFound(id);
        }
        return book;
    }
    @Transactional
    public List<Comment> getComments() {
        return cRepo.findAll();
    }
    @Transactional
    public List<Comment> getCommentsbyBookid(long book_id){
        return cRepo.findCommentsBybookId(book_id);
    }

    @Transactional
    public UUID createComment(String customerName, String body,long bookId)
            throws IOException {
        TicketUser customer = buRepo.findById(customerName).orElse(null);

        if (customer == null){
            throw new RuntimeException("User " + customerName + " not found.");
        }
        Comment comment = new Comment();
        Book book = getBook(bookId);
        comment.setCustomer(customer);
        comment.setBody(body);
        comment.setBook(book);
        Comment savedComment = cRepo.save(comment);
        customer.getComments().add(savedComment);
        return savedComment.getId();
    }

    @Transactional
    public void deleteComment(long bookId, UUID cid)
            throws BookNotFound, PhotoNotFound {
        Book book = bRepo.findById(bookId).orElse(null);
        if (book == null) {
            throw new BookNotFound(bookId);
        }
        for (Comment comment : book.getComments()) {
            if (comment.getId().equals(cid)) {
                book.deleteComment(comment);
                bRepo.save(book);
                return;
            }
        }
        throw new CommentNotFound(cid);
    }
    @Transactional
    public Photo getPhoto(long bookId, UUID photoId)
            throws BookNotFound, PhotoNotFound {
        Book book = bRepo.findById(bookId).orElse(null);
        if (book == null) {
            throw new BookNotFound(bookId);
        }
        Photo photo = pRepo.findById(photoId).orElse(null);
        if (photo == null) {
            throw new PhotoNotFound(photoId);
        }
        return photo;
    }

    @Transactional
    public void delete(long id) throws BookNotFound {
        Book deletedBook = bRepo.findById(id).orElse(null);
        if (deletedBook == null) {
            throw new BookNotFound(id);
        }
        bRepo.delete(deletedBook);
    }

    @Transactional
    public void deleteBook(long bookId, UUID photoId)
            throws BookNotFound, PhotoNotFound {
        Book book = bRepo.findById(bookId).orElse(null);
        if (book == null) {
            throw new BookNotFound(bookId);
        }
        for (Photo photo : book.getPhotos()) {
            if (photo.getId().equals(photoId)) {
                book.deletePhoto(photo);
                bRepo.save(book);
                return;
            }
        }
        throw new PhotoNotFound(photoId);
    }

    @Transactional
    public long createBook(String customerName, String subject,
                             String body, List<MultipartFile> photos)
            throws IOException {
        TicketUser customer = buRepo.findById(customerName).orElse(null);
        if (customer == null){
            throw new RuntimeException("User " + customerName + " not found.");
        }
        Book book = new Book();
        book.setCustomer(customer);
        book.setSubject(subject);
        book.setBody(body);
        for (MultipartFile filePart : photos) {
            Photo photo = new Photo();
            photo.setName(filePart.getOriginalFilename());
            photo.setMimeContentType(filePart.getContentType());
            photo.setContents(filePart.getBytes());
            photo.setBook(book);
            if (photo.getName() != null && photo.getName().length() > 0
                    && photo.getContents() != null
                    && photo.getContents().length > 0) {
                book.getPhotos().add(photo);
            }
        }
        Book savedBook = bRepo.save(book);
        customer.getBooks().add(savedBook);
        return savedBook.getId();
    }

    @Transactional
    public void updateBook(long id, String subject,
                            String body, List<MultipartFile> photos)
            throws IOException, BookNotFound {
        Book updatedBook = bRepo.findById(id).orElse(null);
        if (updatedBook == null) {
            throw new BookNotFound(id);
        }
        updatedBook.setSubject(subject);
        updatedBook.setBody(body);
        for (MultipartFile filePart : photos) {
            Photo photo = new Photo();
            photo.setName(filePart.getOriginalFilename());
            photo.setMimeContentType(filePart.getContentType());
            photo.setContents(filePart.getBytes());
            photo.setBook(updatedBook);
            if (photo.getName() != null && photo.getName().length() > 0
                    && photo.getContents() != null
                    && photo.getContents().length > 0) {
                updatedBook.getPhotos().add(photo);
            }
        }
        bRepo.save(updatedBook);
    }
}

