-- MySQL dump 10.13  Distrib 5.7.23, for Linux (x86_64)
--
-- Host: localhost    Database: ProjectManagement
-- ------------------------------------------------------
-- Server version	5.7.23-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ProjectManagement_addingcost`
--

DROP TABLE IF EXISTS `ProjectManagement_addingcost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_addingcost` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `cost` double NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_ad_order_id_c99e43e4_fk_ProjectMa` (`order_id`),
  CONSTRAINT `ProjectManagement_ad_order_id_c99e43e4_fk_ProjectMa` FOREIGN KEY (`order_id`) REFERENCES `ProjectManagement_ordernumber` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_addingcost`
--

LOCK TABLES `ProjectManagement_addingcost` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_addingcost` DISABLE KEYS */;
INSERT INTO `ProjectManagement_addingcost` VALUES (1,'Откат',10000,NULL);
/*!40000 ALTER TABLE `ProjectManagement_addingcost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_applicationmethod`
--

DROP TABLE IF EXISTS `ProjectManagement_applicationmethod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_applicationmethod` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `method` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_applicationmethod`
--

LOCK TABLES `ProjectManagement_applicationmethod` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_applicationmethod` DISABLE KEYS */;
INSERT INTO `ProjectManagement_applicationmethod` VALUES (1,'Шелкография Водными красками'),(3,'Термопечать'),(4,'Термопечать, вышивка, шелкуха'),(5,'вывязка логотипа, 12 класс вязки, до 3 цветов'),(6,'вышивка, сублимация, картонная бирка, пакет'),(7,'сублимационная печать'),(8,'сублимационный трансфер'),(9,'шелкография водными красками'),(10,'шелкотрансфер, шелкотрафарет'),(11,'термоперенос'),(12,'выдавлвивание'),(13,'гравировка'),(14,'роспись'),(15,'вышивка'),(16,'тиснение'),(17,'шеврон пластизоль'),(18,'шеврон вышивкой'),(19,'шеврон ПВХ'),(20,'вывязка жаккард'),(21,'цифровая печать'),(22,'офсетная печать'),(23,'сублимация и шелкография'),(24,'смешанное нанесение'),(25,'вышивка и сублимация'),(28,'вывзка 12 класс, с хедером, до 3 цветов'),(29,'вывязка логотипа, 16 класс вязки'),(30,'литье мягким пвх'),(31,'НЕТ');
/*!40000 ALTER TABLE `ProjectManagement_applicationmethod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_cart`
--

DROP TABLE IF EXISTS `ProjectManagement_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime(6) NOT NULL,
  `checked_out` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_cart`
--

LOCK TABLES `ProjectManagement_cart` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_cart` DISABLE KEYS */;
INSERT INTO `ProjectManagement_cart` VALUES (2,'2018-09-10 14:44:36.415385',0),(3,'2018-09-10 14:49:22.244131',0),(5,'2018-09-11 16:43:28.533260',0),(6,'2018-09-14 13:17:22.479045',0),(7,'2018-09-14 15:09:52.479621',0),(14,'2018-09-21 09:42:54.834965',0),(17,'2018-09-27 11:13:41.026233',0),(20,'2018-09-27 16:30:46.489880',0),(22,'2018-09-28 11:09:51.785541',0),(23,'2018-09-28 11:25:07.539766',0),(27,'2018-10-02 17:54:54.581318',0),(29,'2018-10-05 12:23:45.388974',0),(30,'2018-10-08 17:22:27.604575',0),(31,'2018-10-10 13:27:24.959886',0),(33,'2018-10-25 16:58:17.034898',0),(34,'2018-11-27 14:37:55.400055',0),(36,'2018-11-27 14:52:35.868675',0),(37,'2018-11-28 13:38:15.177342',0),(39,'2018-11-28 13:59:07.547278',0),(41,'2018-11-28 14:24:09.054261',0),(44,'2018-12-03 15:33:58.774642',0),(45,'2018-12-03 16:16:25.627399',0),(46,'2018-12-03 16:17:32.913290',0),(47,'2018-12-03 16:22:12.230566',0),(48,'2018-12-03 16:22:36.340885',0),(49,'2018-12-03 16:35:55.670443',0),(50,'2018-12-04 11:12:30.554340',0);
/*!40000 ALTER TABLE `ProjectManagement_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_clientdocuments`
--

DROP TABLE IF EXISTS `ProjectManagement_clientdocuments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_clientdocuments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `discription` varchar(3000) DEFAULT NULL,
  `file` varchar(100) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_cl_client_id_bc3f97ab_fk_ProjectMa` (`client_id`),
  CONSTRAINT `ProjectManagement_cl_client_id_bc3f97ab_fk_ProjectMa` FOREIGN KEY (`client_id`) REFERENCES `ProjectManagement_clientprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_clientdocuments`
--

LOCK TABLES `ProjectManagement_clientdocuments` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_clientdocuments` DISABLE KEYS */;
INSERT INTO `ProjectManagement_clientdocuments` VALUES (1,'123','новый','ClientDocuments/Curl.txt',NULL),(2,'Договор','новый','ClientDocuments/Curl_osawi0Z.txt',NULL),(3,'Доп. соглашение','ещё','ClientDocuments/Curl_pel4Eg6.txt',NULL),(4,'Доп. соглашение','ещё','ClientDocuments/Log_tracert.txt',NULL),(5,'Доп. соглашение','ещё','ClientDocuments/FileInsight.exe',NULL),(6,'Ljujdjh','договор','ClientDocuments/ФК_Волгарь_2.jpg',NULL),(7,'Договор',NULL,'ClientDocuments/Договор_ХК_Спартак.doc',2),(8,'Договор',NULL,'ClientDocuments/IMG_20170626_163552.jpg',5),(11,'Логотип + Pantone','Формат документа PDF','ClientDocuments/logo_spartak_pantone_2fWsQaN.pdf',2),(12,'Логотип + Pantone','Формат документа AI','ClientDocuments/logo_spartak_pantone.ai',2);
/*!40000 ALTER TABLE `ProjectManagement_clientdocuments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_clientprofile`
--

DROP TABLE IF EXISTS `ProjectManagement_clientprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_clientprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company` varchar(500) DEFAULT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `surname` varchar(500) DEFAULT NULL,
  `first_name` varchar(500) DEFAULT NULL,
  `middle_name` varchar(500) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `requisites` varchar(3000) DEFAULT NULL,
  `client_type` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `delivery_address` varchar(3000) DEFAULT NULL,
  `contract_attached` tinyint(1) NOT NULL,
  `contract_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_clientprofile_user_id_57d75490_fk_auth_user_id` (`user_id`),
  CONSTRAINT `ProjectManagement_clientprofile_user_id_57d75490_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_clientprofile`
--

LOCK TABLES `ProjectManagement_clientprofile` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_clientprofile` DISABLE KEYS */;
INSERT INTO `ProjectManagement_clientprofile` VALUES (2,'АНО \"Народная команда - ХК \"Спартак\"','','Бугров','Денис','Сергеевич','d.bugrov@msk-spartak.ru','+79250325450','Автономная некоммерческая организация \" Народная Команда - Хоккейный Клуб \" Спартак\" (АНО \"Народная команда - ХК \"Спартак\")\r<br> Юр. адрес: 107023, Москва, Электрозаводская, дом 24, строение 1\r<br> Почтовый адрес: 107023, Москва, Электрозаводская, дом 24, строение 1\r<br> ИНН/КПП 7718112426 / 771801001\r<br> р/с 40703810295000001911 в БАНК ГПБ (АО) БИК 044525823 \r<br> к/с 30101810200000000823',2,54,'107023, Москва, Электрозаводская, дом 24, строение 1',1,'16 от 07 ноября 2017'),(5,'Ассоциация «Хоккейный клуб «Локомотив» Ярославль»','','Павлов','Владимир','Львович','pavlov@hclokomotiv.ru','+79605368000','Ассоциация ХК «Локомотив»\r<br> Юридический адрес: 150023, г. Ярославль, \r<br> ул. Гагарина, д. 15\r<br> Фактический, почтовый адрес: 1500999, \r<br> г. Ярославль, ул. Гагарина, д. 15\r<br> ИНН/КПП   7606034730/760401001\r<br> р/с 40703810077020000231\r<br> в Северном банке ПАО Сбербанк\r<br> к/с 30101810500000000670\r<br> БИК 047 888 670\r<br> Тел.: 8 (4852) 40-71-02',2,NULL,'1500999, г. Ярославль, ул. Гагарина, д. 15',0,'5  от 14.06.17'),(10,'ФК НН','','Хохрин','Егор','....','Khohrin@gmail.com','+79527703737','....',2,NULL,'',0,NULL),(11,'ФК Рубин','','Суханов','Алексей','.....','sukhanov@pfrk.ru','+79172220364','ООО «ПРЕМЬЕР ФУТБОЛ РК» \r<br> ИНН/КПП 165 527 24 48/165 501 001 \r<br> ОКПО – 437 910 12, ОКОГУ – 421 00 14, ОКАТО – 924 013 670 00 \r<br> ОКТМО – 927 010 00, ОКФС – 16, ОКОПФ – 121 65 \r<br> ОКВЭД – 52.48.23 \r<br> ОГРН – 113 169 004 49 69 \r<br> Юридический адрес: \r<br> 420111, г. Казань, ул. Баумана, д.19, помещение 139а \r<br> Фактический (почтовый) адрес: \r<br> 420202, г. Казань, ул. Ташаяк, д.2а, стадион «Центральный», южная трибуна, сектор 5, второй этаж, а/я 641 \r<br> Банковские реквизиты: \r<br> Р/счет – 40702810706090011277 \r<br> в ОOО БАНК «АВЕРС» г. Казань \r<br> К/счет – 30101810500000000774\r<br> БИК 049205774\r<br> e-mail: pfrk@bk.ru \r<br> Телефон: +7 (843) 292-50-60',2,NULL,'420202, г. Казань, ул. Ташаяк, д.2а, стадион «Центральный», южная трибуна, сектор 5, второй этаж, а/я 641',0,NULL),(12,'ХК Авангард','','Шарапова','Елена','....','sharapova_lena@mail.ru','+79150957474','....',2,NULL,'....',0,NULL),(13,'АНО «Хоккейный клуб «Автомобилист»','','Алексей','...','...','AM4444077@gmail.com','+79634444077','АНО «Хоккейный клуб «Автомобилист» город Екатеринбург»\r<br> Юридический адрес:\r<br> 620144, Свердловская область, г. Екатеринбург, ул. Большакова, 90\r<br> Тел. (343) 357-31-71, Факс: (343) 287-34-51\r<br> ИНН 6671195711, КПП 667101001\r<br> р/с 40703810400000000433 в ООО КБ «КОЛЬЦО УРАЛА»\r<br> К/с 30101810500000000768\r<br> БИК 046577768',2,NULL,'620144, Свердловская область, г. Екатеринбург, ул. Большакова, 90',0,'12 от 08.02.18'),(14,'ХК Адмирал','','Теплова','Мария','...','m.teplova@hcadmiral.ru','+79024859901','ООО «Спорт Трейд»\r<br> Юридический адрес: 690024, Приморский край, г. Владивосток, ул. Маковского, д. 284\r<br> Почтовый адрес: 690024, Приморский край, г. Владивосток, ул. Маковского, д. 284\r<br> ИНН: 2540205599\r<br> КПП: 254301001\r<br> Банковские реквизиты\r<br> Расчетный счет 40702810300183906001\r<br> Реквизиты банка:\r<br> ПАО АКБ «Приморье» г. Владивосток,\r<br> Кор. счет: 30101810800000000795\r<br> БИК 040507795',2,NULL,'690024, Приморский край, г. Владивосток, ул. Маковского, д. 284',0,'1 от 24 ноября 2016'),(15,'ООО «СКП «Татнефть- Ак Барс»','','Кандалин','Андрей','....','kandalin.ak-bars@mail.ru','+79272487272','Адрес места нахождения (почтовый и фактический): Российская Федерация, 420015, г. Казань, ул. К.Маркса. д.71.\r<br> Тел: +7 8435338235 / Факс: +7 843 533 82 35\r<br> ИНН 1655085014/КПП 168150001\r<br> ОГРН 1041621031792 /ОКПО74575130\r<br> ОКВЭД 74.40; 92.3; 92.62\r<br> Банковские реквизиты:\r<br> Филиал «Приволжский» ПАО Банк ЗЕНИТ\r<br>  р\\с 40702810800090000077\r<br> К\\с 30101810200000000702 / БИК 049205702',2,NULL,'Российская Федерация, 420015, г. Казань, ул. К.Маркса. д.71.',0,'№6063/18 от «14» мая 2018'),(16,'НП \"Хоккейный клуб Амур\"','','Черных','Евгения','.....','shop@hcamur.ru','+79242127689','ИНН 2722027990     КПП 272101001\r<br> ОГРН 1022701134169\r<br> Юридический и фактический адрес: \r<br> 680013, г.Хабаровск, ул. Дикопольцева, 12\r<br> Спортивно-зрелищный комплекс «Платинум Арена»\r<br> тел. (4212) 42-70-10\r<br> факс (4212) 30-58-99\r<br> бухгалтерия (4212) 30-48-24\r<br> e-mail: hc_amur@bk.ru \r<br> \r<br> Банк: Филиал «Газпромбанк» (Акционерное общество) «Дальневосточный»\r<br> \r<br> р/с 40703810742090000085\r<br> к/с 30101810105070000886 в Дальневосточном главном управлении Центрального банка Российской Федерации \r<br> БИК 040507886\r<br> ИНН 7744001497\r<br> ОГРН 1027700167110\r<br> КПП 253643001\r<br> ОКПО 88271304\r<br> ОКТМО 05701000',2,NULL,'680013, г.Хабаровск, ул. Дикопольцева, 12\r\nСпортивно-зрелищный комплекс «Платинум Арена»',0,NULL),(17,'Частное учреждение \"Хоккейный клуб \"Барыс\"','','Есболов','Берик','....','berik_kali@mail.ru','+77016631677','Юридический адрес: 010000, Астана, ул. Кажымукана, 7\r<br> Почтовый адрес:  010000, Астана, ул. Кажымукана, 7\r<br> тел. Тел +7(7172) 61-35-13, факс 61-35-13\r<br> РНН: 620300311247 \r<br> БИН:080940001956\r<br> КБЕ 17\r<br> Столичный филиал АО \"Цеснабанк\" \r<br> БИК  TSESKZKA \r<br> \r<br> Номер счета  KZ73998ВТВ0000025641(RUB)',2,NULL,'010000, Астана, ул. Кажымукана, 7',0,'2/2018 от 23 июля 2018'),(18,'ООО “Хоккейный Клуб Дианмо-Москва','','Игнатов','Денис','....','denis.i@dynamo.ru','+79057343117','ООО «Хоккейный Клуб Динамо-Москва»\r<br> 125167, город Москва, \r<br> Ленинградское Шоссе 39, стр 53 пом 214\r<br> тел\\факс: +7(495)775-45-93\r<br> ИНН 9710006998\r<br> КПП: 774301001\r<br> ОГРН 1167746085341\r<br> ОКПО 52735662\r<br> р\\с 40702810700000175167\r<br> в  Филиал № 7701 Банка ВТБ (ПАО)\r<br> БИК 044525745\r<br> к\\сч 30101810345250000745',2,NULL,'125167, город Москва, \r\nЛенинградское Шоссе 39, стр 53 пом 214',0,'11 от 25 июля 2018'),(19,'АНО «ХК «ЛАДА','','Бородкина','Екатерина','...','katerina-tlt@mail.ru','+79276172308','Автономная некоммерческая организация «Хоккейный клуб «ЛАДА» \r<br> (АНО «ХК «ЛАДА»)\r<br> Дата создания (регистрации): 23.04.2014 г.\r<br> Юридический адрес: 445000, РФ, Самарская обл., г. Тольятти, ул. Ботаническая, д. 5\r<br> Почтовый адрес: 445036, РФ, Самарская обл., г. Тольятти, ул. Ботаническая, д. 5\r<br> ИНН 6320266716 \r<br> КПП 632001001 \r<br> ОГРН 1146300001110\r<br> р/с 40603810704004000002 в Филиале АО АКБ «НОВИКОМБАНК» в г. Тольятти\r<br> к/с 30101810800000000944 \r<br> БИК 043678944',2,NULL,'445036, РФ, Самарская обл., г. Тольятти, ул. Ботаническая, д. 5',0,'11 от 27 сентября 2017'),(20,'Ассоциация «НХК «Металлург»,','','Губина','Ольга','....','olaintera@mail.ru','+79609050633','Ассоциация «НХК «Металлург»\r<br> 654000, Кемеровская область, \r<br> Новокузнецк, пр. Строителей, 24. \r<br> тел\\факс: (3843) 45-86-77\r<br> ИНН 4217072921\r<br> ОГРН 1054217032100\r<br> ОКПО 72276937 \r<br>  ОКАТО 32431373000\r<br> р\\с 40703810300000000348\r<br> в  АО Кузнецкбизнесбанк\r<br> г. Новокузнецка\r<br> БИК 043209740\r<br> к\\сч 30101810600000000740\r<br> в РКЦ г. Новокузнецка',2,NULL,'654000, Кемеровская область, \r\nНовокузнецк, пр. Строителей, 24.',0,'21 от 24 июля 2018'),(21,'«Хоккейный клуб «Северсталь»,','','Петров','Глеб','....','gleb27petrov2013@yandex.ru','+79992602747','Спортивная автономная некоммерческая организация «Хоккейный клуб «Северсталь»\r<br> Юр. адрес: 162609, РФ, Вологодская область, г. Череповец, Октябрьский пр., 70\r<br> Почт. адрес: 162609, РФ, Вологодская область, г. Череповец, Октябрьский пр., 70\r<br> р/с 40703810971000000045\r<br> В банке: в Филиале Вологодский Банка ВТБ (ПАО) г. Вологда\r<br> БИК 041909722\r<br> к/сч 30101810000000000722\r<br> ИНН/КПП 3528073203/352801001\r<br> тел/факс (8202) 32-34-30 / 32-34-56',2,NULL,'162609, РФ, Вологодская область, г. Череповец, Октябрьский пр., 70',0,NULL),(22,'АНО \"СК\"Кубань-Регион\"','','Вайсбанд','Виктор','...','v.vaisband@hcsochi.ru','+79284509088','АНО \"СК\"Кубань-Регион\"\r<br> Юр Адрес: 354000, Краснодарский край, г. Сочи, ул Воровского 19\r<br> ОГРН  1142300002349\r<br> ИНН/КПП 2320981324/23200100\r<br> р/с 40703810200230778388 в Краснодарский филиал АО ЮниКредит Банк г. Краснодар\r<br> кор/с 30101810400000000548\r<br> Бяк 040349548',2,NULL,'354340, Краснодарский Край, г. Сочи, Адлерский р-н, ул. Ленина д2.',0,'1 от 15 июня 2017'),(23,'ХК Торпедо','','Малютина','Екатерина','...','km@hctorpedo.ru','+79306938317','ИП Климаков Юрий Александрович \r<br> ИНН 525690045762 \r<br> ОГРНИП 318527500116532 \r<br> паспорт 22 08 063078 \r<br> выдан ОУФМС России по Нижегородской области в Автозаводском р-не \r<br> гор. Нижнего Новгорода 13.11.2007 г., зарегистрированный по адресу: Нижегородская область, город Нижний Новгород, пр. Бусыгина, д. 45А, кв. 224',2,NULL,'',0,NULL),(24,'Некоммерческое Партнерство “Хоккейный Клуб “Югра””','','Пархоменко','Александр','.....','marketing@ugra-hc.ru','+79822028885','...',2,NULL,'628001, РФ ХМАО_Югра, г. Ханты-Мансийск, ул. Ледовая 1а',0,'20 от 19 июля 2018'),(25,'ФК Локомотив','','Копьева','Ольга','....','kopeva@finrs.ru','+79175635129','....',2,NULL,'....',0,NULL),(26,'123','','Тестовый','Тест','Тестович','justdani@list.ru','123123','213321',2,50,'123123',0,NULL),(27,'АО «ГСК «Югория»','','Рябков','Дмитрий','Сергеевич','RyabkovDS@ugsk.ru','83467357197','Полное наименование	Акционерное общество «Государственная страховая компания «Югория»\r<br> Сокращенное наименование	АО «ГСК «Югория»\r<br> Юридический адрес	628012, г. Ханты-Мансийск, ул. Комсомольская, д. 61\r<br> Почтовый адрес	628012, г. Ханты-Мансийск, ул. Комсомольская, д. 61\r<br> Руководитель	Охлопков Алексей Анатольевич, Генеральный директор на основании Устава\r<br> Телефон\r<br> Факс	(3467) 357-222\r<br> (3467) 357-223\r<br> ИНН/КПП	8601023568 / 860101001\r<br> Код ОКПО	47854138\r<br> Код ОКОНХ	96210\r<br> Код ОКОГУ	49001\r<br> Код ОКФС	13\r<br> Код ОКОПФ	47\r<br> Код ОКВЭД	66.01 66.02.2 66.03.1 66.03.2 66.03.3 66.03.4 66.03.5 66.03.9\r<br> ОГРН	1048600005728\r<br> Расчетный счет	40701810267460100007\r<br> Наименование банка	Западно-Сибирский банк ПАО «Сбербанк России», Ханты-Мансийское ОСБ 1791\r<br> Кор. счет	30101810800000000651\r<br> БИК	047102651\r<br> \r<br> Внимание!\r<br> В договорах согласующим лицом со стороны компании необходимо указывать Директора Департамента экономики и финансов Косенко Михаила Владимировича, действующего на основании Доверенности №495 от 24.08.2016 г.',2,55,'628012, г. Ханты-Мансийск, ул. Комсомольская, д. 61',0,NULL);
/*!40000 ALTER TABLE `ProjectManagement_clientprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_design1`
--

DROP TABLE IF EXISTS `ProjectManagement_design1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_design1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture` varchar(100) DEFAULT NULL,
  `confirm` tinyint(1) NOT NULL,
  `position_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_de_position_id_abeab2ff_fk_ProjectMa` (`position_id`),
  CONSTRAINT `ProjectManagement_de_position_id_abeab2ff_fk_ProjectMa` FOREIGN KEY (`position_id`) REFERENCES `ProjectManagement_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_design1`
--

LOCK TABLES `ProjectManagement_design1` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_design1` DISABLE KEYS */;
INSERT INTO `ProjectManagement_design1` VALUES (32,'',1,1),(33,'',0,2),(34,'',0,3),(35,'',0,4),(36,'Футболка_с_коротним_рукавом-09_MIeD64A.png',0,9),(37,'logo-white_o2XSUdL.png',0,11),(38,'Picture_design/Desing_1/3.jpg',1,38),(39,'Picture_design/Desing_1/Project_Managment_Systems.jpg',0,21),(40,'Picture_design/Desing_1/Футболка_с_коротним_рукавом_итог-03.png',1,39),(41,'Picture_design/Desing_1/Футболка_с_коротним_рукавом_все-01.jpg',1,95),(42,'Picture_design/Desing_1/ХК_Локомотив_6.jpg',0,60),(43,'',0,117),(44,'Picture_design/Desing_1/Футболка_с_коротним_рукавом_все-04.jpg',0,141),(45,'Picture_design/Desing_1/ХК_Спартак_1_NwyJYmT.jpg',1,146),(46,'Picture_design/Desing_1/Шарфы_classic-01.png',1,147),(47,'Picture_design/Desing_1/настоящииспартаковец_RR76UPe.jpg',1,148),(48,'Picture_design/Desing_1/Шарфы_чемпион-01.png',1,149),(49,'Picture_design/Desing_1/Шарфы_чемпион-02.png',1,150),(50,'Picture_design/Desing_1/logo-white.png',1,174),(51,'Picture_design/Desing_1/Поло-01.jpg',0,217),(52,'Picture_design/Desing_1/Брелок-01.jpg',1,218),(53,'Picture_design/Desing_1/Магнит-01.jpg',1,219),(54,'Picture_design/Desing_1/Вымпел-01.jpg',1,220),(55,'Picture_design/Desing_1/Шарф-01.jpg',1,221),(56,'Picture_design/Desing_1/Шарф_1400х170-09.jpg',1,231),(57,'Picture_design/Desing_1/Шарф_1400х170-01.jpg',0,229),(58,'Picture_design/Desing_1/Шарф_1400х170-02.jpg',0,230),(59,'Picture_design/Desing_1/Шарф_1400х170-04.jpg',0,232),(60,'Picture_design/Desing_1/Шарф_1400х170-05.jpg',0,233),(61,'Picture_design/Desing_1/Шарф_1400х170-06.jpg',0,234),(62,'Picture_design/Desing_1/Шарф_1400х170-07.jpg',0,235),(63,'Picture_design/Desing_1/Значок_закатной_1-01.jpg',0,236),(64,'Picture_design/Desing_1/Значок_закатной_1-01-01.jpg',0,237),(65,'Picture_design/Desing_1/Брелок_пвх_шайба-01.jpg',0,241),(66,'Picture_design/Desing_1/jilet_ugoria-01.jpg',0,225),(67,'Picture_design/Desing_1/jilet_ugoria-02.jpg',0,226),(68,'Picture_design/Desing_1/kurtka_ugoria-02.jpg',0,227),(69,'Picture_design/Desing_1/kurtka_ugoria-03.jpg',0,228),(70,'Picture_design/Desing_1/Vetrovka_ugoria-01.jpg',0,224),(71,'',0,266);
/*!40000 ALTER TABLE `ProjectManagement_design1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_design1_comment`
--

DROP TABLE IF EXISTS `ProjectManagement_design1_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_design1_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture` varchar(100) DEFAULT NULL,
  `comment` varchar(5000) DEFAULT NULL,
  `design_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_de_design_id_a6c4fe7b_fk_ProjectMa` (`design_id`),
  KEY `ProjectManagement_de_user_id_82ad975a_fk_auth_user` (`user_id`),
  CONSTRAINT `ProjectManagement_de_design_id_a6c4fe7b_fk_ProjectMa` FOREIGN KEY (`design_id`) REFERENCES `ProjectManagement_design1` (`id`),
  CONSTRAINT `ProjectManagement_de_user_id_82ad975a_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_design1_comment`
--

LOCK TABLES `ProjectManagement_design1_comment` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_design1_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProjectManagement_design1_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_design2`
--

DROP TABLE IF EXISTS `ProjectManagement_design2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_design2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture` varchar(100) DEFAULT NULL,
  `confirm` tinyint(1) NOT NULL,
  `position_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_de_position_id_1e74c4fc_fk_ProjectMa` (`position_id`),
  CONSTRAINT `ProjectManagement_de_position_id_1e74c4fc_fk_ProjectMa` FOREIGN KEY (`position_id`) REFERENCES `ProjectManagement_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_design2`
--

LOCK TABLES `ProjectManagement_design2` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_design2` DISABLE KEYS */;
INSERT INTO `ProjectManagement_design2` VALUES (3,'Футболка_с_коротним_рукавом-09.png',0,1),(4,'',0,11),(5,'Picture_design/Desing_2/Футболка_с_коротним_рукавом_все-02.jpg',1,95),(6,'Picture_design/Desing_2/Футболка_с_коротним_рукавом_все-01.jpg',1,39),(7,'Picture_design/Desing_2/Футболка_с_коротним_рукавом_все-02_UdEBBJw.jpg',0,60),(8,'',0,146),(9,'Picture_design/Desing_2/Шарфы_classic-02.png',1,147),(10,'Picture_design/Desing_2/Шарфы_classic-04.png',1,148),(11,'Picture_design/Desing_2/CRM_Logo.jpg',1,174),(12,'',0,224);
/*!40000 ALTER TABLE `ProjectManagement_design2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_design2_comment`
--

DROP TABLE IF EXISTS `ProjectManagement_design2_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_design2_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture` varchar(100) DEFAULT NULL,
  `comment` varchar(5000) DEFAULT NULL,
  `design_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_de_design_id_4474d304_fk_ProjectMa` (`design_id`),
  KEY `ProjectManagement_de_user_id_52923dd8_fk_auth_user` (`user_id`),
  CONSTRAINT `ProjectManagement_de_design_id_4474d304_fk_ProjectMa` FOREIGN KEY (`design_id`) REFERENCES `ProjectManagement_design1` (`id`),
  CONSTRAINT `ProjectManagement_de_user_id_52923dd8_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_design2_comment`
--

LOCK TABLES `ProjectManagement_design2_comment` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_design2_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProjectManagement_design2_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_design3`
--

DROP TABLE IF EXISTS `ProjectManagement_design3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_design3` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture` varchar(100) DEFAULT NULL,
  `confirm` tinyint(1) NOT NULL,
  `position_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_de_position_id_a590b076_fk_ProjectMa` (`position_id`),
  CONSTRAINT `ProjectManagement_de_position_id_a590b076_fk_ProjectMa` FOREIGN KEY (`position_id`) REFERENCES `ProjectManagement_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_design3`
--

LOCK TABLES `ProjectManagement_design3` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_design3` DISABLE KEYS */;
INSERT INTO `ProjectManagement_design3` VALUES (3,'',1,1),(4,'',0,11),(5,'',0,147),(6,'Picture_design/Desing_3/Шарфы_classic-03_iau61de.png',0,148),(7,'',0,224);
/*!40000 ALTER TABLE `ProjectManagement_design3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_design3_comment`
--

DROP TABLE IF EXISTS `ProjectManagement_design3_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_design3_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture` varchar(100) DEFAULT NULL,
  `comment` varchar(5000) DEFAULT NULL,
  `design_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_de_design_id_8365b575_fk_ProjectMa` (`design_id`),
  KEY `ProjectManagement_de_user_id_52588542_fk_auth_user` (`user_id`),
  CONSTRAINT `ProjectManagement_de_design_id_8365b575_fk_ProjectMa` FOREIGN KEY (`design_id`) REFERENCES `ProjectManagement_design1` (`id`),
  CONSTRAINT `ProjectManagement_de_user_id_52588542_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_design3_comment`
--

LOCK TABLES `ProjectManagement_design3_comment` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_design3_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProjectManagement_design3_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_design4`
--

DROP TABLE IF EXISTS `ProjectManagement_design4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_design4` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture` varchar(100) DEFAULT NULL,
  `confirm` tinyint(1) NOT NULL,
  `position_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_de_position_id_91f6f2d2_fk_ProjectMa` (`position_id`),
  CONSTRAINT `ProjectManagement_de_position_id_91f6f2d2_fk_ProjectMa` FOREIGN KEY (`position_id`) REFERENCES `ProjectManagement_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_design4`
--

LOCK TABLES `ProjectManagement_design4` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_design4` DISABLE KEYS */;
INSERT INTO `ProjectManagement_design4` VALUES (3,'',0,38),(4,'',0,224);
/*!40000 ALTER TABLE `ProjectManagement_design4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_design4_comment`
--

DROP TABLE IF EXISTS `ProjectManagement_design4_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_design4_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture` varchar(100) DEFAULT NULL,
  `comment` varchar(5000) DEFAULT NULL,
  `design_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_de_design_id_d97aa924_fk_ProjectMa` (`design_id`),
  KEY `ProjectManagement_de_user_id_28c3332a_fk_auth_user` (`user_id`),
  CONSTRAINT `ProjectManagement_de_design_id_d97aa924_fk_ProjectMa` FOREIGN KEY (`design_id`) REFERENCES `ProjectManagement_design1` (`id`),
  CONSTRAINT `ProjectManagement_de_user_id_28c3332a_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_design4_comment`
--

LOCK TABLES `ProjectManagement_design4_comment` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_design4_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProjectManagement_design4_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_designerorder`
--

DROP TABLE IF EXISTS `ProjectManagement_designerorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_designerorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_method_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `material_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_de_app_method_id_7f6ca128_fk_ProjectMa` (`app_method_id`),
  KEY `ProjectManagement_de_item_id_e5cdb19b_fk_ProjectMa` (`item_id`),
  KEY `ProjectManagement_de_material_id_89e3ed6b_fk_ProjectMa` (`material_id`),
  CONSTRAINT `ProjectManagement_de_app_method_id_7f6ca128_fk_ProjectMa` FOREIGN KEY (`app_method_id`) REFERENCES `ProjectManagement_applicationmethod` (`id`),
  CONSTRAINT `ProjectManagement_de_item_id_e5cdb19b_fk_ProjectMa` FOREIGN KEY (`item_id`) REFERENCES `ProjectManagement_item` (`id`),
  CONSTRAINT `ProjectManagement_de_material_id_89e3ed6b_fk_ProjectMa` FOREIGN KEY (`material_id`) REFERENCES `ProjectManagement_materials` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_designerorder`
--

LOCK TABLES `ProjectManagement_designerorder` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_designerorder` DISABLE KEYS */;
INSERT INTO `ProjectManagement_designerorder` VALUES (1,1,NULL,2),(2,1,NULL,1),(3,1,NULL,1),(4,1,NULL,1),(5,1,NULL,1),(6,1,NULL,1),(7,1,NULL,2),(8,1,NULL,1),(9,1,NULL,2),(10,1,NULL,1),(11,1,NULL,2),(12,1,NULL,1),(13,1,NULL,1),(14,1,NULL,3),(15,4,NULL,5),(16,4,NULL,5),(17,6,NULL,6),(18,5,NULL,7),(19,28,NULL,7),(20,20,NULL,7),(21,29,NULL,7),(22,1,NULL,1),(23,1,NULL,2),(24,1,NULL,3),(25,29,52,7),(26,29,15,7),(27,29,51,7),(28,15,53,1),(29,30,55,20),(30,30,54,20),(31,7,56,10),(32,29,15,7),(33,7,58,12),(34,7,59,12),(35,7,60,12),(36,31,16,7),(37,31,15,7),(38,7,18,5),(39,24,51,7),(40,31,51,7),(41,7,20,5),(42,12,25,5),(43,3,11,2),(44,3,11,1),(45,4,12,6),(46,3,21,3),(47,7,46,3),(48,5,57,2),(49,6,55,6),(50,11,19,9),(51,5,56,15),(52,10,58,19),(53,15,60,16),(54,8,59,17),(55,5,60,8),(56,19,57,8);
/*!40000 ALTER TABLE `ProjectManagement_designerorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_designfilesforproduction`
--

DROP TABLE IF EXISTS `ProjectManagement_designfilesforproduction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_designfilesforproduction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file` varchar(100) NOT NULL,
  `position_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_de_position_id_2f36440c_fk_ProjectMa` (`position_id`),
  CONSTRAINT `ProjectManagement_de_position_id_2f36440c_fk_ProjectMa` FOREIGN KEY (`position_id`) REFERENCES `ProjectManagement_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_designfilesforproduction`
--

LOCK TABLES `ProjectManagement_designfilesforproduction` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_designfilesforproduction` DISABLE KEYS */;
INSERT INTO `ProjectManagement_designfilesforproduction` VALUES (2,'Поло.cdr',217),(3,'Поло.pdf',217),(4,'Брелок.eps',218),(5,'Магнит.ai',219),(6,'Вымпел.eps',220),(7,'Шарф.cdr',221),(8,'Шарф_1400х170-09.cdr',231),(9,'Шарф_1400х170-01.cdr',229),(10,'Шарф_1400х170-02.cdr',230),(11,'Шарф_1400х170-04.cdr',232),(12,'Шарф_1400х170-05.cdr',233),(13,'Шарф_1400х170-06.cdr',234),(14,'Шарф_1400х170-07.cdr',235);
/*!40000 ALTER TABLE `ProjectManagement_designfilesforproduction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_designimage`
--

DROP TABLE IF EXISTS `ProjectManagement_designimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_designimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(100) NOT NULL,
  `confirm` tinyint(1) NOT NULL,
  `position_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_de_position_id_889774dc_fk_ProjectMa` (`position_id`),
  CONSTRAINT `ProjectManagement_de_position_id_889774dc_fk_ProjectMa` FOREIGN KEY (`position_id`) REFERENCES `ProjectManagement_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_designimage`
--

LOCK TABLES `ProjectManagement_designimage` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_designimage` DISABLE KEYS */;
INSERT INTO `ProjectManagement_designimage` VALUES (1,'Футболка_с_коротним_рукавом_итог-01.png',0,1),(2,'Футболка_с_коротним_рукавом_итог-04.png',0,1),(4,'Футболка_с_коротним_рукавом_итог-03.png',1,1);
/*!40000 ALTER TABLE `ProjectManagement_designimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_designimagecomment`
--

DROP TABLE IF EXISTS `ProjectManagement_designimagecomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_designimagecomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` varchar(2500) DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `design` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_de_user_id_26f61d51_fk_auth_user` (`user_id`),
  KEY `ProjectManagement_de_position_id_ae5245f9_fk_ProjectMa` (`position_id`),
  CONSTRAINT `ProjectManagement_de_position_id_ae5245f9_fk_ProjectMa` FOREIGN KEY (`position_id`) REFERENCES `ProjectManagement_order` (`id`),
  CONSTRAINT `ProjectManagement_de_user_id_26f61d51_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_designimagecomment`
--

LOCK TABLES `ProjectManagement_designimagecomment` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_designimagecomment` DISABLE KEYS */;
INSERT INTO `ProjectManagement_designimagecomment` VALUES (1,'Кто видит этот коментарий?',1,4,NULL),(2,'',1,4,NULL),(3,'123',1,4,''),(4,'gfd',11,4,''),(5,'fghfgh',38,4,''),(6,'fgh',39,4,''),(7,NULL,11,4,'logo-white_kGt1s8v.png'),(8,NULL,11,4,'logo-white_kGt1s8v.png'),(9,NULL,11,4,'logo-white_kGt1s8v.png'),(10,NULL,11,4,'CRM_Logo_XvkdThb.jpg'),(11,NULL,11,4,'Project_Managment_Systems_lPn5UQ6.jpg'),(12,NULL,11,4,'Project_Managment_Systems_lPn5UQ6.jpg'),(13,'Говно',11,4,''),(14,'Да неее, нормально',11,4,''),(15,NULL,11,4,'123213321321_rrp1IU0.jpg'),(16,'dfgfdg',11,4,''),(17,NULL,38,4,'logo-white_8Vp2TyM.png'),(18,NULL,38,4,'logo_2_qtE3T42.bmp'),(19,'Проверка. ',38,4,''),(20,NULL,11,4,'logo-white_o2XSUdL.png'),(21,'lkj',11,4,''),(22,'123',38,3,''),(23,NULL,38,4,'Project_Managment_Systems_FKsZR8O.jpg'),(24,'Вау',38,4,''),(25,NULL,38,4,'Picture_design/Desing_1/Футболка_с_коротним_рукавом_итог-01.png'),(26,'123',21,NULL,''),(27,'Отправляем',60,NULL,''),(28,'пропррпо',38,3,''),(29,NULL,39,4,'Picture_design/Desing_1/Футболка_с_коротним_рукавом_итог-03.png'),(30,NULL,38,4,'Picture_design/Desing_1/Футболка_с_коротним_рукавом_итог-01.png'),(31,'123',60,4,''),(32,NULL,38,4,'Picture_design/Desing_1/ФК_Волгарь_1_1.jpg'),(33,NULL,95,4,'Picture_design/Desing_2/Футболка_с_коротним_рукавом_все-02.jpg'),(34,'321',95,4,''),(35,'222',95,4,''),(36,NULL,117,4,'Picture_design/Desing_1/ХК_Спартак_1.jpg'),(37,NULL,60,4,'Picture_design/Desing_1/ХК_Локомотив_6.jpg'),(38,NULL,60,4,'Picture_design/Desing_2/Футболка_с_коротним_рукавом_все-02_UdEBBJw.jpg'),(39,NULL,60,NULL,'Picture_design/Desing_1/ХК_Локомотив_6.jpg'),(40,NULL,60,NULL,'Picture_design/Desing_2/Футболка_с_коротним_рукавом_все-02_UdEBBJw.jpg'),(41,'ядлвао',95,4,''),(42,'ыВАыва',95,4,''),(43,'ыва',95,4,''),(44,'ЫВАыпви',95,4,''),(45,'ывымымв',95,4,''),(46,'последнее письмо',95,4,''),(47,NULL,95,4,'Picture_design/Desing_1/Футболка_с_коротним_рукавом_все-01.jpg'),(48,NULL,148,4,'Picture_design/Desing_1/настоящииспартаковец_RR76UPe.jpg'),(49,NULL,148,4,'Picture_design/Desing_2/Шарфы_classic-04.png'),(50,NULL,148,4,'Picture_design/Desing_3/Шарфы_classic-03_iau61de.png'),(51,NULL,148,4,'Picture_design/Desing_3/Шарфы_classic-03_iau61de.png'),(52,'Файлы загрузил',148,4,''),(53,NULL,148,4,'Picture_design/Desing_1/настоящииспартаковец_RR76UPe.jpg'),(54,NULL,148,4,'Picture_design/Desing_1/настоящииспартаковец_RR76UPe.jpg'),(55,NULL,148,4,'Picture_design/Desing_1/настоящииспартаковец_RR76UPe.jpg'),(56,'добрый день',149,NULL,''),(57,'мне не нравиться дизайн',149,NULL,''),(58,NULL,149,NULL,'Picture_design/Desing_1/Шарфы_чемпион-01.png'),(59,NULL,146,NULL,'Picture_design/Desing_1/ХК_Спартак_1_NwyJYmT.jpg'),(60,'Возможно изменить цвет формы и сделать его более темнее',146,NULL,''),(61,'Хорошо. Заменил',146,4,''),(62,'стоимость увеличиться',146,2,''),(63,NULL,174,NULL,'Picture_design/Desing_1/logo-white.png'),(64,NULL,174,NULL,'Picture_design/Desing_2/CRM_Logo.jpg'),(65,NULL,174,NULL,'Picture_design/Desing_1/logo-white.png'),(66,NULL,174,NULL,'Picture_design/Desing_1/logo-white.png'),(67,NULL,174,NULL,'Picture_design/Desing_1/logo-white.png'),(68,NULL,174,NULL,'Picture_design/Desing_1/logo-white.png'),(69,NULL,174,NULL,'Picture_design/Desing_1/logo-white.png'),(70,NULL,174,NULL,'Picture_design/Desing_1/logo-white.png'),(71,NULL,174,NULL,'Picture_design/Desing_1/logo-white.png'),(72,NULL,174,NULL,'Picture_design/Desing_1/logo-white.png'),(73,NULL,174,NULL,'Picture_design/Desing_1/logo-white.png'),(74,NULL,174,NULL,'Picture_design/Desing_1/logo-white.png'),(75,'жываро',146,1,''),(76,'ывапыва',146,1,''),(77,'ываывап',146,1,''),(78,'оп',146,1,''),(79,'lkj',174,4,''),(80,NULL,174,4,'Picture_design/Desing_1/logo-white.png'),(81,'hgfhgf',146,4,''),(82,NULL,146,4,'Picture_design/Desing_2/ХК_Спартак_2.jpg'),(83,NULL,146,4,'Picture_design/Desing_1/ХК_Спартак_1_NwyJYmT.jpg'),(84,'Бывает',149,4,''),(85,'Дизайн одобрен',231,NULL,''),(86,NULL,266,4,'Picture_design/Desing_1/CRM_Logo.jpg'),(87,'123123',266,4,''),(88,'привет',224,2,''),(89,NULL,224,55,'Picture_design/Desing_2/спартак.jpg'),(90,NULL,224,4,'Picture_design/Desing_1/Vetrovka_ugoria-01.jpg'),(91,'Согласны ли вы с Дизайном?',224,4,''),(92,'Да! Всё хорошо!',224,55,'');
/*!40000 ALTER TABLE `ProjectManagement_designimagecomment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_designspecification`
--

DROP TABLE IF EXISTS `ProjectManagement_designspecification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_designspecification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `specification` varchar(10000) DEFAULT NULL,
  `picture` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_designspecification`
--

LOCK TABLES `ProjectManagement_designspecification` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_designspecification` DISABLE KEYS */;
INSERT INTO `ProjectManagement_designspecification` VALUES (15,'Шарфы акрил','70*140 см, 6 см бахрома, хедер в CMYK, шарф в GDR','');
/*!40000 ALTER TABLE `ProjectManagement_designspecification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_filesforproduction`
--

DROP TABLE IF EXISTS `ProjectManagement_filesforproduction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_filesforproduction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discription` varchar(6000) DEFAULT NULL,
  `file` varchar(100) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_fi_order_id_55f8636b_fk_ProjectMa` (`order_id`),
  CONSTRAINT `ProjectManagement_fi_order_id_55f8636b_fk_ProjectMa` FOREIGN KEY (`order_id`) REFERENCES `ProjectManagement_ordernumber` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_filesforproduction`
--

LOCK TABLES `ProjectManagement_filesforproduction` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_filesforproduction` DISABLE KEYS */;
INSERT INTO `ProjectManagement_filesforproduction` VALUES (1,'12321','logo-dark_uEpziq3.jpg',NULL),(2,'Форма для игрушки','Джерси_реплика.pdf',18),(3,'Глаза Игрушки','Глаза.pdf',18),(4,'Шарф Премиум 1','Шарфы_чемпион-01.cdr',18),(5,'Шарф Премиум 2','Шарфы_чемпион-02.cdr',18),(6,'2. Шарф Акрил Дизайн №1','Шарфы_classic-01.cdr',18),(7,'2. Шарф Акрил Дизайн №2','Шарфы_classic-02.cdr',18),(8,'3. Шарф Акрил Дизайн №1','настоящииспартаковец.cdr',18),(9,'2. Шарф Акрил Дизайн №2','Шарфы_classic-04.cdr',18),(10,NULL,'logo_2_sy4AU69.bmp',NULL),(11,NULL,'CRM_Logo_ao6GFcy.jpg',NULL);
/*!40000 ALTER TABLE `ProjectManagement_filesforproduction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_item`
--

DROP TABLE IF EXISTS `ProjectManagement_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `info` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_item`
--

LOCK TABLES `ProjectManagement_item` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_item` DISABLE KEYS */;
INSERT INTO `ProjectManagement_item` VALUES (11,'футболка мужская ULTRAS','items/футболка_ультрас.jpg','Футболка из смесовой ткани, нанесение шелкографией в 1 цвет до формата А4 с 1 стороны, упаковка пэ пакет и картонная бирка.'),(12,'футболка мужская FAN','items/Футболка_с_коротним_рукавом_все-04_ojjKs3N.jpg','Футболка из смесовой ткани  или 100 % хлопка плотности 180 и более гр, нанесение шелкографией 3+0, возможно с двух сторон, объем нанесения обсуждается, упаковка пэ пакет и картонная бирка.'),(13,'футболка мужская Family','items/Футболка_модель_1.jpg','Футболка из смесовой ткани  или 100 % хлопка плотности 180 и более гр, нанесение шелкографией 4+0 или вспененное, возможна вышивка, возможно с двух сторон, объем нанесения обсуждается, упаковка пэ пакет и картонная бирка.'),(15,'Шарф акрил 16','items/Шарфы-06.jpg','Шарф от 16 класса вязки, до 5 цветов в ряд,  100 % акрил'),(16,'Шарф Акрил 10-12','items/Шарфы-05.jpg','Шарф до 12 класса вязки, одноцветная бахрома, 100 % акрил'),(17,'Шарф с вышивкой','items/Шарф_с_вышивкой-04.jpg','Шарф 16 класса вязки, до 5 цветов в ряд, 100 % акрил'),(18,'Значок закатной','items/значок_закатной.jpg','d -32/35 мм, полноцветное нанесение, крепление булавка, без упаковки, металл.'),(19,'Значок металл штамп','items/0dd2a06c-e892-4c48-bf46-346db28128ef.jpg','Размер согласно макету. Нанесение: штамповка с последующей заливкой эмалями или без покраски. Упаковка пакет с еврослотом и картонный вкладыш.'),(20,'Значок Смолевой','items/Sochi_zn_02_2018.jpg','На металлической основе, круглый или прямоугольный, до 1,5 см высотой.Нанесение: печать логотипа и последующая заливка эпоксидной смолой. Крепление бабочка цанга. Упаковка: пакет с еврослотом и картонный вкладыш.'),(21,'Мягкая игрушка 25 см','items/43f555d7-8f06-4934-840b-fb844b2df5cc.jpg','Игрушка высотой 25 см, в виде ростового талисмана клуба, в имитации игровой формы клуба. Нанесение вышивка и сублимация. Упаковка : пакет и картонная бирка.'),(22,'Блокнот А5 на пружине','','15*20 см, картон и бумага, печать полноцвет'),(23,'брелок хоккеист пвх','items/хоккеисты.jpg','Брелок высотой до 5 см, выполнен методом литья жесткого пвх.'),(24,'Брелок пвх шлем','','3d брелок, выполненный методом литья, высота до 5 см'),(25,'Брелок пвх шайба','','Брелок 3d,выполненный методом литья пвх, логотип либо с 1 либо с двух сторон.'),(26,'ежедневник недатированный','items/ежедневник.jpg','формат а5, нанесение уф печать'),(27,'коврик для коньков','items/коврик.jpg','на резиновой основе , коврик с низким ворсом, логотип в 1 цвет'),(28,'банный набор 3 позиции','items/Банный_набор.jpg','шерсть  до 90%, вышивка, упаковка пакет, шапка, варежка и коврик'),(29,'кросовки -кеды','items/кеды.jpg','белые кеды с нанесением логотипа в одном месте'),(30,'кружка','items/кружка.png','керамическая кружка с сублимацией в упаковке'),(31,'линейка','','школьные канцтовары, нанесение с одной стороны в 1 цвет тампопечатью'),(32,'ручка шариковая','','школьные канцтовары, нанесение с одной стороны в 1 цвет тампопечатью'),(33,'карандаш','','школьные канцтовары, нанесение с одной стороны в 1 цвет тампопечатью'),(34,'ластик','','квадратный ластик, винил, нанесение тампопечать'),(35,'пенал','','текстильный пенал, нанесение с одной стороны шелкографией'),(36,'наклейка вырубная в упаковке','','наклейка, полноцветная печать, формать а5, в упаковке пакет.'),(37,'зажигалка тип пьезо','items/Зажигалка_2.png','зажигалка в ассортименте, нанесение тампопечатью, без индивидуальной упаковки, в пачках, от 1000 штук. Возможные цвета белый, зеленый, черный, красный, синий'),(38,'номерная открытка для авто','','формат 1/2 а5, печать 4+0, мелованная бумага 300 гр'),(39,'очки солнечные взрослые','items/Очки_ХК_АкБарс-01.png','пластиковые очки с цветными дужками, печать на дужках логотипа в 1 цвет,  защита от солнца 400'),(40,'шапка меховая','items/502652_1.jpg','шапка в виде игрушки талисмана с подкладкой флис'),(41,'полотенце большое','items/Барыс_полотенце-01.png','70*140 см, плотность 400-450 гр, в два цвета, пестротканное, в упаковке пакет'),(42,'рюкзак из неопрена','','детский рюкзак в виде игрушки, два больших отделения, печать изображения.'),(43,'часы настенные 01','items/1e869f9c-f0ca-4be4-a47b-7cf4516a389e.jpg',NULL),(44,'часы настенные 02','items/02.jpg',NULL),(45,'часы настенные 77','items/9b29698a-fd84-4f0b-b90f-621c3c4969a3.jpg',NULL),(46,'тапочки домашние','items/тапки.jpg','плотный флис или велюр и резиновая подошва, нанесение вышивка'),(47,'чехол айфон 10','items/Чехол_на_IPhone-01.png',NULL),(48,'чехол айфон 6','items/Чехол_на_IPhone-01_iZcYhfY.png',NULL),(49,'буква на клеевой основе','',NULL),(50,'цифра на клеевой основе','',NULL),(51,'шапка  с помпоном взрослая','items/две_взрослые_шапки.jpg','акрил, вывязка логотипа, помпон, 16 класс вязки'),(52,'шапка детская с помпоном','items/детская_шапка.jpg','акрил, вывязка логотипа, 16 класс вязки, детский размер'),(53,'поло','items/поло_химик.png','футболка поло с вышивкой'),(54,'магнит пфх','items/магнит_химик.png','плоский пвх магнит'),(55,'брелок пвх двусторонний','items/брелок_химик.png',NULL),(56,'вымпел жесткий 15*22','items/Вымпел_-03.png','класический вымпел с бахромой или шнуром'),(57,'вымпел авто','items/Вымпел_-02.png',NULL),(58,'Ветровка','items/ХК_Северсталь_2.jpg','Классическая ветровка'),(59,'Жилетка','items/ХК_Северсталь_1.jpg','Классическая Жилетка'),(60,'Куртка','','Для Югории'),(61,'Шапка Петушок','',NULL);
/*!40000 ALTER TABLE `ProjectManagement_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_logisticscompanies`
--

DROP TABLE IF EXISTS `ProjectManagement_logisticscompanies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_logisticscompanies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `surname` varchar(500) DEFAULT NULL,
  `first_name` varchar(500) DEFAULT NULL,
  `middle_name` varchar(500) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `requisites` varchar(5000) DEFAULT NULL,
  `address` varchar(6000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_logisticscompanies`
--

LOCK TABLES `ProjectManagement_logisticscompanies` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_logisticscompanies` DISABLE KEYS */;
INSERT INTO `ProjectManagement_logisticscompanies` VALUES (2,'Деловые линии',NULL,NULL,NULL,NULL,'200-00-03',NULL,NULL),(3,'СДЕК','.','.','.',NULL,'282-13-62','.',NULL),(4,'БлаБлаКар','.','.','.',NULL,NULL,NULL,NULL),(5,'Газель','Александр','.',NULL,NULL,'89200005592','номер карты привязан к телефону','1000 рублей за 2 часа'),(6,'Достависта-курьер',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'Автобус',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,'ПЭК',NULL,NULL,NULL,NULL,'215-13-00',NULL,NULL);
/*!40000 ALTER TABLE `ProjectManagement_logisticscompanies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_logistlink`
--

DROP TABLE IF EXISTS `ProjectManagement_logistlink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_logistlink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `link` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_logistlink`
--

LOCK TABLES `ProjectManagement_logistlink` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_logistlink` DISABLE KEYS */;
INSERT INTO `ProjectManagement_logistlink` VALUES (7,'пек','https://pecom.ru/contacts/filial/nizhniy-novgorod/'),(8,'Деловые линии','https://nizhniy-novgorod.dellin.ru/cabinet/orders/'),(9,'СДЕК','https://lk.cdek.ru/user/login'),(10,'Достависта','https://dostavista.ru');
/*!40000 ALTER TABLE `ProjectManagement_logistlink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_materials`
--

DROP TABLE IF EXISTS `ProjectManagement_materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_materials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `material` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_materials`
--

LOCK TABLES `ProjectManagement_materials` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_materials` DISABLE KEYS */;
INSERT INTO `ProjectManagement_materials` VALUES (1,'100% ХБ'),(2,'92 ХБ, 8 ПЭ'),(3,'Тестовый материал'),(5,'метал,нитки, резина'),(6,'плюш, холофайбер, ложная сетка'),(7,'акрил 100%'),(8,'плюш, холофайбер, полиэстер'),(9,'искусственный мех и плюш, холофайбер, ложная сетка'),(10,'атлас 100%'),(11,'флис 100%'),(12,'полиэстер 100%'),(13,'85 % ХБ, 15% Эластан'),(14,'65% ХБ, 35% ЭЛАСТАН'),(15,'85% ХБ, 10% ЭЛАСТАН'),(16,'ложная сетка'),(17,'тканево-клеевая основа'),(18,'бумага 300 гр'),(19,'дизайнерский картон'),(20,'мягкий пвх');
/*!40000 ALTER TABLE `ProjectManagement_materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_order`
--

DROP TABLE IF EXISTS `ProjectManagement_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL,
  `design_img` varchar(100) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `pre_payment` double DEFAULT NULL,
  `app_method_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `material_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `production_status_id` int(11) DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `size_id` int(11) DEFAULT NULL,
  `shipping_company_id` int(11) DEFAULT NULL,
  `est_date` date DEFAULT NULL,
  `volume` double DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `production_est_date` date DEFAULT NULL,
  `production_purchase_price` double DEFAULT NULL,
  `info` varchar(10000) DEFAULT NULL,
  `design_requirements` varchar(10000) DEFAULT NULL,
  `design_specification_id` int(11) DEFAULT NULL,
  `sending_date` date DEFAULT NULL,
  `delivering_price` double DEFAULT NULL,
  `designer_date` date DEFAULT NULL,
  `provider_pre_payment` double,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_or_client_id_5232ec02_fk_ProjectMa` (`client_id`),
  KEY `ProjectManagement_or_item_id_ac67c654_fk_ProjectMa` (`item_id`),
  KEY `ProjectManagement_or_production_status_id_9c270d8f_fk_ProjectMa` (`production_status_id`),
  KEY `ProjectManagement_or_provider_id_b6b5079a_fk_ProjectMa` (`provider_id`),
  KEY `ProjectManagement_or_order_id_c35ff981_fk_ProjectMa` (`order_id`),
  KEY `ProjectManagement_or_shipping_company_id_8a350487_fk_ProjectMa` (`shipping_company_id`),
  KEY `ProjectManagement_or_size_id_3f9eb960_fk_ProjectMa` (`size_id`),
  KEY `ProjectManagement_or_design_specification_8632ce9e_fk_ProjectMa` (`design_specification_id`),
  KEY `ProjectManagement_or_app_method_id_a5ce1ba2_fk_ProjectMa` (`app_method_id`),
  KEY `ProjectManagement_or_material_id_0848a46d_fk_ProjectMa` (`material_id`),
  CONSTRAINT `ProjectManagement_or_app_method_id_a5ce1ba2_fk_ProjectMa` FOREIGN KEY (`app_method_id`) REFERENCES `ProjectManagement_applicationmethod` (`id`),
  CONSTRAINT `ProjectManagement_or_client_id_5232ec02_fk_ProjectMa` FOREIGN KEY (`client_id`) REFERENCES `ProjectManagement_clientprofile` (`id`),
  CONSTRAINT `ProjectManagement_or_design_specification_8632ce9e_fk_ProjectMa` FOREIGN KEY (`design_specification_id`) REFERENCES `ProjectManagement_designspecification` (`id`),
  CONSTRAINT `ProjectManagement_or_item_id_ac67c654_fk_ProjectMa` FOREIGN KEY (`item_id`) REFERENCES `ProjectManagement_item` (`id`),
  CONSTRAINT `ProjectManagement_or_material_id_0848a46d_fk_ProjectMa` FOREIGN KEY (`material_id`) REFERENCES `ProjectManagement_materials` (`id`),
  CONSTRAINT `ProjectManagement_or_order_id_c35ff981_fk_ProjectMa` FOREIGN KEY (`order_id`) REFERENCES `ProjectManagement_ordernumber` (`id`),
  CONSTRAINT `ProjectManagement_or_production_status_id_9c270d8f_fk_ProjectMa` FOREIGN KEY (`production_status_id`) REFERENCES `ProjectManagement_productionstatus` (`id`),
  CONSTRAINT `ProjectManagement_or_provider_id_b6b5079a_fk_ProjectMa` FOREIGN KEY (`provider_id`) REFERENCES `ProjectManagement_provider` (`id`),
  CONSTRAINT `ProjectManagement_or_shipping_company_id_8a350487_fk_ProjectMa` FOREIGN KEY (`shipping_company_id`) REFERENCES `ProjectManagement_logisticscompanies` (`id`),
  CONSTRAINT `ProjectManagement_or_size_id_3f9eb960_fk_ProjectMa` FOREIGN KEY (`size_id`) REFERENCES `ProjectManagement_size` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=296 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_order`
--

LOCK TABLES `ProjectManagement_order` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_order` DISABLE KEYS */;
INSERT INTO `ProjectManagement_order` VALUES (1,25,'',590,0,1,NULL,NULL,2,NULL,1,1,3,2,'2018-09-14',1,15,'2018-09-13',450,NULL,NULL,NULL,NULL,NULL,NULL,0),(2,15,'',590,0,1,NULL,NULL,2,NULL,1,1,4,NULL,NULL,NULL,NULL,'2018-09-13',500,NULL,NULL,NULL,NULL,NULL,NULL,0),(3,15,'',590,0,1,NULL,NULL,2,NULL,1,1,1,NULL,NULL,NULL,NULL,'2018-09-13',500,NULL,NULL,NULL,NULL,NULL,NULL,0),(4,25,'',590,0,1,NULL,NULL,2,NULL,1,1,2,3,'2018-09-16',1,2,'2018-09-13',500,NULL,NULL,NULL,NULL,NULL,NULL,0),(5,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(6,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(7,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(8,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(9,5,'',690,0,1,NULL,NULL,2,NULL,5,1,1,3,'2018-09-15',1,1,'2018-09-15',510,NULL,NULL,NULL,NULL,NULL,NULL,0),(10,5,'',500,0,1,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Все L',NULL,NULL,NULL,NULL,NULL,0),(11,11,'',400,0,1,NULL,NULL,1,NULL,3,1,NULL,2,NULL,0.7,NULL,'2018-09-20',320,NULL,'Нарисуй ручку, какую нибудь.',NULL,'2018-09-20',100,NULL,0),(12,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(13,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(14,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(15,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(16,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(17,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(18,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(19,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(20,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(21,50,'',500,0,1,2,NULL,1,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,100,'',NULL,NULL,NULL,NULL,NULL,0),(22,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0),(23,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0),(24,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0),(25,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0),(26,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0),(27,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0),(28,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0),(29,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0),(30,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0),(31,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0),(32,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0),(33,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0),(34,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0),(35,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0),(36,15,'',500,0,1,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,90,NULL,0),(37,5,'',400,0,1,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,10,NULL,0),(38,100,'',490,10000,1,NULL,NULL,1,NULL,4,1,NULL,4,'2018-09-26',0.1,10,'2018-09-21',300,NULL,'Нарисуй ручку, какую нибудь.',NULL,'2018-09-23',600,'2018-10-10',0),(39,100,'',510,0,1,NULL,NULL,2,NULL,3,1,NULL,2,'2018-09-26',0.1,10,'2018-09-21',500,NULL,NULL,NULL,'2018-09-23',600,'2018-09-25',0),(40,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(41,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(42,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(43,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(44,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(45,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(46,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(47,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(48,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(49,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(50,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(51,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(52,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(53,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(54,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(55,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(56,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(57,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(58,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(59,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(60,5,'',510,0,1,2,NULL,1,NULL,NULL,NULL,NULL,4,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,100,'2018-09-24',0),(61,15,'',530,0,1,2,NULL,2,NULL,NULL,NULL,NULL,4,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,50,'2018-09-24',0),(62,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(63,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(64,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(65,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(66,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(67,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(68,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(69,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(70,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(71,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(72,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(73,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(74,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(75,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(76,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(77,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(78,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(79,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(80,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(81,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(82,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(83,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(84,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(85,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(86,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(87,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(88,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(89,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(90,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(91,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(92,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(93,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(94,1,'',0,0,1,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,0,NULL,0),(95,200,'',30000,0,1,NULL,NULL,1,NULL,3,1,NULL,2,NULL,1,20,'2018-09-30',340,'Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.Тестовый, достаточно длинный комментарий.','пр прпр прпро прпот праати прпрпр  прп пр',NULL,NULL,520,NULL,0),(96,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(97,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(98,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(99,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(100,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(101,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(102,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(103,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(104,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(105,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(106,1,'',200,0,1,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,100,'g g g g g g g g g g g g g g',NULL,NULL,NULL,0,NULL,0),(107,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(108,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(109,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(110,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(111,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(112,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(113,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(114,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(115,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(116,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(117,50,'',25,100,4,NULL,NULL,5,NULL,3,1,NULL,2,'2018-09-29',0.2,2,NULL,5,'проба проба проооба','1)	Не присваевается номер договора клиенту  нет статуса по договору по цветам цветами  нет даты создания заказа нет маржи  неможем добавить в уже созданый заказ еще позицию в заказ. дополнительных затрат продакшина и логиста не видит, ( обсуждали на последней встрече) 2)	Дата изменения статуса т.е. нет контроля движения заказа полностью, когда создан, когда ушел в продакшн,когда в дизайн,когда согласовали и т.д 3)	 4)	 5)	Номенакулатура -  возможность добавлять более одного файла. 6)	При создании заказа, нет кнопки  отправить в продакшн, 7)	У продакшина горит кнопка Дизайн, а должен в продакшн',NULL,'2018-09-29',500,'2018-09-30',0),(118,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(119,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(120,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(121,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(122,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(123,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(124,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(125,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(126,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(127,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(128,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(129,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(130,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(131,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(132,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(133,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(134,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(135,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(136,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(137,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(138,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(139,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(140,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(141,1,'',50,0,3,NULL,NULL,3,NULL,4,1,NULL,NULL,NULL,NULL,NULL,'1990-10-12',15,'образец','1111',NULL,NULL,0,NULL,0),(142,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(143,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(144,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(145,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(146,250,'',500,10000,6,2,NULL,6,18,6,4,NULL,4,'2018-11-14',0.3,20,'2018-11-11',400,'Продолжаем тираж той которую делали','рисуем только форму спартака',NULL,'2018-11-13',1200,'2018-10-03',0),(147,800,'',210,0,5,2,NULL,7,18,6,2,NULL,6,'2018-10-18',1,160,'2018-10-16',140,'Дизайн вар 1','рисуем в CDR',15,'2018-10-18',4800,'2018-10-04',0),(148,1200,'',210,0,28,2,NULL,7,18,6,2,NULL,6,'2018-10-18',2,240,'2018-10-16',140,'Дизайн вар 3','рисуем в CDR',15,'2018-10-18',7200,'2018-10-04',0),(149,400,'',300,0,29,2,NULL,7,18,6,3,NULL,6,'2018-10-16',0.3,80,'2018-10-15',242,'Дизайн вар 1','рисуем в CDR',15,'2018-10-16',0,'2018-10-03',0),(150,200,'',300,0,29,2,NULL,7,18,6,3,NULL,6,'2018-10-16',0.2,40,'2018-10-15',242,'Дизайн вар 2','рисуем в CDR',NULL,'2018-10-16',0,'2018-10-03',0),(151,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(152,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(153,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(154,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(155,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(156,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(157,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(158,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(159,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(160,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(161,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(162,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(163,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(164,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(165,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(166,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(167,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(168,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(169,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(170,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(171,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(172,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(173,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(174,1,'',0,0,1,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,0,NULL,100),(175,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(176,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(177,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(178,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(179,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(180,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(181,1,'',0,0,1,26,NULL,2,NULL,4,NULL,NULL,NULL,NULL,NULL,NULL,'2018-10-11',0,'',NULL,NULL,'2018-10-12',0,NULL,0),(182,1,'',0,0,1,26,NULL,3,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,'2018-10-20',0,'',NULL,NULL,NULL,0,NULL,0),(183,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(184,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(185,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(186,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(187,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(188,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(189,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(190,200,'',342.2,0,29,23,52,7,21,6,3,NULL,NULL,NULL,NULL,NULL,'2018-10-31',235.5,'',NULL,NULL,NULL,0,NULL,47200),(191,200,'',282.3,0,29,23,15,7,21,6,3,NULL,NULL,NULL,NULL,NULL,'2018-10-31',194,'',NULL,NULL,NULL,0,NULL,39000),(192,300,'',282.3,0,29,23,51,7,21,6,3,NULL,NULL,NULL,NULL,NULL,'2018-10-31',236,'',NULL,NULL,NULL,0,NULL,27490),(193,300,'',282.3,0,29,23,51,7,21,6,3,NULL,NULL,NULL,NULL,NULL,'2018-10-31',236,'',NULL,NULL,NULL,0,NULL,27490),(194,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(195,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(196,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(197,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(198,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(199,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(200,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(201,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(202,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(203,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(204,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(205,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(206,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(207,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(208,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(209,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(210,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(211,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(212,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(213,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(214,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(215,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(216,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(217,40,'',750,0,15,2,53,1,22,6,1,NULL,NULL,NULL,NULL,NULL,'2018-11-19',590,'',NULL,NULL,NULL,0,'2018-11-07',0),(218,150,'',275,0,30,2,55,20,22,6,23,NULL,NULL,NULL,NULL,NULL,'2018-11-19',201.67,'',NULL,NULL,NULL,0,'2018-11-07',0),(219,150,'',205,0,30,2,54,20,22,6,23,NULL,NULL,NULL,NULL,NULL,'2018-11-19',148.33,'',NULL,NULL,NULL,0,'2018-11-07',0),(220,300,'',135,0,7,2,56,10,22,6,22,NULL,NULL,NULL,NULL,NULL,'2018-11-19',103,'',NULL,NULL,NULL,0,'2018-11-07',0),(221,300,'',350,0,29,2,15,7,22,6,3,NULL,NULL,NULL,NULL,NULL,'2018-11-20',240,'',NULL,NULL,NULL,0,'2018-11-07',0),(222,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(223,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(224,280,'',1750,100000,7,27,58,12,23,3,NULL,NULL,NULL,'2018-12-20',NULL,NULL,'2019-12-18',0,NULL,NULL,15,'2018-12-19',0,'2018-11-28',0),(225,140,'',2100,100000,7,27,59,12,23,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1900,'Синий основной цвет',NULL,NULL,NULL,0,'2018-11-28',0),(226,60,'',2100,0,7,27,59,12,23,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1900,'Разноцветная',NULL,NULL,NULL,0,'2018-11-28',0),(227,63,'',2800,0,7,27,60,12,23,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'Синяя основа',NULL,NULL,NULL,0,'2018-11-28',0),(228,37,'',2800,0,7,27,60,12,23,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'Разноцветная',NULL,NULL,NULL,0,'2018-11-28',0),(229,400,'',199,0,31,2,16,7,24,1,2,NULL,6,'2018-12-16',NULL,NULL,'2018-12-14',140,'Дизайн двухсторонний  Спартак 1946','Дизайн 5/6 двухсторонний Спартак Москва 1946',NULL,'2018-12-14',750,'2018-11-29',0),(230,300,'',200,0,31,2,16,7,24,1,2,NULL,6,'2018-12-16',NULL,NULL,'2018-12-14',140,'Дизайн полосатый Спартак','Дизайн 2/3 двухсторонний спартак',NULL,'2018-12-14',750,'2018-11-29',0),(231,300,'',200,0,31,2,16,7,24,1,2,NULL,6,'2018-12-16',NULL,NULL,'2018-12-14',140,'Дизайн много и мелко Спартак Москва','Дизайн 9 полосатый',NULL,'2018-12-14',750,'2018-11-29',0),(232,300,'',310,0,31,2,15,7,24,1,3,NULL,6,'2018-12-18',NULL,NULL,'2018-12-16',242,'Дизайн \"С\" с треснувшим льдом','Дизайн 1 \"С\" с эффектом льда',NULL,'2018-12-16',500,'2018-11-29',0),(233,300,'',310,0,31,2,15,7,24,1,3,NULL,6,'2018-12-18',NULL,NULL,'2018-12-16',242,'Дизайн \"Спартак Москва\" на треснувшем льду','Дизайн 4 Спартак москва с эффектом льда',NULL,'2018-12-16',500,'2018-11-29',0),(234,300,'',200,0,31,2,16,7,24,1,2,NULL,6,'2018-12-16',NULL,NULL,'2018-12-14',140,'Дизайн двухсторонний Спартак','Дизайн 10 Много и мелко спаратк москва',NULL,'2018-12-14',750,'2018-11-29',0),(235,300,'',310,0,31,2,15,7,24,1,3,NULL,6,'2018-12-18',NULL,NULL,'2018-12-16',242,'Дизайн Якушев','Дизайн Якушев',NULL,'2018-12-16',500,'2018-11-29',0),(236,250,'',19.5,0,7,2,18,5,24,1,NULL,NULL,6,'2018-12-19',NULL,NULL,'2018-12-18',15,'Дизайн \"Я болею за Спартак\"','Я болею за спартак',NULL,'2018-12-18',500,'2018-11-29',0),(237,250,'',19.5,0,7,2,18,5,24,1,NULL,NULL,6,'2018-12-19',NULL,NULL,'2018-12-18',15,'Дизайн Победа будет за нами','Победа будет за нами',NULL,'2018-12-18',500,'2018-11-29',0),(238,500,'',310,0,24,2,51,7,24,1,3,NULL,6,'2018-12-18',NULL,NULL,'2018-12-18',245,'Два дизайна по 250 шт','2 ряд дизайн 4,  3 ряд дизайн 1',NULL,'2018-12-16',500,'2018-11-29',0),(239,750,'',310,0,31,2,51,7,24,1,3,NULL,6,'2018-12-18',NULL,NULL,'2018-12-18',245,'ЭТО ШАПКА ПЕТУШОК: 3 Дизайна по 250 шт','ЭТО ШАПКИ ПЕТУШКИ. 1 ряд дизайн 2и3,  3 ряд дизайн 3',NULL,'2018-12-16',500,'2018-11-29',0),(240,750,'',115,0,7,2,20,5,24,1,NULL,NULL,6,'2018-12-19',NULL,NULL,'2018-12-18',84,'1 дизайн - джесри и 2 дизайна Ретро','3 дизайна: 1 Джерси и 2 Ретро',NULL,'2018-12-18',500,'2018-11-29',0),(241,200,'',245,0,12,2,25,5,24,1,10,NULL,6,'2018-12-19',NULL,NULL,'2018-12-18',165,'Двухсторонний ПВХ  брелок','Брелок 2-х сторонний',NULL,'2018-12-18',500,'2018-11-29',0),(242,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(243,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(244,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(245,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(246,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(247,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(248,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(249,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(250,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(251,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(252,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(253,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(254,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(255,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(256,1,'',0,0,3,26,11,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,0,NULL,0),(257,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(258,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(259,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(260,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(261,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(262,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(263,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(264,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(265,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(266,22,'',500,0,3,26,11,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,120.1,'123321',NULL,NULL,NULL,0,NULL,0),(267,123,'',400,0,4,26,12,6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,200.2,'123',NULL,NULL,NULL,0,NULL,0),(268,23,'',800,0,3,26,21,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,632.3,'23123',NULL,NULL,NULL,0,NULL,0),(269,321,'',2100,0,7,26,46,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1500,'213',NULL,NULL,NULL,0,NULL,0),(270,115,'',3500,0,5,26,57,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3500,'3213',NULL,NULL,NULL,0,NULL,0),(271,1354,'',16000,0,6,26,55,6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1600,'12321',NULL,NULL,NULL,0,NULL,0),(272,500,'',110,0,11,26,19,9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,100,'321312',NULL,NULL,NULL,0,NULL,0),(273,1345,'',250,0,6,26,55,6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,240,NULL,NULL,NULL,NULL,0,NULL,0),(274,145,'',270,0,5,26,56,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,220,NULL,NULL,NULL,NULL,0,NULL,0),(275,17,'',600,0,10,26,58,19,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,450,NULL,NULL,NULL,NULL,0,NULL,0),(276,154,'',750,0,15,26,60,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,580,NULL,NULL,NULL,NULL,0,NULL,0),(277,1543,'',250,0,8,26,59,17,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,220,NULL,NULL,NULL,NULL,0,NULL,0),(278,1456,'',320,0,5,26,60,8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,310,'3213',NULL,NULL,NULL,0,NULL,0),(279,1654,'',210,0,19,26,57,8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,200,NULL,NULL,NULL,NULL,0,NULL,0),(280,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(281,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(282,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(283,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(284,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(285,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(286,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(287,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(288,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(289,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(290,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(291,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(292,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(293,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(294,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0),(295,1,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,0);
/*!40000 ALTER TABLE `ProjectManagement_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_ordercomment`
--

DROP TABLE IF EXISTS `ProjectManagement_ordercomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_ordercomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` varchar(4000) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_or_order_id_2c8da63c_fk_ProjectMa` (`order_id`),
  KEY `ProjectManagement_ordercomment_user_id_ee8f6298_fk_auth_user_id` (`user_id`),
  CONSTRAINT `ProjectManagement_or_order_id_2c8da63c_fk_ProjectMa` FOREIGN KEY (`order_id`) REFERENCES `ProjectManagement_ordernumber` (`id`),
  CONSTRAINT `ProjectManagement_ordercomment_user_id_ee8f6298_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_ordercomment`
--

LOCK TABLES `ProjectManagement_ordercomment` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_ordercomment` DISABLE KEYS */;
INSERT INTO `ProjectManagement_ordercomment` VALUES (1,'кому пришло?',NULL,3),(2,'',NULL,2),(3,'все видят?',NULL,2),(4,'123',NULL,5),(5,'',NULL,5),(6,'Комментарий',NULL,3),(7,'Комментарий',NULL,3),(8,'Коммент',NULL,4),(9,'564',NULL,4),(10,'123',NULL,3),(11,'678',NULL,4),(12,'876',NULL,4),(13,'12',NULL,4),(14,'321',NULL,3),(15,'Комментарий',NULL,3),(16,'456',NULL,3),(17,'456',NULL,3),(18,'dsa',NULL,3),(19,'Переписка',NULL,3),(20,'Переписка',NULL,3),(21,'Переписка',NULL,3),(22,'Переписка',NULL,3),(23,'Переписка',NULL,3),(24,'Переписка',NULL,3),(25,'Переписка',NULL,3),(26,'Переписка',NULL,3),(27,'Переписка',NULL,3),(28,'Переписка',NULL,3),(29,'Комментарий',NULL,3),(30,'Комментарий',NULL,3),(31,'Комментарий',NULL,3),(32,'324234',NULL,3),(33,'243',NULL,3),(34,'kjhgfkjhg',NULL,3),(35,'пробуй',NULL,4),(36,'123',NULL,3),(37,'1',NULL,3),(38,'коментарии к заказыууу',NULL,3),(39,'енкш',NULL,4),(40,'ывавыатлы',NULL,2),(41,'под пунктом 2 не верные дизайны',18,3),(42,'ntgthm jr',18,3),(43,'теперь ок',18,3),(44,'Олег, шарфы Премиум отправка по москве, шарфы Акрил - отправка как обычно спартаку по москве, игрушки сначала к нам потом в мск',18,2),(45,'123',NULL,4),(46,'Леха, я выслал тебе дизайны на почту. Сделай их для продакшна пжл',23,3),(47,'Леха, прикрепи дизайны по изделиям',24,3),(48,'saeddsadsa',NULL,1),(49,'qweew',NULL,2),(50,'asdda',NULL,4),(51,'123321',NULL,4),(52,'как дела?',23,2),(53,'нормально',23,4),(54,'хреново',23,2);
/*!40000 ALTER TABLE `ProjectManagement_ordercomment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_orderdocuments`
--

DROP TABLE IF EXISTS `ProjectManagement_orderdocuments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_orderdocuments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `discription` varchar(3000) DEFAULT NULL,
  `file` varchar(100) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_or_order_id_09ce96cd_fk_ProjectMa` (`order_id`),
  CONSTRAINT `ProjectManagement_or_order_id_09ce96cd_fk_ProjectMa` FOREIGN KEY (`order_id`) REFERENCES `ProjectManagement_ordernumber` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_orderdocuments`
--

LOCK TABLES `ProjectManagement_orderdocuments` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_orderdocuments` DISABLE KEYS */;
INSERT INTO `ProjectManagement_orderdocuments` VALUES (1,'Договор','договор','Client.txt',NULL),(2,'','','Примерная_схема_для_CRM_-_с_вопросами_1.docx',NULL),(3,'','','ФК_Волгарь_2.jpg',NULL),(4,'Финальный дизайн','123','logo-white_bsehMCk.png',NULL),(5,'','','Футболка_с_коротним_рукавом_все-01.pdf',NULL),(6,'','','Футболка_с_коротним_рукавом_все-02.pdf',NULL),(7,'','','Футболка_с_коротним_рукавом_все-01_pMjIasA.pdf',NULL),(8,'','','Футболка_с_коротним_рукавом_все-02_AAYBGt9.pdf',NULL),(9,'','','Футболка_с_коротним_рукавом_все-04.pdf',NULL),(10,'1','1','7.png',NULL),(11,'Приложение 4 от 27.09.18','','Спартак2.pdf',18);
/*!40000 ALTER TABLE `ProjectManagement_orderdocuments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_ordernumber`
--

DROP TABLE IF EXISTS `ProjectManagement_ordernumber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_ordernumber` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_done` tinyint(1) NOT NULL,
  `date` datetime(6) NOT NULL,
  `info` varchar(5000) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `logist_delivering` int(11) DEFAULT NULL,
  `manager_addition_cost` int(11) NOT NULL,
  `add_agreement` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_or_client_id_8ecacedc_fk_ProjectMa` (`client_id`),
  KEY `ProjectManagement_ordernumber_user_id_a13bde0d_fk_auth_user_id` (`user_id`),
  KEY `ProjectManagement_ordernumber_status_id_708c7206` (`status_id`),
  CONSTRAINT `ProjectManagement_or_client_id_8ecacedc_fk_ProjectMa` FOREIGN KEY (`client_id`) REFERENCES `ProjectManagement_clientprofile` (`id`),
  CONSTRAINT `ProjectManagement_or_status_id_708c7206_fk_ProjectMa` FOREIGN KEY (`status_id`) REFERENCES `ProjectManagement_productionstatus` (`id`),
  CONSTRAINT `ProjectManagement_ordernumber_user_id_a13bde0d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_ordernumber`
--

LOCK TABLES `ProjectManagement_ordernumber` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_ordernumber` DISABLE KEYS */;
INSERT INTO `ProjectManagement_ordernumber` VALUES (18,1,'2018-10-02 17:54:54.482797',NULL,6,2,2,0,0,'4 от 27.09.18'),(21,0,'2018-10-25 16:58:16.879155',NULL,6,23,2,0,0,NULL),(22,1,'2018-11-27 14:52:35.522718',NULL,6,2,2,0,0,NULL),(23,0,'2018-11-28 13:59:07.256887',NULL,1,27,2,0,0,'1 от 28 ноября 2018'),(24,0,'2018-11-28 14:24:08.798502',NULL,2,2,2,0,0,'5 от 28 ноября 2018');
/*!40000 ALTER TABLE `ProjectManagement_ordernumber` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_orderstatus`
--

DROP TABLE IF EXISTS `ProjectManagement_orderstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_orderstatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_orderstatus`
--

LOCK TABLES `ProjectManagement_orderstatus` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_orderstatus` DISABLE KEYS */;
INSERT INTO `ProjectManagement_orderstatus` VALUES (1,'Дизайн'),(2,'Отправлен'),(3,'Доставлен'),(4,'Сборка');
/*!40000 ALTER TABLE `ProjectManagement_orderstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_productionstatus`
--

DROP TABLE IF EXISTS `ProjectManagement_productionstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_productionstatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_productionstatus`
--

LOCK TABLES `ProjectManagement_productionstatus` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_productionstatus` DISABLE KEYS */;
INSERT INTO `ProjectManagement_productionstatus` VALUES (1,'На просчете'),(2,'Просчитан'),(3,'Дизайн'),(4,'В производстве'),(5,'Логист'),(6,'Сдан');
/*!40000 ALTER TABLE `ProjectManagement_productionstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_provider`
--

DROP TABLE IF EXISTS `ProjectManagement_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_provider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `surname` varchar(500) DEFAULT NULL,
  `first_name` varchar(500) DEFAULT NULL,
  `middle_name` varchar(500) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `requisites` varchar(10000) DEFAULT NULL,
  `address` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_provider`
--

LOCK TABLES `ProjectManagement_provider` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_provider` DISABLE KEYS */;
INSERT INTO `ProjectManagement_provider` VALUES (1,'ООО \"Ника-тигра\"','Рыбакова','Вероника',NULL,'tigra-vika52@mail.ru','89519138133','ИНН 5263064042, КПП 526301001, 603158, Нижегородская обл, Нижний Новгород г, Зайцева ул, дом № 31, кв.805, тел.: (831) 211-30-41, Ген.Директор Фролов А.А.','Нижегородская обл, Нижний Новгород г, Зайцева ул, дом № 31'),(2,'ООО Бах Текстиль','Богатырёв','Аслан','Хусеинович','bahtextile@mail.ru','89298437111','ИНН 2628058503, КПП262801001,БИК 040702615, 40702810660100011643','357736, Ставропольский край, г.Кисловодск, улица Марцинкевича, д.90 кв.48'),(3,'ООО \"Легион\"','Киреева','Мария',NULL,'l-dom@inbox.ru','+375-29-111-66-66','ИНН 6732122640','Представительство в РФ\r\n\r\nООО \"Легион\", РФ 214030, Смоленская область, г.Смоленск, Краснинское шоссе,37-2\r\nАдрес почтовый\r\n\r\n220004, г. Минск, ул. Романовская слобода, 11'),(4,'ООО Рекламный Базар','Суховеркова','Анастасия','Владимировна','reklam-bazar@yandex.ru','+7 925 510-77-07','ИНН\\КПП 7722722061/772201001\r\nЮридический адрес:\r\n111116, Москва, ул. Энергетическая, д. 16\r\nкорп. 1, тел. 8 495-510-77-07\r\nПочтовый адрес:\r\n111116, Москва, ул. Энергетическая, д. 16\r\nкорп. 1, тел. 8 495-510-77-07\r\nр/сч 40702810500000010050\r\nАКБ “НБВК” ЗАО г. Москва\r\nк/сч 30101810245250000573\r\nБИК 044525573','111116, Москва, Гостиничная 3'),(5,'ООО \"Нордтекс\"','Чернышова','Ирина',NULL,'chernyshova.i.v@nord-tex.ru','89620924800','Общество с ограниченной ответственностью \"Нордтекс\" (ООО \"Нордтекс\")\r\nАдрес	РФ, 143904 Московская область, г. Балашиха Западная коммунальная зона, ш. Энтузиастов, владение 4\r\n\r\nТел./Факс	730-88-53 730-88-53 ДОБ. 1278\r\n\r\nИНН 5001069981 КПП 500101001 Филиал ПАО «Сбербанк России» Ивановское отделение №8639 р/с 40702810517000002302 к/с 30101810000000000608\r\nБИК 042406608','РФ, 143904 Московская область, г. Балашиха Западная коммунальная зона, ш. Энтузиастов, владение 4'),(6,'ООО Актив плюс','Ларионова','Алла',NULL,'fabrikaplusha@mail.ru','89109886437','Полное наименование	Общество с ограниченной ответственностью \"Актив Плюс\"\r\nСокращенное наименование	ООО \"Актив Плюс\"\r\nДиректор	Шрибак Роман Николаевич\r\nЮридический адрес	153032, г. Иваново, ул. Лежневская, д. 158 Б, оф. 1\r\nФактический адрес	153034, г. Иваново, ул. Огородная, д. 33, оф. 3\r\nИНН / КПП	3702644668 / 370201001\r\nОГРН	1113702009850\r\nОКПО	69367501\r\nРасчетный счет	407 028 102 170 000 003 87\r\nБанк	Отделение №8639 Сбербанка России г. Иваново\r\nБИК	042 406 608\r\nК/с	301 018 100 000 000 006 08\r\nТелефон	+7-910-988-64-37, +7-920-370-37-24','153034, г. Иваново, ул. Огородная, д. 33, оф. 3'),(7,'ООО \"Проект 111\"','Медведева','Светлана',NULL,'smedvedeva@gifts.ru','+7 929 106 08 24','Адрес: 190031 г. Санкт-Петербург, пр-т Московский,\r\nд. 10-12,лит. В, пом.83Н\r\nИНН 7838307811 КПП 783801001 ОГРН 1047855113261\r\nОКПО 74772563; ОКВЭД 51.70; ОКАТО 40262562000\r\nР/с 40702810722500000041 в ПАО «БАНК УРАЛСИБ»\r\nК/с 30101810800000000706 в Северо-Западном ГУ Банка\r\nРоссии, БИК 044030706\r\nГенеральный директор ООО «Проект 111» Афанасьев Дмитрий Игоревич','190031 г. Санкт-Петербург, пр-т Московский,\r\nд. 10-12,лит. В, пом.83Н'),(8,'ООО \"РИЗА Гифтс\"','Жерздева','Татьяна',NULL,'manager@riza.ru','+7 (495) 988-29-60','ИНН 9723037150, КПП 772301001, АО ОТП БАНК г.Москва  БИК 044525311','Москва. проспект Южнопортовый, 2-й, дом 5, корп 1, этаж 1, пом 6 ком 1.Индекс 115088'),(9,'ООО \"ГЛАВСПОРТ НН\"','Баранов','Антон',NULL,'glavsport@mail.ru','89036001323','ООО \"ГЛАВСПОРТ НН\",  ИНН 5260432273, КПП 526001001','Нижний Новгород, Малая Ямская 65/4, п 2, 603000'),(10,'ООО Формула рекламы','Савицкий','Евгений',NULL,'8043404@gmail.com','Т. +7 495 792-80-34 | M. +7 968 804-34-04','Нижний Новгород г, Бориса Панина ул, дом № 3А, офис 215А	603105','Нижний Новгород г, Бориса Панина ул, дом № 3А, офис 215А	603105'),(11,'ООО Промошапка','Бунакова','Ольга',NULL,'bunakova@promoshapka.com','Тел.: +7 (4852) 44-81-91 доб.121 +7 (4852) 44-81-6','150030, Россия, Ярославль\r\nул. Льва Толстого, 26',NULL),(12,'ООО Принт Салон СПБ','Сильченко','Павел',NULL,NULL,'8 (800) 511-09-44','198334, Россия, г. Санкт-Петербург, ул. Добровольцев, 54-168\r\n7807385457 / 780701001\r\n40702810401180000760\r\nв Филиал Петровский ПАО Банка \"ФК Открытие\"\r\n30101810540300000795 БИК: 044030795','198334, Россия, г. Санкт-Петербург, ул. Добровольцев, 54-168'),(13,'ООО \"Сувениритет\"','Попова','Дарья',NULL,'popova222@yandex.ru','89036380579,','ООО \"Сувениритет\", ИНН 7604126312, КПП 760401001, 150010, Ярославская обл, Ярославль г, Попова ул, дом № 22, квартира 47, тел.: (4852) 493353, 599462','150010, Ярославская обл, Ярославль г, Попова ул, дом № 22, квартира 47'),(14,'ООО АРТиК','Сергей',NULL,NULL,'artik-nn@mail.ru','+7(831)4-129-179, +7(831)4-129-149','г.Н.Новгород\r\nул.Артельная, д.21а','г.Н.Новгород\r\nул.Артельная, д.21а'),(15,'ООО Авантаж',NULL,'Марина',NULL,'avantage_print@bk.ru','89519097961','Нижний Новгород, ул.Фучика  60','Нижний Новгород, ул.Фучика  60'),(16,'ООО Тигра Стиль','Рыбакова','Вероника',NULL,'tigra-vika52@mail.ru','89519138133','Нижний Новгород, Зайцева 31','Нижний Новгород, Зайцева 31'),(17,'ООО Лазер холл','Мочалин','Павел',NULL,'pm@laserhall.org','+7 (831) 429-04-71  | +7(909)299-29-64 |',NULL,'ул. Бориса Панина, 3А, Нижний Новгород (Нижний Новгород, ул. Бориса Панина, дом 3А, оф. 202 (2-й этаж))'),(18,'ИП Карцев','Карцев','Александр',NULL,'admin@polymark.ru','8-910-985-40-92','г. Иваново, ул. Советская, д. 22А\r\nИП Карцев А.Е. (Компания \"Полимарк\")','г. Иваново, ул. Советская, д. 22А\r\nИП Карцев А.Е. (Компания \"Полимарк\")'),(19,'ООО ВИСПО','Крамер','Андрей',NULL,NULL,'89060545999','Россия, 107150, г. Москва, ул. Пермская 11, с. 5, оф. 501','Россия, 107150, г. Москва, ул. Пермская 11, с. 5, оф. 501'),(20,'ООО АРС','Куцан','Ирина',NULL,'opt@ramki-nomerov.ru','8 800 500 48 68 | +7 900 347 90 47',NULL,NULL),(21,'ООО Типография 1','Чернова','Татьяна',NULL,'1pk@mail.ru','89307080078',NULL,'Печерский съезд'),(22,'ООО Русфлаг','Полубарьев','Алексей',NULL,'rusflagnn@mail.ru','8-910-105-55-999','603089, г. Н. Новгород,\r\nВысоковский проезд, д.22','603089, г. Н. Новгород,\r\nВысоковский проезд, д.22'),(23,'ООО Фабрика сувениров','Савицкий','Евгений',NULL,'8043404@gmail.com','89151050985',NULL,NULL),(24,'\"Мосзнак\"  ООО \"ПК ДВС\"','Якунин',NULL,NULL,'mosznak@gmail.com','(495) 120-21-44 (многоканальный)          (495) 67','ИНН 7720782386, КПП 772001001\r\nр/с 40702810838120010301\r\nв ПАО СБЕРБАНК, г. Москва\r\nк/с 30101810400000000225\r\nБИК 044525225\r\n111024, г.Москва, проезд Энтузиастов, д.5 стр.2','111024, г.Москва, проезд Энтузиастов, д.5 стр.2'),(25,'ООО \"Нилтекс Интернешнл Трейдинг\"(жилеты)','Рубашов','Антон',NULL,'anton@formatpromo.ru','+7 (495) 150-46-74  +7 (926) 878-46-99','ИНН 7717752776, КПП 774301001, 125599, Москва г, Ижорская ул, дом № 5, строение 1, помещение III ком 17,18','125599, Москва г, Ижорская ул, дом № 5, строение 1, помещение III ком 17,18'),(26,'РК Спорт',NULL,'Марина',NULL,'zakaz@rk-sport.ru','+7 (499) 350-84-20','Москва,\r\n2-й Верхний Михайловский проезд 9,\r\nстроение 3, подъезд 2','Москва,\r\n2-й Верхний Михайловский проезд 9,\r\nстроение 3, подъезд 2'),(27,'ИП Якобенчук','Башмаков','Олег',NULL,'nash.grad@gmail.com','тел. +7 (495) 612-10-71, 646-1-456  тел.+7 977 566','Индивидуальный предприниматель Якобенчук Александр\r\nВладимирович\r\nЕГРН 304272326700011 ИНН 272304254120\r\nСв-во серия 27 № 000291279 от 23.09.2004 г.\r\nЮр. адрес: г. Хабаровск, ул. Краснореченская, 128/97\r\nр/с 40802810208010005381 в РЕГИОБАНК-филиал ПАО Банка\r\n«ФК Открытие» г.Хабаровск\r\nБИК 040813997 к/с 30101810508130000997','г. Хабаровск, ул. Краснореченская, 128/97'),(28,'ООО Промсервис','Чешуин','Том',NULL,'9650262@mail.ru',NULL,NULL,NULL),(29,'ООО «ИДК»',NULL,'Арина',NULL,'info@upakovkatut.ru','8(495)-973-13-72','упаковка для кружек',NULL),(30,'Металл Хантымансийск',NULL,'Максим',NULL,'hmsf@mail.ru','+7 922 257-55-00',NULL,NULL),(31,'ООО \"Роял Сервис\"','Насырова','Алина',NULL,'director@prom-hotel.ru','+74994042757','ИНН 7724347306 КПП 772401001\r\nПолучатель\r\nООО \"Роял Сервис\" Сч. № 40702810502640000918\r\nБанк получателя БИК 044525593\r\nАО «АЛЬФА- БАНК» Сч. № 30101810200000000593','УЛ. КОТЛЯКОВСКАЯ, ДОМ 3, СТРОЕНИЕ 1, МОСКВА, Россия,\r\n115201');
/*!40000 ALTER TABLE `ProjectManagement_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_providerdocuments`
--

DROP TABLE IF EXISTS `ProjectManagement_providerdocuments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_providerdocuments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `discription` varchar(300) DEFAULT NULL,
  `file` varchar(100) NOT NULL,
  `provider_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_pr_provider_id_7201e3f9_fk_ProjectMa` (`provider_id`),
  CONSTRAINT `ProjectManagement_pr_provider_id_7201e3f9_fk_ProjectMa` FOREIGN KEY (`provider_id`) REFERENCES `ProjectManagement_provider` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_providerdocuments`
--

LOCK TABLES `ProjectManagement_providerdocuments` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_providerdocuments` DISABLE KEYS */;
INSERT INTO `ProjectManagement_providerdocuments` VALUES (6,'договор с ТГ 789','договор','ProviderDocuments/ТГ789.doc',1),(7,'договор с ТГ 789 с НДС','договор с НДС','ProviderDocuments/с_НДС_ТГ789.doc',1),(8,'договор с Глобал Спорт Маркетинг','договор без НДС','ProviderDocuments/Глобал_спорт.doc',1),(9,'договор с Глобал Спорт Маркетинг с НДС','договор с НДС','ProviderDocuments/с_НДС__Глобал_спорт.doc',1),(10,'договор поставки Динамо','договор на полотенца','ProviderDocuments/Договор_поставки_ГСМ_Нордтекс.doc',5),(11,'карточка предприятия','реквизиты','ProviderDocuments/Карточка_Актив_Плюс.docx',6);
/*!40000 ALTER TABLE `ProjectManagement_providerdocuments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_size`
--

DROP TABLE IF EXISTS `ProjectManagement_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_size` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `size` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_size`
--

LOCK TABLES `ProjectManagement_size` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_size` DISABLE KEYS */;
INSERT INTO `ProjectManagement_size` VALUES (1,'S'),(2,'M'),(3,'L'),(4,'XL'),(5,'б.р');
/*!40000 ALTER TABLE `ProjectManagement_size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectManagement_temporaryorder`
--

DROP TABLE IF EXISTS `ProjectManagement_temporaryorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectManagement_temporaryorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(10) unsigned NOT NULL,
  `price` double DEFAULT NULL,
  `pre_payment` double DEFAULT NULL,
  `app_method_id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `material_id` int(11) NOT NULL,
  `size_id` int(11) DEFAULT NULL,
  `info` varchar(3000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProjectManagement_te_app_method_id_18edb6ce_fk_ProjectMa` (`app_method_id`),
  KEY `ProjectManagement_te_cart_id_65706e70_fk_ProjectMa` (`cart_id`),
  KEY `ProjectManagement_te_client_id_6443401b_fk_ProjectMa` (`client_id`),
  KEY `ProjectManagement_te_item_id_4fca750a_fk_ProjectMa` (`item_id`),
  KEY `ProjectManagement_te_material_id_30e5137f_fk_ProjectMa` (`material_id`),
  KEY `ProjectManagement_te_size_id_ee12596e_fk_ProjectMa` (`size_id`),
  CONSTRAINT `ProjectManagement_te_app_method_id_18edb6ce_fk_ProjectMa` FOREIGN KEY (`app_method_id`) REFERENCES `ProjectManagement_applicationmethod` (`id`),
  CONSTRAINT `ProjectManagement_te_cart_id_65706e70_fk_ProjectMa` FOREIGN KEY (`cart_id`) REFERENCES `ProjectManagement_cart` (`id`),
  CONSTRAINT `ProjectManagement_te_client_id_6443401b_fk_ProjectMa` FOREIGN KEY (`client_id`) REFERENCES `ProjectManagement_clientprofile` (`id`),
  CONSTRAINT `ProjectManagement_te_item_id_4fca750a_fk_ProjectMa` FOREIGN KEY (`item_id`) REFERENCES `ProjectManagement_item` (`id`),
  CONSTRAINT `ProjectManagement_te_material_id_30e5137f_fk_ProjectMa` FOREIGN KEY (`material_id`) REFERENCES `ProjectManagement_materials` (`id`),
  CONSTRAINT `ProjectManagement_te_size_id_ee12596e_fk_ProjectMa` FOREIGN KEY (`size_id`) REFERENCES `ProjectManagement_size` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectManagement_temporaryorder`
--

LOCK TABLES `ProjectManagement_temporaryorder` WRITE;
/*!40000 ALTER TABLE `ProjectManagement_temporaryorder` DISABLE KEYS */;
INSERT INTO `ProjectManagement_temporaryorder` VALUES (42,1,0,0,5,45,26,15,5,NULL,''),(43,1,0,0,11,45,26,15,5,NULL,''),(44,1,0,0,4,45,26,29,16,NULL,''),(45,1,0,0,6,47,26,16,3,NULL,'');
/*!40000 ALTER TABLE `ProjectManagement_temporaryorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (5,'Clients'),(2,'Designers'),(4,'Logists'),(1,'Managers'),(3,'Productions');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,105),(2,1,106),(3,2,107),(4,3,108),(5,4,109),(6,5,110);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add AddingCost',7,'add_addingcost'),(26,'Can change AddingCost',7,'change_addingcost'),(27,'Can delete AddingCost',7,'delete_addingcost'),(28,'Can view AddingCost',7,'view_addingcost'),(29,'Can add ApplicationMethod',8,'add_applicationmethod'),(30,'Can change ApplicationMethod',8,'change_applicationmethod'),(31,'Can delete ApplicationMethod',8,'delete_applicationmethod'),(32,'Can view ApplicationMethod',8,'view_applicationmethod'),(33,'Can add Cart',9,'add_cart'),(34,'Can change Cart',9,'change_cart'),(35,'Can delete Cart',9,'delete_cart'),(36,'Can view Cart',9,'view_cart'),(37,'Can add Doc',10,'add_clientdocuments'),(38,'Can change Doc',10,'change_clientdocuments'),(39,'Can delete Doc',10,'delete_clientdocuments'),(40,'Can view Doc',10,'view_clientdocuments'),(41,'Can add ClientProfile',11,'add_clientprofile'),(42,'Can change ClientProfile',11,'change_clientprofile'),(43,'Can delete ClientProfile',11,'delete_clientprofile'),(44,'Can view ClientProfile',11,'view_clientprofile'),(45,'Can add Item',12,'add_item'),(46,'Can change Item',12,'change_item'),(47,'Can delete Item',12,'delete_item'),(48,'Can view Item',12,'view_item'),(49,'Can add Materials',13,'add_materials'),(50,'Can change Materials',13,'change_materials'),(51,'Can delete Materials',13,'delete_materials'),(52,'Can view Materials',13,'view_materials'),(53,'Can add Order',14,'add_order'),(54,'Can change Order',14,'change_order'),(55,'Can delete Order',14,'delete_order'),(56,'Can view Order',14,'view_order'),(57,'Can add OrderComment',15,'add_ordercomment'),(58,'Can change OrderComment',15,'change_ordercomment'),(59,'Can delete OrderComment',15,'delete_ordercomment'),(60,'Can view OrderComment',15,'view_ordercomment'),(61,'Can add Doc',16,'add_orderdocuments'),(62,'Can change Doc',16,'change_orderdocuments'),(63,'Can delete Doc',16,'delete_orderdocuments'),(64,'Can view Doc',16,'view_orderdocuments'),(65,'Can add OrderNumber',17,'add_ordernumber'),(66,'Can change OrderNumber',17,'change_ordernumber'),(67,'Can delete OrderNumber',17,'delete_ordernumber'),(68,'Can view OrderNumber',17,'view_ordernumber'),(69,'Can add OrderStatus',18,'add_orderstatus'),(70,'Can change OrderStatus',18,'change_orderstatus'),(71,'Can delete OrderStatus',18,'delete_orderstatus'),(72,'Can view OrderStatus',18,'view_orderstatus'),(73,'Can add ProductionStatus',19,'add_productionstatus'),(74,'Can change ProductionStatus',19,'change_productionstatus'),(75,'Can delete ProductionStatus',19,'delete_productionstatus'),(76,'Can view ProductionStatus',19,'view_productionstatus'),(77,'Can add Provider',20,'add_provider'),(78,'Can change Provider',20,'change_provider'),(79,'Can delete Provider',20,'delete_provider'),(80,'Can view Provider',20,'view_provider'),(81,'Can add size',21,'add_size'),(82,'Can change size',21,'change_size'),(83,'Can delete size',21,'delete_size'),(84,'Can view size',21,'view_size'),(85,'Can add TemporaryOrder',22,'add_temporaryorder'),(86,'Can change TemporaryOrder',22,'change_temporaryorder'),(87,'Can delete TemporaryOrder',22,'delete_temporaryorder'),(88,'Can view TemporaryOrder',22,'view_temporaryorder'),(89,'Can add DesignerOrder',23,'add_designerorder'),(90,'Can change DesignerOrder',23,'change_designerorder'),(91,'Can delete DesignerOrder',23,'delete_designerorder'),(92,'Can view DesignerOrder',23,'view_designerorder'),(93,'Can add DesignImage',24,'add_designimage'),(94,'Can change DesignImage',24,'change_designimage'),(95,'Can delete DesignImage',24,'delete_designimage'),(96,'Can view DesignImage',24,'view_designimage'),(97,'Can add DesignImageComment',25,'add_designimagecomment'),(98,'Can change DesignImageComment',25,'change_designimagecomment'),(99,'Can delete DesignImageComment',25,'delete_designimagecomment'),(100,'Can view DesignImageComment',25,'view_designimagecomment'),(101,'Can add Logist',26,'add_logisticscompanies'),(102,'Can change Logist',26,'change_logisticscompanies'),(103,'Can delete Logist',26,'delete_logisticscompanies'),(104,'Can view Logist',26,'view_logisticscompanies'),(105,'Manager Read and Write',4,'manager_rw'),(106,'Can create and change clients',4,'manage_clients'),(107,'Designer Read and Write',4,'designer_rw'),(108,'Production Read and Write',4,'production_rw'),(109,'Logist Read and Write',4,'logist_rw'),(110,'Client Read and Write',4,'client_rw'),(111,'Can add Design2',27,'add_design2'),(112,'Can change Design2',27,'change_design2'),(113,'Can delete Design2',27,'delete_design2'),(114,'Can view Design2',27,'view_design2'),(115,'Can add Design3',28,'add_design3'),(116,'Can change Design3',28,'change_design3'),(117,'Can delete Design3',28,'delete_design3'),(118,'Can view Design3',28,'view_design3'),(119,'Can add Design4',29,'add_design4'),(120,'Can change Design4',29,'change_design4'),(121,'Can delete Design4',29,'delete_design4'),(122,'Can view Design4',29,'view_design4'),(123,'Can add Design3_comment',30,'add_design3_comment'),(124,'Can change Design3_comment',30,'change_design3_comment'),(125,'Can delete Design3_comment',30,'delete_design3_comment'),(126,'Can view Design3_comment',30,'view_design3_comment'),(127,'Can add Design4_comment',31,'add_design4_comment'),(128,'Can change Design4_comment',31,'change_design4_comment'),(129,'Can delete Design4_comment',31,'delete_design4_comment'),(130,'Can view Design4_comment',31,'view_design4_comment'),(131,'Can add Design1_comment',32,'add_design1_comment'),(132,'Can change Design1_comment',32,'change_design1_comment'),(133,'Can delete Design1_comment',32,'delete_design1_comment'),(134,'Can view Design1_comment',32,'view_design1_comment'),(135,'Can add Design2_comment',33,'add_design2_comment'),(136,'Can change Design2_comment',33,'change_design2_comment'),(137,'Can delete Design2_comment',33,'delete_design2_comment'),(138,'Can view Design2_comment',33,'view_design2_comment'),(139,'Can add Design1',34,'add_design1'),(140,'Can change Design1',34,'change_design1'),(141,'Can delete Design1',34,'delete_design1'),(142,'Can view Design1',34,'view_design1'),(143,'Can add DesignSpecification',35,'add_designspecification'),(144,'Can change DesignSpecification',35,'change_designspecification'),(145,'Can delete DesignSpecification',35,'delete_designspecification'),(146,'Can view DesignSpecification',35,'view_designspecification'),(147,'Can add LogistLink',36,'add_logistlink'),(148,'Can change LogistLink',36,'change_logistlink'),(149,'Can delete LogistLink',36,'delete_logistlink'),(150,'Can view LogistLink',36,'view_logistlink'),(151,'Can add ProviderDocuments',37,'add_providerdocuments'),(152,'Can change ProviderDocuments',37,'change_providerdocuments'),(153,'Can delete ProviderDocuments',37,'delete_providerdocuments'),(154,'Can view ProviderDocuments',37,'view_providerdocuments'),(155,'Can add files for production',38,'add_filesforproduction'),(156,'Can change files for production',38,'change_filesforproduction'),(157,'Can delete files for production',38,'delete_filesforproduction'),(158,'Can view files for production',38,'view_filesforproduction'),(159,'Can add DesignFilesForProduction',39,'add_designfilesforproduction'),(160,'Can change DesignFilesForProduction',39,'change_designfilesforproduction'),(161,'Can delete DesignFilesForProduction',39,'delete_designfilesforproduction'),(162,'Can view DesignFilesForProduction',39,'view_designfilesforproduction');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$120000$uLwQju78sxUh$ll6Gjtf12WR/Atq2V1RWQ/1xiFXIdsMfY8cuqWxtfpg=','2018-12-03 16:22:26.846310',1,'admin','Администратор','Компании','',1,1,'2018-09-10 12:45:24.000000'),(2,'pbkdf2_sha256$120000$XCRMcalr2KGb$JVXzAZRDYIFCdEjO4zWdfQFBDfHhObcfw5X22Cy/Ztw=','2019-01-10 10:30:40.586442',0,'manager@company.ru','Менеджер','Компании','manager@company.ru',0,1,'2018-09-10 12:46:07.000000'),(3,'pbkdf2_sha256$120000$WlAZ5ePyfb8I$aXTRuwgAj6P3wXp419HBE6xYZ5eJ3A4wMtggVad3oEw=','2018-12-06 11:56:34.562531',0,'production@company.ru','Продакшн','Компании','production@company.ru',0,1,'2018-09-10 12:47:10.000000'),(4,'pbkdf2_sha256$120000$lsKmI3xhA0HW$QD+ExSz4AASJJJ/DSuwI++VV//bgfayzvAhfnmgPM24=','2018-12-27 12:40:37.780503',0,'designer@company.ru','Дизайнер','Компании','designer@company.ru',0,1,'2018-09-10 12:47:45.000000'),(5,'pbkdf2_sha256$120000$JWtcnYLUH846$r+vKuEJaUAW8PM+faWEH6wgGVNmQsbywFan3H2EVwbg=','2018-12-13 14:32:47.378373',0,'logist@company.ru','Логист','Компании','logist@company.ru',0,1,'2018-09-10 12:48:16.000000'),(13,'pbkdf2_sha256$120000$22r7WXQF768y$SaOu2IsuPoX2XcjT+8FhP2hwYXeLVu4fJ34NlB0CfeU=',NULL,0,'korovenkovia@mail.ru','Клиент Клиентович','Тестовый','korovenkovia@mail.ru',0,1,'2018-09-20 15:35:06.960122'),(50,'pbkdf2_sha256$120000$tjE1t8xmy2AU$86uBT3L5g6/ZNmoUA/42uEssvvFyHpgHEXVSn8z+fiI=','2018-10-10 13:26:19.247888',0,'justdani@list.ru','Тест Тестович','Тестовый','justdani@list.ru',0,1,'2018-10-10 13:25:55.397959'),(54,'pbkdf2_sha256$120000$5HYHZeZdGVs6$Z+6w6FWUcf9YAeFztME/c2FMa89wsn1HBMVQBTltMJ4=','2018-11-29 11:07:36.129002',0,'d.bugrov@msk-spartak.ru','Денис Сергеевич','Бугров','d.bugrov@msk-spartak.ru',0,1,'2018-11-28 15:37:39.971810'),(55,'pbkdf2_sha256$120000$QW1gXaKFsOxE$ZO6eqXsUAD4SIBwklxEBgICD2jMalZXS2Zo/FmatZjM=','2018-12-04 10:55:38.859332',0,'a.batsmanov@gsmagency.ru','Дмитрий Сергеевич','Рябков','a.batsmanov@gsmagency.ru',0,1,'2018-12-04 10:53:41.762307');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (1,2,1),(2,3,3),(3,4,2),(4,5,4),(12,13,5),(45,50,5),(49,54,5),(50,55,5);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-09-10 12:46:07.724799','2','manager@company.ru',1,'[{\"added\": {}}]',4,1),(2,'2018-09-10 12:46:27.495408','2','manager@company.ru',2,'[{\"changed\": {\"fields\": [\"first_name\", \"last_name\", \"email\", \"groups\"]}}]',4,1),(3,'2018-09-10 12:47:10.813779','3','production@company.ru',1,'[{\"added\": {}}]',4,1),(4,'2018-09-10 12:47:25.650759','3','production@company.ru',2,'[{\"changed\": {\"fields\": [\"first_name\", \"last_name\", \"email\", \"groups\"]}}]',4,1),(5,'2018-09-10 12:47:45.422925','4','designer@company.ru',1,'[{\"added\": {}}]',4,1),(6,'2018-09-10 12:48:00.451098','4','designer@company.ru',2,'[{\"changed\": {\"fields\": [\"first_name\", \"last_name\", \"email\", \"groups\"]}}]',4,1),(7,'2018-09-10 12:48:16.673369','5','logist@company.ru',1,'[{\"added\": {}}]',4,1),(8,'2018-09-10 12:48:33.628847','5','logist@company.ru',2,'[{\"changed\": {\"fields\": [\"first_name\", \"last_name\", \"email\", \"groups\"]}}]',4,1),(9,'2018-09-10 12:51:24.525933','4','designer@company.ru',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',4,1),(10,'2018-09-10 12:51:37.125826','5','logist@company.ru',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',4,1),(11,'2018-09-10 12:51:53.484701','2','manager@company.ru',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',4,1),(12,'2018-09-10 12:52:05.033474','3','production@company.ru',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',4,1),(13,'2018-09-10 13:13:56.170710','4','designer@company.ru',2,'[]',4,1),(14,'2018-09-10 14:30:05.890218','6','test@test.ru',1,'[{\"added\": {}}]',4,1),(15,'2018-09-10 14:31:05.589602','6','test@test.ru',2,'[{\"changed\": {\"fields\": [\"first_name\", \"last_name\", \"groups\"]}}]',4,1),(16,'2018-09-10 16:58:23.395403','5','logist@company.ru',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',4,1),(17,'2018-09-10 16:58:26.794317','5','logist@company.ru',2,'[]',4,1),(18,'2018-09-12 12:21:38.812343','5','logist@company.ru',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',4,1),(19,'2018-09-12 12:23:48.376749','5','logist@company.ru',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',4,1),(20,'2018-09-12 15:36:09.208411','8','pavlov@hclokomotiv.ru',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',4,1),(21,'2018-09-12 16:12:05.028436','6','test@test.ru',3,'',4,1),(22,'2018-09-17 09:14:29.070507','2','Ассоциация ХК «Локомотив»',3,'',17,1),(23,'2018-09-17 09:14:29.082720','1','Ассоциация ХК «Локомотив»',3,'',17,1),(24,'2018-09-17 09:50:40.443295','6','Ассоциация ХК «Локомотив»',3,'',17,1),(25,'2018-09-17 09:50:40.452258','5','Ассоциация ХК «Локомотив»',3,'',17,1),(26,'2018-09-17 09:50:40.459316','4','Ассоциация ХК «Локомотив»',3,'',17,1),(27,'2018-09-17 09:50:40.466349','3','Ассоциация ХК «Локомотив»',3,'',17,1),(28,'2018-10-01 16:05:26.173944','43','hakep@vzlom.ru',1,'[{\"added\": {}}]',4,1),(29,'2018-10-01 16:05:33.431707','43','hakep@vzlom.ru',2,'[{\"changed\": {\"fields\": [\"groups\"]}}]',4,1),(30,'2018-10-01 16:06:11.948433','43','hakep@vzlom.ru',3,'',4,1),(31,'2018-10-01 16:06:31.924448','41','admin@1card.ru',3,'',4,1),(32,'2018-10-01 16:07:49.343394','1','admin',2,'[{\"changed\": {\"fields\": [\"groups\"]}}]',4,1),(33,'2018-10-01 16:08:06.115050','1','admin',2,'[{\"changed\": {\"fields\": [\"groups\"]}}]',4,1),(34,'2018-10-01 16:08:08.480668','1','admin',2,'[]',4,1),(35,'2018-10-01 16:08:16.833539','2','manager@company.ru',2,'[{\"changed\": {\"fields\": [\"is_staff\", \"is_superuser\"]}}]',4,1),(36,'2018-10-01 16:08:48.821303','2','manager@company.ru',2,'[{\"changed\": {\"fields\": [\"is_staff\", \"is_superuser\"]}}]',4,2),(37,'2018-10-02 17:51:31.154927','16','тест',3,'',17,1),(38,'2018-10-02 17:51:31.163289','15','тест',3,'',17,1),(39,'2018-10-02 17:51:31.180046','14','тест',3,'',17,1),(40,'2018-10-02 17:51:31.397802','13','тест',3,'',17,1),(41,'2018-10-02 17:51:31.405481','12','тест',3,'',17,1),(42,'2018-10-04 09:40:44.658726','5','ООО \"Ника-тигра\"',3,'',37,1),(43,'2018-10-04 09:40:44.668991','4','ООО \"Ника-тигра\"',3,'',37,1),(44,'2018-10-04 09:40:44.681127','3','ООО \"Ника-тигра\"',3,'',37,1),(45,'2018-10-04 09:40:44.691400','2','ООО \"Ника-тигра\"',3,'',37,1),(46,'2018-10-04 09:40:44.793610','1','ООО \"Ника-тигра\"',3,'',37,1),(47,'2018-11-28 15:22:17.910283','2','Деловые линии',2,'[{\"changed\": {\"fields\": [\"surname\", \"first_name\", \"middle_name\", \"email\", \"phone\", \"requisites\"]}}]',26,1),(48,'2018-11-28 15:31:16.543862','3','СДЕК',2,'[{\"changed\": {\"fields\": [\"surname\", \"first_name\", \"middle_name\", \"email\", \"phone\", \"requisites\"]}}]',26,1),(49,'2018-11-28 15:32:58.651260','5','Газель',2,'[{\"changed\": {\"fields\": [\"surname\", \"first_name\", \"phone\", \"address\"]}}]',26,1),(50,'2018-11-28 15:35:16.700011','4','БлаБлаКар',2,'[{\"changed\": {\"fields\": [\"surname\", \"first_name\", \"middle_name\", \"phone\", \"requisites\"]}}]',26,1),(51,'2018-11-29 11:21:26.209044','19','None',3,'',17,1),(52,'2018-11-29 11:21:26.221426','17','None',3,'',17,1),(53,'2018-11-29 11:21:26.232760','10','None',3,'',17,1),(54,'2018-11-29 11:21:26.379809','9','None',3,'',17,1),(55,'2018-11-29 11:21:26.460548','7','None',3,'',17,1),(56,'2018-11-29 11:22:11.376706','25','123',3,'',17,1),(57,'2018-11-29 11:22:11.384949','20','123',3,'',17,1),(58,'2018-11-29 11:24:32.467569','11','АНО \"Народная команда - ХК \"Спартак\"',3,'',17,1),(59,'2018-11-29 11:26:36.340115','8','АНО \"Народная команда - ХК \"Спартак\"',3,'',17,1),(60,'2018-12-03 15:59:06.470620','26','123',3,'',17,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'ProjectManagement','addingcost'),(8,'ProjectManagement','applicationmethod'),(9,'ProjectManagement','cart'),(10,'ProjectManagement','clientdocuments'),(11,'ProjectManagement','clientprofile'),(34,'ProjectManagement','design1'),(32,'ProjectManagement','design1_comment'),(27,'ProjectManagement','design2'),(33,'ProjectManagement','design2_comment'),(28,'ProjectManagement','design3'),(30,'ProjectManagement','design3_comment'),(29,'ProjectManagement','design4'),(31,'ProjectManagement','design4_comment'),(23,'ProjectManagement','designerorder'),(39,'ProjectManagement','designfilesforproduction'),(24,'ProjectManagement','designimage'),(25,'ProjectManagement','designimagecomment'),(35,'ProjectManagement','designspecification'),(38,'ProjectManagement','filesforproduction'),(12,'ProjectManagement','item'),(26,'ProjectManagement','logisticscompanies'),(36,'ProjectManagement','logistlink'),(13,'ProjectManagement','materials'),(14,'ProjectManagement','order'),(15,'ProjectManagement','ordercomment'),(16,'ProjectManagement','orderdocuments'),(17,'ProjectManagement','ordernumber'),(18,'ProjectManagement','orderstatus'),(19,'ProjectManagement','productionstatus'),(20,'ProjectManagement','provider'),(37,'ProjectManagement','providerdocuments'),(21,'ProjectManagement','size'),(22,'ProjectManagement','temporaryorder'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-09-10 10:58:36.917316'),(2,'auth','0001_initial','2018-09-10 10:58:39.687254'),(3,'ProjectManagement','0001_initial','2018-09-10 10:58:49.690389'),(4,'ProjectManagement','0002_auto_20180817_1136','2018-09-10 10:58:52.771888'),(5,'ProjectManagement','0003_auto_20180903_1010','2018-09-10 10:58:53.330094'),(6,'ProjectManagement','0004_logist','2018-09-10 10:58:53.513792'),(7,'ProjectManagement','0005_auto_20180906_1237','2018-09-10 10:58:53.578896'),(8,'admin','0001_initial','2018-09-10 10:58:53.960678'),(9,'admin','0002_logentry_remove_auto_add','2018-09-10 10:58:53.991713'),(10,'admin','0003_logentry_add_action_flag_choices','2018-09-10 10:58:54.020813'),(11,'contenttypes','0002_remove_content_type_name','2018-09-10 10:58:54.334363'),(12,'auth','0002_alter_permission_name_max_length','2018-09-10 10:58:54.540539'),(13,'auth','0003_alter_user_email_max_length','2018-09-10 10:58:54.764129'),(14,'auth','0004_alter_user_username_opts','2018-09-10 10:58:54.797534'),(15,'auth','0005_alter_user_last_login_null','2018-09-10 10:58:54.956627'),(16,'auth','0006_require_contenttypes_0002','2018-09-10 10:58:54.964926'),(17,'auth','0007_alter_validators_add_error_messages','2018-09-10 10:58:54.991410'),(18,'auth','0008_alter_user_username_max_length','2018-09-10 10:58:55.238552'),(19,'auth','0009_alter_user_last_name_max_length','2018-09-10 10:58:55.437943'),(20,'sessions','0001_initial','2018-09-10 10:58:55.556945'),(21,'ProjectManagement','0006_auto_20180910_1446','2018-09-10 14:46:27.226121'),(22,'ProjectManagement','0007_order_shipping_company','2018-09-10 17:09:45.618790'),(23,'ProjectManagement','0008_auto_20180911_0935','2018-09-11 09:35:16.709137'),(24,'ProjectManagement','0009_ordernumber_logist_delivering','2018-09-11 14:23:23.200780'),(25,'ProjectManagement','0010_auto_20180912_0908','2018-09-12 09:08:27.100162'),(26,'ProjectManagement','0011_auto_20180912_1203','2018-09-12 12:03:20.381893'),(27,'ProjectManagement','0012_auto_20180912_1218','2018-09-12 12:19:00.741328'),(28,'ProjectManagement','0013_auto_20180912_1748','2018-09-12 17:48:13.139568'),(29,'ProjectManagement','0014_design1_design1_comment_design2_design2_comment_design3_design3_comment_design4_design4_comment','2018-09-13 14:13:37.231658'),(30,'ProjectManagement','0015_auto_20180913_1441','2018-09-13 14:41:07.977053'),(31,'ProjectManagement','0016_auto_20180914_1032','2018-09-14 10:32:43.980925'),(32,'ProjectManagement','0017_auto_20180914_1034','2018-09-14 10:34:10.207865'),(33,'ProjectManagement','0018_auto_20180914_1038','2018-09-14 10:38:36.777065'),(34,'ProjectManagement','0019_auto_20180914_1039','2018-09-14 10:39:31.627487'),(35,'ProjectManagement','0020_auto_20180914_1042','2018-09-14 10:42:13.836214'),(36,'ProjectManagement','0021_auto_20180914_1051','2018-09-14 10:51:50.343909'),(37,'ProjectManagement','0022_auto_20180914_1105','2018-09-14 11:05:04.182302'),(38,'ProjectManagement','0023_designimagecomment_design','2018-09-14 12:18:03.914698'),(39,'ProjectManagement','0024_auto_20180914_1325','2018-09-14 13:25:10.105159'),(40,'ProjectManagement','0025_auto_20180917_0844','2018-09-17 08:45:00.776167'),(41,'ProjectManagement','0026_auto_20180917_0921','2018-09-17 09:21:15.975654'),(42,'ProjectManagement','0027_clientprofile_desivery_address','2018-09-17 11:24:40.265333'),(43,'ProjectManagement','0028_auto_20180917_1129','2018-09-17 11:29:10.421485'),(44,'ProjectManagement','0029_ordernumber_manager_addition_cost','2018-09-17 13:03:02.244086'),(45,'ProjectManagement','0030_auto_20180917_1420','2018-09-17 14:20:26.617843'),(46,'ProjectManagement','0031_auto_20180917_1422','2018-09-17 14:22:37.116007'),(47,'ProjectManagement','0032_auto_20180918_1032','2018-09-18 10:32:43.736680'),(48,'ProjectManagement','0033_auto_20180918_1314','2018-09-18 13:14:20.561274'),(49,'ProjectManagement','0034_auto_20180918_1323','2018-09-18 13:23:41.252922'),(50,'ProjectManagement','0035_auto_20180918_1348','2018-09-18 13:48:19.753766'),(51,'ProjectManagement','0036_auto_20180918_1349','2018-09-18 13:49:05.540059'),(52,'ProjectManagement','0037_auto_20180918_1409','2018-09-18 14:09:24.232926'),(53,'ProjectManagement','0038_auto_20180918_1437','2018-09-18 14:37:28.229094'),(54,'ProjectManagement','0039_order_delivering_price','2018-09-18 15:41:37.475314'),(55,'ProjectManagement','0040_auto_20180918_1556','2018-09-18 15:56:57.731573'),(56,'ProjectManagement','0041_auto_20180920_1254','2018-09-20 12:54:19.193106'),(57,'ProjectManagement','0042_logisticscompanies_address','2018-09-21 12:03:14.160832'),(58,'ProjectManagement','0043_logistlink','2018-09-21 12:53:02.829878'),(59,'ProjectManagement','0044_provider_address','2018-09-25 09:19:08.041984'),(60,'ProjectManagement','0045_ordernumber_add_agreement','2018-09-26 13:49:53.545096'),(61,'ProjectManagement','0046_ordernumber_contract_attached','2018-09-28 14:20:52.315592'),(62,'ProjectManagement','0047_remove_ordernumber_contract_attached','2018-09-28 14:22:19.054219'),(63,'ProjectManagement','0048_auto_20180928_1423','2018-09-28 14:23:23.846169'),(64,'ProjectManagement','0049_auto_20180928_1434','2018-09-28 14:35:02.175569'),(65,'ProjectManagement','0050_auto_20181001_1035','2018-10-01 10:35:15.485777'),(66,'ProjectManagement','0051_providerdocuments','2018-10-01 12:56:04.095441'),(67,'ProjectManagement','0052_filesforproduction','2018-10-02 11:37:26.335615'),(68,'ProjectManagement','0053_auto_20181009_0913','2018-10-09 09:13:56.307582'),(69,'ProjectManagement','0054_order_provider_pre_payment','2018-10-09 09:47:01.263662'),(70,'ProjectManagement','0055_auto_20181009_1450','2018-10-09 14:50:35.484755'),(71,'ProjectManagement','0056_designfilesforproduction','2018-10-10 10:51:34.599962'),(72,'ProjectManagement','0057_auto_20181107_1112','2018-11-07 11:12:39.698278'),(73,'ProjectManagement','0058_auto_20181128_1711','2018-11-28 17:12:02.894970'),(74,'ProjectManagement','0059_auto_20181128_1716','2018-11-28 17:16:37.617241'),(75,'ProjectManagement','0060_auto_20181128_1717','2018-11-28 17:17:11.255370'),(76,'ProjectManagement','0061_auto_20181128_1718','2018-11-28 17:18:27.509197'),(77,'ProjectManagement','0062_auto_20181128_1719','2018-11-28 17:19:25.503925'),(78,'ProjectManagement','0063_auto_20181128_1720','2018-11-28 17:20:20.030719');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('05objp00iw01b3a2wszp12a5jlvbivk7','OTZjYWRjY2Q4NWRiMzFkZDVjYzY2MWJlYWYyOWE0MTYzMWZjYjI0MTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlOTA2MTYyZmIzZmIyODU1NWNiNGIyNjg0Y2I4ODM1YzljNDU5YjA3In0=','2018-12-11 14:52:56.030407'),('10t5tiwzfy7x1fiwt2wz6oq2z21cve2f','MWI2MDI3MTY0ODhlNmY2MDcwZmFhZjk0ZDIxYmIxNjgzMDMxMDViMzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyNDRkMWFiYWQ0ZGFjYzdmOTVlYzk3NTFkMjFjZjk4MjI1NzBjZjg2In0=','2018-12-17 15:23:51.411157'),('16p7fpxiqc4wvsavw5xbyqim6rbl0an7','NTUwODJlZDVkZjYyYmM5ZTdkMTliNzdhYjIzMmNjOGMzZmYxMWU3YTp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjNmNkY2ZlNWYwMmQxNzI3MjZhZTRmN2QzYTY3Nzk0NmFlNzc4NTNkIn0=','2018-10-25 15:05:23.062927'),('27fwjsma2mk4ec8cza3qn8gjde3p4fyd','OTZjYWRjY2Q4NWRiMzFkZDVjYzY2MWJlYWYyOWE0MTYzMWZjYjI0MTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlOTA2MTYyZmIzZmIyODU1NWNiNGIyNjg0Y2I4ODM1YzljNDU5YjA3In0=','2018-12-17 16:00:48.151015'),('2a4j5vntvqgo0t5jphpiszovtvnw36dn','MWI2MDI3MTY0ODhlNmY2MDcwZmFhZjk0ZDIxYmIxNjgzMDMxMDViMzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyNDRkMWFiYWQ0ZGFjYzdmOTVlYzk3NTFkMjFjZjk4MjI1NzBjZjg2In0=','2018-11-05 14:18:09.856643'),('2iq1o168fwzcnqk6r86fa1felt2aau90','NTUwODJlZDVkZjYyYmM5ZTdkMTliNzdhYjIzMmNjOGMzZmYxMWU3YTp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjNmNkY2ZlNWYwMmQxNzI3MjZhZTRmN2QzYTY3Nzk0NmFlNzc4NTNkIn0=','2018-10-24 14:48:38.549180'),('2xpok015u1rpx5xux4glzzbrg5xw5mo0','NmUxZjBmMDBiNzQ4Mjk3Njc0ZGNjYTRkMGE1ZmNiYTBkODZiNTFhZjp7Il9hdXRoX3VzZXJfaWQiOiI1NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDk2Y2JlODU1YjYwNWM0NzA4YzlmMmQ1NmRiZDRhN2NlZmQ5Njc1MCJ9','2018-12-18 10:55:38.868811'),('33omimgc1ahzar7p5je4w904uf46kqym','OTZjYWRjY2Q4NWRiMzFkZDVjYzY2MWJlYWYyOWE0MTYzMWZjYjI0MTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlOTA2MTYyZmIzZmIyODU1NWNiNGIyNjg0Y2I4ODM1YzljNDU5YjA3In0=','2018-10-19 11:07:51.974667'),('3iogse6br4t8m5j1gz2i060qkimfm905','MWI2MDI3MTY0ODhlNmY2MDcwZmFhZjk0ZDIxYmIxNjgzMDMxMDViMzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyNDRkMWFiYWQ0ZGFjYzdmOTVlYzk3NTFkMjFjZjk4MjI1NzBjZjg2In0=','2018-11-20 10:47:57.798660'),('70kgu6eltlme6x1q0hpw8ymkj5uyu2u1','NTUwODJlZDVkZjYyYmM5ZTdkMTliNzdhYjIzMmNjOGMzZmYxMWU3YTp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjNmNkY2ZlNWYwMmQxNzI3MjZhZTRmN2QzYTY3Nzk0NmFlNzc4NTNkIn0=','2018-09-28 14:45:45.324078'),('9fja6n7kme65nis9unvol96tw5pwni62','OTZjYWRjY2Q4NWRiMzFkZDVjYzY2MWJlYWYyOWE0MTYzMWZjYjI0MTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlOTA2MTYyZmIzZmIyODU1NWNiNGIyNjg0Y2I4ODM1YzljNDU5YjA3In0=','2018-10-05 11:06:42.051538'),('9fmirtazzvb3zm5opnhf4gq91v4cbs33','MWI2MDI3MTY0ODhlNmY2MDcwZmFhZjk0ZDIxYmIxNjgzMDMxMDViMzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyNDRkMWFiYWQ0ZGFjYzdmOTVlYzk3NTFkMjFjZjk4MjI1NzBjZjg2In0=','2018-11-21 17:46:14.526827'),('brybtdonlpt5i9ykae7vq988usu8afs5','OTZjYWRjY2Q4NWRiMzFkZDVjYzY2MWJlYWYyOWE0MTYzMWZjYjI0MTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlOTA2MTYyZmIzZmIyODU1NWNiNGIyNjg0Y2I4ODM1YzljNDU5YjA3In0=','2018-10-11 10:35:01.806690'),('cbfoc4gmh4sjqc7nud3t0m0eu8qzpurn','MThlMDFmN2NiYzdiYThkYWEwZGE1ZmEyZmI2NzZkYmE0NTdjNGE0Yjp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMGM3YTllZTI5OTM1Mjc5ZGYwZmIwOWI3ZGY3MGQ3M2I1ZTQyNTYwIn0=','2018-11-27 11:56:19.217006'),('d87fr4gtg3tp629br565k7wx0fif2cc7','ODJjNjI2M2EyNmI5ODcwODM2MWI3NWM1ODQ1NTgzNTFjZDllMWIyMTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMGM3YTllZTI5OTM1Mjc5ZGYwZmIwOWI3ZGY3MGQ3M2I1ZTQyNTYwIiwiQ0FSVC1JRCI6M30=','2018-09-24 14:49:22.286490'),('dko27z179tb1tcat66df8qxuyjzxkbog','ZjUwZDE4NmUxODgwOGQ1ZDlhOWZjOGQzMjk0ZTUxMjhiZjVjYmFiOTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMGM3YTllZTI5OTM1Mjc5ZGYwZmIwOWI3ZGY3MGQ3M2I1ZTQyNTYwIiwiQ0FSVC1JRCI6MzB9','2018-10-22 17:22:27.729243'),('fua9wihkhttpr1o5m9gg9pg5yobalrk3','OTZjYWRjY2Q4NWRiMzFkZDVjYzY2MWJlYWYyOWE0MTYzMWZjYjI0MTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlOTA2MTYyZmIzZmIyODU1NWNiNGIyNjg0Y2I4ODM1YzljNDU5YjA3In0=','2018-11-21 10:09:01.096552'),('i9g9owl7vy5lrewy0bi5e9syi1mzrlwx','NTUwODJlZDVkZjYyYmM5ZTdkMTliNzdhYjIzMmNjOGMzZmYxMWU3YTp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjNmNkY2ZlNWYwMmQxNzI3MjZhZTRmN2QzYTY3Nzk0NmFlNzc4NTNkIn0=','2018-11-08 14:57:36.559490'),('knlwuc4miupsp51y6slhxtzuccn79ukg','YjkwOTg3YmE0MzhjMmIwZDIzMDc3YjUyZjMxNjgzNzIyODU3YTgzZDp7Il9hdXRoX3VzZXJfaWQiOiI1NCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYTYxNmUyOTI5ZGM0YTI0MGQ2ODA4MTQ2N2RkOTM2ZWFlZWRhMDQ3MCJ9','2018-12-13 11:07:36.138828'),('kw6ofnbe250di423cw856myz2mmqeeli','NTUwODJlZDVkZjYyYmM5ZTdkMTliNzdhYjIzMmNjOGMzZmYxMWU3YTp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjNmNkY2ZlNWYwMmQxNzI3MjZhZTRmN2QzYTY3Nzk0NmFlNzc4NTNkIn0=','2018-12-27 14:32:47.391138'),('kyb4yz52e2vjiw71hhtyuumtp8g6c2yr','MWI2MDI3MTY0ODhlNmY2MDcwZmFhZjk0ZDIxYmIxNjgzMDMxMDViMzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyNDRkMWFiYWQ0ZGFjYzdmOTVlYzk3NTFkMjFjZjk4MjI1NzBjZjg2In0=','2018-10-25 11:48:05.289885'),('m6mmmbe4w97iaj9cz87b06l2zfrbofxz','OTZjYWRjY2Q4NWRiMzFkZDVjYzY2MWJlYWYyOWE0MTYzMWZjYjI0MTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlOTA2MTYyZmIzZmIyODU1NWNiNGIyNjg0Y2I4ODM1YzljNDU5YjA3In0=','2018-12-18 12:20:08.667352'),('me8299i7i7joi4jsbh59b22hnd0n7k8e','OTZjYWRjY2Q4NWRiMzFkZDVjYzY2MWJlYWYyOWE0MTYzMWZjYjI0MTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlOTA2MTYyZmIzZmIyODU1NWNiNGIyNjg0Y2I4ODM1YzljNDU5YjA3In0=','2018-11-20 11:24:24.211195'),('mf1fw70s1qufm6mtvhg1sr095mnmejzp','MWI2MDI3MTY0ODhlNmY2MDcwZmFhZjk0ZDIxYmIxNjgzMDMxMDViMzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyNDRkMWFiYWQ0ZGFjYzdmOTVlYzk3NTFkMjFjZjk4MjI1NzBjZjg2In0=','2018-09-28 15:40:24.408150'),('oj4s67fl5vg5ol6sdrjuanp3c7hpwbok','NTUwODJlZDVkZjYyYmM5ZTdkMTliNzdhYjIzMmNjOGMzZmYxMWU3YTp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjNmNkY2ZlNWYwMmQxNzI3MjZhZTRmN2QzYTY3Nzk0NmFlNzc4NTNkIn0=','2018-10-05 13:24:31.582346'),('p59r5wqdjoi13xq9mwidxhkhyrac99km','MThlMDFmN2NiYzdiYThkYWEwZGE1ZmEyZmI2NzZkYmE0NTdjNGE0Yjp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMGM3YTllZTI5OTM1Mjc5ZGYwZmIwOWI3ZGY3MGQ3M2I1ZTQyNTYwIn0=','2018-11-23 16:57:44.738827'),('ppgiggvgk6zj5hki7ymamjiib2oq7oxn','OTZjYWRjY2Q4NWRiMzFkZDVjYzY2MWJlYWYyOWE0MTYzMWZjYjI0MTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlOTA2MTYyZmIzZmIyODU1NWNiNGIyNjg0Y2I4ODM1YzljNDU5YjA3In0=','2018-11-05 17:24:40.168195'),('q76q663yz4qkl4e0kj5zocwnhl863p26','NTUwODJlZDVkZjYyYmM5ZTdkMTliNzdhYjIzMmNjOGMzZmYxMWU3YTp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjNmNkY2ZlNWYwMmQxNzI3MjZhZTRmN2QzYTY3Nzk0NmFlNzc4NTNkIn0=','2018-12-12 17:03:19.757700'),('ta7nzo9bpioh6hzn3jboawcunws6h9ta','MWI2MDI3MTY0ODhlNmY2MDcwZmFhZjk0ZDIxYmIxNjgzMDMxMDViMzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyNDRkMWFiYWQ0ZGFjYzdmOTVlYzk3NTFkMjFjZjk4MjI1NzBjZjg2In0=','2018-10-02 10:33:44.884419'),('tt97v6gvsxhoxnfwzjfxmfwrrxirgxc6','MWI2MDI3MTY0ODhlNmY2MDcwZmFhZjk0ZDIxYmIxNjgzMDMxMDViMzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyNDRkMWFiYWQ0ZGFjYzdmOTVlYzk3NTFkMjFjZjk4MjI1NzBjZjg2In0=','2019-01-10 12:40:37.902892'),('tysobrtsw0e4qmu4tzauobc1zj1hunot','MTk5MGNhMWQwZjg2OGE2NGFhZGZiNGZjMTllNGVlNTI2MjllNzE2NTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMGM3YTllZTI5OTM1Mjc5ZGYwZmIwOWI3ZGY3MGQ3M2I1ZTQyNTYwIiwiQ0FSVC1JRCI6MzF9','2018-10-24 13:27:25.010644'),('v6kbncv71o1z6r85kbqb95nr2v0dcbow','MDk3ZTIwZTFlODIwYzhiNjg5NTAwNWRlNGMzM2Q0Y2FiOTk4YjU0OTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3N2QxYjI0YmYwMTgxM2ZjMTViMWI3NmFjZTA4ZjRhZDk5ZTVkZWViIn0=','2018-09-24 17:12:28.464280'),('vacxpvs5zpn2pigsb6zg0unt9jy6sxrd','YjM2MzhjNTU0ZDdlOTljM2ZlMzA2NjM2NWViOTRmODI2ZGI1MjI3ODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMGM3YTllZTI5OTM1Mjc5ZGYwZmIwOWI3ZGY3MGQ3M2I1ZTQyNTYwIiwiQ0FSVC1JRCI6NDl9','2018-12-17 16:35:55.719586'),('w8xk9m6v1vvmw3gmh4chyx3dhm59iixh','OTZjYWRjY2Q4NWRiMzFkZDVjYzY2MWJlYWYyOWE0MTYzMWZjYjI0MTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlOTA2MTYyZmIzZmIyODU1NWNiNGIyNjg0Y2I4ODM1YzljNDU5YjA3In0=','2018-12-20 11:56:34.572124'),('wy8hp2fhjug1mvb9irvaqn1hsji9fiiq','MThlMDFmN2NiYzdiYThkYWEwZGE1ZmEyZmI2NzZkYmE0NTdjNGE0Yjp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMGM3YTllZTI5OTM1Mjc5ZGYwZmIwOWI3ZGY3MGQ3M2I1ZTQyNTYwIn0=','2019-01-24 10:30:40.596360'),('x2wfshhthsd11b1r2wuh3dr4yv238es6','OTZjYWRjY2Q4NWRiMzFkZDVjYzY2MWJlYWYyOWE0MTYzMWZjYjI0MTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlOTA2MTYyZmIzZmIyODU1NWNiNGIyNjg0Y2I4ODM1YzljNDU5YjA3In0=','2018-11-20 10:26:02.650648'),('xa57ggdr8161qis4f0fdkq7kxuamgf1x','MWI2MDI3MTY0ODhlNmY2MDcwZmFhZjk0ZDIxYmIxNjgzMDMxMDViMzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyNDRkMWFiYWQ0ZGFjYzdmOTVlYzk3NTFkMjFjZjk4MjI1NzBjZjg2In0=','2018-11-01 09:43:09.165072'),('xwfpnnm65yk0tc8dtwd7jmp1auqt1q3e','MWI2MDI3MTY0ODhlNmY2MDcwZmFhZjk0ZDIxYmIxNjgzMDMxMDViMzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyNDRkMWFiYWQ0ZGFjYzdmOTVlYzk3NTFkMjFjZjk4MjI1NzBjZjg2In0=','2018-10-16 10:44:46.468255');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-10 13:14:32
