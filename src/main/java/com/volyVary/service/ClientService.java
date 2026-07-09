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

    // private String genererNouvelleReference(){
    //     List<Client> clients = clientRepository.trouverClientsParIdDesc();

    //     if (clients.isEmpty()) {
    //         return "C001";
    //     }

    //     String derniereReference = clients.get(0).getReference();
    //     if (derniereReference == null || derniereReference.isBlank()) {
    //         return "C001";
    //     }

    //     String prefix = derniereReference.replaceAll("\\D", "");
    //     if (prefix.isEmpty()) {
    //         return "C001";
    //     }
    //     int numero = Integer.parseInt(prefix);
    //     return String.format("C%03d", numero + 1);
    // }
    public String obtenirDerniereReference() {
        List<Client> clients = clientRepository.trouverClientsParIdDesc();
        if (clients.isEmpty()) {
            return "C001";
        }
        return clients.get(0).getReference();
    }


    public Client trouverOuCreerClient(String reference, String nom, String prenom, String telephone, String dateHeure){
        Client clientExistant = clientRepository.TrouverParReference(reference);
        if (clientExistant != null) {
            verifierCoherenceClient(clientExistant, nom, prenom, telephone);
            return clientExistant;
        }
        
        validerTelephone(telephone);
        if (!clientRepository.TrouverParTelephone(telephone).isEmpty()) {
            throw new IllegalArgumentException("Numero de telephone existe deja");
        }
        
        Client nouveauClient = new Client();
        nouveauClient.setNom(nom);
        nouveauClient.setPrenom(prenom);
        nouveauClient.setTelephone(telephone);
        nouveauClient.setDateClient(LocalDateTime.parse(dateHeure).toLocalDate());
        nouveauClient.setReference(reference);
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


    private void verifierCoherenceClient(Client client, String nom, String prenom, String telephone) {
        if (!client.getNom().trim().equalsIgnoreCase(nom.trim())) {
            throw new IllegalArgumentException("Le nom ne correspond pas au client existant : " + client.getReference());
        }

        if (!client.getPrenom().trim().equalsIgnoreCase(prenom.trim())) {
            throw new IllegalArgumentException("Le prenom ne correspond pas au client existant : " + client.getReference());
        }

        if (!client.getTelephone().trim().equals(telephone.trim())) {
            throw new IllegalArgumentException("Le numero de telephone ne correspond pas au client existant : " + client.getReference());
        }
    }
}