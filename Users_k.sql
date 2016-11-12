
-- ------------------------------------------------------------------
-- CREANDO USUARIOS
-- ------------------------------------------------------------------
CREATE USER 'Zache'@'localhost' IDENTIFIED BY 'QVX27KUO4FF';
GRANT ALL PRIVILEGES ON zonaComidasCC.consultaPago TO 'Zache'@'localhost' IDENTIFIED BY 'QVX27KUO4FF';
REVOKE ALL PRIVILEGES ON *.* FROM 'Zache'@'localhost';
SHOW GRANTS FOR 'Zache'@'localhost';

/*
CREATE USER 'Elain'@'localhost' IDENTIFIED BY 'PIP77RSD8ZW';
CREATE USER 'Nayda'@'localhost' IDENTIFIED BY 'NDX35SBG1OX';
CREATE USER 'Nicol'@'localhost' IDENTIFIED BY 'VQH26FWH3XR';
CREATE USER 'Yvonn'@'localhost' IDENTIFIED BY 'BJG26AOY5ZY';
CREATE USER 'Yetta'@'localhost' IDENTIFIED BY 'HEW50QKH3TP';
CREATE USER 'Carte'@'localhost' IDENTIFIED BY 'SHP15EMX3BK';
CREATE USER 'Eve F'@'localhost' IDENTIFIED BY 'QLA62UPT7JB';
CREATE USER 'Rogan'@'localhost' IDENTIFIED BY 'NYI62FQD7QF';
CREATE USER 'Ivory'@'localhost' IDENTIFIED BY 'COM54WKR9PA';
CREATE USER 'Judit'@'localhost' IDENTIFIED BY 'OET07HWJ2DT';
CREATE USER 'Chanc'@'localhost' IDENTIFIED BY 'NBX31UZU1GV';
CREATE USER 'Keane'@'localhost' IDENTIFIED BY 'NSZ52YSM6HL';
CREATE USER 'Xerxe'@'localhost' IDENTIFIED BY 'INB91IHM0RB';
CREATE USER 'Keeli'@'localhost' IDENTIFIED BY 'CLV34TXN2BH';
CREATE USER 'Leand'@'localhost' IDENTIFIED BY 'LQW13BAJ4IG';
CREATE USER 'Cally'@'localhost' IDENTIFIED BY 'FZK41HLH6RX';
CREATE USER 'Calvi'@'localhost' IDENTIFIED BY 'USX37BPO2SD';
CREATE USER 'Cassi'@'localhost' IDENTIFIED BY 'BKJ45JVQ5EY';
CREATE USER 'Ingri'@'localhost' IDENTIFIED BY 'COO15PAK2TW';
CREATE USER 'Dunca'@'localhost' IDENTIFIED BY 'ELC81RRF0RC';
CREATE USER 'Yen H'@'localhost' IDENTIFIED BY 'TDP84NXB0XU';
CREATE USER 'Aladd'@'localhost' IDENTIFIED BY 'GXE62MRY2LH';
CREATE USER 'Adam '@'localhost' IDENTIFIED BY 'TZD88VMF4GD';
CREATE USER 'Maite'@'localhost' IDENTIFIED BY 'WCL44YSA5DP';
CREATE USER 'Rhian'@'localhost' IDENTIFIED BY 'OZY70VQW5ID';
CREATE USER 'Dolan'@'localhost' IDENTIFIED BY 'XSZ91MEJ0II';
CREATE USER 'Gisel'@'localhost' IDENTIFIED BY 'FUU93OQA4DD';
CREATE USER 'Inez '@'localhost' IDENTIFIED BY 'CXB94HFE7EU';
CREATE USER 'Lucy '@'localhost' IDENTIFIED BY 'MEV00BPI3AE';
CREATE USER 'Septe'@'localhost' IDENTIFIED BY 'MXR69ZZV5PK';
CREATE USER 'Raven'@'localhost' IDENTIFIED BY 'KYU26BUX0DK';
CREATE USER 'Anjol'@'localhost' IDENTIFIED BY 'OML49CXY3FT';
CREATE USER 'Mikay'@'localhost' IDENTIFIED BY 'UTS27HWS5MV';
CREATE USER 'Beck '@'localhost' IDENTIFIED BY 'PJV27NOH1DM';
CREATE USER 'Samue'@'localhost' IDENTIFIED BY 'OVM66HVU6DP';
CREATE USER 'Fritz'@'localhost' IDENTIFIED BY 'ZRA48XLX7UG';
CREATE USER 'Jakee'@'localhost' IDENTIFIED BY 'KPS82NRM6IH';
CREATE USER 'Dean '@'localhost' IDENTIFIED BY 'WET78TLE9DU';
CREATE USER 'Eaton'@'localhost' IDENTIFIED BY 'YOY71UEM8XS';
CREATE USER 'Quinn'@'localhost' IDENTIFIED BY 'BRQ73AYX9YY';
CREATE USER 'Xavie'@'localhost' IDENTIFIED BY 'IRN86CKF0JJ';
CREATE USER 'Danie'@'localhost' IDENTIFIED BY 'DWS91QUC4TS';
CREATE USER 'Kelly'@'localhost' IDENTIFIED BY 'OXP29VIT2YU';
CREATE USER 'Kaitl'@'localhost' IDENTIFIED BY 'LEE05TWZ6FB';
CREATE USER 'Adria'@'localhost' IDENTIFIED BY 'XEY97DRD9VR';
CREATE USER 'Echo '@'localhost' IDENTIFIED BY 'NAM00CFB8ZQ';
CREATE USER 'Mallo'@'localhost' IDENTIFIED BY 'YAI21RZQ6RU';
CREATE USER 'Dacey'@'localhost' IDENTIFIED BY 'BQD64DUH5XS';
CREATE USER 'Odess'@'localhost' IDENTIFIED BY 'AAR32IAL1UH';
CREATE USER 'Lacy '@'localhost' IDENTIFIED BY 'HEC07OHC2FA';
CREATE USER 'Madel'@'localhost' IDENTIFIED BY 'BHY86BMU0ZO';
CREATE USER 'Bruno'@'localhost' IDENTIFIED BY 'MLH98FDM4ZW';
CREATE USER 'Lione'@'localhost' IDENTIFIED BY 'VFJ97GYW1JR';
*/
-- ------------------------------------------------------------------
-- ELIMINANDO USUARIOS
-- ------------------------------------------------------------------
DROP USER 'Zache'@'localhost';
DROP USER 'Elain'@'localhost';
DROP USER 'Nayda'@'localhost';
DROP USER 'Nicol'@'localhost';
DROP USER 'Yvonn'@'localhost';
DROP USER 'Yetta'@'localhost';
DROP USER 'Carte'@'localhost';
DROP USER 'Eve F'@'localhost';
DROP USER 'Rogan'@'localhost';
DROP USER 'Ivory'@'localhost';
DROP USER 'Judit'@'localhost';
DROP USER 'Chanc'@'localhost';
DROP USER 'Keane'@'localhost';
DROP USER 'Xerxe'@'localhost';
DROP USER 'Keeli'@'localhost';
DROP USER 'Leand'@'localhost';
DROP USER 'Cally'@'localhost';
DROP USER 'Calvi'@'localhost';
DROP USER 'Cassi'@'localhost';
DROP USER 'Ingri'@'localhost';
DROP USER 'Dunca'@'localhost';
DROP USER 'Yen H'@'localhost';
DROP USER 'Aladd'@'localhost';
DROP USER 'Adam '@'localhost';
DROP USER 'Maite'@'localhost';
DROP USER 'Rhian'@'localhost';
DROP USER 'Dolan'@'localhost';
DROP USER 'Gisel'@'localhost';
DROP USER 'Inez '@'localhost';
DROP USER 'Lucy '@'localhost';
DROP USER 'Septe'@'localhost';
DROP USER 'Raven'@'localhost';
DROP USER 'Anjol'@'localhost';
DROP USER 'Mikay'@'localhost';
DROP USER 'Beck '@'localhost';
DROP USER 'Samue'@'localhost';
DROP USER 'Fritz'@'localhost';
DROP USER 'Jakee'@'localhost';
DROP USER 'Dean '@'localhost';
DROP USER 'Eaton'@'localhost';
DROP USER 'Quinn'@'localhost';
DROP USER 'Xavie'@'localhost';
DROP USER 'Danie'@'localhost';
DROP USER 'Kelly'@'localhost';
DROP USER 'Kaitl'@'localhost';
DROP USER 'Adria'@'localhost';
DROP USER 'Echo '@'localhost';
DROP USER 'Mallo'@'localhost';
DROP USER 'Dacey'@'localhost';
DROP USER 'Odess'@'localhost';
DROP USER 'Lacy '@'localhost';
DROP USER 'Madel'@'localhost';
DROP USER 'Bruno'@'localhost';
DROP USER 'Lione'@'localhost';

