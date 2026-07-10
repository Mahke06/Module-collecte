package com.volyVary.controller;

import com.volyVary.modele.Client;
import com.volyVary.repository.ClientRepository;
import com.volyVary.service.ImportService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;



@Controller
@RequestMapping("/collectes")
public class CollecteImportController {
    @Autowired
    private ClientRepository clientRepository;

    @GetMapping("/chercher-client")
    @ResponseBody
    public Client chercherClient(@RequestParam String reference) {
        return clientRepository.TrouverParReference(reference);
    }


    
    @Autowired
    private ImportService importService;

    @PostMapping("/lire-excel")
    @ResponseBody
    public Map<String, Object> lireExcel(@RequestParam("fichier") MultipartFile fichier) {
        try {
            return importService.lireExcel(fichier);
        } catch (IllegalArgumentException e) {
            Map<String, Object> erreur = new HashMap<>();
            erreur.put("erreur", e.getMessage());
            return erreur;
        }
    }
}