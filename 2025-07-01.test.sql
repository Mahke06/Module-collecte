-- Données de test pour statut_lot_paddy
INSERT INTO statut_lot_paddy (libelle, sigle) VALUES
('En attente de validation', 'EN_ATTENTE'),
('Validé et payé', 'VALIDE'),
('Annulé', 'ANNULE');

-- Données de test pour reduction
INSERT INTO reduction (humidite1, humidite2, reduction) VALUES
(0, 15, 0),      -- 0% à 15% → 0% de réduction
(15, 20, 20),    -- 15% à 20% → 20% de réduction
(20, 100, 50);   -- Plus de 20% → 50% de réduction

INSERT INTO client (reference, nom, prenom, telephone, date) VALUES
('C001', 'Rakoto', 'Jean', '0341234567', '2025-07-01'),
('C002', 'Rabe', 'Marie', '0349876543', '2025-07-01'),
('C003', 'Andrianarisoa', 'Hery', '0345678901', '2025-07-01');