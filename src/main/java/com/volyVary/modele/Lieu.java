package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "lieu")
public class Lieu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idLieu;

    public int getidLieu(){
        return idLieu;
    }
    public void setidLieu(int idLieu){
        this.idLieu = idLieu;
    }
    
}
