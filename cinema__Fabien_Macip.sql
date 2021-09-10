/* CREATE DATABASE `cinema`; */

DROP TABLE IF EXISTS `ticket`;
DROP TABLE IF EXISTS `seance`;
DROP TABLE IF EXISTS `client`;
DROP TABLE IF EXISTS `film`;
DROP TABLE IF EXISTS `salle`;
DROP TABLE IF EXISTS `complexe`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `tarif`;


CREATE TABLE `tarif` (
  `id` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `libelle` varchar(20) NOT NULL,
  `montant` float NOT NULL
); 

CREATE TABLE `user` (
  `id` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `email` varchar(60) NOT NULL UNIQUE,
  `prenom` varchar(20) NOT NULL,
  `nom` varchar(40) NOT NULL,
  `hash` varchar(100) NOT NULL,
  `salt` varchar(100) NOT NULL,
  `token` varchar(100) NOT NULL,
  `droits` enum('client','gerant','administrateur') NOT NULL
); 

CREATE TABLE `complexe` (
  `id` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `lieu` varchar(50) NOT NULL,
  `telephone` varchar(10) DEFAULT NULL,
  `id_gerant` int,
  FOREIGN KEY (id_gerant) REFERENCES user (id)
);

CREATE TABLE `salle` (
  `id` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `id_complexe` int NOT NULL,
  `num_salle` int NOT NULL,
  `capacite` int NOT NULL,
  FOREIGN KEY (id_complexe) REFERENCES complexe (id)
); 

CREATE TABLE `film` (
  `id` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `titre` varchar(60) NOT NULL,
  `synopsis` text(500),
  `duree_minutes` int NOT NULL
); 

CREATE TABLE `client` (
  `id` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `date_naissance` date NOT NULL,
  `etudiant` tinyint(1) NOT NULL,
  FOREIGN KEY (id_user) REFERENCES user (id)
); 

CREATE TABLE `seance` (
  `id` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `id_salle` int NOT NULL,
  `id_film` int NOT NULL,
  `jour` date NOT NULL,
  `heure` time NOT NULL,
  FOREIGN KEY (id_salle) REFERENCES salle (id),
  FOREIGN KEY (id_film) REFERENCES film (id)
); 

CREATE TABLE `ticket` (
  `id_ticket` varchar(12) NOT NULL PRIMARY KEY,
  `id_seance` int NOT NULL,
  `id_client` int(10) NOT NULL,
  `paye_en_ligne` tinyint(1) NOT NULL,
  `id_tarif` int NOT NULL,
  FOREIGN KEY (id_seance) REFERENCES seance (id),
  FOREIGN KEY (id_client) REFERENCES client (id),
  FOREIGN KEY (id_tarif) REFERENCES tarif (id)
); 

/* ********************** INSERTIONS ********************** */

INSERT INTO `tarif` (`libelle`, `montant`) VALUES
('Plein', '9.20'),
('Etudiant', '7.60'),
('Moins14', '5.90');

INSERT INTO `user` (`email`,`nom`,`prenom`,`hash`,`salt`,`token`,`droits`) VALUES
('jacques.durand@yahoo.fr','Durand','Jacques','mqsdkjf0980Q98DF0Q9','MLKJ243mlkj43Jqsd','QDSFK34jlkj34j','administrateur'),
('mimimoumou@cinemas.fr','Moutarde','Mireille','mlkjqdmflkjazmelkjqm','mlkjmlkj34345l','fqsdmflkj345','administrateur'),
('fatabien@gmail.com','Macip','Fabien','mqlkjmlkj345J345','345jljlkj345j','6655JJJjjjlkj','gerant'),
('jdupont@toto.org','Dupont','Jean','mlkjqmlfkjmlkj ','mlkjmlkjmoiujsedf','acspmlkjazpoij','gerant'),
('kikou38@hotmail.com','Dupuis','Corinne','mlkjmlkj','eszrazefdmqf','qmzeoij3425','client'),
('lulu-454@gmail.com','Amouroux','Lucienne','pkjqezmrlkj','mlkjmlkjsdfcafqdmlk','qsdmflkj345356qmlkj','client'),
('gegelabouteille@ricard.fr','Tatrobu','Gerard','mlkjmlkj1234653fLKJ','QDSF34Tqdfqjlkj','43FGQSFGqfdg543','client');

INSERT INTO `complexe` (`lieu`,`telephone`,`id_gerant`) VALUES
('Nantes','0234566343','1'),
('Lille','0243123212','3'),
('Toulon','0467344304','4');

INSERT INTO `salle` (`id_complexe`,`num_salle`,`capacite`) VALUES
('1','1','350'),
('1','2','298'),
('1','3','200'),
('2','1','450'),
('2','2','382'),
('2','3','344'),
('2','4','243'),
('3','1','356'),
('3','2','301'),
('3','3','284');

INSERT INTO `film` (`titre`,`synopsis`,`duree_minutes`) VALUES
('La grande vadrouille','Lorem ipsum dolor sit amet consectetur adipisicing elit. Molestias repudiandae nihil explicabo harum, vero ipsum laboriosam','121'),
('Les bronzés','Lorem ipsum dolor sit amet consectetur adipisicing elit. Molestias repudiandae nihil explicabo','109'),
('Fantasia','Lorem ipsum dolor sit amet consectetur adipisicing elit. Molestias repudiandae nihil explicabo harum, vero ipsum laboriosam voluptas vitae rerum. Ipsum consequatur totam quasi? Obcaecati quaerat tenetur','105'),
('Popeye','Lorem ipsum dolor sit amet consectetur adipisicing elit. Molestias repudiandae nihil explicabo harum, vero ipsum laboriosam voluptas vitae rerum. Ipsum consequatur','107'),
('Alice','Lorem ipsum dolor sit amet consectetur adipisicing elit. Molestias repudiandae nihil explicabo harum, vero ipsum laboriosam voluptas vitae rerum. Ipsum consequatur totam quasi','125');

INSERT INTO `client` (`id_user`,`date_naissance`,`etudiant`) VALUES
('5','2000-04-01','1'),
('6','2010-01-03','0'),
('7','1995-10-09','0');

INSERT INTO `seance` (`id_salle`,`id_film`,`jour`,`heure`) VALUES
('1','2','2021-09-09','18:00:00'),
('5','2','2021-09-09','18:00:00'),
('8','2','2021-09-10','20:30:00'),
('1','1','2021-09-09','20:45:00'),
('2','5','2021-09-08','15:00:00'),
('3','4','2021-09-08','15:00:00'),
('6','1','2021-09-09','11:00:00');

INSERT INTO `ticket` (`id_ticket`,`id_seance`,`id_client`,`paye_en_ligne`,`id_tarif`) VALUES
('LILL00000001','2','3','1','1'),
('LILL00000002','7','3','0','1'),
('LILL00000003','7','1','1','2'),
('TOUL00000001','3','2','1','3'),
('NANT00000001','5','2','0','3'),
('NANT00000002','5','3','0','1');



/* 
La table TICKET n`a pas besoin de la colonne `id_tarif`, car on peut retouver le tarif par requêtes SQL. 
Mais j`ai choisi d`implémenter cette colonne, au cas où, à l`avenir, le cinéma mette en place d`autres tarifs
ou des abonnements, ce qui impliquerai qu`un "Etudiant" puisse avoir des places à un tarif encore 
plus avantageux via un abonnement par exemple. 
*/


