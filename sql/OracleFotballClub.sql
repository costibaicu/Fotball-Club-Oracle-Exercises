-----------------------------------------------------------------BAZA DE DATE - PROIECT FCSB-----------------------------------------------------------------------
-- Tabelul MEMBRU 
CREATE TABLE membru (
    id_membru NUMBER(6) CONSTRAINT pk_membru PRIMARY KEY,
    nume VARCHAR2(50) NOT NULL,
    data_nasterii DATE,
    adresa VARCHAR2(100),
    telefon CHAR(10),
    email VARCHAR2(50),
    data_inscriere DATE DEFAULT SYSDATE
);

-- Tabelul SECTIE (fostul Departament din desen)
CREATE TABLE sectie (
    id_sectie NUMBER(4) CONSTRAINT pk_sectie PRIMARY KEY,
    nume_sectie VARCHAR2(50) NOT NULL,
    descriere VARCHAR2(200)
);
x
-- Tabelul ANTRENOR
CREATE TABLE antrenor (
    id_antrenor NUMBER(6) CONSTRAINT pk_antrenor PRIMARY KEY,
    nume VARCHAR2(50) NOT NULL,
    specializare VARCHAR2(50),
    telefon CHAR(10)
);

-- Tabelul SALA
CREATE TABLE sala (
    id_sala NUMBER(4) CONSTRAINT pk_sala PRIMARY KEY,
    nume_sala VARCHAR2(50) NOT NULL,
    capacitate NUMBER(5),
    tip_sala VARCHAR2(30),
    echipamente VARCHAR2(200)
);

-- Tabelul ABONAMENT
CREATE TABLE abonament (
    id_abonament NUMBER(4) CONSTRAINT pk_abonament PRIMARY KEY,
    tip VARCHAR2(30) NOT NULL,
    pret NUMBER(8,2) NOT NULL,
    descriere VARCHAR2(100)
);

-- Tabelul GRUPA (legat de SECTIE si ANTRENOR)
CREATE TABLE grupa (
    id_grupa NUMBER(4) CONSTRAINT pk_grupa PRIMARY KEY,
    id_sectie NUMBER(4),
    id_antrenor NUMBER(6),
    nume_grupa VARCHAR2(50) NOT NULL,
    nivel VARCHAR2(30), --ex: juniori, seniori
    orar VARCHAR2(100),
    CONSTRAINT fk_grupa_sectie FOREIGN KEY (id_sectie) REFERENCES sectie(id_sectie),
    CONSTRAINT fk_grupa_antrenor FOREIGN KEY (id_antrenor) REFERENCES antrenor(id_antrenor)
);

-- Tabelul PLATA (legat de MEMBRU)
CREATE TABLE plata (
    id_plata NUMBER(8) CONSTRAINT pk_plata PRIMARY KEY,
    id_membru NUMBER(6),
    suma NUMBER(8,2) NOT NULL,
    data_plata DATE DEFAULT SYSDATE,
    metoda VARCHAR2(20), --ex: cash sau card 
    descriere VARCHAR2(100),
    CONSTRAINT fk_plata_membru FOREIGN KEY (id_membru) REFERENCES membru(id_membru)
);

-- Tabelul ACTIVITATE (Leaga GRUPA de SALA)
CREATE TABLE activitate (
    id_activitate NUMBER(8) CONSTRAINT pk_activitate PRIMARY KEY,
    id_grupa NUMBER(4),
    id_sala NUMBER(4),
    tip_activitate VARCHAR2(50), -- ex: antrenament fizic, tactic
    CONSTRAINT fk_activitate_grupa FOREIGN KEY (id_grupa) REFERENCES grupa(id_grupa),
    CONSTRAINT fk_activitate_sala FOREIGN KEY (id_sala) REFERENCES sala(id_sala)
);

-- Tabelul MEMBRU_ABONAMENT 
CREATE TABLE membru_abonament (
    id_membru_abonament NUMBER(8) CONSTRAINT pk_membru_abo PRIMARY KEY,
    id_membru NUMBER(6),
    id_abonament NUMBER(4),
    data_start DATE NOT NULL,
    data_end DATE NOT NULL,
    CONSTRAINT fk_ma_membru FOREIGN KEY (id_membru) REFERENCES membru(id_membru),
    CONSTRAINT fk_ma_abonament FOREIGN KEY (id_abonament) REFERENCES abonament(id_abonament)
);

-- Tabelul MEMBRU_GRUPA 
CREATE TABLE membru_grupa (
    id_membru_grupa NUMBER(8) CONSTRAINT pk_membru_grupa PRIMARY KEY,
    id_membru NUMBER(6),
    id_grupa NUMBER(4),
    rol_grupa VARCHAR2(30), --ex: capitan
    CONSTRAINT fk_mg_membru FOREIGN KEY (id_membru) REFERENCES membru(id_membru),
    CONSTRAINT fk_mg_grupa FOREIGN KEY (id_grupa) REFERENCES grupa(id_grupa)
);

-- 1. SECTII
INSERT INTO sectie VALUES (1, 'Fotbal Seniori', 'Echipa mare FCSB');
INSERT INTO sectie VALUES (2, 'Academie Juniori', 'Centrul de copii si juniori');
INSERT INTO sectie VALUES (3, 'Recuperare Medicala', 'Departament recuperare');

-- 2. ANTRENORI
INSERT INTO antrenor VALUES (10, 'Elias Charalambous', 'Licenta UEFA Pro', '0722111222');
INSERT INTO antrenor VALUES (20, 'Mihai Pintilii', 'Antrenor Secund', '0722333444');
INSERT INTO antrenor VALUES (30, 'Lucian Filip', 'Preparator Fizic', '0722555666');
INSERT INTO antrenor VALUES (40, 'Marius Popa', 'Antrenor Portari', '0722111333');
INSERT INTO antrenor VALUES (50, 'Thomas Neubert', 'Preparator Fizic', '0722444555');

-- 3. SALI
INSERT INTO sala VALUES (100, 'Baza Berceni - Teren I', 500, 'Teren Iarba', 'Nocturna, Irigatii');
INSERT INTO sala VALUES (101, 'Baza Berceni - Sala Forta', 30, 'Sala Fitness', 'Aparate Gym');
INSERT INTO sala VALUES (102, 'Arena Nationala', 55000, 'Stadion Oficial', 'Standard UEFA');

-- 4. ABONAMENTE
INSERT INTO abonament VALUES (1, 'Junior Starter', 150, 'Acces antrenamente de 3 ori pe saptamana');
INSERT INTO abonament VALUES (2, 'Performance Pro', 300, 'Acces zilnic + Sala forta');
INSERT INTO abonament VALUES (3, 'VIP Member', 1000, 'Acces total + Loja meciuri');
INSERT INTO abonament VALUES (50, 'FCSB VIP Gold', 5000, 'Acces Tribuna Oficiala si Spa');

-- 5. MEMBRI
INSERT INTO membru VALUES (1001, 'Popescu Andrei', TO_DATE('15-05-2005', 'DD-MM-YYYY'), 'Str. Libertatii 10', '0799123456', 'andrei.p@gmail.com', TO_DATE('01-09-2023', 'DD-MM-YYYY'));
INSERT INTO membru VALUES (1002, 'Ionescu Maria', TO_DATE('20-11-2000', 'DD-MM-YYYY'), 'Bd. Unirii 4', '0799654321', 'maria.i@yahoo.com', TO_DATE('10-01-2024', 'DD-MM-YYYY'));
INSERT INTO membru VALUES (1003, 'Radu George', TO_DATE('10-03-2008', 'DD-MM-YYYY'), 'Calea Victoriei 22', '0799000111', 'radu.g@gmail.com', SYSDATE);
INSERT INTO membru VALUES (1004, 'Coman Florinel', TO_DATE('10-04-1998', 'DD-MM-YYYY'), 'Bd. Timisoara 5', '0722111222', 'mbappe@fcsb.ro', TO_DATE('15-06-2017', 'DD-MM-YYYY'));
INSERT INTO membru VALUES (1005, 'Olaru Darius', TO_DATE('03-03-1998', 'DD-MM-YYYY'), 'Str. Brasov 12', '0722333444', 'olaru@fcsb.ro', TO_DATE('01-01-2020', 'DD-MM-YYYY'));
INSERT INTO membru VALUES (1006, 'Tavi Popescu', TO_DATE('27-12-2002', 'DD-MM-YYYY'), 'Aleea Rozelor 1', '0722555666', 'tavi@fcsb.ro', TO_DATE('20-09-2020', 'DD-MM-YYYY'));
INSERT INTO membru VALUES (1007, 'Chiriches Vlad', TO_DATE('14-11-1989', 'DD-MM-YYYY'), 'Str. Pipera 100', '0722777888', 'vlad.ch@fcsb.ro', TO_DATE('01-07-2023', 'DD-MM-YYYY'));
INSERT INTO membru VALUES (1008, 'Tanase Florin', TO_DATE('30-12-1994', 'DD-MM-YYYY'), 'Bd. Decebal 3', '0722999000', 'tanase@fcsb.ro', TO_DATE('01-08-2016', 'DD-MM-YYYY'));
INSERT INTO membru VALUES (1009, 'Pantea Grigoras', TO_DATE('24-06-2003', 'DD-MM-YYYY'), 'Str. Berceni 45', '0733111222', 'pantea@fcsb.ro', TO_DATE('10-02-2021', 'DD-MM-YYYY'));
INSERT INTO membru VALUES (1010, 'Miculescu David', TO_DATE('02-05-2001', 'DD-MM-YYYY'), 'Calea Mosilor 88', '0733444555', 'david.mic@fcsb.ro', TO_DATE('01-08-2022', 'DD-MM-YYYY'));

