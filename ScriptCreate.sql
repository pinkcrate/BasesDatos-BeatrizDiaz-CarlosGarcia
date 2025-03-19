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
-- Table `PaymentAssistant`.`pay_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `birth` DATE NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  `delete` BIT(1) NOT NULL,
  `last_update` DATETIME NOT NULL,
  `active` BIT(1) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_method` (
  `metodo_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `apiURL` VARCHAR(255) NOT NULL,
  `secret_key` VARCHAR(100) NOT NULL,
  `key` VARCHAR(100) NOT NULL,
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
  `token` VARCHAR(45) NOT NULL,
  `exptokendate` VARCHAR(45) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `user_id` INT NOT NULL,
  `pay_method_type_metodo_id` INT NOT NULL,
  PRIMARY KEY (`available_method`),
  UNIQUE INDEX `method_id_UNIQUE` (`available_method` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_pay_available_method_pay_method_type1_idx` (`pay_method_type_metodo_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_available_method_pay_method_type1`
    FOREIGN KEY (`pay_method_type_metodo_id`)
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
  `end_date` DATE NOT NULL,
  PRIMARY KEY (`schedule_id`))
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
  `currency` CHAR(3) NOT NULL,
  `auth` VARCHAR(255) NOT NULL,
  `changeToken` VARCHAR(255) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `error` BIT(1) NOT NULL,
  `date` DATETIME NOT NULL,
  `result` ENUM('SUCCESS', 'FAILED', 'PENDING') NOT NULL,
  `checksum` BINARY(32) NOT NULL,
  `schedule_id` INT NULL,
  PRIMARY KEY (`payments_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `method_id_idx` (`available_method` ASC) VISIBLE,
  INDEX `fk_payments_schedule1_idx` (`schedule_id` ASC) VISIBLE,
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
-- Table `PaymentAssistant`.`plan_prices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`plan_prices` (
  `prices_id` INT NOT NULL,
  `amount` DECIMAL(6,2) NOT NULL,
  `recurrencytype` VARCHAR(45) NOT NULL,
  `post_time` DATETIME NOT NULL,
  `endDate` DATETIME NOT NULL,
  `current` BIT(1) NOT NULL,
  `plan_type_id` INT NOT NULL,
  `subscriptions_id` INT NOT NULL,
  PRIMARY KEY (`prices_id`),
  INDEX `fk_plan_prices_pay_plan1_idx` (`plan_type_id` ASC) VISIBLE,
  INDEX `fk_plan_prices_subscriptions1_idx` (`subscriptions_id` ASC) VISIBLE,
  CONSTRAINT `fk_plan_prices_pay_plan1`
    FOREIGN KEY (`plan_type_id`)
    REFERENCES `PaymentAssistant`.`pay_plan_type` (`plan_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_prices_subscriptions1`
    FOREIGN KEY (`subscriptions_id`)
    REFERENCES `PaymentAssistant`.`subscriptions` (`subscriptions_id`)
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
  `enable` BIT(1) NOT NULL,
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
  `datepart` DATE NOT NULL,
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
-- Table `PaymentAssistant`.`paymentspayment_notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`payment_notifications` (
  `notificationid` INT NOT NULL,
  `payments_id` BIGINT UNSIGNED NOT NULL,
  `description` VARCHAR(100) NULL,
  `enable` BIT(1) NOT NULL,
  `message` VARCHAR(70) NOT NULL,
  `details_id` INT NOT NULL,
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
-- Table `PaymentAssistant`.`pay_contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_contact` (
  `contact_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `value` VARCHAR(100) NOT NULL,
  `enabled` BIT(1) NOT NULL,
  `last_update` DATETIME NOT NULL,
  PRIMARY KEY (`contact_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `contact_id_UNIQUE` (`contact_id` ASC) VISIBLE,
  CONSTRAINT `pay_contact_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
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
-- Table `PaymentAssistant`.`userbalance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`userbalance` (
  `balanceid` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `balance` DECIMAL(10,2) NOT NULL,
  `lastbalance` DECIMAL(10,2) NOT NULL,
  `freezeamount` DECIMAL(10,2) NOT NULL,
  `lastupdate` DATETIME NOT NULL,
  `checksum` VARBINARY(32) NOT NULL,
  `last_update` DATETIME NOT NULL,
  PRIMARY KEY (`balanceid`),
  INDEX `fk_userbalance_pay_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_userbalance_pay_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`transactions` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `balanceid` INT NOT NULL,
  `payments_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `transaction_date` DATETIME NOT NULL,
  `post_time` DATETIME NOT NULL,
  `checksum` VARBINARY(32) NOT NULL,
  `ref_number` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`transaction_id`),
  INDEX `payments_id_idx` (`payments_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_transactions_userbalance1_idx` (`balanceid` ASC) VISIBLE,
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
  CONSTRAINT `fk_transactions_userbalance1`
    FOREIGN KEY (`balanceid`)
    REFERENCES `PaymentAssistant`.`userbalance` (`balanceid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`features_per_plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`features_per_plan` (
  `featuresPerPlan_id` INT NOT NULL,
  `value` VARCHAR(45) NOT NULL,
  `enable` BIT(1) NOT NULL,
  `subscriptions_id` INT NOT NULL,
  PRIMARY KEY (`featuresPerPlan_id`),
  INDEX `fk_features_plan_subscriptions1_idx` (`subscriptions_id` ASC) VISIBLE,
  CONSTRAINT `fk_features_plan_subscriptions1`
    FOREIGN KEY (`subscriptions_id`)
    REFERENCES `PaymentAssistant`.`subscriptions` (`subscriptions_id`)
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
  `featuresPerPlan_id` INT NOT NULL,
  PRIMARY KEY (`features_id`),
  INDEX `fk_features_plan_features_per_plan1_idx` (`featuresPerPlan_id` ASC) VISIBLE,
  CONSTRAINT `fk_features_plan_features_per_plan1`
    FOREIGN KEY (`featuresPerPlan_id`)
    REFERENCES `PaymentAssistant`.`features_per_plan` (`featuresPerPlan_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_contact_info_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_contact_info_type` (
  `infotype_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `contact_id` INT NOT NULL,
  PRIMARY KEY (`infotype_id`),
  INDEX `fk_pay_contact_info_type_pay_contact1_idx` (`contact_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_contact_info_type_pay_contact1`
    FOREIGN KEY (`contact_id`)
    REFERENCES `PaymentAssistant`.`pay_contact` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`pay_culture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`pay_culture` (
  `culture_id` INT NOT NULL,
  `currency` VARCHAR(15) NOT NULL,
  `language` VARCHAR(15) NOT NULL,
  `pay_country_country_id` INT NOT NULL,
  PRIMARY KEY (`culture_id`),
  INDEX `fk_pay_culture_pay_country1_idx` (`pay_country_country_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_culture_pay_country1`
    FOREIGN KEY (`pay_country_country_id`)
    REFERENCES `PaymentAssistant`.`pay_country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  PRIMARY KEY (`logsid`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `logs_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `PaymentAssistant`.`pay_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  `logs_logsid` INT NOT NULL,
  PRIMARY KEY (`logtypeid`),
  INDEX `fk_logtypes_logs1_idx` (`logs_logsid` ASC) VISIBLE,
  CONSTRAINT `fk_logtypes_logs1`
    FOREIGN KEY (`logs_logsid`)
    REFERENCES `PaymentAssistant`.`logs` (`logsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`logsources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`logsources` (
  `logsourcesid` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `logsid` INT NOT NULL,
  PRIMARY KEY (`logsourcesid`),
  INDEX `fk_logsources_logs1_idx` (`logsid` ASC) VISIBLE,
  CONSTRAINT `fk_logsources_logs1`
    FOREIGN KEY (`logsid`)
    REFERENCES `PaymentAssistant`.`logs` (`logsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentAssistant`.`logserenty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PaymentAssistant`.`logserenty` (
  `logsrentyid` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `logsid` INT NOT NULL,
  PRIMARY KEY (`logsrentyid`),
  INDEX `fk_logserenty_logs1_idx` (`logsid` ASC) VISIBLE,
  CONSTRAINT `fk_logserenty_logs1`
    FOREIGN KEY (`logsid`)
    REFERENCES `PaymentAssistant`.`logs` (`logsid`)
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
  `ia_answer` VARCHAR(255) NOT NULL,
  `audio_transcription` VARCHAR(255) NOT NULL,
  `date` DATETIME NOT NULL,
  `result` ENUM("ERROR", "CONFIRMED", "CANCELLED", "REPEAT") NOT NULL,
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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
