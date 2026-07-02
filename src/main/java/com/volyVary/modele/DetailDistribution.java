package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "detail_distribution")
public class DetailDistribution {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idDetailDistribution;

    public int getidDetailDistribution(){
        return idDetailDistribution;
    }
    public void setidDetailDistribution(int idDetailDistribution){
        this.idDetailDistribution = idDetailDistribution;
    }
    
}
