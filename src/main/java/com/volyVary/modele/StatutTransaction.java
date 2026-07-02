package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "statut_transaction")
public class StatutTransaction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idStatutTransaction;

    public int getidStatutTransaction(){
        return idStatutTransaction;
    }
    public void setidStatutTransaction(int idStatutTransaction){
        this.idStatutTransaction = idStatutTransaction;
    }
    
}
