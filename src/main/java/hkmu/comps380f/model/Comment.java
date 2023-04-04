//package hkmu.comps380f.model;
//
//import jakarta.persistence.*;
//import jakarta.persistence.Table;
//import org.hibernate.annotations.*;
//
//import java.util.Date;
//import java.util.UUID;
//
//@Entity
//@Table(name = "Comment")
//public class Comment {
//    @Id
//    @GeneratedValue
//    @ColumnDefault("random_uuid()")
//    private UUID id;
//    @Column(name = "name", insertable=false, updatable=false)
//    private String userName;
//    @ManyToOne
//    @JoinColumn(name = "name")
//    private TicketUser customers;
//    @CreationTimestamp
//    private Date createTime;
//
//    @UpdateTimestamp
//    private Date updateTime;
//    @Column(name = "Book_id", insertable=false, updatable=false)
//    private long bid;
//
//    @ManyToOne
//    @JoinColumn(name = "book_id")
//    private Book book;
//
//    private String body;
//
//    public String getUserName() {
//        return userName;
//    }
//
//    public void setUserName(String userName) {
//        this.userName = userName;
//    }
//
//    public TicketUser getCustomer() {
//        return customers;
//    }
//
//    public void setCustomer(TicketUser customers) {
//        this.customers = customers;
//    }
//
//    public Date getCreateTime() {
//        return createTime;
//    }
//
//    public void setCreateTime(Date createTime) {
//        this.createTime = createTime;
//    }
//
//    public Date getUpdateTime() {
//        return updateTime;
//    }
//
//    public void setUpdateTime(Date updateTime) {
//        this.updateTime = updateTime;
//    }
//
//    public UUID getId() {
//        return id;
//    }
//
//    public void setId(UUID id) {
//        this.id = id;
//    }
//
//    public long getBid() {
//        return bid;
//    }
//
//    public void setBid(long bid) {
//        this.bid = bid;
//    }
//
//    public Book getBook() {
//        return book;
//    }
//
//    public void setBook(Book book) {
//        this.book = book;
//    }
//
//    public String getBody() {
//        return body;
//    }
//
//    public void setBody(String body) {
//        this.body = body;
//    }
//}
