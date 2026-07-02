package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "type_transaction")
public class TypeTransaction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idTypeTransaction;

    public int getidTypeTransaction(){
        return idTypeTransaction;
    }
    public void setidTypeTransaction(int idTypeTransaction){
        this.idTypeTransaction = idTypeTransaction;
    }
    
}
