package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "distribution")
public class Distribution {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idDistribution;

    public int getidDistribution(){
        return idDistribution;
    }
    public void setidDistribution(int idDistribution){
        this.idDistribution = idDistribution;
    }
    
}
