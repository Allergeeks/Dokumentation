-- MySQL Script generated by MySQL Workbench
-- 03/26/15 20:34:42
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema allergeeks
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema allergeeks
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `allergeeks` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `allergeeks` ;

-- -----------------------------------------------------
-- Table `allergeeks`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `allergeeks`.`User` (
  `ID` INT NOT NULL,
  `Username` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Password` VARCHAR(200) NOT NULL,
  `eMail` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `Username_UNIQUE` (`Username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `allergeeks`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `allergeeks`.`Product` (
  `EAN` INT NOT NULL,
  `Name` VARCHAR(200) NOT NULL,
  `Description` TEXT NULL,
  `ProductCategory_ID` INT NOT NULL,
  PRIMARY KEY (`EAN`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `allergeeks`.`Ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `allergeeks`.`Ingredient` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(200) NOT NULL,
  `Description` TEXT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `allergeeks`.`Product_has_Ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `allergeeks`.`Product_has_Ingredient` (
  `Product_EAN` INT NOT NULL,
  `Ingredient_ID` INT NOT NULL,
  `Amount` FLOAT NULL,
  `AmountUnit` VARCHAR(45) NULL,
  PRIMARY KEY (`Product_EAN`, `Ingredient_ID`),
  INDEX `fk_Product_has_Ingredient_Ingredient1_idx` (`Ingredient_ID` ASC),
  INDEX `fk_Product_has_Ingredient_Product_idx` (`Product_EAN` ASC),
  CONSTRAINT `fk_Product_has_Ingredient_Product`
    FOREIGN KEY (`Product_EAN`)
    REFERENCES `allergeeks`.`Product` (`EAN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_has_Ingredient_Ingredient1`
    FOREIGN KEY (`Ingredient_ID`)
    REFERENCES `allergeeks`.`Ingredient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `allergeeks`.`Blacklist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `allergeeks`.`Blacklist` (
  `User_ID` INT NOT NULL,
  `Ingredient_ID` INT NOT NULL,
  PRIMARY KEY (`User_ID`, `Ingredient_ID`),
  INDEX `fk_User_has_Ingredient_Ingredient1_idx` (`Ingredient_ID` ASC),
  INDEX `fk_User_has_Ingredient_User1_idx` (`User_ID` ASC),
  CONSTRAINT `fk_User_has_Ingredient_User1`
    FOREIGN KEY (`User_ID`)
    REFERENCES `allergeeks`.`User` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Ingredient_Ingredient1`
    FOREIGN KEY (`Ingredient_ID`)
    REFERENCES `allergeeks`.`Ingredient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `allergeeks`.`Device`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `allergeeks`.`Device` (
  `Token` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `valid` DATE NOT NULL,
  `admin_right` TINYINT(1) NOT NULL DEFAULT 0,
  `User_ID` INT NOT NULL,
  PRIMARY KEY (`Token`),
  INDEX `fk_Device_User1_idx` (`User_ID` ASC),
  CONSTRAINT `fk_Device_User1`
    FOREIGN KEY (`User_ID`)
    REFERENCES `allergeeks`.`User` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `allergeeks`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `allergeeks`.`Category` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `allergeeks`.`Ingredient_has_Categorie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `allergeeks`.`Ingredient_has_Categorie` (
  `Ingredient_ID` INT NOT NULL,
  `Categorie_ID` INT NOT NULL,
  PRIMARY KEY (`Ingredient_ID`, `Categorie_ID`),
  INDEX `fk_Ingredient_has_Kategorie_Kategorie1_idx` (`Categorie_ID` ASC),
  INDEX `fk_Ingredient_has_Kategorie_Ingredient1_idx` (`Ingredient_ID` ASC),
  CONSTRAINT `fk_Ingredient_has_Kategorie_Ingredient1`
    FOREIGN KEY (`Ingredient_ID`)
    REFERENCES `allergeeks`.`Ingredient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ingredient_has_Kategorie_Kategorie1`
    FOREIGN KEY (`Categorie_ID`)
    REFERENCES `allergeeks`.`Category` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;