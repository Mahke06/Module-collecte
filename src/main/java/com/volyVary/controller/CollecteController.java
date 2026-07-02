package com.volyVary.controller;

import com.volyVary.modele.Client;
import com.volyVary.modele.HistoriqueCollecte;
import com.volyVary.modele.LotPaddy;
import com.volyVary.repository.ClientRepository;
import com.volyVary.repository.HistoriqueCollecteRepository;
import com.volyVary.service.CollecteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/collectes")
public class CollecteController {

    @Autowired
    private CollecteService collecteService;

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private HistoriqueCollecteRepository historiqueCollecteRepository;

    
    // Formulaire nouveau achat
    @GetMapping("/nouveau")
    public String formulaireNouveauAchat(Model model) {
        model.addAttribute("now", LocalDateTime.now());
        List<Client> clients = clientRepository.findAll();
        model.addAttribute("clients", clients);
        return "collecte/formulaire-collecte";
    }



    // Calculer collecte (validation)
    @PostMapping("/calculer")
    public String calculerCollecte(@RequestParam int clientId, @RequestParam Double quantite, @RequestParam Double prixUnitaire, @RequestParam Double tauxHumidite, Model model) {
        Client client = clientRepository.TrouverParIdClient(clientId);
        if (client == null) {
            return "redirect:/collectes/nouveau?erreur=Client non trouvé";
        }

        LotPaddy lot = collecteService.calculerCollecte(clientId, quantite, prixUnitaire, tauxHumidite);

        model.addAttribute("lot", lot);
        model.addAttribute("client", client);
        model.addAttribute("prixUnitaireOriginal", prixUnitaire);
        
        return "collecte/validation-collecte";
    }



    // Enregistrer collecte
    @PostMapping("/enregistrer")
    public String enregistrerCollecte(@RequestParam int clientId, @RequestParam Double quantite, @RequestParam Double prixUnitaire, @RequestParam Double tauxHumidite) {
        LotPaddy lot = collecteService.enregistrerCollecte(clientId, quantite, prixUnitaire, tauxHumidite);
        
        if (lot != null) {
            return "redirect:/collectes/detail/" + lot.getIdLotPaddy();
        }
        
        return "redirect:/collectes/nouveau?erreur=Erreur lors de l'enregistrement";
    }




    // Payer lot existant
    @PostMapping("/payer-lot")
    public String payerLot(@RequestParam int idLot) {
        collecteService.payerLot(idLot);
        return "redirect:/collectes/detail/" + idLot;
    }



    // Annuler achat
    @PostMapping("/annuler")
    public String annulerAchat(@RequestParam int idLot) {
        collecteService.annulerAchat(idLot);
        return "redirect:/collectes/liste";
    }



    // Détail d'un lot
    @GetMapping("/detail/{id}")
    public String detailLot(@PathVariable int id, Model model) {
        LotPaddy lot = collecteService.obtenirLot(id);
        
        if (lot == null) {
            return "redirect:/collectes/liste?erreur=Lot non trouvé";
        }
        
        List<HistoriqueCollecte> historique = historiqueCollecteRepository.trouverDernierHistoriqueParLot(id);
        // Client client = historique != null ? historique.getClient() : null;
        // String statutActuel = historique != null ? historique.getStatut().getSigle() : null;
        
        Client client = null;
        String statutActuel = null;
        
        if (!historique.isEmpty()) {
            HistoriqueCollecte dernierHistorique = historique.get(0);
            client = dernierHistorique.getClient();
            statutActuel = dernierHistorique.getStatut().getSigle();
        }

        model.addAttribute("lot", lot);
        model.addAttribute("client", client);
        model.addAttribute("statutActuel", statutActuel);
        
        return "collecte/validation-collecte";
    }



    // Liste des lots
    @GetMapping("/liste")
    public String listerLots(Model model) {
        List<LotPaddy> lots = collecteService.listerLotsActif();
        Double quantiteTotale = collecteService.obtenirQuantiteTotale();
        Double recetteTotale = collecteService.obtenirRecetteTotale();

        model.addAttribute("lots", lots);
        model.addAttribute("quantiteTotale", quantiteTotale != null ? quantiteTotale : 0);
        model.addAttribute("recetteTotale", recetteTotale != null ? recetteTotale : 0);

        return "collecte/liste-lots";
    }
}