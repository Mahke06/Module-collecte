package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "statut_distribution")
public class StatutDistribution {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idStatutDistribution;

    public int getidStatutDistribution(){
        return idStatutDistribution;
    }
    public void setidStatutDistribution(int idStatutDistribution){
        this.idStatutDistribution = idStatutDistribution;
    }
    
}