-- 6. GRUPE
INSERT INTO grupa VALUES (500, 2, 20, 'FCSB U19', 'Elite', 'Luni-Vineri 16:00');
INSERT INTO grupa VALUES (501, 1, 10, 'Prima Echipa', 'Superliga', 'Zilnic 10:00');
INSERT INTO grupa VALUES (502, 2, 20, 'FCSB U17', 'Elite', 'Luni-Vineri 16:30');
INSERT INTO grupa VALUES (503, 1, 50, 'Recuperare Fitness', 'Amatori', 'Zilnic 14:00');

-- 7. PLATI
INSERT INTO plata VALUES (1, 1001, 150, SYSDATE, 'Card', 'Taxa lunara Septembrie');
INSERT INTO plata VALUES (2, 1002, 300, SYSDATE, 'Cash', 'Abonament Performance');
INSERT INTO plata VALUES (101, 1004, 5000, SYSDATE, 'Card', 'Cotizatie anuala'); 
INSERT INTO plata VALUES (102, 1005, 4500, SYSDATE, 'Transfer', 'Cotizatie anuala'); 
INSERT INTO plata VALUES (103, 1003, 300, SYSDATE, 'Cash', 'Taxa luna curenta'); 
INSERT INTO plata VALUES (104, 1002, 300, SYSDATE, 'Card', 'Taxa luna curenta'); 

-- 8. MEMBRU_ABOMAMENT
INSERT INTO membru_abonament VALUES (1, 1001, 1, SYSDATE, SYSDATE + 30);
INSERT INTO membru_abonament VALUES (2, 1005, 4, SYSDATE, SYSDATE + 365);
INSERT INTO membru_abonament VALUES (3, 1003, 2, SYSDATE, SYSDATE + 365);
INSERT INTO membru_abonament VALUES (4, 1006, 3, SYSDATE - 400, SYSDATE - 10);
INSERT INTO membru_abonament VALUES (5, 1009, 3, SYSDATE, SYSDATE + 180);

-- 9. MEMBRU_GRUPA
INSERT INTO membru_grupa VALUES (1, 1001, 500, 'Portar');
INSERT INTO membru_grupa VALUES (2, 1003, 500, 'Atacant');
INSERT INTO membru_grupa VALUES (1, 1004, 501, 'Atacant Stanga'); 
INSERT INTO membru_grupa VALUES (2, 1005, 501, 'Mijlocas Central'); 
INSERT INTO membru_grupa VALUES (3, 1007, 501, 'Fundas Central'); 
INSERT INTO membru_grupa VALUES (4, 1008, 501, 'Atacant'); 
INSERT INTO membru_grupa VALUES (5, 1010, 501, 'Atacant Dreapta'); 
INSERT INTO membru_grupa VALUES (6, 1006, 500, 'Mijlocas Ofensiv'); 
INSERT INTO membru_grupa VALUES (7, 1009, 500, 'Fundas Dreapta'); 
INSERT INTO membru_grupa VALUES (8, 1001, 500, 'Portar'); 
INSERT INTO membru_grupa VALUES (9, 1003, 500, 'Fundas Stanga'); 
INSERT INTO membru_grupa VALUES (10, 1002, 500, 'Mijlocas'); 
INSERT INTO membru_grupa VALUES (11, 1004, 501, 'Atacant Stanga'); 
INSERT INTO membru_grupa VALUES (12, 1005, 501, 'Mijlocas Central'); 
INSERT INTO membru_grupa VALUES (13, 1003, 501, 'Fundas Stanga'); 
INSERT INTO membru_grupa VALUES (14, 1002, 501, 'Mijlocas'); 

-- 10. ACTIVITATI
INSERT INTO activitate VALUES (1, 501, 100, 'Antrenament Tactic');
INSERT INTO activitate VALUES (2, 501, 101, 'Pregatire Fizica');
INSERT INTO activitate VALUES (3, 500, 100, 'Meci Amical');
INSERT INTO activitate VALUES (4, 502, 101, 'Kinetoterapie');
INSERT INTO activitate VALUES (5, 500, 102, 'Sedinta Video');
INSERT INTO activitate VALUES (6, 503, 101, 'Evaluare Medicala');
COMMIT;

---------------- OPERATII DE ACTUALIZARE SI INTEROGARE A DATELOR - TEMA 2 ---------------
--1. Marirea pretului abonamentelor VIP cu 10% 
UPDATE abonament 
SET pret = pret * 1.10 
WHERE tip = 'VIP Member';

--2. Schimbarea orarului pentru grupa U19 (Grupa 500)
UPDATE grupa 
SET orar = 'Luni-Miercuri-Vineri 17:30' 
WHERE id_grupa = 500;

--3. Actualizarea telefonului unui antrenor (Elias Charalambous)
UPDATE antrenor 
SET telefon = '0722999888' 
WHERE nume LIKE '%Charalambous%';

--4. Marirea capacitatii salii de forta
UPDATE sala
SET capacitate = capacitate + 10, echipamente = CONCAT(echipamente, ', Banda alergare')
WHERE id_sala = 101;

--5. Corectarea adresei unui membru care s-a mutat
UPDATE membru 
SET adresa = 'Sos. Stefan cel Mare, Bl. 5, Ap. 13' 
WHERE id_membru = 1001;

--6. Actualizarea capacitatii pentru Arena Nationala
UPDATE sala
SET capacitate = 70000
WHERE nume_sala = 'Arena Nationala';

--1. Programul activitatilor (ce grupa se antreneaza, unde)
SELECT tip_activitate, nume_sala, nume_grupa,echipamente
FROM activitate
JOIN sala USING (id_sala)
JOIN grupa USING (id_grupa);

--2. Afisarea membrilor si a abonamentelor active, cu zile ramase
SELECT nume, tip, ROUND(data_end - SYSDATE) AS zile_ramase
FROM membru
JOIN membru_abonament USING (id_membru)
JOIN abonament USING (id_abonament)
WHERE data_end > SYSDATE;

--3. Venitul total generat de fiecare tip de abonament
SELECT tip, COUNT(*) AS nr_abonamente_vandute, TO_CHAR(SUM(pret), '99,999.00') AS venit_total
FROM abonament
JOIN membru_abonament USING (id_abonament)
GROUP BY tip;

--4. Clasificarea pretului abonamentelor
SELECT tip, pret, CASE 
        WHEN pret < 200 THEN 'Accesibil'
        WHEN pret BETWEEN 200 AND 500 THEN 'Standard'
        ELSE 'Premium'
    END AS categorie_pret
FROM abonament;
	
--5. In ce grupe a juca t un membru si pe ce post
SELECT nume, nume_grupa, rol_grupa, nivel
FROM membru
JOIN membru_grupa USING (id_membru)
JOIN grupa USING (id_grupa);

--6. Ce antrenor raspunde de care sectie
SELECT nume_sectie, nume_grupa, nume, specializare
FROM sectie
JOIN grupa USING (id_sectie)
JOIN antrenor USING (id_antrenor);

------------------TEMA 3 --------------------
--1.Venitul total generat de fiecare metoda de plata (Cash/Card)
SELECT metoda, SUM(suma) AS total_incasat, COUNT(id_plata) AS numar_tranzactii
FROM plata
GROUP BY metoda;

--2. Numarul de sportivi din fiecare grupa (doar grupele mari)
--Afiseaza grupele care au mai mult de 5 membri
SELECT nume_grupa, COUNT(id_membru) AS nr_sportivi
FROM grupa
JOIN membru_grupa USING (id_grupa)
GROUP BY nume_grupa
HAVING COUNT(id_membru) > 5;

--3. Media preturilor abonamentelor per tip
SELECT tip, ROUND(AVG(pret), 2) AS pret_mediu
FROM abonament
GROUP BY tip;

--4. Topul sectiilor in functie de numarul de grupe
SELECT nume_sectie, COUNT(id_grupa) AS nr_grupe
FROM sectie
JOIN grupa USING (id_sectie)
GROUP BY nume_sectie
ORDER BY nr_grupe DESC;

--5. Gradul de utilizare al salilor
SELECT nume_sala, COUNT(id_activitate) AS nr_activitati
FROM sala
JOIN activitate USING (id_sala)
GROUP BY nume_sala;

--6. Situatia platilor per membru. Gasim membrii VIP care au adus clubului peste 100 RON
SELECT nume, SUM(suma) AS total_contributie
FROM membru
JOIN plata USING (id_membru)
GROUP BY nume
HAVING SUM(suma) > 100;

--7. Repartizarea membrilor pe ani de nastere. Ce generatii de juniori predomina
SELECT EXTRACT(YEAR FROM data_nasterii) AS an_nastere, COUNT(*) AS nr_copii
FROM membru
GROUP BY EXTRACT(YEAR FROM data_nasterii)
ORDER BY an_nastere;



--1. Membrii care au platit o suma mai mare decat media tuturor platilor
SELECT nume, suma
FROM membru
JOIN plata USING (id_membru)
WHERE suma > (SELECT AVG(suma) FROM plata);

