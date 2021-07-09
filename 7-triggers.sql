


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

 



    

 





