package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "categorie_fourniture")
public class CategorieFourniture {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idCategorieFourniture;

    public int getidCategorieFourniture(){
        return idCategorieFourniture;
    }
    public void setidCategorieFourniture(int idCategorieFourniture){
        this.idCategorieFourniture = idCategorieFourniture;
    }
    
}
