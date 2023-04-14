package hkmu.comps380f.dao;

import hkmu.comps380f.model.TicketUser;
import jakarta.annotation.Resource;
import jakarta.transaction.Transactional;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserManagementService {
    @Resource
    private BookUserRepository tuRepo;

    @Transactional
    public void createTicketUser(String username, String password, String[] roles) {
        TicketUser user = new TicketUser(username, password, roles);
        tuRepo.save(user);
    }
    @Transactional
    public List<TicketUser> getTicketUsers() {
        return tuRepo.findAll();
    }
    public TicketUser getTicketUser(String username) {
        return tuRepo.findById(username).orElse(null);
    }
    @Transactional
    public void delete(String username) {
        TicketUser ticketUser = tuRepo.findById(username).orElse(null);
        if (ticketUser == null) {
            throw new UsernameNotFoundException("User '" + username + "' not found.");
        }
        tuRepo.delete(ticketUser);
    }

    @Transactional
    public void createDescription(String username, String description){
        TicketUser updateUserDes = tuRepo.findById(username).orElse(null);
        if (updateUserDes == null) {
            throw new UsernameNotFoundException("User '" + username + "' not found.");
        }
        updateUserDes.setDescription(description);
        tuRepo.save(updateUserDes);

    }

}