--2. Afisarea antrenorilor care NU au nicio grupa alocata
SELECT nume, specializare
FROM antrenor
WHERE id_antrenor NOT IN (SELECT id_antrenor FROM grupa);

--3. Membrii care au cel mai scump abonament disponibil
SELECT nume
FROM membru
JOIN membru_abonament USING (id_membru)
JOIN abonament USING (id_abonament)
WHERE pret IN (SELECT MAX(pret) FROM abonament);

--4. Grupele care activeaza pe "Arena Nationala" 
SELECT nume_grupa, nivel
FROM grupa
WHERE id_grupa IN (
    SELECT id_grupa 
    FROM activitate 
    JOIN sala USING (id_sala) 
    WHERE nume_sala = 'Arena Nationala'
);

--5. Afisarea membrilor si diferenta dintre plata lor și cea mai mica plata inregistrata 
SELECT nume, suma, suma - (SELECT MIN(suma) FROM plata) AS diferenta_fata_de_minim
FROM membru
JOIN plata USING (id_membru);

UPDATE membru_grupa
SET rol_grupa = 'Mijlocas Ofensiv'
WHERE id_membru = 1005; 
COMMIT;
--6. Membrii care joaca pe acelasi post cu cineva
SELECT nume, rol_grupa
FROM membru
JOIN membru_grupa USING (id_membru)
WHERE rol_grupa = (
    SELECT rol_grupa
    FROM membru 
    JOIN membru_grupa USING (id_membru) 
    WHERE nume = 'Tavi Popescu'
);

--7. Membrii care s-au inscris la club dupa un anumit jucator (cronologie)
SELECT nume, nume_grupa, data_inscriere
FROM membru
JOIN membru_grupa USING (id_membru)
JOIN grupa USING (id_grupa)
WHERE data_inscriere > (
    SELECT data_inscriere 
    FROM membru 
    WHERE nume = 'Tanase Florin'
);

--1. Membrii care nu au efectuat nicio plata
--Folosim LEFT JOIN pentru a-i gasi pe cei care exista in membri, dar nu in plati
SELECT nume, telefon,email
FROM membru
LEFT JOIN plata USING (id_membru)
WHERE id_plata IS NULL;

--2. Topul grupelor in functie de cati bani au adus la club
SELECT nume_grupa, SUM(suma) AS total_incasari_grupa
FROM grupa
JOIN membru_grupa USING (id_grupa)
JOIN membru USING (id_membru)
JOIN plata USING (id_membru)
GROUP BY nume_grupa
ORDER BY total_incasari_grupa DESC;

--3. Antrenorii care antreneaza cel putin doua grupe de nivel Elite
SELECT nume, specializare, COUNT(id_grupa) AS nr_elite
FROM antrenor 
JOIN grupa USING (id_antrenor)
WHERE nivel = 'Elite' 
GROUP BY nume, specializare
HAVING COUNT(id_grupa) >= 2; 

--4. Media de varsta a sportivilor pentru fiecare Antrenor
SELECT antrenor.nume AS nume_antrenor, nume_grupa, ROUND(AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, membru.data_nasterii) / 12)), 1) AS medie_varsta
FROM antrenor
JOIN grupa USING (id_antrenor)
JOIN membru_grupa USING (id_grupa)
JOIN membru USING (id_membru)
GROUP BY antrenor.nume, nume_grupa;

--5. Lista detaliata a platilor, incluzand abonamentul si perioada de valabilitate
SELECT nume, tip, suma, data_plata, data_end AS data_expirare_abonament
FROM membru
JOIN plata USING (id_membru)
JOIN membru_abonament USING (id_membru)
JOIN abonament USING (id_abonament)
WHERE suma > 0
ORDER BY data_plata DESC;

-----VIEW-----
--1.Sa se creeze o tabela virtuala prin care sa se afiseze toate grupele de juniori (id 2) impreuna cu numele antrenorului lor
CREATE OR REPLACE VIEW v_juniorantrenor AS 
SELECT nume_grupa, nivel, nume
FROM grupa
JOIN antrenor USING (id_antrenor) 
WHERE id_sectie = 2;

--2.Sa se creeze o tabela virtuala care sa calculeze numarul de activitati distincte desfasurate in fiecare sala
CREATE OR REPLACE VIEW v_raportsala AS 
SELECT nume_sala, COUNT(DISTINCT tip_activitate) AS nr_activitati 
FROM sala 
JOIN activitate USING (id_sala) GROUP BY nume_sala;

--3.Sa se creeze o tabela virtuala prin care sa se afiseze toti membrii care au un abonament expirat (data_end < SYSDATE)
CREATE OR REPLACE VIEW v_membriiexpirati AS 
SELECT nume, data_end
FROM membru 
JOIN membru_abonament USING (id_membru) 
WHERE data_end < SYSDATE;

--4. Sa se creeze o tabela virtuala numita v_membrii_activi care sa afiseze toti membrii a caror data de nastere este dupa anul 2000
CREATE OR REPLACE VIEW v_membrii_activi AS 
SELECT nume, data_nasterii
FROM membru 
WHERE EXTRACT(YEAR FROM data_nasterii) > 2000;

--5.Sa se creeze o tabela virtuala care sa afiseze numarul total de membri din fiecare grupa.
CREATE OR REPLACE VIEW v_nr_membrii_grupa AS 
SELECT nume_grupa, COUNT(id_membru) AS nr_membri 
FROM grupa 
JOIN membru_grupa USING (id_grupa) 
GROUP BY nume_grupa;



--------------------------------------------------------PL/SQL---------------------------------------------------------------------------
-----------------------------------------------------------Structuri de control-----------------------------------------------------------
--1. Afisarea jucatorilor care au acelasi rol cu un alt membru, folosind o structura repetitiva de tip FOR LOOP
SET SERVEROUTPUT ON;
DECLARE
    v_nume membru.nume%TYPE := 'Tavi Popescu';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Membrii pe acelasi post cu ' || v_nume || ':');
    FOR i IN (
        SELECT nume, rol_grupa
        FROM membru
        JOIN membru_grupa USING (id_membru)
        WHERE rol_grupa IN (
            SELECT rol_grupa
            FROM membru
            JOIN membru_grupa USING (id_membru)
            WHERE nume = v_nume
        )
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Nume: ' || i.nume || ' | Rol: ' || i.rol_grupa);
    END LOOP;
END;
/

--2. Afisarea grupelor care se antreneaza pe Arena Nationala, folosind o structura repetitiva
SET SERVEROUTPUT ON;
BEGIN
    FOR i IN (
        SELECT nume_grupa, nivel
        FROM grupa
        WHERE id_grupa IN (
            SELECT id_grupa 
            FROM activitate 
            JOIN sala USING (id_sala)
            WHERE nume_sala = 'Arena Nationala'
        )
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Grupa: ' || i.nume_grupa || ' | Nivel: ' || i.nivel);
    END LOOP;
END;
/

--3. Verificam daca o anumita plata (dupa ID) este considerata mare sau mica (peste/sub 100 lei)
SET SERVEROUTPUT ON;
DECLARE
    v_suma     plata.suma%TYPE;
    v_id_plata NUMBER := &id_plata;
BEGIN
    SELECT suma 
    INTO v_suma 
    FROM plata 
    WHERE id_plata = v_id_plata;

    IF v_suma > 100 THEN
        DBMS_OUTPUT.PUT_LINE('Plata: ' || v_id_plata || ' in valoare de ' || v_suma || ' este o suma mare');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Plata: ' || v_id_plata || ' in valoare de ' || v_suma || ' este o suma mica');
    END IF;
END;
/

--4. Verificam daca o grupa mai are locuri libere, comparand numarul de membri inscrisi cu o capacitate maxima stabilita
SET SERVEROUTPUT ON
DECLARE
    v_id_grupa  grupa.id_grupa%TYPE := &id_grupa;
    v_nr_membri NUMBER;
    v_max       NUMBER := 5; --maxim de capacitate
BEGIN
    SELECT count(*) 
    INTO v_nr_membri 
    FROM membru_grupa 
    WHERE id_grupa = v_id_grupa;

    IF v_nr_membri >= v_max THEN
        DBMS_OUTPUT.PUT_LINE('Grupa ' || v_id_grupa || ' este plina (' || v_nr_membri || ' membri)');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Grupa ' || v_id_grupa || ' are locuri libere. Inscrisi: ' || v_nr_membri);
    END IF;
END;
/

--5. Afisarea abonamentelor unui membru si verificarea statusului, comparand data de sfarsit cu data curenta
SET SERVEROUTPUT ON;
DECLARE
    v_id_membru membru.id_membru%TYPE := &id_membru;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Raport Abonamente Membru ' || v_id_membru);
    FOR i IN (
        SELECT id_membru_abonament, data_end
        FROM membru_abonament
        WHERE id_membru = v_id_membru
    ) 
    LOOP
        IF i.data_end < SYSDATE THEN
            DBMS_OUTPUT.PUT_LINE('Inregistrarea ' || i.id_membru_abonament || ': Expirat (Finalizat la: ' || i.data_end || ')');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Inregistrarea ' || i.id_membru_abonament || ': Activ (Valabil pana la: ' || i.data_end || ')');
        END IF;
    END LOOP;
END;
/



-----------------------------------------------------------CURSORI-----------------------------------------------------------

---IMPLICITI
--1.Actualizarea automata a pretului unui abonament (cu 10%)
--Se testeaza cu: Performance, FCSB VIP Gold, Junior Starter, VIP Member
SET SERVEROUTPUT ON;
DECLARE
    v_tip_abonament abonament.tip%TYPE := '&tip_abonament';
BEGIN
    UPDATE abonament
    SET pret = pret * 1.1
    WHERE tip = v_tip_abonament;
    
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Au fost actualizate ' || SQL%ROWCOUNT || ' abonamente de tip ' || v_tip_abonament);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nu s-au gasit abonamente de acel tip');
    END IF;
END;
/
    
--2.Verificarea si actualizarea specializarii antrenorilor pe o anumita disciplina
SET SERVEROUTPUT ON;
DECLARE
    v_id                 antrenor.id_antrenor%TYPE := &id_antrenor;
    v_specializare       antrenor.specializare%TYPE := '&specializare_noua';
    v_nume_antrenor      antrenor.nume%TYPE;
BEGIN
    FOR i IN (
            SELECT nume 
            FROM antrenor 
            WHERE id_antrenor = v_id ) 
    LOOP
        v_nume_antrenor := i.nume;
    END LOOP;
 
    UPDATE antrenor
    SET specializare = v_specializare
    WHERE id_antrenor = v_id;

    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Antrenorul ' || v_nume_antrenor || ' are acum specializarea: ' || v_specializare);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Antrenorul cu ID ' || v_id || ' nu exista. Nu s-a facut nicio modificare.');
    END IF;
