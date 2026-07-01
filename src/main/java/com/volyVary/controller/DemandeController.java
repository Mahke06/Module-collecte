package com.volyVary.controller;

import com.volyVary.service.*;
import com.volyVary.modele.*;
import com.volyVary.repository.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

@Controller
public class DemandeController {
    @Autowired
    private ClientRepository clientRepository;
    
    //Ce controlleur n'est juste qu'un exemple
}
