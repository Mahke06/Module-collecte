package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "detail_transaction")
public class DetailTransaction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idDetailTransaction;

    public int getidDetailTransaction(){
        return idDetailTransaction;
    }
    public void setidDetailTransaction(int idDetailTransaction){
        this.idDetailTransaction = idDetailTransaction;
    }
    
}
