package com.volyVary.service;

import com.volyVary.repository.*;
import com.volyVary.modele.*;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClientService {
    @Autowired
    private ClientRepository clientRepository;

    private String genererNouvelleReference(){
        List<Client> clients = clientRepository.trouverClientsParIdDesc();

        if (clients.isEmpty()) {
            return "C001";
        }

        String derniereReference = clients.get(0).getReference();
        if (derniereReference == null || derniereReference.isBlank()) {
            return "C001";
        }

        String prefix = derniereReference.replaceAll("\\D", "");
        if (prefix.isEmpty()) {
            return "C001";
        }
        int numero = Integer.parseInt(prefix);
        return String.format("C00%d", numero + 1);
    }


    public Client trouverOuCreerClient(String nom, String prenom, String telephone){
        Client clientExistant = clientRepository.TrouverParTelephone(telephone);
        if (clientExistant != null) {
            return clientExistant;        
        }

        Client nouveauClient = new Client();
        nouveauClient.setNom(nom);
        nouveauClient.setPrenom(prenom);
        nouveauClient.setTelephone(telephone);
        nouveauClient.setDateClient(LocalDate.now());
        nouveauClient.setReference(genererNouvelleReference());
        return clientRepository.save(nouveauClient);
        
    }
}
