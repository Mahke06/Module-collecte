package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "fourniture")
public class Fourniture {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idFourniture;

    public int getidFourniture(){
        return idFourniture;
    }
    public void setidFourniture(int idFourniture){
        this.idFourniture = idFourniture;
    }
    
}