END;
/
    
--3.Actualizarea grupei pentru toti membrii care fac parte dintr-o grupa anumita grupa, mutandu-i intr-o grupa noua (de exemplu, la final de sezon)
SET SERVEROUTPUT ON;
DECLARE
    v_grupa_veche grupa.id_grupa%TYPE := &id_vechi;
    v_grupa_noua  grupa.id_grupa%TYPE := &id_nou;
BEGIN
    UPDATE membru_grupa
    SET id_grupa = v_grupa_noua
    WHERE id_grupa = v_grupa_veche;
    
    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista membri inscrisi in grupa: ' || v_grupa_veche);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Au fost transferati: ' || SQL%ROWCOUNT || ' membri in grupa noua');
    END IF;
END;
/
--ROLLBACK
    
--4. Actualizarea capacitatii salii pentru o activitate specifica
SET SERVEROUTPUT ON;
DECLARE
    v_id_activitate      activitate.id_activitate%TYPE := &id_activitate;
    v_plus_locuri        NUMBER := &locuri_suplimentare;
BEGIN
    UPDATE sala
    SET capacitate = capacitate + v_plus_locuri
    WHERE id_sala = (
                SELECT id_sala 
                FROM activitate 
                WHERE id_activitate = v_id_activitate );

    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('---Modificare capacitate---');
        DBMS_OUTPUT.PUT_LINE('Capacitatea salii pentru activitatea ' || v_id_activitate || ' a fost marita cu ' || v_plus_locuri || ' locuri');

        IF v_plus_locuri > 50 THEN
            DBMS_OUTPUT.PUT_LINE('S-a solicitat o suplimentare majora de locuri');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Atentie: Nu s-a gasit activitatea cu ID ' || v_id_activitate || '. Nicio sala nu a fost modificata');
    END IF;
END;
/

--5. Gestionarea istoricului de plati pentru un membru
SET SERVEROUTPUT ON;
DECLARE
    v_id_membru   membru.id_membru%TYPE := &id_membru;
    v_nume_membru membru.nume%TYPE;
BEGIN
    FOR r IN (
            SELECT nume 
            FROM membru 
            WHERE id_membru = v_id_membru ) 
    LOOP
        v_nume_membru := r.nume;
    END LOOP;

    DELETE FROM plata
    WHERE id_membru = v_id_membru;

    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Istoricul de plati pentru membrul ' || v_nume_membru || ' a fost sters');
        DBMS_OUTPUT.PUT_LINE('Numar inregistrari eliminate: ' || SQL%ROWCOUNT);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nu s-au gasit plati de sters pentru ID-ul ' || v_id_membru);
    END IF;
END;
/

--EXPLICITI
--1.Lista membrilor si tipul de abonament detinut
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c IS
        SELECT nume, tip, data_end
        FROM membru 
        JOIN membru_abonament USING (id_membru)
        JOIN abonament USING (id_abonament);
    
    v_nume membru.nume%TYPE;
    v_tip  abonament.tip%TYPE;
    v_data membru_abonament.data_end%TYPE;
BEGIN
    OPEN c;
    LOOP
        FETCH c 
        INTO v_nume, v_tip, v_data;
        EXIT WHEN c%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Membrul ' || v_nume || ' are abonament ' || v_tip || ' valabil pana la ' || v_data);
    END LOOP;
    CLOSE c;
END;
/

--2. Afisarea membrilor inscrisi la o anumita sectie (parametrizat)
SET SERVEROUTPUT ON;
DECLARE
    v_sectie_id sectie.id_sectie%TYPE := &id_sectie;
    CURSOR c(p_id NUMBER) IS
        SELECT nume, nume_grupa
        FROM membru 
        JOIN membru_grupa USING (id_membru)
        JOIN grupa USING (id_grupa)
        WHERE id_sectie = p_id;
    
    v_nume_m membru.nume%TYPE;
    v_nume_g grupa.nume_grupa%TYPE;
BEGIN
    OPEN c(v_sectie_id);
    DBMS_OUTPUT.PUT_LINE('Membri inscrisi in sectia ' || v_sectie_id || ':');
    LOOP
        FETCH c 
        INTO v_nume_m, v_nume_g;
        EXIT WHEN c%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(v_nume_m || ' (Grupa: ' || v_nume_g || ')');
    END LOOP;
    CLOSE c;
END;
/

--3. Analiza platilor totale pe metode de plata
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c IS
        SELECT metoda, SUM(suma) as total, COUNT(id_plata) as nr_tranzactii
        FROM plata
        GROUP BY metoda;
    
    v_plata c%ROWTYPE;
BEGIN
    OPEN c;
    LOOP
        FETCH c 
        INTO v_plata;
        EXIT WHEN c%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Metoda: ' || v_plata.metoda || ' | Total: ' || v_plata.total || ' RON | Tranzactii: ' || v_plata.nr_tranzactii);
    END LOOP;
    CLOSE c;
END;
/

--4.Verificarea capacitatii salilor pentru activitati
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c IS
        SELECT nume_sala, capacitate, tip_activitate
        FROM sala 
        JOIN activitate USING (id_sala);
        
    v_sala sala.nume_sala%TYPE;
    v_cap  sala.capacitate%TYPE;
    v_tip_act activitate.tip_activitate%TYPE;
BEGIN
    OPEN c;
    LOOP
        FETCH c INTO v_sala, v_cap, v_tip_act;
        EXIT WHEN c%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Sala: ' || v_sala || ' gazduieste ' || v_tip_act);
        IF v_cap > 20 THEN
            DBMS_OUTPUT.PUT_LINE('Spatiu adecvat pentru grup mare');
            DBMS_OUTPUT.PUT_LINE(' ');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Spatiu pentru antrenament individual');
        END IF;
    END LOOP;
    CLOSE c;
END;
/

--5. Afisati toti membrii clubului care detin un abonament de un anumit tip, primit ca parametru.
--Pentru fiecare membru afisati numele, data de start si data de expirare a abonamentului
SET SERVEROUTPUT ON;
DECLARE
    v_tip    abonament.tip%TYPE := '&tip_abonament';
    v_count  NUMBER := 0;
    
    CURSOR c(p_tip VARCHAR2) IS
        SELECT nume, data_start, data_end
        FROM membru
        JOIN membru_abonament USING (id_membru)
        JOIN abonament USING (id_abonament)
        WHERE tip = p_tip;
BEGIN
    FOR rec IN c(v_tip) LOOP
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE('Membru: ' || rec.nume ||
                             ' | Start: ' || rec.data_start ||
                             ' | Expira: ' || rec.data_end);
    END LOOP;
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista membri cu abonamentul: ' || v_tip);
    END IF;
END;
/


-----------------------------------------EXCEPŢII------------------------------------
--IMPLICITE
--1.Calcularea mediei de participare pe grupe
SET SERVEROUTPUT ON;
DECLARE
    v_id_grupa      grupa.id_grupa%TYPE := &cod_grupa;
    v_nume_grupa    grupa.nume_grupa%TYPE;
    v_nr_membri     NUMBER;
    v_nr_activitati NUMBER;
    v_medie         NUMBER;
BEGIN
    SELECT nume_grupa 
    INTO v_nume_grupa 
    FROM grupa 
    WHERE id_grupa = v_id_grupa;

    SELECT COUNT(*) 
    INTO v_nr_membri 
    FROM membru_grupa 
    WHERE id_grupa = v_id_grupa;

    SELECT COUNT(*) 
    INTO v_nr_activitati 
    FROM activitate 
    WHERE id_grupa = v_id_grupa;

    v_medie := v_nr_membri / v_nr_activitati;

    DBMS_OUTPUT.PUT_LINE('Grupa ' || v_nume_grupa || ' are o medie de ' || v_medie || ' membri pe activitate');

EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Grupa ' || v_nume_grupa || ' nu are nicio activitate programata');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Grupa cu ID-ul ' || v_id_grupa || ' nu exista');
END;
/

--2.Identificarea membrului dupa numarul de telefon
SET SERVEROUTPUT ON
DECLARE
    v_tel_cautat membru.telefon%TYPE := '&numar_telefon';
    v_nume       membru.nume%TYPE;
    v_email      membru.email%TYPE;
BEGIN
    SELECT nume, email
    INTO v_nume, v_email
    FROM membru
    WHERE telefon = v_tel_cautat;

    DBMS_OUTPUT.PUT_LINE('Membrul gasit: ' || v_nume || ' (Email: ' || v_email || ')');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista niciun membru cu numarul de telefon: ' || v_tel_cautat);
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Exista mai multi membri cu acest numar de telefon');
END;
/

--3.Verificarea tipului de activitate pentru o grupa
SET SERVEROUTPUT ON;
DECLARE
    v_nume_grupa  grupa.nume_grupa%TYPE := '&nume_grupa';
    v_activitate  activitate.tip_activitate%TYPE;
    v_orar_grupa  grupa.orar%TYPE;
BEGIN
    SELECT tip_activitate, orar
    INTO v_activitate, v_orar_grupa
    FROM grupa 
    JOIN activitate USING (id_grupa)
    WHERE nume_grupa = v_nume_grupa;

    DBMS_OUTPUT.PUT_LINE('Grupa: ' || v_nume_grupa);
    DBMS_OUTPUT.PUT_LINE('Tip activitate: ' || v_activitate);
    DBMS_OUTPUT.PUT_LINE('Program: ' || v_orar_grupa);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Grupa ' || v_nume_grupa || ' nu figureaza in programul clubului');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Grupa are mai multe activitati');
END;
/

--EXPLICITE
--1.Verificarea antrenorilor dintr-o sectie si a numarului de personal
SET SERVEROUTPUT ON
DECLARE
    v_id_sectie sectie.id_sectie%TYPE := &cod_sectie;
    v_nume_sectie    sectie.nume_sectie%TYPE;
    
    CURSOR c (p_sectie NUMBER) IS
        SELECT id_antrenor, nume
        FROM antrenor
        JOIN grupa USING (id_antrenor)
        WHERE id_sectie = p_sectie;
        
    v_nr_antrenori    NUMBER := 0;
    e_fara_staff      EXCEPTION;
BEGIN
    SELECT nume_sectie 
    INTO v_nume_sectie
    FROM sectie
    WHERE id_sectie = v_id_sectie;
    
    DBMS_OUTPUT.PUT_LINE('Analiza staff pentru sectia: ' || v_nume_sectie);
    
    FOR x IN c(v_id_sectie) 
    LOOP
        v_nr_antrenori := v_nr_antrenori + 1;
        DBMS_OUTPUT.PUT_LINE('Antrenor gasit: ' || x.nume);
    END LOOP;

    IF v_nr_antrenori = 0 THEN
        RAISE e_fara_staff;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total personal activ: ' || v_nr_antrenori);
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Sectia ' || v_id_sectie || ' nu exista');
    WHEN e_fara_staff THEN
        DBMS_OUTPUT.PUT_LINE('Sectia ' || v_nume_sectie || ' nu are antrenori alocati momentan');
END;
/

--2.Verificarea disponibilitatii orarului pentru activitati
SET SERVEROUTPUT ON
DECLARE
    v_tip_activitate activitate.tip_activitate%TYPE := '&tip_activitate';
    
    CURSOR c (p_tip VARCHAR2) IS
        SELECT nume_grupa, nume_sala, orar
        FROM activitate 
        JOIN grupa USING (id_grupa)
        JOIN sala USING (id_sala)
        WHERE tip_activitate = p_tip;

    v_nr_programari NUMBER := 0;
    e_lipsa_program EXCEPTION;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Verificare logistica pentru: ' || v_tip_activitate);
    
    FOR r IN c(v_tip_activitate) 
    LOOP
        v_nr_programari := v_nr_programari + 1;
        
        DBMS_OUTPUT.PUT_LINE('Nr. programari: ' || v_nr_programari || '| Grupa: ' || r.nume_grupa);
        DBMS_OUTPUT.PUT_LINE('Locatie: ' || r.nume_sala || ' | Interval: ' || r.orar);
    END LOOP;

    IF v_nr_programari = 0 THEN
        RAISE e_lipsa_program;
    ELSE
        DBMS_OUTPUT.PUT_LINE('S-au gasit ' || v_nr_programari || ' activitati confirmate');
    END IF;

EXCEPTION
    WHEN e_lipsa_program THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista nicio programare activa pentru tipul: ' || v_tip_activitate);
END;
/

--3.Analiza gradului de ocupare a unei sali (SALA + ACTIVITATE + GRUPA + ANTRENOR)
SET SERVEROUTPUT ON
DECLARE
    v_id_sala         sala.id_sala%TYPE := &cod_sala;
    v_nume_sala       sala.nume_sala%TYPE;

    CURSOR c (p_sala NUMBER) IS
        SELECT nume_grupa, nume AS nume_antrenor, tip_activitate
        FROM activitate 
        JOIN grupa USING (id_grupa)
        JOIN antrenor USING (id_antrenor)
        WHERE id_sala = p_sala;
        
    v_nr_activitati NUMBER := 0;
    e_sala_libera   EXCEPTION;
BEGIN
    SELECT nume_sala 
    INTO v_nume_sala
    FROM sala
    WHERE id_sala = v_id_sala;
    
    DBMS_OUTPUT.PUT_LINE('Raport ocupare pentru locatia: ' || v_nume_sala);
    
    FOR r IN c(v_id_sala) LOOP
        v_nr_activitati := v_nr_activitati + 1;
        DBMS_OUTPUT.PUT_LINE('Activitate: ' || r.tip_activitate);
        DBMS_OUTPUT.PUT_LINE('Grupa: ' || r.nume_grupa || ' | Antrenor: ' || r.nume_antrenor);
    END LOOP;
    
    IF v_nr_activitati = 0 THEN
        RAISE e_sala_libera;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total evenimente gasite: ' || v_nr_activitati);
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Sala cu ID-ul ' || v_id_sala || ' nu este inregistrata');
    WHEN e_sala_libera THEN
        DBMS_OUTPUT.PUT_LINE('Sala ' || v_nume_sala || ' nu are nicio grupa programata');
END;
/


-------------------------------------PROIECT TEMA V.4------------------------------------------------------------------
------------------------------------------ PROCEDURI--------------------------------------------

--1.Afisarea tuturor membrilor dintr-o grupa, cu rolul lor, folosind cursor explicit si exceptie definita de utilizator
CREATE OR REPLACE PROCEDURE p_membri_grupa(p_id_grupa IN NUMBER) IS
    CURSOR c_membri IS
        SELECT nume, rol_grupa
        FROM membru 
        JOIN membru_grupa USING (id_membru)
        WHERE id_grupa = p_id_grupa;

    TYPE t_rec IS RECORD (
        nume      membru.nume%TYPE,
        rol_grupa membru_grupa.rol_grupa%TYPE
    );
    v_rec         t_rec;
    v_nr          NUMBER := 0;
    e_fara_membri EXCEPTION;
BEGIN
    OPEN c_membri;
    LOOP
        FETCH c_membri INTO v_rec;
        EXIT WHEN c_membri%NOTFOUND;
        v_nr := v_nr + 1;
        DBMS_OUTPUT.PUT_LINE('Membru: ' || v_rec.nume || ' Rol: ' || v_rec.rol_grupa);
    END LOOP;
    CLOSE c_membri;

    IF v_nr = 0 THEN
        RAISE e_fara_membri;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total membri in grupa: ' || v_nr);
    END IF;
EXCEPTION
    WHEN e_fara_membri THEN
        DBMS_OUTPUT.PUT_LINE('Niciun membru gasit in grupa ' || p_id_grupa);
END p_membri_grupa;
/

SET SERVEROUTPUT ON;
BEGIN
    p_membri_grupa(500);
END;
/


--2.Adaugarea unui nou membru si inscrierea lui intr-o grupa, cu verificare si tratarea exceptiei de date invalide
CREATE OR REPLACE PROCEDURE p_adauga_si_inscrie(
    p_id_membru  IN NUMBER,
    p_nume       IN VARCHAR2,
    p_id_grupa   IN NUMBER,
    p_rol        IN VARCHAR2
) IS
    v_id_grupa grupa.id_grupa%TYPE;
    e_grupa_inexistenta EXCEPTION;
BEGIN
    BEGIN
        SELECT id_grupa 
        INTO v_id_grupa 
        FROM grupa 
        WHERE id_grupa = p_id_grupa;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            RAISE e_grupa_inexistenta;
    END;

    INSERT INTO membru (id_membru, nume, data_inscriere)
    VALUES (p_id_membru, p_nume, SYSDATE);

    INSERT INTO membru_grupa (id_membru_grupa, id_membru, id_grupa, rol_grupa)
    VALUES (p_id_membru * 100, p_id_membru, p_id_grupa, p_rol);

    DBMS_OUTPUT.PUT_LINE('Membrul ' || p_nume || ' a fost inscris in grupa ' || p_id_grupa);
