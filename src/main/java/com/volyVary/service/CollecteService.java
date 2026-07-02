package com.volyVary.service;

import com.volyVary.modele.*;
import com.volyVary.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.time.LocalDate;
import java.util.List;

@Service
public class CollecteService {

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private CollecteRepository collecteRepository;

    @Autowired
    private LotPaddyRepository lotPaddyRepository;

    @Autowired
    private ReductionRepository reductionRepository;

    @Autowired
    private StatutLotPaddyRepository statutRepository;

    @Autowired
    private HistoriqueCollecteRepository historiqueRepository;


    public LotPaddy calculerCollecte(int clientId, Double quantite, Double prixUnitaire, Double tauxHumidite) {
        
       Client client = clientRepository.TrouverParIdClient(clientId);
        if (client == null) {
            return null;
        }

        Reduction reduction = reductionRepository.trouverReductionParTaux(tauxHumidite);

        double tauxReduction = 0;
        
        if (reduction != null) {
            tauxReduction = reduction.getReduction();
        }

        double prixCorrige = prixUnitaire * (1 - tauxReduction / 100);
        double prixTotal = quantite * prixCorrige;

        Collecte collecte = new Collecte();
        collecte.setPrixUnitaire(prixCorrige);

        LotPaddy lot = new LotPaddy();
        lot.setQuantite(quantite);
        lot.setTauxHumidite(tauxHumidite);
        lot.setDate(LocalDate.now());
        lot.setPrixCollecte(prixTotal);
        lot.setCollecte(collecte);

        return lot;
    }



    @Transactional
    public LotPaddy enregistrerCollecte(int clientId, Double quantite, Double prixUnitaire, Double tauxHumidite) {
        Client client = clientRepository.TrouverParIdClient(clientId);
        if (client == null) {
            return null;
        }

        Reduction reduction = reductionRepository.trouverReductionParTaux(tauxHumidite);
        double tauxReduction = 0;
        if (reduction != null) {
            tauxReduction = reduction.getReduction();
        }

        double prixCorrige = prixUnitaire * (1 - tauxReduction / 100);
        double prixTotal = quantite * prixCorrige;

        Collecte collecte = new Collecte();
        collecte.setPrixUnitaire(prixCorrige);
        collecte = collecteRepository.save(collecte);

        LotPaddy lot = new LotPaddy();
        lot.setReference("LP" + System.currentTimeMillis());
        lot.setQuantite(quantite);
        lot.setTauxHumidite(tauxHumidite);
        lot.setDate(LocalDate.now());
        lot.setPrixCollecte(prixTotal);
        lot.setCollecte(collecte);
        lot = lotPaddyRepository.save(lot);

        StatutLotPaddy statut = statutRepository.trouverParSigle("EN_ATTENTE");
        if (statut == null) {
            return null;
        }

        HistoriqueCollecte historique = new HistoriqueCollecte();
        historique.setClient(client);
        historique.setLotPaddy(lot);
        historique.setStatut(statut);
        historique.setDateHistoriqueCollecte(LocalDate.now());
        historiqueRepository.save(historique);

        return lot;
    }


    @Transactional
    public void payerLot(int idLot) {
        LotPaddy lot = lotPaddyRepository.trouverParIdLotPaddy(idLot);
        if (lot == null) {
            return;
        }

        StatutLotPaddy statutPaye = statutRepository.trouverParSigle("PAYE");
        if (statutPaye == null) {
            return;
        }

        HistoriqueCollecte historique = new HistoriqueCollecte();
        historique.setLotPaddy(lot);
        historique.setStatut(statutPaye);
        historique.setDateHistoriqueCollecte(LocalDate.now());
        historiqueRepository.save(historique);
    }


    public List<LotPaddy> listerLots() {
        return lotPaddyRepository.trouverToutDateDec();
    }


    public LotPaddy obtenirLot(int id) {
        return lotPaddyRepository.trouverParIdLotPaddy(id);
    }


    public Double obtenirQuantiteTotale() {
        return lotPaddyRepository.obtenirQuantiteTotal();
    }

    
    public Double obtenirRecetteTotale() {
        return lotPaddyRepository.obtenirRecetteTotal();
    }

    public void annulerAchat(int idLot){   
        LotPaddy lot = lotPaddyRepository.trouverParIdLotPaddy(idLot);
        if (lot == null) {
            return;
        }

        StatutLotPaddy statutAnnule = statutRepository.trouverParSigle("ANNULE");
        if (statutAnnule == null) {
            return;
        }

        HistoriqueCollecte historique = new HistoriqueCollecte();
        historique.setLotPaddy(lot);
        historique.setStatut(statutAnnule);
        historique.setDateHistoriqueCollecte(LocalDate.now());
        historiqueRepository.save(historique);
    }
}