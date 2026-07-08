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
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.data.domain.Page;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import java.util.Map;
import java.util.stream.Collectors;

import java.util.Comparator;

import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFRow;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Chunk;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfWriter;
import java.awt.Color;

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
    public String listerLots(Model model, @RequestParam(required = false) String reference, @RequestParam(required = false) String dateMin, @RequestParam(required = false) String dateMax, @RequestParam(required = false) Double quantiteMin, @RequestParam(required = false) Double quantiteMax, @RequestParam(required = false) Double prixMin, @RequestParam(required = false) Double prixMax, @RequestParam(required = false) Double totalMin, @RequestParam(required = false) Double totalMax, @RequestParam(defaultValue = "0") int page,
    @RequestParam(required = false) String triePar, @RequestParam(required = false) String ordre) {
        List<LotPaddy> lots = getLotsFiltresEtTries(reference, dateMin, dateMax, quantiteMin, quantiteMax, prixMin, prixMax, totalMin, totalMax, triePar, ordre);

        int pageMax = 10;
        int startPage = page * pageMax;
        int endPage = Math.min(startPage + pageMax, lots.size());
        List<LotPaddy> lotsEnPage = startPage < lots.size() ? lots.subList(startPage, endPage) : List.of();
        Page<LotPaddy> pageLots = new PageImpl<>(lotsEnPage, PageRequest.of(page, pageMax), lots.size());

        Double quantiteTotale = collecteService.obtenirQuantiteTotale();
        Double recetteTotale = collecteService.obtenirRecetteTotale();

        model.addAttribute("lots", pageLots.getContent());
        model.addAttribute("pageCourante", pageLots.getNumber());
        model.addAttribute("pageTotales", pageLots.getTotalPages());
        model.addAttribute("quantiteTotale", quantiteTotale != null ? quantiteTotale : 0);
        model.addAttribute("recetteTotale", recetteTotale != null ? recetteTotale : 0);
        
        model.addAttribute("reference", reference);
        model.addAttribute("dateMin", dateMin);
        model.addAttribute("dateMax", dateMax);
        model.addAttribute("quantiteMin", quantiteMin);
        model.addAttribute("quantiteMax", quantiteMax);
        model.addAttribute("prixMin", prixMin);
        model.addAttribute("prixMax", prixMax);
        model.addAttribute("totalMin", totalMin);
        model.addAttribute("totalMax", totalMax);

        model.addAttribute("triePar", triePar);
        model.addAttribute("ordre", ordre);

        return "collecte/liste-lots";
    }


    @GetMapping("/export/csv")
    public void exportCsv(
            HttpServletResponse response,
            @RequestParam(required = false) String reference,
            @RequestParam(required = false) String dateMin,
            @RequestParam(required = false) String dateMax,
            @RequestParam(required = false) Double quantiteMin,
            @RequestParam(required = false) Double quantiteMax,
            @RequestParam(required = false) Double prixMin,
            @RequestParam(required = false) Double prixMax,
            @RequestParam(required = false) Double totalMin,
            @RequestParam(required = false) Double totalMax,
            @RequestParam(required = false) String triePar,
            @RequestParam(required = false) String ordre) throws IOException {

        List<LotPaddy> lots = getLotsFiltresEtTries(reference, dateMin, dateMax,
                quantiteMin, quantiteMax, prixMin, prixMax, totalMin, totalMax, triePar, ordre);

        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=lots-paddy.csv");

        try (PrintWriter w = response.getWriter()) {
            w.println("Référence;Date;Quantité (kg);Prix unitaire (Ar);Total (Ar)");
            for (LotPaddy lot : lots) {
                w.printf("%s;%s;%.2f;%.0f;%.0f%n",
                        lot.getReference(),
                        lot.getDate(),
                        lot.getQuantite(),
                        lot.getCollecte().getPrixUnitaire(),
                        lot.getPrixCollecte());
            }
        }
    }


    @GetMapping("/export/excel")
    public void exportExcel(
            HttpServletResponse response,
            @RequestParam(required = false) String reference,
            @RequestParam(required = false) String dateMin,
            @RequestParam(required = false) String dateMax,
            @RequestParam(required = false) Double quantiteMin,
            @RequestParam(required = false) Double quantiteMax,
            @RequestParam(required = false) Double prixMin,
            @RequestParam(required = false) Double prixMax,
            @RequestParam(required = false) Double totalMin,
            @RequestParam(required = false) Double totalMax,
            @RequestParam(required = false) String triePar,
            @RequestParam(required = false) String ordre) throws IOException {

        List<LotPaddy> lots = getLotsFiltresEtTries(reference, dateMin, dateMax,
                quantiteMin, quantiteMax, prixMin, prixMax, totalMin, totalMax, triePar, ordre);

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=lots-paddy.xlsx");

        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("Lots de paddy");

        String[] headers = {"Référence", "Date", "Quantité (kg)", "Prix unitaire (Ar)", "Total (Ar)"};
        XSSFRow headerRow = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            headerRow.createCell(i).setCellValue(headers[i]);
        }

        int rowNum = 1;
        for (LotPaddy lot : lots) {
            XSSFRow row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(lot.getReference());
            row.createCell(1).setCellValue(lot.getDate().toString());
            row.createCell(2).setCellValue(lot.getQuantite());
            row.createCell(3).setCellValue(lot.getCollecte().getPrixUnitaire());
            row.createCell(4).setCellValue(lot.getPrixCollecte());
        }

        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
        }

        workbook.write(response.getOutputStream());
        workbook.close();
    }


    @GetMapping("/export/pdf")
    public void exportPdf(
            HttpServletResponse response,
            @RequestParam(required = false) String reference,
            @RequestParam(required = false) String dateMin,
            @RequestParam(required = false) String dateMax,
            @RequestParam(required = false) Double quantiteMin,
            @RequestParam(required = false) Double quantiteMax,
            @RequestParam(required = false) Double prixMin,
            @RequestParam(required = false) Double prixMax,
            @RequestParam(required = false) Double totalMin,
            @RequestParam(required = false) Double totalMax,
            @RequestParam(required = false) String triePar,
            @RequestParam(required = false) String ordre) throws IOException, DocumentException {

        List<LotPaddy> lots = getLotsFiltresEtTries(reference, dateMin, dateMax,
                quantiteMin, quantiteMax, prixMin, prixMax, totalMin, totalMax, triePar, ordre);

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=lots-paddy.pdf");

        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        document.add(new Paragraph("Liste des lots de paddy"));
        document.add(Chunk.NEWLINE);

        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100);

        String[] headers = {"Référence", "Date", "Quantité (kg)", "Prix unitaire (Ar)", "Total (Ar)"};
        for (String h : headers) {
            PdfPCell cell = new PdfPCell(new Phrase(h));
            cell.setBackgroundColor(new Color(200, 200, 200));
            table.addCell(cell);
        }

        for (LotPaddy lot : lots) {
            table.addCell(lot.getReference());
            table.addCell(lot.getDate().toString());
            table.addCell(String.format("%.2f", lot.getQuantite()));
            table.addCell(String.format("%.0f", lot.getCollecte().getPrixUnitaire()));
            table.addCell(String.format("%.0f", lot.getPrixCollecte()));
        }

        document.add(table);
        document.close();
    }


    private List<LotPaddy> getLotsFiltresEtTries(
            String reference, String dateMin, String dateMax,
            Double quantiteMin, Double quantiteMax, Double prixMin, Double prixMax,
            Double totalMin, Double totalMax, String triePar, String ordre) {
        List<LotPaddy> lots = collecteService.listerLotsActif();
        lots = filtrerLots(lots, reference, dateMin, dateMax,
                quantiteMin, quantiteMax, prixMin, prixMax, totalMin, totalMax);
        lots = trierLots(lots, triePar, ordre);
        return lots;
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
    public String lotsEnAttente(Model model, @RequestParam(required = false) String reference, @RequestParam(required = false) String dateMin, @RequestParam(required = false) String dateMax, @RequestParam(required = false) Double quantiteMin, @RequestParam(required = false) Double quantiteMax, @RequestParam(required = false) Double prixMin, @RequestParam(required = false) Double prixMax, @RequestParam(required = false) Double totalMin, @RequestParam(required = false) Double totalMax, 
    @RequestParam(required = false) String triePar, @RequestParam(required = false) String ordre) {
        List<LotPaddy> tousLesLots = collecteService.listerLotsActif();
        List<LotPaddy> lotsEnAttente = new ArrayList<>();

        for (LotPaddy lot : tousLesLots) {
            List<HistoriqueCollecte> historiques = historiqueCollecteRepository.trouverDernierHistoriqueParLot(lot.getIdLotPaddy());
            if (!historiques.isEmpty() && "EN_ATTENTE".equals(historiques.get(0).getStatut().getSigle())) {
                lotsEnAttente.add(lot);
            }
        }
        
        lotsEnAttente = filtrerLots(lotsEnAttente, reference, dateMin, dateMax, quantiteMin, quantiteMax, prixMin, prixMax, totalMin, totalMax);


        lotsEnAttente = trierLots(lotsEnAttente, triePar, ordre);

        Double quantiteTotale = lotsEnAttente.stream().mapToDouble(LotPaddy::getQuantite).sum();
        Double recetteTotale = lotsEnAttente.stream().mapToDouble(LotPaddy::getPrixCollecte).sum();

        model.addAttribute("lots", lotsEnAttente);
        model.addAttribute("quantiteTotale", quantiteTotale);
        model.addAttribute("recetteTotale", recetteTotale);

        model.addAttribute("reference", reference);
        model.addAttribute("dateMin", dateMin);
        model.addAttribute("dateMax", dateMax);
        model.addAttribute("quantiteMin", quantiteMin);
        model.addAttribute("quantiteMax", quantiteMax);
        model.addAttribute("prixMin", prixMin);
        model.addAttribute("prixMax", prixMax);
        model.addAttribute("totalMin", totalMin);
        model.addAttribute("totalMax", totalMax);

        model.addAttribute("triePar", triePar);
        model.addAttribute("ordre", ordre);

        return "collecte/liste-en-attente";
    }



    @GetMapping("/valides")
    public String lotsValides(Model model, @RequestParam(required = false) String reference, @RequestParam(required = false) String dateMin, @RequestParam(required = false) String dateMax, @RequestParam(required = false) Double quantiteMin, @RequestParam(required = false) Double quantiteMax, @RequestParam(required = false) Double prixMin, @RequestParam(required = false) Double prixMax, @RequestParam(required = false) Double totalMin, @RequestParam(required = false) Double totalMax, 
    @RequestParam(required = false) String triePar, @RequestParam(required = false) String ordre) {
        List<LotPaddy> tousLesLots = collecteService.listerLotsActif();
        List<LotPaddy> lotsValides = new ArrayList<>();

        for (LotPaddy lot : tousLesLots) {
            List<HistoriqueCollecte> historiques = historiqueCollecteRepository.trouverDernierHistoriqueParLot(lot.getIdLotPaddy());
            if (!historiques.isEmpty() && "VALIDE".equals(historiques.get(0).getStatut().getSigle())) {
                lotsValides.add(lot);
            }
        }

        lotsValides = filtrerLots(lotsValides, reference, dateMin, dateMax, quantiteMin, quantiteMax, prixMin, prixMax, totalMin, totalMax);

        lotsValides = trierLots(lotsValides, triePar, ordre);

        Double quantiteTotale = lotsValides.stream().mapToDouble(LotPaddy::getQuantite).sum();
        Double recetteTotale = lotsValides.stream().mapToDouble(LotPaddy::getPrixCollecte).sum();

        model.addAttribute("lots", lotsValides);
        model.addAttribute("quantiteTotale", quantiteTotale);
        model.addAttribute("recetteTotale", recetteTotale);

        model.addAttribute("reference", reference);
        model.addAttribute("dateMin", dateMin);
        model.addAttribute("dateMax", dateMax);
        model.addAttribute("quantiteMin", quantiteMin);
        model.addAttribute("quantiteMax", quantiteMax);
        model.addAttribute("prixMin", prixMin);
        model.addAttribute("prixMax", prixMax);
        model.addAttribute("totalMin", totalMin);
        model.addAttribute("totalMax", totalMax);

        model.addAttribute("triePar", triePar);
        model.addAttribute("ordre", ordre);

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


    private List<LotPaddy> filtrerLots(List<LotPaddy> lots, String reference, String dateMin, String dateMax, Double quantiteMin, Double quantiteMax, Double prixMin, Double prixMax, Double totalMin, Double totalMax) {
        return lots.stream()
            .filter(lot -> {
                // Filtre référence (texte partiel)
                if (reference != null && !reference.trim().isEmpty()) {
                    if (!lot.getReference().toLowerCase().contains(reference.trim().toLowerCase())) {
                        return false;
                    }
                }

                // Filtre date min
                if (dateMin != null && !dateMin.isEmpty()) {
                    LocalDate min = LocalDate.parse(dateMin);
                    if (lot.getDate().isBefore(min)) {
                        return false;
                    }
                }

                // Filtre date max
                if (dateMax != null && !dateMax.isEmpty()) {
                    LocalDate max = LocalDate.parse(dateMax);
                    if (lot.getDate().isAfter(max)) {
                        return false;
                    }
                }

                // Filtre quantité min
                if (quantiteMin != null && lot.getQuantite() < quantiteMin) {
                    return false;
                }

                // Filtre quantité max
                if (quantiteMax != null && lot.getQuantite() > quantiteMax) {
                    return false;
                }

                // Filtre prix unitaire min
                if (prixMin != null && lot.getCollecte().getPrixUnitaire() < prixMin) {
                    return false;
                }

                // Filtre prix unitaire max
                if (prixMax != null && lot.getCollecte().getPrixUnitaire() > prixMax) {
                    return false;
                }

                // Filtre total min
                if (totalMin != null && lot.getPrixCollecte() < totalMin) {
                    return false;
                }

                // Filtre total max
                if (totalMax != null && lot.getPrixCollecte() > totalMax) {
                    return false;
                }

                return true;
            })
            .collect(Collectors.toList());
    }





   private List<LotPaddy> trierLots(List<LotPaddy> lots, String trierPar, String ordre) {
        if (trierPar == null || trierPar.isEmpty()) {
            return lots;
        }

        Comparator<LotPaddy> comparateur = null;

        switch (trierPar) {
            case "reference":
                comparateur = Comparator.comparing(lot -> lot.getReference());
                break;

            case "date":
                comparateur = Comparator.comparing(lot -> lot.getDate());
                break;

            case "quantite":
                comparateur = Comparator.comparing(lot -> lot.getQuantite());
                break;

            case "prix":
                comparateur = Comparator.comparing(lot -> lot.getCollecte().getPrixUnitaire());
                break;

            case "total":
                comparateur = Comparator.comparing(lot -> lot.getPrixCollecte());
                break;
        }

        if (comparateur == null) {
            return lots;
        }

        if ("desc".equalsIgnoreCase(ordre)) {
            comparateur = comparateur.reversed();
        }

        lots.sort(comparateur);

        return lots;
    }
}