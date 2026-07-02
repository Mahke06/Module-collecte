package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "commune")
public class Commune {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idCommune;

    public int getidCommune(){
        return idCommune;
    }
    public void setidCommune(int idCommune){
        this.idCommune = idCommune;
    }
    
}
