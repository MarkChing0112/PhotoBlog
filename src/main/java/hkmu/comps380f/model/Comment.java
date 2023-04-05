package hkmu.comps380f.model;

import jakarta.persistence.Entity;
import jakarta.persistence.*;
import org.hibernate.annotations.*;

import java.util.Date;
import java.util.UUID;

@Entity
public class Comment {
    @Id
    @GeneratedValue
    @ColumnDefault("random_uuid()")
    private UUID id;
    @Column(name = "name", insertable=false, updatable=false)
    private String customerName;
    @ManyToOne
    @JoinColumn(name = "name")
    private TicketUser customers;
    @CreationTimestamp
    private Date createTime;

    @UpdateTimestamp
    private Date updateTime;
    @Column(name = "book_id", insertable=false, updatable=false)
    private long bookId;

    @ManyToOne
    @JoinColumn(name = "book_id")
    private Book books;

    private String body;

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public TicketUser getCustomer() {
        return customers;
    }

    public void setCustomer(TicketUser customers) {
        this.customers = customers;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public long getBook_id() {
        return bookId;
    }

    public void setBook_id(long bookId) {
        this.bookId = bookId;
    }

    public Book getBook() {
        return books;
    }

    public void setBook(Book books) {
        this.books = books;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }
}