EXCEPTION
    WHEN e_grupa_inexistenta THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Grupa ' || p_id_grupa || ' nu exista');
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: ID-ul ' || p_id_membru || ' este deja folosit');
END p_adauga_si_inscrie;
/

SET SERVEROUTPUT ON;
BEGIN
    p_adauga_si_inscrie(9999, 'Ion Vasile', 501, 'Jucator');
END;
/


--3.Raport complet al unei sectii: antrenori, grupe si numar membri, folosind cursor, tabele de tip TABLE OF si structuri de control
CREATE OR REPLACE PROCEDURE p_raport_sectie(p_id_sectie IN NUMBER) IS
    TYPE t_tab IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
    v_grupe    t_tab;
    v_antrenori t_tab;
    v_idx      PLS_INTEGER := 0;
    v_nr_membri NUMBER;
    v_nr_grupe  NUMBER := 0;

    CURSOR c_grupe IS
        SELECT id_grupa, nume_grupa, nume AS antrenor
        FROM grupa
        JOIN antrenor USING (id_antrenor)
        WHERE id_sectie = p_id_sectie;
BEGIN
    FOR r IN c_grupe 
    LOOP
        v_idx := v_idx + 1;
        v_grupe(v_idx) := r.nume_grupa;
        v_antrenori(v_idx) := r.antrenor;
        v_nr_grupe := v_nr_grupe + 1;

        SELECT COUNT(*) 
        INTO v_nr_membri 
        FROM membru_grupa 
        WHERE id_grupa = r.id_grupa;

        DBMS_OUTPUT.PUT_LINE('Grupa: ' || r.nume_grupa || ' Antrenor: ' || r.antrenor || ' Nr membri: ' || v_nr_membri);
    END LOOP;

    IF v_nr_grupe = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Sectia ' || p_id_sectie || ' nu are grupe inregistrate');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total grupe in sectie: ' || v_nr_grupe);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Sectia ' || p_id_sectie || ' nu exista');
END p_raport_sectie;
/

SET SERVEROUTPUT ON;
BEGIN
    p_raport_sectie(1);
END;
/


--4.Actualizarea pretului abonamentelor cu un procent dat, cu validare si cursor FOR cu LOG al modificarilor
CREATE OR REPLACE PROCEDURE p_actualizeaza_preturi(p_procent IN NUMBER) IS
    e_procent_invalid EXCEPTION;
    v_pret_nou NUMBER;
BEGIN
    IF p_procent <= 0 OR p_procent > 100 THEN
        RAISE e_procent_invalid;
    END IF;

    FOR r IN (SELECT id_abonament, tip, pret 
              FROM abonament) 
    LOOP
        v_pret_nou := r.pret * (1 + p_procent / 100);

        UPDATE abonament
        SET pret = v_pret_nou
        WHERE id_abonament = r.id_abonament;

        DBMS_OUTPUT.PUT_LINE('Abonament ' || r.tip || ', pret: ' || r.pret || ' -> ' || v_pret_nou);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Preturi actualizate cu ' || p_procent || '%');
EXCEPTION
    WHEN e_procent_invalid THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Procentul trebuie sa fie intre 1 si 100');
END p_actualizeaza_preturi;
/

SET SERVEROUTPUT ON;
BEGIN
    p_actualizeaza_preturi(10);
END;
/


--5.Afisarea istoricului de plati al unui membru, cu total calculat, cursor parametrizat si exceptie pentru lipsa date
CREATE OR REPLACE PROCEDURE p_istoric_plati(p_id_membru IN NUMBER) IS
    CURSOR c_plati(p_id NUMBER) IS
        SELECT id_plata, suma, data_plata, metoda
        FROM plata
        WHERE id_membru = p_id
        ORDER BY data_plata;

    TYPE t_plata IS RECORD (
        id_plata   plata.id_plata%TYPE,
        suma       plata.suma%TYPE,
        data_plata plata.data_plata%TYPE,
        metoda     plata.metoda%TYPE
    );
    v_plata   t_plata;
    v_total   NUMBER := 0;
    v_nr      NUMBER := 0;
    v_nume    membru.nume%TYPE;
    e_fara_plati EXCEPTION;
BEGIN
    SELECT nume 
    INTO v_nume 
    FROM membru 
    WHERE id_membru = p_id_membru;

    OPEN c_plati(p_id_membru);
    LOOP
        FETCH c_plati 
        INTO v_plata;
        EXIT WHEN c_plati%NOTFOUND;
        v_nr := v_nr + 1;
        v_total := v_total + v_plata.suma;

        DBMS_OUTPUT.PUT_LINE('Plata ' || v_plata.id_plata || ' in valoare de ' || v_plata.suma || ' RON' || ' | ' || v_plata.data_plata || ' | ' || v_plata.metoda);
    END LOOP;
    CLOSE c_plati;

    IF v_nr = 0 THEN
        RAISE e_fara_plati;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total plati ' || v_nume || ': ' || v_total || ' RON (' || v_nr || ' tranzactii)');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Membrul cu ID ' || p_id_membru || ' nu exista');
    WHEN e_fara_plati THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista plati inregistrate pentru ' || v_nume);
END p_istoric_plati;
/

SET SERVEROUTPUT ON;
BEGIN
    p_istoric_plati(1004);
END;
/



-------------------------------------------FUNCTII------------------------------------------------------
--1.Returneaza numarul total de membri dintr-o grupa
CREATE OR REPLACE FUNCTION f_nr_membri_grupa(p_id_grupa IN NUMBER)
RETURN NUMBER IS
    v_nr NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO v_nr 
    FROM membru_grupa 
    WHERE id_grupa = p_id_grupa;
    
    RETURN v_nr;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END f_nr_membri_grupa;
/

SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Nr membri: ' || f_nr_membri_grupa(501));
END;
/


--2.Verifica daca un membru are abonament activ la data curenta, returneaza 'DA' sau 'NU', cu exceptie pentru membru inexistent
CREATE OR REPLACE FUNCTION f_abonament_activ(p_id_membru IN NUMBER)
RETURN VARCHAR2 IS
    v_nr     NUMBER;
    v_nume   membru.nume%TYPE;
BEGIN
    SELECT nume 
    INTO v_nume 
    FROM membru 
    WHERE id_membru = p_id_membru;

    SELECT COUNT(*) 
    INTO v_nr
    FROM membru_abonament
    WHERE id_membru = p_id_membru
      AND SYSDATE BETWEEN data_start AND data_end;

    IF v_nr > 0 THEN
        RETURN 'DA';
    ELSE
        RETURN 'NU';
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'MEMBRU INEXISTENT';
END f_abonament_activ;
/

SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Abonament activ: ' || f_abonament_activ(1003));
END;
/


--3.Calculeaza totalul incasat din plati pentru o sectie, parcurgand grupe si membri cu cursor
CREATE OR REPLACE FUNCTION f_total_incasat_sectie(p_id_sectie IN NUMBER)
RETURN NUMBER IS
    v_total NUMBER := 0;
    v_suma  NUMBER;
BEGIN
    FOR r IN (
        SELECT DISTINCT id_membru
        FROM grupa 
        JOIN membru_grupa USING (id_grupa)
        WHERE id_sectie = p_id_sectie
    ) LOOP
        SELECT NVL(SUM(suma), 0) 
        INTO v_suma
        FROM plata 
        WHERE id_membru = r.id_membru;
        
        v_total := v_total + v_suma;
    END LOOP;
    
    RETURN v_total;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END f_total_incasat_sectie;
/

SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Total incasat sectia 1: ' || f_total_incasat_sectie(1) || ' RON');
END;
/



--4.Returneaza nivelul de ocupare al unei sali (LIBERA / OCUPATA PARTIAL / PLINA), comparand numarul de activitati cu capacitatea salii
CREATE OR REPLACE FUNCTION f_status_sala(p_id_sala IN NUMBER)
RETURN VARCHAR2 IS
    v_capacitate sala.capacitate%TYPE;
    v_nr_act     NUMBER;
    v_status     VARCHAR2(30);
BEGIN
    SELECT capacitate 
    INTO v_capacitate 
    FROM sala 
    WHERE id_sala = p_id_sala;

    SELECT COUNT(*) 
    INTO v_nr_act 
    FROM activitate
    WHERE id_sala = p_id_sala;

    IF v_nr_act = 0 THEN
        v_status := 'LIBERA';
    ELSIF v_nr_act < v_capacitate THEN
        v_status := 'OCUPATA PARTIAL';
    ELSE
        v_status := 'PLINA';
    END IF;

    RETURN v_status;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'SALA INEXISTENTA';
END f_status_sala;
/

SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Status sala: ' || f_status_sala(104));
END;
/


--5. Returneaza un sumar text al unui antrenor (nume, specializare, numar grupe), folosind cursor si tip compus
CREATE OR REPLACE FUNCTION f_sumar_antrenor(p_id_antrenor IN NUMBER)
RETURN VARCHAR2 IS
    TYPE t_info IS RECORD (
        nume         antrenor.nume%TYPE,
        specializare antrenor.specializare%TYPE );
    v_info     t_info;
    v_nr_grupe NUMBER := 0;
    v_rezultat VARCHAR2(200);
