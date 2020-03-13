package com.example.demo.service;

import com.example.demo.dao.UserRepository;
import com.example.demo.po.User;
import com.example.demo.util.Md5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;

    @Override
    public User checkUser(String username, String password) {
        User user = userRepository.findByUsernameAndPassword(username, Md5Util.code(password));
        return user;
    }
}
