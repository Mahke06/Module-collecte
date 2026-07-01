package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "client")
public class Client {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_client")
    private int idClient;

    @Column(name = "nom")
    private String nom;

    /*Constructeur*/
    public Client(){
    
    }

    /*Setters*/
    public void setIdClient(int idClient) {
        this.idClient = idClient;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    /*Getters*/
    public int getIdClient() {
        return idClient;
    }

    public String getNom() {
        return nom;
    }

}