BEGIN
    SELECT nume, specializare 
    INTO v_info.nume, v_info.specializare
    FROM antrenor 
    WHERE id_antrenor = p_id_antrenor;

    FOR r IN (
            SELECT id_grupa 
            FROM grupa 
            WHERE id_antrenor = p_id_antrenor) 
    LOOP
        v_nr_grupe := v_nr_grupe + 1;
    END LOOP;

    v_rezultat := 'Antrenor: ' || v_info.nume || ' Specializare: ' || v_info.specializare || ' Grupe coordonate: ' || v_nr_grupe;

    RETURN v_rezultat;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Antrenorul cu ID ' || p_id_antrenor || ' nu exista';
END f_sumar_antrenor;
/

SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE(f_sumar_antrenor(12));
END;
/


-----------------------------------------------------PROIECT TEMA V.5---------------------------------
--------------------------------------------PACHETE----------------------------------------------------

--Ex. 1
--Construiti un pachet care sa gestioneze platile si abonamentele membrilor. Pachetul trebuie sa contina:
--o procedura care afiseaza numele membrului si suma totala platita;
--o functie care returneaza pretul unui abonament dupa aplicarea unei reduceri, folosind o exceptie proprie daca procentul depaseste 80;
--o procedura care sterge un membru din grupe daca acesta nu are nicio plata efectuata
CREATE OR REPLACE PACKAGE pachet_fcsb_financiar AS
    e_reducere_prea_mare EXCEPTION;
    
    PROCEDURE afiseaza_plati_membru(p_id_membru NUMBER);
    FUNCTION calculeaza_reducere(p_id_abo NUMBER, p_procent NUMBER) 
        RETURN NUMBER;
    PROCEDURE sterge_membru_fara_plata(p_id_membru NUMBER);
END pachet_fcsb_financiar;
/

CREATE OR REPLACE PACKAGE BODY pachet_fcsb_financiar AS

    PROCEDURE afiseaza_plati_membru(p_id_membru NUMBER) IS
        v_nume  VARCHAR2(50);
        v_suma  NUMBER;
    BEGIN
        SELECT nume, SUM(suma) 
        INTO v_nume, v_suma
        FROM membru
        JOIN plata USING (id_membru)
        WHERE id_membru = p_id_membru
        GROUP BY nume;

        DBMS_OUTPUT.PUT_LINE('Nume: ' || v_nume || ' | Total: ' || v_suma);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista date');
    END afiseaza_plati_membru;

    FUNCTION calculeaza_reducere(p_id_abo NUMBER, p_procent NUMBER) RETURN NUMBER IS
        v_pret_nou NUMBER;
    BEGIN
        IF p_procent > 80 THEN
            RAISE e_reducere_prea_mare;
        END IF;

        SELECT pret - (pret * p_procent / 100) 
        INTO v_pret_nou
        FROM abonament
        WHERE id_abonament = p_id_abo;

        RETURN v_pret_nou;
    EXCEPTION
        WHEN e_reducere_prea_mare THEN
            DBMS_OUTPUT.PUT_LINE('Reducerea este prea mare');
            RETURN 0;
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Abonamentul nu exista');
            RETURN 0;
    END calculeaza_reducere;

    PROCEDURE sterge_membru_fara_plata(p_id_membru NUMBER) IS
        v_nr_plati NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_nr_plati 
        FROM plata
        WHERE id_membru = p_id_membru;

        IF v_nr_plati = 0 THEN
            DELETE FROM membru_grupa
            WHERE id_membru = p_id_membru;
            DBMS_OUTPUT.PUT_LINE('Membru eliminat din grupe');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Membrul are plati efectuate');
        END IF;
    END sterge_membru_fara_plata;

END pachet_fcsb_financiar;
/

--Apel
SET SERVEROUTPUT ON;
EXECUTE pachet_fcsb_financiar.afiseaza_plati_membru(&id_membru_test);

DECLARE
    v_pret_final NUMBER;
BEGIN
    v_pret_final := pachet_fcsb_financiar.calculeaza_reducere(&id_abonament_test, &procent_reducere);
    DBMS_OUTPUT.PUT_LINE('Pretul nou dupa reducere este: ' || v_pret_final);
END;
/

EXECUTE pachet_fcsb_financiar.sterge_membru_fara_plata(&id_membru_verificare);



--Ex. 2
--Construiti un pachet pentru gestionarea resurselor clubului FCSB. Pachetul trebuie sa contina:
--o procedura care afiseaza numele antrenorului si sectia de care apartine;
--o functie care returneaza capacitatea unei sali;
--o procedura care actualizeaza adresa unui membru, folosind o exceptie proprie daca noua adresa are mai putin de 5 caractere
CREATE OR REPLACE PACKAGE pachet_resurse_fcsb AS
    e_adresa_prea_scurta EXCEPTION;

    PROCEDURE detalii_antrenor(p_id_ant NUMBER);
    FUNCTION capacitate_sala(p_id_sala NUMBER) RETURN NUMBER;
    PROCEDURE actualizeaza_adresa(p_id_mem NUMBER, p_adresa_noua VARCHAR2);
END pachet_resurse_fcsb;
/

CREATE OR REPLACE PACKAGE BODY pachet_resurse_fcsb AS

    PROCEDURE detalii_antrenor(p_id_ant NUMBER) IS
        v_nume_ant VARCHAR2(50);
        v_sectie   VARCHAR2(50);
    BEGIN
        SELECT nume, nume_sectie 
        INTO v_nume_ant, v_sectie
        FROM antrenor
        JOIN grupa USING (id_antrenor)
        JOIN sectie USING (id_sectie)
        WHERE id_antrenor = p_id_ant AND ROWNUM = 1;

        DBMS_OUTPUT.PUT_LINE('Antrenor: ' || v_nume_ant || ' | Sectie: ' || v_sectie);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Antrenorul nu a fost gasit');
    END detalii_antrenor;

    FUNCTION capacitate_sala(p_id_sala NUMBER) RETURN NUMBER IS
        v_cap NUMBER;
    BEGIN
        SELECT capacitate INTO v_cap 
        FROM sala
        WHERE id_sala = p_id_sala;
        
        RETURN v_cap;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
    END capacitate_sala;

    PROCEDURE actualizeaza_adresa(p_id_mem NUMBER, p_adresa_noua VARCHAR2) IS
    BEGIN
        IF LENGTH(p_adresa_noua) < 5 THEN
            RAISE e_adresa_prea_scurta;
        END IF;

        UPDATE membru
        SET adresa = p_adresa_noua
        WHERE id_membru = p_id_mem;
        
        IF SQL%ROWCOUNT > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Adresa actualizata');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Membrul nu exista');
        END IF;
    EXCEPTION
        WHEN e_adresa_prea_scurta THEN
            DBMS_OUTPUT.PUT_LINE('Adresa este prea scurta pentru a fi valida');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Eroare neasteptata la actualizarea adresei');
    END actualizeaza_adresa;

END pachet_resurse_fcsb;
/

--Apel
SET SERVEROUTPUT ON;
--Inlocuieste cu un ID de antrenor existent in tabela ANTRENOR
EXECUTE pachet_resurse_fcsb.detalii_antrenor(&id_ant_existent);

DECLARE
    v_capacitate NUMBER;
BEGIN
    v_capacitate := pachet_resurse_fcsb.capacitate_sala(&id_sala_existent);
    DBMS_OUTPUT.PUT_LINE('Sala are o capacitate de: ' || v_capacitate || ' locuri');
END;
/

--Introdu un ID de membru si o adresa lunga
EXECUTE pachet_resurse_fcsb.actualizeaza_adresa(&id_mem, '&adresa_lunga');

--Introdu o adresa foarte scurta
EXECUTE pachet_resurse_fcsb.actualizeaza_adresa(&id_mem, 'Str');

SELECT id_membru, nume, adresa 
FROM membru
WHERE id_membru = &id_mem;


--Ex. 3
--Construiti un pachet pentru evidenta activitatilor clubului FCSB. Pachetul trebuie sa contina:
--o functie care returneaza numarul de persoane dintr-o grupa;
--o procedura care afiseaza tipul activitatii si numele salii;
--o procedura care scumpeste toate abonamentele cu o suma fixa, folosind o exceptie proprie daca suma depaseste 100 RON.
CREATE OR REPLACE PACKAGE pachet_activitati_fcsb AS
    e_scumpire_prea_mare EXCEPTION;

    FUNCTION nr_persoane_grupa(p_id_gr NUMBER) RETURN NUMBER;
    PROCEDURE info_activitate(p_id_act NUMBER);
    PROCEDURE scumpire_generala(p_suma NUMBER);
END pachet_activitati_fcsb;
/

