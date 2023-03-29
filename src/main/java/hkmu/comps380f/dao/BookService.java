package hkmu.comps380f.dao;

import hkmu.comps380f.exception.AttachmentNotFound;
import hkmu.comps380f.exception.BookNotFound;
import hkmu.comps380f.model.Attachment;
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
    private BookRepository tRepo;
    @Resource
    private TicketUserRepository tuRepo;

    @Resource
    private AttachmentRepository aRepo;

    @Transactional
    public List<Book> getBooks() {
        return tRepo.findAll();
    }
    @Transactional
    public List<Book> getBooksByUser(String username){
        return tRepo.findBooksByCustomerName(username);
    }
    @Transactional
    public Book getBook(long id)
            throws BookNotFound {
        Book book = tRepo.findById(id).orElse(null);
        if (book == null) {
            throw new BookNotFound(id);
        }
        return book;
    }

    @Transactional
    public Attachment getAttachment(long bookId, UUID attachmentId)
            throws BookNotFound, AttachmentNotFound {
        Book book = tRepo.findById(bookId).orElse(null);
        if (book == null) {
            throw new BookNotFound(bookId);
        }
        Attachment attachment = aRepo.findById(attachmentId).orElse(null);
        if (attachment == null) {
            throw new AttachmentNotFound(attachmentId);
        }
        return attachment;
    }

    @Transactional
    public void delete(long id) throws BookNotFound {
        Book deletedBook = tRepo.findById(id).orElse(null);
        if (deletedBook == null) {
            throw new BookNotFound(id);
        }
        tRepo.delete(deletedBook);
    }

    @Transactional
    public void deleteAttachment(long bookId, UUID attachmentId)
            throws BookNotFound, AttachmentNotFound {
        Book book = tRepo.findById(bookId).orElse(null);
        if (book == null) {
            throw new BookNotFound(bookId);
        }
        for (Attachment attachment : book.getAttachments()) {
            if (attachment.getId().equals(attachmentId)) {
                book.deleteAttachment(attachment);
                tRepo.save(book);
                return;
            }
        }
        throw new AttachmentNotFound(attachmentId);
    }

    @Transactional
    public long createBook(String customerName, String subject,
                             String body, List<MultipartFile> attachments)
            throws IOException {
        TicketUser customer = tuRepo.findById(customerName).orElse(null);
        if (customer == null){
            throw new RuntimeException("User " + customerName + " not found.");
        }
        Book book = new Book();
        book.setCustomer(customer);
        book.setSubject(subject);
        book.setBody(body);
        for (MultipartFile filePart : attachments) {
            Attachment attachment = new Attachment();
            attachment.setName(filePart.getOriginalFilename());
            attachment.setMimeContentType(filePart.getContentType());
            attachment.setContents(filePart.getBytes());
            attachment.setBook(book);
            if (attachment.getName() != null && attachment.getName().length() > 0
                    && attachment.getContents() != null
                    && attachment.getContents().length > 0) {
                book.getAttachments().add(attachment);
            }
        }
        Book savedBook = tRepo.save(book);
        customer.getBooks().add(savedBook);
        return savedBook.getId();
    }

    @Transactional
    public void updateBook(long id, String subject,
                             String body, List<MultipartFile> attachments)
            throws IOException, BookNotFound {
        Book updatedBook = tRepo.findById(id).orElse(null);
        if (updatedBook == null) {
            throw new BookNotFound(id);
        }
        updatedBook.setSubject(subject);
        updatedBook.setBody(body);
        for (MultipartFile filePart : attachments) {
            Attachment attachment = new Attachment();
            attachment.setName(filePart.getOriginalFilename());
            attachment.setMimeContentType(filePart.getContentType());
            attachment.setContents(filePart.getBytes());
            attachment.setBook(updatedBook);
            if (attachment.getName() != null && attachment.getName().length() > 0
                    && attachment.getContents() != null
                    && attachment.getContents().length > 0) {
                updatedBook.getAttachments().add(attachment);
            }
        }
        tRepo.save(updatedBook);
    }
}

