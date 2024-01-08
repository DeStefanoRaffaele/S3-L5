-- Creazione della tabella 'vendite'
CREATE TABLE vendite (
    idtransazione INT PRIMARY KEY,
    categoria_prodotto VARCHAR(50),
    costo_vendita DECIMAL(10, 2),
    sconto INT
);

-- Creazione della tabella 'dettagli_vendite'
CREATE TABLE dettagli_vendite (
    idtransazione INT PRIMARY KEY,
    data_transazione_acquisto DATE,
    quantita INT
);
-- Inserimento dati nella tabella 'vendite'
INSERT INTO vendite (idtransazione, categoria_prodotto, costo_vendita, sconto)
VALUES
    (1, 'Elettronica', 500.50, 20),
    (2, 'Abbigliamento', 100.90, 10),
    (3, 'Casa', 200.00, 15),
    (4, 'Cancelleria', 150.00, 25),
    (5, 'Informatica', 289.00, 75),
    (6, 'Informatica', 100.00, 75),
    (7, 'Elettronica', 250.10, 30),
    (8, 'Casa', 270.10, 30),
    (9, 'Meccanica', 180.00, 35),
    (10, 'Lavanderia', 162.50, 60),
    (11, 'Abbigliamento', 250.50, 25),
    (12, 'Intimo', 120.00, 55),
    (13, 'Lavanderia', 210.00, 30),
    (14, 'Salute', 250.90, 15),
    (15, 'Medicinali', 350.00, 70),
    (16, 'Elettronica', 100.50, 20),
    (17, 'Abbigliamento', 105.90, 15),
    (18, 'Casa', 200.50, 15),
    (19, 'Cancelleria', 155.00, 45),
    (20, 'Informatica', 219.00, 65),
    (21, 'Informatica', 200.00, 75),
    (22, 'Elettronica', 100.10, 40),
    (23, 'Casa', 130.10, 30),
    (24, 'Meccanica', 140.00, 40),
    (25, 'Lavanderia', 112.50, 55),
    (26, 'Abbigliamento', 800.50, 55),
    (27, 'Intimo', 80.00, 15),
    (28, 'Lavanderia', 210.50, 30),
    (29, 'Salute', 50.90, 80),
    (30, 'Medicinali', 260.00, 25);

-- Inserimento dati nella tabella 'dettagli_vendite'
INSERT INTO dettagli_vendite (idtransazione, data_transazione_acquisto, quantita)
VALUES
    (1,'2024-01-08', 2),
    (2,'2023-01-10', 10),
    (3,'2023-10-10', 3),
    (4,'2023-11-25', 15),
    (5,'2023-01-10', 29),
    (6,'2023-11-20', 25),
    (7,'2024-01-01', 20),
    (8,'2023-06-22', 10),
    (9,'2023-02-02', 30),
    (10,'2023-11-25', 7),
    (11,'2023-02-25', 29),
    (12,'2024-01-02', 9),
    (13,'2023-11-27', 17),
    (14,'2023-01-01', 2),
    (15,'2023-09-30', 19),
    (16,'2024-01-05', 21),
    (17,'2023-04-05', 10),
    (18,'2023-03-10', 3),
    (19,'2023-03-25', 15),
    (20,'2023-07-10', 29),
    (21,'2023-08-20', 25),
    (22,'2024-04-01', 20),
    (23,'2023-06-22', 10),
    (24,'2023-09-02', 30),
    (25,'2023-10-25', 7),
    (26,'2023-03-25', 29),
    (27,'2024-01-07', 9),
    (28,'2023-11-27', 17),
    (29,'2023-01-10', 2),
    (30,'2023-09-30', 19);



#Seleziona tutte le vendite avvenute in una specifica data.

SELECT v.categoria_prodotto, v.costo_vendita
FROM vendite v
JOIN dettagli_vendite d ON v.idtransazione = d.idtransazione
WHERE d.data_transazione_acquisto = '2023-01-10';



#Elenco delle vendite con sconti maggiori del 50%.

SELECT *
FROM vendite
WHERE sconto > 50;



#Calcola il totale delle vendite (costo) per categoria.

SELECT categoria_prodotto, SUM(costo_vendita) AS vendite_totali
FROM vendite
GROUP BY categoria_prodotto;



#Trova il numero totale di prodotti venduti per ogni categoria.

SELECT categoria_prodotto, COUNT(costo_vendita) AS num_vendite
FROM vendite
GROUP BY categoria_prodotto;



#Seleziona le vendite dell'ultimo trimestre.

SELECT v.categoria_prodotto, v.costo_vendita
FROM vendite v
JOIN dettagli_vendite d ON v.idtransazione = d.idtransazione
WHERE d.data_transazione_acquisto >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
AND d.data_transazione_acquisto <= CURDATE();



#Raggruppa le vendite per mese e calcola il totale delle vendite per ogni mese.

SELECT
    YEAR(d.data_transazione_acquisto) AS anno,
    MONTH(d.data_transazione_acquisto) AS mese,
    SUM(v.costo_vendita) AS totale_vendite
FROM vendite v
JOIN dettagli_vendite d ON v.idtransazione = d.idtransazione
GROUP BY YEAR(d.data_transazione_acquisto), MONTH(d.data_transazione_acquisto)
ORDER BY YEAR(d.data_transazione_acquisto) ASC;



#Trova la categoria con lo sconto medio più alto.

SELECT categoria_prodotto, AVG(sconto) AS sconto_medio
FROM vendite
GROUP BY categoria_prodotto
ORDER BY sconto_medio DESC;



#Confronta le vendite mese per mese per vedere l'incremento o il decremento delle vendite. 
#Calcola l’incremento o decremento mese per mese.

SELECT
    YEAR(d.data_transazione_acquisto) AS anno,
    MONTH(d.data_transazione_acquisto) AS mese,
    v.costo_vendita
FROM vendite v
JOIN dettagli_vendite d ON v.idtransazione = d.idtransazione
GROUP BY YEAR(d.data_transazione_acquisto), MONTH(d.data_transazione_acquisto), v.costo_vendita
ORDER BY YEAR(d.data_transazione_acquisto) ASC;



#Confronta le vendite totali in diverse stagioni.

SELECT SUM(v.costo_vendita) AS costo_totale, 
    CASE
        WHEN MONTH(data_transazione_acquisto) BETWEEN 1 AND 3 THEN 'Gen-Feb-Mar'  
        WHEN MONTH(data_transazione_acquisto) BETWEEN 4 AND 6 THEN 'Apr-Mag-Giu' 
        WHEN MONTH(data_transazione_acquisto) BETWEEN 7 AND 9 THEN 'Lug-Ago-Set' 
        WHEN MONTH(data_transazione_acquisto) BETWEEN 10 AND 12 THEN 'Ott-Nov-Dic' 
    END AS quadrimestre,
    YEAR(data_transazione_acquisto) AS anno
FROM vendite v 
JOIN dettagli_vendite d ON v.idtransazione = d.idtransazione
GROUP BY anno, quadrimestre
ORDER BY anno ASC, quadrimestre ASC;



#Supponendo di avere una tabella clienti con i campi IDCliente e IDVendita, 
#scrivi una query per trovare i top 5 clienti con il maggior numero di acquisti. 

SELECT IDCliente, COUNT(IDVendita) AS NumeroAcquisti
FROM clienti
GROUP BY IDCliente
ORDER BY NumeroAcquisti DESC
LIMIT 5;

