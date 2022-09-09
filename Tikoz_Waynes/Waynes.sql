INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_waynes','waynes',1),
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_waynes','waynes',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_waynes', 'waynes', 1)
;

INSERT INTO `jobs` (`name`, `label`) VALUES
('waynes', "Wayne's")
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('waynes', 0, 'novice', 'Débutant', 200, 'null', 'null'),
('waynes', 1, 'expert', 'Mecano', 400, 'null', 'null'),
('waynes', 2, 'chef', "Chef d'atelier", 600, 'null', 'null'),
('waynes', 3, 'boss', 'Patron', 1000, 'null', 'null')
;

INSERT INTO `items` (`name`, `label`, `limit`) VALUES
("boitierreprog", "boitier reprog", 2),
("embrayage", "embrayage", 10),
('injecteurs', 'injecteurs', 10),
('turbo', "turbo", 2),
('arbreacame', "arbres à cames", 5)
; 

ALTER TABLE owned_vehicles
ADD reprog int(2)