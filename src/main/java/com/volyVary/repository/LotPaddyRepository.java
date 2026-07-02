package com.volyVary.repository;

import com.volyVary.modele.LotPaddy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


import java.util.List;

@Repository
public interface LotPaddyRepository extends JpaRepository<LotPaddy, Integer> {

    @Query("SELECT SUM(lo.quantite) FROM LotPaddy lo")
    Double obtenirQuantiteTotal();

    @Query("SELECT SUM(lo.prixCollecte) FROM LotPaddy lo")
    Double obtenirRecetteTotal();

    @Query("SELECT lo FROM LotPaddy lo ORDER BY lo.date DESC")
    List<LotPaddy> trouverToutDateDec();

    @Query("SELECT lo FROM LotPaddy lo WHERE lo.idLotPaddy = :id")
    LotPaddy trouverParIdLotPaddy(@Param("id") int id);

    @Query("""
    SELECT DISTINCT lo
    FROM LotPaddy lo
    WHERE (
        SELECT h2.statut.sigle
        FROM HistoriqueCollecte h2
        WHERE h2.lotPaddy.idLotPaddy = lo.idLotPaddy
        ORDER BY h2.dateHistoriqueCollecte DESC
    ) <> 'ANNULE'
    """)
    List<LotPaddy> trouverLotsActif();
    
}