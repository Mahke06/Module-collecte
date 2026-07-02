package com.volyVary.repository;

import com.volyVary.modele.LotPaddy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


import java.util.List;

@Repository
public interface LotPaddyRepository extends JpaRepository<LotPaddy, Integer> {

    @Query("""
        SELECT SUM(lo.quantite) FROM LotPaddy lo
        WHERE EXISTS (
            SELECT 1
            FROM HistoriqueCollecte h
            WHERE h.lotPaddy = lo
                AND h.idHistoriqueCollecte = (
                    SELECT MAX(h2.idHistoriqueCollecte)
                    FROM HistoriqueCollecte h2
                    WHERE h2.lotPaddy = lo)
                AND h.statut.sigle != 'ANNULE')
    """)
    Double obtenirQuantiteTotal();

    @Query("""
        SELECT SUM(lo.prixCollecte) FROM LotPaddy lo
        WHERE EXISTS (
        SELECT 1
        FROM HistoriqueCollecte h
        WHERE h.lotPaddy = lo
            AND h.idHistoriqueCollecte = (
                SELECT MAX(h2.idHistoriqueCollecte)
                FROM HistoriqueCollecte h2
                WHERE h2.lotPaddy = lo)
                AND h.statut.sigle != 'ANNULE')
    """)
    Double obtenirRecetteTotal();

    @Query("SELECT lo FROM LotPaddy lo ORDER BY lo.date DESC")
    List<LotPaddy> trouverToutDateDec();

    @Query("SELECT lo FROM LotPaddy lo WHERE lo.idLotPaddy = :id")
    LotPaddy trouverParIdLotPaddy(@Param("id") int id);

    @Query("""
    SELECT lo
    FROM LotPaddy lo
    WHERE NOT EXISTS (
        SELECT 1
        FROM HistoriqueCollecte h
        WHERE h.lotPaddy = lo
          AND h.idHistoriqueCollecte = (
              SELECT MAX(h2.idHistoriqueCollecte)
              FROM HistoriqueCollecte h2
              WHERE h2.lotPaddy = lo
          )
          AND h.statut.sigle = 'ANNULE'
    )
    ORDER BY lo.date DESC
    """)
    List<LotPaddy> trouverLotsActif();
    
}