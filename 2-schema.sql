SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `Casino` ;
USE `Casino` ;

-- -----------------------------------------------------
-- Table `Casino`.`probablity_controlling`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`probablity_controlling` (
  `control_id` SMALLINT UNSIGNED ,
  `last_update` TIMESTAMP NULL,
  PRIMARY KEY (`control_id3`),
  INDEX `control_id3` (`control_id3` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE CASINO.probablity_controlling
add control_alert tinyint(1) NULL,
add before_control double NULL,
add after_control double NULL;

ALTER TABLE CASINO.probablity_controlling
modify last_update timestamp null;

SET AUTOCOMMIT=0;
INSERT INTO CASINO.probablity_controlling VALUES 
(1002,null, 1, 0.4889, 0.3333),
(2003, null, 1, 0.50, 0.2332), 
(2005,  null, 1, 0.4987, 0.2322), 
(3006, null, 0, 0.3333, 0.3333),
(5008,  null, 1, 0.51, 0.2222), 
(5009,  null, 1, 0.5111, 0.1111);
COMMIT;







-- ---------------------------------------------------------------------------------------
-- Part One -- `gamblers` including 'country' 'government' 'old_customer' 'new_register'
-- ---------------------------------------------------------------------------------------


-- -----------------------------------------------------
-- Table `Casino`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`country` (
  `country_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(50) NOT NULL,
  `c_profit_index` FLOAT NOT NULL,
  `population` FLOAT NOT NULL,
  `gambler_percent` DECIMAL(10,5) NOT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


#select * from Casino.country;

--
-- Adding data for table `Casino`.`country`
--

SET AUTOCOMMIT=0;
INSERT INTO Casino.country VALUES (1,'THE NETHERLANDS','36.5', '17.28', '0.87'),
(2, 'ITALY','35.5', '60.36', '0.80'), 
(3, 'RUSSIA','18.6', '144.5', '0.75'), 
(4, 'FINLAND','6.1', '5.51','0.74'),
(5, 'ICELAND','5.7', '0.36', '0.69'), 
(6, 'GREAT BRITAIN','5.5', '66.65', '0.68');
COMMIT;


-- -----------------------------------------------------
-- Table `Casino`.`government`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`government` (
  `gov_id` SMALLINT UNSIGNED,
  `district` VARCHAR(20) NULL,
  `postal_code` VARCHAR(100) NULL,
  `supportive_info` TINYINT NULL DEFAULT -1,
  `country_id` SMALLINT UNSIGNED ,
  PRIMARY KEY (`gov_id`))

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

--
-- Adding data for table `Casino`.`government`
--

SET AUTOCOMMIT=0;
INSERT INTO Casino.government VALUES (1,'Amsterdam','1012AB', '6', '1'),
(2, 'Rome','00185', '-1', '2'), 
(3, 'Moscow','101000', '-6', '3'), 
(4, 'Helsinki','320', '5','4'),
(5, 'Reykjanik','101-105-112', '6', '5'), 
(6, 'London','SW1A', '-2', '6');
COMMIT;




-- -----------------------------------------------------
-- Table `Casino`.`safe_keeping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`safe_keeping` (
  `safe_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `danger_index` SMALLINT NOT NULL,
  PRIMARY KEY (`safe_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE CASINO.safe_keeping
drop name,
add danger_amount smallint;


SET AUTOCOMMIT=0;
INSERT INTO Casino.safe_keeping VALUES 
(99,default, '6', '1000'),
(112, default ,'-1', '2'), 
(113, default, '-6', '3'), 
(114, default,'320', '5000'),
(115, default, '6', '5'), 
(116, default, '-2', '6');
COMMIT;



-- -----------------------------------------------------
-- Table `Casino`.`superstar_company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`superstar_company` (
  `company_id` TINYINT UNSIGNED NOT NULL,
  `gov_id` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`company_id`),
  INDEX `idx_fk_gov` (`gov_id` ASC),
  CONSTRAINT `fk_gov1`
    FOREIGN KEY (`gov_id`)
    REFERENCES `Casino`.`government` (`gov_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



-- -----------------------------------------------------
-- Table `Casino`.`old_customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`old_customer` (
  `old_id` SMALLINT UNSIGNED ,
  `old_name` VARCHAR(50) NULL,
  `country_id` SMALLINT UNSIGNED ,
  `email` VARCHAR(250) NULL,
  `gov_id` SMALLINT UNSIGNED ,
  `company_id` TINYINT UNSIGNED ,
  `o_profit_index` TINYINT NULL,
  PRIMARY KEY (`old_id`),
  INDEX `idx_fk_country_id` (`country_id` ASC),
  INDEX `fk_gov_id_idx` (`gov_id` ASC),
  INDEX `fk_custumer_com_idx` (`company_id` ASC))
 
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


--
-- Adding data for table `Casino`.`old_customer`
--

SET AUTOCOMMIT=0;
INSERT INTO Casino.old_customer VALUES (3580,'Edword Thop','6', 'et@gmail.com', '6', '88', '68'),
(5699, 'Billy Walters','5', 'bws@gmail.com', '5', '88', '33'), 
(6326, 'Phil Lvey','4',  'Pl6326@superstar.com', '4', '88', '32'), 
(8833, 'Chris Moneymaker','3', 'Cm8833@superstar.com', '3', '88','26'),
(8999, 'Blackjack Team','2',  'Bj8999@MIT.edu.com', '2', '88', '25'), 
(9326, 'Stanford Wong','1',  '973427@QQ.COM', '1', '88', '-12' ); 
-- comment 'If the pfofit_index value is minus it means the gambler wind more than lost, the profit for the casino is minus'
COMMIT;


-- -----------------------------------------------------
-- Table `Casino`.`new_register`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`new_register` (
  `n_id` SMALLINT UNSIGNED ,
  `n_name` VARCHAR(50) NULL,
  `country_id` SMALLINT UNSIGNED ,
  `n_email` VARCHAR(250) NULL,
  `gov_id` SMALLINT UNSIGNED ,
  `company_id` TINYINT UNSIGNED ,
  `n_profit_index` TINYINT NULL,
  PRIMARY KEY (`n_id`),
  INDEX `idx_n_country_id` (`country_id` ASC),
  INDEX `fk_gov_n_idx` (`gov_id` ASC),
  INDEX `fk_ncom_idx` (`company_id` ASC))

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- If the customer win more than lost it means the lost of the casino. 'If the pfofit_index value is minus it means the gambler wind more than lost, the profit for the casino is minus' ); 


--
-- Adding data for table `Casino`.`new_register`
--
SET AUTOCOMMIT=0;
INSERT INTO Casino.new_register VALUES 
(3580,'Ed','6', '6@gmail.com', '6', '88', '68'),
(5699, 'B','5', 'b5@gmail.com', '5', '88', '33'), 
(6326, 'Ph','4',  'P4@superstar.com', '4', '88', '32'), 
(8833, 'Chris M','3', '833@superstar.com', '3', '88','26'),
(8999, 'Blare','2',  '299@MIT.edu.com', '2', '88', '25'), 
(9326, 'Stan','1',  '342@QQ.COM', '1', '88', '-12' ); 
-- comment 'If the pfofit_index value is minus it means the gambler wind more than lost, the profit for the casino is minus'
COMMIT;



-- -----------------------------------------------------
-- Table `Casino`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`staff` (
  `staff_id` TINYINT UNSIGNED ,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `picture` BLOB NULL,
  `email` VARCHAR(50) NULL,
  `com_id` TINYINT UNSIGNED ,
  `phone` BIGINT NOT NULL,
  PRIMARY KEY (`staff_id`))

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


ALTER TABLE `Casino`.`staff` 
add staff_name varchar(50),
drop first_name,
drop last_name,
change com_id staff_profit smallint null;




--
-- Adding data for table `Casino`.`staff`
--
SET AUTOCOMMIT=0;
INSERT INTO Casino.staff VALUES (12,null,null, '88', 202230, 'Alice Smith'),
(25, null,null, '88', 202250,  'Maria Garcia'), 
(36, null,null, '88', 230250, 'Robert Johnson'), 
(50, null,null, '88', 250260, 'Gill Brown'),
(55, null,null, '88', 356569, 'Jack Miller'), 
(59, null,null, '88', 560, 'Ana'),
(66, null,null, '88', 360, 'Xiao Dongdong');
COMMIT;


-- -----------------------------------------------------
-- Table `Casino`.`tracking_records`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`tracking_records` (
  `tracking_id` TINYINT UNSIGNED ,
  `business_id2` TINYINT NOT NULL,
`danger_idX2` SMALLINT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tracking_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET AUTOCOMMIT=0;
INSERT INTO CASINO.tracking_records VALUES 
(1, 2,  1333, default),
(2, 3, 123, default), 
(22, 5, 322, default), 
(3, 6,  33, default),
(6,8,  22, default), 
(9, 9,  11, default);
COMMIT;

-- -----------------------------------------------------
-- Table `Casino`.`table_game_sys`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`table_game_sys` (
  `table_id` SMALLINT UNSIGNED NOT NULL,
  `control_id3` SMALLINT UNSIGNED NOT NULL,
  `game_name` VARCHAR(50),
  `control_Probab` DOUBLE NULL,
 `tb_profit_idx` DOUBLE NULL,

  PRIMARY KEY (`table_id`, `control_id3`),
    FOREIGN KEY (`control_id3`)
    REFERENCES `Casino`.`probablity_controlling` (`control_id3`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



SET AUTOCOMMIT=0;
INSERT INTO CASINO.table_game_sys VALUES 
(1, 1002,null,  0.3333, 68),
(2, 2003, null, 0.2332, 88), 
(22, 2005,  null, 0.2322, 89), 
(3, 3006, null,  0.3333, 35),
(58,5008,  null,  0.2222, 99), 
(59, 5009,  null,  0.1111, 98);
COMMIT;


-- -----------------------------------------------------
-- Table `Casino`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`transaction` (
  `transaction_id` SMALLINT UNSIGNED NOT NULL,
  `currecy_type` SMALLINT UNSIGNED NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `transaction_amount` LONGBLOB NOT NULL,
  `table_id` SMALLINT UNSIGNED NOT NULL,
  `safe_id` TINYINT UNSIGNED NOT NULL,
  `tracking_id` TINYINT UNSIGNED NOT NULL,
  `control_id` SMALLINT UNSIGNED NOT NULL,
  `transaction_amount` BIGINT NOT NULL,
  `transactioncol` VARCHAR(45) NULL,
  INDEX `fk_tr1_idx` (`table_id` ASC, `transaction_id` ASC),
  INDEX `fk_tr2_idx` (`safe_id` ASC),
  INDEX `fk_con4_idx` (`control_id` ASC),
  PRIMARY KEY (`transaction_id`),
  CONSTRAINT `fk_tr1`
    FOREIGN KEY (`table_id` , `transaction_id`)
    REFERENCES `Casino`.`table_game_sys` (`table_id` , `table_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tr2`
    FOREIGN KEY (`safe_id`)
    REFERENCES `Casino`.`safe_keeping` (`safe_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_con4`
    FOREIGN KEY (`control_id`)
    REFERENCES `Casino`.`probablity_controlling` (`control_id3`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Casino`.`on-line sys`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`on-line sys` (
  `online_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `online_title` VARCHAR(255) NOT NULL,
  `staff_id` TINYINT UNSIGNED NOT NULL,
  `online_time` TIMESTAMP NOT NULL,
  `tracking_id` TINYINT UNSIGNED NOT NULL,
  `table_id` TINYINT UNSIGNED NOT NULL,
  `safe_id` TINYINT UNSIGNED NOT NULL DEFAULT 3,
  `control_id` SMALLINT UNSIGNED NOT NULL DEFAULT 4.99,
  `transaction_id` SMALLINT UNSIGNED NOT NULL,
  `special_features` SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_title` (`online_title` ASC),
  PRIMARY KEY (`online_id`),
  INDEX `fk_staff_sys_idx` (`staff_id` ASC),
  INDEX `fk_tracking_sys_idx` (`tracking_id` ASC),
  INDEX `fk_table_sys_idx` (`table_id` ASC),
  INDEX `fk_safe_sys_idx` (`safe_id` ASC),
  INDEX `fk_control_sys_idx` (`control_id` ASC),
  INDEX `fk_trans_sys_idx` (`transaction_id` ASC),
  CONSTRAINT `fk_staff_sys`
    FOREIGN KEY (`staff_id`)
    REFERENCES `Casino`.`staff` (`staff_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tracking_sys`
    FOREIGN KEY (`tracking_id`)
    REFERENCES `Casino`.`tracking_records` (`tracking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table_sys`
    FOREIGN KEY (`table_id`)
    REFERENCES `Casino`.`table_game_sys` (`game_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_safe_sys`
    FOREIGN KEY (`safe_id`)
    REFERENCES `Casino`.`safe_keeping` (`safe_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_control_sys`
    FOREIGN KEY (`control_id`)
    REFERENCES `Casino`.`probablity_controlling` (`control_id3`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trans_sys`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `Casino`.`transaction` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Casino`.`cashier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`cashier` (
  `cashier_id` TINYINT UNSIGNED NOT NULL,
  `cashier_type` VARCHAR(50) NULL,
  `transaction_id` SMALLINT UNSIGNED NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `safe_id` TINYINT UNSIGNED NULL,
  PRIMARY KEY (`cashier_id`),
  INDEX `idx_store_id_profit_id` (`transaction_id` ASC, `cashier_type` ASC),
  INDEX `fk_safe6_idx` (`safe_id` ASC),
  CONSTRAINT `fk_tran5`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `Casino`.`transaction` (`transaction_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_safe6`
    FOREIGN KEY (`safe_id`)
    REFERENCES `Casino`.`safe_keeping` (`safe_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Casino`.`price_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`price_list` (
  `price_id` TINYINT UNSIGNED NOT NULL,
   `price_info` VARCHAR(50) NULL,
  `p_profit_sat` TINYINT(1) NULL,
  `update_info` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`price_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET AUTOCOMMIT=0;
INSERT INTO CASINO.table_game_sys VALUES 
(61, 1002,null,  0.3333, 68),
(62, 2003, null, 0.2332, 88), 
(82, 2005,  null, 0.2322, 89), 
(63, 3006, null,  0.3333, 35),
(68,5008,  null,  0.2222, 99), 
(69, 5009,  null,  0.1111, 98);
COMMIT;





-- -----------------------------------------------------
-- Table `Casino`.`business_catalog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`business_catalog` (
  `catalog_id` TINYINT UNSIGNED,
  `catalog_info` CHAR(50) NULL,
  `cg_profit_index` SMALLINT NOT NULL,
  `price_id` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`catalog_id`),
  INDEX `fk_price_idx` (`price_id` ASC)
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SET AUTOCOMMIT=0;
INSERT INTO CASINO.business_catalog VALUES 
(1, null,  0.3333, 68),
(2, null, 0.2332, 88), 
(5, null, 0.2322, 89), 
(6, null,  0.3333, 35),
(8,null,  0.2222, 99), 
(9, null,  0.1111, 98),
(98,null,  0.2222, 99), 
(99, null,  0.1111, 98);
COMMIT;


-- -----------------------------------------------------
-- Table `Casino`.`Luxury_hotel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`Luxury_hotel` (
  `hotel_id` TINYINT UNSIGNED NOT NULL,
  `hotel_name` VARCHAR(45) NULL,
  `lh_profit_index` SMALLINT NULL,
  `catslog_id` TINYINT UNSIGNED,
  
  PRIMARY KEY (`hotel_id`),
  INDEX `fk_hotel_catalog_idx` (`catslog_id` ASC),

  CONSTRAINT `fk_hotel_catalog`
    FOREIGN KEY (`catslog_id`)
    REFERENCES `Casino`.`business_catalog` (`catalog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET AUTOCOMMIT=0;
INSERT INTO CASINO.Luxury_hotel VALUES 
(12, 'Goodholiday',  33, 6),
(25, null, 2, 8), 
(22, 'Vacano', 132, 9), 
(36, 'Canvas',  133, 5),
(58, 'Pleasant Dream',  222, 99), 
(59, null,  -11, 98);
COMMIT;



-- -----------------------------------------------------
-- Table `Casino`.`staff_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`staff_category` (
  `staff_id` TINYINT UNSIGNED ,
  `category_id` TINYINT UNSIGNED ,
  `category_info` VARCHAR(45) NULL,
  `sf_profit_idx` SMALLINT NULL,
  PRIMARY KEY (`staff_id`, `category_id`),
  CONSTRAINT `fk_category1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `Casino`.`staff` (`staff_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;




SET AUTOCOMMIT=0;
INSERT INTO Casino.staff_category 
VALUES (12, 6, 'main', 230),
(25, 8, 'entertain', 250), 
(36, 3, 'main', 250), 
(50, 5, 'ad', 260),
(55, 6, 'ad', 569), 
(66, 9, 'entertain', 360);
COMMIT;


-- -----------------------------------------------------
-- Table `Casino`.`shareholder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`shareholder` (
  `sh_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `hold_value` SMALLINT NOT NULL,
  `market_value` SMALLINT NOT NULL,
  `sh_profit_index` SMALLINT NOT NULL,
  `company_id` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`sh_id`),
  INDEX `fk_company_shareholder_idx` (`company_id` ASC),
  CONSTRAINT `fk_company_shareholder`
    FOREIGN KEY (`company_id`)
    REFERENCES `Casino`.`superstar_company` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Casino`.`traditional_food_supply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`traditional_food_supply` (
  `food_id` TINYINT UNSIGNED NOT NULL,
  `food_name` VARCHAR(45) NOT NULL,
  `company_id` TINYINT UNSIGNED NOT NULL,
  `fd_profit_index` SMALLINT NOT NULL,
  `fd_catalog_id` TINYINT UNSIGNED NOT NULL,
  `fd_price_id` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`food_id`),
  INDEX `fk_food_company_idx` (`company_id` ASC),
  INDEX `fk_food_catalog_idx` (`fd_catalog_id` ASC),
  INDEX `fk_food_price_idx` (`fd_price_id` ASC),
  CONSTRAINT `fk_food_company`
    FOREIGN KEY (`company_id`)
    REFERENCES `Casino`.`superstar_company` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_food_catalog`
    FOREIGN KEY (`fd_catalog_id`)
    REFERENCES `Casino`.`business_catalog` (`catalog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_food_price`
    FOREIGN KEY (`fd_price_id`)
    REFERENCES `Casino`.`price_list` (`price_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Casino`.`slot_machine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`slot_machine` (
  `machine_id` TINYINT UNSIGNED NOT NULL,
  `machine_name` VARCHAR(45) NOT NULL,
  `company_id` TINYINT UNSIGNED NOT NULL,
  `mc_profit_index` SMALLINT NOT NULL,
  `mc_catalog_id` TINYINT UNSIGNED NOT NULL,
  `mc_price_id` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`machine_id`),
  INDEX `fk_food_company_idx` (`company_id` ASC),
  INDEX `fk_food_catalog_idx` (`mc_catalog_id` ASC),
  INDEX `fk_food_price_idx` (`mc_price_id` ASC),
  CONSTRAINT `fk_mc_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `Casino`.`superstar_company` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mc_catalog1`
    FOREIGN KEY (`mc_catalog_id`)
    REFERENCES `Casino`.`business_catalog` (`catalog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mc_price1`
    FOREIGN KEY (`mc_price_id`)
    REFERENCES `Casino`.`price_list` (`price_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Casino`.`performance_hall`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`performance_hall` (
  `hall_id` TINYINT UNSIGNED NOT NULL,
  `hall_name` VARCHAR(45) NOT NULL,
  `company_id` TINYINT UNSIGNED NOT NULL,
  `hall_profit_index` SMALLINT NOT NULL,
  `hall_catalog_id` TINYINT UNSIGNED NOT NULL,
  `hall_price_id` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`hall_id`),
  INDEX `fk_food_company_idx` (`company_id` ASC),
  INDEX `fk_food_catalog_idx` (`hall_catalog_id` ASC),
  INDEX `fk_food_price_idx` (`hall_price_id` ASC),
  CONSTRAINT `fk_hall_company2`
    FOREIGN KEY (`company_id`)
    REFERENCES `Casino`.`superstar_company` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hall_catalog2`
    FOREIGN KEY (`hall_catalog_id`)
    REFERENCES `Casino`.`business_catalog` (`catalog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hall_price2`
    FOREIGN KEY (`hall_price_id`)
    REFERENCES `Casino`.`price_list` (`price_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Casino`.`gaming_area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`gaming_area` (
  `game_id` TINYINT UNSIGNED NOT NULL,
  `game_name` VARCHAR(45) NOT NULL,
  `company_id` TINYINT UNSIGNED NOT NULL,
  `game_profit_index` SMALLINT NOT NULL,
  `game_catalog_id` TINYINT UNSIGNED NOT NULL,
  `game_price_id` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`game_id`),
  INDEX `fk_food_company_idx` (`company_id` ASC),
  INDEX `fk_food_catalog_idx` (`game_catalog_id` ASC),
  INDEX `fk_food_price_idx` (`game_price_id` ASC),
  CONSTRAINT `fk_game_company0`
    FOREIGN KEY (`company_id`)
    REFERENCES `Casino`.`superstar_company` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_catalog0`
    FOREIGN KEY (`game_catalog_id`)
    REFERENCES `Casino`.`business_catalog` (`catalog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_price0`
    FOREIGN KEY (`game_price_id`)
    REFERENCES `Casino`.`price_list` (`price_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Casino`.`Link1_new_Services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`Link1_new_Services` (
  `new_id2` SMALLINT UNSIGNED NOT NULL,
  `hotel_id` TINYINT UNSIGNED NOT NULL,
  `food_id` TINYINT UNSIGNED NOT NULL,
  `machine_id` TINYINT UNSIGNED NOT NULL,
  `hall_id` TINYINT UNSIGNED NOT NULL,
  `game_id` TINYINT UNSIGNED NOT NULL,
  INDEX `fk_new_luxury1_idx` (`new_id2` ASC),
  INDEX `fk_new_luxury2_idx` (`hotel_id` ASC),
  INDEX `fk_new_3_idx` (`food_id` ASC),
  INDEX `fk_new_4_idx` (`machine_id` ASC),
  INDEX `fk_new5_idx` (`hall_id` ASC),
  INDEX `fk_new6_idx` (`game_id` ASC),
  CONSTRAINT `fk_new_1`
    FOREIGN KEY (`new_id2`)
    REFERENCES `Casino`.`new_register` (`new_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_new_2`
    FOREIGN KEY (`hotel_id`)
    REFERENCES `Casino`.`Luxury_hotel` (`hotel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_new_3`
    FOREIGN KEY (`food_id`)
    REFERENCES `Casino`.`traditional_food_supply` (`food_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_new_4`
    FOREIGN KEY (`machine_id`)
    REFERENCES `Casino`.`slot_machine` (`machine_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_new5`
    FOREIGN KEY (`hall_id`)
    REFERENCES `Casino`.`performance_hall` (`hall_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_new6`
    FOREIGN KEY (`game_id`)
    REFERENCES `Casino`.`gaming_area` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Casino`.`Link2_old_Services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`Link2_old_Services` (
  `old_id` SMALLINT UNSIGNED NOT NULL,
  `hotel_id` TINYINT UNSIGNED NOT NULL,
  `food_id` TINYINT UNSIGNED NOT NULL,
  `machine_id` TINYINT UNSIGNED NOT NULL,
  `hall_id` TINYINT UNSIGNED NOT NULL,
  `game_id` TINYINT UNSIGNED NOT NULL,
  INDEX `fk_new_luxury2_idx` (`hotel_id` ASC),
  INDEX `fk_new_luxury3_idx` (`old_id` ASC),
  INDEX `fk_old6_idx` (`food_id` ASC),
  INDEX `fk_old8_idx` (`machine_id` ASC),
  INDEX `fk_old9_idx` (`hall_id` ASC),
  INDEX `fk_old10_idx` (`game_id` ASC),
  CONSTRAINT `fk_old3`
    FOREIGN KEY (`old_id`)
    REFERENCES `Casino`.`old_customer` (`old_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_old5`
    FOREIGN KEY (`hotel_id`)
    REFERENCES `Casino`.`Luxury_hotel` (`hotel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_old6`
    FOREIGN KEY (`food_id`)
    REFERENCES `Casino`.`traditional_food_supply` (`food_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_old8`
    FOREIGN KEY (`machine_id`)
    REFERENCES `Casino`.`slot_machine` (`machine_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_old9`
    FOREIGN KEY (`hall_id`)
    REFERENCES `Casino`.`performance_hall` (`hall_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_old10`
    FOREIGN KEY (`game_id`)
    REFERENCES `Casino`.`gaming_area` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `Casino`.`bank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Casino`.`bank` (
  `bank_id` TINYINT UNSIGNED NOT NULL,
  `transaction_id` SMALLINT UNSIGNED NOT NULL,
  `cashier_id` TINYINT UNSIGNED NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `safe_id` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`bank_id`),
  INDEX `idx_store_id_profit_id` (`cashier_id` ASC, `transaction_id` ASC),
  INDEX `fk_tran1_idx` (`transaction_id` ASC),
  INDEX `fk_safe3_idx` (`safe_id` ASC),
  CONSTRAINT `fk_tran1`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `Casino`.`transaction` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ca2`
    FOREIGN KEY (`cashier_id`)
    REFERENCES `Casino`.`cashier` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_safe3`
    FOREIGN KEY (`safe_id`)
    REFERENCES `Casino`.`safe_keeping` (`safe_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;




-- -----------------------------------------------------
CREATE VIEW  `Casino`.`Sammary1_gamblers` as select * from old_customer;

-- --------------------------------------------------------
CREATE VIEW `Casino`.`Sammary2_transaction` AS select * from new_register;


-- -----------------------------------------------------
CREATE VIEW  `Casino`.`Summary3_Entertainment` AS select * from luxury_hotel, table_game;



-- -----------------------------------------------------
-- View `Casino`.`Sammary1_gamblers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Casino`.`Sammary1_gamblers`;
USE `Casino`;
CREATE  OR REPLACE VIEW `Sammary1_gamblers` AS 
select gambler_num, c_profit_index, supportive_info from country, government;

-- -----------------------------------------------------
-- View `Casino`.`Sammary2_business`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Casino`.`Sammary2_business`;
USE `Casino`;
CREATE  OR REPLACE VIEW `Sammary2_business` AS 
select catalog_id, catalog_info, price_id, p_profit_sat from business_catalog, price_list
where business_catalog.price_id = price_list.price_id;

-- -----------------------------------------------------
-- View `Casino`.`Summary3_Entertainment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Casino`.`Summary3_Entertainment`;
USE `Casino`;
CREATE  OR REPLACE VIEW `Summary3_Entertainment` AS
select lh_profit_index from Luxury_hotel,
select mc_profit_index from slot_machine;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
USE `Casino`;




-- -----------------------------------------------------
-- trigger1 `Casino`.`main_log`
-- trigger2 `Casino`.`customer_log`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `Casino`.`main_log` (
  `message` VARCHAR(250))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Casino`.`customer_log` (
  `log_msg` VARCHAR(250) NULL,
  `msg_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_msg`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

DELIMITER //

CREATE TRIGGER `trigger_mainlog` AFTER INSERT ON `new_register` FOR EACH ROW BEGIN
    INSERT INTO main_log (message)
        VALUES ('new one');
  END;
//

DELIMITER $$

CREATE TRIGGER `trigger_delete` AFTER DELETE ON `new_register` FOR EACH ROW BEGIN
    INSERT INTO main_log (message)
        VALUES (concat('delete one'));
  END;
$$

DELIMITER $$

CREATE TRIGGER `trigger_update` AFTER UPDATE ON `new_register` FOR EACH ROW BEGIN
    INSERT INTO main_log (message)
        VALUES ('update');
  END;
$$



DELIMITER $$
CREATE TRIGGER `upd_profit` AFTER UPDATE ON `profit` FOR EACH ROW BEGIN
    IF (old.title != new.title) or (old.description != new.description)
    THEN
        UPDATE profit_text
            SET title=new.title,
                description=new.description,
                profit_id=new.profit_id
        WHERE profit_id=old.profit_id;
    END IF;
  END;
$$

DELIMITER $$

CREATE TRIGGER `del_profit` AFTER DELETE ON `profit` FOR EACH ROW BEGIN
    DELETE FROM profit_text WHERE profit_id = old.profit_id;
  END;
$$


DELIMITER ;


-- -----------------------------------------------------
-- trigger10 `Casino`.`Feferential_Integrity1` 
-- trigger11 `Casino`.`Feferential_Integrity2`
-- trigger12 `Casino`.`Feferential_Integrity3`
-- -----------------------------------------------------

delimiter //
create trigger ref1_delete after delete on country
for each row
begin
delete from government where country_id = old.country_id;
end;
//
DELIMITER ;


delimiter //
create trigger ref2_add before insert on government
for each row
begin
declare temp int;
set temp = 0;
select count(*) into temp from country where add_id = new.country_id;
if temp = 0 then
insert into main_log values('not in the sys');
insert into anytable values('error');
end if;
end;
//

DELIMITER ;


-- -----------------------------------------------------
-- trigger15 `Casino`.`Sum1` 
-- trigger16 `Casino`.`Sum2`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `Casino`.`sum_1` (
 `MIN` SMALLINT NULL,
  `MAX` SMALLINT NULL

  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


delimiter //
create  trigger sum_1 after insert on staff
for each row
begin
insert sum_1
select min(staff_profit), max(staff_profit) from staff group by staff_id;
end;
//


DELIMITER ;




 

Delimiter $$

Create trigger profit_domain_checking before insert on new_register

For each row

Begin

Declare temp int; set temp=0;

Select count(*) into temp

From old_customer where old_id =new.n_id;

If temp=0 then

Insert into main_log values('Invalid');

Insert into customer_log values('Not available', default); End if;

End; $$

 

 

 

 

 

 

 

 

Delimiter //

Create trigger checking_gender after insert on staff

For each row

Begin

         If

              new.gender != ‘F’ && new.gender != ‘M’

         Then

               Signal sqlstate 'error' set message_text = ‘wronggender’;

End if;

End //

 



    

 





