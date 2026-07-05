package com.volyVary.controller;

import com.volyVary.modele.Client;
import com.volyVary.modele.HistoriqueCollecte;
import com.volyVary.modele.LotPaddy;
import com.volyVary.repository.ClientRepository;
import com.volyVary.repository.HistoriqueCollecteRepository;
import com.volyVary.service.ClientService;
import com.volyVary.service.CollecteService;
import com.volyVary.service.ImportService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import java.util.Map;


@Controller
@RequestMapping("/collectes")
public class CollecteController {

    @Autowired
    private CollecteService collecteService;

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private final ClientService clientService;

    @Autowired
    private HistoriqueCollecteRepository historiqueCollecteRepository;


    CollecteController(ClientService clientService) {
        this.clientService = clientService;
    }


    @GetMapping("/nouveau")
    public String formulaireNouveauAchat(Model model) {
        model.addAttribute("now", LocalDateTime.now());
        List<Client> clients = clientRepository.findAll();
        model.addAttribute("clients", clients);
        return "collecte/formulaire-collecte";
    }


    @PostMapping("/calculer")
    public String calculerCollecte(@RequestParam String nom, @RequestParam String prenom, @RequestParam String telephone, @RequestParam String dateHeure, @RequestParam Double quantite, @RequestParam Double prixUnitaire, @RequestParam Double tauxHumidite, Model model) {
        try { 
        Client client = clientService.trouverOuCreerClient(nom, prenom, telephone, dateHeure);
        
        if (client == null) {
            return "redirect:/collectes/nouveau?erreur=Client non trouvé";
        }

        LotPaddy lot = collecteService.calculerCollecte(client.getIdClient(), quantite, prixUnitaire, tauxHumidite, dateHeure);

        model.addAttribute("dateHeure", dateHeure);
        model.addAttribute("lot", lot);
        model.addAttribute("client", client);
        model.addAttribute("prixUnitaireOriginal", prixUnitaire);
        
        return "collecte/validation-collecte";

        } catch (IllegalArgumentException e) {
            model.addAttribute("erreur", e.getMessage());
            return "collecte/formulaire-collecte";
        }
    }


    @PostMapping("/enregistrer")
    public String enregistrerCollecte(@RequestParam int clientId, @RequestParam Double quantite, @RequestParam Double prixUnitaire, @RequestParam Double tauxHumidite, @RequestParam String dateHeure, Model model) {
        try { 
        LotPaddy lot = collecteService.enregistrerCollecte(clientId, quantite, prixUnitaire, tauxHumidite, dateHeure);
        
        if (lot != null) {
            return "redirect:/collectes/detail/" + lot.getIdLotPaddy();
        }
        
        return "redirect:/collectes/nouveau?erreur=Erreur lors de l'enregistrement";
        }
        catch (IllegalArgumentException e) {
            model.addAttribute("erreur", e.getMessage());
            return "collecte/formulaire-collecte";
        }
    }




    @PostMapping("/payer-lot")
    public String payerLot(@RequestParam int idLot) {
        collecteService.payerLot(idLot);
        return "redirect:/collectes/detail/" + idLot;
    }


    @PostMapping("/annuler")
    public String annulerAchat(@RequestParam int idLot) {
        collecteService.annulerAchat(idLot);
        return "redirect:/collectes/liste";
    }



    @GetMapping("/detail/{id}")
    public String detailLot(@PathVariable int id, Model model) {
        LotPaddy lot = collecteService.obtenirLot(id);
        
        if (lot == null) {
            return "redirect:/collectes/liste?erreur=Lot non trouvé";
        }
        
        List<HistoriqueCollecte> historique = historiqueCollecteRepository.trouverDernierHistoriqueParLot(id);

        
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


    @GetMapping("/imprimer/{id}")
    public String imprimer(@PathVariable int id, Model model) {
        LotPaddy lot = collecteService.obtenirLot(id);

        if (lot == null) {
            return "redirect:/collectes/liste?erreur=Lot non trouvé";
        }

        List<HistoriqueCollecte> historique = historiqueCollecteRepository.trouverDernierHistoriqueParLot(id);
        HistoriqueCollecte historiques = null;
        if (!historique.isEmpty()) {
            historiques = historique.get(0);
        }
        Client client = null;
        if(historiques != null) {
            client = historiques.getClient();
        }

        model.addAttribute("lot", lot);
        model.addAttribute("client", client);

        return "collecte/imprimer";
    }
    



    @GetMapping("/en-attente")
    public String lotsEnAttente(Model model) {
        List<LotPaddy> tousLesLots = collecteService.listerLotsActif();
        List<LotPaddy> lotsEnAttente = new ArrayList<>();

        for (LotPaddy lot : tousLesLots) {
            List<HistoriqueCollecte> historiques = historiqueCollecteRepository.trouverDernierHistoriqueParLot(lot.getIdLotPaddy());
            if (!historiques.isEmpty() && "EN_ATTENTE".equals(historiques.get(0).getStatut().getSigle())) {
                lotsEnAttente.add(lot);
            }
        }

        Double quantiteTotale = lotsEnAttente.stream().mapToDouble(LotPaddy::getQuantite).sum();
        Double recetteTotale = lotsEnAttente.stream().mapToDouble(LotPaddy::getPrixCollecte).sum();

        model.addAttribute("lots", lotsEnAttente);
        model.addAttribute("quantiteTotale", quantiteTotale);
        model.addAttribute("recetteTotale", recetteTotale);

        return "collecte/liste-en-attente";
    }



    @GetMapping("/valides")
    public String lotsValides(Model model) {
        List<LotPaddy> tousLesLots = collecteService.listerLotsActif();
        List<LotPaddy> lotsValides = new ArrayList<>();

        for (LotPaddy lot : tousLesLots) {
            List<HistoriqueCollecte> historiques = historiqueCollecteRepository.trouverDernierHistoriqueParLot(lot.getIdLotPaddy());
            if (!historiques.isEmpty() && "VALIDE".equals(historiques.get(0).getStatut().getSigle())) {
                lotsValides.add(lot);
            }
        }

        Double quantiteTotale = lotsValides.stream().mapToDouble(LotPaddy::getQuantite).sum();
        Double recetteTotale = lotsValides.stream().mapToDouble(LotPaddy::getPrixCollecte).sum();

        model.addAttribute("lots", lotsValides);
        model.addAttribute("quantiteTotale", quantiteTotale);
        model.addAttribute("recetteTotale", recetteTotale);

        return "collecte/liste-valides";
    }



    @Autowired
    private ImportService importService;

    @PostMapping("/lire-excel")
    @ResponseBody
    public Map<String, Object> lireExcel(@RequestParam("fichier") MultipartFile fichier) {
        try {
            return importService.lireExcel(fichier);
        } catch (IllegalArgumentException e) {
            Map<String, Object> erreur = new HashMap<>();
            erreur.put("erreur", e.getMessage());
            return erreur;
        }
    }
}