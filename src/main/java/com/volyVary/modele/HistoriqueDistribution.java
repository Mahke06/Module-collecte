package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "historique_distribution")
public class HistoriqueDistribution {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idHistoriqueDistribution;

    public int getidHistoriqueDistribution(){
        return idHistoriqueDistribution;
    }
    public void setidHistoriqueDistribution(int idHistoriqueDistribution){
        this.idHistoriqueDistribution = idHistoriqueDistribution;
    }
    
}
