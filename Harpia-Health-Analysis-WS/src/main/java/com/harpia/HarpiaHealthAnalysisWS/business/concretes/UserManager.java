package com.harpia.HarpiaHealthAnalysisWS.business.concretes;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.UserService;
import com.harpia.HarpiaHealthAnalysisWS.dataaccess.UserRepository;
import com.harpia.HarpiaHealthAnalysisWS.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service

public class UserManager implements UserService {
    @Autowired
    UserRepository userRepository;

    @Override
    public User save(User u) {
        return userRepository.save(u);
    }

    @Override
    public List<User> saveAll(List<User> list) {
        return userRepository.saveAll(list);
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    public User findById(long id) {
        return userRepository.findById(id).get();
    }

    @Override
    public List<User> findAllByRoleId(int id) {
        return userRepository.findAllByRoleId(id);
    }

    @Override
    public User findByUsernameAndPassword(String username, String password) {
        return userRepository.findByUsernameAndPassword(username, password);
    }
}
