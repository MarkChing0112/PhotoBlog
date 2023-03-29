package hkmu.comps380f.dao;

import hkmu.comps380f.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookRepository extends JpaRepository<Book, Long> {
    List<Book> findBooksByCustomerName(String customerName);
}
