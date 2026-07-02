CREATE TABLE statut_lot_paddy (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    libelle VARCHAR(255),
    sigle VARCHAR(50)
);

CREATE TABLE client (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    reference VARCHAR(100),
    nom VARCHAR(255),
    prenom VARCHAR(255),
    telephone VARCHAR(50),
    date DATE
);

CREATE TABLE collecte (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    prix_unitaire DECIMAL(10, 2)
);

CREATE TABLE lot_paddy (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    reference VARCHAR(100),
    quantite DECIMAL(12, 2),
    taux_humidite DECIMAL(5, 2),
    date DATE,
    prix_collecte DECIMAL(12, 2),
    id_collecte INT,
    FOREIGN KEY (id_collecte) REFERENCES collecte(id)
);

CREATE TABLE historique_collecte (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_client INT,
    id_lot_paddy INT,
    id_statut INT,
    date DATE,
    FOREIGN KEY (id_client) REFERENCES client(id),
    FOREIGN KEY (id_lot_paddy) REFERENCES lot_paddy(id),
    FOREIGN KEY (id_statut) REFERENCES statut_lot_paddy(id)
);

CREATE TABLE reduction (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    humidite1 DECIMAL(5, 2),
    humidite2 DECIMAL(5, 2),
    reduction DECIMAL(5, 2)
);