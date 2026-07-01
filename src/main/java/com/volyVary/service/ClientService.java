package com.volyVary.service;

import com.volyVary.repository.*;
import com.volyVary.modele.*;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClientService {
    @Autowired
    private ClientRepository clientRepository;

    
}
