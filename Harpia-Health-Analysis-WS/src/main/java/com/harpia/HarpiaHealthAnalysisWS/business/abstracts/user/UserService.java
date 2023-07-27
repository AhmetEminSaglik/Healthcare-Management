package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user;

import com.harpia.HarpiaHealthAnalysisWS.model.users.User;

import java.util.List;

public interface UserService {
    User save(User u);

    List<User> saveAll(List<User> list);


    User findById(long id);

    User findByUsernameAndPassword(String username, String password);
    User findByUsername(String username);


    List<User> findAll();

//    List<User> findAllByRoleId(int id);

}
