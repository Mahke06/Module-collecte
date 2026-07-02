package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "historique_transaction")
public class HistoriqueTransaction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idHistoriqueTransaction;

    public int getidHistoriqueTransaction(){
        return idHistoriqueTransaction;
    }
    public void setidHistoriqueTransaction(int idHistoriqueTransaction){
        this.idHistoriqueTransaction = idHistoriqueTransaction;
    }
    
}
