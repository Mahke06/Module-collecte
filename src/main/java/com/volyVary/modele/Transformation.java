package com.volyVary.modele;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "transformation")
public class Transformation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idTransformation;

    public int getidTransformation(){
        return idTransformation;
    }
    public void setidTransformation(int idTransformation){
        this.idTransformation = idTransformation;
    }
    
}
