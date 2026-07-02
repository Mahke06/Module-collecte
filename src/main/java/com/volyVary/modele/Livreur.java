package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "livreur")
public class Livreur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idLivreur;

    public int getidLivreur(){
        return idLivreur;
    }
    public void setidLivreur(int idLivreur){
        this.idLivreur = idLivreur;
    }
    
}
