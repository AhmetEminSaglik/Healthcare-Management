package com.harpia.HarpiaHealthAnalysisWS.business.concretes.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.dataaccess.user.UserRepository;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class UserManager implements UserService {
    @Autowired
    UserRepository userRepository;

    //    PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    @Override
    public User save(User user) {
        return userRepository.save(user);
    }

    @Override
    public List<User> saveAll(List<User> list) {
        return userRepository.saveAll(list);
    }

    public List<User> findAll() {
        return userRepository.findAllByOrderByIdAsc();
    }

    @Override
    public List<User> findAllByRoleId(int roleId) {
        return userRepository.findAllByRoleIdOrderByIdDesc(roleId);
    }

    @Override
    public User findById(long id) {
        return userRepository.findById(id).get();
    }

    @Override
    public User findByUsernameAndPassword(String username, String password) {
        return userRepository.findByUsernameAndPassword(username, password);
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public List<User> findAllByCreatedTimeAfter(LocalDateTime time) {
        return userRepository.findAllByCreatedAtAfter(time);
    }
}
