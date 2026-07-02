package com.volyVary.repository;

import com.volyVary.modele.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ClientRepository extends JpaRepository<Client, Integer> {
    @Query("SELECT c FROM Client c WHERE c.reference = :reference")
    Client TrouverParReference(@Param("reference") String reference);   

    @Query("SELECT c FROM Client c WHERE c.id = :idClient")
    Client TrouverParIdClient(int idClient);
}