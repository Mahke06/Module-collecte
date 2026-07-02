package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "produit")
public class Produit {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idProduit;

    public int getidProduit(){
        return idProduit;
    }
    public void setidProduit(int idProduit){
        this.idProduit = idProduit;
    }
    
}
