-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PaymentAssistant
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PaymentAssistant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PaymentAssistant` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `PaymentAssistant` ;

-- -----------------------------------------------------
-- Table `PaymentAssistant`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`countries` (
  `country_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`region` (
  `region_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`region_id`),
  INDEX `fk_region_countries1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `region_fk_region_countries1`
    FOREIGN KEY (`country_id`)
    REFERENCES `PaymentAssistant`.`countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`city` (
  `city_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `region_id` INT NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_city_region1_idx` (`region_id` ASC) VISIBLE,
  CONSTRAINT `fk_city_region1`
    FOREIGN KEY (`region_id`)
    REFERENCES `PaymentAssistant`.`region` (`region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`address` (
  `address_id` INT NOT NULL,
  `linea1` VARCHAR(100) NOT NULL,
  `linea2` VARCHAR(100) NOT NULL,
  `postalCode` TINYINT NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_address_city1_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `PaymentAssistant`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `birth` DATE NOT NULL,
  `password` VARBINARY(250) NOT NULL,
  `delete` BIT(1) NOT NULL,
  `last_update` DATETIME NOT NULL,
  `active` BIT(1) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  INDEX `fk_pay_user_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_user_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `PaymentAssistant`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_method` (
  `metodo_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `apiURL` VARCHAR(255) NOT NULL,
  `secret_key` VARBINARY(100) NOT NULL,
  `key` VARBINARY(100) NOT NULL,
  `logoIconURL` VARBINARY(255) NOT NULL,
  `enabled` BIT(1) NOT NULL,
  `config` JSON NOT NULL,
  PRIMARY KEY (`metodo_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_available_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_available_method` (
  `available_method` INT NOT NULL,
  `mask_account` VARCHAR(45) NOT NULL,
  `token` VARBINARY(50) NOT NULL,
  `exptokendate` DATETIME NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `user_id` INT NOT NULL,
  `metodo_id` INT NOT NULL,
  PRIMARY KEY (`available_method`),
  UNIQUE INDEX `method_id_UNIQUE` (`available_method` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_pay_available_method_pay_method_type1_idx` (`metodo_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_available_method_pay_method_type1`
    FOREIGN KEY (`metodo_id`)
    REFERENCES `PaymentAssistant`.`pay_method` (`metodo_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`schedule` (
  `schedule_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `recurrencyType:` VARCHAR(45) NOT NULL,
  `repit` TINYINT NOT NULL,
  `endType` VARCHAR(45) NOT NULL,
  `repetitions` TINYINT NOT NULL,
  `end_date` DATETIME NOT NULL,
  PRIMARY KEY (`schedule_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`currencies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`currencies` (
  `currency_id` INT NOT NULL,
  `currency_simbol` VARCHAR(10) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`currency_id`),
  INDEX `fk_currencies_countries1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_currencies_countries1`
    FOREIGN KEY (`country_id`)
    REFERENCES `PaymentAssistant`.`countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`payments` (
  `payments_id` BIGINT UNSIGNED NOT NULL,
  `user_id` INT NOT NULL,
  `available_method` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `current_price` DECIMAL(10,2) NOT NULL,
  `auth` VARCHAR(255) NOT NULL,
  `changeToken` VARCHAR(255) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `error` BIT(1) NOT NULL,
  `date` DATETIME NOT NULL,
  `result` ENUM('SUCCESS', 'FAILED', 'PENDING') NOT NULL,
  `checksum` BINARY(32) NOT NULL,
  `schedule_id` INT NULL,
  `currency_id` INT NOT NULL,
  PRIMARY KEY (`payments_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `method_id_idx` (`available_method` ASC) VISIBLE,
  INDEX `fk_payments_schedule1_idx` (`schedule_id` ASC) VISIBLE,
  INDEX `fk_payments_currencies1_idx` (`currency_id` ASC) VISIBLE,
  CONSTRAINT `payments_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `method_id`
    FOREIGN KEY (`available_method`)
    REFERENCES `PaymentAssistant`.`pay_available_method` (`available_method`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payments_schedule1`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `PaymentAssistant`.`schedule` (`schedule_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payments_currencies1`
    FOREIGN KEY (`currency_id`)
    REFERENCES `PaymentAssistant`.`currencies` (`currency_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_roles` (
  `roleid` INT NOT NULL,
  `name_role` VARCHAR(30) NOT NULL,
  `last_update` DATETIME NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`roleid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_user_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_user_roles` (
  `userrolesid` INT NOT NULL AUTO_INCREMENT,
  `roleid` INT NOT NULL,
  `user_id` INT NOT NULL,
  `last_update` DATETIME NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `enabled` BIT(1) NOT NULL,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `roleid_idx` (`roleid` ASC) VISIBLE,
  PRIMARY KEY (`userrolesid`),
  CONSTRAINT `pay_user_roles_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `roleid`
    FOREIGN KEY (`roleid`)
    REFERENCES `PaymentAssistant`.`pay_roles` (`roleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_modules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_modules` (
  `moduleid` TINYINT(8) NOT NULL,
  `name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`moduleid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_permissions` (
  `permissions_id` INT NOT NULL,
  `moduleid` TINYINT(8) NOT NULL,
  `description` VARCHAR(70) NOT NULL,
  `code` VARCHAR(10) NOT NULL,
  `last_update` DATETIME NOT NULL,
  PRIMARY KEY (`permissions_id`),
  INDEX `fk_payment_permissions_payment_modules1_idx` (`moduleid` ASC) VISIBLE,
  CONSTRAINT `fk_payment_permissions_payment_modules1`
    FOREIGN KEY (`moduleid`)
    REFERENCES `PaymentAssistant`.`pay_modules` (`moduleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_rolespermissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_rolespermissions` (
  `rolespermissions_id` INT NOT NULL,
  `permissions_id` INT NOT NULL,
  `roleid` INT NOT NULL,
  `enabled` BIT(1) NOT NULL,
  `deleted` BIT(1) NOT NULL,
  `last_update` DATETIME NOT NULL,
  PRIMARY KEY (`rolespermissions_id`),
  INDEX `fk_payment_rolespermissions_payment_roles1_idx` (`roleid` ASC) VISIBLE,
  INDEX `fk_payment_rolespermissions_payment_permissions1_idx` (`permissions_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_rolespermissions_payment_roles1`
    FOREIGN KEY (`roleid`)
    REFERENCES `PaymentAssistant`.`pay_roles` (`roleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_rolespermissions_payment_permissions1`
    FOREIGN KEY (`permissions_id`)
    REFERENCES `PaymentAssistant`.`pay_permissions` (`permissions_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_user_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_user_permissions` (
  `rolepermissionsid` INT NOT NULL,
  `user_id` INT NOT NULL,
  `permissions_id` INT NOT NULL,
  `enabled` BIT(1) NOT NULL,
  `last_update` DATETIME NOT NULL,
  `checksum` VARBINARY(255) NOT NULL,
  PRIMARY KEY (`rolepermissionsid`),
  INDEX `fk_payment_user_permissions_payment_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_payment_user_permissions_payment_permissions1_idx` (`permissions_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_user_permissions_payment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_user_permissions_payment_permissions1`
    FOREIGN KEY (`permissions_id`)
    REFERENCES `PaymentAssistant`.`pay_permissions` (`permissions_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_plan_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_plan_type` (
  `plan_type_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `enable` BIT(1) NOT NULL,
  `acquisition` DATE NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`plan_type_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `pay_plan_type_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`subscriptions` (
  `subscriptions_id` INT NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `logourl` VARBINARY(255) NOT NULL,
  PRIMARY KEY (`subscriptions_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`recurrences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`recurrences` (
  `recurrences_id` INT NOT NULL,
  `description` VARCHAR(50) NOT NULL,
  `recurrence_num` INT NOT NULL,
  PRIMARY KEY (`recurrences_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`plan_prices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`plan_prices` (
  `prices_id` INT NOT NULL,
  `amount` DECIMAL(6,2) NOT NULL,
  `post_time` DATETIME NOT NULL,
  `endDate` DATETIME NOT NULL,
  `current` BIT(1) NOT NULL,
  `plan_type_id` INT NOT NULL,
  `subscriptions_id` INT NOT NULL,
  `recurrences_id` INT NOT NULL,
  PRIMARY KEY (`prices_id`),
  INDEX `fk_plan_prices_pay_plan1_idx` (`plan_type_id` ASC) VISIBLE,
  INDEX `fk_plan_prices_subscriptions1_idx` (`subscriptions_id` ASC) VISIBLE,
  INDEX `fk_plan_prices_recurrences1_idx` (`recurrences_id` ASC) VISIBLE,
  CONSTRAINT `fk_plan_prices_pay_plan1`
    FOREIGN KEY (`plan_type_id`)
    REFERENCES `PaymentAssistant`.`pay_plan_type` (`plan_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_prices_subscriptions1`
    FOREIGN KEY (`subscriptions_id`)
    REFERENCES `PaymentAssistant`.`subscriptions` (`subscriptions_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_prices_recurrences1`
    FOREIGN KEY (`recurrences_id`)
    REFERENCES `PaymentAssistant`.`recurrences` (`recurrences_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`plan_per_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`plan_per_user` (
  `planuser_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `prices_id` INT NOT NULL,
  `acquisition` DATETIME NOT NULL,
  `enable` BIT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`planuser_id`),
  INDEX `fk_plan_per_user_pay_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_plan_per_user_plan_prices1_idx` (`prices_id` ASC) VISIBLE,
  CONSTRAINT `fk_plan_per_user_pay_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_per_user_plan_prices1`
    FOREIGN KEY (`prices_id`)
    REFERENCES `PaymentAssistant`.`plan_prices` (`prices_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`schedule_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`schedule_details` (
  `details_id` INT NOT NULL,
  `deleted` BIT(1) NOT NULL,
  `baseDate:` DATE NOT NULL,
  `datepart` VARCHAR(10) NOT NULL,
  `LastExecute` DATETIME NOT NULL,
  `NextExecute` DATETIME NOT NULL,
  `plan_id` INT NOT NULL,
  `schedule_id` INT NOT NULL,
  `planuser_id` INT NOT NULL,
  PRIMARY KEY (`details_id`),
  INDEX `fk_schedule_details_pay_plan1_idx` (`plan_id` ASC) VISIBLE,
  INDEX `fk_schedule_details_schedule1_idx` (`schedule_id` ASC) VISIBLE,
  INDEX `fk_schedule_details_plan_per_user1_idx` (`planuser_id` ASC) VISIBLE,
  CONSTRAINT `fk_schedule_details_pay_plan1`
    FOREIGN KEY (`plan_id`)
    REFERENCES `PaymentAssistant`.`pay_plan_type` (`plan_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedule_details_schedule1`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `PaymentAssistant`.`schedule` (`schedule_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedule_details_plan_per_user1`
    FOREIGN KEY (`planuser_id`)
    REFERENCES `PaymentAssistant`.`plan_per_user` (`planuser_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`payment_notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`payment_notifications` (
  `notificationid` INT NOT NULL,
  `payments_id` BIGINT UNSIGNED NOT NULL,
  `description` VARCHAR(100) NULL,
  `enable` BIT(1) NOT NULL,
  `message` VARCHAR(70) NOT NULL,
  `details_id` INT NOT NULL,
  `sendDate` DATETIME NOT NULL,
  `succes` BIT(1) NULL,
  PRIMARY KEY (`notificationid`),
  INDEX `fk_payment_notifications_payment_details1_idx` (`payments_id` ASC) VISIBLE,
  INDEX `fk_payment_notifications_schedule_details1_idx` (`details_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_notifications_payment_details1`
    FOREIGN KEY (`payments_id`)
    REFERENCES `PaymentAssistant`.`payments` (`payments_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_notifications_schedule_details1`
    FOREIGN KEY (`details_id`)
    REFERENCES `PaymentAssistant`.`schedule_details` (`details_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_contact_info_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_contact_info_type` (
  `infotype_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`infotype_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_contact` (
  `contact_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `value` VARCHAR(100) NOT NULL,
  `enabled` BIT(1) NOT NULL,
  `last_update` DATETIME NOT NULL,
  `infotype_id` INT NOT NULL,
  PRIMARY KEY (`contact_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `contact_id_UNIQUE` (`contact_id` ASC) VISIBLE,
  INDEX `fk_pay_contact_pay_contact_info_type1_idx` (`infotype_id` ASC) VISIBLE,
  CONSTRAINT `pay_contact_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_contact_pay_contact_info_type1`
    FOREIGN KEY (`infotype_id`)
    REFERENCES `PaymentAssistant`.`pay_contact_info_type` (`infotype_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_country` (
  `country_id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `contact_id` INT NOT NULL,
  PRIMARY KEY (`country_id`),
  INDEX `fk_pay_country_pay_contact1_idx` (`contact_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_country_pay_contact1`
    FOREIGN KEY (`contact_id`)
    REFERENCES `PaymentAssistant`.`pay_contact` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`transactionType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`transactionType` (
  `transactionType_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`transactionType_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`exchangeRate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`exchangeRate` (
  `exchangeRate_id` INT NOT NULL,
  `fromCurrency_id` INT NOT NULL,
  `toCurrency_id` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `changeRate` DECIMAL(10,6) NOT NULL,
  PRIMARY KEY (`exchangeRate_id`),
  INDEX `fromCurrency_idx` (`fromCurrency_id` ASC) VISIBLE,
  INDEX `toCurrency_idx` (`toCurrency_id` ASC) VISIBLE,
  CONSTRAINT `fromCurrency`
    FOREIGN KEY (`fromCurrency_id`)
    REFERENCES `PaymentAssistant`.`currencies` (`currency_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `toCurrency`
    FOREIGN KEY (`toCurrency_id`)
    REFERENCES `PaymentAssistant`.`currencies` (`currency_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`transactions` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `payments_id` INT NULL,
  `user_id` INT NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `transaction_date` DATETIME NOT NULL,
  `post_time` DATETIME NOT NULL,
  `checksum` VARBINARY(32) NOT NULL,
  `ref_number` VARCHAR(255) NOT NULL,
  `currency_id` INT NOT NULL,
  `transactionType_id` INT NOT NULL,
  `exchangeRate_id` INT NOT NULL,
  PRIMARY KEY (`transaction_id`),
  INDEX `payments_id_idx` (`payments_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_transactions_currencies1_idx` (`currency_id` ASC) VISIBLE,
  INDEX `fk_transactions_transactionType1_idx` (`transactionType_id` ASC) VISIBLE,
  INDEX `fk_transactions_exchangeRate1_idx` (`exchangeRate_id` ASC) VISIBLE,
  CONSTRAINT `payments_id`
    FOREIGN KEY (`payments_id`)
    REFERENCES `PaymentAssistant`.`payments` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `transactions_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_currencies1`
    FOREIGN KEY (`currency_id`)
    REFERENCES `PaymentAssistant`.`currencies` (`currency_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_transactionType1`
    FOREIGN KEY (`transactionType_id`)
    REFERENCES `PaymentAssistant`.`transactionType` (`transactionType_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_exchangeRate1`
    FOREIGN KEY (`exchangeRate_id`)
    REFERENCES `PaymentAssistant`.`exchangeRate` (`exchangeRate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`features_plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`features_plan` (
  `features_id` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `enabled` BIT(1) NOT NULL,
  `dataypte` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`features_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`features_per_plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`features_per_plan` (
  `featuresPerPlan_id` INT NOT NULL,
  `value` VARCHAR(45) NOT NULL,
  `enable` BIT(1) NOT NULL,
  `subscriptions_id` INT NOT NULL,
  `plan_features_id` INT NOT NULL,
  PRIMARY KEY (`featuresPerPlan_id`),
  INDEX `fk_features_plan_subscriptions1_idx` (`subscriptions_id` ASC) VISIBLE,
  INDEX `fk_features_per_plan_features_plan1_idx` (`plan_features_id` ASC) VISIBLE,
  CONSTRAINT `fk_features_plan_subscriptions1`
    FOREIGN KEY (`subscriptions_id`)
    REFERENCES `PaymentAssistant`.`subscriptions` (`subscriptions_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_features_per_plan_features_plan1`
    FOREIGN KEY (`plan_features_id`)
    REFERENCES `PaymentAssistant`.`features_plan` (`features_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_culture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_culture` (
  `culture_id` INT NOT NULL,
  `currency` VARCHAR(45) NOT NULL,
  `language` VARCHAR(45) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`culture_id`),
  INDEX `fk_pay_culture_pay_country1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_culture_pay_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `PaymentAssistant`.`pay_country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`logserenty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`logserenty` (
  `logsrentyid` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`logsrentyid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`logtypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`logtypes` (
  `logtypeid` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `ref1Desc` VARCHAR(100) NOT NULL,
  `ref2Desc` VARCHAR(100) NOT NULL,
  `value1Desc` VARCHAR(100) NOT NULL,
  `value2Desc` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`logtypeid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`logsources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`logsources` (
  `logsourcesid` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`logsourcesid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`logs` (
  `logsid` INT NOT NULL,
  `description` VARCHAR(80) NOT NULL,
  `posttime` DATETIME NOT NULL,
  `computer` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `trace` VARCHAR(45) NOT NULL,
  `referenceid1` BIGINT NOT NULL,
  `referenceid2` BIGINT NOT NULL,
  `value1` VARCHAR(180) NOT NULL,
  `value2` VARCHAR(180) NOT NULL,
  `checksum` VARCHAR(255) NOT NULL,
  `logscol` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  `logserenty_logsrentyid` INT NOT NULL,
  `logtypeid` INT NOT NULL,
  `logsourcesid` INT NOT NULL,
  PRIMARY KEY (`logsid`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_logs_logserenty1_idx` (`logserenty_logsrentyid` ASC) VISIBLE,
  INDEX `fk_logs_logtypes1_idx` (`logtypeid` ASC) VISIBLE,
  INDEX `fk_logs_logsources1_idx` (`logsourcesid` ASC) VISIBLE,
  CONSTRAINT `logs_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_logs_logserenty1`
    FOREIGN KEY (`logserenty_logsrentyid`)
    REFERENCES `PaymentAssistant`.`logserenty` (`logsrentyid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_logs_logtypes1`
    FOREIGN KEY (`logtypeid`)
    REFERENCES `PaymentAssistant`.`logtypes` (`logtypeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_logs_logsources1`
    FOREIGN KEY (`logsourcesid`)
    REFERENCES `PaymentAssistant`.`logsources` (`logsourcesid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`ia_session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`ia_session` (
  `session_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `session_token` VARCHAR(255) NOT NULL,
  `started_at` TIMESTAMP NOT NULL,
  `ended_at` TIMESTAMP NOT NULL,
  `status` ENUM('active', 'completed', 'failed') NOT NULL,
  `api_url` VARCHAR(255) NOT NULL,
  `config` JSON NOT NULL,
  `audioURL` VARCHAR(225) NOT NULL,
  PRIMARY KEY (`session_id`),
  INDEX `fk_ai_request_pay_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_ai_request_pay_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`ia_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`ia_type` (
  `type_id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`ia_interactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`ia_interactions` (
  `interactions_id` INT NOT NULL AUTO_INCREMENT,
  `session_id` INT NOT NULL,
  `type_id` INT NOT NULL,
  `audio_transcription` VARCHAR(255) NOT NULL,
  `date` DATETIME NOT NULL,
  `result` ENUM("ERROR", "CONFIRMED", "CANCELLED", "REPEAT") NOT NULL,
  `detectedBank` ENUM("Banco Popular", "BCR", "Banco Nacional", "BAC", "Scotiabank", "CityBank", "Paypal") NOT NULL,
  `detectedRecipient` VARCHAR(225) NOT NULL,
  `detectedAmount` DECIMAL(10,2) NOT NULL,
  `amountAccuracy` DECIMAL(10,2) NOT NULL,
  `recipientAccuracy` DECIMAL(10,2) NOT NULL,
  `bankAccuracy` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`interactions_id`),
  INDEX `fk_ia_interactions_ia_request1_idx` (`session_id` ASC) VISIBLE,
  INDEX `fk_ia_interactions_ia_type1_idx` (`type_id` ASC) VISIBLE,
  CONSTRAINT `fk_ia_interactions_ia_request1`
    FOREIGN KEY (`session_id`)
    REFERENCES `PaymentAssistant`.`ia_session` (`session_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ia_interactions_ia_type1`
    FOREIGN KEY (`type_id`)
    REFERENCES `PaymentAssistant`.`ia_type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`user_plan_limit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`user_plan_limit` (
  `limitid` INT NOT NULL,
  `limit` INT NULL,
  `planuser_id` INT NOT NULL,
  `featuresPerPlan_id` INT NOT NULL,
  PRIMARY KEY (`limitid`),
  INDEX `fk_user_plan_limit_plan_per_user1_idx` (`planuser_id` ASC) VISIBLE,
  INDEX `fk_user_plan_limit_features_per_plan1_idx` (`featuresPerPlan_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_plan_limit_plan_per_user1`
    FOREIGN KEY (`planuser_id`)
    REFERENCES `PaymentAssistant`.`plan_per_user` (`planuser_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_plan_limit_features_per_plan1`
    FOREIGN KEY (`featuresPerPlan_id`)
    REFERENCES `PaymentAssistant`.`features_per_plan` (`featuresPerPlan_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`mediaFile_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`mediaFile_types` (
  `mediaFileType_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`mediaFileType_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`media_files`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`media_files` (
  `file_id` INT NOT NULL,
  `mediaFileType_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `size` BIGINT(100) NOT NULL,
  PRIMARY KEY (`file_id`),
  INDEX `fk_media_files_mediaFile_types1_idx` (`mediaFileType_id` ASC) VISIBLE,
  INDEX `fk_media_files_pay_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_media_files_mediaFile_types1`
    FOREIGN KEY (`mediaFileType_id`)
    REFERENCES `PaymentAssistant`.`mediaFile_types` (`mediaFileType_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_media_files_pay_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`IA_proccessing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`IA_proccessing` (
  `procces_id` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `trigger` VARCHAR(45) NOT NULL,
  `result` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`procces_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`IA_logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`IA_logs` (
  `IAlogs_id` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `interactions_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `procces_id` INT NOT NULL,
  `userTaps` INT NOT NULL,
  `errorDetail` INT NOT NULL,
  `userCorrections` TIMESTAMP NOT NULL,
  PRIMARY KEY (`IAlogs_id`),
  INDEX `fk_IA_logs_ia_interactions1_idx` (`interactions_id` ASC) VISIBLE,
  INDEX `fk_IA_logs_pay_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_IA_logs_IA_proccessing1_idx` (`procces_id` ASC) VISIBLE,
  CONSTRAINT `fk_IA_logs_ia_interactions1`
    FOREIGN KEY (`interactions_id`)
    REFERENCES `PaymentAssistant`.`ia_interactions` (`interactions_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IA_logs_pay_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IA_logs_IA_proccessing1`
    FOREIGN KEY (`procces_id`)
    REFERENCES `PaymentAssistant`.`IA_proccessing` (`procces_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