CREATE OR REPLACE PACKAGE BODY pachet_activitati_fcsb AS

    FUNCTION nr_persoane_grupa(p_id_gr NUMBER) RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_total 
        FROM membru_grupa
        WHERE id_grupa = p_id_gr;
        
        RETURN v_total;
    END nr_persoane_grupa;

    PROCEDURE info_activitate(p_id_act NUMBER) IS
        v_tip  VARCHAR2(50);
        v_sala VARCHAR2(50);
    BEGIN
        SELECT tip_activitate, nume_sala 
        INTO v_tip, v_sala
        FROM activitate
        JOIN sala USING (id_sala)
        WHERE id_activitate = p_id_act;

        DBMS_OUTPUT.PUT_LINE('Activitate: ' || v_tip || ' | Sala: ' || v_sala);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Activitatea nu exista');
    END info_activitate;

    PROCEDURE scumpire_generala(p_suma NUMBER) IS
    BEGIN
        IF p_suma > 100 THEN
            RAISE e_scumpire_prea_mare;
        END IF;

        UPDATE abonament
        SET pret = pret + p_suma;
        
        DBMS_OUTPUT.PUT_LINE('Toate abonamentele au fost scumpite cu succes');
    EXCEPTION
        WHEN e_scumpire_prea_mare THEN
            DBMS_OUTPUT.PUT_LINE('Eroare: Nu puteti scumpi abonamentele cu mai mult de 100 RON odata');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Eroare neasteptata la actualizarea preturilor');
    END scumpire_generala;

END pachet_activitati_fcsb;
/

--Apel
SET SERVEROUTPUT ON;
DECLARE
    v_nr NUMBER;
BEGIN
    v_nr := pachet_activitati_fcsb.nr_persoane_grupa(&id_grupa_test);
    DBMS_OUTPUT.PUT_LINE('In grupa selectata sunt: ' || v_nr || ' membri');
END;
/

EXECUTE pachet_activitati_fcsb.info_activitate(&id_act_test);

EXECUTE pachet_activitati_fcsb.scumpire_generala(150);

SELECT id_abonament, tip, pret FROM abonament;



--------------------------------------------------TRIGGERE--------------------------------------------------
--1.Sa se creeze un trigger, care la stergerea unui membru din tabela Membru sa stearga automat si toate platile asociate acestuia din tabela Plata. 
--Sa se verifice trigger-ul.
CREATE OR REPLACE TRIGGER trg_1
BEFORE DELETE ON membru
FOR EACH ROW
BEGIN
    DELETE FROM membru_abonament 
    WHERE id_membru = :OLD.id_membru;

    DELETE FROM membru_grupa 
    WHERE id_membru = :OLD.id_membru;
    
    DELETE FROM plata 
    WHERE id_membru = :OLD.id_membru;
END;
/

--Apel
DELETE FROM membru
WHERE id_membru = 9999;

SELECT * FROM plata 
WHERE id_membru = 9999;


--2.Sa se creeze un trigger, care sa nu permita inscrierea unui membru intr-o grupa daca acesta are varsta mai mica de 14 ani. 
--Sa se verifice trigger-ul
CREATE OR REPLACE TRIGGER trg_2
BEFORE INSERT ON membru_grupa
FOR EACH ROW
DECLARE
    v_data_nastere DATE;
BEGIN
    SELECT data_nasterii INTO v_data_nastere
    FROM membru
    WHERE id_membru = :NEW.id_membru;

    IF MONTHS_BETWEEN(SYSDATE, v_data_nastere) / 12 < 14 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Membrul este prea tanar pentru a fi inscris in grupa!');
    END IF;
END;
/

--Apel: 
--Apel care trebuie sa dea EROARE
INSERT INTO membru_grupa (id_membru_grupa, id_membru, id_grupa, rol_grupa) 
VALUES (5001, 2001, 502, 'Jucator');


--3.Sa se creeze un trigger, care sa nu permita modificarea metodei de plata daca suma platita este mai mica decat pretul abonamentului respectiv. 
--Totodata, daca metoda se modifica in 'Cash', se va aplica o taxa administrativa de 5 RON adaugata la suma. Sa se verifice trigger-ul.
CREATE OR REPLACE TRIGGER trg_3
BEFORE UPDATE OF metoda ON plata
FOR EACH ROW
DECLARE
    v_pret_abo NUMBER;
BEGIN
    SELECT pret INTO v_pret_abo
    FROM abonament
    JOIN membru_abonament USING (id_abonament)
    WHERE id_membru = :OLD.id_membru AND ROWNUM = 1;

    IF :OLD.suma < v_pret_abo THEN
        RAISE_APPLICATION_ERROR(-20003, 'Nu se poate schimba metoda pentru plati partiale!');
    END IF;

    IF :NEW.metoda = 'Cash' AND :OLD.metoda != 'Cash' THEN
        :NEW.suma := :OLD.suma + 5;
        DBMS_OUTPUT.PUT_LINE('S-a aplicat taxa de procesare cash');
    END IF;
END;
/

--Apel:
UPDATE plata
SET metoda = 'Cash'
WHERE id_plata = 1;
ROLLBACK;


--4.Sa se creeze un trigger complex, asupra tabelei Antrenor. Acesta va avea doua roluri:
--La modificare: va impiedica marirea salariului cu un procent mai mare de 25% fata de valoarea actuala;
--La sterfere: sa impiedice stergerea antrenorilor care detin 'Licenta UEFA Pro', pentru a asigura continuitatea licentei clubului
CREATE OR REPLACE TRIGGER trg_4
BEFORE UPDATE OF salariu OR DELETE ON antrenor
FOR EACH ROW
DECLARE
    v_nr_specialisti NUMBER;
BEGIN
    IF UPDATING THEN
        IF :NEW.salariu > :OLD.salariu * 1.25 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Eroare: Marirea depaseste limita de 25%!');
        END IF;
    END IF;

    IF DELETING THEN
        -- Verificam daca antrenorul sters are licenta Pro
        IF :OLD.specializare = 'Licenta UEFA Pro' THEN
            RAISE_APPLICATION_ERROR(-20005, 'Eroare: Nu puteti sterge antrenorul cu Licenta UEFA Pro! Clubul va fi sanctionat.');
        END IF;
    END IF;
END;
/

--Apel:
UPDATE antrenor
SET salariu = salariu * 2
WHERE id_antrenor = &id_antrenor_existent;

DELETE FROM antrenor
WHERE id_antrenor = &id_antrenor_singur_pe_sectie;


--5.Sa se creeze un trigger, care la modificarea pretului unui abonament sa verifice daca exista membri care au platit deja pentru acesta. 
--Daca noul pret este mai mare cu peste 20% fata de cel vechi, sa se anuleze operatia, altfel sa se updateze automat descrierea abonamentului cu data ultimei modificari. 
--Sa se verifice trigger-ul.
CREATE OR REPLACE TRIGGER trg_5
BEFORE UPDATE OF pret ON abonament
FOR EACH ROW
DECLARE
    v_nr_plati NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_nr_plati
    FROM membru_abonament
    WHERE id_abonament = :OLD.id_abonament;

    IF v_nr_plati > 0 THEN
        IF :NEW.pret > :OLD.pret * 1.2 THEN
            RAISE_APPLICATION_ERROR(-20005, 'Scumpire prea mare pentru un abonament activ!');
        ELSE
            :NEW.descriere := 'Pret actualizat la data: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY');
        END IF;
    END IF;
END;
/

--Apel: 
UPDATE abonament 
SET pret = 500 
WHERE id_abonament = 1;

SELECT id_abonament, pret, descriere 
FROM abonament 
WHERE id_abonament = 1;

--6. Creați un trigger compus pe tabela abonament care să nu permită scăderea prețului și nici creșterea cu mai mult de 30%. 
--Pentru fiecare abonament modificat, actualizați descriere cu data și prețul anterior. Afișați la final numărul total de modificări efectuate.
CREATE OR REPLACE TRIGGER trg_compound_abonamente
FOR UPDATE OF pret ON abonament
COMPOUND TRIGGER

    TYPE t_preturi IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    v_preturi_vechi  t_preturi;
    v_idx            PLS_INTEGER := 0;

BEFORE STATEMENT IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Incepe actualizarea preturilor abonamentelor');
    v_preturi_vechi.DELETE;
    v_idx := 0;
END BEFORE STATEMENT;

BEFORE EACH ROW IS
BEGIN
    IF :NEW.pret < :OLD.pret THEN
        RAISE_APPLICATION_ERROR(-20011, 'Pretul abonamentului ' || :OLD.tip ||  ' nu poate fi scazut. Pret curent: ' || :OLD.pret || ' RON');
    END IF;

    IF :NEW.pret > :OLD.pret * 1.30 THEN
        RAISE_APPLICATION_ERROR(-20012, 'Cresterea pretului pentru ' || :OLD.tip || ' depaseste 30%! Limita maxima: ' || ROUND(:OLD.pret * 1.30, 2) || ' RON');
    END IF;

    v_idx := v_idx + 1;
    v_preturi_vechi(v_idx) := :OLD.pret;

    :NEW.descriere := 'Pret modificat: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY') || ' | Pret anterior: ' || :OLD.pret || ' RON';
END BEFORE EACH ROW;

AFTER EACH ROW IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Actualizat: ' || :OLD.tip ||  ' | ' || :OLD.pret || ' -> ' || :NEW.pret || ' RON');
END AFTER EACH ROW;

AFTER STATEMENT IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Total abonamente modificate: ' || v_idx);
END AFTER STATEMENT;    

END trg_compound_abonamente;
/

--Apel
SET SERVEROUTPUT ON;
--actualizare valida
UPDATE abonament SET pret = pret * 1.10 WHERE tip = 'Junior Starter';

--eroare: scadere de pret
UPDATE abonament SET pret = 100 WHERE tip = 'Performance';

--eroare: crestere peste 30%
UPDATE abonament SET pret = pret * 2 WHERE tip = 'VIP Member';

SELECT id_abonament, tip, pret, descriere FROM abonament;