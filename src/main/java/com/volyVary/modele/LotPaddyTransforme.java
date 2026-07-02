package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "lot_paddy_transforme")
public class LotPaddyTransforme {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idLotPaddyTransforme;

    public int getidLotPaddyTransforme(){
        return idLotPaddyTransforme;
    }
    public void setidLotPaddyTransforme(int idLotPaddyTransforme){
        this.idLotPaddyTransforme = idLotPaddyTransforme;
    }
    
}
