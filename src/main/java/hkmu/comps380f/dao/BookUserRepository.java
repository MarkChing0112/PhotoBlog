package hkmu.comps380f.dao;

import hkmu.comps380f.model.Book;
import hkmu.comps380f.model.TicketUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookUserRepository
        extends JpaRepository<TicketUser, String> {
}

