package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "transaction")
public class Transaction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idTransaction;

    public int getidTransaction(){
        return idTransaction;
    }
    public void setidTransaction(int idTransaction){
        this.idTransaction = idTransaction;
    }
    
}
