package com.volyVary.service;

import com.volyVary.repository.*;
import com.volyVary.modele.*;


import java.time.LocalDateTime;
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
        return String.format("C%03d", numero + 1);
    }


    public Client trouverOuCreerClient(String nom, String prenom, String telephone, String dateHeure){
        validerTelephone(telephone);
        Client clientExistant = clientRepository.TrouverParTelephone(telephone);
        if (clientExistant != null) {
            if (!clientExistant.getNom().equalsIgnoreCase(nom) || !clientExistant.getPrenom().equalsIgnoreCase(prenom)) {
                throw new IllegalArgumentException("Numero existant");
            }
            return clientExistant;       
        }

        Client nouveauClient = new Client();
        nouveauClient.setNom(nom);
        nouveauClient.setPrenom(prenom);
        nouveauClient.setTelephone(telephone);
        nouveauClient.setDateClient(LocalDateTime.parse(dateHeure).toLocalDate());
        nouveauClient.setReference(genererNouvelleReference());
        return clientRepository.save(nouveauClient); 
    }



    private void validerTelephone(String telephone) {
        if (telephone == null || telephone.isBlank()) {
            throw new IllegalArgumentException("Le numéro de téléphone est obligatoire");
        }
        if (!telephone.matches("^[0-9 ]+$")) {
            throw new IllegalArgumentException("Le numéro de téléphone ne doit contenir que des chiffres : " + telephone);
        }
    }
}
