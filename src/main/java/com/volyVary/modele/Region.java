package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "region")
public class Region {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idRegion;

    public int getidRegion(){
        return idRegion;
    }
    public void setidRegion(int idRegion){
        this.idRegion = idRegion;
    }
    
}
