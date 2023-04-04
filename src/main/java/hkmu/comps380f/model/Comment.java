package hkmu.comps380f.model;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.util.Date;

public class Comment {
    @Column(name = "name", insertable=false, updatable=false)
    private String userName;
    @ManyToOne
    @JoinColumn(name = "name")
    private TicketUser customer;
    @CreationTimestamp
    private Date createTime;

    @UpdateTimestamp
    private Date updateTime;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @Column(name = "Book_id", insertable=false, updatable=false)
    private long bid;

    @ManyToOne
    @JoinColumn(name = "book_id")
    private Book book;
    @OneToMany
    private String body;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public TicketUser getCustomer() {
        return customer;
    }

    public void setCustomer(TicketUser customer) {
        this.customer = customer;
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

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getBid() {
        return bid;
    }

    public void setBid(long bid) {
        this.bid = bid;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }
}
