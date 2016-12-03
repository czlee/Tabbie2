--
-- Generated from mysql2pgsql.perl
-- http://gborg.postgresql.org/project/mysql2psql/
-- (c) 2001 - 2007 Jose M. Duarte, Joseph Speigle
--

-- warnings are printed for drop tables if they do not exist
-- please see http://archives.postgresql.org/pgsql-novice/2004-10/msg00158.php

-- ##############################################################
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
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
-- MySQL dump 10.13  Distrib 5.7.9, for osx10.9 (x86_64)
--
-- Host: localhost    Database: tabbie
-- ------------------------------------------------------
-- Server version	5.1.73-log


--
-- Table structure for table adjudicator
--

DROP TABLE IF EXISTS "adjudicator" CASCADE;
DROP SEQUENCE IF EXISTS "adjudicator_id_seq" CASCADE ;

CREATE SEQUENCE "adjudicator_id_seq"  START WITH 4303 ;

CREATE TABLE  "adjudicator" (
   "id" integer DEFAULT nextval('"adjudicator_id_seq"') NOT NULL,
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   "user_id" int CHECK ("user_id" >= 0) NOT NULL,
   "active"    smallint NOT NULL DEFAULT '1',
   "breaking"    smallint NOT NULL DEFAULT '0',
   "strength"    smallint DEFAULT NULL,
   "society_id" int CHECK ("society_id" >= 0) NOT NULL,
   "can_chair"    smallint NOT NULL DEFAULT '1',
   "are_watched"    smallint NOT NULL DEFAULT '0',
   "checkedin"    smallint NOT NULL DEFAULT '0',
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "adjudicator_user_id_idx" ON "adjudicator" USING btree ("user_id");
CREATE INDEX "adjudicator_tournament_id_idx" ON "adjudicator" USING btree ("tournament_id");
CREATE INDEX "adjudicator_society_id_idx" ON "adjudicator" USING btree ("society_id");
ALTER TABLE "adjudicator" ADD FOREIGN KEY ("society_id") REFERENCES "society" ("id");
ALTER TABLE "adjudicator" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");
ALTER TABLE "adjudicator" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

--
-- Table structure for table adjudicator_in_panel
--

DROP TABLE IF EXISTS "adjudicator_in_panel" CASCADE;
CREATE TABLE  "adjudicator_in_panel" (
   "adjudicator_id" int CHECK ("adjudicator_id" >= 0) NOT NULL,
   "panel_id" int CHECK ("panel_id" >= 0) NOT NULL,
   "function"  smallint CHECK ("function" >= 0) NOT NULL DEFAULT '0',
   "got_feedback"    smallint NOT NULL DEFAULT '0',
   primary key ("adjudicator_id", "panel_id")
)  ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "adjudicator_in_panel_panel_id_idx" ON "adjudicator_in_panel" USING btree ("panel_id");
CREATE INDEX "adjudicator_in_panel_adjudicator_id_idx" ON "adjudicator_in_panel" USING btree ("adjudicator_id");
ALTER TABLE "adjudicator_in_panel" ADD FOREIGN KEY ("adjudicator_id") REFERENCES "adjudicator" ("id");
ALTER TABLE "adjudicator_in_panel" ADD FOREIGN KEY ("panel_id") REFERENCES "panel" ("id");

--
-- Table structure for table adjudicator_strike
--

DROP TABLE IF EXISTS "adjudicator_strike" CASCADE;
CREATE TABLE  "adjudicator_strike" (
   "adjudicator_from_id" int CHECK ("adjudicator_from_id" >= 0) NOT NULL,
   "adjudicator_to_id" int CHECK ("adjudicator_to_id" >= 0) NOT NULL,
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   "user_clash_id"   int DEFAULT NULL,
   "accepted"    smallint NOT NULL DEFAULT '1',
   primary key ("adjudicator_from_id", "adjudicator_to_id")
)  ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "adjudicator_strike_adjudicator_to_id_idx" ON "adjudicator_strike" USING btree ("adjudicator_to_id");
CREATE INDEX "adjudicator_strike_adjudicator_from_id_idx" ON "adjudicator_strike" USING btree ("adjudicator_from_id");
CREATE INDEX "adjudicator_strike_tournament_id_idx" ON "adjudicator_strike" USING btree ("tournament_id");
CREATE INDEX "adjudicator_strike_user_clash_id_idx" ON "adjudicator_strike" USING btree ("user_clash_id");
ALTER TABLE "adjudicator_strike" ADD FOREIGN KEY ("adjudicator_from_id") REFERENCES "adjudicator" ("id");
ALTER TABLE "adjudicator_strike" ADD FOREIGN KEY ("adjudicator_to_id") REFERENCES "adjudicator" ("id");
ALTER TABLE "adjudicator_strike" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");
ALTER TABLE "adjudicator_strike" ADD FOREIGN KEY ("user_clash_id") REFERENCES "user_clash" ("id");

--
-- Table structure for table answer
--

DROP TABLE IF EXISTS "answer" CASCADE;
DROP SEQUENCE IF EXISTS "answer_id_seq" CASCADE ;

CREATE SEQUENCE "answer_id_seq"  START WITH 48524 ;

CREATE TABLE  "answer" (
   "id" integer DEFAULT nextval('"answer_id_seq"') NOT NULL,
   "feedback_id" int CHECK ("feedback_id" >= 0) NOT NULL,
   "question_id" int CHECK ("question_id" >= 0) NOT NULL,
   "value"   text,
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "answer_question_id_idx" ON "answer" USING btree ("question_id");
CREATE INDEX "answer_feedback_id_idx" ON "answer" USING btree ("feedback_id");
ALTER TABLE "answer" ADD FOREIGN KEY ("feedback_id") REFERENCES "feedback" ("id");
ALTER TABLE "answer" ADD FOREIGN KEY ("question_id") REFERENCES "question" ("id");

--
-- Table structure for table ca
--

DROP TABLE IF EXISTS "ca" CASCADE;
CREATE TABLE  "ca" (
   "user_id" int CHECK ("user_id" >= 0) NOT NULL,
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   primary key ("user_id", "tournament_id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "ca_tournament_id_idx" ON "ca" USING btree ("tournament_id");
CREATE INDEX "ca_user_id_idx" ON "ca" USING btree ("user_id");
ALTER TABLE "ca" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");
ALTER TABLE "ca" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

--
-- Table structure for table convenor
--

DROP TABLE IF EXISTS "convenor" CASCADE;
CREATE TABLE  "convenor" (
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   "user_id" int CHECK ("user_id" >= 0) NOT NULL,
   primary key ("tournament_id", "user_id")
)  ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "convenor_user_id_idx" ON "convenor" USING btree ("user_id");
CREATE INDEX "convenor_tournament_id_idx" ON "convenor" USING btree ("tournament_id");
ALTER TABLE "convenor" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");
ALTER TABLE "convenor" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

--
-- Table structure for table country
--

DROP TABLE IF EXISTS "country" CASCADE;
DROP SEQUENCE IF EXISTS "country_id_seq" CASCADE ;

CREATE SEQUENCE "country_id_seq"  START WITH 252 ;

CREATE TABLE  "country" (
   "id" integer DEFAULT nextval('"country_id_seq"') NOT NULL,
   "name"   varchar(100) DEFAULT NULL,
   "alpha_2"   varchar(2) DEFAULT NULL,
   "alpha_3"   varchar(3) DEFAULT NULL,
   "region_id"   int DEFAULT NULL,
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40000 ALTER TABLE country DISABLE KEYS */;

--
-- Dumping data for table country
--

INSERT INTO "country" VALUES (1,E'Afghanistan',E'af',E'afg',24);
INSERT INTO "country" VALUES (2,E'Aland Islands',E'ax',E'ala',11);
INSERT INTO "country" VALUES (3,E'Albania',E'al',E'alb',13);
INSERT INTO "country" VALUES (4,E'Algeria',E'dz',E'dza',41);
INSERT INTO "country" VALUES (5,E'American Samoa',E'as',E'asm',34);
INSERT INTO "country" VALUES (6,E'Andorra',E'ad',E'and',13);
INSERT INTO "country" VALUES (7,E'Angola',E'ao',E'ago',43);
INSERT INTO "country" VALUES (8,E'Anguilla',E'ai',E'aia',53);
INSERT INTO "country" VALUES (9,E'Antarctica',E'aq',NULL,71);
INSERT INTO "country" VALUES (10,E'Antigua and Barbuda',E'ag',E'atg',53);
INSERT INTO "country" VALUES (11,E'Argentina',E'ar',E'arg',61);
INSERT INTO "country" VALUES (12,E'Armenia',E'am',E'arm',23);
INSERT INTO "country" VALUES (13,E'Aruba',E'aw',E'abw',53);
INSERT INTO "country" VALUES (14,E'Australia',E'au',E'aus',31);
INSERT INTO "country" VALUES (15,E'Austria',E'at',E'aut',12);
INSERT INTO "country" VALUES (16,E'Azerbaijan',E'az',E'aze',23);
INSERT INTO "country" VALUES (17,E'Bahamas',E'bs',E'bhs',53);
INSERT INTO "country" VALUES (18,E'Bahrain',E'bh',E'bhr',23);
INSERT INTO "country" VALUES (19,E'Bangladesh',E'bd',E'bgd',24);
INSERT INTO "country" VALUES (20,E'Barbados',E'bb',E'brb',53);
INSERT INTO "country" VALUES (21,E'Belarus',E'by',E'blr',14);
INSERT INTO "country" VALUES (22,E'Belgium',E'be',E'bel',12);
INSERT INTO "country" VALUES (23,E'Belize',E'bz',E'blz',52);
INSERT INTO "country" VALUES (24,E'Benin',E'bj',E'ben',42);
INSERT INTO "country" VALUES (25,E'Bermuda',E'bm',E'bmu',51);
INSERT INTO "country" VALUES (26,E'Bhutan',E'bt',E'btn',24);
INSERT INTO "country" VALUES (27,E'Bolivia, Plurinational State of',E'bo',E'bol',61);
INSERT INTO "country" VALUES (28,E'Bonaire, Sint Eustatius and Saba',E'bq',E'bes',53);
INSERT INTO "country" VALUES (29,E'Bosnia and Herzegovina',E'ba',E'bih',13);
INSERT INTO "country" VALUES (30,E'Botswana',E'bw',E'bwa',45);
INSERT INTO "country" VALUES (31,E'Bouvet Island',E'bv',NULL,11);
INSERT INTO "country" VALUES (32,E'Brazil',E'br',E'bra',61);
INSERT INTO "country" VALUES (33,E'British Indian Ocean Territory',E'io',NULL,25);
INSERT INTO "country" VALUES (34,E'Brunei Darussalam',E'bn',E'brn',25);
INSERT INTO "country" VALUES (35,E'Bulgaria',E'bg',E'bgr',14);
INSERT INTO "country" VALUES (36,E'Burkina Faso',E'bf',E'bfa',42);
INSERT INTO "country" VALUES (37,E'Burundi',E'bi',E'bdi',44);
INSERT INTO "country" VALUES (38,E'Cambodia',E'kh',E'khm',25);
INSERT INTO "country" VALUES (39,E'Cameroon',E'cm',E'cmr',43);
INSERT INTO "country" VALUES (40,E'Canada',E'ca',E'can',51);
INSERT INTO "country" VALUES (41,E'Cape Verde',E'cv',E'cpv',42);
INSERT INTO "country" VALUES (42,E'Cayman Islands',E'ky',E'cym',53);
INSERT INTO "country" VALUES (43,E'Central African Republic',E'cf',E'caf',43);
INSERT INTO "country" VALUES (44,E'Chad',E'td',E'tcd',43);
INSERT INTO "country" VALUES (45,E'Chile',E'cl',E'chl',61);
INSERT INTO "country" VALUES (46,E'China',E'cn',E'chn',22);
INSERT INTO "country" VALUES (47,E'Christmas Island',E'cx',NULL,31);
INSERT INTO "country" VALUES (48,E'Cocos (Keeling) Islands',E'cc',NULL,31);
INSERT INTO "country" VALUES (49,E'Colombia',E'co',E'col',61);
INSERT INTO "country" VALUES (50,E'Comoros',E'km',E'com',44);
INSERT INTO "country" VALUES (51,E'Congo',E'cg',E'cog',43);
INSERT INTO "country" VALUES (52,E'Congo, The Democratic Republic of the',E'cd',E'cod',43);
INSERT INTO "country" VALUES (53,E'Cook Islands',E'ck',E'cok',34);
INSERT INTO "country" VALUES (54,E'Costa Rica',E'cr',E'cri',52);
INSERT INTO "country" VALUES (55,E'Cote d\'Ivoire',E'ci',E'civ',42);
INSERT INTO "country" VALUES (56,E'Croatia',E'hr',E'hrv',13);
INSERT INTO "country" VALUES (57,E'Cuba',E'cu',E'cub',53);
INSERT INTO "country" VALUES (58,E'Curacao',E'cw',E'cuw',53);
INSERT INTO "country" VALUES (59,E'Cyprus',E'cy',E'cyp',13);
INSERT INTO "country" VALUES (60,E'Czech Republic',E'cz',E'cze',14);
INSERT INTO "country" VALUES (61,E'Denmark',E'dk',E'dnk',11);
INSERT INTO "country" VALUES (62,E'Djibouti',E'dj',E'dji',44);
INSERT INTO "country" VALUES (63,E'Dominica',E'dm',E'dma',53);
INSERT INTO "country" VALUES (64,E'Dominican Republic',E'do',E'dom',53);
INSERT INTO "country" VALUES (65,E'Ecuador',E'ec',E'ecu',61);
INSERT INTO "country" VALUES (66,E'Egypt',E'eg',E'egy',41);
INSERT INTO "country" VALUES (67,E'El Salvador',E'sv',E'slv',52);
INSERT INTO "country" VALUES (68,E'Equatorial Guinea',E'gq',E'gnq',43);
INSERT INTO "country" VALUES (69,E'Eritrea',E'er',E'eri',44);
INSERT INTO "country" VALUES (70,E'Estonia',E'ee',E'est',11);
INSERT INTO "country" VALUES (71,E'Ethiopia',E'et',E'eth',44);
INSERT INTO "country" VALUES (72,E'Falkland Islands (Malvinas)',E'fk',E'flk',61);
INSERT INTO "country" VALUES (73,E'Faroe Islands',E'fo',E'fro',11);
INSERT INTO "country" VALUES (74,E'Fiji',E'fj',E'fji',33);
INSERT INTO "country" VALUES (75,E'Finland',E'fi',E'fin',11);
INSERT INTO "country" VALUES (76,E'France',E'fr',E'fra',12);
INSERT INTO "country" VALUES (77,E'French Guiana',E'gf',E'guf',61);
INSERT INTO "country" VALUES (78,E'French Polynesia',E'pf',E'pyf',34);
INSERT INTO "country" VALUES (79,E'French Southern Territories',E'tf',NULL,71);
INSERT INTO "country" VALUES (80,E'Gabon',E'ga',E'gab',43);
INSERT INTO "country" VALUES (81,E'Gambia',E'gm',E'gmb',42);
INSERT INTO "country" VALUES (82,E'Georgia',E'ge',E'geo',23);
INSERT INTO "country" VALUES (83,E'Germany',E'de',E'deu',12);
INSERT INTO "country" VALUES (84,E'Ghana',E'gh',E'gha',42);
INSERT INTO "country" VALUES (85,E'Gibraltar',E'gi',E'gib',13);
INSERT INTO "country" VALUES (86,E'Greece',E'gr',E'grc',13);
INSERT INTO "country" VALUES (87,E'Greenland',E'gl',E'grl',51);
INSERT INTO "country" VALUES (88,E'Grenada',E'gd',E'grd',53);
INSERT INTO "country" VALUES (89,E'Guadeloupe',E'gp',E'glp',53);
INSERT INTO "country" VALUES (90,E'Guam',E'gu',E'gum',32);
INSERT INTO "country" VALUES (91,E'Guatemala',E'gt',E'gtm',52);
INSERT INTO "country" VALUES (92,E'Guernsey',E'gg',E'ggy',11);
INSERT INTO "country" VALUES (93,E'Guinea',E'gn',E'gin',42);
INSERT INTO "country" VALUES (94,E'Guinea-Bissau',E'gw',E'gnb',42);
INSERT INTO "country" VALUES (95,E'Guyana',E'gy',E'guy',61);
INSERT INTO "country" VALUES (96,E'Haiti',E'ht',E'hti',53);
INSERT INTO "country" VALUES (97,E'Heard Island and McDonald Islands',E'hm',NULL,71);
INSERT INTO "country" VALUES (98,E'Holy See (Vatican City State)',E'va',E'vat',13);
INSERT INTO "country" VALUES (99,E'Honduras',E'hn',E'hnd',52);
INSERT INTO "country" VALUES (100,E'China, Hong Kong Special Administrative Region',E'hk',E'hkg',22);
INSERT INTO "country" VALUES (101,E'Hungary',E'hu',E'hun',14);
INSERT INTO "country" VALUES (102,E'Iceland',E'is',E'isl',11);
INSERT INTO "country" VALUES (103,E'India',E'in',E'ind',24);
INSERT INTO "country" VALUES (104,E'Indonesia',E'id',E'idn',25);
INSERT INTO "country" VALUES (105,E'Iran, Islamic Republic of',E'ir',E'irn',24);
INSERT INTO "country" VALUES (106,E'Iraq',E'iq',E'irq',23);
INSERT INTO "country" VALUES (107,E'Ireland',E'ie',E'irl',11);
INSERT INTO "country" VALUES (108,E'Isle of Man',E'im',E'imn',11);
INSERT INTO "country" VALUES (109,E'Israel',E'il',E'isr',23);
INSERT INTO "country" VALUES (110,E'Italy',E'it',E'ita',13);
INSERT INTO "country" VALUES (111,E'Jamaica',E'jm',E'jam',53);
INSERT INTO "country" VALUES (112,E'Japan',E'jp',E'jpn',22);
INSERT INTO "country" VALUES (113,E'Jersey',E'je',E'jey',11);
INSERT INTO "country" VALUES (114,E'Jordan',E'jo',E'jor',23);
INSERT INTO "country" VALUES (115,E'Kazakhstan',E'kz',E'kaz',21);
INSERT INTO "country" VALUES (116,E'Kenya',E'ke',E'ken',44);
INSERT INTO "country" VALUES (117,E'Kiribati',E'ki',E'kir',32);
INSERT INTO "country" VALUES (118,E'Korea, Democratic People\'s Republic of',E'kp',E'prk',22);
INSERT INTO "country" VALUES (119,E'Korea, Republic of',E'kr',E'kor',22);
INSERT INTO "country" VALUES (120,E'Kuwait',E'kw',E'kwt',23);
INSERT INTO "country" VALUES (121,E'Kyrgyzstan',E'kg',E'kgz',21);
INSERT INTO "country" VALUES (122,E'Lao People\'s Democratic Republic',E'la',E'lao',25);
INSERT INTO "country" VALUES (123,E'Latvia',E'lv',E'lva',11);
INSERT INTO "country" VALUES (124,E'Lebanon',E'lb',E'lbn',23);
INSERT INTO "country" VALUES (125,E'Lesotho',E'ls',E'lso',45);
INSERT INTO "country" VALUES (126,E'Liberia',E'lr',E'lbr',42);
INSERT INTO "country" VALUES (127,E'Libyan Arab Jamahiriya',E'ly',E'lby',41);
INSERT INTO "country" VALUES (128,E'Liechtenstein',E'li',E'lie',12);
INSERT INTO "country" VALUES (129,E'Lithuania',E'lt',E'ltu',11);
INSERT INTO "country" VALUES (130,E'Luxembourg',E'lu',E'lux',12);
INSERT INTO "country" VALUES (131,E'China, Macau Special Administrative Region',E'mo',E'mac',22);
INSERT INTO "country" VALUES (132,E'Macedonia, The former Yugoslav Republic of',E'mk',E'mkd',13);
INSERT INTO "country" VALUES (133,E'Madagascar',E'mg',E'mdg',44);
INSERT INTO "country" VALUES (134,E'Malawi',E'mw',E'mwi',44);
INSERT INTO "country" VALUES (135,E'Malaysia',E'my',E'mys',25);
INSERT INTO "country" VALUES (136,E'Maldives',E'mv',E'mdv',24);
INSERT INTO "country" VALUES (137,E'Mali',E'ml',E'mli',42);
INSERT INTO "country" VALUES (138,E'Malta',E'mt',E'mlt',13);
INSERT INTO "country" VALUES (139,E'Marshall Islands',E'mh',E'mhl',32);
INSERT INTO "country" VALUES (140,E'Martinique',E'mq',E'mtq',53);
INSERT INTO "country" VALUES (141,E'Mauritania',E'mr',E'mrt',42);
INSERT INTO "country" VALUES (142,E'Mauritius',E'mu',E'mus',44);
INSERT INTO "country" VALUES (143,E'Mayotte',E'yt',E'myt',44);
INSERT INTO "country" VALUES (144,E'Mexico',E'mx',E'mex',52);
INSERT INTO "country" VALUES (145,E'Micronesia, Federated States of',E'fm',E'fsm',32);
INSERT INTO "country" VALUES (146,E'Moldova, Republic of',E'md',E'mda',14);
INSERT INTO "country" VALUES (147,E'Monaco',E'mc',E'mco',12);
INSERT INTO "country" VALUES (148,E'Mongolia',E'mn',E'mng',22);
INSERT INTO "country" VALUES (149,E'Montenegro',E'me',E'mne',13);
INSERT INTO "country" VALUES (150,E'Montserrat',E'ms',E'msr',53);
INSERT INTO "country" VALUES (151,E'Morocco',E'ma',E'mar',41);
INSERT INTO "country" VALUES (152,E'Mozambique',E'mz',E'moz',44);
INSERT INTO "country" VALUES (153,E'Myanmar',E'mm',E'mmr',25);
INSERT INTO "country" VALUES (154,E'Namibia',E'na',E'nam',45);
INSERT INTO "country" VALUES (155,E'Nauru',E'nr',E'nru',32);
INSERT INTO "country" VALUES (156,E'Nepal',E'np',E'npl',24);
INSERT INTO "country" VALUES (157,E'Netherlands',E'nl',E'nld',12);
INSERT INTO "country" VALUES (158,E'New Caledonia',E'nc',E'ncl',33);
INSERT INTO "country" VALUES (159,E'New Zealand',E'nz',E'nzl',31);
INSERT INTO "country" VALUES (160,E'Nicaragua',E'ni',E'nic',52);
INSERT INTO "country" VALUES (161,E'Niger',E'ne',E'ner',42);
INSERT INTO "country" VALUES (162,E'Nigeria',E'ng',E'nga',42);
INSERT INTO "country" VALUES (163,E'Niue',E'nu',E'niu',34);
INSERT INTO "country" VALUES (164,E'Norfolk Island',E'nf',E'nfk',31);
INSERT INTO "country" VALUES (165,E'Northern Mariana Islands',E'mp',E'mnp',32);
INSERT INTO "country" VALUES (166,E'Norway',E'no',E'nor',11);
INSERT INTO "country" VALUES (167,E'Oman',E'om',E'omn',23);
INSERT INTO "country" VALUES (168,E'Pakistan',E'pk',E'pak',24);
INSERT INTO "country" VALUES (169,E'Palau',E'pw',E'plw',32);
INSERT INTO "country" VALUES (170,E'State of Palestine, \"non-state entity\"',E'ps',E'pse',23);
INSERT INTO "country" VALUES (171,E'Panama',E'pa',E'pan',52);
INSERT INTO "country" VALUES (172,E'Papua New Guinea',E'pg',E'png',33);
INSERT INTO "country" VALUES (173,E'Paraguay',E'py',E'pry',61);
INSERT INTO "country" VALUES (174,E'Peru',E'pe',E'per',61);
INSERT INTO "country" VALUES (175,E'Philippines',E'ph',E'phl',25);
INSERT INTO "country" VALUES (176,E'Pitcairn',E'pn',E'pcn',34);
INSERT INTO "country" VALUES (177,E'Poland',E'pl',E'pol',14);
INSERT INTO "country" VALUES (178,E'Portugal',E'pt',E'prt',13);
INSERT INTO "country" VALUES (179,E'Puerto Rico',E'pr',E'pri',53);
INSERT INTO "country" VALUES (180,E'Qatar',E'qa',E'qat',23);
INSERT INTO "country" VALUES (181,E'Reunion',E're',E'reu',44);
INSERT INTO "country" VALUES (182,E'Romania',E'ro',E'rou',14);
INSERT INTO "country" VALUES (183,E'Russian Federation',E'ru',E'rus',14);
INSERT INTO "country" VALUES (184,E'Rwanda',E'rw',E'rwa',44);
INSERT INTO "country" VALUES (185,E'Saint Barthelemy',E'bl',E'blm',53);
INSERT INTO "country" VALUES (186,E'Saint Helena, Ascension and Tristan Da Cunha',E'sh',E'shn',42);
INSERT INTO "country" VALUES (187,E'Saint Kitts and Nevis',E'kn',E'kna',53);
INSERT INTO "country" VALUES (188,E'Saint Lucia',E'lc',E'lca',53);
INSERT INTO "country" VALUES (189,E'Saint Martin (French Part)',E'mf',E'maf',53);
INSERT INTO "country" VALUES (190,E'Saint Pierre and Miquelon',E'pm',E'spm',51);
INSERT INTO "country" VALUES (191,E'Saint Vincent and The Grenadines',E'vc',E'vct',53);
INSERT INTO "country" VALUES (192,E'Samoa',E'ws',E'wsm',34);
INSERT INTO "country" VALUES (193,E'San Marino',E'sm',E'smr',13);
INSERT INTO "country" VALUES (194,E'Sao Tome and Principe',E'st',E'stp',43);
INSERT INTO "country" VALUES (195,E'Saudi Arabia',E'sa',E'sau',23);
INSERT INTO "country" VALUES (196,E'Senegal',E'sn',E'sen',42);
INSERT INTO "country" VALUES (197,E'Serbia',E'rs',E'srb',13);
INSERT INTO "country" VALUES (198,E'Seychelles',E'sc',E'syc',44);
INSERT INTO "country" VALUES (199,E'Sierra Leone',E'sl',E'sle',42);
INSERT INTO "country" VALUES (200,E'Singapore',E'sg',E'sgp',25);
INSERT INTO "country" VALUES (201,E'Sint Maarten (Dutch Part)',E'sx',E'sxm',53);
INSERT INTO "country" VALUES (202,E'Slovakia',E'sk',E'svk',14);
INSERT INTO "country" VALUES (203,E'Slovenia',E'si',E'svn',13);
INSERT INTO "country" VALUES (204,E'Solomon Islands',E'sb',E'slb',33);
INSERT INTO "country" VALUES (205,E'Somalia',E'so',E'som',44);
INSERT INTO "country" VALUES (206,E'South Africa',E'za',E'zaf',45);
INSERT INTO "country" VALUES (207,E'South Georgia and The South Sandwich Islands',E'gs',NULL,71);
INSERT INTO "country" VALUES (208,E'South Sudan',E'ss',E'ssd',41);
INSERT INTO "country" VALUES (209,E'Spain',E'es',E'esp',13);
INSERT INTO "country" VALUES (210,E'Sri Lanka',E'lk',E'lka',24);
INSERT INTO "country" VALUES (211,E'Sudan',E'sd',E'sdn',41);
INSERT INTO "country" VALUES (212,E'Suriname',E'sr',E'sur',61);
INSERT INTO "country" VALUES (213,E'Svalbard and Jan Mayen',E'sj',E'sjm',11);
INSERT INTO "country" VALUES (214,E'Swaziland',E'sz',E'swz',45);
INSERT INTO "country" VALUES (215,E'Sweden',E'se',E'swe',11);
INSERT INTO "country" VALUES (216,E'Switzerland',E'ch',E'che',12);
INSERT INTO "country" VALUES (217,E'Syrian Arab Republic',E'sy',E'syr',23);
INSERT INTO "country" VALUES (218,E'Taiwan, Province of China',E'tw',NULL,22);
INSERT INTO "country" VALUES (219,E'Tajikistan',E'tj',E'tjk',21);
INSERT INTO "country" VALUES (220,E'Tanzania, United Republic of',E'tz',E'tza',44);
INSERT INTO "country" VALUES (221,E'Thailand',E'th',E'tha',25);
INSERT INTO "country" VALUES (222,E'Timor-Leste',E'tl',E'tls',25);
INSERT INTO "country" VALUES (223,E'Togo',E'tg',E'tgo',42);
INSERT INTO "country" VALUES (224,E'Tokelau',E'tk',E'tkl',34);
INSERT INTO "country" VALUES (225,E'Tonga',E'to',E'ton',34);
INSERT INTO "country" VALUES (226,E'Trinidad and Tobago',E'tt',E'tto',53);
INSERT INTO "country" VALUES (227,E'Tunisia',E'tn',E'tun',41);
INSERT INTO "country" VALUES (228,E'Turkey',E'tr',E'tur',23);
INSERT INTO "country" VALUES (229,E'Turkmenistan',E'tm',E'tkm',21);
INSERT INTO "country" VALUES (230,E'Turks and Caicos Islands',E'tc',E'tca',53);
INSERT INTO "country" VALUES (231,E'Tuvalu',E'tv',E'tuv',34);
INSERT INTO "country" VALUES (232,E'Uganda',E'ug',E'uga',44);
INSERT INTO "country" VALUES (233,E'Ukraine',E'ua',E'ukr',14);
INSERT INTO "country" VALUES (234,E'United Arab Emirates',E'ae',E'are',23);
INSERT INTO "country" VALUES (235,E'United Kingdom of Great Britain and Northern Ireland',E'gb',E'gbr',11);
INSERT INTO "country" VALUES (236,E'United States of America',E'us',E'usa',51);
INSERT INTO "country" VALUES (237,E'United States Minor Outlying Islands',E'um',NULL,51);
INSERT INTO "country" VALUES (238,E'Uruguay',E'uy',E'ury',61);
INSERT INTO "country" VALUES (239,E'Uzbekistan',E'uz',E'uzb',21);
INSERT INTO "country" VALUES (240,E'Vanuatu',E'vu',E'vut',33);
INSERT INTO "country" VALUES (241,E'Venezuela, Bolivarian Republic of',E've',E'ven',61);
INSERT INTO "country" VALUES (242,E'Viet Nam',E'vn',E'vnm',25);
INSERT INTO "country" VALUES (243,E'Virgin Islands, British',E'vg',E'vgb',53);
INSERT INTO "country" VALUES (244,E'Virgin Islands, U.S.',E'vi',E'vir',53);
INSERT INTO "country" VALUES (245,E'Wallis and Futuna',E'wf',E'wlf',34);
INSERT INTO "country" VALUES (246,E'Western Sahara',E'eh',E'esh',41);
INSERT INTO "country" VALUES (247,E'Yemen',E'ye',E'yem',23);
INSERT INTO "country" VALUES (248,E'Zambia',E'zm',E'zmb',44);
INSERT INTO "country" VALUES (249,E'Zimbabwe',E'zw',E'zwe',44);
INSERT INTO "country" VALUES (250,E'Unknow',E'xx',E'xxx',0);
INSERT INTO "country" VALUES (251,E'Kosovo',E'xk',E'unk',13);

/*!40000 ALTER TABLE country ENABLE KEYS */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

--
-- Table structure for table debate
--

DROP TABLE IF EXISTS "debate" CASCADE;
DROP SEQUENCE IF EXISTS "debate_id_seq" CASCADE ;

CREATE SEQUENCE "debate_id_seq"  START WITH 8674 ;

CREATE TABLE  "debate" (
   "id" integer DEFAULT nextval('"debate_id_seq"') NOT NULL,
   "round_id" int CHECK ("round_id" >= 0) NOT NULL,
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   "og_team_id" int CHECK ("og_team_id" >= 0) NOT NULL,
   "oo_team_id" int CHECK ("oo_team_id" >= 0) NOT NULL,
   "cg_team_id" int CHECK ("cg_team_id" >= 0) NOT NULL,
   "co_team_id" int CHECK ("co_team_id" >= 0) NOT NULL,
   "panel_id" int CHECK ("panel_id" >= 0) NOT NULL,
   "venue_id" int CHECK ("venue_id" >= 0) NOT NULL,
   "energy"   int NOT NULL DEFAULT '0',
   "og_feedback"    smallint NOT NULL DEFAULT '0',
   "oo_feedback"    smallint NOT NULL DEFAULT '0',
   "cg_feedback"    smallint NOT NULL DEFAULT '0',
   "co_feedback"    smallint NOT NULL DEFAULT '0',
   "time"   timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   "messages"   text,
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "debate_venue_id_idx" ON "debate" USING btree ("venue_id");
CREATE INDEX "debate_panel_id_idx" ON "debate" USING btree ("panel_id");
CREATE INDEX "debate_1_idx" ON "debate" USING btree ("round_id", "tournament_id");
CREATE INDEX "debate_og_team_id_idx" ON "debate" USING btree ("og_team_id");
CREATE INDEX "debate_oo_team_id_idx" ON "debate" USING btree ("oo_team_id");
CREATE INDEX "debate_cg_team_id_idx" ON "debate" USING btree ("cg_team_id");
CREATE INDEX "debate_co_team_id_idx" ON "debate" USING btree ("co_team_id");
ALTER TABLE "debate" ADD FOREIGN KEY ("panel_id") REFERENCES "panel" ("id");
ALTER TABLE "debate" ADD FOREIGN KEY ("venue_id") REFERENCES "venue" ("id");

--
-- Table structure for table energy_config
--

DROP TABLE IF EXISTS "energy_config" CASCADE;
DROP SEQUENCE IF EXISTS "energy_config_id_seq" CASCADE ;

CREATE SEQUENCE "energy_config_id_seq"  START WITH 3827 ;

CREATE TABLE  "energy_config" (
   "id" integer DEFAULT nextval('"energy_config_id_seq"') NOT NULL,
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   "label"   varchar(255) NOT NULL,
   "value"   int NOT NULL DEFAULT '0',
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "energy_config_100_idx" ON "energy_config" USING btree ("100");
CREATE INDEX "energy_config_tournament_id_idx" ON "energy_config" USING btree ("tournament_id");
ALTER TABLE "energy_config" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");

--
-- Table structure for table feedback
--

DROP TABLE IF EXISTS "feedback" CASCADE;
DROP SEQUENCE IF EXISTS "feedback_id_seq" CASCADE ;

CREATE SEQUENCE "feedback_id_seq"  START WITH 9362 ;

CREATE TABLE  "feedback" (
   "id" integer DEFAULT nextval('"feedback_id_seq"') NOT NULL,
   "debate_id" int CHECK ("debate_id" >= 0) NOT NULL,
   "time"   timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   "to_type"    smallint DEFAULT NULL,
   "to_id"   int DEFAULT NULL,
   "from_id"   int DEFAULT NULL,
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "feedback_debate_id_idx" ON "feedback" USING btree ("debate_id");
ALTER TABLE "feedback" ADD FOREIGN KEY ("debate_id") REFERENCES "debate" ("id");

--
-- Table structure for table in_society
--

DROP TABLE IF EXISTS "in_society" CASCADE;
CREATE TABLE  "in_society" (
   "user_id" int CHECK ("user_id" >= 0) NOT NULL,
   "society_id" int CHECK ("society_id" >= 0) NOT NULL,
   "starting"   date NOT NULL,
   "ending"   date DEFAULT NULL,
   primary key ("society_id", "user_id")
)  ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "in_society_society_id_idx" ON "in_society" USING btree ("society_id");
CREATE INDEX "in_society_user_id_idx" ON "in_society" USING btree ("user_id");
ALTER TABLE "in_society" ADD FOREIGN KEY ("society_id") REFERENCES "society" ("id");
ALTER TABLE "in_society" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

--
-- Table structure for table language
--

DROP TABLE IF EXISTS "language" CASCADE;
CREATE TABLE  "language" (
   "language"   varchar(16) NOT NULL,
   "label"   varchar(100) NOT NULL,
   "last_update"   timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   primary key ("language")
)  ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40000 ALTER TABLE language DISABLE KEYS */;

--
-- Dumping data for table language
--

INSERT INTO "language" VALUES (E'de-DE',E'German (DE)',E'2016-01-18 16:28:28');
INSERT INTO "language" VALUES (E'es-CO',E'Colombian (ES)',E'2015-12-29 07:27:02');
INSERT INTO "language" VALUES (E'fr-FR',E'Frence (FR)',E'2016-01-05 17:23:24');
INSERT INTO "language" VALUES (E'tr-TR',E'Turkish (TR)',E'2015-09-25 14:42:06');

/*!40000 ALTER TABLE language ENABLE KEYS */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

--
-- Table structure for table language_maintainer
--

DROP TABLE IF EXISTS "language_maintainer" CASCADE;
CREATE TABLE  "language_maintainer" (
   "user_id" int CHECK ("user_id" >= 0) NOT NULL,
   "language_language"   varchar(16) NOT NULL,
   primary key ("user_id", "language_language")
)  ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "language_maintainer_language_language_idx" ON "language_maintainer" USING btree ("language_language");
CREATE INDEX "language_maintainer_user_id_idx" ON "language_maintainer" USING btree ("user_id");
ALTER TABLE "language_maintainer" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "language_maintainer" ADD FOREIGN KEY ("language_language") REFERENCES "language" ("language");

--
-- Table structure for table language_officer
--

DROP TABLE IF EXISTS "language_officer" CASCADE;
CREATE TABLE  "language_officer" (
   "user_id" int CHECK ("user_id" >= 0) NOT NULL,
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   primary key ("user_id", "tournament_id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "language_officer_tournament_id_idx" ON "language_officer" USING btree ("tournament_id");
CREATE INDEX "language_officer_user_id_idx" ON "language_officer" USING btree ("user_id");
ALTER TABLE "language_officer" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");
ALTER TABLE "language_officer" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

--
-- Table structure for table legacy_motion
--

DROP TABLE IF EXISTS "legacy_motion" CASCADE;
DROP SEQUENCE IF EXISTS "legacy_motion_id_seq" CASCADE ;

CREATE SEQUENCE "legacy_motion_id_seq"  START WITH 28 ;

CREATE TABLE  "legacy_motion" (
   "id" integer DEFAULT nextval('"legacy_motion_id_seq"') NOT NULL,
   "motion"   text NOT NULL,
   "language"   varchar(2) NOT NULL DEFAULT 'en',
   "time"   date NOT NULL,
   "infoslide"   text,
   "tournament"   varchar(255) NOT NULL,
   "round"   varchar(45) DEFAULT NULL,
   "link"   varchar(255) DEFAULT NULL,
   "by_user_id" int CHECK ("by_user_id" >= 0) DEFAULT NULL,
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "legacy_motion_by_user_id_idx" ON "legacy_motion" USING btree ("by_user_id");
ALTER TABLE "legacy_motion" ADD FOREIGN KEY ("by_user_id") REFERENCES "user" ("id");

--
-- Table structure for table legacy_tag
--

DROP TABLE IF EXISTS "legacy_tag" CASCADE;
CREATE TABLE  "legacy_tag" (
   "motion_tag_id"   int NOT NULL,
   "legacy_motion_id"   int NOT NULL,
   primary key ("motion_tag_id", "legacy_motion_id")
)  ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "legacy_tag_legacy_motion_id_idx" ON "legacy_tag" USING btree ("legacy_motion_id");
CREATE INDEX "legacy_tag_motion_tag_id_idx" ON "legacy_tag" USING btree ("motion_tag_id");
ALTER TABLE "legacy_tag" ADD FOREIGN KEY ("legacy_motion_id") REFERENCES "legacy_motion" ("id");
ALTER TABLE "legacy_tag" ADD FOREIGN KEY ("motion_tag_id") REFERENCES "motion_tag" ("id");

--
-- Table structure for table message
--

DROP TABLE IF EXISTS "message" CASCADE;
CREATE TABLE  "message" (
   "id"   int NOT NULL,
   "language"   varchar(16) NOT NULL DEFAULT '',
   "translation"   text,
   primary key ("language", "id")
)  ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40000 ALTER TABLE message DISABLE KEYS */;

--
-- Dumping data for table message
--

INSERT INTO "message" VALUES (1,E'de-DE',E'ID');
INSERT INTO "message" VALUES (2,E'de-DE',E'Name');
INSERT INTO "message" VALUES (3,E'de-DE',E'Import: {modelClass}');
INSERT INTO "message" VALUES (4,E'de-DE',E'Import');
INSERT INTO "message" VALUES (5,E'de-DE',E'Verein');
INSERT INTO "message" VALUES (6,E'de-DE',E'Update');
INSERT INTO "message" VALUES (7,E'de-DE',E'Löschen');
INSERT INTO "message" VALUES (8,E'de-DE',E'Bist du sicher, dass du das Element löschen möchtest?');
INSERT INTO "message" VALUES (9,E'de-DE',E'Update: {modelClass}');
INSERT INTO "message" VALUES (10,E'de-DE',E'Kombiniere \'{society}\' mit ...');
INSERT INTO "message" VALUES (11,E'de-DE',E'Wähle den korrekten Verein ...');
INSERT INTO "message" VALUES (12,E'de-DE',E'Erstelle {modelClass}');
INSERT INTO "message" VALUES (13,E'de-DE',E'Betrachte {modelClass}');
INSERT INTO "message" VALUES (14,E'de-DE',E'Aktualisiere {modelClass}');
INSERT INTO "message" VALUES (15,E'de-DE',E'Lösche {modelClass}');
INSERT INTO "message" VALUES (16,E'de-DE',E'Neues Element hinzufügen');
INSERT INTO "message" VALUES (17,E'de-DE',E'Inhalt neu laden');
INSERT INTO "message" VALUES (18,E'de-DE',E'Importiere von CSV Datei');
INSERT INTO "message" VALUES (19,E'de-DE',E'Erstelle');
INSERT INTO "message" VALUES (20,E'de-DE',E'Sprachen');
INSERT INTO "message" VALUES (21,E'de-DE',E'Erstelle Sprache');
INSERT INTO "message" VALUES (22,E'de-DE',E'Spezielle Anforderungen');
INSERT INTO "message" VALUES (23,E'de-DE',E'Themen Tags');
INSERT INTO "message" VALUES (24,E'de-DE',E'Kombiniere Themen Tag \'{tag}\' mit ...');
INSERT INTO "message" VALUES (25,E'de-DE',E'Wähle den korrekten Tag ...');
INSERT INTO "message" VALUES (26,E'de-DE',E'Suche');
INSERT INTO "message" VALUES (27,E'de-DE',E'Zurücksetzen');
INSERT INTO "message" VALUES (28,E'de-DE',E'Erstelle Themen Tag');
INSERT INTO "message" VALUES (29,E'de-DE',E'API');
INSERT INTO "message" VALUES (30,E'de-DE',E'Master');
INSERT INTO "message" VALUES (31,E'de-DE',E'Nachrichten');
INSERT INTO "message" VALUES (32,E'de-DE',E'Nachricht erstellen');
INSERT INTO "message" VALUES (33,E'de-DE',E'{count} Tags geändert');
INSERT INTO "message" VALUES (34,E'de-DE',E'Datei Syntax falsch');
INSERT INTO "message" VALUES (35,E'de-DE',E'Themen-Tag');
INSERT INTO "message" VALUES (36,E'de-DE',E'Runde');
INSERT INTO "message" VALUES (37,E'de-DE',E'Abkürzung');
INSERT INTO "message" VALUES (38,E'de-DE',E'Menge');
INSERT INTO "message" VALUES (39,E'de-DE',E'Eröffnende Regierung');
INSERT INTO "message" VALUES (40,E'de-DE',E'Eröffnende Opposition');
INSERT INTO "message" VALUES (41,E'de-DE',E'Schließende Regierung');
INSERT INTO "message" VALUES (42,E'de-DE',E'Schließende Opposition');
INSERT INTO "message" VALUES (43,E'de-DE',E'Team');
INSERT INTO "message" VALUES (44,E'de-DE',E'Aktiv');
INSERT INTO "message" VALUES (45,E'de-DE',E'Turnier');
INSERT INTO "message" VALUES (46,E'de-DE',E'RednerIn');
INSERT INTO "message" VALUES (47,E'de-DE',E'Verein');
INSERT INTO "message" VALUES (48,E'de-DE',E'Springerteam');
INSERT INTO "message" VALUES (49,E'de-DE',E'Sprachstatus');
INSERT INTO "message" VALUES (50,E'de-DE',E'Alles normal');
INSERT INTO "message" VALUES (51,E'de-DE',E'Wurde durch Springerteam ersetzt');
INSERT INTO "message" VALUES (52,E'de-DE',E'RednerIn {letter} erschien nicht');
INSERT INTO "message" VALUES (53,E'de-DE',E'Schlüssel');
INSERT INTO "message" VALUES (54,E'de-DE',E'Label');
INSERT INTO "message" VALUES (55,E'de-DE',E'Wert');
INSERT INTO "message" VALUES (56,E'de-DE',E'Teamposition darf nicht leer sein');
INSERT INTO "message" VALUES (57,E'de-DE',E'KO-Runde');
INSERT INTO "message" VALUES (58,E'de-DE',E'Tabmaster-BenutzerIn');
INSERT INTO "message" VALUES (59,E'de-DE',E'BenutzerIn');
INSERT INTO "message" VALUES (60,E'de-DE',E'ENL-Platzierung');
INSERT INTO "message" VALUES (61,E'de-DE',E'ESL-Platzierung');
INSERT INTO "message" VALUES (62,E'de-DE',E'Cache Ergebnisse');
INSERT INTO "message" VALUES (63,E'de-DE',E'Voller Name');
INSERT INTO "message" VALUES (64,E'de-DE',E'Abkürzung');
INSERT INTO "message" VALUES (65,E'de-DE',E'Stadt');
INSERT INTO "message" VALUES (66,E'de-DE',E'Land');
INSERT INTO "message" VALUES (67,E'de-DE',E'ER Team');
INSERT INTO "message" VALUES (68,E'de-DE',E'EO Team');
INSERT INTO "message" VALUES (69,E'de-DE',E'SR Team');
INSERT INTO "message" VALUES (70,E'de-DE',E'SO Team');
INSERT INTO "message" VALUES (71,E'de-DE',E'Jury');
INSERT INTO "message" VALUES (72,E'de-DE',E'Raum');
INSERT INTO "message" VALUES (73,E'de-DE',E'ER Feedback');
INSERT INTO "message" VALUES (74,E'de-DE',E'EO Feedback');
INSERT INTO "message" VALUES (75,E'de-DE',E'SR Feedback');
INSERT INTO "message" VALUES (76,E'de-DE',E'SO Feedback');
INSERT INTO "message" VALUES (77,E'de-DE',E'Zeit');
INSERT INTO "message" VALUES (78,E'de-DE',E'Thema');
INSERT INTO "message" VALUES (79,E'de-DE',E'Sprache');
INSERT INTO "message" VALUES (80,E'de-DE',E'Datum');
INSERT INTO "message" VALUES (81,E'de-DE',E'Infotext zum Thema');
INSERT INTO "message" VALUES (82,E'de-DE',E'Link');
INSERT INTO "message" VALUES (83,E'de-DE',E'von BenutzerIn');
INSERT INTO "message" VALUES (84,E'de-DE',E'Übersetzung');
INSERT INTO "message" VALUES (85,E'de-DE',E'JurorIn');
INSERT INTO "message" VALUES (86,E'de-DE',E'Antwort');
INSERT INTO "message" VALUES (87,E'de-DE',E'Feedback');
INSERT INTO "message" VALUES (88,E'de-DE',E'Frage');
INSERT INTO "message" VALUES (89,E'de-DE',E'Erstellt');
INSERT INTO "message" VALUES (90,E'de-DE',E'Läuft');
INSERT INTO "message" VALUES (91,E'de-DE',E'Geschlossen');
INSERT INTO "message" VALUES (92,E'de-DE',E'Versteckt');
INSERT INTO "message" VALUES (93,E'de-DE',E'Veranstaltet von');
INSERT INTO "message" VALUES (94,E'de-DE',E'Turniername');
INSERT INTO "message" VALUES (95,E'de-DE',E'Beginnt am');
INSERT INTO "message" VALUES (96,E'de-DE',E'Endet am');
INSERT INTO "message" VALUES (97,E'de-DE',E'Zeitzone');
INSERT INTO "message" VALUES (98,E'de-DE',E'Logo');
INSERT INTO "message" VALUES (99,E'de-DE',E'URL-Kürzel');
INSERT INTO "message" VALUES (100,E'de-DE',E'Tab-\r\nAlgorithmus');
INSERT INTO "message" VALUES (101,E'de-DE',E'Voraussichtliche Rundenanzahl');
INSERT INTO "message" VALUES (102,E'de-DE',E'Zeige ESL-Platzierung');
INSERT INTO "message" VALUES (103,E'de-DE',E'Es gibt ein Finale');
INSERT INTO "message" VALUES (104,E'de-DE',E'Es gibt ein Halbfinale');
INSERT INTO "message" VALUES (105,E'de-DE',E'Es gibt ein Viertelfinale');
INSERT INTO "message" VALUES (106,E'de-DE',E'Es gibt ein Achtelfinale');
INSERT INTO "message" VALUES (107,E'de-DE',E'Zugriffsschlüssel');
INSERT INTO "message" VALUES (108,E'de-DE',E'TeilnehmerInnenschild');
INSERT INTO "message" VALUES (109,E'de-DE',E'Alpha 2');
INSERT INTO "message" VALUES (110,E'de-DE',E'Alpha 3');
INSERT INTO "message" VALUES (111,E'de-DE',E'Region');
INSERT INTO "message" VALUES (112,E'de-DE',E'Sprachcode');
INSERT INTO "message" VALUES (113,E'de-DE',E'Abdeckung');
INSERT INTO "message" VALUES (114,E'de-DE',E'Letzte Aktualisierung');
INSERT INTO "message" VALUES (115,E'de-DE',E'Stärke');
INSERT INTO "message" VALUES (116,E'de-DE',E'Kann hauptjurieren');
INSERT INTO "message" VALUES (117,E'de-DE',E'Werden beobachtet');
INSERT INTO "message" VALUES (118,E'de-DE',E'Nicht bewertet');
INSERT INTO "message" VALUES (121,E'de-DE',E'Kann jurieren');
INSERT INTO "message" VALUES (122,E'de-DE',E'Ordentlich');
INSERT INTO "message" VALUES (124,E'de-DE',E'Hohes Potential');
INSERT INTO "message" VALUES (125,E'de-DE',E'HauptjurorIn');
INSERT INTO "message" VALUES (126,E'de-DE',E'Gut');
INSERT INTO "message" VALUES (127,E'de-DE',E'Breakend');
INSERT INTO "message" VALUES (128,E'de-DE',E'ChefjurorIn');
INSERT INTO "message" VALUES (129,E'de-DE',E'Beginn');
INSERT INTO "message" VALUES (130,E'de-DE',E'Ende');
INSERT INTO "message" VALUES (131,E'de-DE',E'Rednerpunkte');
INSERT INTO "message" VALUES (132,E'de-DE',E'Diese Email-Adresse ist bereits vergeben.');
INSERT INTO "message" VALUES (133,E'de-DE',E'DebattantIn');
INSERT INTO "message" VALUES (134,E'de-DE',E'Auth-Schlüssel');
INSERT INTO "message" VALUES (135,E'de-DE',E'Passwort-Hash');
INSERT INTO "message" VALUES (136,E'de-DE',E'Passwort-Reset-Schlüssel');
INSERT INTO "message" VALUES (137,E'de-DE',E'Email');
INSERT INTO "message" VALUES (138,E'de-DE',E'Account-Rolle');
INSERT INTO "message" VALUES (139,E'de-DE',E'Account-Status');
INSERT INTO "message" VALUES (140,E'de-DE',E'Letzte Änderung');
INSERT INTO "message" VALUES (141,E'de-DE',E'Vorname');
INSERT INTO "message" VALUES (142,E'de-DE',E'Nachname');
INSERT INTO "message" VALUES (143,E'de-DE',E'Bild');
INSERT INTO "message" VALUES (144,E'de-DE',E'Platzhalter');
INSERT INTO "message" VALUES (145,E'de-DE',E'TabmasterIn');
INSERT INTO "message" VALUES (146,E'de-DE',E'Admin');
INSERT INTO "message" VALUES (147,E'de-DE',E'Gelöscht');
INSERT INTO "message" VALUES (148,E'de-DE',E'Nicht bekanntgegeben');
INSERT INTO "message" VALUES (149,E'de-DE',E'Weiblich');
INSERT INTO "message" VALUES (150,E'de-DE',E'Männlich');
INSERT INTO "message" VALUES (151,E'de-DE',E'Andere');
INSERT INTO "message" VALUES (152,E'de-DE',E'mixed');
INSERT INTO "message" VALUES (153,E'de-DE',E'Noch nicht gesetzt');
INSERT INTO "message" VALUES (154,E'de-DE',E'Interview wird benötigt');
INSERT INTO "message" VALUES (155,E'de-DE',E'EPL');
INSERT INTO "message" VALUES (157,E'de-DE',E'ESL');
INSERT INTO "message" VALUES (158,E'de-DE',E'Englisch als zweite Sprache');
INSERT INTO "message" VALUES (159,E'de-DE',E'EFL');
INSERT INTO "message" VALUES (160,E'de-DE',E'English als Fremdsprache');
INSERT INTO "message" VALUES (161,E'de-DE',E'Nicht gesetzt');
INSERT INTO "message" VALUES (162,E'de-DE',E'Fehler beim Speichern von InSociety für {user_name\r\n}');
INSERT INTO "message" VALUES (163,E'de-DE',E'Fehler beim Speichern von BenutzerIn {user_name}');
INSERT INTO "message" VALUES (164,E'de-DE',E'{tournament_name}: BenutzerInnen-Account für {user_name}');
INSERT INTO "message" VALUES (165,E'de-DE',E'Diese URL-Abkürzung ist nicht erlaubt.');
INSERT INTO "message" VALUES (166,E'de-DE',E'Veröffentlicht');
INSERT INTO "message" VALUES (167,E'de-DE',E'Angezeigt');
INSERT INTO "message" VALUES (168,E'de-DE',E'Begann');
INSERT INTO "message" VALUES (169,E'de-DE',E'Jurierend');
INSERT INTO "message" VALUES (170,E'de-DE',E'Beendet');
INSERT INTO "message" VALUES (171,E'de-DE',E'Haupt');
INSERT INTO "message" VALUES (172,E'de-DE',E'EinsteigerInnen');
INSERT INTO "message" VALUES (173,E'de-DE',E'Finale');
INSERT INTO "message" VALUES (174,E'de-DE',E'Halbfinale');
INSERT INTO "message" VALUES (175,E'de-DE',E'Viertelfinale');
INSERT INTO "message" VALUES (176,E'de-DE',E'Achtelfinale');
INSERT INTO "message" VALUES (177,E'de-DE',E'Runde #{num}');
INSERT INTO "message" VALUES (178,E'de-DE',E'Vorrunde');
INSERT INTO "message" VALUES (179,E'de-DE',E'Energie');
INSERT INTO "message" VALUES (180,E'de-DE',E'Infotext');
INSERT INTO "message" VALUES (181,E'de-DE',E'Vorbereitungszeit begann');
INSERT INTO "message" VALUES (182,E'de-DE',E'Letzte Temperatur');
INSERT INTO "message" VALUES (183,E'de-DE',E'ms zur Berechnung');
INSERT INTO "message" VALUES (184,E'de-DE',E'Nicht genug Teams für einen Raum - {aktiv: {teams_count})');
INSERT INTO "message" VALUES (185,E'de-DE',E'Mindestens 2 JurorInnen sind nötig - (aktive: {count_adju})');
INSERT INTO "message" VALUES (186,E'de-DE',E'Anzahl der Teams muss durch 4 dividierbar sein ;) - (aktive: {count_teams})');
INSERT INTO "message" VALUES (187,E'de-DE',E'Nicht genug aktive Räume - (aktive: {active_rooms} benötigt: {required})');
INSERT INTO "message" VALUES (188,E'de-DE',E'Nicht genug JurorInnen - (aktive: {active} benötigt: {required})');
INSERT INTO "message" VALUES (189,E'de-DE',E'Nicht genug freie JurorInnen bei dieser vorkonfigurierten Jurysetzung. (füllbare Räume: {active} mindestens benötigt: {required})');
INSERT INTO "message" VALUES (190,E'de-DE',E'Kann Jury nicht speichern! Fehler: {message}');
INSERT INTO "message" VALUES (191,E'de-DE',E'Kann Debatte nicht speichern! Fehler: {message}');
INSERT INTO "message" VALUES (192,E'de-DE',E'Kann Debatte nicht speichern! Fehler:<br>{errors}');
INSERT INTO "message" VALUES (193,E'de-DE',E'Keine Debatte #{num} zum Aktualisieren gefunden');
INSERT INTO "message" VALUES (195,E'de-DE',E'Typ');
INSERT INTO "message" VALUES (196,E'de-DE',E'Parameter falls gebraucht');
INSERT INTO "message" VALUES (197,E'de-DE',E'Passt zu Team -> HauptjurorIn');
INSERT INTO "message" VALUES (198,E'de-DE',E'Passt zu HauptjurorIn -> NebenjurorIn');
INSERT INTO "message" VALUES (199,E'de-DE',E'Passt zu NebenjurorIn -> HauptjurorIn');
INSERT INTO "message" VALUES (200,E'de-DE',E'Nicht gut');
INSERT INTO "message" VALUES (201,E'de-DE',E'Sehr gut');
INSERT INTO "message" VALUES (202,E'de-DE',E'Exzellent');
INSERT INTO "message" VALUES (203,E'de-DE',E'Sternen-Wertung (1-5) Feld');
INSERT INTO "message" VALUES (204,E'de-DE',E'Kurzes Textfeld');
INSERT INTO "message" VALUES (205,E'de-DE',E'Langes Textfeld');
INSERT INTO "message" VALUES (206,E'de-DE',E'Nummernfeld');
INSERT INTO "message" VALUES (207,E'de-DE',E'Kontrollboxfeld');
INSERT INTO "message" VALUES (208,E'de-DE',E'Debatte');
INSERT INTO "message" VALUES (209,E'de-DE',E'Feedback für ID');
INSERT INTO "message" VALUES (210,E'de-DE',E'JurorInnen-Konflikt von ID');
INSERT INTO "message" VALUES (211,E'de-DE',E'JurorInnen-Konflikt mit ID');
INSERT INTO "message" VALUES (212,E'de-DE',E'Gruppe');
INSERT INTO "message" VALUES (213,E'de-DE',E'Aktiver Raum');
INSERT INTO "message" VALUES (214,E'de-DE',E'NebenjurorIn');
INSERT INTO "message" VALUES (215,E'de-DE',E'Verwendet');
INSERT INTO "message" VALUES (216,E'de-DE',E'Ist vorkonfigurierte Jury');
INSERT INTO "message" VALUES (217,E'de-DE',E'Jury #{id} beinhaltet {amount} HauptjurorInnen');
INSERT INTO "message" VALUES (218,E'de-DE',E'Kategorie');
INSERT INTO "message" VALUES (219,E'de-DE',E'Nachricht');
INSERT INTO "message" VALUES (220,E'de-DE',E'Funktion');
INSERT INTO "message" VALUES (221,E'de-DE',E'Altes Thema');
INSERT INTO "message" VALUES (222,E'de-DE',E'Fragen');
INSERT INTO "message" VALUES (223,E'de-DE',E'Konflikt mit');
INSERT INTO "message" VALUES (224,E'de-DE',E'Grund');
INSERT INTO "message" VALUES (225,E'de-DE',E'Teamkonflikt');
INSERT INTO "message" VALUES (226,E'de-DE',E'JurorInnenkonflikt');
INSERT INTO "message" VALUES (227,E'de-DE',E'Kein Typ gefunden');
INSERT INTO "message" VALUES (228,E'de-DE',E'ER A RednerInnenpunkte');
INSERT INTO "message" VALUES (229,E'de-DE',E'ER B RednerInnenpunkte');
INSERT INTO "message" VALUES (230,E'de-DE',E'ER Platzierung');
INSERT INTO "message" VALUES (231,E'de-DE',E'EO A RednerInnenpunkte');
INSERT INTO "message" VALUES (232,E'de-DE',E'EO B RednerInnenpunkte');
INSERT INTO "message" VALUES (233,E'de-DE',E'EO Platzierung');
INSERT INTO "message" VALUES (234,E'de-DE',E'SR A RednerInnenpunkte');
INSERT INTO "message" VALUES (235,E'de-DE',E'SR B RednerInnenpunkte');
INSERT INTO "message" VALUES (236,E'de-DE',E'SR Platzierung');
INSERT INTO "message" VALUES (237,E'de-DE',E'SO A RednerInnenpunkte');
INSERT INTO "message" VALUES (238,E'de-DE',E'SO B RednerInnenpunkte');
INSERT INTO "message" VALUES (239,E'de-DE',E'SO Platzierung');
INSERT INTO "message" VALUES (240,E'de-DE',E'Überprüft');
INSERT INTO "message" VALUES (241,E'de-DE',E'Eingegeben von BenutzerIn ID');
INSERT INTO "message" VALUES (242,E'de-DE',E'Gleiche Platzierungen existieren');
INSERT INTO "message" VALUES (243,E'de-DE',E'Ironman durch');
INSERT INTO "message" VALUES (244,E'de-DE',E'CJ');
INSERT INTO "message" VALUES (245,E'de-DE',E'Passwort-Reset-Schlüssel darf nicht leer sein.');
INSERT INTO "message" VALUES (246,E'de-DE',E'Falscher Passwort-Reset-Schlüssel.');
INSERT INTO "message" VALUES (247,E'de-DE',E'Komma ( , ) getrennte Datei');
INSERT INTO "message" VALUES (248,E'de-DE',E'Strickpunkt ( ; ) getrennte Datei');
INSERT INTO "message" VALUES (249,E'de-DE',E'Tag ( ->| ) getrennte Datei');
INSERT INTO "message" VALUES (250,E'de-DE',E'CSV-Datei');
INSERT INTO "message" VALUES (251,E'de-DE',E'Trennzeichen');
INSERT INTO "message" VALUES (252,E'de-DE',E'Markiere als Test-Datenimport (es werden keine Emails versendet)');
INSERT INTO "message" VALUES (253,E'de-DE',E'BenutzerInnenname');
INSERT INTO "message" VALUES (254,E'de-DE',E'Profilbild');
INSERT INTO "message" VALUES (255,E'de-DE',E'Derzeitiger Verein');
INSERT INTO "message" VALUES (256,E'de-DE',E'Mit welchem Geschlecht identifizierst du dich am meisten');
INSERT INTO "message" VALUES (257,E'de-DE',E'Diese URL ist nicht erlaubt.');
INSERT INTO "message" VALUES (258,E'de-DE',E'{adju} ist registriert!');
INSERT INTO "message" VALUES (259,E'de-DE',E'{adju} wurde bereits registriert!');
INSERT INTO "message" VALUES (260,E'de-DE',E'{id) ist nicht gültig! Kein Juror!');
INSERT INTO "message" VALUES (261,E'de-DE',E'{speaker} wurde registriert!');
INSERT INTO "message" VALUES (262,E'de-DE',E'{speaker} wurde bereits registriert!');
INSERT INTO "message" VALUES (263,E'de-DE',E'{id) ist nicht gültig! Kein Team!');
INSERT INTO "message" VALUES (264,E'de-DE',E'Keine gültige Eingabe');
INSERT INTO "message" VALUES (265,E'de-DE',E'Überprüfungscode');
INSERT INTO "message" VALUES (266,E'de-DE',E'DebReg');
INSERT INTO "message" VALUES (267,E'de-DE',E'Passwort zurücksetzen für {user}');
INSERT INTO "message" VALUES (268,E'de-DE',E'Benutzerin mit dieser Email-Adresse nicht gefunden');
INSERT INTO "message" VALUES (269,E'de-DE',E'{object} hinzufügen');
INSERT INTO "message" VALUES (270,E'de-DE',E'Verein erstellen');
INSERT INTO "message" VALUES (271,E'de-DE',E'Hey cool! Du hast einen unbekannten Verein hinzugefügt!');
INSERT INTO "message" VALUES (272,E'de-DE',E'Bevor wir dich verknüpfen können gib uns doch bitte noch einige Informationen zu deinem Verein:');
INSERT INTO "message" VALUES (273,E'de-DE',E'Suche nach Land ...');
INSERT INTO "message" VALUES (274,E'de-DE',E'Neuen Verein hinzufügen');
INSERT INTO "message" VALUES (275,E'de-DE',E'Suche nach Verein ...');
INSERT INTO "message" VALUES (276,E'de-DE',E'Füge Datum des Beginns hinzu ...');
INSERT INTO "message" VALUES (277,E'de-DE',E'Füge Datum des Endes hinzu, falls passend ...');
INSERT INTO "message" VALUES (278,E'de-DE',E'Sprachen-Beauftragte');
INSERT INTO "message" VALUES (279,E'de-DE',E'Beauftragte/r');
INSERT INTO "message" VALUES (280,E'de-DE',E'Jedes {object} ...');
INSERT INTO "message" VALUES (281,E'de-DE',E'Sprachstatus-Bericht');
INSERT INTO "message" VALUES (282,E'de-DE',E'Status');
INSERT INTO "message" VALUES (283,E'de-DE',E'Beantrage ein Interview');
INSERT INTO "message" VALUES (284,E'de-DE',E'Setze ENL');
INSERT INTO "message" VALUES (285,E'de-DE',E'Setze ESL');
INSERT INTO "message" VALUES (286,E'de-DE',E'Sprachen-Beauftragte/r');
INSERT INTO "message" VALUES (288,E'de-DE',E'Hinzufügen');
INSERT INTO "message" VALUES (289,E'de-DE',E'Suchen nach NutzerIn ...');
INSERT INTO "message" VALUES (290,E'de-DE',E'Einchecken');
INSERT INTO "message" VALUES (291,E'de-DE',E'Übermitteln');
INSERT INTO "message" VALUES (292,E'de-DE',E'TeilnehmerInnenschilder erstellen');
INSERT INTO "message" VALUES (293,E'de-DE',E'Nur für BenutzerIn ...');
INSERT INTO "message" VALUES (294,E'de-DE',E'TeilnehmerInnenschilder drucken');
INSERT INTO "message" VALUES (295,E'de-DE',E'Strichcode generieren');
INSERT INTO "message" VALUES (296,E'de-DE',E'Nach BenutzerIn suchen ... oder leer lassen');
INSERT INTO "message" VALUES (297,E'de-DE',E'Strichcodes drucken');
INSERT INTO "message" VALUES (298,E'de-DE',E'Teams');
INSERT INTO "message" VALUES (299,E'de-DE',E'Teamname');
INSERT INTO "message" VALUES (300,E'de-DE',E'RednerIn A');
INSERT INTO "message" VALUES (301,E'de-DE',E'RednerIn B');
INSERT INTO "message" VALUES (302,E'de-DE',E'So einsenden');
INSERT INTO "message" VALUES (303,E'de-DE',E'Thema:');
INSERT INTO "message" VALUES (304,E'de-DE',E'Jury:');
INSERT INTO "message" VALUES (305,E'de-DE',E'Aktiv schalten');
INSERT INTO "message" VALUES (307,E'de-DE',E'Nach BenutzerIn suchen ...');
INSERT INTO "message" VALUES (308,E'de-DE',E'Turniere');
INSERT INTO "message" VALUES (309,E'de-DE',E'Überblick');
INSERT INTO "message" VALUES (310,E'de-DE',E'Themen');
INSERT INTO "message" VALUES (311,E'de-DE',E'Teamtab');
INSERT INTO "message" VALUES (312,E'de-DE',E'RednerInnentab');
INSERT INTO "message" VALUES (313,E'de-DE',E'KO-Runden');
INSERT INTO "message" VALUES (314,E'de-DE',E'Breakende JurorInnen');
INSERT INTO "message" VALUES (315,E'de-DE',E'So einsenden!');
INSERT INTO "message" VALUES (316,E'de-DE',E'DebReg-Turnier');
INSERT INTO "message" VALUES (317,E'de-DE',E'Zeige vergangene Turniere');
INSERT INTO "message" VALUES (318,E'de-DE',E'JurorInnen');
INSERT INTO "message" VALUES (319,E'de-DE',E'Ergebnis');
INSERT INTO "message" VALUES (320,E'de-DE',E'gemeinsam mit {teammate}');
INSERT INTO "message" VALUES (321,E'de-DE',E'als Ironman');
INSERT INTO "message" VALUES (322,E'de-DE',E'Du bist als Team <br> \'{team}\' {with} für {society} registriert');
INSERT INTO "message" VALUES (323,E'de-DE',E'Du bist als JurorIn für {society} registriert');
INSERT INTO "message" VALUES (325,E'de-DE',E'Registrierungsinformationen');
INSERT INTO "message" VALUES (326,E'de-DE',E'Informationen hinzufügen');
INSERT INTO "message" VALUES (327,E'de-DE',E'Runde #{num} Info');
INSERT INTO "message" VALUES (328,E'de-DE',E'Du bist <b>{pos}</b> im Raum <b>{room}</b>.');
INSERT INTO "message" VALUES (329,E'de-DE',E'Runde beginnt um: <b>{time}</b>');
INSERT INTO "message" VALUES (330,E'de-DE',E'Infotext');
INSERT INTO "message" VALUES (331,E'de-DE',E'Runde #{num} Teams');
INSERT INTO "message" VALUES (332,E'de-DE',E'Mein super geniales Turnier ... z.B. Vienna IV');
INSERT INTO "message" VALUES (333,E'de-DE',E'Wähle die CheforganisatorInnen aus ...');
INSERT INTO "message" VALUES (334,E'de-DE',E'Wähle das Datum des Beginns...');
INSERT INTO "message" VALUES (335,E'de-DE',E'Wähle das Datum des Endes ...');
INSERT INTO "message" VALUES (336,E'de-DE',E'ChefjurorInnen');
INSERT INTO "message" VALUES (337,E'de-DE',E'Wähle deine ChefjurorInnen ...');
INSERT INTO "message" VALUES (338,E'de-DE',E'Wähle deinen Tabmaster ...');
INSERT INTO "message" VALUES (339,E'de-DE',E'Turnierarchiv');
INSERT INTO "message" VALUES (340,E'de-DE',E'Der obige Fehler ist aufgetreten während der Server deine Anfrage bearbeitet hat.');
INSERT INTO "message" VALUES (341,E'de-DE',E'Bitte kontaktiere uns, wenn du der Meinung bist, dass dies ein Serverfehler ist. Danke!');
INSERT INTO "message" VALUES (342,E'de-DE',E'Passwort wiederherstellen');
INSERT INTO "message" VALUES (343,E'de-DE',E'Bitte wähle dein neues Passwort:');
INSERT INTO "message" VALUES (344,E'de-DE',E'Speichern');
INSERT INTO "message" VALUES (345,E'de-DE',E'Registrieren');
INSERT INTO "message" VALUES (346,E'de-DE',E'Bitte fülle die folgenden Felder aus, um dich zu registrieren:');
INSERT INTO "message" VALUES (347,E'de-DE',E'Die meisten Zuweisungsalgorithmen dieses Systems versuchen, unter anderem eine diverse Jury zu generieren. Damit dies funktionieren kann, würden wir dich bitten, eine Option aus der Liste auszuwählen. Wir sind uns bewusst, dass durch unsere Auswahl nicht jede persönliche Präferenz abgedeckt werden kann und entschuldigen uns für fehlende Optionen. Wenn du den Eindruck hast, dass keine dieser Optionen anwendbar ist, wähle bitte <Not Revealing>. Diese Option wird niemals regulären NutzerInnen angezeigt und dient einzig Berechnungszwecken!');
INSERT INTO "message" VALUES (348,E'de-DE',E'Einloggen');
INSERT INTO "message" VALUES (349,E'de-DE',E'Bitte fülle die folgenden Felder aus um dich einzuloggen:');
INSERT INTO "message" VALUES (350,E'de-DE',E'Falls du dein Passwort vergessen hast, kannst du {resetIt}');
INSERT INTO "message" VALUES (351,E'de-DE',E'es resetten');
INSERT INTO "message" VALUES (352,E'de-DE',E'Passwortreset anfordern');
INSERT INTO "message" VALUES (353,E'de-DE',E'Bitte gib deine Email-Adresse ein. Wir werden dir einen Link zum Resetten deines Passworts zusenden.');
INSERT INTO "message" VALUES (354,E'de-DE',E'Senden');
INSERT INTO "message" VALUES (355,E'de-DE',E'Räume-CSV');
INSERT INTO "message" VALUES (356,E'de-DE',E'JurorInnen-CSV');
INSERT INTO "message" VALUES (357,E'de-DE',E'Team-CSV');
INSERT INTO "message" VALUES (358,E'de-DE',E'erstellt');
INSERT INTO "message" VALUES (359,E'de-DE',E'Beispiel einer Raum-CSV');
INSERT INTO "message" VALUES (360,E'de-DE',E'Beispiel einer Team-CSV');
INSERT INTO "message" VALUES (361,E'de-DE',E'Beispiel einer JurorInnen-CSV');
INSERT INTO "message" VALUES (362,E'de-DE',E'Aktuelles BPS-Turnier {count, plural, =0{Tournament} =1{Tournament} other{Tournaments}}');
INSERT INTO "message" VALUES (363,E'de-DE',E'Willkommen bei {appName}!');
INSERT INTO "message" VALUES (364,E'de-DE',E'Zeige Turniere');
INSERT INTO "message" VALUES (365,E'de-DE',E'Erstelle Turnier');
INSERT INTO "message" VALUES (366,E'de-DE',E'Ehe wir dich registrieren können vervollständige bitte die Informationen zu deinem Verein:');
INSERT INTO "message" VALUES (367,E'de-DE',E'Kontakt');
INSERT INTO "message" VALUES (368,E'de-DE',E'Vorkonfigurierte Jury #');
INSERT INTO "message" VALUES (369,E'de-DE',E'Jury');
INSERT INTO "message" VALUES (370,E'de-DE',E'Durchschnittliche Jury-Stärke');
INSERT INTO "message" VALUES (371,E'de-DE',E'Erstelle Jury');
INSERT INTO "message" VALUES (372,E'de-DE',E'Vorkonfigurierte Jury für die nächste Runde');
INSERT INTO "message" VALUES (373,E'de-DE',E'Erstelle {object} ...');
INSERT INTO "message" VALUES (374,E'de-DE',E'Platz');
INSERT INTO "message" VALUES (375,E'de-DE',E'Teampunkte');
INSERT INTO "message" VALUES (376,E'de-DE',E'#{number}');
INSERT INTO "message" VALUES (377,E'de-DE',E'Keine breakenden Juroren definiert');
INSERT INTO "message" VALUES (378,E'de-DE',E'Verteilung der RednerInnenpunkte');
INSERT INTO "message" VALUES (379,E'de-DE',E'Lauf');
INSERT INTO "message" VALUES (380,E'de-DE',E'Eröffnende Regierung');
INSERT INTO "message" VALUES (381,E'de-DE',E'Eröffnende Opposition');
INSERT INTO "message" VALUES (382,E'de-DE',E'Schließende Regierung');
INSERT INTO "message" VALUES (383,E'de-DE',E'Schließende Opposition');
INSERT INTO "message" VALUES (384,E'de-DE',E'Zeige Infotext');
INSERT INTO "message" VALUES (385,E'de-DE',E'Zeige Thema');
INSERT INTO "message" VALUES (386,E'de-DE',E'Fehlende Personen');
INSERT INTO "message" VALUES (387,E'de-DE',E'Markiere fehlende Personen als inaktiv');
INSERT INTO "message" VALUES (388,E'de-DE',E'Ergebnisse');
INSERT INTO "message" VALUES (389,E'de-DE',E'Runner Ansicht für Runde #{number}');
INSERT INTO "message" VALUES (390,E'de-DE',E'Automatische Aktualisierung <i id=\'pjax-status\' class=\'\'></i>');
INSERT INTO "message" VALUES (391,E'de-DE',E'Aktualisiere individuellen Konflikt');
INSERT INTO "message" VALUES (392,E'de-DE',E'Individueller Konflikt');
INSERT INTO "message" VALUES (393,E'de-DE',E'Es sind noch nicht alle DebattantInnen im System. :)');
INSERT INTO "message" VALUES (394,E'de-DE',E'Erstelle Konflikt');
INSERT INTO "message" VALUES (395,E'de-DE',E'Aktualisiere Konflikt');
INSERT INTO "message" VALUES (396,E'de-DE',E'Energie-Einstellungen');
INSERT INTO "message" VALUES (397,E'de-DE',E'Aktualisiere Energie Einstellungen');
INSERT INTO "message" VALUES (398,E'de-DE',E'Runde #{number}');
INSERT INTO "message" VALUES (399,E'de-DE',E'Runden');
INSERT INTO "message" VALUES (400,E'de-DE',E'Aktionen');
INSERT INTO "message" VALUES (401,E'de-DE',E'Veröffentliche Tab');
INSERT INTO "message" VALUES (402,E'de-DE',E'Erneute Draw-Erstellung versuchen');
INSERT INTO "message" VALUES (403,E'de-DE',E'Aktualisiere Runde');
INSERT INTO "message" VALUES (404,E'de-DE',E'Drowpdown-Menü umschalten');
INSERT INTO "message" VALUES (405,E'de-DE',E'Verbessere weiter um');
INSERT INTO "message" VALUES (407,E'de-DE',E'Bist du sicher, dass du die Runde neu anlegen möchtest? Alle Informationen gehen dabei verloren!');
INSERT INTO "message" VALUES (408,E'de-DE',E'Drucke Laufzettel');
INSERT INTO "message" VALUES (411,E'de-DE',E'Rundenstatus');
INSERT INTO "message" VALUES (412,E'de-DE',E'Durchschnittliche Energie');
INSERT INTO "message" VALUES (413,E'de-DE',E'Erstellungszeit');
INSERT INTO "message" VALUES (414,E'de-DE',E'Farbpalette');
INSERT INTO "message" VALUES (415,E'de-DE',E'Geschlecht');
INSERT INTO "message" VALUES (416,E'de-DE',E'Regionen');
INSERT INTO "message" VALUES (417,E'de-DE',E'Punkte');
INSERT INTO "message" VALUES (418,E'de-DE',E'Laden ...');
INSERT INTO "message" VALUES (419,E'de-DE',E'Zeige Feedback');
INSERT INTO "message" VALUES (420,E'de-DE',E'Zeige BenutzerIn');
INSERT INTO "message" VALUES (421,E'de-DE',E'Tausche Raum {venue} mit');
INSERT INTO "message" VALUES (422,E'de-DE',E'Wähle einen Raum ...');
INSERT INTO "message" VALUES (423,E'de-DE',E'Aktualisiere {modelClass} #{number}');
INSERT INTO "message" VALUES (424,E'de-DE',E'Energielevel');
INSERT INTO "message" VALUES (425,E'de-DE',E'Wähle ein Team ...');
INSERT INTO "message" VALUES (426,E'de-DE',E'Wähle eine Sprache ...');
INSERT INTO "message" VALUES (427,E'de-DE',E'Wähle JurorIn ...');
INSERT INTO "message" VALUES (428,E'de-DE',E'Tausche JurorInnen');
INSERT INTO "message" VALUES (429,E'de-DE',E'Tausche JurorIn ...');
INSERT INTO "message" VALUES (430,E'de-DE',E'mit');
INSERT INTO "message" VALUES (431,E'de-DE',E'JurorIn ...');
INSERT INTO "message" VALUES (432,E'de-DE',E'Suche nach Themen-Tag ...');
INSERT INTO "message" VALUES (433,E'de-DE',E'Rang');
INSERT INTO "message" VALUES (434,E'de-DE',E'Gesamt');
INSERT INTO "message" VALUES (435,E'de-DE',E'Debatten-ID');
INSERT INTO "message" VALUES (436,E'de-DE',E'Raum');
INSERT INTO "message" VALUES (437,E'de-DE',E'KO-Runden');
INSERT INTO "message" VALUES (438,E'de-DE',E'Themenarchiv');
INSERT INTO "message" VALUES (439,E'de-DE',E'Systemexternes Thema');
INSERT INTO "message" VALUES (440,E'de-DE',E'Dein geniales Turnier');
INSERT INTO "message" VALUES (441,E'de-DE',E'Füge ein Datum ein ...');
INSERT INTO "message" VALUES (442,E'de-DE',E'Runde #1 oder Finale');
INSERT INTO "message" VALUES (443,E'de-DE',E'DHW ...');
INSERT INTO "message" VALUES (444,E'de-DE',E'http://bitte.quelle.angeben.de');
INSERT INTO "message" VALUES (445,E'de-DE',E'{modelClass} manuell einfügen');
INSERT INTO "message" VALUES (446,E'de-DE',E'Optionen');
INSERT INTO "message" VALUES (447,E'de-DE',E'Weiter');
INSERT INTO "message" VALUES (448,E'de-DE',E'Noch keine Ergebnisse!');
INSERT INTO "message" VALUES (449,E'de-DE',E'Ergebnisse in Raum: {venue}');
INSERT INTO "message" VALUES (450,E'de-DE',E'Ergebnisse für {venue}');
INSERT INTO "message" VALUES (451,E'de-DE',E'Tabellenansicht');
INSERT INTO "message" VALUES (452,E'de-DE',E'Ergebnisse für {label}');
INSERT INTO "message" VALUES (453,E'de-DE',E'Wechseln zur Raumansicht');
INSERT INTO "message" VALUES (454,E'de-DE',E'Ergebnis des Springerteams');
INSERT INTO "message" VALUES (455,E'de-DE',E'Zeige Details zum Ergebnis');
INSERT INTO "message" VALUES (456,E'de-DE',E'Korregiere Ergebnis');
INSERT INTO "message" VALUES (457,E'de-DE',E'Raumansicht');
INSERT INTO "message" VALUES (458,E'de-DE',E'Wechseln zur Tabellenansicht');
INSERT INTO "message" VALUES (459,E'de-DE',E'Bestätige Daten für {venue}');
INSERT INTO "message" VALUES (460,E'de-DE',E'beginne neu');
INSERT INTO "message" VALUES (461,E'de-DE',E'Runde {number}');
INSERT INTO "message" VALUES (462,E'de-DE',E'Vielen Dank');
INSERT INTO "message" VALUES (463,E'de-DE',E'Vielen Dank!');
INSERT INTO "message" VALUES (464,E'de-DE',E'Ergebnisse erfolgreich gespeichert');
INSERT INTO "message" VALUES (465,E'de-DE',E'Geschwindigkeits-Bonus!');
INSERT INTO "message" VALUES (466,E'de-DE',E'Schneller! Hopp hopp!');
INSERT INTO "message" VALUES (467,E'de-DE',E'Faulpelze! Ihr seid Letzter!');
INSERT INTO "message" VALUES (468,E'de-DE',E'Du bist <b>#{place}</b> von {max}');
INSERT INTO "message" VALUES (469,E'de-DE',E'Feedback übermitteln');
INSERT INTO "message" VALUES (470,E'de-DE',E'Zurück zum Turnier');
INSERT INTO "message" VALUES (471,E'de-DE',E'Feedbacks');
INSERT INTO "message" VALUES (472,E'de-DE',E'Ziel-JurorIn');
INSERT INTO "message" VALUES (473,E'de-DE',E'JurorInnen-Name ...');
INSERT INTO "message" VALUES (474,E'de-DE',E'JurorIn-Feedback');
INSERT INTO "message" VALUES (475,E'de-DE',E'Übermittle Feedback');
INSERT INTO "message" VALUES (476,E'de-DE',E'{tournament} - Sprachen-Beauftragte/r');
INSERT INTO "message" VALUES (477,E'de-DE',E'Sprachstatus überprüfen');
INSERT INTO "message" VALUES (478,E'de-DE',E'enthält geheime Alientechnologie');
INSERT INTO "message" VALUES (479,E'de-DE',E'Fehler berichten');
INSERT INTO "message" VALUES (480,E'de-DE',E'{tournament} - Manager');
INSERT INTO "message" VALUES (481,E'de-DE',E'Räume auflisten');
INSERT INTO "message" VALUES (482,E'de-DE',E'Raum erstellen');
INSERT INTO "message" VALUES (483,E'de-DE',E'Raum importieren');
INSERT INTO "message" VALUES (484,E'de-DE',E'Teams auflisten');
INSERT INTO "message" VALUES (485,E'de-DE',E'Team erstellen');
INSERT INTO "message" VALUES (486,E'de-DE',E'Team importieren');
INSERT INTO "message" VALUES (487,E'de-DE',E'Teamkonflikt');
INSERT INTO "message" VALUES (488,E'de-DE',E'JurorInnen auflisten');
INSERT INTO "message" VALUES (489,E'de-DE',E'JurorIn erstellen');
INSERT INTO "message" VALUES (490,E'de-DE',E'JurorIn importieren');
INSERT INTO "message" VALUES (491,E'de-DE',E'Vorkonfigurierte Jury zeigen');
INSERT INTO "message" VALUES (492,E'de-DE',E'Vorkonfigurierte Jury erstellen');
INSERT INTO "message" VALUES (493,E'de-DE',E'JurorInnenkonflikt');
INSERT INTO "message" VALUES (494,E'de-DE',E'Turnier aktualisieren');
INSERT INTO "message" VALUES (495,E'de-DE',E'Teamübersicht anzeigen');
INSERT INTO "message" VALUES (496,E'de-DE',E'RednerInnenübersicht anzeigen');
INSERT INTO "message" VALUES (497,E'de-DE',E'KO-Rundenübersicht anzeigen');
INSERT INTO "message" VALUES (498,E'de-DE',E'Das Tab zu veröffentlichen wird das Turnier schließen und archivieren! Bist du sicher, dass du fortfahren möchtest?');
INSERT INTO "message" VALUES (499,E'de-DE',E'Fehlende/r BenutzerIn');
INSERT INTO "message" VALUES (500,E'de-DE',E'Eincheck-Formular');
INSERT INTO "message" VALUES (501,E'de-DE',E'Teilnehmerschilder drucken');
INSERT INTO "message" VALUES (502,E'de-DE',E'Einchecken zurücksetzen');
INSERT INTO "message" VALUES (503,E'de-DE',E'Bist du sicher, dass du das Einchecken zurücksetzen möchtest?');
INSERT INTO "message" VALUES (504,E'de-DE',E'Sync mit DebReg');
INSERT INTO "message" VALUES (505,E'de-DE',E'Migriere zu Tabbie1');
INSERT INTO "message" VALUES (506,E'de-DE',E'Extreme Vorsicht, junger Padawan!');
INSERT INTO "message" VALUES (507,E'de-DE',E'Runden auflisten');
INSERT INTO "message" VALUES (508,E'de-DE',E'Runde erstellen');
INSERT INTO "message" VALUES (509,E'de-DE',E'Energie-Optionen');
INSERT INTO "message" VALUES (510,E'de-DE',E'Ergebnisse anzeigen');
INSERT INTO "message" VALUES (511,E'de-DE',E'Laufzettel einfügen');
INSERT INTO "message" VALUES (512,E'de-DE',E'Cache korrigieren');
INSERT INTO "message" VALUES (513,E'de-DE',E'Fragen einrichten');
INSERT INTO "message" VALUES (514,E'de-DE',E'Jedes Feedback');
INSERT INTO "message" VALUES (515,E'de-DE',E'Feedback für JurorIn');
INSERT INTO "message" VALUES (516,E'de-DE',E'Über');
INSERT INTO "message" VALUES (517,E'de-DE',E'Anleitung');
INSERT INTO "message" VALUES (518,E'de-DE',E'BenutzerInnen');
INSERT INTO "message" VALUES (519,E'de-DE',E'Registrieren');
INSERT INTO "message" VALUES (520,E'de-DE',E'{user}s Profil');
INSERT INTO "message" VALUES (521,E'de-DE',E'{user}s Verlauf');
INSERT INTO "message" VALUES (522,E'de-DE',E'Ausloggen');
INSERT INTO "message" VALUES (524,E'de-DE',E'Aktualisiere {label}');
INSERT INTO "message" VALUES (525,E'de-DE',E'Nächster Schritt');
INSERT INTO "message" VALUES (526,E'de-DE',E'Raum {number}');
INSERT INTO "message" VALUES (527,E'de-DE',E'Räume');
INSERT INTO "message" VALUES (529,E'de-DE',E'Konflikte');
INSERT INTO "message" VALUES (530,E'de-DE',E'Importiere Konflikte');
INSERT INTO "message" VALUES (531,E'de-DE',E'Akzeptieren');
INSERT INTO "message" VALUES (532,E'de-DE',E'Ablehnen');
INSERT INTO "message" VALUES (533,E'de-DE',E'Suche nach Team ...');
INSERT INTO "message" VALUES (534,E'de-DE',E'Suche nach JurorIn ...');
INSERT INTO "message" VALUES (535,E'de-DE',E'JurorInnenkonflikt hinzufügen');
INSERT INTO "message" VALUES (536,E'de-DE',E'{modelClass} zusätzlich erstellen');
INSERT INTO "message" VALUES (537,E'de-DE',E'Team aktualisieren');
INSERT INTO "message" VALUES (538,E'de-DE',E'Team löschen');
INSERT INTO "message" VALUES (539,E'de-DE',E'(not set)');
INSERT INTO "message" VALUES (540,E'de-DE',NULL);
INSERT INTO "message" VALUES (541,E'de-DE',E'Team mit JurorIn in Konflikt setzen');
INSERT INTO "message" VALUES (542,E'de-DE',E'Team aktualisieren');
INSERT INTO "message" VALUES (543,E'de-DE',E'Team löschen');
INSERT INTO "message" VALUES (544,E'de-DE',E'{modelClass}s Verlauf');
INSERT INTO "message" VALUES (545,E'de-DE',E'Verlauf');
INSERT INTO "message" VALUES (546,E'de-DE',E'Team-Überblick');
INSERT INTO "message" VALUES (547,E'de-DE',E'EPL-Platzierung');
INSERT INTO "message" VALUES (548,E'de-DE',E'RednerInnenpunkte des Teams');
INSERT INTO "message" VALUES (549,E'de-DE',E'Aktuell ist kein veröffentlichtes Tab verfügbar');
INSERT INTO "message" VALUES (550,E'de-DE',E'Kann hauptjurieren');
INSERT INTO "message" VALUES (551,E'de-DE',E'Sollte nicht hauptjurieren');
INSERT INTO "message" VALUES (552,E'de-DE',E'Break');
INSERT INTO "message" VALUES (553,E'de-DE',E'Nicht breakend');
INSERT INTO "message" VALUES (554,E'de-DE',E'Unter Beobachtung');
INSERT INTO "message" VALUES (555,E'de-DE',E'Nicht unter Beobachtung');
INSERT INTO "message" VALUES (556,E'de-DE',E'Beobachtung\r\n umschalten');
INSERT INTO "message" VALUES (557,E'de-DE',E'Breakend umschalten');
INSERT INTO "message" VALUES (558,E'de-DE',E'Beobachterstatus zurücksetzen');
INSERT INTO "message" VALUES (559,E'de-DE',E'Suche nach {object} ...');
INSERT INTO "message" VALUES (560,E'de-DE',E'Hauptjuriert');
INSERT INTO "message" VALUES (561,E'de-DE',E'Punkte-Tendenz');
INSERT INTO "message" VALUES (562,E'de-DE',E'Aktualisiere BenutzerInnen-Profil');
INSERT INTO "message" VALUES (563,E'de-DE',E'Individuelle Konflikte');
INSERT INTO "message" VALUES (564,E'de-DE',E'Aktualisiere Konflikt-Informationen');
INSERT INTO "message" VALUES (565,E'de-DE',E'Lösche Konflikt');
INSERT INTO "message" VALUES (566,E'de-DE',E'Dem System sind keine Konflikte bekannt.');
INSERT INTO "message" VALUES (567,E'de-DE',E'Besuchte Debattiervereine');
INSERT INTO "message" VALUES (568,E'de-DE',E'Verein zum Verlauf hinzufügen');
INSERT INTO "message" VALUES (569,E'de-DE',E'nach wie vor aktiv');
INSERT INTO "message" VALUES (570,E'de-DE',E'Aktualisiere Informationen zu besuchten Vereinen');
INSERT INTO "message" VALUES (571,E'de-DE',E'Für {name} ein neues Passwort erzwingen');
INSERT INTO "message" VALUES (572,E'de-DE',E'Abbrechen');
INSERT INTO "message" VALUES (573,E'de-DE',E'Suche nach einem Turnier ...');
INSERT INTO "message" VALUES (574,E'de-DE',E'Neues Passwort festlegen');
INSERT INTO "message" VALUES (575,E'de-DE',E'BenutzerIn aktualisieren');
INSERT INTO "message" VALUES (576,E'de-DE',E'BenutzerIn löschen');
INSERT INTO "message" VALUES (577,E'de-DE',E'BenutzerIn erstellen');
INSERT INTO "message" VALUES (578,E'de-DE',E'Keine zutreffende Bedingung');
INSERT INTO "message" VALUES (579,E'de-DE',E'Jury bestand Überprüfung nicht. Alt: {old} / Neu: {new}');
INSERT INTO "message" VALUES (580,E'de-DE',E'Kann {object} nicht speichern! Fehler: {message}');
INSERT INTO "message" VALUES (582,E'de-DE',E'Keine Datei verfügbar');
INSERT INTO "message" VALUES (583,E'de-DE',E'Keine passenden Einträge gefunden');
INSERT INTO "message" VALUES (584,E'de-DE',E'Vielen Dank für deine Eingabe.');
INSERT INTO "message" VALUES (585,E'de-DE',E'Fehler beim Speichern der Jury:');
INSERT INTO "message" VALUES (586,E'de-DE',E'Jury gelöscht');
INSERT INTO "message" VALUES (587,E'de-DE',E'Willkommen! Dies ist das erste Mal, dass du dich anmeldest. Bitte stelle sicher, dass all deine Informationen zutreffen.');
INSERT INTO "message" VALUES (588,E'de-DE',E'Ein neuer Verein wurde gespeichert');
INSERT INTO "message" VALUES (589,E'de-DE',E'Beim Entgegennehmen deiner vorherigen Eingabe ist ein Fehler aufgetreten. Bitte versuche es noch einmal.');
INSERT INTO "message" VALUES (590,E'de-DE',E'BenutzerIn registriert! Willkommen, {user}!');
INSERT INTO "message" VALUES (591,E'de-DE',E'Anmeldung fehlgeschlagen');
INSERT INTO "message" VALUES (592,E'de-DE',E'Bitte überprüfe für weitere Anweisungen deine Emails.');
INSERT INTO "message" VALUES (593,E'de-DE',E'Bitte entschuldige - für die angegebene Email-Adresse können wir kein Passwort zurücksetzen.<br>{message}');
INSERT INTO "message" VALUES (594,E'de-DE',E'Das neue Passwort wurde gespeichert.');
INSERT INTO "message" VALUES (595,E'de-DE',E'Neues Passwort festgelegt.');
INSERT INTO "message" VALUES (596,E'de-DE',E'Fehler beim Speichern des neuen Passworts.');
INSERT INTO "message" VALUES (597,E'de-DE',E'Verknüpfung mit Verein nicht gespeichert');
INSERT INTO "message" VALUES (598,E'de-DE',E'BenutzerIn erfolgreich gespeichert');
INSERT INTO "message" VALUES (599,E'de-DE',E'BenutzerIn nicht gespeichert!');
INSERT INTO "message" VALUES (600,E'de-DE',E'Verbindung zu Verein nicht gespeichert!');
INSERT INTO "message" VALUES (601,E'de-DE',E'BenutzerIn erfolgreich aktualisiert!');
INSERT INTO "message" VALUES (602,E'de-DE',E'Bitte gib ein neues Passwort ein!');
INSERT INTO "message" VALUES (603,E'de-DE',E'BenutzerIn gelöscht');
INSERT INTO "message" VALUES (604,E'de-DE',E'Kann aufgrund von {error} nicht gelöscht werden.');
INSERT INTO "message" VALUES (605,E'de-DE',E'Konnte nicht gelöscht werden, da bereits in Gebrauch.<br> {ex}');
INSERT INTO "message" VALUES (606,E'de-DE',E'Checking Flags zurücksetzen');
INSERT INTO "message" VALUES (607,E'de-DE',E'Es gab keinen Bedarf zurückzusetzen.');
INSERT INTO "message" VALUES (608,E'de-DE',E'Bitte lege erst die breakenden JurorInnen fest - benutze hierfür das Sternensymbol in der Aktionsspalte.');
INSERT INTO "message" VALUES (609,E'de-DE',E'Konnte Team nicht erstellen.');
INSERT INTO "message" VALUES (610,E'de-DE',E'Fehler beim Speichern des Vereinsverhältnisses für {society}.');
INSERT INTO "message" VALUES (611,E'de-DE',E'Fehler beim Speichern von Team {name}!');
INSERT INTO "message" VALUES (613,E'de-DE',E'Kann Turnierverknüpfung nicht speichern.');
INSERT INTO "message" VALUES (614,E'de-DE',E'Kann Frage nicht löschen.');
INSERT INTO "message" VALUES (615,E'de-DE',E'Vereinsverknüpfung wurde erfolgreich erstellt');
INSERT INTO "message" VALUES (616,E'de-DE',E'Verein konnte nicht gespeichert werden');
INSERT INTO "message" VALUES (617,E'de-DE',E'Fehler beim wakeup');
INSERT INTO "message" VALUES (618,E'de-DE',E'Vereinsinformationen aktualisiert');
INSERT INTO "message" VALUES (619,E'de-DE',E'Das Tab ist veröffentlicht, das Turnier geschlossen. Auf zu einem Drink!');
INSERT INTO "message" VALUES (620,E'de-DE',E'Kein/e HauptjurorIn im Panel gefunden - falscher Typ?');
INSERT INTO "message" VALUES (622,E'de-DE',E'Kein gültiger Typ');
INSERT INTO "message" VALUES (623,E'de-DE',E'{object} erfolgreich eingegeben');
INSERT INTO "message" VALUES (624,E'de-DE',E'{object} erstellt');
INSERT INTO "message" VALUES (625,E'de-DE',E'Individueller Konflikt');
INSERT INTO "message" VALUES (626,E'de-DE',E'Individueller Konflikt konnte nicht gespeichert werden');
INSERT INTO "message" VALUES (627,E'de-DE',E'{object} aktualisiert');
INSERT INTO "message" VALUES (628,E'de-DE',E'{object} konnte nicht gespeichert werden');
INSERT INTO "message" VALUES (629,E'de-DE',E'{object} gelöscht');
INSERT INTO "message" VALUES (630,E'de-DE',E'{tournament} auf Tabbie2');
INSERT INTO "message" VALUES (631,E'de-DE',E'{tournament} findet vom {start} bis zum {end} statt und wird ausgetragen von {host} in {country}.');
INSERT INTO "message" VALUES (632,E'de-DE',E'Turnier erfolgreich erstellt');
INSERT INTO "message" VALUES (633,E'de-DE',E'Turnier wurde erstellt doch die Energie-Konfiguration schluf fehl!');
INSERT INTO "message" VALUES (634,E'de-DE',E'Kann Turnier nicht speichern!');
INSERT INTO "message" VALUES (635,E'de-DE',E'DebReg Synchronisation erfolgreich');
INSERT INTO "message" VALUES (636,E'de-DE',E'Räume getauscht');
INSERT INTO "message" VALUES (637,E'de-DE',E'Fehler beim Wechseln');
INSERT INTO "message" VALUES (638,E'de-DE',E'Neue Räume festgelegt');
INSERT INTO "message" VALUES (639,E'de-DE',E'Fehler beim Festlegen eines neuen Raumes');
INSERT INTO "message" VALUES (640,E'de-DE',E'Kann Runde nicht erstellen: Anzahl der Teams ist nicht durch 4 teilbar');
INSERT INTO "message" VALUES (641,E'de-DE',E'Erfolgreich neu gesetzt in {secs}s');
INSERT INTO "message" VALUES (642,E'de-DE',E'Energie in {secs}s um {diff} Punkte verbessert');
INSERT INTO "message" VALUES (643,E'de-DE',E'JurorIn {n1} und {n2} getauscht');
INSERT INTO "message" VALUES (644,E'de-DE',E'Konnte nicht tauschen, da: {a_panel}<br>und<br>{b_panel}');
INSERT INTO "message" VALUES (645,E'de-DE',E'Zeige Runde {number}');
INSERT INTO "message" VALUES (646,E'de-DE',E'Für diesen Raum konnten keine Debatten gefunden werden');
INSERT INTO "message" VALUES (647,E'de-DE',E'Diese Spracheinstellung ist ungültig.');
INSERT INTO "message" VALUES (648,E'de-DE',E'Team zu {status} aufgewertet');
INSERT INTO "message" VALUES (649,E'de-DE',E'Spracheinstellungen gespeichert');
INSERT INTO "message" VALUES (650,E'de-DE',E'Fehler beim Speichern der Spracheinstellungen');
INSERT INTO "message" VALUES (651,E'de-DE',E'BenutzerIn nicht gefunden!');
INSERT INTO "message" VALUES (652,E'de-DE',E'{object} erfolgreich hinzugefügt');
INSERT INTO "message" VALUES (653,E'de-DE',E'Löschen erfolgreich');
INSERT INTO "message" VALUES (654,E'de-DE',E'Die Syntax der Datei ist falsch! Erwartet werden 3 Spalten.');
INSERT INTO "message" VALUES (656,E'de-DE',E'Fehler beim Speichern der Ergebnisse.<br>Bitte frage einen Laufzettel aus Papier an!');
INSERT INTO "message" VALUES (657,E'de-DE',E'Ergebnis gespeichert. Auf zum Nächsten!');
INSERT INTO "message" VALUES (658,E'de-DE',E'Debatte #{id} existiert nicht');
INSERT INTO "message" VALUES (659,E'de-DE',E'Korrigiere die Teampunkte des Teams {team} von {old_points} auf {new_points}');
INSERT INTO "message" VALUES (660,E'de-DE',E'Korrigiere die RednerInnenpunkte von RednerIn {pos} des Teams {team} von {old_points} auf {new_points}');
INSERT INTO "message" VALUES (661,E'de-DE',E'Cache ist in Bestform. Keine Veränderungen nötig!');
INSERT INTO "message" VALUES (662,E'de-DE',E'Kann Entscheidung zum Konflikt nicht speichern. {reason}');
INSERT INTO "message" VALUES (663,E'de-DE',E'Nicht genügend Räume');
INSERT INTO "message" VALUES (664,E'de-DE',E'Zu viele Räume');
INSERT INTO "message" VALUES (665,E'de-DE',E'Maximiere Wiederholungen zum Verbessern der JurorInnenzuweisung');
INSERT INTO "message" VALUES (666,E'de-DE',E'Strafwert für Teams und JurorInnen aus gleichen Vereinen');
INSERT INTO "message" VALUES (667,E'de-DE',E'Beide JurorInnen sind im Konflikt');
INSERT INTO "message" VALUES (668,E'de-DE',E'Team ist mit JurorIn im Konflikt.');
INSERT INTO "message" VALUES (669,E'de-DE',E'JurorIn darf nicht hauptjurieren.');
INSERT INTO "message" VALUES (670,E'de-DE',E'HauptjurorIn ist für die aktuelle Situation suboptimal.');
INSERT INTO "message" VALUES (671,E'de-DE',E'JuroIn hat das Team bereits gesehen.');
INSERT INTO "message" VALUES (672,E'de-DE',E'JurorIn hat bereits in dieser Konstellation juriert.');
INSERT INTO "message" VALUES (673,E'de-DE',E'Die Jury hat eine dem Raum unangemessene Stärke.');
INSERT INTO "message" VALUES (674,E'de-DE',E'Richards Geheimzutat');
INSERT INTO "message" VALUES (675,E'de-DE',E'JurorIn {adju} und {team} in gleichem Verein.');
INSERT INTO "message" VALUES (676,E'de-DE',E'Die JurorInnen {adju1} und {adju2} stehen manuell im Konflikt.');
INSERT INTO "message" VALUES (677,E'de-DE',E'JurorIn {adju} und Team {team} stehen manuell im Konflikt.');
INSERT INTO "message" VALUES (678,E'de-DE',E'JurorIn {adju} wurde als Nicht-HauptjurorIn markiert.');
INSERT INTO "message" VALUES (679,E'de-DE',E'HauptjurorIn ist um {points} suboptimal.');
INSERT INTO "message" VALUES (680,E'de-DE',E'Die JurorInnen {adju1} und {adju2} haben zuvor x{occ} gemeinsam juriert.');
INSERT INTO "message" VALUES (681,E'de-DE',E'JurorIn {adju} hat das Team {team} zuvor x {occ} juriert.');
INSERT INTO "message" VALUES (682,E'de-DE',E'Steilheits-Vergleich: {comparison_factor}, Differenz: {roomDifference}, Steilheits-Strafe: {steepnessPenalty}');
INSERT INTO "message" VALUES (686,E'de-DE',E'Unbestimmt');
INSERT INTO "message" VALUES (687,E'de-DE',E'Nordeuropa');
INSERT INTO "message" VALUES (688,E'de-DE',E'Westeuropa');
INSERT INTO "message" VALUES (689,E'de-DE',E'Südeuropa');
INSERT INTO "message" VALUES (690,E'de-DE',E'Osteuropa');
INSERT INTO "message" VALUES (691,E'de-DE',E'Zentralasien');
INSERT INTO "message" VALUES (692,E'de-DE',E'Ostasien');
INSERT INTO "message" VALUES (693,E'de-DE',E'Westasien');
INSERT INTO "message" VALUES (694,E'de-DE',E'Südasien');
INSERT INTO "message" VALUES (695,E'de-DE',E'Süd-Ostasien');
INSERT INTO "message" VALUES (696,E'de-DE',E'Australien & Neuseeland');
INSERT INTO "message" VALUES (697,E'de-DE',E'Mikronesien');
INSERT INTO "message" VALUES (698,E'de-DE',E'Melanesien');
INSERT INTO "message" VALUES (699,E'de-DE',E'Polynesien');
INSERT INTO "message" VALUES (700,E'de-DE',E'Nordafrika');
INSERT INTO "message" VALUES (701,E'de-DE',E'Westafrika');
INSERT INTO "message" VALUES (702,E'de-DE',E'Zentralafrika');
INSERT INTO "message" VALUES (703,E'de-DE',E'Ostafrika');
INSERT INTO "message" VALUES (704,E'de-DE',E'Südafrika');
INSERT INTO "message" VALUES (705,E'de-DE',E'Nordamerika');
INSERT INTO "message" VALUES (706,E'de-DE',E'Mittelamerika');
INSERT INTO "message" VALUES (707,E'de-DE',E'Karibik');
INSERT INTO "message" VALUES (708,E'de-DE',E'Südamerika');
INSERT INTO "message" VALUES (709,E'de-DE',E'Antarktis');
INSERT INTO "message" VALUES (710,E'de-DE',E'Bestrafte/r JurorIn');
INSERT INTO "message" VALUES (711,E'de-DE',E'Schlechte/r JurorIn');
INSERT INTO "message" VALUES (712,E'de-DE',E'Ordentliche/r JurorIn');
INSERT INTO "message" VALUES (713,E'de-DE',E'Durchschnittliche/r JurorIn');
INSERT INTO "message" VALUES (714,E'de-DE',E'Durchschnittliche/r HauptjurorIn');
INSERT INTO "message" VALUES (715,E'de-DE',E'Gute/r HauptjurorIn');
INSERT INTO "message" VALUES (716,E'de-DE',E'Breakende/r HauptjurorIn');
INSERT INTO "message" VALUES (717,E'de-DE',E'<b>Dieses Turnier hat noch keine Teams.</b><br>{add_button} oder {import_button}');
INSERT INTO "message" VALUES (718,E'de-DE',E'Ein Team hinzufügen');
INSERT INTO "message" VALUES (719,E'de-DE',E'Importiere sie als CSV-Datei');
INSERT INTO "message" VALUES (720,E'de-DE',E'<b>Dieses Turnier hat noch keine Räume.</b><br>{add} oder {import}');
INSERT INTO "message" VALUES (721,E'de-DE',E'Einen Raum hinzufügen');
INSERT INTO "message" VALUES (722,E'de-DE',E'Importiere sie als CSV-Datei');
INSERT INTO "message" VALUES (723,E'de-DE',E'<b>Diese Turnier hat keine Juroren.</b><br>{add_button} oder {import_button}');
INSERT INTO "message" VALUES (724,E'de-DE',E'Importiere sie als CSV-Datei');
INSERT INTO "message" VALUES (725,E'de-DE',E'Für diese Runde wurden bereits Ergebnisse eingetragen. Neusetzung nicht möglich!');
INSERT INTO "message" VALUES (726,E'de-DE',E'Für diese Runde wurden bereits Ergebnisse eingetragen. Verbessern nicht möglich!');
INSERT INTO "message" VALUES (727,E'de-DE',E'Feedback #{num}');
INSERT INTO "message" VALUES (728,E'de-DE',E'BenutzerIn ID');
INSERT INTO "message" VALUES (729,E'de-DE',E'Sprach-VerwalterIn');
INSERT INTO "message" VALUES (730,E'de-DE',E'Sprach-VerwalterIn');
INSERT INTO "message" VALUES (731,E'de-DE',E'Sprach-VerwalterIn erstellen');
INSERT INTO "message" VALUES (732,E'de-DE',E'EFL-Ranking anzeigen');
INSERT INTO "message" VALUES (733,E'de-DE',E'EinsteigerInnen-Ranking anzeigen');
INSERT INTO "message" VALUES (734,E'de-DE',E'Englisch als gemeisterte Sprache');
INSERT INTO "message" VALUES (735,E'de-DE',E'EIN');
INSERT INTO "message" VALUES (736,E'de-DE',E'EinsteigerIn festlegen');
INSERT INTO "message" VALUES (737,E'de-DE',E'ENL');
INSERT INTO "message" VALUES (738,E'de-DE',E'Neue Sprache erstellen');
INSERT INTO "message" VALUES (739,E'de-DE',E'Setzung als JSON exportieren');
INSERT INTO "message" VALUES (740,E'de-DE',E'Das Team {name} kann nicht gelöscht werden, da es bereits in Gebrauch ist.');
INSERT INTO "message" VALUES (741,E'de-DE',E'Der/die JurorIn {name} kann nicht gelöscht werden, da er/sie bereits verwendet wird.');
INSERT INTO "message" VALUES (742,E'de-DE',E'Der Raum {name} kann nicht gelöscht werden, da er bereits verwendet wird.');
INSERT INTO "message" VALUES (743,E'de-DE',E'Gib in 3-4 allgemeinen Stichworten an, um was es im Thema geht. Falls bereits passende Stichworte existieren, verwende bitte diese!');
INSERT INTO "message" VALUES (744,E'de-DE',E'Fehler beim Speichern des benutzerdefinierten Attributs: {name}');
INSERT INTO "message" VALUES (745,E'de-DE',E'Fehler beim Speichern des benutzerdefinierten Werts \'{key}\': {value}');
INSERT INTO "message" VALUES (746,E'de-DE',E'BenutzerIn Attr ID');
INSERT INTO "message" VALUES (747,E'de-DE',E'Turnier ID');
INSERT INTO "message" VALUES (748,E'de-DE',E'Benötigt');
INSERT INTO "message" VALUES (749,E'de-DE',E'Hilfe');
INSERT INTO "message" VALUES (750,E'de-DE',E'Benutzerdefinierte Werte für {tournament}');
INSERT INTO "message" VALUES (751,E'de-DE',E'Die Syntax der Datei passt nicht. Es werden mindestens 5 Spalten benötigt.');
INSERT INTO "message" VALUES (753,E'de-DE',E'Jurierlehrling');
INSERT INTO "message" VALUES (754,E'de-DE',E'Importiere {modelClass} #{number}');
INSERT INTO "message" VALUES (755,E'de-DE',E'Veröffentliche bestätigte Setzung');
INSERT INTO "message" VALUES (756,E'de-DE',E'Importiere Setzung aus JSON');
INSERT INTO "message" VALUES (757,E'de-DE',E'Dies wird die aktuelle Setzung überschreiben! Alle Informationen gehen dabei verloren\r\n!');
INSERT INTO "message" VALUES (758,E'de-DE',E'Runde neu setzen');
INSERT INTO "message" VALUES (759,E'de-DE',E'Runde löschen');
INSERT INTO "message" VALUES (760,E'de-DE',E'Bist du sicher, dass du die Runde LÖSCHEN willst? Alle Informationen gehen dabei verloren!');
INSERT INTO "message" VALUES (761,E'de-DE',E'Die Runde ist bereits aktiv! Überschreiben mit der Eingabe ist nicht möglich.');
INSERT INTO "message" VALUES (762,E'de-DE',E'Die hochgeladene Datei war leer. Bitte wähle eine andere Datei.');
INSERT INTO "message" VALUES (764,E'de-DE',E'RednerInnen');
INSERT INTO "message" VALUES (765,E'de-DE',E'Die Syntax der Datei ist falsch! Mindestens {min} Spalten werden benötigt; {num} vorhanden in Zeile {line}');
INSERT INTO "message" VALUES (766,E'de-DE',E'Fragetext');
INSERT INTO "message" VALUES (767,E'de-DE',E'Hilfstext');
INSERT INTO "message" VALUES (770,E'de-DE',E'Konflikte von JurorInnen mit JurorInnen');
INSERT INTO "message" VALUES (771,E'de-DE',E'Alle zulassen');
INSERT INTO "message" VALUES (772,E'de-DE',E'Alle verweigern');
INSERT INTO "message" VALUES (773,E'de-DE',E'Konflikte von Teams mit JurorInnen');
INSERT INTO "message" VALUES (774,E'de-DE',E'Keine gültige Entscheidung');
INSERT INTO "message" VALUES (775,E'de-DE',E'Importiere Wertung für {modelClass}');
INSERT INTO "message" VALUES (777,E'de-DE',E'Öffentlich zugängliche URLs');
INSERT INTO "message" VALUES (778,E'de-DE',E'Debatte nicht gefunden - falscher Typ?');
INSERT INTO "message" VALUES (783,E'de-DE',E'Themenausgeglichenheit');
INSERT INTO "message" VALUES (784,E'de-DE',E'Rundeninformation');
INSERT INTO "message" VALUES (785,E'de-DE',E'Es gibt derzeit keine aktive Runde. Lade diese Seite später noch einmal neu.');
INSERT INTO "message" VALUES (787,E'de-DE',E'Teilgedoppeltes Achtelfinale');
INSERT INTO "message" VALUES (788,E'de-DE',E'Ersetze JurorIn {adjudicator} durch');
INSERT INTO "message" VALUES (789,E'de-DE',E'Ersetze');
INSERT INTO "message" VALUES (790,E'de-DE',E'Ansehen');
INSERT INTO "message" VALUES (791,E'de-DE',E'Tausche Team {team} mit');
INSERT INTO "message" VALUES (792,E'de-DE',E'Versuche Setzung erneut');
INSERT INTO "message" VALUES (793,E'de-DE',E'AVG');
INSERT INTO "message" VALUES (794,E'de-DE',NULL);
INSERT INTO "message" VALUES (795,E'de-DE',NULL);
INSERT INTO "message" VALUES (796,E'de-DE',NULL);
INSERT INTO "message" VALUES (1,E'es-CO',E'ID');
INSERT INTO "message" VALUES (2,E'es-CO',E'Nombre');
INSERT INTO "message" VALUES (3,E'es-CO',E'Importar {modelClass}');
INSERT INTO "message" VALUES (4,E'es-CO',E'Importar');
INSERT INTO "message" VALUES (5,E'es-CO',E'Sociedades de Debate');
INSERT INTO "message" VALUES (6,E'es-CO',E'Actualizar');
INSERT INTO "message" VALUES (7,E'es-CO',E'Eliminar');
INSERT INTO "message" VALUES (8,E'es-CO',E'¿Estás seguro de que quieres eliminar este elemento?');
INSERT INTO "message" VALUES (9,E'es-CO',E'Actualizar {modelClass}:');
INSERT INTO "message" VALUES (10,E'es-CO',E'Fusionar las sociedades \'{society}\' en ...');
INSERT INTO "message" VALUES (11,E'es-CO',E'Selecciones la Sociedad de Debate principal');
INSERT INTO "message" VALUES (12,E'es-CO',E'Crear {modelClass}');
INSERT INTO "message" VALUES (13,E'es-CO',E'Ver {modelClass}');
INSERT INTO "message" VALUES (14,E'es-CO',E'Actualizar {modelClass}');
INSERT INTO "message" VALUES (15,E'es-CO',E'Eliminar {modelClass}');
INSERT INTO "message" VALUES (16,E'es-CO',E'Agregar nuevo elemento');
INSERT INTO "message" VALUES (17,E'es-CO',E'Volver a cargar contenido');
INSERT INTO "message" VALUES (18,E'es-CO',E'Importar archivo EXL');
INSERT INTO "message" VALUES (19,E'es-CO',E'Crear');
INSERT INTO "message" VALUES (20,E'es-CO',E'Idiomas');
INSERT INTO "message" VALUES (21,E'es-CO',E'Crear idioma');
INSERT INTO "message" VALUES (22,E'es-CO',E'Necesidades especiales');
INSERT INTO "message" VALUES (23,E'es-CO',E'Etiquetas de la moción');
INSERT INTO "message" VALUES (24,E'es-CO',E'Fusionar la etiqueta \'{tag}\' de la moción a');
INSERT INTO "message" VALUES (25,E'es-CO',E'Seleccione la etiqueta principal');
INSERT INTO "message" VALUES (26,E'es-CO',E'Buscar');
INSERT INTO "message" VALUES (27,E'es-CO',E'Reiniciar');
INSERT INTO "message" VALUES (28,E'es-CO',E'Crear etiqueta para la moción');
INSERT INTO "message" VALUES (29,E'es-CO',E'API');
INSERT INTO "message" VALUES (30,E'es-CO',E'Master');
INSERT INTO "message" VALUES (31,E'es-CO',E'Mensajes');
INSERT INTO "message" VALUES (32,E'es-CO',E'Crear mensaje');
INSERT INTO "message" VALUES (33,E'es-CO',E'{count} Cambiar etiquetas');
INSERT INTO "message" VALUES (34,E'es-CO',E'Error de archivo');
INSERT INTO "message" VALUES (35,E'es-CO',E'Etiqueta de la moción');
INSERT INTO "message" VALUES (36,E'es-CO',E'Ronda');
INSERT INTO "message" VALUES (37,E'es-CO',E'Abreviación');
INSERT INTO "message" VALUES (38,E'es-CO',E'Puntaje');
INSERT INTO "message" VALUES (39,E'es-CO',E'Cámara alta de Gobierno');
INSERT INTO "message" VALUES (40,E'es-CO',E'Cámara alta de Oposición');
INSERT INTO "message" VALUES (41,E'es-CO',E'Cámara baja de Gobierno');
INSERT INTO "message" VALUES (42,E'es-CO',E'Cámara baja de Oposición');
INSERT INTO "message" VALUES (43,E'es-CO',E'Equipo');
INSERT INTO "message" VALUES (44,E'es-CO',E'Activo');
INSERT INTO "message" VALUES (45,E'es-CO',E'Torneo');
INSERT INTO "message" VALUES (46,E'es-CO',E'Orador');
INSERT INTO "message" VALUES (47,E'es-CO',E'Sociedad de Debate');
INSERT INTO "message" VALUES (48,E'es-CO',E'Swing Team');
INSERT INTO "message" VALUES (49,E'es-CO',E'Estatus por idioma');
INSERT INTO "message" VALUES (50,E'es-CO',E'Todo normal');
INSERT INTO "message" VALUES (51,E'es-CO',E'Fue remplazado por equipo swing');
INSERT INTO "message" VALUES (52,E'es-CO',E'Orador {letra} no se presentó');
INSERT INTO "message" VALUES (53,E'es-CO',E'Llave');
INSERT INTO "message" VALUES (54,E'es-CO',E'Etiqueta');
INSERT INTO "message" VALUES (55,E'es-CO',E'Valor');
INSERT INTO "message" VALUES (56,E'es-CO',E'La posición del equipo no puede estar en blanco');
INSERT INTO "message" VALUES (57,E'es-CO',E'Fuera de ronda');
INSERT INTO "message" VALUES (58,E'es-CO',E'Usuario del Tabulador');
INSERT INTO "message" VALUES (59,E'es-CO',E'Usuario');
INSERT INTO "message" VALUES (60,E'es-CO',E'ENL Posición');
INSERT INTO "message" VALUES (61,E'es-CO',E'ESL Posición');
INSERT INTO "message" VALUES (62,E'es-CO',E'Resultados caché');
INSERT INTO "message" VALUES (63,E'es-CO',E'Nombre Completo');
INSERT INTO "message" VALUES (64,E'es-CO',E'Abreviación');
INSERT INTO "message" VALUES (65,E'es-CO',E'Ciudad');
INSERT INTO "message" VALUES (66,E'es-CO',E'País');
INSERT INTO "message" VALUES (67,E'es-CO',E'Primer Gobierno');
INSERT INTO "message" VALUES (68,E'es-CO',E'Primera Oposición');
INSERT INTO "message" VALUES (69,E'es-CO',E'Segundo Gobierno');
INSERT INTO "message" VALUES (70,E'es-CO',E'Segunda Oposición');
INSERT INTO "message" VALUES (71,E'es-CO',E'Panel');
INSERT INTO "message" VALUES (72,E'es-CO',E'Lugar');
INSERT INTO "message" VALUES (73,E'es-CO',E'Retroalimentación\r\n CAG');
INSERT INTO "message" VALUES (74,E'es-CO',E'Retroalimentación CAO');
INSERT INTO "message" VALUES (75,E'es-CO',E'Retroalimentación CBG');
INSERT INTO "message" VALUES (76,E'es-CO',E'Retroalimentación CBO');
INSERT INTO "message" VALUES (77,E'es-CO',E'Hora');
INSERT INTO "message" VALUES (78,E'es-CO',E'Moción');
INSERT INTO "message" VALUES (79,E'es-CO',E'Idioma');
INSERT INTO "message" VALUES (80,E'es-CO',E'Fecha');
INSERT INTO "message" VALUES (81,E'es-CO',E'Diapositiva de información');
INSERT INTO "message" VALUES (82,E'es-CO',E'Enlace');
INSERT INTO "message" VALUES (83,E'es-CO',E'Por Usuario');
INSERT INTO "message" VALUES (84,E'es-CO',E'Traducción');
INSERT INTO "message" VALUES (85,E'es-CO',E'Adjudicador');
INSERT INTO "message" VALUES (86,E'es-CO',E'Respuesta');
INSERT INTO "message" VALUES (87,E'es-CO',E'Retroalimentación');
INSERT INTO "message" VALUES (88,E'es-CO',E'Pregunta');
INSERT INTO "message" VALUES (89,E'es-CO',E'Creado');
INSERT INTO "message" VALUES (90,E'es-CO',E'En marcha');
INSERT INTO "message" VALUES (91,E'es-CO',E'Cerrado');
INSERT INTO "message" VALUES (92,E'es-CO',E'Oculto');
INSERT INTO "message" VALUES (93,E'es-CO',E'Organizado por');
INSERT INTO "message" VALUES (94,E'es-CO',E'Nombre del torneo');
INSERT INTO "message" VALUES (95,E'es-CO',E'Fecha de inicio');
INSERT INTO "message" VALUES (96,E'es-CO',E'Fecha de finalización');
INSERT INTO "message" VALUES (97,E'es-CO',E'Zona horaria');
INSERT INTO "message" VALUES (98,E'es-CO',E'Logo');
INSERT INTO "message" VALUES (99,E'es-CO',E'URL Adjunta');
INSERT INTO "message" VALUES (100,E'es-CO',E'Algoritmo de tabulación');
INSERT INTO "message" VALUES (101,E'es-CO',E'Número estimado de rondas');
INSERT INTO "message" VALUES (102,E'es-CO',E'Mostrar ranking ESL');
INSERT INTO "message" VALUES (103,E'es-CO',E'¿Hay una gran final?');
INSERT INTO "message" VALUES (104,E'es-CO',E'¿Hay semifinales?');
INSERT INTO "message" VALUES (105,E'es-CO',E'¿Hay cuartos de final?');
INSERT INTO "message" VALUES (106,E'es-CO',E'¿Hay octavos de final?');
INSERT INTO "message" VALUES (107,E'es-CO',E'Símbolo de acceso');
INSERT INTO "message" VALUES (108,E'es-CO',E'Insignia del participante');
INSERT INTO "message" VALUES (109,E'es-CO',E'Alfa 2');
INSERT INTO "message" VALUES (110,E'es-CO',E'Alfa 3');
INSERT INTO "message" VALUES (111,E'es-CO',E'Región');
INSERT INTO "message" VALUES (112,E'es-CO',E'Código de lenguaje');
INSERT INTO "message" VALUES (113,E'es-CO',E'Covertura');
INSERT INTO "message" VALUES (114,E'es-CO',E'Última actualización');
INSERT INTO "message" VALUES (115,E'es-CO',E'Fuerza');
INSERT INTO "message" VALUES (116,E'es-CO',E'Puede ser juez principal');
INSERT INTO "message" VALUES (117,E'es-CO',E'está observando');
INSERT INTO "message" VALUES (118,E'es-CO',E'Sin clasificar');
INSERT INTO "message" VALUES (121,E'es-CO',E'Puede juzgar');
INSERT INTO "message" VALUES (122,E'es-CO',E'Decente');
INSERT INTO "message" VALUES (124,E'es-CO',E'Gran potencial');
INSERT INTO "message" VALUES (125,E'es-CO',E'Juez principal');
INSERT INTO "message" VALUES (126,E'es-CO',E'Bueno');
INSERT INTO "message" VALUES (127,E'es-CO',E'Breaking');
INSERT INTO "message" VALUES (128,E'es-CO',E'Jefe de adjudicación');
INSERT INTO "message" VALUES (129,E'es-CO',E'Empezando');
INSERT INTO "message" VALUES (130,E'es-CO',E'Finalizando');
INSERT INTO "message" VALUES (131,E'es-CO',E'Puntos de orador');
INSERT INTO "message" VALUES (132,E'es-CO',E'Esta dirección de correo ya está en uso');
INSERT INTO "message" VALUES (133,E'es-CO',E'Debatiente');
INSERT INTO "message" VALUES (134,E'es-CO',E'Clave de autenticación');
INSERT INTO "message" VALUES (135,E'es-CO',E'Contraseña');
INSERT INTO "message" VALUES (136,E'es-CO',E'Restablecer contraseña');
INSERT INTO "message" VALUES (137,E'es-CO',E'Correo electrónico');
INSERT INTO "message" VALUES (138,E'es-CO',E'Rol de la cuenta');
INSERT INTO "message" VALUES (139,E'es-CO',E'Estado de la cuenta');
INSERT INTO "message" VALUES (140,E'es-CO',E'Último cambio');
INSERT INTO "message" VALUES (141,E'es-CO',E'Nombre');
INSERT INTO "message" VALUES (142,E'es-CO',E'Apellido');
INSERT INTO "message" VALUES (143,E'es-CO',E'Imagen de perfil');
INSERT INTO "message" VALUES (144,E'es-CO',E'Lugar de ubicación');
INSERT INTO "message" VALUES (145,E'es-CO',E'Tabulador');
INSERT INTO "message" VALUES (146,E'es-CO',E'Administrador');
INSERT INTO "message" VALUES (147,E'es-CO',E'Eliminado');
INSERT INTO "message" VALUES (148,E'es-CO',E'No revelar');
INSERT INTO "message" VALUES (149,E'es-CO',E'Femenino');
INSERT INTO "message" VALUES (150,E'es-CO',E'Masculino');
INSERT INTO "message" VALUES (151,E'es-CO',E'Otro');
INSERT INTO "message" VALUES (152,E'es-CO',E'mezclado');
INSERT INTO "message" VALUES (153,E'es-CO',E'Sin definir');
INSERT INTO "message" VALUES (154,E'es-CO',E'Entrevista necesaria');
INSERT INTO "message" VALUES (155,E'es-CO',E'EPL');
INSERT INTO "message" VALUES (157,E'es-CO',E'ESL');
INSERT INTO "message" VALUES (158,E'es-CO',E'Español como segunda lengua');
INSERT INTO "message" VALUES (159,E'es-CO',E'ELE');
INSERT INTO "message" VALUES (160,E'es-CO',E'Español como lengua extranjera');
INSERT INTO "message" VALUES (161,E'es-CO',E'Sin asignar');
INSERT INTO "message" VALUES (162,E'es-CO',E'Error guardando Relación con la sociedad para {user_name}');
INSERT INTO "message" VALUES (163,E'es-CO',E'Error guardando usuario {user_name}');
INSERT INTO "message" VALUES (164,E'es-CO',E'{tournament_name}: Cuenta de usuario para  {user_name}');
INSERT INTO "message" VALUES (165,E'es-CO',E'Esta dirección no está permitida');
INSERT INTO "message" VALUES (166,E'es-CO',E'Publicado');
INSERT INTO "message" VALUES (167,E'es-CO',E'Visualizado');
INSERT INTO "message" VALUES (168,E'es-CO',E'Iniciado');
INSERT INTO "message" VALUES (169,E'es-CO',E'Juzgando');
INSERT INTO "message" VALUES (170,E'es-CO',E'Finalizado');
INSERT INTO "message" VALUES (171,E'es-CO',E'Principal');
INSERT INTO "message" VALUES (172,E'es-CO',E'Principiante');
INSERT INTO "message" VALUES (173,E'es-CO',E'Final');
INSERT INTO "message" VALUES (174,E'es-CO',E'Semifinal');
INSERT INTO "message" VALUES (175,E'es-CO',E'Cuartos de final');
INSERT INTO "message" VALUES (176,E'es-CO',E'Octavos de final');
INSERT INTO "message" VALUES (177,E'es-CO',E'Ronda #{num}');
INSERT INTO "message" VALUES (178,E'es-CO',E'En ronda');
INSERT INTO "message" VALUES (179,E'es-CO',E'Energía');
INSERT INTO "message" VALUES (180,E'es-CO',E'Diapositiva de información');
INSERT INTO "message" VALUES (181,E'es-CO',E'Empieza el tiempo de preparación');
INSERT INTO "message" VALUES (182,E'es-CO',E'Última temperatura');
INSERT INTO "message" VALUES (183,E'es-CO',E'ms a calcular');
INSERT INTO "message" VALUES (184,E'es-CO',E'No hay suficientes equipos para completar la sala - (active: {teams_count})');
INSERT INTO "message" VALUES (185,E'es-CO',E'Al menos dos jueces son necesarios - (active: {count_adju})');
INSERT INTO "message" VALUES (186,E'es-CO',E'El número de equipos activos debe dividirse entre 4 ;) - (active: {count_teams})');
INSERT INTO "message" VALUES (187,E'es-CO',E'No hay suficientes salas activas (active: {active_rooms} required: {required})');
INSERT INTO "message" VALUES (188,E'es-CO',E'No hay suficientes jueces (active: {active} min-required: {required})');
INSERT INTO "message" VALUES (189,E'es-CO',E'No hay jueces libres suficientes con esta configuración preseleccionada de panel (fillable rooms: {active} min-required: {required})');
INSERT INTO "message" VALUES (190,E'es-CO',E'No se puede guardar el panel! Error {message}');
INSERT INTO "message" VALUES (191,E'es-CO',E'No se puede guardar el debate! Error {message}');
INSERT INTO "message" VALUES (192,E'es-CO',E'No se puede guardar el debate! Errores <br>{errors}');
INSERT INTO "message" VALUES (193,E'es-CO',E'No se encuentra el debate #{num} para actualizar');
INSERT INTO "message" VALUES (195,E'es-CO',E'Tipo');
INSERT INTO "message" VALUES (196,E'es-CO',E'Parámetro si es necesario');
INSERT INTO "message" VALUES (197,E'es-CO',E'Aplica al equipo -> Juez principal');
INSERT INTO "message" VALUES (198,E'es-CO',E'Aplica al Juez principal -> Juez panel');
INSERT INTO "message" VALUES (199,E'es-CO',E'Aplicar a juez panel -> Juez principal');
INSERT INTO "message" VALUES (200,E'es-CO',E'No es bueno');
INSERT INTO "message" VALUES (201,E'es-CO',E'Muy bueno');
INSERT INTO "message" VALUES (202,E'es-CO',E'Excelente');
INSERT INTO "message" VALUES (203,E'es-CO',E'Califique (De 1 a 5) en el campo');
INSERT INTO "message" VALUES (204,E'es-CO',E'Campo para texto corto');
INSERT INTO "message" VALUES (205,E'es-CO',E'Campo para texto largo');
INSERT INTO "message" VALUES (206,E'es-CO',E'Número de campo');
INSERT INTO "message" VALUES (207,E'es-CO',E'Casilla de verificación de campo');
INSERT INTO "message" VALUES (208,E'es-CO',E'Debate');
INSERT INTO "message" VALUES (209,E'es-CO',E'Retroalimentación a ID');
INSERT INTO "message" VALUES (210,E'es-CO',E'Calificación del juez de ID');
INSERT INTO "message" VALUES (211,E'es-CO',E'Calificación del juez a ID');
INSERT INTO "message" VALUES (212,E'es-CO',E'Grupo');
INSERT INTO "message" VALUES (213,E'es-CO',E'Sala activa');
INSERT INTO "message" VALUES (214,E'es-CO',E'Juez panel');
INSERT INTO "message" VALUES (215,E'es-CO',E'Usado');
INSERT INTO "message" VALUES (216,E'es-CO',E'Es el panel predeterminado');
INSERT INTO "message" VALUES (217,E'es-CO',E'Panel #{id} tiene {amount} jueces principales');
INSERT INTO "message" VALUES (218,E'es-CO',E'Categoría');
INSERT INTO "message" VALUES (219,E'es-CO',E'Mensaje');
INSERT INTO "message" VALUES (220,E'es-CO',E'Función');
INSERT INTO "message" VALUES (221,E'es-CO',E'Mociones usadas');
INSERT INTO "message" VALUES (222,E'es-CO',E'Preguntas');
INSERT INTO "message" VALUES (223,E'es-CO',E'En conflicto con');
INSERT INTO "message" VALUES (224,E'es-CO',E'Razón');
INSERT INTO "message" VALUES (225,E'es-CO',E'Equipo en conflicto');
INSERT INTO "message" VALUES (226,E'es-CO',E'Juez en conflicto');
INSERT INTO "message" VALUES (227,E'es-CO',E'No se encuentra el tipo');
INSERT INTO "message" VALUES (228,E'es-CO',E'CAG Orador A');
INSERT INTO "message" VALUES (229,E'es-CO',E'CAG Orador B');
INSERT INTO "message" VALUES (230,E'es-CO',E'CAG Puesto');
INSERT INTO "message" VALUES (231,E'es-CO',E'CAO Orador A');
INSERT INTO "message" VALUES (232,E'es-CO',E'CAO Orador B');
INSERT INTO "message" VALUES (233,E'es-CO',E'CAO Puesto');
INSERT INTO "message" VALUES (234,E'es-CO',E'CBG Orador A');
INSERT INTO "message" VALUES (235,E'es-CO',E'CBG Orador B');
INSERT INTO "message" VALUES (236,E'es-CO',E'CBG Puesto');
INSERT INTO "message" VALUES (237,E'es-CO',E'CBO Orador A');
INSERT INTO "message" VALUES (238,E'es-CO',E'CBO Orador B');
INSERT INTO "message" VALUES (239,E'es-CO',E'CBO Puesto');
INSERT INTO "message" VALUES (240,E'es-CO',E'Revisado');
INSERT INTO "message" VALUES (241,E'es-CO',E'Ingresado por usuario ID');
INSERT INTO "message" VALUES (242,E'es-CO',E'Existe empate');
INSERT INTO "message" VALUES (243,E'es-CO',E'Ironman by');
INSERT INTO "message" VALUES (244,E'es-CO',E'Jefe de Adjudicación');
INSERT INTO "message" VALUES (245,E'es-CO',E'El espacio para restablecer la contraseña no puede estár en blanco');
INSERT INTO "message" VALUES (246,E'es-CO',E'Error en el restablecimiento de contraseña');
INSERT INTO "message" VALUES (247,E'es-CO',E'Archivo separado por comas ( , )');
INSERT INTO "message" VALUES (248,E'es-CO',E'Archivo separado por punto y coma ( ; )');
INSERT INTO "message" VALUES (249,E'es-CO',E'Archivo separado por espacios tabulados ( ->| )');
INSERT INTO "message" VALUES (250,E'es-CO',E'Archivo EXL');
INSERT INTO "message" VALUES (251,E'es-CO',E'Delimitador');
INSERT INTO "message" VALUES (252,E'es-CO',E'Marcar como datos de prueba (no enviar e-mail)');
INSERT INTO "message" VALUES (253,E'es-CO',E'Nombre de usuario');
INSERT INTO "message" VALUES (254,E'es-CO',E'Imagen de perfil');
INSERT INTO "message" VALUES (255,E'es-CO',E'Sociedad de debate actual');
INSERT INTO "message" VALUES (256,E'es-CO',E'Con qué género se siente más identificado');
INSERT INTO "message" VALUES (257,E'es-CO',E'La URL no está permitida');
INSERT INTO "message" VALUES (258,E'es-CO',E'{adju} Registrado');
INSERT INTO "message" VALUES (259,E'es-CO',E'{adju} ya está registrado!');
INSERT INTO "message" VALUES (260,E'es-CO',E'{id} número no valido! no es juez!');
INSERT INTO "message" VALUES (261,E'es-CO',E'{speaker} Registrado!');
INSERT INTO "message" VALUES (262,E'es-CO',E'{speaker} ya se encuentra registrado!');
INSERT INTO "message" VALUES (263,E'es-CO',E'{id} número no valido! No es un equipo!');
INSERT INTO "message" VALUES (264,E'es-CO',E'No es una entrada válida');
INSERT INTO "message" VALUES (265,E'es-CO',E'Código de verificación');
INSERT INTO "message" VALUES (266,E'es-CO',E'RegDeb');
INSERT INTO "message" VALUES (267,E'es-CO',E'Contraseña reestablecida por {user}');
INSERT INTO "message" VALUES (268,E'es-CO',E'No se encuentra el usuario con este E-mail');
INSERT INTO "message" VALUES (269,E'es-CO',E'Agregar {object}');
INSERT INTO "message" VALUES (270,E'es-CO',E'Crear sociedad de debate');
INSERT INTO "message" VALUES (271,E'es-CO',E'Hey tranquilo! Estás ingresando una sociedad de debate desconocida.');
INSERT INTO "message" VALUES (272,E'es-CO',E'Antes de que podamos vincularte, por favor completa la información sobre tu sociedad de debate');
INSERT INTO "message" VALUES (273,E'es-CO',E'Buscar por país');
INSERT INTO "message" VALUES (274,E'es-CO',E'Agregar nueva sociedad de debate');
INSERT INTO "message" VALUES (275,E'es-CO',E'Buscar por sociedad de debate...');
INSERT INTO "message" VALUES (276,E'es-CO',E'Ingrese la fecha de inicio...');
INSERT INTO "message" VALUES (277,E'es-CO',E'Ingrese la fecha de finalización (si aplica)...');
INSERT INTO "message" VALUES (278,E'es-CO',E'Idioma oficial');
INSERT INTO "message" VALUES (279,E'es-CO',E'Oficial');
INSERT INTO "message" VALUES (280,E'es-CO',E'Alguno \r\n{object} ...');
INSERT INTO "message" VALUES (281,E'es-CO',E'Revisión del estado de idiomas');
INSERT INTO "message" VALUES (282,E'es-CO',E'Estado');
INSERT INTO "message" VALUES (283,E'es-CO',E'Requiere entrevista');
INSERT INTO "message" VALUES (284,E'es-CO',E'Grupo ENL');
INSERT INTO "message" VALUES (285,E'es-CO',E'Grupo ESL');
INSERT INTO "message" VALUES (286,E'es-CO',E'Idioma oficial');
INSERT INTO "message" VALUES (288,E'es-CO',E'Agregar');
INSERT INTO "message" VALUES (289,E'es-CO',E'Buscar usuario...');
INSERT INTO "message" VALUES (290,E'es-CO',E'Comprobar');
INSERT INTO "message" VALUES (291,E'es-CO',E'Enviar');
INSERT INTO "message" VALUES (292,E'es-CO',E'Generar ballots');
INSERT INTO "message" VALUES (293,E'es-CO',E'Únicamente hacer por usuario...');
INSERT INTO "message" VALUES (294,E'es-CO',E'Imprimir Ballots');
INSERT INTO "message" VALUES (295,E'es-CO',E'Generar código de barras');
INSERT INTO "message" VALUES (296,E'es-CO',E'Buscar usuario.. o dejar en blanco');
INSERT INTO "message" VALUES (297,E'es-CO',E'Imprimir código de barras');
INSERT INTO "message" VALUES (298,E'es-CO',E'Equipos');
INSERT INTO "message" VALUES (299,E'es-CO',E'Nombre del equipo');
INSERT INTO "message" VALUES (300,E'es-CO',E'Orador A');
INSERT INTO "message" VALUES (301,E'es-CO',E'Orador B');
INSERT INTO "message" VALUES (302,E'es-CO',E'Así queda');
INSERT INTO "message" VALUES (303,E'es-CO',E'Moción:');
INSERT INTO "message" VALUES (304,E'es-CO',E'Panel de jueces:');
INSERT INTO "message" VALUES (305,E'es-CO',E'Palanca activa');
INSERT INTO "message" VALUES (307,E'es-CO',E'Buscar usuario...');
INSERT INTO "message" VALUES (308,E'es-CO',E'Torneos');
INSERT INTO "message" VALUES (309,E'es-CO',E'Detalle general');
INSERT INTO "message" VALUES (310,E'es-CO',E'Mociones');
INSERT INTO "message" VALUES (311,E'es-CO',E'Tabla de equipos');
INSERT INTO "message" VALUES (312,E'es-CO',E'Tabla de oradores');
INSERT INTO "message" VALUES (313,E'es-CO',E'Fuera de rondas');
INSERT INTO "message" VALUES (314,E'es-CO',E'Jueces que pasan el break');
INSERT INTO "message" VALUES (315,E'es-CO',E'Así queda');
INSERT INTO "message" VALUES (316,E'es-CO',E'Registro torneos de debate');
INSERT INTO "message" VALUES (317,E'es-CO',E'Mostrar antiguos torneos');
INSERT INTO "message" VALUES (318,E'es-CO',E'Jueces');
INSERT INTO "message" VALUES (319,E'es-CO',E'Resultado');
INSERT INTO "message" VALUES (320,E'es-CO',E'junto con {teammate}');
INSERT INTO "message" VALUES (321,E'es-CO',E'as ironman');
INSERT INTO "message" VALUES (322,E'es-CO',E'Estás registrado como equipo <br> \'{team}\' {with} por {society}');
INSERT INTO "message" VALUES (323,E'es-CO',E'Usted está registrado como juez por {society}');
INSERT INTO "message" VALUES (325,E'es-CO',E'Registro de información');
INSERT INTO "message" VALUES (326,E'es-CO',E'Ingresar información');
INSERT INTO "message" VALUES (327,E'es-CO',E'Información de la ronda #{num}');
INSERT INTO "message" VALUES (328,E'es-CO',E'Estás <b>{pos}</b> en la sala <b>{room}</b>.');
INSERT INTO "message" VALUES (329,E'es-CO',E'La ronda comienza a las: <b>{time}</b>');
INSERT INTO "message" VALUES (330,E'es-CO',E'Diapositiva de Información');
INSERT INTO "message" VALUES (331,E'es-CO',E'Equipos Ronda #{num}');
INSERT INTO "message" VALUES (332,E'es-CO',E'Mi súper increíble IV Torneo... ej: Vienna IV');
INSERT INTO "message" VALUES (333,E'es-CO',E'Seleccione los organizadores');
INSERT INTO "message" VALUES (334,E'es-CO',E'Ingrese fecha y hora de inicio...');
INSERT INTO "message" VALUES (335,E'es-CO',E'Ingrese fecha y hora de finalización...');
INSERT INTO "message" VALUES (336,E'es-CO',E'Jefes de adjudicación');
INSERT INTO "message" VALUES (337,E'es-CO',E'Elija sus JAs...');
INSERT INTO "message" VALUES (338,E'es-CO',E'Elija su Tabulador');
INSERT INTO "message" VALUES (339,E'es-CO',E'Archivo del torneo');
INSERT INTO "message" VALUES (340,E'es-CO',E'Se produjo un error mientras el servidor Web procesaba su solicitud.');
INSERT INTO "message" VALUES (341,E'es-CO',E'Por favor contáctenos si cree que es un problema del servidor. Gracias');
INSERT INTO "message" VALUES (342,E'es-CO',E'Recuperar contraseña');
INSERT INTO "message" VALUES (343,E'es-CO',E'Por favor escoja su nueva contraseña');
INSERT INTO "message" VALUES (344,E'es-CO',E'Guardar');
INSERT INTO "message" VALUES (345,E'es-CO',E'Registrarse');
INSERT INTO "message" VALUES (346,E'es-CO',E'Por favor complete la siguiente información para registrarse:');
INSERT INTO "message" VALUES (347,E'es-CO',E'La mayoría de los algoritmos de asignación están en el sistema, pero tenga presente la diversidad del panel de jueces. Para que el sistema funcione completamente, le pedimos que escoja una opción de esta lista. Somos conscientes que no todas las preferencias personales pueden tenerse en cuenta en nuestras opciones. Si cree que ninguna de las opciones es útil para usted, por favor escoja <Not Revealing>. Esta opción nunca mostrará los resultados a los usuarios y se usa únicamente para calcular.');
INSERT INTO "message" VALUES (348,E'es-CO',E'Ingresar');
INSERT INTO "message" VALUES (349,E'es-CO',E'Por favor ingrese la siguiente información para iniciar sesión:');
INSERT INTO "message" VALUES (350,E'es-CO',E'Si olvidó su contraseña puede {resetlt}');
INSERT INTO "message" VALUES (351,E'es-CO',E'Reestablecer');
INSERT INTO "message" VALUES (352,E'es-CO',E'Solicitar nueva contraseña');
INSERT INTO "message" VALUES (353,E'es-CO',E'Por favor ingrese su e-mail. Un enlace será enviado allí para recuperar su contraseña.');
INSERT INTO "message" VALUES (354,E'es-CO',E'Enviar');
INSERT INTO "message" VALUES (355,E'es-CO',E'Posiciones EXL');
INSERT INTO "message" VALUES (356,E'es-CO',E'Jueces EXL');
INSERT INTO "message" VALUES (357,E'es-CO',E'Equipos EXL');
INSERT INTO "message" VALUES (358,E'es-CO',E'Crear');
INSERT INTO "message" VALUES (359,E'es-CO',E'Posiciones de muestra EXL');
INSERT INTO "message" VALUES (360,E'es-CO',E'Equipo de muestra EXL');
INSERT INTO "message" VALUES (361,E'es-CO',E'Muestra Jueces EXL');
INSERT INTO "message" VALUES (362,E'es-CO',E'Torneo BP Actual {count, plural, =0{Tournament} =1{Tournament} other{Tournaments}}');
INSERT INTO "message" VALUES (363,E'es-CO',E'Bienvenido a {appName}!');
INSERT INTO "message" VALUES (364,E'es-CO',E'Ver torneos');
INSERT INTO "message" VALUES (365,E'es-CO',E'Crear torneo');
INSERT INTO "message" VALUES (366,E'es-CO',E'Antes de registrarse por favor complete la información acerca de su sociedad de debate:');
INSERT INTO "message" VALUES (367,E'es-CO',E'Contacto');
INSERT INTO "message" VALUES (368,E'es-CO',E'Preseleccionar panel de jueces #');
INSERT INTO "message" VALUES (369,E'es-CO',E'Panel de jueces');
INSERT INTO "message" VALUES (370,E'es-CO',E'Calificación promedio de panel de jueces');
INSERT INTO "message" VALUES (371,E'es-CO',E'Crear panel de jueces');
INSERT INTO "message" VALUES (372,E'es-CO',E'Preseleccionar jueces para la próxima ronda');
INSERT INTO "message" VALUES (373,E'es-CO',E'Agregar {object}\r\n...');
INSERT INTO "message" VALUES (374,E'es-CO',E'Lugar');
INSERT INTO "message" VALUES (375,E'es-CO',E'Puntos de Equipo');
INSERT INTO "message" VALUES (376,E'es-CO',E'#{number}');
INSERT INTO "message" VALUES (377,E'es-CO',E'No hay jueces que pasen el break definidos');
INSERT INTO "message" VALUES (378,E'es-CO',E'Distribución de puntos de orador');
INSERT INTO "message" VALUES (379,E'es-CO',E'Corre');
INSERT INTO "message" VALUES (380,E'es-CO',E'Cámara Alta de Gobierno');
INSERT INTO "message" VALUES (381,E'es-CO',E'Cámara Alta de Oposición');
INSERT INTO "message" VALUES (382,E'es-CO',E'Cámara Baja de Gobierno');
INSERT INTO "message" VALUES (383,E'es-CO',E'Cámara Baja de Oposición');
INSERT INTO "message" VALUES (384,E'es-CO',E'Mostrar diapositiva de información');
INSERT INTO "message" VALUES (385,E'es-CO',E'Mostrar moción');
INSERT INTO "message" VALUES (386,E'es-CO',E'Usuario desaparecido');
INSERT INTO "message" VALUES (387,E'es-CO',E'Marcar desaparecido como inactivo');
INSERT INTO "message" VALUES (388,E'es-CO',E'Resultados');
INSERT INTO "message" VALUES (389,E'es-CO',E'Corre la información de al ronda #{number}');
INSERT INTO "message" VALUES (390,E'es-CO',E'Auto actualización <i id=\'pjax-status\' class=\'\'></i>');
INSERT INTO "message" VALUES (391,E'es-CO',E'Actualizar enfrentamiento individual');
INSERT INTO "message" VALUES (392,E'es-CO',E'Enfrentamiento individual');
INSERT INTO "message" VALUES (393,E'es-CO',E'En el sistema aún no están todos los debatientes :)');
INSERT INTO "message" VALUES (394,E'es-CO',E'Crear impedimento');
INSERT INTO "message" VALUES (395,E'es-CO',E'Actualizar impedimento');
INSERT INTO "message" VALUES (396,E'es-CO',E'Configuración de energía');
INSERT INTO "message" VALUES (397,E'es-CO',E'Actualizar valores de energía');
INSERT INTO "message" VALUES (398,E'es-CO',E'Ronda #{number}');
INSERT INTO "message" VALUES (399,E'es-CO',E'Rondas');
INSERT INTO "message" VALUES (400,E'es-CO',E'Acciones');
INSERT INTO "message" VALUES (401,E'es-CO',E'Publicar la tabulación');
INSERT INTO "message" VALUES (402,E'es-CO',E'Volver intentar generar ronda');
INSERT INTO "message" VALUES (403,E'es-CO',E'Actualizar ronda');
INSERT INTO "message" VALUES (404,E'es-CO',E'Toggle desplegable');
INSERT INTO "message" VALUES (405,E'es-CO',E'Continúa mejorando por');
INSERT INTO "message" VALUES (407,E'es-CO',E'Está seguro que quiere volver a sortear la ronda? Perderá toda la información!');
INSERT INTO "message" VALUES (408,E'es-CO',E'Imprimir Ballots');
INSERT INTO "message" VALUES (411,E'es-CO',E'Estado de la ronda');
INSERT INTO "message" VALUES (412,E'es-CO',E'Puntaje promedio');
INSERT INTO "message" VALUES (413,E'es-CO',E'Tiempo de preparación');
INSERT INTO "message" VALUES (414,E'es-CO',E'Paleta de color');
INSERT INTO "message" VALUES (415,E'es-CO',E'Género');
INSERT INTO "message" VALUES (416,E'es-CO',E'Regiones');
INSERT INTO "message" VALUES (417,E'es-CO',E'Puntos');
INSERT INTO "message" VALUES (418,E'es-CO',E'Cargando ...');
INSERT INTO "message" VALUES (419,E'es-CO',E'Ver retroalimentación');
INSERT INTO "message" VALUES (420,E'es-CO',E'Ver usuario');
INSERT INTO "message" VALUES (421,E'es-CO',E'Cambiar posición con {venue}');
INSERT INTO "message" VALUES (422,E'es-CO',E'Elija posición ...');
INSERT INTO "message" VALUES (423,E'es-CO',E'Actualizar {modelClass} #{número}');
INSERT INTO "message" VALUES (424,E'es-CO',E'Nivel de puntaje');
INSERT INTO "message" VALUES (425,E'es-CO',E'Elegir equipo ...');
INSERT INTO "message" VALUES (426,E'es-CO',E'Elegir idioma ...');
INSERT INTO "message" VALUES (427,E'es-CO',E'Elegir juez ...');
INSERT INTO "message" VALUES (428,E'es-CO',E'Cambiar jueces ...');
INSERT INTO "message" VALUES (429,E'es-CO',E'Cambiar este juez ...');
INSERT INTO "message" VALUES (430,E'es-CO',E'con');
INSERT INTO "message" VALUES (431,E'es-CO',E'con este ...');
INSERT INTO "message" VALUES (432,E'es-CO',E'Buscar moción por etiqueta ...');
INSERT INTO "message" VALUES (433,E'es-CO',E'Puesto');
INSERT INTO "message" VALUES (434,E'es-CO',E'Total');
INSERT INTO "message" VALUES (435,E'es-CO',E'Debate ID');
INSERT INTO "message" VALUES (436,E'es-CO',E'Sala');
INSERT INTO "message" VALUES (437,E'es-CO',E'Fuera de ronda');
INSERT INTO "message" VALUES (438,E'es-CO',E'Archivo de moción');
INSERT INTO "message" VALUES (439,E'es-CO',E'Moción a terceros');
INSERT INTO "message" VALUES (440,E'es-CO',E'Su sensacional IV');
INSERT INTO "message" VALUES (441,E'es-CO',E'Ingrese fecha ...');
INSERT INTO "message" VALUES (442,E'es-CO',E'Ronda #1 o Final');
INSERT INTO "message" VALUES (443,E'es-CO',E'EC ...');
INSERT INTO "message" VALUES (444,E'es-CO',E'http://dar.creditos.donde.los.creditos.se.necesitan.com');
INSERT INTO "message" VALUES (445,E'es-CO',E'Ingresar {modelClass} Manualmente');
INSERT INTO "message" VALUES (446,E'es-CO',E'Opciones');
INSERT INTO "message" VALUES (447,E'es-CO',E'Continuar');
INSERT INTO "message" VALUES (448,E'es-CO',E'No hay resultados aún!');
INSERT INTO "message" VALUES (449,E'es-CO',E'Resultados en la sala: {venue}');
INSERT INTO "message" VALUES (450,E'es-CO',E'Resultados por posición {venue}');
INSERT INTO "message" VALUES (451,E'es-CO',E'Vista de la lista');
INSERT INTO "message" VALUES (452,E'es-CO',E'Resultados por {label}');
INSERT INTO "message" VALUES (453,E'es-CO',E'Cambiar a vista de las posiciones');
INSERT INTO "message" VALUES (454,E'es-CO',E'Puntaje del Swing Team');
INSERT INTO "message" VALUES (455,E'es-CO',E'Ver detalles de los resultados');
INSERT INTO "message" VALUES (456,E'es-CO',E'Resultado correcto');
INSERT INTO "message" VALUES (457,E'es-CO',E'Ver posiciones');
INSERT INTO "message" VALUES (458,E'es-CO',E'Cambiar a vista de la lista');
INSERT INTO "message" VALUES (459,E'es-CO',E'Confirmar datos de {venue}');
INSERT INTO "message" VALUES (460,E'es-CO',E'Comenzar de nuevo');
INSERT INTO "message" VALUES (461,E'es-CO',E'Ronda {number}');
INSERT INTO "message" VALUES (462,E'es-CO',E'Gracias');
INSERT INTO "message" VALUES (463,E'es-CO',E'Gracias!');
INSERT INTO "message" VALUES (464,E'es-CO',E'Resultados exitosamente guardados');
INSERT INTO "message" VALUES (465,E'es-CO',E'Boooonus por velocidad!');
INSERT INTO "message" VALUES (466,E'es-CO',E'Apúrate ¡vamos! ¡vamos!');
INSERT INTO "message" VALUES (467,E'es-CO',E'¡Ya está!¡El último!');
INSERT INTO "message" VALUES (468,E'es-CO',E'Usted es <b>#{place}</b> de {max}');
INSERT INTO "message" VALUES (469,E'es-CO',E'Ingresar retroalimentación');
INSERT INTO "message" VALUES (470,E'es-CO',E'Volver al torneo');
INSERT INTO "message" VALUES (471,E'es-CO',E'Retroalimentaciones');
INSERT INTO "message" VALUES (472,E'es-CO',E'Objetivo del juez');
INSERT INTO "message" VALUES (473,E'es-CO',E'Nombre del juez');
INSERT INTO "message" VALUES (474,E'es-CO',E'Retroalimentación del juez');
INSERT INTO "message" VALUES (475,E'es-CO',E'Enviar retroalimentación');
INSERT INTO "message" VALUES (476,E'es-CO',E'{tournament} - Idioma oficial');
INSERT INTO "message" VALUES (477,E'es-CO',E'Revisar estado del idioma');
INSERT INTO "message" VALUES (478,E'es-CO',E'desarrollado con tecnología alien secreta');
INSERT INTO "message" VALUES (479,E'es-CO',E'Reporte error');
INSERT INTO "message" VALUES (480,E'es-CO',E'{tournament} - Director');
INSERT INTO "message" VALUES (481,E'es-CO',E'Lista de posiciones');
INSERT INTO "message" VALUES (482,E'es-CO',E'Crear posición');
INSERT INTO "message" VALUES (483,E'es-CO',E'Importar posición');
INSERT INTO "message" VALUES (484,E'es-CO',E'Lista de equipos');
INSERT INTO "message" VALUES (485,E'es-CO',E'Crear equipo');
INSERT INTO "message" VALUES (486,E'es-CO',E'Importar Equipo');
INSERT INTO "message" VALUES (487,E'es-CO',E'Puntuar equipo');
INSERT INTO "message" VALUES (488,E'es-CO',E'Lista de Jueces');
INSERT INTO "message" VALUES (489,E'es-CO',E'Crear Juez');
INSERT INTO "message" VALUES (490,E'es-CO',E'Importar Juez');
INSERT INTO "message" VALUES (491,E'es-CO',E'Ver panel de jueces preseleccionado');
INSERT INTO "message" VALUES (492,E'es-CO',E'Crear panel de jueces preseleccionado');
INSERT INTO "message" VALUES (493,E'es-CO',E'Puntuar adjudicador');
INSERT INTO "message" VALUES (494,E'es-CO',E'Actualizar torneo');
INSERT INTO "message" VALUES (495,E'es-CO',E'Mostrar Tabla de equipos');
INSERT INTO "message" VALUES (496,E'es-CO',E'Mostrar tabla de oradores');
INSERT INTO "message" VALUES (497,E'es-CO',E'Mostrar fuera de ronda');
INSERT INTO "message" VALUES (498,E'es-CO',E'Al publicar la tabulación el torneo se cerrará y archivará! Seguro que desea continuar?');
INSERT INTO "message" VALUES (499,E'es-CO',E'Usuarios desaparecidos');
INSERT INTO "message" VALUES (500,E'es-CO',E'Forma de confirmación');
INSERT INTO "message" VALUES (501,E'es-CO',E'Imprimir Badgets');
INSERT INTO "message" VALUES (502,E'es-CO',E'Reiniciar confirmación');
INSERT INTO "message" VALUES (503,E'es-CO',E'Está seguro que desea reiniciar la confirmación?');
INSERT INTO "message" VALUES (504,E'es-CO',E'Sincronizar con DebReg');
INSERT INTO "message" VALUES (505,E'es-CO',E'Ir a Tabbie 1');
INSERT INTO "message" VALUES (506,E'es-CO',E'Mucho cuidado pequeño padawan!');
INSERT INTO "message" VALUES (507,E'es-CO',E'Lista de Rondas');
INSERT INTO "message" VALUES (508,E'es-CO',E'Crear ronda');
INSERT INTO "message" VALUES (509,E'es-CO',E'Opciones de energía');
INSERT INTO "message" VALUES (510,E'es-CO',E'Lista de resultados');
INSERT INTO "message" VALUES (511,E'es-CO',E'Ingrese ballot');
INSERT INTO "message" VALUES (512,E'es-CO',E'Caché correcta');
INSERT INTO "message" VALUES (513,E'es-CO',E'Preguntas de configuración');
INSERT INTO "message" VALUES (514,E'es-CO',E'Cada retroalimentación');
INSERT INTO "message" VALUES (515,E'es-CO',E'Retroalimentacion de jueces');
INSERT INTO "message" VALUES (516,E'es-CO',E'Acerca de');
INSERT INTO "message" VALUES (517,E'es-CO',E'Cómo se hace');
INSERT INTO "message" VALUES (518,E'es-CO',E'Usuarios');
INSERT INTO "message" VALUES (519,E'es-CO',E'Registro');
INSERT INTO "message" VALUES (520,E'es-CO',E'Perfil de {user}');
INSERT INTO "message" VALUES (521,E'es-CO',E'Historial de {user}');
INSERT INTO "message" VALUES (522,E'es-CO',E'Cerrar sesión');
INSERT INTO "message" VALUES (524,E'es-CO',E'Actualizar {label}');
INSERT INTO "message" VALUES (525,E'es-CO',E'Siguiente paso');
INSERT INTO "message" VALUES (526,E'es-CO',E'Sala {number}');
INSERT INTO "message" VALUES (527,E'es-CO',E'Posiciones');
INSERT INTO "message" VALUES (529,E'es-CO',E'Puntuaciones');
INSERT INTO "message" VALUES (530,E'es-CO',E'Importar puntuaciones');
INSERT INTO "message" VALUES (531,E'es-CO',E'Aceptar');
INSERT INTO "message" VALUES (532,E'es-CO',E'Rechazar');
INSERT INTO "message" VALUES (533,E'es-CO',E'Buscar equipo...');
INSERT INTO "message" VALUES (534,E'es-CO',E'Buscar juez ...');
INSERT INTO "message" VALUES (535,E'es-CO',E'Puntuar jueces');
INSERT INTO "message" VALUES (536,E'es-CO',E'Crear adicional {modelClass}');
INSERT INTO "message" VALUES (537,E'es-CO',E'Actualizar equipo');
INSERT INTO "message" VALUES (538,E'es-CO',E'Eliminar equipo');
INSERT INTO "message" VALUES (539,E'es-CO',E'Buscar por juez ...');
INSERT INTO "message" VALUES (540,E'es-CO',E'Buscar un juez para ...');
INSERT INTO "message" VALUES (541,E'es-CO',E'Puntuar equipo con juez');
INSERT INTO "message" VALUES (542,E'es-CO',E'Actualizar equipo');
INSERT INTO "message" VALUES (543,E'es-CO',E'Eliminar equipo');
INSERT INTO "message" VALUES (544,E'es-CO',E'{modelClass} Historial');
INSERT INTO "message" VALUES (545,E'es-CO',E'Historial');
INSERT INTO "message" VALUES (546,E'es-CO',E'Revisión de equipos');
INSERT INTO "message" VALUES (547,E'es-CO',E'EPL Posición');
INSERT INTO "message" VALUES (548,E'es-CO',E'Puntos de orador por equipo');
INSERT INTO "message" VALUES (549,E'es-CO',E'No hay tabulación disponible para publicar por el momento');
INSERT INTO "message" VALUES (550,E'es-CO',E'Puede ser juez principal');
INSERT INTO "message" VALUES (551,E'es-CO',E'No debe ser juez principal');
INSERT INTO "message" VALUES (552,E'es-CO',E'Pasa el Break');
INSERT INTO "message" VALUES (553,E'es-CO',E'No pasa el break');
INSERT INTO "message" VALUES (554,E'es-CO',E'Observador');
INSERT INTO "message" VALUES (555,E'es-CO',E'No observador');
INSERT INTO "message" VALUES (556,E'es-CO',E'Ver palanca');
INSERT INTO "message" VALUES (557,E'es-CO',E'Break palanca');
INSERT INTO "message" VALUES (558,E'es-CO',E'Reiniciar bandera de observación');
INSERT INTO "message" VALUES (559,E'es-CO',E'Buscar {object} ...');
INSERT INTO "message" VALUES (560,E'es-CO',E'Juez principal');
INSERT INTO "message" VALUES (561,E'es-CO',E'Indicador');
INSERT INTO "message" VALUES (562,E'es-CO',E'Actualziar perfil de usuario');
INSERT INTO "message" VALUES (563,E'es-CO',E'Enfrentamiento individual');
INSERT INTO "message" VALUES (564,E'es-CO',E'Actualizar información de enfrentamiento');
INSERT INTO "message" VALUES (565,E'es-CO',E'Eliminar enfrentamiento');
INSERT INTO "message" VALUES (566,E'es-CO',E'No se conoce enfrentamiento en el sistema.');
INSERT INTO "message" VALUES (567,E'es-CO',E'Historial de la sociedad de debate');
INSERT INTO "message" VALUES (568,E'es-CO',E'Agregar nueva sociedad de debate al historial');
INSERT INTO "message" VALUES (569,E'es-CO',E'Continúa activo');
INSERT INTO "message" VALUES (570,E'es-CO',E'Actualizar información de sociedad de debate');
INSERT INTO "message" VALUES (571,E'es-CO',E'Forzar nueva contraseña para {name}');
INSERT INTO "message" VALUES (572,E'es-CO',E'Cancelar');
INSERT INTO "message" VALUES (573,E'es-CO',E'Buscar torneo...');
INSERT INTO "message" VALUES (574,E'es-CO',E'Elegir nueva contraseña');
INSERT INTO "message" VALUES (575,E'es-CO',E'Actualizar usuario');
INSERT INTO "message" VALUES (576,E'es-CO',E'Eliminar usuario');
INSERT INTO "message" VALUES (577,E'es-CO',E'Crear usuario');
INSERT INTO "message" VALUES (578,E'es-CO',E'No coincide condición');
INSERT INTO "message" VALUES (579,E'es-CO',E'No pasó la verificación de antiguedad del panel:  {old} / new: {new}');
INSERT INTO "message" VALUES (580,E'es-CO',E'No se pudo guardar {object}! Error: {message}');
INSERT INTO "message" VALUES (582,E'es-CO',E'No hay archivo disponible');
INSERT INTO "message" VALUES (583,E'es-CO',E'No coincide busqueda de historial');
INSERT INTO "message" VALUES (584,E'es-CO',E'Gracias por su registro');
INSERT INTO "message" VALUES (585,E'es-CO',E'Error guardando el panel de jueces:');
INSERT INTO "message" VALUES (586,E'es-CO',E'Panel de jueces eliminado');
INSERT INTO "message" VALUES (587,E'es-CO',E'Bienvenido! Esta es la primera vez que ingresas, por favor confirma que tu información sea correcta');
INSERT INTO "message" VALUES (588,E'es-CO',E'La nueva sociedad de debate ha sido guardada.');
INSERT INTO "message" VALUES (589,E'es-CO',E'Ha ocurrido un error recibiendo tu ingreso anterior. Por favor ingréselo nuevamente');
INSERT INTO "message" VALUES (590,E'es-CO',E'Usuario registrado! Bienvenido {user}');
INSERT INTO "message" VALUES (591,E'es-CO',E'Falló inicio de sesión');
INSERT INTO "message" VALUES (592,E'es-CO',E'Revisa tu e-mail para más instrucciones');
INSERT INTO "message" VALUES (593,E'es-CO',E'Lo sentimos, no podemos recuperar la contraseña del e-mail ingresado <br>{message}');
INSERT INTO "message" VALUES (594,E'es-CO',E'Nueva contraseña guardada');
INSERT INTO "message" VALUES (595,E'es-CO',E'Elegir nueva contraseña');
INSERT INTO "message" VALUES (596,E'es-CO',E'Error guardando nueva contraseña');
INSERT INTO "message" VALUES (597,E'es-CO',E'Conexión con sociedad de debate no guardada');
INSERT INTO "message" VALUES (598,E'es-CO',E'Usuario exitosamente guardado!');
INSERT INTO "message" VALUES (599,E'es-CO',E'Usuario no guardado!');
INSERT INTO "message" VALUES (600,E'es-CO',E'Conexión con sociedad de debate no guardada!');
INSERT INTO "message" VALUES (601,E'es-CO',E'Usuario actualizado exitosamente!');
INSERT INTO "message" VALUES (602,E'es-CO',E'Por favor ingrese nueva contraseña!');
INSERT INTO "message" VALUES (603,E'es-CO',E'Usuario eliminado');
INSERT INTO "message" VALUES (604,E'es-CO',E'No se puede eliminar debido a {error}');
INSERT INTO "message" VALUES (605,E'es-CO',E'No se puede eliminar porque actualmente está siendo usado. <br> {ex}');
INSERT INTO "message" VALUES (606,E'es-CO',E'Comprobando reinicio de banderas');
INSERT INTO "message" VALUES (607,E'es-CO',E'No hay necesidad de reiniciar');
INSERT INTO "message" VALUES (608,E'es-CO',E'Por favor elija los jueces del break primero - Use el ícono de inicio en la columna de acciones.');
INSERT INTO "message" VALUES (609,E'es-CO',E'No se puede crear equipo.');
INSERT INTO "message" VALUES (610,E'es-CO',E'Error guardando relación con la sociedad de debate {society}');
INSERT INTO "message" VALUES (611,E'es-CO',E'Error guardando equipo {name}!');
INSERT INTO "message" VALUES (613,E'es-CO',E'No se puede guardar conexión con el torneo');
INSERT INTO "message" VALUES (614,E'es-CO',E'No se puede eliminar la pregunta');
INSERT INTO "message" VALUES (615,E'es-CO',E'Relación con la sociedad de debate exitosamente creada');
INSERT INTO "message" VALUES (616,E'es-CO',E'No se puede guardar la sociedad de debate');
INSERT INTO "message" VALUES (617,E'es-CO',E'Error en la activación');
INSERT INTO "message" VALUES (618,E'es-CO',E'Información de la sociedad de debate actualizada');
INSERT INTO "message" VALUES (619,E'es-CO',E'Tabulación publicada y torneo cerrado. ¡Vamos por una cerveza!');
INSERT INTO "message" VALUES (620,E'es-CO',E'Juez principal del panel de jueces no encontrado - Escribiste mal?');
INSERT INTO "message" VALUES (622,E'es-CO',E'Invalido');
INSERT INTO "message" VALUES (623,E'es-CO',E'{object} enviado exitosamente');
INSERT INTO "message" VALUES (624,E'es-CO',E'{object} creado');
INSERT INTO "message" VALUES (625,E'es-CO',E'Enfrentamiento individual');
INSERT INTO "message" VALUES (626,E'es-CO',E'No se pudo guardar enfrentamiento individual');
INSERT INTO "message" VALUES (627,E'es-CO',E'{object} actualizado');
INSERT INTO "message" VALUES (628,E'es-CO',E'No se puede guardar {object}');
INSERT INTO "message" VALUES (629,E'es-CO',E'{object} eliminado');
INSERT INTO "message" VALUES (630,E'es-CO',E'{tournament} en Tabbie2');
INSERT INTO "message" VALUES (631,E'es-CO',E'{tournament} tendrá lugar del {start} al {end} organizado por {host} en {country}');
INSERT INTO "message" VALUES (632,E'es-CO',E'Torneo creado exitosamente');
INSERT INTO "message" VALUES (633,E'es-CO',E'Se creo el torneo pero la configuración de la conexión falló!');
INSERT INTO "message" VALUES (634,E'es-CO',E'No se puede guardar el torneo!');
INSERT INTO "message" VALUES (635,E'es-CO',E'Sincronización exitosa con DebReg');
INSERT INTO "message" VALUES (636,E'es-CO',E'Posiciones cambiadas');
INSERT INTO "message" VALUES (637,E'es-CO',E'Error mientras se hacía la combinación');
INSERT INTO "message" VALUES (638,E'es-CO',E'Nuevas posicioes seleccionadas');
INSERT INTO "message" VALUES (639,E'es-CO',E'Error mientras se configuraban las nuevas posiciones');
INSERT INTO "message" VALUES (640,E'es-CO',E'No se puede crear la ronda: La cantidad de equipos no se puede dividir en 4');
INSERT INTO "message" VALUES (641,E'es-CO',E'Exitosamente reasignado in {sec}s');
INSERT INTO "message" VALUES (642,E'es-CO',E'Mejorar la energía por {diff} puntos en {secs}');
INSERT INTO "message" VALUES (643,E'es-CO',E'Juez {n1} y {n2} se cambiaron');
INSERT INTO "message" VALUES (644,E'es-CO',E'No se puede cambiar debido a quel {a_panel}<br>y<br>{b_panel}');
INSERT INTO "message" VALUES (645,E'es-CO',E'Mostrar ronda {number}');
INSERT INTO "message" VALUES (646,E'es-CO',E'No se encontraron debates en esta ronda');
INSERT INTO "message" VALUES (647,E'es-CO',E'El idioma no es una opción valida en parámetros');
INSERT INTO "message" VALUES (648,E'es-CO',E'Equipo actualizado a {status}');
INSERT INTO "message" VALUES (649,E'es-CO',E'Configuración de idioma guardada');
INSERT INTO "message" VALUES (650,E'es-CO',E'Error guardando la configuración de idioma');
INSERT INTO "message" VALUES (651,E'es-CO',E'No se encuentra usuario!');
INSERT INTO "message" VALUES (652,E'es-CO',E'{object} agregado exitosamente');
INSERT INTO "message" VALUES (653,E'es-CO',E'Eliminado exitosamente');
INSERT INTO "message" VALUES (654,E'es-CO',E'Error en el formato! Se requieren 3 columnas');
INSERT INTO "message" VALUES (656,E'es-CO',E'Error guardando resultados. <br> Por favor solicite la ballot!');
INSERT INTO "message" VALUES (657,E'es-CO',E'Se guardaron los resultados! Siguiente!');
INSERT INTO "message" VALUES (658,E'es-CO',E'Debate #{id} no existe');
INSERT INTO "message" VALUES (659,E'es-CO',E'Números correctos de equipo para {team} desde {old_points} hasta {new_points}');
INSERT INTO "message" VALUES (660,E'es-CO',E'Confirmado puntaje de orador {pos} del equipo {team} desde {old_points} hasta {new_points}');
INSERT INTO "message" VALUES (661,E'es-CO',E'Caché en perfecto estado. No se necesitan cambios');
INSERT INTO "message" VALUES (662,E'es-CO',E'No se puede guardar el enfrentamiento {reason}');
INSERT INTO "message" VALUES (663,E'es-CO',E'No hay suficientes posiciones');
INSERT INTO "message" VALUES (664,E'es-CO',E'Demasiadas posiciones');
INSERT INTO "message" VALUES (665,E'es-CO',E'Número máximo de interacciones para mejorar la asignación de jueces');
INSERT INTO "message" VALUES (666,E'es-CO',E'Equipo y juez en la misma penalidad');
INSERT INTO "message" VALUES (667,E'es-CO',E'Ambos adjudicadores en conflicto');
INSERT INTO "message" VALUES (668,E'es-CO',E'Equipo y adjudicadores en conflicto');
INSERT INTO "message" VALUES (669,E'es-CO',E'Juez no está habilitado para ser juez principal');
INSERT INTO "message" VALUES (670,E'es-CO',E'El juez no es la mejor opción en la situación actual');
INSERT INTO "message" VALUES (671,E'es-CO',E'El juez ya ha visto al equipo');
INSERT INTO "message" VALUES (672,E'es-CO',E'El juez ya ha juzgado en esta combinación');
INSERT INTO "message" VALUES (673,E'es-CO',E'El panel no está bien puntuado para la sala');
INSERT INTO "message" VALUES (674,E'es-CO',E'El ingrediente especial de Richard');
INSERT INTO "message" VALUES (675,E'es-CO',E'Juez {adju} y {team} en la misma sociedad de debate.');
INSERT INTO "message" VALUES (676,E'es-CO',E'Juez {adju1} y {adju2} enfrentados manualmente');
INSERT INTO "message" VALUES (677,E'es-CO',E'Juez {adju} y equipo {team} se enfrentan manualmente');
INSERT INTO "message" VALUES (678,E'es-CO',E'Juez {adju} fue etiquetado como no principal.');
INSERT INTO "message" VALUES (679,E'es-CO',E'El equipo de jueces no es el mejor por puntaje {points}.');
INSERT INTO "message" VALUES (680,E'es-CO',E'Juez {adju1} y {adju2} han juzgados juntos x {occ} antes');
INSERT INTO "message" VALUES (681,E'es-CO',E'Juez {adju} ya juzgó el equipo {team} x {occ} antes.');
INSERT INTO "message" VALUES (682,E'es-CO',E'Pendiente comparación: {comparison_factor}, Diferencia: {roomDifference}, Pendiente penalidad: {steepnessPenalty}');
INSERT INTO "message" VALUES (686,E'es-CO',E'Sin definir');
INSERT INTO "message" VALUES (687,E'es-CO',E'Norte de Europa');
INSERT INTO "message" VALUES (688,E'es-CO',E'Oeste de Europa');
INSERT INTO "message" VALUES (689,E'es-CO',E'Sur de Europa');
INSERT INTO "message" VALUES (690,E'es-CO',E'Europa del Este');
INSERT INTO "message" VALUES (691,E'es-CO',E'Asia central');
INSERT INTO "message" VALUES (692,E'es-CO',E'Este de Asia');
INSERT INTO "message" VALUES (693,E'es-CO',E'Oeste de Asia');
INSERT INTO "message" VALUES (694,E'es-CO',E'Sur de Asia');
INSERT INTO "message" VALUES (695,E'es-CO',E'Suseste de Asia');
INSERT INTO "message" VALUES (696,E'es-CO',E'Australia y Nueva Zelanda');
INSERT INTO "message" VALUES (697,E'es-CO',E'Micronesia');
INSERT INTO "message" VALUES (698,E'es-CO',E'Melanesia');
INSERT INTO "message" VALUES (699,E'es-CO',E'Polinesia');
INSERT INTO "message" VALUES (700,E'es-CO',E'Norte de África');
INSERT INTO "message" VALUES (701,E'es-CO',E'Oeste de África');
INSERT INTO "message" VALUES (702,E'es-CO',E'Africa Central');
INSERT INTO "message" VALUES (703,E'es-CO',E'Este de África');
INSERT INTO "message" VALUES (704,E'es-CO',E'Sur de África');
INSERT INTO "message" VALUES (705,E'es-CO',E'Norte América');
INSERT INTO "message" VALUES (706,E'es-CO',E'Centro América');
INSERT INTO "message" VALUES (707,E'es-CO',E'Caribe');
INSERT INTO "message" VALUES (708,E'es-CO',E'Sur América');
INSERT INTO "message" VALUES (709,E'es-CO',E'Antártida');
INSERT INTO "message" VALUES (710,E'es-CO',E'Juez penalizado');
INSERT INTO "message" VALUES (711,E'es-CO',E'Mal juez');
INSERT INTO "message" VALUES (712,E'es-CO',E'Juez decente');
INSERT INTO "message" VALUES (713,E'es-CO',E'Juez promedio');
INSERT INTO "message" VALUES (714,E'es-CO',E'Juez principal promedio');
INSERT INTO "message" VALUES (715,E'es-CO',E'Buen juez principal');
INSERT INTO "message" VALUES (716,E'es-CO',E'Jueces principales del break');
INSERT INTO "message" VALUES (717,E'es-CO',E'<b> Este torneo no tiene equipos aún. </b><br>{add_button} or {import_button}');
INSERT INTO "message" VALUES (718,E'es-CO',E'Agregar equipo');
INSERT INTO "message" VALUES (719,E'es-CO',E'Importarlos vía archivo EXL.');
INSERT INTO "message" VALUES (720,E'es-CO',E'Este torneo no tiene lugares aún. <br>{add} or {import}');
INSERT INTO "message" VALUES (721,E'es-CO',E'Agregar lugar');
INSERT INTO "message" VALUES (722,E'es-CO',E'Importarlos vía archivo EXL');
INSERT INTO "message" VALUES (723,E'es-CO',E'<b> Este torneo no tiene jueces aún.</b><br>{add_button} ó {import_button}.');
INSERT INTO "message" VALUES (724,E'es-CO',E'Importarlos via archivo EXL');
INSERT INTO "message" VALUES (725,E'es-CO',E'Ya se ingresaron los resultados para esta ronda. No se pueden cambiar!');
INSERT INTO "message" VALUES (726,E'es-CO',E'Ya se ingresaron los resultados para esta ronda. No se pueden mejorar!');
INSERT INTO "message" VALUES (727,E'es-CO',E'Retroalimentación #{num}');
INSERT INTO "message" VALUES (728,E'es-CO',E'ID del usuario');
INSERT INTO "message" VALUES (729,E'es-CO',E'Encargado del idioma');
INSERT INTO "message" VALUES (730,E'es-CO',E'Encargados del idioma');
INSERT INTO "message" VALUES (731,E'es-CO',E'Crear encargado del idioma');
INSERT INTO "message" VALUES (732,E'es-CO',E'Mostrar ELE ranking');
INSERT INTO "message" VALUES (733,E'es-CO',E'Mostrar ranking de novatos');
INSERT INTO "message" VALUES (734,E'es-CO',E'Inglés como idioma de dominio');
INSERT INTO "message" VALUES (735,E'es-CO',E'NOV');
INSERT INTO "message" VALUES (736,E'es-CO',E'Seleccionar novato');
INSERT INTO "message" VALUES (737,E'es-CO',E'ENL');
INSERT INTO "message" VALUES (738,E'es-CO',E'Agregar nuevo idioma');
INSERT INTO "message" VALUES (739,E'es-CO',NULL);
INSERT INTO "message" VALUES (740,E'es-CO',NULL);
INSERT INTO "message" VALUES (741,E'es-CO',NULL);
INSERT INTO "message" VALUES (742,E'es-CO',NULL);
INSERT INTO "message" VALUES (743,E'es-CO',NULL);
INSERT INTO "message" VALUES (744,E'es-CO',NULL);
INSERT INTO "message" VALUES (745,E'es-CO',NULL);
INSERT INTO "message" VALUES (746,E'es-CO',NULL);
INSERT INTO "message" VALUES (747,E'es-CO',NULL);
INSERT INTO "message" VALUES (748,E'es-CO',NULL);
INSERT INTO "message" VALUES (749,E'es-CO',NULL);
INSERT INTO "message" VALUES (750,E'es-CO',NULL);
INSERT INTO "message" VALUES (751,E'es-CO',NULL);
INSERT INTO "message" VALUES (753,E'es-CO',NULL);
INSERT INTO "message" VALUES (754,E'es-CO',NULL);
INSERT INTO "message" VALUES (755,E'es-CO',NULL);
INSERT INTO "message" VALUES (756,E'es-CO',NULL);
INSERT INTO "message" VALUES (757,E'es-CO',NULL);
INSERT INTO "message" VALUES (758,E'es-CO',NULL);
INSERT INTO "message" VALUES (759,E'es-CO',NULL);
INSERT INTO "message" VALUES (760,E'es-CO',NULL);
INSERT INTO "message" VALUES (761,E'es-CO',NULL);
INSERT INTO "message" VALUES (762,E'es-CO',NULL);
INSERT INTO "message" VALUES (764,E'es-CO',NULL);
INSERT INTO "message" VALUES (765,E'es-CO',NULL);
INSERT INTO "message" VALUES (766,E'es-CO',NULL);
INSERT INTO "message" VALUES (767,E'es-CO',NULL);
INSERT INTO "message" VALUES (770,E'es-CO',NULL);
INSERT INTO "message" VALUES (771,E'es-CO',NULL);
INSERT INTO "message" VALUES (772,E'es-CO',NULL);
INSERT INTO "message" VALUES (773,E'es-CO',NULL);
INSERT INTO "message" VALUES (774,E'es-CO',NULL);
INSERT INTO "message" VALUES (775,E'es-CO',NULL);
INSERT INTO "message" VALUES (777,E'es-CO',NULL);
INSERT INTO "message" VALUES (778,E'es-CO',NULL);
INSERT INTO "message" VALUES (783,E'es-CO',NULL);
INSERT INTO "message" VALUES (784,E'es-CO',NULL);
INSERT INTO "message" VALUES (785,E'es-CO',NULL);
INSERT INTO "message" VALUES (787,E'es-CO',NULL);
INSERT INTO "message" VALUES (788,E'es-CO',NULL);
INSERT INTO "message" VALUES (789,E'es-CO',NULL);
INSERT INTO "message" VALUES (790,E'es-CO',NULL);
INSERT INTO "message" VALUES (791,E'es-CO',NULL);
INSERT INTO "message" VALUES (792,E'es-CO',NULL);
INSERT INTO "message" VALUES (793,E'es-CO',NULL);
INSERT INTO "message" VALUES (794,E'es-CO',NULL);
INSERT INTO "message" VALUES (795,E'es-CO',NULL);
INSERT INTO "message" VALUES (796,E'es-CO',NULL);
INSERT INTO "message" VALUES (1,E'tr-TR',E'Kullanıcı Kodu');
INSERT INTO "message" VALUES (2,E'tr-TR',E'İsim');
INSERT INTO "message" VALUES (3,E'tr-TR',E'{modelClass}\'ı İçeri Aktar');
INSERT INTO "message" VALUES (4,E'tr-TR',E'İçeri Aktar');
INSERT INTO "message" VALUES (5,E'tr-TR',E'Topluluklar');
INSERT INTO "message" VALUES (6,E'tr-TR',E'Güncelle');
INSERT INTO "message" VALUES (7,E'tr-TR',E'Sil');
INSERT INTO "message" VALUES (8,E'tr-TR',E'Bu ögeyi silmek istediğinizden emin misiniz?');
INSERT INTO "message" VALUES (9,E'tr-TR',E'{modelClass}\'ı Güncelle:');
INSERT INTO "message" VALUES (10,E'tr-TR',E'\'{society}\' Topluluğunu Şununla Birleştir: ...');
INSERT INTO "message" VALUES (11,E'tr-TR',E'Bir Ana Topluluk Seç ...');
INSERT INTO "message" VALUES (12,E'tr-TR',E'{modelClass} Oluştur');
INSERT INTO "message" VALUES (13,E'tr-TR',E'{modelClass}\'ı Görüntüle');
INSERT INTO "message" VALUES (14,E'tr-TR',E'{modelClass}\'ı Güncelle');
INSERT INTO "message" VALUES (15,E'tr-TR',E'{modelClass}\'ı Sil');
INSERT INTO "message" VALUES (16,E'tr-TR',E'Yeni öge ekle');
INSERT INTO "message" VALUES (17,E'tr-TR',E'İçeriği yeniden yükle');
INSERT INTO "message" VALUES (18,E'tr-TR',E'CSV Dosyası Aracılığıyla İçeri Aktar');
INSERT INTO "message" VALUES (19,E'tr-TR',E'Oluştur');
INSERT INTO "message" VALUES (20,E'tr-TR',E'Diller');
INSERT INTO "message" VALUES (21,E'tr-TR',E'Dil Oluştur');
INSERT INTO "message" VALUES (22,E'tr-TR',E'Özel İhtiyaçlar');
INSERT INTO "message" VALUES (23,E'tr-TR',E'Önerge Etiketleri');
INSERT INTO "message" VALUES (24,E'tr-TR',E'\'{tag}\' Önerge Etiketini Şununla Birleştir: ...');
INSERT INTO "message" VALUES (25,E'tr-TR',E'Bir Üst Etiket Seç ...');
INSERT INTO "message" VALUES (26,E'tr-TR',E'Ara');
INSERT INTO "message" VALUES (27,E'tr-TR',E'Sıfırla');
INSERT INTO "message" VALUES (28,E'tr-TR',E'Önerge Etiketi Oluştur');
INSERT INTO "message" VALUES (29,E'tr-TR',E'Uygulama Programlama Arayüzü');
INSERT INTO "message" VALUES (30,E'tr-TR',E'Yönetici');
INSERT INTO "message" VALUES (31,E'tr-TR',E'Mesajlar');
INSERT INTO "message" VALUES (32,E'tr-TR',E'Mesaj Oluştur');
INSERT INTO "message" VALUES (33,E'tr-TR',E'{count} adet Etiket değiştirildi');
INSERT INTO "message" VALUES (34,E'tr-TR',E'Dosya Söz Dizimi Hatalı');
INSERT INTO "message" VALUES (35,E'tr-TR',E'Önerge Etiketi');
INSERT INTO "message" VALUES (36,E'tr-TR',E'Tur');
INSERT INTO "message" VALUES (37,E'tr-TR',E'Kısaltma');
INSERT INTO "message" VALUES (38,E'tr-TR',NULL);
INSERT INTO "message" VALUES (39,E'tr-TR',E'Hükümet Açılış');
INSERT INTO "message" VALUES (40,E'tr-TR',E'Muhalefet Açılış');
INSERT INTO "message" VALUES (41,E'tr-TR',E'Hükümet Kapanış');
INSERT INTO "message" VALUES (42,E'tr-TR',E'Muhalefet Kapanış');
INSERT INTO "message" VALUES (43,E'tr-TR',E'Takım');
INSERT INTO "message" VALUES (44,E'tr-TR',E'Aktif');
INSERT INTO "message" VALUES (45,E'tr-TR',E'Turnuva');
INSERT INTO "message" VALUES (46,E'tr-TR',E'Konuşmacı');
INSERT INTO "message" VALUES (47,E'tr-TR',E'Topluluk');
INSERT INTO "message" VALUES (48,E'tr-TR',E'Gölge Takım');
INSERT INTO "message" VALUES (49,E'tr-TR',E'Dil Durumu');
INSERT INTO "message" VALUES (50,E'tr-TR',E'Her şey kontrol altında');
INSERT INTO "message" VALUES (51,E'tr-TR',E'Yerine bir gölge takım yerleştirildi');
INSERT INTO "message" VALUES (52,E'tr-TR',E'Konuşmacı {letter} maça katılmadı');
INSERT INTO "message" VALUES (53,E'tr-TR',NULL);
INSERT INTO "message" VALUES (54,E'tr-TR',E'Etiket');
INSERT INTO "message" VALUES (55,E'tr-TR',E'Değer');
INSERT INTO "message" VALUES (56,E'tr-TR',E'Takım pozisyonu boş bırakılamaz');
INSERT INTO "message" VALUES (57,E'tr-TR',NULL);
INSERT INTO "message" VALUES (58,E'tr-TR',E'Tabmaster Kullanıcısı');
INSERT INTO "message" VALUES (59,E'tr-TR',E'Kullanıcı');
INSERT INTO "message" VALUES (60,E'tr-TR',E'ENL Sıralaması');
INSERT INTO "message" VALUES (61,E'tr-TR',E'ESL Sıralaması');
INSERT INTO "message" VALUES (62,E'tr-TR',E'');
INSERT INTO "message" VALUES (63,E'tr-TR',E'Tam İsim');
INSERT INTO "message" VALUES (64,E'tr-TR',E'Kısaltma');
INSERT INTO "message" VALUES (65,E'tr-TR',E'Şehir');
INSERT INTO "message" VALUES (66,E'tr-TR',E'Ülke');
INSERT INTO "message" VALUES (67,E'tr-TR',E'HA Takımı');
INSERT INTO "message" VALUES (68,E'tr-TR',E'MA Takımı');
INSERT INTO "message" VALUES (69,E'tr-TR',E'HK Takımı');
INSERT INTO "message" VALUES (70,E'tr-TR',E'MK Takımı');
INSERT INTO "message" VALUES (71,E'tr-TR',E'Panel');
INSERT INTO "message" VALUES (72,E'tr-TR',E'Salon');
INSERT INTO "message" VALUES (73,E'tr-TR',E'HA Geri Bildirimi');
INSERT INTO "message" VALUES (74,E'tr-TR',E'MA Geri Bildirimi');
INSERT INTO "message" VALUES (75,E'tr-TR',E'HK Geri Bildirimi');
INSERT INTO "message" VALUES (76,E'tr-TR',E'MK Geri Bildirimi');
INSERT INTO "message" VALUES (77,E'tr-TR',E'Zaman');
INSERT INTO "message" VALUES (78,E'tr-TR',E'Önerge');
INSERT INTO "message" VALUES (79,E'tr-TR',E'Dil');
INSERT INTO "message" VALUES (80,E'tr-TR',E'Tarih');
INSERT INTO "message" VALUES (81,E'tr-TR',E'Bilgi Slaytı');
INSERT INTO "message" VALUES (82,E'tr-TR',E'Link');
INSERT INTO "message" VALUES (83,E'tr-TR',E'Kullanıcı Tarafından');
INSERT INTO "message" VALUES (84,E'tr-TR',E'Çeviri');
INSERT INTO "message" VALUES (85,E'tr-TR',E'Jüri');
INSERT INTO "message" VALUES (86,E'tr-TR',E'Cevap');
INSERT INTO "message" VALUES (87,E'tr-TR',E'Geri Bildirim');
INSERT INTO "message" VALUES (88,E'tr-TR',E'Soru');
INSERT INTO "message" VALUES (89,E'tr-TR',E'Oluşturuldu');
INSERT INTO "message" VALUES (90,E'tr-TR',E'Devam Ediyor');
INSERT INTO "message" VALUES (91,E'tr-TR',E'Kapandı');
INSERT INTO "message" VALUES (92,E'tr-TR',E'Gizlendi');
INSERT INTO "message" VALUES (93,E'tr-TR',E'Ev Sahibi:');
INSERT INTO "message" VALUES (94,E'tr-TR',E'Turnuva Adı');
INSERT INTO "message" VALUES (95,E'tr-TR',E'Başlangıç Tarihi');
INSERT INTO "message" VALUES (96,E'tr-TR',E'Bitiş Tarihi:');
INSERT INTO "message" VALUES (97,E'tr-TR',E'Zaman Dilimi');
INSERT INTO "message" VALUES (98,E'tr-TR',E'Logo');
INSERT INTO "message" VALUES (99,E'tr-TR',NULL);
INSERT INTO "message" VALUES (100,E'tr-TR',E'Tab Algoritması');
INSERT INTO "message" VALUES (101,E'tr-TR',E'Tahmini tur sayısı');
INSERT INTO "message" VALUES (102,E'tr-TR',E'ESL Sıralamasını Göster');
INSERT INTO "message" VALUES (103,E'tr-TR',E'Final turu var mı');
INSERT INTO "message" VALUES (104,E'tr-TR',E'Yarı final turu var mı');
INSERT INTO "message" VALUES (105,E'tr-TR',E'Çeyrek final turu var m?');
INSERT INTO "message" VALUES (106,E'tr-TR',E'Ön çeyrek final turu var mı');
INSERT INTO "message" VALUES (107,E'tr-TR',E'Erişim İşareti');
INSERT INTO "message" VALUES (108,E'tr-TR',E'Katılımcı Kimlik Kartı');
INSERT INTO "message" VALUES (109,E'tr-TR',NULL);
INSERT INTO "message" VALUES (110,E'tr-TR',NULL);
INSERT INTO "message" VALUES (111,E'tr-TR',E'Bölge');
INSERT INTO "message" VALUES (112,E'tr-TR',E'Dil Kodu');
INSERT INTO "message" VALUES (113,E'tr-TR',E'Kapsam');
INSERT INTO "message" VALUES (114,E'tr-TR',E'Son Düzenleme');
INSERT INTO "message" VALUES (115,E'tr-TR',E'Kuvvet');
INSERT INTO "message" VALUES (116,E'tr-TR',E'Salon Başkanlığı için uygun');
INSERT INTO "message" VALUES (117,E'tr-TR',E'İzleniyor');
INSERT INTO "message" VALUES (118,E'tr-TR',E'Değerlendirilmemiş');
INSERT INTO "message" VALUES (121,E'tr-TR',E'Jürilik için uygun');
INSERT INTO "message" VALUES (122,E'tr-TR',NULL);
INSERT INTO "message" VALUES (124,E'tr-TR',E'Yüksek Potansiyelli');
INSERT INTO "message" VALUES (125,E'tr-TR',E'Salon Başkanı');
INSERT INTO "message" VALUES (126,E'tr-TR',E'İyi');
INSERT INTO "message" VALUES (127,E'tr-TR',NULL);
INSERT INTO "message" VALUES (128,E'tr-TR',E'Jüri Komitesi Başkanı (CA)');
INSERT INTO "message" VALUES (129,E'tr-TR',NULL);
INSERT INTO "message" VALUES (130,E'tr-TR',NULL);
INSERT INTO "message" VALUES (131,E'tr-TR',E'Konuşmacı Puanları');
INSERT INTO "message" VALUES (132,E'tr-TR',E'Bu e-posta adresi kullanımda.');
INSERT INTO "message" VALUES (133,E'tr-TR',E'Münazır');
INSERT INTO "message" VALUES (134,E'tr-TR',E'Yetkilendirme Anahtarı');
INSERT INTO "message" VALUES (135,E'tr-TR',NULL);
INSERT INTO "message" VALUES (136,E'tr-TR',E'Parola Sıfırlama Anahtarı');
INSERT INTO "message" VALUES (137,E'tr-TR',E'e-posta');
INSERT INTO "message" VALUES (138,E'tr-TR',E'Hesap Türü');
INSERT INTO "message" VALUES (139,E'tr-TR',E'Hesap Durumu');
INSERT INTO "message" VALUES (140,E'tr-TR',E'Son Değişiklik');
INSERT INTO "message" VALUES (141,E'tr-TR',E'İsim');
INSERT INTO "message" VALUES (142,E'tr-TR',E'Soyisim');
INSERT INTO "message" VALUES (143,E'tr-TR',E'Fotoğraf');
INSERT INTO "message" VALUES (144,E'tr-TR',E'Vekil');
INSERT INTO "message" VALUES (145,E'tr-TR',E'Tabmaster');
INSERT INTO "message" VALUES (146,E'tr-TR',E'Yönetici');
INSERT INTO "message" VALUES (147,E'tr-TR',E'Silindi');
INSERT INTO "message" VALUES (148,E'tr-TR',E'Belirtmek istemiyor');
INSERT INTO "message" VALUES (149,E'tr-TR',E'Kadın');
INSERT INTO "message" VALUES (150,E'tr-TR',E'Erkek');
INSERT INTO "message" VALUES (151,E'tr-TR',E'Diğer');
INSERT INTO "message" VALUES (152,E'tr-TR',E'karışık');
INSERT INTO "message" VALUES (153,E'tr-TR',E'Daha belirlenmedi');
INSERT INTO "message" VALUES (154,E'tr-TR',E'Mülakat gerekli');
INSERT INTO "message" VALUES (155,E'tr-TR',E'EPL');
INSERT INTO "message" VALUES (157,E'tr-TR',E'ESL');
INSERT INTO "message" VALUES (158,E'tr-TR',E'İkinci dili İngilizce olan');
INSERT INTO "message" VALUES (159,E'tr-TR',E'EFL');
INSERT INTO "message" VALUES (160,E'tr-TR',E'Yabancı dili İngilizce olan');
INSERT INTO "message" VALUES (161,E'tr-TR',E'Belirlenmemiş');
INSERT INTO "message" VALUES (162,E'tr-TR',E'{user_name} Kullanıcısı İçin Kulüp İçi İlişkiyi Kaydetmede Hata');
INSERT INTO "message" VALUES (163,E'tr-TR',E'{user_name} Kullanıcısını Kaydetmede Hata');
INSERT INTO "message" VALUES (164,E'tr-TR',E'{tournament_name}: {user_name} için Kullanıcı Hesabı');
INSERT INTO "message" VALUES (165,E'tr-TR',E'Bu URL-Slug\'ı kullanmanız mümkün değil');
INSERT INTO "message" VALUES (166,E'tr-TR',E'Yayımlandı');
INSERT INTO "message" VALUES (167,E'tr-TR',E'Gösterildi');
INSERT INTO "message" VALUES (168,E'tr-TR',E'Başladı');
INSERT INTO "message" VALUES (169,E'tr-TR',NULL);
INSERT INTO "message" VALUES (170,E'tr-TR',E'Bitti');
INSERT INTO "message" VALUES (171,E'tr-TR',E'Ana');
INSERT INTO "message" VALUES (172,E'tr-TR',E'Çaylak');
INSERT INTO "message" VALUES (173,E'tr-TR',E'Final');
INSERT INTO "message" VALUES (174,E'tr-TR',E'Yarı Final');
INSERT INTO "message" VALUES (175,E'tr-TR',E'Çeyrek Final');
INSERT INTO "message" VALUES (176,E'tr-TR',E'Ön Çeyrek Final');
INSERT INTO "message" VALUES (177,E'tr-TR',E'Tur #{num}');
INSERT INTO "message" VALUES (178,E'tr-TR',E'Turlar');
INSERT INTO "message" VALUES (179,E'tr-TR',NULL);
INSERT INTO "message" VALUES (180,E'tr-TR',E'Bilgi Slaydı');
INSERT INTO "message" VALUES (181,E'tr-TR',E'Hazırlık Süresi Başladı');
INSERT INTO "message" VALUES (182,E'tr-TR',E'Ölçülen Son Sıcaklık');
INSERT INTO "message" VALUES (183,E'tr-TR',E'ms\'de hazırlandı');
INSERT INTO "message" VALUES (184,E'tr-TR',E'Bir salonu doldurmak için yeterli takım bulunmuyor - (aktif: {teams_count})');
INSERT INTO "message" VALUES (185,E'tr-TR',E'En az iki jüri gerekli - (aktif: {count_adju})');
INSERT INTO "message" VALUES (186,E'tr-TR',E'Aktif takım sayısı 4\'e bölünmeli ;) - (aktif: {count_teams})');
INSERT INTO "message" VALUES (187,E'tr-TR',E'Gereğinden az salon bulunuyor - (aktif: {active_rooms})');
INSERT INTO "message" VALUES (188,E'tr-TR',E'Yeteri kadar jüri bulunmuyor - (aktif: {active}, minimum: {required})');
INSERT INTO "message" VALUES (189,E'tr-TR',NULL);
INSERT INTO "message" VALUES (190,E'tr-TR',E'Paneli kaydederken hata: {message}');
INSERT INTO "message" VALUES (191,E'tr-TR',E'Maçı kaydederken hata: {message}');
INSERT INTO "message" VALUES (192,E'tr-TR',E'Maçı kaydederken hata:<br>{errors}');
INSERT INTO "message" VALUES (193,E'tr-TR',E'Güncellemek istediğiniz Maç #{num} bulunamadı.');
INSERT INTO "message" VALUES (195,E'tr-TR',NULL);
INSERT INTO "message" VALUES (196,E'tr-TR',NULL);
INSERT INTO "message" VALUES (197,E'tr-TR',NULL);
INSERT INTO "message" VALUES (198,E'tr-TR',NULL);
INSERT INTO "message" VALUES (199,E'tr-TR',NULL);
INSERT INTO "message" VALUES (200,E'tr-TR',E'İyi Değil');
INSERT INTO "message" VALUES (201,E'tr-TR',E'Oldukça İyi');
INSERT INTO "message" VALUES (202,E'tr-TR',E'Mükemmel');
INSERT INTO "message" VALUES (203,E'tr-TR',NULL);
INSERT INTO "message" VALUES (204,E'tr-TR',E'Kısa Metin Kutucuğu');
INSERT INTO "message" VALUES (205,E'tr-TR',E'Uzun Metin Kutucuğu');
INSERT INTO "message" VALUES (206,E'tr-TR',E'Sayı Kutucuğu');
INSERT INTO "message" VALUES (207,E'tr-TR',E'Onay Kutusu Listesi');
INSERT INTO "message" VALUES (208,E'tr-TR',E'Maç');
INSERT INTO "message" VALUES (209,E'tr-TR',E'Geri Bildirim: ID');
INSERT INTO "message" VALUES (210,E'tr-TR',NULL);
INSERT INTO "message" VALUES (211,E'tr-TR',NULL);
INSERT INTO "message" VALUES (212,E'tr-TR',E'Grup');
INSERT INTO "message" VALUES (213,E'tr-TR',E'Aktif Salon');
INSERT INTO "message" VALUES (214,E'tr-TR',E'Yan Jüri');
INSERT INTO "message" VALUES (215,E'tr-TR',E'Kullanıldı');
INSERT INTO "message" VALUES (216,E'tr-TR',E'Önceden Belirlenmiş Paneldir');
INSERT INTO "message" VALUES (217,E'tr-TR',E'Panel #{id}\'de {amount} Salon Başkanı var');
INSERT INTO "message" VALUES (218,E'tr-TR',E'Kategori');
INSERT INTO "message" VALUES (219,E'tr-TR',E'Mesaj');
INSERT INTO "message" VALUES (220,E'tr-TR',E'İşlev');
INSERT INTO "message" VALUES (221,E'tr-TR',NULL);
INSERT INTO "message" VALUES (222,E'tr-TR',NULL);
INSERT INTO "message" VALUES (223,E'tr-TR',NULL);
INSERT INTO "message" VALUES (224,E'tr-TR',NULL);
INSERT INTO "message" VALUES (225,E'tr-TR',NULL);
INSERT INTO "message" VALUES (226,E'tr-TR',NULL);
INSERT INTO "message" VALUES (227,E'tr-TR',NULL);
INSERT INTO "message" VALUES (228,E'tr-TR',E'HA A Konuşmacı Puanı');
INSERT INTO "message" VALUES (229,E'tr-TR',E'HA B Konuşmacı Puanı');
INSERT INTO "message" VALUES (230,E'tr-TR',E'HA Sıralama');
INSERT INTO "message" VALUES (231,E'tr-TR',E'MA A Konuşmacı Puanı');
INSERT INTO "message" VALUES (232,E'tr-TR',E'MA B Konuşmacı Puanı');
INSERT INTO "message" VALUES (233,E'tr-TR',E'MA Sıralama');
INSERT INTO "message" VALUES (234,E'tr-TR',E'HK A Konuşmacı Puanı');
INSERT INTO "message" VALUES (235,E'tr-TR',E'HK B Konuşmacı Puanı');
INSERT INTO "message" VALUES (236,E'tr-TR',E'HK Sıralama');
INSERT INTO "message" VALUES (237,E'tr-TR',E'MK A Konuşmacı Puanı');
INSERT INTO "message" VALUES (238,E'tr-TR',E'MK B Konuşmacı Puanı');
INSERT INTO "message" VALUES (239,E'tr-TR',E'MK Sıralama');
INSERT INTO "message" VALUES (240,E'tr-TR',E'Kontrol Edildi');
INSERT INTO "message" VALUES (241,E'tr-TR',E'Şu Kullanıcı Tarafından Girildi: ID');
INSERT INTO "message" VALUES (242,E'tr-TR',NULL);
INSERT INTO "message" VALUES (243,E'tr-TR',NULL);
INSERT INTO "message" VALUES (244,E'tr-TR',E'CA');
INSERT INTO "message" VALUES (245,E'tr-TR',E'Parola sıfırlama anahtarı boş bırakılamaz.');
INSERT INTO "message" VALUES (246,E'tr-TR',E'Parola sıfırlama anahtarı hatası.');
INSERT INTO "message" VALUES (247,E'tr-TR',NULL);
INSERT INTO "message" VALUES (248,E'tr-TR',NULL);
INSERT INTO "message" VALUES (249,E'tr-TR',NULL);
INSERT INTO "message" VALUES (250,E'tr-TR',E'CSV Dosyası');
INSERT INTO "message" VALUES (251,E'tr-TR',NULL);
INSERT INTO "message" VALUES (252,E'tr-TR',NULL);
INSERT INTO "message" VALUES (253,E'tr-TR',E'Kullanıcı Adı');
INSERT INTO "message" VALUES (254,E'tr-TR',E'Profil Fotoğrafı');
INSERT INTO "message" VALUES (255,E'tr-TR',E'Güncel Topluluk');
INSERT INTO "message" VALUES (256,E'tr-TR',E'Kendinizi hangi cinsiyet kategorisiyle en çok bağdaştırıyorsunuz');
INSERT INTO "message" VALUES (257,E'tr-TR',E'Bu URL kullanılamaz.');
INSERT INTO "message" VALUES (258,E'tr-TR',E'{adju} burada!');
INSERT INTO "message" VALUES (259,E'tr-TR',E'{adju} zaten yoklama vermişti');
INSERT INTO "message" VALUES (260,E'tr-TR',E'{id} numarası geçersiz! Bu kişi jüri değil!');
INSERT INTO "message" VALUES (261,E'tr-TR',E'{speaker} burada!');
INSERT INTO "message" VALUES (262,E'tr-TR',E'{speaker} zaten yoklama vermişti');
INSERT INTO "message" VALUES (263,E'tr-TR',E'{id} numarası geçersiz! Bu bir takım değil!');
INSERT INTO "message" VALUES (264,E'tr-TR',E'Geçerli bir girdi değil');
INSERT INTO "message" VALUES (265,E'tr-TR',E'Doğrulama Kodu');
INSERT INTO "message" VALUES (266,E'tr-TR',NULL);
INSERT INTO "message" VALUES (267,E'tr-TR',E'{user} için parola sıfırlama');
INSERT INTO "message" VALUES (268,E'tr-TR',E'Bu e-posta adresiyle bir kullanıcı bulunamadı');
INSERT INTO "message" VALUES (269,E'tr-TR',E'{object} Ekle');
INSERT INTO "message" VALUES (270,E'tr-TR',E'Topluluk Oluştur');
INSERT INTO "message" VALUES (271,E'tr-TR',NULL);
INSERT INTO "message" VALUES (272,E'tr-TR',NULL);
INSERT INTO "message" VALUES (273,E'tr-TR',E'Bir ülke ara ...');
INSERT INTO "message" VALUES (274,E'tr-TR',E'Yeni Topluluk Ekle');
INSERT INTO "message" VALUES (275,E'tr-TR',E'Bir topluluk ara ...');
INSERT INTO "message" VALUES (276,E'tr-TR',E'Başlangıç tarihini gir ...');
INSERT INTO "message" VALUES (277,E'tr-TR',E'Eğer mümkünse bitiş tarihini gir ...');
INSERT INTO "message" VALUES (278,E'tr-TR',E'Dil Görevlileri');
INSERT INTO "message" VALUES (279,E'tr-TR',E'Görevli');
INSERT INTO "message" VALUES (280,E'tr-TR',NULL);
INSERT INTO "message" VALUES (281,E'tr-TR',E'Dil Durumunu Gözden Geçirme');
INSERT INTO "message" VALUES (282,E'tr-TR',E'Durum');
INSERT INTO "message" VALUES (283,E'tr-TR',E'Bir mülakat iste');
INSERT INTO "message" VALUES (284,E'tr-TR',NULL);
INSERT INTO "message" VALUES (285,E'tr-TR',NULL);
INSERT INTO "message" VALUES (286,E'tr-TR',NULL);
INSERT INTO "message" VALUES (288,E'tr-TR',NULL);
INSERT INTO "message" VALUES (289,E'tr-TR',NULL);
INSERT INTO "message" VALUES (290,E'tr-TR',E'Yoklama');
INSERT INTO "message" VALUES (291,E'tr-TR',NULL);
INSERT INTO "message" VALUES (292,E'tr-TR',NULL);
INSERT INTO "message" VALUES (293,E'tr-TR',NULL);
INSERT INTO "message" VALUES (294,E'tr-TR',NULL);
INSERT INTO "message" VALUES (295,E'tr-TR',NULL);
INSERT INTO "message" VALUES (296,E'tr-TR',NULL);
INSERT INTO "message" VALUES (297,E'tr-TR',NULL);
INSERT INTO "message" VALUES (298,E'tr-TR',NULL);
INSERT INTO "message" VALUES (299,E'tr-TR',NULL);
INSERT INTO "message" VALUES (300,E'tr-TR',NULL);
INSERT INTO "message" VALUES (301,E'tr-TR',NULL);
INSERT INTO "message" VALUES (302,E'tr-TR',NULL);
INSERT INTO "message" VALUES (303,E'tr-TR',NULL);
INSERT INTO "message" VALUES (304,E'tr-TR',NULL);
INSERT INTO "message" VALUES (305,E'tr-TR',NULL);
INSERT INTO "message" VALUES (307,E'tr-TR',NULL);
INSERT INTO "message" VALUES (308,E'tr-TR',NULL);
INSERT INTO "message" VALUES (309,E'tr-TR',NULL);
INSERT INTO "message" VALUES (310,E'tr-TR',NULL);
INSERT INTO "message" VALUES (311,E'tr-TR',NULL);
INSERT INTO "message" VALUES (312,E'tr-TR',NULL);
INSERT INTO "message" VALUES (313,E'tr-TR',NULL);
INSERT INTO "message" VALUES (314,E'tr-TR',NULL);
INSERT INTO "message" VALUES (315,E'tr-TR',NULL);
INSERT INTO "message" VALUES (316,E'tr-TR',NULL);
INSERT INTO "message" VALUES (317,E'tr-TR',NULL);
INSERT INTO "message" VALUES (318,E'tr-TR',NULL);
INSERT INTO "message" VALUES (319,E'tr-TR',NULL);
INSERT INTO "message" VALUES (320,E'tr-TR',NULL);
INSERT INTO "message" VALUES (321,E'tr-TR',NULL);
INSERT INTO "message" VALUES (322,E'tr-TR',NULL);
INSERT INTO "message" VALUES (323,E'tr-TR',NULL);
INSERT INTO "message" VALUES (325,E'tr-TR',NULL);
INSERT INTO "message" VALUES (326,E'tr-TR',NULL);
INSERT INTO "message" VALUES (327,E'tr-TR',NULL);
INSERT INTO "message" VALUES (328,E'tr-TR',NULL);
INSERT INTO "message" VALUES (329,E'tr-TR',NULL);
INSERT INTO "message" VALUES (330,E'tr-TR',NULL);
INSERT INTO "message" VALUES (331,E'tr-TR',NULL);
INSERT INTO "message" VALUES (332,E'tr-TR',NULL);
INSERT INTO "message" VALUES (333,E'tr-TR',NULL);
INSERT INTO "message" VALUES (334,E'tr-TR',NULL);
INSERT INTO "message" VALUES (335,E'tr-TR',NULL);
INSERT INTO "message" VALUES (336,E'tr-TR',NULL);
INSERT INTO "message" VALUES (337,E'tr-TR',NULL);
INSERT INTO "message" VALUES (338,E'tr-TR',NULL);
INSERT INTO "message" VALUES (339,E'tr-TR',NULL);
INSERT INTO "message" VALUES (340,E'tr-TR',NULL);
INSERT INTO "message" VALUES (341,E'tr-TR',NULL);
INSERT INTO "message" VALUES (342,E'tr-TR',NULL);
INSERT INTO "message" VALUES (343,E'tr-TR',NULL);
INSERT INTO "message" VALUES (344,E'tr-TR',NULL);
INSERT INTO "message" VALUES (345,E'tr-TR',NULL);
INSERT INTO "message" VALUES (346,E'tr-TR',NULL);
INSERT INTO "message" VALUES (347,E'tr-TR',NULL);
INSERT INTO "message" VALUES (348,E'tr-TR',NULL);
INSERT INTO "message" VALUES (349,E'tr-TR',NULL);
INSERT INTO "message" VALUES (350,E'tr-TR',NULL);
INSERT INTO "message" VALUES (351,E'tr-TR',NULL);
INSERT INTO "message" VALUES (352,E'tr-TR',NULL);
INSERT INTO "message" VALUES (353,E'tr-TR',NULL);
INSERT INTO "message" VALUES (354,E'tr-TR',NULL);
INSERT INTO "message" VALUES (355,E'tr-TR',NULL);
INSERT INTO "message" VALUES (356,E'tr-TR',NULL);
INSERT INTO "message" VALUES (357,E'tr-TR',NULL);
INSERT INTO "message" VALUES (358,E'tr-TR',NULL);
INSERT INTO "message" VALUES (359,E'tr-TR',NULL);
INSERT INTO "message" VALUES (360,E'tr-TR',NULL);
INSERT INTO "message" VALUES (361,E'tr-TR',NULL);
INSERT INTO "message" VALUES (362,E'tr-TR',NULL);
INSERT INTO "message" VALUES (363,E'tr-TR',NULL);
INSERT INTO "message" VALUES (364,E'tr-TR',NULL);
INSERT INTO "message" VALUES (365,E'tr-TR',NULL);
INSERT INTO "message" VALUES (366,E'tr-TR',NULL);
INSERT INTO "message" VALUES (367,E'tr-TR',NULL);
INSERT INTO "message" VALUES (368,E'tr-TR',NULL);
INSERT INTO "message" VALUES (369,E'tr-TR',NULL);
INSERT INTO "message" VALUES (370,E'tr-TR',NULL);
INSERT INTO "message" VALUES (371,E'tr-TR',NULL);
INSERT INTO "message" VALUES (372,E'tr-TR',NULL);
INSERT INTO "message" VALUES (373,E'tr-TR',NULL);
INSERT INTO "message" VALUES (374,E'tr-TR',NULL);
INSERT INTO "message" VALUES (375,E'tr-TR',NULL);
INSERT INTO "message" VALUES (376,E'tr-TR',NULL);
INSERT INTO "message" VALUES (377,E'tr-TR',NULL);
INSERT INTO "message" VALUES (378,E'tr-TR',NULL);
INSERT INTO "message" VALUES (379,E'tr-TR',NULL);
INSERT INTO "message" VALUES (380,E'tr-TR',NULL);
INSERT INTO "message" VALUES (381,E'tr-TR',NULL);
INSERT INTO "message" VALUES (382,E'tr-TR',NULL);
INSERT INTO "message" VALUES (383,E'tr-TR',NULL);
INSERT INTO "message" VALUES (384,E'tr-TR',NULL);
INSERT INTO "message" VALUES (385,E'tr-TR',NULL);
INSERT INTO "message" VALUES (386,E'tr-TR',NULL);
INSERT INTO "message" VALUES (387,E'tr-TR',NULL);
INSERT INTO "message" VALUES (388,E'tr-TR',NULL);
INSERT INTO "message" VALUES (389,E'tr-TR',NULL);
INSERT INTO "message" VALUES (390,E'tr-TR',NULL);
INSERT INTO "message" VALUES (391,E'tr-TR',NULL);
INSERT INTO "message" VALUES (392,E'tr-TR',NULL);
INSERT INTO "message" VALUES (393,E'tr-TR',NULL);
INSERT INTO "message" VALUES (394,E'tr-TR',NULL);
INSERT INTO "message" VALUES (395,E'tr-TR',NULL);
INSERT INTO "message" VALUES (396,E'tr-TR',NULL);
INSERT INTO "message" VALUES (397,E'tr-TR',NULL);
INSERT INTO "message" VALUES (398,E'tr-TR',NULL);
INSERT INTO "message" VALUES (399,E'tr-TR',NULL);
INSERT INTO "message" VALUES (400,E'tr-TR',NULL);
INSERT INTO "message" VALUES (401,E'tr-TR',NULL);
INSERT INTO "message" VALUES (402,E'tr-TR',NULL);
INSERT INTO "message" VALUES (403,E'tr-TR',NULL);
INSERT INTO "message" VALUES (404,E'tr-TR',NULL);
INSERT INTO "message" VALUES (405,E'tr-TR',NULL);
INSERT INTO "message" VALUES (407,E'tr-TR',NULL);
INSERT INTO "message" VALUES (408,E'tr-TR',NULL);
INSERT INTO "message" VALUES (411,E'tr-TR',NULL);
INSERT INTO "message" VALUES (412,E'tr-TR',NULL);
INSERT INTO "message" VALUES (413,E'tr-TR',NULL);
INSERT INTO "message" VALUES (414,E'tr-TR',NULL);
INSERT INTO "message" VALUES (415,E'tr-TR',E'Cinsiyet');
INSERT INTO "message" VALUES (416,E'tr-TR',NULL);
INSERT INTO "message" VALUES (417,E'tr-TR',NULL);
INSERT INTO "message" VALUES (418,E'tr-TR',E'Yükleniyor ...');
INSERT INTO "message" VALUES (419,E'tr-TR',E'Geri Bildirimi Görüntüle');
INSERT INTO "message" VALUES (420,E'tr-TR',E'Kullanıcıyı Görüntüle');
INSERT INTO "message" VALUES (421,E'tr-TR',E'{venue} salonunu şununla değiştir:');
INSERT INTO "message" VALUES (422,E'tr-TR',E'Bir Salon Seç ...');
INSERT INTO "message" VALUES (423,E'tr-TR',NULL);
INSERT INTO "message" VALUES (424,E'tr-TR',NULL);
INSERT INTO "message" VALUES (425,E'tr-TR',E'Bir Takım Seç ...');
INSERT INTO "message" VALUES (426,E'tr-TR',E'Bir Dil Seç ...');
INSERT INTO "message" VALUES (427,E'tr-TR',E'Bir Jüri Seç ...');
INSERT INTO "message" VALUES (428,E'tr-TR',E'Jürileri Değiştir');
INSERT INTO "message" VALUES (429,E'tr-TR',NULL);
INSERT INTO "message" VALUES (430,E'tr-TR',E'ile');
INSERT INTO "message" VALUES (431,E'tr-TR',E'bununla ...');
INSERT INTO "message" VALUES (432,E'tr-TR',E'Bir Önerge Etiketi Ara ...');
INSERT INTO "message" VALUES (433,E'tr-TR',E'Sıralama');
INSERT INTO "message" VALUES (434,E'tr-TR',E'Toplam');
INSERT INTO "message" VALUES (435,E'tr-TR',NULL);
INSERT INTO "message" VALUES (436,E'tr-TR',E'Salon');
INSERT INTO "message" VALUES (437,E'tr-TR',E'Final Turları');
INSERT INTO "message" VALUES (438,E'tr-TR',NULL);
INSERT INTO "message" VALUES (439,E'tr-TR',NULL);
INSERT INTO "message" VALUES (440,E'tr-TR',NULL);
INSERT INTO "message" VALUES (441,E'tr-TR',NULL);
INSERT INTO "message" VALUES (442,E'tr-TR',NULL);
INSERT INTO "message" VALUES (443,E'tr-TR',NULL);
INSERT INTO "message" VALUES (444,E'tr-TR',NULL);
INSERT INTO "message" VALUES (445,E'tr-TR',NULL);
INSERT INTO "message" VALUES (446,E'tr-TR',NULL);
INSERT INTO "message" VALUES (447,E'tr-TR',NULL);
INSERT INTO "message" VALUES (448,E'tr-TR',NULL);
INSERT INTO "message" VALUES (449,E'tr-TR',NULL);
INSERT INTO "message" VALUES (450,E'tr-TR',NULL);
INSERT INTO "message" VALUES (451,E'tr-TR',NULL);
INSERT INTO "message" VALUES (452,E'tr-TR',NULL);
INSERT INTO "message" VALUES (453,E'tr-TR',NULL);
INSERT INTO "message" VALUES (454,E'tr-TR',NULL);
INSERT INTO "message" VALUES (455,E'tr-TR',NULL);
INSERT INTO "message" VALUES (456,E'tr-TR',NULL);
INSERT INTO "message" VALUES (457,E'tr-TR',NULL);
INSERT INTO "message" VALUES (458,E'tr-TR',NULL);
INSERT INTO "message" VALUES (459,E'tr-TR',NULL);
INSERT INTO "message" VALUES (460,E'tr-TR',NULL);
INSERT INTO "message" VALUES (461,E'tr-TR',NULL);
INSERT INTO "message" VALUES (462,E'tr-TR',E'Teşekkürler');
INSERT INTO "message" VALUES (463,E'tr-TR',E'Teşekkürler!');
INSERT INTO "message" VALUES (464,E'tr-TR',NULL);
INSERT INTO "message" VALUES (465,E'tr-TR',NULL);
INSERT INTO "message" VALUES (466,E'tr-TR',NULL);
INSERT INTO "message" VALUES (467,E'tr-TR',NULL);
INSERT INTO "message" VALUES (468,E'tr-TR',NULL);
INSERT INTO "message" VALUES (469,E'tr-TR',NULL);
INSERT INTO "message" VALUES (470,E'tr-TR',NULL);
INSERT INTO "message" VALUES (471,E'tr-TR',NULL);
INSERT INTO "message" VALUES (472,E'tr-TR',NULL);
INSERT INTO "message" VALUES (473,E'tr-TR',NULL);
INSERT INTO "message" VALUES (474,E'tr-TR',E'Jüri Geri Bildirimi');
INSERT INTO "message" VALUES (475,E'tr-TR',E'Geri Bildirim Yolla');
INSERT INTO "message" VALUES (476,E'tr-TR',NULL);
INSERT INTO "message" VALUES (477,E'tr-TR',E'Dil Durumunu Gözden Geçir');
INSERT INTO "message" VALUES (478,E'tr-TR',NULL);
INSERT INTO "message" VALUES (479,E'tr-TR',NULL);
INSERT INTO "message" VALUES (480,E'tr-TR',E'{tournament} - Yönetici');
INSERT INTO "message" VALUES (481,E'tr-TR',E'Salonları Listele');
INSERT INTO "message" VALUES (482,E'tr-TR',E'Salon Oluştur');
INSERT INTO "message" VALUES (483,E'tr-TR',E'Salonları İçeri Aktar');
INSERT INTO "message" VALUES (484,E'tr-TR',E'Takımları Listele');
INSERT INTO "message" VALUES (485,E'tr-TR',E'Takım Oluştur');
INSERT INTO "message" VALUES (486,E'tr-TR',E'Takımları İçeri Aktar');
INSERT INTO "message" VALUES (487,E'tr-TR',NULL);
INSERT INTO "message" VALUES (488,E'tr-TR',NULL);
INSERT INTO "message" VALUES (489,E'tr-TR',NULL);
INSERT INTO "message" VALUES (490,E'tr-TR',NULL);
INSERT INTO "message" VALUES (491,E'tr-TR',NULL);
INSERT INTO "message" VALUES (492,E'tr-TR',NULL);
INSERT INTO "message" VALUES (493,E'tr-TR',NULL);
INSERT INTO "message" VALUES (494,E'tr-TR',NULL);
INSERT INTO "message" VALUES (495,E'tr-TR',NULL);
INSERT INTO "message" VALUES (496,E'tr-TR',NULL);
INSERT INTO "message" VALUES (497,E'tr-TR',NULL);
INSERT INTO "message" VALUES (498,E'tr-TR',NULL);
INSERT INTO "message" VALUES (499,E'tr-TR',NULL);
INSERT INTO "message" VALUES (500,E'tr-TR',NULL);
INSERT INTO "message" VALUES (501,E'tr-TR',NULL);
INSERT INTO "message" VALUES (502,E'tr-TR',NULL);
INSERT INTO "message" VALUES (503,E'tr-TR',NULL);
INSERT INTO "message" VALUES (504,E'tr-TR',NULL);
INSERT INTO "message" VALUES (505,E'tr-TR',NULL);
INSERT INTO "message" VALUES (506,E'tr-TR',NULL);
INSERT INTO "message" VALUES (507,E'tr-TR',NULL);
INSERT INTO "message" VALUES (508,E'tr-TR',NULL);
INSERT INTO "message" VALUES (509,E'tr-TR',NULL);
INSERT INTO "message" VALUES (510,E'tr-TR',NULL);
INSERT INTO "message" VALUES (511,E'tr-TR',NULL);
INSERT INTO "message" VALUES (512,E'tr-TR',NULL);
INSERT INTO "message" VALUES (513,E'tr-TR',NULL);
INSERT INTO "message" VALUES (514,E'tr-TR',NULL);
INSERT INTO "message" VALUES (515,E'tr-TR',NULL);
INSERT INTO "message" VALUES (516,E'tr-TR',NULL);
INSERT INTO "message" VALUES (517,E'tr-TR',NULL);
INSERT INTO "message" VALUES (518,E'tr-TR',NULL);
INSERT INTO "message" VALUES (519,E'tr-TR',NULL);
INSERT INTO "message" VALUES (520,E'tr-TR',NULL);
INSERT INTO "message" VALUES (521,E'tr-TR',NULL);
INSERT INTO "message" VALUES (522,E'tr-TR',NULL);
INSERT INTO "message" VALUES (524,E'tr-TR',NULL);
INSERT INTO "message" VALUES (525,E'tr-TR',NULL);
INSERT INTO "message" VALUES (526,E'tr-TR',NULL);
INSERT INTO "message" VALUES (527,E'tr-TR',NULL);
INSERT INTO "message" VALUES (529,E'tr-TR',NULL);
INSERT INTO "message" VALUES (530,E'tr-TR',NULL);
INSERT INTO "message" VALUES (531,E'tr-TR',NULL);
INSERT INTO "message" VALUES (532,E'tr-TR',NULL);
INSERT INTO "message" VALUES (533,E'tr-TR',NULL);
INSERT INTO "message" VALUES (534,E'tr-TR',NULL);
INSERT INTO "message" VALUES (535,E'tr-TR',NULL);
INSERT INTO "message" VALUES (536,E'tr-TR',NULL);
INSERT INTO "message" VALUES (537,E'tr-TR',NULL);
INSERT INTO "message" VALUES (538,E'tr-TR',NULL);
INSERT INTO "message" VALUES (539,E'tr-TR',NULL);
INSERT INTO "message" VALUES (540,E'tr-TR',NULL);
INSERT INTO "message" VALUES (541,E'tr-TR',NULL);
INSERT INTO "message" VALUES (542,E'tr-TR',NULL);
INSERT INTO "message" VALUES (543,E'tr-TR',NULL);
INSERT INTO "message" VALUES (544,E'tr-TR',NULL);
INSERT INTO "message" VALUES (545,E'tr-TR',NULL);
INSERT INTO "message" VALUES (546,E'tr-TR',E'Takım Yorumları');
INSERT INTO "message" VALUES (547,E'tr-TR',NULL);
INSERT INTO "message" VALUES (548,E'tr-TR',NULL);
INSERT INTO "message" VALUES (549,E'tr-TR',NULL);
INSERT INTO "message" VALUES (550,E'tr-TR',NULL);
INSERT INTO "message" VALUES (551,E'tr-TR',NULL);
INSERT INTO "message" VALUES (552,E'tr-TR',NULL);
INSERT INTO "message" VALUES (553,E'tr-TR',NULL);
INSERT INTO "message" VALUES (554,E'tr-TR',NULL);
INSERT INTO "message" VALUES (555,E'tr-TR',NULL);
INSERT INTO "message" VALUES (556,E'tr-TR',NULL);
INSERT INTO "message" VALUES (557,E'tr-TR',NULL);
INSERT INTO "message" VALUES (558,E'tr-TR',NULL);
INSERT INTO "message" VALUES (559,E'tr-TR',NULL);
INSERT INTO "message" VALUES (560,E'tr-TR',NULL);
INSERT INTO "message" VALUES (561,E'tr-TR',NULL);
INSERT INTO "message" VALUES (562,E'tr-TR',NULL);
INSERT INTO "message" VALUES (563,E'tr-TR',NULL);
INSERT INTO "message" VALUES (564,E'tr-TR',NULL);
INSERT INTO "message" VALUES (565,E'tr-TR',NULL);
INSERT INTO "message" VALUES (566,E'tr-TR',NULL);
INSERT INTO "message" VALUES (567,E'tr-TR',E'Münazara Topluluğu Geçmişi');
INSERT INTO "message" VALUES (568,E'tr-TR',E'Geçmişe yeni topluluk ekle');
INSERT INTO "message" VALUES (569,E'tr-TR',E'hala aktif');
INSERT INTO "message" VALUES (570,E'tr-TR',E'Topluluk Bilgisini Güncelle');
INSERT INTO "message" VALUES (571,E'tr-TR',E'{name}\'i yeni parola almaya zorla');
INSERT INTO "message" VALUES (572,E'tr-TR',E'İptal');
INSERT INTO "message" VALUES (573,E'tr-TR',E'Bir Turnuva Ara ...');
INSERT INTO "message" VALUES (574,E'tr-TR',E'Yeni Parola Belirle');
INSERT INTO "message" VALUES (575,E'tr-TR',E'Kullanıcıyı Güncelle');
INSERT INTO "message" VALUES (576,E'tr-TR',E'Kullanıcıyı Sil');
INSERT INTO "message" VALUES (577,E'tr-TR',E'Kullanıcı Oluştur');
INSERT INTO "message" VALUES (578,E'tr-TR',NULL);
INSERT INTO "message" VALUES (579,E'tr-TR',NULL);
INSERT INTO "message" VALUES (580,E'tr-TR',NULL);
INSERT INTO "message" VALUES (582,E'tr-TR',E'Uygun dosya bulunamad?');
INSERT INTO "message" VALUES (583,E'tr-TR',E'E?le?en sonuç bulunamad?');
INSERT INTO "message" VALUES (584,E'tr-TR',NULL);
INSERT INTO "message" VALUES (585,E'tr-TR',NULL);
INSERT INTO "message" VALUES (586,E'tr-TR',NULL);
INSERT INTO "message" VALUES (587,E'tr-TR',NULL);
INSERT INTO "message" VALUES (588,E'tr-TR',NULL);
INSERT INTO "message" VALUES (589,E'tr-TR',NULL);
INSERT INTO "message" VALUES (590,E'tr-TR',E'Kullanıcı kaydedildi! Hoşgeldin {user}');
INSERT INTO "message" VALUES (591,E'tr-TR',E'Giriş başarısız!');
INSERT INTO "message" VALUES (592,E'tr-TR',E'Daha fazla yönlendirme için e-posta kutunuzu ziyaret edin');
INSERT INTO "message" VALUES (593,E'tr-TR',NULL);
INSERT INTO "message" VALUES (594,E'tr-TR',NULL);
INSERT INTO "message" VALUES (595,E'tr-TR',NULL);
INSERT INTO "message" VALUES (596,E'tr-TR',NULL);
INSERT INTO "message" VALUES (597,E'tr-TR',NULL);
INSERT INTO "message" VALUES (598,E'tr-TR',NULL);
INSERT INTO "message" VALUES (599,E'tr-TR',NULL);
INSERT INTO "message" VALUES (600,E'tr-TR',NULL);
INSERT INTO "message" VALUES (601,E'tr-TR',NULL);
INSERT INTO "message" VALUES (602,E'tr-TR',NULL);
INSERT INTO "message" VALUES (603,E'tr-TR',NULL);
INSERT INTO "message" VALUES (604,E'tr-TR',NULL);
INSERT INTO "message" VALUES (605,E'tr-TR',NULL);
INSERT INTO "message" VALUES (606,E'tr-TR',NULL);
INSERT INTO "message" VALUES (607,E'tr-TR',NULL);
INSERT INTO "message" VALUES (608,E'tr-TR',NULL);
INSERT INTO "message" VALUES (609,E'tr-TR',NULL);
INSERT INTO "message" VALUES (610,E'tr-TR',NULL);
INSERT INTO "message" VALUES (611,E'tr-TR',NULL);
INSERT INTO "message" VALUES (613,E'tr-TR',NULL);
INSERT INTO "message" VALUES (614,E'tr-TR',NULL);
INSERT INTO "message" VALUES (615,E'tr-TR',NULL);
INSERT INTO "message" VALUES (616,E'tr-TR',NULL);
INSERT INTO "message" VALUES (617,E'tr-TR',NULL);
INSERT INTO "message" VALUES (618,E'tr-TR',NULL);
INSERT INTO "message" VALUES (619,E'tr-TR',NULL);
INSERT INTO "message" VALUES (620,E'tr-TR',NULL);
INSERT INTO "message" VALUES (622,E'tr-TR',NULL);
INSERT INTO "message" VALUES (623,E'tr-TR',NULL);
INSERT INTO "message" VALUES (624,E'tr-TR',NULL);
INSERT INTO "message" VALUES (625,E'tr-TR',NULL);
INSERT INTO "message" VALUES (626,E'tr-TR',NULL);
INSERT INTO "message" VALUES (627,E'tr-TR',NULL);
INSERT INTO "message" VALUES (628,E'tr-TR',NULL);
INSERT INTO "message" VALUES (629,E'tr-TR',NULL);
INSERT INTO "message" VALUES (630,E'tr-TR',NULL);
INSERT INTO "message" VALUES (631,E'tr-TR',NULL);
INSERT INTO "message" VALUES (632,E'tr-TR',NULL);
INSERT INTO "message" VALUES (633,E'tr-TR',NULL);
INSERT INTO "message" VALUES (634,E'tr-TR',NULL);
INSERT INTO "message" VALUES (635,E'tr-TR',NULL);
INSERT INTO "message" VALUES (636,E'tr-TR',NULL);
INSERT INTO "message" VALUES (637,E'tr-TR',NULL);
INSERT INTO "message" VALUES (638,E'tr-TR',NULL);
INSERT INTO "message" VALUES (639,E'tr-TR',NULL);
INSERT INTO "message" VALUES (640,E'tr-TR',NULL);
INSERT INTO "message" VALUES (641,E'tr-TR',NULL);
INSERT INTO "message" VALUES (642,E'tr-TR',NULL);
INSERT INTO "message" VALUES (643,E'tr-TR',NULL);
INSERT INTO "message" VALUES (644,E'tr-TR',NULL);
INSERT INTO "message" VALUES (645,E'tr-TR',NULL);
INSERT INTO "message" VALUES (646,E'tr-TR',NULL);
INSERT INTO "message" VALUES (647,E'tr-TR',NULL);
INSERT INTO "message" VALUES (648,E'tr-TR',NULL);
INSERT INTO "message" VALUES (649,E'tr-TR',E'Dil seçenekleri kaydedildi');
INSERT INTO "message" VALUES (650,E'tr-TR',E'Dil seçeneklerini kaydetmede hata');
INSERT INTO "message" VALUES (651,E'tr-TR',E'Kullanıcı bulunamadı!');
INSERT INTO "message" VALUES (652,E'tr-TR',E'{object} başarıyla eklendi');
INSERT INTO "message" VALUES (653,E'tr-TR',E'Başarıyla silindi');
INSERT INTO "message" VALUES (654,E'tr-TR',NULL);
INSERT INTO "message" VALUES (656,E'tr-TR',E'Sonuçların kaydedilmesinde hata.<br>Lütfen basılı sonuç kağıdı isteyin.');
INSERT INTO "message" VALUES (657,E'tr-TR',E'Sonuçlar kaydedildi. Sıradaki!');
INSERT INTO "message" VALUES (658,E'tr-TR',NULL);
INSERT INTO "message" VALUES (659,E'tr-TR',NULL);
INSERT INTO "message" VALUES (660,E'tr-TR',NULL);
INSERT INTO "message" VALUES (661,E'tr-TR',NULL);
INSERT INTO "message" VALUES (662,E'tr-TR',NULL);
INSERT INTO "message" VALUES (663,E'tr-TR',E'Yeterli sayıda salon mevcut değil');
INSERT INTO "message" VALUES (664,E'tr-TR',E'Gereğinden fazla sayıda salon var');
INSERT INTO "message" VALUES (665,E'tr-TR',NULL);
INSERT INTO "message" VALUES (666,E'tr-TR',NULL);
INSERT INTO "message" VALUES (667,E'tr-TR',NULL);
INSERT INTO "message" VALUES (668,E'tr-TR',NULL);
INSERT INTO "message" VALUES (669,E'tr-TR',NULL);
INSERT INTO "message" VALUES (670,E'tr-TR',NULL);
INSERT INTO "message" VALUES (671,E'tr-TR',E'Jüri daha önce bu takımı gördü');
INSERT INTO "message" VALUES (672,E'tr-TR',E'Jüri daha önce bu kombinasyonu izledi');
INSERT INTO "message" VALUES (673,E'tr-TR',NULL);
INSERT INTO "message" VALUES (674,E'tr-TR',NULL);
INSERT INTO "message" VALUES (675,E'tr-TR',E'Jüri {adju} ve {team} aynı topluluğa mensuplar.');
INSERT INTO "message" VALUES (676,E'tr-TR',NULL);
INSERT INTO "message" VALUES (677,E'tr-TR',NULL);
INSERT INTO "message" VALUES (678,E'tr-TR',NULL);
INSERT INTO "message" VALUES (679,E'tr-TR',NULL);
INSERT INTO "message" VALUES (680,E'tr-TR',NULL);
INSERT INTO "message" VALUES (681,E'tr-TR',NULL);
INSERT INTO "message" VALUES (682,E'tr-TR',NULL);
INSERT INTO "message" VALUES (686,E'tr-TR',E'Tanımlanmamış');
INSERT INTO "message" VALUES (687,E'tr-TR',E'Kuzey Avrupa');
INSERT INTO "message" VALUES (688,E'tr-TR',E'Batı Avrupa');
INSERT INTO "message" VALUES (689,E'tr-TR',E'Güney Avrupa');
INSERT INTO "message" VALUES (690,E'tr-TR',E'Doğu Avrupa');
INSERT INTO "message" VALUES (691,E'tr-TR',E'Orta Asya');
INSERT INTO "message" VALUES (692,E'tr-TR',E'Doğu Asya');
INSERT INTO "message" VALUES (693,E'tr-TR',E'Batı Asya');
INSERT INTO "message" VALUES (694,E'tr-TR',E'Güney Asya');
INSERT INTO "message" VALUES (695,E'tr-TR',E'Güneydoğu Asya');
INSERT INTO "message" VALUES (696,E'tr-TR',E'Avustralya ve Yeni Zelanda');
INSERT INTO "message" VALUES (697,E'tr-TR',E'Mikronezya');
INSERT INTO "message" VALUES (698,E'tr-TR',E'Melanezya');
INSERT INTO "message" VALUES (699,E'tr-TR',E'Polinezya');
INSERT INTO "message" VALUES (700,E'tr-TR',E'Kuzey Afrika');
INSERT INTO "message" VALUES (701,E'tr-TR',E'Batı Afrika');
INSERT INTO "message" VALUES (702,E'tr-TR',E'Orta Afrika');
INSERT INTO "message" VALUES (703,E'tr-TR',E'Doğu Afrika');
INSERT INTO "message" VALUES (704,E'tr-TR',E'Güney Afrika');
INSERT INTO "message" VALUES (705,E'tr-TR',E'Kuzey Amerika');
INSERT INTO "message" VALUES (706,E'tr-TR',E'Orta Amerika');
INSERT INTO "message" VALUES (707,E'tr-TR',E'Karayipler');
INSERT INTO "message" VALUES (708,E'tr-TR',E'Güney Amerika');
INSERT INTO "message" VALUES (709,E'tr-TR',E'Antarktika');
INSERT INTO "message" VALUES (710,E'tr-TR',E'Cezalı Jüri Üyesi');
INSERT INTO "message" VALUES (711,E'tr-TR',E'Kötü Jüri Üyesi');
INSERT INTO "message" VALUES (712,E'tr-TR',E'Vasat Jüri Üyesi');
INSERT INTO "message" VALUES (713,E'tr-TR',E'Ortalama Jüri Üyesi');
INSERT INTO "message" VALUES (714,E'tr-TR',E'Ortalama Salon Başkanı');
INSERT INTO "message" VALUES (715,E'tr-TR',E'İyi Salon Başkanı');
INSERT INTO "message" VALUES (716,E'tr-TR',NULL);
INSERT INTO "message" VALUES (717,E'tr-TR',E'<b>Bu turnuvanın takımları henüz eklenmemiş.</b><br>{add_button} ya da {import_button}');
INSERT INTO "message" VALUES (718,E'tr-TR',E'Takım ekle');
INSERT INTO "message" VALUES (719,E'tr-TR',E'CSV dosyası aracılığıyla içeri aktar');
INSERT INTO "message" VALUES (720,E'tr-TR',E'Bu turnuvanın salonları henüz girilmemiş.<br>{add} ya da {import}');
INSERT INTO "message" VALUES (721,E'tr-TR',E'Salon ekle');
INSERT INTO "message" VALUES (722,E'tr-TR',E'CSV dosyası aracılığıyla içeri aktar');
INSERT INTO "message" VALUES (723,E'tr-TR',E'<b>Bu turnuvanın jürileri henüz eklenmemiş.</b><br>{add_button} ya da {import_button}');
INSERT INTO "message" VALUES (724,E'tr-TR',E'CSV dosyası aracılığıyla içeri aktar');
INSERT INTO "message" VALUES (725,E'tr-TR',NULL);
INSERT INTO "message" VALUES (726,E'tr-TR',NULL);
INSERT INTO "message" VALUES (727,E'tr-TR',NULL);
INSERT INTO "message" VALUES (728,E'tr-TR',NULL);
INSERT INTO "message" VALUES (729,E'tr-TR',NULL);
INSERT INTO "message" VALUES (730,E'tr-TR',NULL);
INSERT INTO "message" VALUES (731,E'tr-TR',NULL);
INSERT INTO "message" VALUES (732,E'tr-TR',NULL);
INSERT INTO "message" VALUES (733,E'tr-TR',NULL);
INSERT INTO "message" VALUES (734,E'tr-TR',NULL);
INSERT INTO "message" VALUES (735,E'tr-TR',NULL);
INSERT INTO "message" VALUES (736,E'tr-TR',NULL);
INSERT INTO "message" VALUES (737,E'tr-TR',NULL);
INSERT INTO "message" VALUES (738,E'tr-TR',NULL);
INSERT INTO "message" VALUES (739,E'tr-TR',NULL);
INSERT INTO "message" VALUES (740,E'tr-TR',NULL);
INSERT INTO "message" VALUES (741,E'tr-TR',NULL);
INSERT INTO "message" VALUES (742,E'tr-TR',NULL);
INSERT INTO "message" VALUES (743,E'tr-TR',NULL);
INSERT INTO "message" VALUES (744,E'tr-TR',NULL);
INSERT INTO "message" VALUES (745,E'tr-TR',NULL);
INSERT INTO "message" VALUES (746,E'tr-TR',NULL);
INSERT INTO "message" VALUES (747,E'tr-TR',NULL);
INSERT INTO "message" VALUES (748,E'tr-TR',NULL);
INSERT INTO "message" VALUES (749,E'tr-TR',NULL);
INSERT INTO "message" VALUES (750,E'tr-TR',NULL);
INSERT INTO "message" VALUES (751,E'tr-TR',NULL);
INSERT INTO "message" VALUES (753,E'tr-TR',NULL);
INSERT INTO "message" VALUES (754,E'tr-TR',NULL);
INSERT INTO "message" VALUES (755,E'tr-TR',NULL);
INSERT INTO "message" VALUES (756,E'tr-TR',NULL);
INSERT INTO "message" VALUES (757,E'tr-TR',NULL);
INSERT INTO "message" VALUES (758,E'tr-TR',NULL);
INSERT INTO "message" VALUES (759,E'tr-TR',NULL);
INSERT INTO "message" VALUES (760,E'tr-TR',NULL);
INSERT INTO "message" VALUES (761,E'tr-TR',NULL);
INSERT INTO "message" VALUES (762,E'tr-TR',NULL);
INSERT INTO "message" VALUES (764,E'tr-TR',NULL);
INSERT INTO "message" VALUES (765,E'tr-TR',NULL);
INSERT INTO "message" VALUES (766,E'tr-TR',NULL);
INSERT INTO "message" VALUES (767,E'tr-TR',NULL);
INSERT INTO "message" VALUES (770,E'tr-TR',NULL);
INSERT INTO "message" VALUES (771,E'tr-TR',NULL);
INSERT INTO "message" VALUES (772,E'tr-TR',NULL);
INSERT INTO "message" VALUES (773,E'tr-TR',NULL);
INSERT INTO "message" VALUES (774,E'tr-TR',NULL);
INSERT INTO "message" VALUES (775,E'tr-TR',NULL);
INSERT INTO "message" VALUES (777,E'tr-TR',NULL);
INSERT INTO "message" VALUES (778,E'tr-TR',NULL);
INSERT INTO "message" VALUES (783,E'tr-TR',NULL);
INSERT INTO "message" VALUES (784,E'tr-TR',NULL);
INSERT INTO "message" VALUES (785,E'tr-TR',NULL);
INSERT INTO "message" VALUES (787,E'tr-TR',NULL);
INSERT INTO "message" VALUES (788,E'tr-TR',NULL);
INSERT INTO "message" VALUES (789,E'tr-TR',NULL);
INSERT INTO "message" VALUES (790,E'tr-TR',NULL);
INSERT INTO "message" VALUES (791,E'tr-TR',NULL);
INSERT INTO "message" VALUES (792,E'tr-TR',NULL);
INSERT INTO "message" VALUES (793,E'tr-TR',NULL);
INSERT INTO "message" VALUES (794,E'tr-TR',NULL);
INSERT INTO "message" VALUES (795,E'tr-TR',NULL);
INSERT INTO "message" VALUES (796,E'tr-TR',NULL);
INSERT INTO "message" VALUES (1,E'{lang}',NULL);
INSERT INTO "message" VALUES (2,E'{lang}',NULL);
INSERT INTO "message" VALUES (3,E'{lang}',NULL);
INSERT INTO "message" VALUES (4,E'{lang}',NULL);
INSERT INTO "message" VALUES (5,E'{lang}',NULL);
INSERT INTO "message" VALUES (6,E'{lang}',NULL);
INSERT INTO "message" VALUES (7,E'{lang}',NULL);
INSERT INTO "message" VALUES (8,E'{lang}',NULL);
INSERT INTO "message" VALUES (9,E'{lang}',NULL);
INSERT INTO "message" VALUES (10,E'{lang}',NULL);
INSERT INTO "message" VALUES (11,E'{lang}',NULL);
INSERT INTO "message" VALUES (12,E'{lang}',NULL);
INSERT INTO "message" VALUES (13,E'{lang}',NULL);
INSERT INTO "message" VALUES (14,E'{lang}',NULL);
INSERT INTO "message" VALUES (15,E'{lang}',NULL);
INSERT INTO "message" VALUES (16,E'{lang}',NULL);
INSERT INTO "message" VALUES (17,E'{lang}',NULL);
INSERT INTO "message" VALUES (18,E'{lang}',NULL);
INSERT INTO "message" VALUES (19,E'{lang}',NULL);
INSERT INTO "message" VALUES (20,E'{lang}',NULL);
INSERT INTO "message" VALUES (21,E'{lang}',NULL);
INSERT INTO "message" VALUES (22,E'{lang}',NULL);
INSERT INTO "message" VALUES (23,E'{lang}',NULL);
INSERT INTO "message" VALUES (24,E'{lang}',NULL);
INSERT INTO "message" VALUES (25,E'{lang}',NULL);
INSERT INTO "message" VALUES (26,E'{lang}',NULL);
INSERT INTO "message" VALUES (27,E'{lang}',NULL);
INSERT INTO "message" VALUES (28,E'{lang}',NULL);
INSERT INTO "message" VALUES (29,E'{lang}',NULL);
INSERT INTO "message" VALUES (30,E'{lang}',NULL);
INSERT INTO "message" VALUES (31,E'{lang}',NULL);
INSERT INTO "message" VALUES (32,E'{lang}',NULL);
INSERT INTO "message" VALUES (33,E'{lang}',NULL);
INSERT INTO "message" VALUES (34,E'{lang}',NULL);
INSERT INTO "message" VALUES (35,E'{lang}',NULL);
INSERT INTO "message" VALUES (36,E'{lang}',NULL);
INSERT INTO "message" VALUES (37,E'{lang}',NULL);
INSERT INTO "message" VALUES (38,E'{lang}',NULL);
INSERT INTO "message" VALUES (39,E'{lang}',NULL);
INSERT INTO "message" VALUES (40,E'{lang}',NULL);
INSERT INTO "message" VALUES (41,E'{lang}',NULL);
INSERT INTO "message" VALUES (42,E'{lang}',NULL);
INSERT INTO "message" VALUES (43,E'{lang}',NULL);
INSERT INTO "message" VALUES (44,E'{lang}',NULL);
INSERT INTO "message" VALUES (45,E'{lang}',NULL);
INSERT INTO "message" VALUES (46,E'{lang}',NULL);
INSERT INTO "message" VALUES (47,E'{lang}',NULL);
INSERT INTO "message" VALUES (48,E'{lang}',NULL);
INSERT INTO "message" VALUES (49,E'{lang}',NULL);
INSERT INTO "message" VALUES (50,E'{lang}',NULL);
INSERT INTO "message" VALUES (51,E'{lang}',NULL);
INSERT INTO "message" VALUES (52,E'{lang}',NULL);
INSERT INTO "message" VALUES (53,E'{lang}',NULL);
INSERT INTO "message" VALUES (54,E'{lang}',NULL);
INSERT INTO "message" VALUES (55,E'{lang}',NULL);
INSERT INTO "message" VALUES (56,E'{lang}',NULL);
INSERT INTO "message" VALUES (57,E'{lang}',NULL);
INSERT INTO "message" VALUES (58,E'{lang}',NULL);
INSERT INTO "message" VALUES (59,E'{lang}',NULL);
INSERT INTO "message" VALUES (60,E'{lang}',NULL);
INSERT INTO "message" VALUES (61,E'{lang}',NULL);
INSERT INTO "message" VALUES (62,E'{lang}',NULL);
INSERT INTO "message" VALUES (63,E'{lang}',NULL);
INSERT INTO "message" VALUES (64,E'{lang}',NULL);
INSERT INTO "message" VALUES (65,E'{lang}',NULL);
INSERT INTO "message" VALUES (66,E'{lang}',NULL);
INSERT INTO "message" VALUES (67,E'{lang}',NULL);
INSERT INTO "message" VALUES (68,E'{lang}',NULL);
INSERT INTO "message" VALUES (69,E'{lang}',NULL);
INSERT INTO "message" VALUES (70,E'{lang}',NULL);
INSERT INTO "message" VALUES (71,E'{lang}',NULL);
INSERT INTO "message" VALUES (72,E'{lang}',NULL);
INSERT INTO "message" VALUES (73,E'{lang}',NULL);
INSERT INTO "message" VALUES (74,E'{lang}',NULL);
INSERT INTO "message" VALUES (75,E'{lang}',NULL);
INSERT INTO "message" VALUES (76,E'{lang}',NULL);
INSERT INTO "message" VALUES (77,E'{lang}',NULL);
INSERT INTO "message" VALUES (78,E'{lang}',NULL);
INSERT INTO "message" VALUES (79,E'{lang}',NULL);
INSERT INTO "message" VALUES (80,E'{lang}',NULL);
INSERT INTO "message" VALUES (81,E'{lang}',NULL);
INSERT INTO "message" VALUES (82,E'{lang}',NULL);
INSERT INTO "message" VALUES (83,E'{lang}',NULL);
INSERT INTO "message" VALUES (84,E'{lang}',NULL);
INSERT INTO "message" VALUES (85,E'{lang}',NULL);
INSERT INTO "message" VALUES (86,E'{lang}',NULL);
INSERT INTO "message" VALUES (87,E'{lang}',NULL);
INSERT INTO "message" VALUES (88,E'{lang}',NULL);
INSERT INTO "message" VALUES (89,E'{lang}',NULL);
INSERT INTO "message" VALUES (90,E'{lang}',NULL);
INSERT INTO "message" VALUES (91,E'{lang}',NULL);
INSERT INTO "message" VALUES (92,E'{lang}',NULL);
INSERT INTO "message" VALUES (93,E'{lang}',NULL);
INSERT INTO "message" VALUES (94,E'{lang}',NULL);
INSERT INTO "message" VALUES (95,E'{lang}',NULL);
INSERT INTO "message" VALUES (96,E'{lang}',NULL);
INSERT INTO "message" VALUES (97,E'{lang}',NULL);
INSERT INTO "message" VALUES (98,E'{lang}',NULL);
INSERT INTO "message" VALUES (99,E'{lang}',NULL);
INSERT INTO "message" VALUES (100,E'{lang}',NULL);
INSERT INTO "message" VALUES (101,E'{lang}',NULL);
INSERT INTO "message" VALUES (102,E'{lang}',NULL);
INSERT INTO "message" VALUES (103,E'{lang}',NULL);
INSERT INTO "message" VALUES (104,E'{lang}',NULL);
INSERT INTO "message" VALUES (105,E'{lang}',NULL);
INSERT INTO "message" VALUES (106,E'{lang}',NULL);
INSERT INTO "message" VALUES (107,E'{lang}',NULL);
INSERT INTO "message" VALUES (108,E'{lang}',NULL);
INSERT INTO "message" VALUES (109,E'{lang}',NULL);
INSERT INTO "message" VALUES (110,E'{lang}',NULL);
INSERT INTO "message" VALUES (111,E'{lang}',NULL);
INSERT INTO "message" VALUES (112,E'{lang}',NULL);
INSERT INTO "message" VALUES (113,E'{lang}',NULL);
INSERT INTO "message" VALUES (114,E'{lang}',NULL);
INSERT INTO "message" VALUES (115,E'{lang}',NULL);
INSERT INTO "message" VALUES (116,E'{lang}',NULL);
INSERT INTO "message" VALUES (117,E'{lang}',NULL);
INSERT INTO "message" VALUES (118,E'{lang}',NULL);
INSERT INTO "message" VALUES (121,E'{lang}',NULL);
INSERT INTO "message" VALUES (122,E'{lang}',NULL);
INSERT INTO "message" VALUES (124,E'{lang}',NULL);
INSERT INTO "message" VALUES (125,E'{lang}',NULL);
INSERT INTO "message" VALUES (126,E'{lang}',NULL);
INSERT INTO "message" VALUES (127,E'{lang}',NULL);
INSERT INTO "message" VALUES (128,E'{lang}',NULL);
INSERT INTO "message" VALUES (129,E'{lang}',NULL);
INSERT INTO "message" VALUES (130,E'{lang}',NULL);
INSERT INTO "message" VALUES (131,E'{lang}',NULL);
INSERT INTO "message" VALUES (132,E'{lang}',NULL);
INSERT INTO "message" VALUES (133,E'{lang}',NULL);
INSERT INTO "message" VALUES (134,E'{lang}',NULL);
INSERT INTO "message" VALUES (135,E'{lang}',NULL);
INSERT INTO "message" VALUES (136,E'{lang}',NULL);
INSERT INTO "message" VALUES (137,E'{lang}',NULL);
INSERT INTO "message" VALUES (138,E'{lang}',NULL);
INSERT INTO "message" VALUES (139,E'{lang}',NULL);
INSERT INTO "message" VALUES (140,E'{lang}',NULL);
INSERT INTO "message" VALUES (141,E'{lang}',NULL);
INSERT INTO "message" VALUES (142,E'{lang}',NULL);
INSERT INTO "message" VALUES (143,E'{lang}',NULL);
INSERT INTO "message" VALUES (144,E'{lang}',NULL);
INSERT INTO "message" VALUES (145,E'{lang}',NULL);
INSERT INTO "message" VALUES (146,E'{lang}',NULL);
INSERT INTO "message" VALUES (147,E'{lang}',NULL);
INSERT INTO "message" VALUES (148,E'{lang}',NULL);
INSERT INTO "message" VALUES (149,E'{lang}',NULL);
INSERT INTO "message" VALUES (150,E'{lang}',NULL);
INSERT INTO "message" VALUES (151,E'{lang}',NULL);
INSERT INTO "message" VALUES (152,E'{lang}',NULL);
INSERT INTO "message" VALUES (153,E'{lang}',NULL);
INSERT INTO "message" VALUES (154,E'{lang}',NULL);
INSERT INTO "message" VALUES (155,E'{lang}',NULL);
INSERT INTO "message" VALUES (157,E'{lang}',NULL);
INSERT INTO "message" VALUES (158,E'{lang}',NULL);
INSERT INTO "message" VALUES (159,E'{lang}',NULL);
INSERT INTO "message" VALUES (160,E'{lang}',NULL);
INSERT INTO "message" VALUES (161,E'{lang}',NULL);
INSERT INTO "message" VALUES (162,E'{lang}',NULL);
INSERT INTO "message" VALUES (163,E'{lang}',NULL);
INSERT INTO "message" VALUES (164,E'{lang}',NULL);
INSERT INTO "message" VALUES (165,E'{lang}',NULL);
INSERT INTO "message" VALUES (166,E'{lang}',NULL);
INSERT INTO "message" VALUES (167,E'{lang}',NULL);
INSERT INTO "message" VALUES (168,E'{lang}',NULL);
INSERT INTO "message" VALUES (169,E'{lang}',NULL);
INSERT INTO "message" VALUES (170,E'{lang}',NULL);
INSERT INTO "message" VALUES (171,E'{lang}',NULL);
INSERT INTO "message" VALUES (172,E'{lang}',NULL);
INSERT INTO "message" VALUES (173,E'{lang}',NULL);
INSERT INTO "message" VALUES (174,E'{lang}',NULL);
INSERT INTO "message" VALUES (175,E'{lang}',NULL);
INSERT INTO "message" VALUES (176,E'{lang}',NULL);
INSERT INTO "message" VALUES (177,E'{lang}',NULL);
INSERT INTO "message" VALUES (178,E'{lang}',NULL);
INSERT INTO "message" VALUES (179,E'{lang}',NULL);
INSERT INTO "message" VALUES (180,E'{lang}',NULL);
INSERT INTO "message" VALUES (181,E'{lang}',NULL);
INSERT INTO "message" VALUES (182,E'{lang}',NULL);
INSERT INTO "message" VALUES (183,E'{lang}',NULL);
INSERT INTO "message" VALUES (184,E'{lang}',NULL);
INSERT INTO "message" VALUES (185,E'{lang}',NULL);
INSERT INTO "message" VALUES (186,E'{lang}',NULL);
INSERT INTO "message" VALUES (187,E'{lang}',NULL);
INSERT INTO "message" VALUES (188,E'{lang}',NULL);
INSERT INTO "message" VALUES (189,E'{lang}',NULL);
INSERT INTO "message" VALUES (190,E'{lang}',NULL);
INSERT INTO "message" VALUES (191,E'{lang}',NULL);
INSERT INTO "message" VALUES (192,E'{lang}',NULL);
INSERT INTO "message" VALUES (193,E'{lang}',NULL);
INSERT INTO "message" VALUES (195,E'{lang}',NULL);
INSERT INTO "message" VALUES (196,E'{lang}',NULL);
INSERT INTO "message" VALUES (197,E'{lang}',NULL);
INSERT INTO "message" VALUES (198,E'{lang}',NULL);
INSERT INTO "message" VALUES (199,E'{lang}',NULL);
INSERT INTO "message" VALUES (200,E'{lang}',NULL);
INSERT INTO "message" VALUES (201,E'{lang}',NULL);
INSERT INTO "message" VALUES (202,E'{lang}',NULL);
INSERT INTO "message" VALUES (203,E'{lang}',NULL);
INSERT INTO "message" VALUES (204,E'{lang}',NULL);
INSERT INTO "message" VALUES (205,E'{lang}',NULL);
INSERT INTO "message" VALUES (206,E'{lang}',NULL);
INSERT INTO "message" VALUES (207,E'{lang}',NULL);
INSERT INTO "message" VALUES (208,E'{lang}',NULL);
INSERT INTO "message" VALUES (209,E'{lang}',NULL);
INSERT INTO "message" VALUES (210,E'{lang}',NULL);
INSERT INTO "message" VALUES (211,E'{lang}',NULL);
INSERT INTO "message" VALUES (212,E'{lang}',NULL);
INSERT INTO "message" VALUES (213,E'{lang}',NULL);
INSERT INTO "message" VALUES (214,E'{lang}',NULL);
INSERT INTO "message" VALUES (215,E'{lang}',NULL);
INSERT INTO "message" VALUES (216,E'{lang}',NULL);
INSERT INTO "message" VALUES (217,E'{lang}',NULL);
INSERT INTO "message" VALUES (218,E'{lang}',NULL);
INSERT INTO "message" VALUES (219,E'{lang}',NULL);
INSERT INTO "message" VALUES (220,E'{lang}',NULL);
INSERT INTO "message" VALUES (221,E'{lang}',NULL);
INSERT INTO "message" VALUES (222,E'{lang}',NULL);
INSERT INTO "message" VALUES (223,E'{lang}',NULL);
INSERT INTO "message" VALUES (224,E'{lang}',NULL);
INSERT INTO "message" VALUES (225,E'{lang}',NULL);
INSERT INTO "message" VALUES (226,E'{lang}',NULL);
INSERT INTO "message" VALUES (227,E'{lang}',NULL);
INSERT INTO "message" VALUES (228,E'{lang}',NULL);
INSERT INTO "message" VALUES (229,E'{lang}',NULL);
INSERT INTO "message" VALUES (230,E'{lang}',NULL);
INSERT INTO "message" VALUES (231,E'{lang}',NULL);
INSERT INTO "message" VALUES (232,E'{lang}',NULL);
INSERT INTO "message" VALUES (233,E'{lang}',NULL);
INSERT INTO "message" VALUES (234,E'{lang}',NULL);
INSERT INTO "message" VALUES (235,E'{lang}',NULL);
INSERT INTO "message" VALUES (236,E'{lang}',NULL);
INSERT INTO "message" VALUES (237,E'{lang}',NULL);
INSERT INTO "message" VALUES (238,E'{lang}',NULL);
INSERT INTO "message" VALUES (239,E'{lang}',NULL);
INSERT INTO "message" VALUES (240,E'{lang}',NULL);
INSERT INTO "message" VALUES (241,E'{lang}',NULL);
INSERT INTO "message" VALUES (242,E'{lang}',NULL);
INSERT INTO "message" VALUES (243,E'{lang}',NULL);
INSERT INTO "message" VALUES (244,E'{lang}',NULL);
INSERT INTO "message" VALUES (245,E'{lang}',NULL);
INSERT INTO "message" VALUES (246,E'{lang}',NULL);
INSERT INTO "message" VALUES (247,E'{lang}',NULL);
INSERT INTO "message" VALUES (248,E'{lang}',NULL);
INSERT INTO "message" VALUES (249,E'{lang}',NULL);
INSERT INTO "message" VALUES (250,E'{lang}',NULL);
INSERT INTO "message" VALUES (251,E'{lang}',NULL);
INSERT INTO "message" VALUES (252,E'{lang}',NULL);
INSERT INTO "message" VALUES (253,E'{lang}',NULL);
INSERT INTO "message" VALUES (254,E'{lang}',NULL);
INSERT INTO "message" VALUES (255,E'{lang}',NULL);
INSERT INTO "message" VALUES (256,E'{lang}',NULL);
INSERT INTO "message" VALUES (257,E'{lang}',NULL);
INSERT INTO "message" VALUES (258,E'{lang}',NULL);
INSERT INTO "message" VALUES (259,E'{lang}',NULL);
INSERT INTO "message" VALUES (260,E'{lang}',NULL);
INSERT INTO "message" VALUES (261,E'{lang}',NULL);
INSERT INTO "message" VALUES (262,E'{lang}',NULL);
INSERT INTO "message" VALUES (263,E'{lang}',NULL);
INSERT INTO "message" VALUES (264,E'{lang}',NULL);
INSERT INTO "message" VALUES (265,E'{lang}',NULL);
INSERT INTO "message" VALUES (266,E'{lang}',NULL);
INSERT INTO "message" VALUES (267,E'{lang}',NULL);
INSERT INTO "message" VALUES (268,E'{lang}',NULL);
INSERT INTO "message" VALUES (269,E'{lang}',NULL);
INSERT INTO "message" VALUES (270,E'{lang}',NULL);
INSERT INTO "message" VALUES (271,E'{lang}',NULL);
INSERT INTO "message" VALUES (272,E'{lang}',NULL);
INSERT INTO "message" VALUES (273,E'{lang}',NULL);
INSERT INTO "message" VALUES (274,E'{lang}',NULL);
INSERT INTO "message" VALUES (275,E'{lang}',NULL);
INSERT INTO "message" VALUES (276,E'{lang}',NULL);
INSERT INTO "message" VALUES (277,E'{lang}',NULL);
INSERT INTO "message" VALUES (278,E'{lang}',NULL);
INSERT INTO "message" VALUES (279,E'{lang}',NULL);
INSERT INTO "message" VALUES (280,E'{lang}',NULL);
INSERT INTO "message" VALUES (281,E'{lang}',NULL);
INSERT INTO "message" VALUES (282,E'{lang}',NULL);
INSERT INTO "message" VALUES (283,E'{lang}',NULL);
INSERT INTO "message" VALUES (284,E'{lang}',NULL);
INSERT INTO "message" VALUES (285,E'{lang}',NULL);
INSERT INTO "message" VALUES (286,E'{lang}',NULL);
INSERT INTO "message" VALUES (288,E'{lang}',NULL);
INSERT INTO "message" VALUES (289,E'{lang}',NULL);
INSERT INTO "message" VALUES (290,E'{lang}',NULL);
INSERT INTO "message" VALUES (291,E'{lang}',NULL);
INSERT INTO "message" VALUES (292,E'{lang}',NULL);
INSERT INTO "message" VALUES (293,E'{lang}',NULL);
INSERT INTO "message" VALUES (294,E'{lang}',NULL);
INSERT INTO "message" VALUES (295,E'{lang}',NULL);
INSERT INTO "message" VALUES (296,E'{lang}',NULL);
INSERT INTO "message" VALUES (297,E'{lang}',NULL);
INSERT INTO "message" VALUES (298,E'{lang}',NULL);
INSERT INTO "message" VALUES (299,E'{lang}',NULL);
INSERT INTO "message" VALUES (300,E'{lang}',NULL);
INSERT INTO "message" VALUES (301,E'{lang}',NULL);
INSERT INTO "message" VALUES (302,E'{lang}',NULL);
INSERT INTO "message" VALUES (303,E'{lang}',NULL);
INSERT INTO "message" VALUES (304,E'{lang}',NULL);
INSERT INTO "message" VALUES (305,E'{lang}',NULL);
INSERT INTO "message" VALUES (307,E'{lang}',NULL);
INSERT INTO "message" VALUES (308,E'{lang}',NULL);
INSERT INTO "message" VALUES (309,E'{lang}',NULL);
INSERT INTO "message" VALUES (310,E'{lang}',NULL);
INSERT INTO "message" VALUES (311,E'{lang}',NULL);
INSERT INTO "message" VALUES (312,E'{lang}',NULL);
INSERT INTO "message" VALUES (313,E'{lang}',NULL);
INSERT INTO "message" VALUES (314,E'{lang}',NULL);
INSERT INTO "message" VALUES (315,E'{lang}',NULL);
INSERT INTO "message" VALUES (316,E'{lang}',NULL);
INSERT INTO "message" VALUES (317,E'{lang}',NULL);
INSERT INTO "message" VALUES (318,E'{lang}',NULL);
INSERT INTO "message" VALUES (319,E'{lang}',NULL);
INSERT INTO "message" VALUES (320,E'{lang}',NULL);
INSERT INTO "message" VALUES (321,E'{lang}',NULL);
INSERT INTO "message" VALUES (322,E'{lang}',NULL);
INSERT INTO "message" VALUES (323,E'{lang}',NULL);
INSERT INTO "message" VALUES (325,E'{lang}',NULL);
INSERT INTO "message" VALUES (326,E'{lang}',NULL);
INSERT INTO "message" VALUES (327,E'{lang}',NULL);
INSERT INTO "message" VALUES (328,E'{lang}',NULL);
INSERT INTO "message" VALUES (329,E'{lang}',NULL);
INSERT INTO "message" VALUES (330,E'{lang}',NULL);
INSERT INTO "message" VALUES (331,E'{lang}',NULL);
INSERT INTO "message" VALUES (332,E'{lang}',NULL);
INSERT INTO "message" VALUES (333,E'{lang}',NULL);
INSERT INTO "message" VALUES (334,E'{lang}',NULL);
INSERT INTO "message" VALUES (335,E'{lang}',NULL);
INSERT INTO "message" VALUES (336,E'{lang}',NULL);
INSERT INTO "message" VALUES (337,E'{lang}',NULL);
INSERT INTO "message" VALUES (338,E'{lang}',NULL);
INSERT INTO "message" VALUES (339,E'{lang}',NULL);
INSERT INTO "message" VALUES (340,E'{lang}',NULL);
INSERT INTO "message" VALUES (341,E'{lang}',NULL);
INSERT INTO "message" VALUES (342,E'{lang}',NULL);
INSERT INTO "message" VALUES (343,E'{lang}',NULL);
INSERT INTO "message" VALUES (344,E'{lang}',NULL);
INSERT INTO "message" VALUES (345,E'{lang}',NULL);
INSERT INTO "message" VALUES (346,E'{lang}',NULL);
INSERT INTO "message" VALUES (347,E'{lang}',NULL);
INSERT INTO "message" VALUES (348,E'{lang}',NULL);
INSERT INTO "message" VALUES (349,E'{lang}',NULL);
INSERT INTO "message" VALUES (350,E'{lang}',NULL);
INSERT INTO "message" VALUES (351,E'{lang}',NULL);
INSERT INTO "message" VALUES (352,E'{lang}',NULL);
INSERT INTO "message" VALUES (353,E'{lang}',NULL);
INSERT INTO "message" VALUES (354,E'{lang}',NULL);
INSERT INTO "message" VALUES (355,E'{lang}',NULL);
INSERT INTO "message" VALUES (356,E'{lang}',NULL);
INSERT INTO "message" VALUES (357,E'{lang}',NULL);
INSERT INTO "message" VALUES (358,E'{lang}',NULL);
INSERT INTO "message" VALUES (359,E'{lang}',NULL);
INSERT INTO "message" VALUES (360,E'{lang}',NULL);
INSERT INTO "message" VALUES (361,E'{lang}',NULL);
INSERT INTO "message" VALUES (362,E'{lang}',NULL);
INSERT INTO "message" VALUES (363,E'{lang}',NULL);
INSERT INTO "message" VALUES (364,E'{lang}',NULL);
INSERT INTO "message" VALUES (365,E'{lang}',NULL);
INSERT INTO "message" VALUES (366,E'{lang}',NULL);
INSERT INTO "message" VALUES (367,E'{lang}',NULL);
INSERT INTO "message" VALUES (368,E'{lang}',NULL);
INSERT INTO "message" VALUES (369,E'{lang}',NULL);
INSERT INTO "message" VALUES (370,E'{lang}',NULL);
INSERT INTO "message" VALUES (371,E'{lang}',NULL);
INSERT INTO "message" VALUES (372,E'{lang}',NULL);
INSERT INTO "message" VALUES (373,E'{lang}',NULL);
INSERT INTO "message" VALUES (374,E'{lang}',NULL);
INSERT INTO "message" VALUES (375,E'{lang}',NULL);
INSERT INTO "message" VALUES (376,E'{lang}',NULL);
INSERT INTO "message" VALUES (377,E'{lang}',NULL);
INSERT INTO "message" VALUES (378,E'{lang}',NULL);
INSERT INTO "message" VALUES (379,E'{lang}',NULL);
INSERT INTO "message" VALUES (380,E'{lang}',NULL);
INSERT INTO "message" VALUES (381,E'{lang}',NULL);
INSERT INTO "message" VALUES (382,E'{lang}',NULL);
INSERT INTO "message" VALUES (383,E'{lang}',NULL);
INSERT INTO "message" VALUES (384,E'{lang}',NULL);
INSERT INTO "message" VALUES (385,E'{lang}',NULL);
INSERT INTO "message" VALUES (386,E'{lang}',NULL);
INSERT INTO "message" VALUES (387,E'{lang}',NULL);
INSERT INTO "message" VALUES (388,E'{lang}',NULL);
INSERT INTO "message" VALUES (389,E'{lang}',NULL);
INSERT INTO "message" VALUES (390,E'{lang}',NULL);
INSERT INTO "message" VALUES (391,E'{lang}',NULL);
INSERT INTO "message" VALUES (392,E'{lang}',NULL);
INSERT INTO "message" VALUES (393,E'{lang}',NULL);
INSERT INTO "message" VALUES (394,E'{lang}',NULL);
INSERT INTO "message" VALUES (395,E'{lang}',NULL);
INSERT INTO "message" VALUES (396,E'{lang}',NULL);
INSERT INTO "message" VALUES (397,E'{lang}',NULL);
INSERT INTO "message" VALUES (398,E'{lang}',NULL);
INSERT INTO "message" VALUES (399,E'{lang}',NULL);
INSERT INTO "message" VALUES (400,E'{lang}',NULL);
INSERT INTO "message" VALUES (401,E'{lang}',NULL);
INSERT INTO "message" VALUES (402,E'{lang}',NULL);
INSERT INTO "message" VALUES (403,E'{lang}',NULL);
INSERT INTO "message" VALUES (404,E'{lang}',NULL);
INSERT INTO "message" VALUES (405,E'{lang}',NULL);
INSERT INTO "message" VALUES (407,E'{lang}',NULL);
INSERT INTO "message" VALUES (408,E'{lang}',NULL);
INSERT INTO "message" VALUES (411,E'{lang}',NULL);
INSERT INTO "message" VALUES (412,E'{lang}',NULL);
INSERT INTO "message" VALUES (413,E'{lang}',NULL);
INSERT INTO "message" VALUES (414,E'{lang}',NULL);
INSERT INTO "message" VALUES (415,E'{lang}',NULL);
INSERT INTO "message" VALUES (416,E'{lang}',NULL);
INSERT INTO "message" VALUES (417,E'{lang}',NULL);
INSERT INTO "message" VALUES (418,E'{lang}',NULL);
INSERT INTO "message" VALUES (419,E'{lang}',NULL);
INSERT INTO "message" VALUES (420,E'{lang}',NULL);
INSERT INTO "message" VALUES (421,E'{lang}',NULL);
INSERT INTO "message" VALUES (422,E'{lang}',NULL);
INSERT INTO "message" VALUES (423,E'{lang}',NULL);
INSERT INTO "message" VALUES (424,E'{lang}',NULL);
INSERT INTO "message" VALUES (425,E'{lang}',NULL);
INSERT INTO "message" VALUES (426,E'{lang}',NULL);
INSERT INTO "message" VALUES (427,E'{lang}',NULL);
INSERT INTO "message" VALUES (428,E'{lang}',NULL);
INSERT INTO "message" VALUES (429,E'{lang}',NULL);
INSERT INTO "message" VALUES (430,E'{lang}',NULL);
INSERT INTO "message" VALUES (431,E'{lang}',NULL);
INSERT INTO "message" VALUES (432,E'{lang}',NULL);
INSERT INTO "message" VALUES (433,E'{lang}',NULL);
INSERT INTO "message" VALUES (434,E'{lang}',NULL);
INSERT INTO "message" VALUES (435,E'{lang}',NULL);
INSERT INTO "message" VALUES (436,E'{lang}',NULL);
INSERT INTO "message" VALUES (437,E'{lang}',NULL);
INSERT INTO "message" VALUES (438,E'{lang}',NULL);
INSERT INTO "message" VALUES (439,E'{lang}',NULL);
INSERT INTO "message" VALUES (440,E'{lang}',NULL);
INSERT INTO "message" VALUES (441,E'{lang}',NULL);
INSERT INTO "message" VALUES (442,E'{lang}',NULL);
INSERT INTO "message" VALUES (443,E'{lang}',NULL);
INSERT INTO "message" VALUES (444,E'{lang}',NULL);
INSERT INTO "message" VALUES (445,E'{lang}',NULL);
INSERT INTO "message" VALUES (446,E'{lang}',NULL);
INSERT INTO "message" VALUES (447,E'{lang}',NULL);
INSERT INTO "message" VALUES (448,E'{lang}',NULL);
INSERT INTO "message" VALUES (449,E'{lang}',NULL);
INSERT INTO "message" VALUES (450,E'{lang}',NULL);
INSERT INTO "message" VALUES (451,E'{lang}',NULL);
INSERT INTO "message" VALUES (452,E'{lang}',NULL);
INSERT INTO "message" VALUES (453,E'{lang}',NULL);
INSERT INTO "message" VALUES (454,E'{lang}',NULL);
INSERT INTO "message" VALUES (455,E'{lang}',NULL);
INSERT INTO "message" VALUES (456,E'{lang}',NULL);
INSERT INTO "message" VALUES (457,E'{lang}',NULL);
INSERT INTO "message" VALUES (458,E'{lang}',NULL);
INSERT INTO "message" VALUES (459,E'{lang}',NULL);
INSERT INTO "message" VALUES (460,E'{lang}',NULL);
INSERT INTO "message" VALUES (461,E'{lang}',NULL);
INSERT INTO "message" VALUES (462,E'{lang}',NULL);
INSERT INTO "message" VALUES (463,E'{lang}',NULL);
INSERT INTO "message" VALUES (464,E'{lang}',NULL);
INSERT INTO "message" VALUES (465,E'{lang}',NULL);
INSERT INTO "message" VALUES (466,E'{lang}',NULL);
INSERT INTO "message" VALUES (467,E'{lang}',NULL);
INSERT INTO "message" VALUES (468,E'{lang}',NULL);
INSERT INTO "message" VALUES (469,E'{lang}',NULL);
INSERT INTO "message" VALUES (470,E'{lang}',NULL);
INSERT INTO "message" VALUES (471,E'{lang}',NULL);
INSERT INTO "message" VALUES (472,E'{lang}',NULL);
INSERT INTO "message" VALUES (473,E'{lang}',NULL);
INSERT INTO "message" VALUES (474,E'{lang}',NULL);
INSERT INTO "message" VALUES (475,E'{lang}',NULL);
INSERT INTO "message" VALUES (476,E'{lang}',NULL);
INSERT INTO "message" VALUES (477,E'{lang}',NULL);
INSERT INTO "message" VALUES (478,E'{lang}',NULL);
INSERT INTO "message" VALUES (479,E'{lang}',NULL);
INSERT INTO "message" VALUES (480,E'{lang}',NULL);
INSERT INTO "message" VALUES (481,E'{lang}',NULL);
INSERT INTO "message" VALUES (482,E'{lang}',NULL);
INSERT INTO "message" VALUES (483,E'{lang}',NULL);
INSERT INTO "message" VALUES (484,E'{lang}',NULL);
INSERT INTO "message" VALUES (485,E'{lang}',NULL);
INSERT INTO "message" VALUES (486,E'{lang}',NULL);
INSERT INTO "message" VALUES (487,E'{lang}',NULL);
INSERT INTO "message" VALUES (488,E'{lang}',NULL);
INSERT INTO "message" VALUES (489,E'{lang}',NULL);
INSERT INTO "message" VALUES (490,E'{lang}',NULL);
INSERT INTO "message" VALUES (491,E'{lang}',NULL);
INSERT INTO "message" VALUES (492,E'{lang}',NULL);
INSERT INTO "message" VALUES (493,E'{lang}',NULL);
INSERT INTO "message" VALUES (494,E'{lang}',NULL);
INSERT INTO "message" VALUES (495,E'{lang}',NULL);
INSERT INTO "message" VALUES (496,E'{lang}',NULL);
INSERT INTO "message" VALUES (497,E'{lang}',NULL);
INSERT INTO "message" VALUES (498,E'{lang}',NULL);
INSERT INTO "message" VALUES (499,E'{lang}',NULL);
INSERT INTO "message" VALUES (500,E'{lang}',NULL);
INSERT INTO "message" VALUES (501,E'{lang}',NULL);
INSERT INTO "message" VALUES (502,E'{lang}',NULL);
INSERT INTO "message" VALUES (503,E'{lang}',NULL);
INSERT INTO "message" VALUES (504,E'{lang}',NULL);
INSERT INTO "message" VALUES (505,E'{lang}',NULL);
INSERT INTO "message" VALUES (506,E'{lang}',NULL);
INSERT INTO "message" VALUES (507,E'{lang}',NULL);
INSERT INTO "message" VALUES (508,E'{lang}',NULL);
INSERT INTO "message" VALUES (509,E'{lang}',NULL);
INSERT INTO "message" VALUES (510,E'{lang}',NULL);
INSERT INTO "message" VALUES (511,E'{lang}',NULL);
INSERT INTO "message" VALUES (512,E'{lang}',NULL);
INSERT INTO "message" VALUES (513,E'{lang}',NULL);
INSERT INTO "message" VALUES (514,E'{lang}',NULL);
INSERT INTO "message" VALUES (515,E'{lang}',NULL);
INSERT INTO "message" VALUES (516,E'{lang}',NULL);
INSERT INTO "message" VALUES (517,E'{lang}',NULL);
INSERT INTO "message" VALUES (518,E'{lang}',NULL);
INSERT INTO "message" VALUES (519,E'{lang}',NULL);
INSERT INTO "message" VALUES (520,E'{lang}',NULL);
INSERT INTO "message" VALUES (521,E'{lang}',NULL);
INSERT INTO "message" VALUES (522,E'{lang}',NULL);
INSERT INTO "message" VALUES (524,E'{lang}',NULL);
INSERT INTO "message" VALUES (525,E'{lang}',NULL);
INSERT INTO "message" VALUES (526,E'{lang}',NULL);
INSERT INTO "message" VALUES (527,E'{lang}',NULL);
INSERT INTO "message" VALUES (529,E'{lang}',NULL);
INSERT INTO "message" VALUES (530,E'{lang}',NULL);
INSERT INTO "message" VALUES (531,E'{lang}',NULL);
INSERT INTO "message" VALUES (532,E'{lang}',NULL);
INSERT INTO "message" VALUES (533,E'{lang}',NULL);
INSERT INTO "message" VALUES (534,E'{lang}',NULL);
INSERT INTO "message" VALUES (535,E'{lang}',NULL);
INSERT INTO "message" VALUES (536,E'{lang}',NULL);
INSERT INTO "message" VALUES (537,E'{lang}',NULL);
INSERT INTO "message" VALUES (538,E'{lang}',NULL);
INSERT INTO "message" VALUES (539,E'{lang}',NULL);
INSERT INTO "message" VALUES (540,E'{lang}',NULL);
INSERT INTO "message" VALUES (541,E'{lang}',NULL);
INSERT INTO "message" VALUES (542,E'{lang}',NULL);
INSERT INTO "message" VALUES (543,E'{lang}',NULL);
INSERT INTO "message" VALUES (544,E'{lang}',NULL);
INSERT INTO "message" VALUES (545,E'{lang}',NULL);
INSERT INTO "message" VALUES (546,E'{lang}',NULL);
INSERT INTO "message" VALUES (547,E'{lang}',NULL);
INSERT INTO "message" VALUES (548,E'{lang}',NULL);
INSERT INTO "message" VALUES (549,E'{lang}',NULL);
INSERT INTO "message" VALUES (550,E'{lang}',NULL);
INSERT INTO "message" VALUES (551,E'{lang}',NULL);
INSERT INTO "message" VALUES (552,E'{lang}',NULL);
INSERT INTO "message" VALUES (553,E'{lang}',NULL);
INSERT INTO "message" VALUES (554,E'{lang}',NULL);
INSERT INTO "message" VALUES (555,E'{lang}',NULL);
INSERT INTO "message" VALUES (556,E'{lang}',NULL);
INSERT INTO "message" VALUES (557,E'{lang}',NULL);
INSERT INTO "message" VALUES (558,E'{lang}',NULL);
INSERT INTO "message" VALUES (559,E'{lang}',NULL);
INSERT INTO "message" VALUES (560,E'{lang}',NULL);
INSERT INTO "message" VALUES (561,E'{lang}',NULL);
INSERT INTO "message" VALUES (562,E'{lang}',NULL);
INSERT INTO "message" VALUES (563,E'{lang}',NULL);
INSERT INTO "message" VALUES (564,E'{lang}',NULL);
INSERT INTO "message" VALUES (565,E'{lang}',NULL);
INSERT INTO "message" VALUES (566,E'{lang}',NULL);
INSERT INTO "message" VALUES (567,E'{lang}',NULL);
INSERT INTO "message" VALUES (568,E'{lang}',NULL);
INSERT INTO "message" VALUES (569,E'{lang}',NULL);
INSERT INTO "message" VALUES (570,E'{lang}',NULL);
INSERT INTO "message" VALUES (571,E'{lang}',NULL);
INSERT INTO "message" VALUES (572,E'{lang}',NULL);
INSERT INTO "message" VALUES (573,E'{lang}',NULL);
INSERT INTO "message" VALUES (574,E'{lang}',NULL);
INSERT INTO "message" VALUES (575,E'{lang}',NULL);
INSERT INTO "message" VALUES (576,E'{lang}',NULL);
INSERT INTO "message" VALUES (577,E'{lang}',NULL);
INSERT INTO "message" VALUES (578,E'{lang}',NULL);
INSERT INTO "message" VALUES (579,E'{lang}',NULL);
INSERT INTO "message" VALUES (580,E'{lang}',NULL);
INSERT INTO "message" VALUES (582,E'{lang}',NULL);
INSERT INTO "message" VALUES (583,E'{lang}',NULL);
INSERT INTO "message" VALUES (584,E'{lang}',NULL);
INSERT INTO "message" VALUES (585,E'{lang}',NULL);
INSERT INTO "message" VALUES (586,E'{lang}',NULL);
INSERT INTO "message" VALUES (587,E'{lang}',NULL);
INSERT INTO "message" VALUES (588,E'{lang}',NULL);
INSERT INTO "message" VALUES (589,E'{lang}',NULL);
INSERT INTO "message" VALUES (590,E'{lang}',NULL);
INSERT INTO "message" VALUES (591,E'{lang}',NULL);
INSERT INTO "message" VALUES (592,E'{lang}',NULL);
INSERT INTO "message" VALUES (593,E'{lang}',NULL);
INSERT INTO "message" VALUES (594,E'{lang}',NULL);
INSERT INTO "message" VALUES (595,E'{lang}',NULL);
INSERT INTO "message" VALUES (596,E'{lang}',NULL);
INSERT INTO "message" VALUES (597,E'{lang}',NULL);
INSERT INTO "message" VALUES (598,E'{lang}',NULL);
INSERT INTO "message" VALUES (599,E'{lang}',NULL);
INSERT INTO "message" VALUES (600,E'{lang}',NULL);
INSERT INTO "message" VALUES (601,E'{lang}',NULL);
INSERT INTO "message" VALUES (602,E'{lang}',NULL);
INSERT INTO "message" VALUES (603,E'{lang}',NULL);
INSERT INTO "message" VALUES (604,E'{lang}',NULL);
INSERT INTO "message" VALUES (605,E'{lang}',NULL);
INSERT INTO "message" VALUES (606,E'{lang}',NULL);
INSERT INTO "message" VALUES (607,E'{lang}',NULL);
INSERT INTO "message" VALUES (608,E'{lang}',NULL);
INSERT INTO "message" VALUES (609,E'{lang}',NULL);
INSERT INTO "message" VALUES (610,E'{lang}',NULL);
INSERT INTO "message" VALUES (611,E'{lang}',NULL);
INSERT INTO "message" VALUES (613,E'{lang}',NULL);
INSERT INTO "message" VALUES (614,E'{lang}',NULL);
INSERT INTO "message" VALUES (615,E'{lang}',NULL);
INSERT INTO "message" VALUES (616,E'{lang}',NULL);
INSERT INTO "message" VALUES (617,E'{lang}',NULL);
INSERT INTO "message" VALUES (618,E'{lang}',NULL);
INSERT INTO "message" VALUES (619,E'{lang}',NULL);
INSERT INTO "message" VALUES (620,E'{lang}',NULL);
INSERT INTO "message" VALUES (622,E'{lang}',NULL);
INSERT INTO "message" VALUES (623,E'{lang}',NULL);
INSERT INTO "message" VALUES (624,E'{lang}',NULL);
INSERT INTO "message" VALUES (625,E'{lang}',NULL);
INSERT INTO "message" VALUES (626,E'{lang}',NULL);
INSERT INTO "message" VALUES (627,E'{lang}',NULL);
INSERT INTO "message" VALUES (628,E'{lang}',NULL);
INSERT INTO "message" VALUES (629,E'{lang}',NULL);
INSERT INTO "message" VALUES (630,E'{lang}',NULL);
INSERT INTO "message" VALUES (631,E'{lang}',NULL);
INSERT INTO "message" VALUES (632,E'{lang}',NULL);
INSERT INTO "message" VALUES (633,E'{lang}',NULL);
INSERT INTO "message" VALUES (634,E'{lang}',NULL);
INSERT INTO "message" VALUES (635,E'{lang}',NULL);
INSERT INTO "message" VALUES (636,E'{lang}',NULL);
INSERT INTO "message" VALUES (637,E'{lang}',NULL);
INSERT INTO "message" VALUES (638,E'{lang}',NULL);
INSERT INTO "message" VALUES (639,E'{lang}',NULL);
INSERT INTO "message" VALUES (640,E'{lang}',NULL);
INSERT INTO "message" VALUES (641,E'{lang}',NULL);
INSERT INTO "message" VALUES (642,E'{lang}',NULL);
INSERT INTO "message" VALUES (643,E'{lang}',NULL);
INSERT INTO "message" VALUES (644,E'{lang}',NULL);
INSERT INTO "message" VALUES (645,E'{lang}',NULL);
INSERT INTO "message" VALUES (646,E'{lang}',NULL);
INSERT INTO "message" VALUES (647,E'{lang}',NULL);
INSERT INTO "message" VALUES (648,E'{lang}',NULL);
INSERT INTO "message" VALUES (649,E'{lang}',NULL);
INSERT INTO "message" VALUES (650,E'{lang}',NULL);
INSERT INTO "message" VALUES (651,E'{lang}',NULL);
INSERT INTO "message" VALUES (652,E'{lang}',NULL);
INSERT INTO "message" VALUES (653,E'{lang}',NULL);
INSERT INTO "message" VALUES (654,E'{lang}',NULL);
INSERT INTO "message" VALUES (656,E'{lang}',NULL);
INSERT INTO "message" VALUES (657,E'{lang}',NULL);
INSERT INTO "message" VALUES (658,E'{lang}',NULL);
INSERT INTO "message" VALUES (659,E'{lang}',NULL);
INSERT INTO "message" VALUES (660,E'{lang}',NULL);
INSERT INTO "message" VALUES (661,E'{lang}',NULL);
INSERT INTO "message" VALUES (662,E'{lang}',NULL);
INSERT INTO "message" VALUES (663,E'{lang}',NULL);
INSERT INTO "message" VALUES (664,E'{lang}',NULL);
INSERT INTO "message" VALUES (665,E'{lang}',NULL);
INSERT INTO "message" VALUES (666,E'{lang}',NULL);
INSERT INTO "message" VALUES (667,E'{lang}',NULL);
INSERT INTO "message" VALUES (668,E'{lang}',NULL);
INSERT INTO "message" VALUES (669,E'{lang}',NULL);
INSERT INTO "message" VALUES (670,E'{lang}',NULL);
INSERT INTO "message" VALUES (671,E'{lang}',NULL);
INSERT INTO "message" VALUES (672,E'{lang}',NULL);
INSERT INTO "message" VALUES (673,E'{lang}',NULL);
INSERT INTO "message" VALUES (674,E'{lang}',NULL);
INSERT INTO "message" VALUES (675,E'{lang}',NULL);
INSERT INTO "message" VALUES (676,E'{lang}',NULL);
INSERT INTO "message" VALUES (677,E'{lang}',NULL);
INSERT INTO "message" VALUES (678,E'{lang}',NULL);
INSERT INTO "message" VALUES (679,E'{lang}',NULL);
INSERT INTO "message" VALUES (680,E'{lang}',NULL);
INSERT INTO "message" VALUES (681,E'{lang}',NULL);
INSERT INTO "message" VALUES (682,E'{lang}',NULL);
INSERT INTO "message" VALUES (686,E'{lang}',NULL);
INSERT INTO "message" VALUES (687,E'{lang}',NULL);
INSERT INTO "message" VALUES (688,E'{lang}',NULL);
INSERT INTO "message" VALUES (689,E'{lang}',NULL);
INSERT INTO "message" VALUES (690,E'{lang}',NULL);
INSERT INTO "message" VALUES (691,E'{lang}',NULL);
INSERT INTO "message" VALUES (692,E'{lang}',NULL);
INSERT INTO "message" VALUES (693,E'{lang}',NULL);
INSERT INTO "message" VALUES (694,E'{lang}',NULL);
INSERT INTO "message" VALUES (695,E'{lang}',NULL);
INSERT INTO "message" VALUES (696,E'{lang}',NULL);
INSERT INTO "message" VALUES (697,E'{lang}',NULL);
INSERT INTO "message" VALUES (698,E'{lang}',NULL);
INSERT INTO "message" VALUES (699,E'{lang}',NULL);
INSERT INTO "message" VALUES (700,E'{lang}',NULL);
INSERT INTO "message" VALUES (701,E'{lang}',NULL);
INSERT INTO "message" VALUES (702,E'{lang}',NULL);
INSERT INTO "message" VALUES (703,E'{lang}',NULL);
INSERT INTO "message" VALUES (704,E'{lang}',NULL);
INSERT INTO "message" VALUES (705,E'{lang}',NULL);
INSERT INTO "message" VALUES (706,E'{lang}',NULL);
INSERT INTO "message" VALUES (707,E'{lang}',NULL);
INSERT INTO "message" VALUES (708,E'{lang}',NULL);
INSERT INTO "message" VALUES (709,E'{lang}',NULL);
INSERT INTO "message" VALUES (710,E'{lang}',NULL);
INSERT INTO "message" VALUES (711,E'{lang}',NULL);
INSERT INTO "message" VALUES (712,E'{lang}',NULL);
INSERT INTO "message" VALUES (713,E'{lang}',NULL);
INSERT INTO "message" VALUES (714,E'{lang}',NULL);
INSERT INTO "message" VALUES (715,E'{lang}',NULL);
INSERT INTO "message" VALUES (716,E'{lang}',NULL);
INSERT INTO "message" VALUES (717,E'{lang}',NULL);
INSERT INTO "message" VALUES (718,E'{lang}',NULL);
INSERT INTO "message" VALUES (719,E'{lang}',NULL);
INSERT INTO "message" VALUES (720,E'{lang}',NULL);
INSERT INTO "message" VALUES (721,E'{lang}',NULL);
INSERT INTO "message" VALUES (722,E'{lang}',NULL);
INSERT INTO "message" VALUES (723,E'{lang}',NULL);
INSERT INTO "message" VALUES (724,E'{lang}',NULL);
INSERT INTO "message" VALUES (725,E'{lang}',NULL);
INSERT INTO "message" VALUES (726,E'{lang}',NULL);
INSERT INTO "message" VALUES (727,E'{lang}',NULL);
INSERT INTO "message" VALUES (728,E'{lang}',NULL);
INSERT INTO "message" VALUES (729,E'{lang}',NULL);
INSERT INTO "message" VALUES (730,E'{lang}',NULL);
INSERT INTO "message" VALUES (731,E'{lang}',NULL);
INSERT INTO "message" VALUES (732,E'{lang}',NULL);
INSERT INTO "message" VALUES (733,E'{lang}',NULL);
INSERT INTO "message" VALUES (734,E'{lang}',NULL);
INSERT INTO "message" VALUES (735,E'{lang}',NULL);
INSERT INTO "message" VALUES (736,E'{lang}',NULL);
INSERT INTO "message" VALUES (737,E'{lang}',NULL);
INSERT INTO "message" VALUES (738,E'{lang}',NULL);
INSERT INTO "message" VALUES (739,E'{lang}',NULL);
INSERT INTO "message" VALUES (740,E'{lang}',NULL);
INSERT INTO "message" VALUES (741,E'{lang}',NULL);
INSERT INTO "message" VALUES (742,E'{lang}',NULL);
INSERT INTO "message" VALUES (743,E'{lang}',NULL);
INSERT INTO "message" VALUES (744,E'{lang}',NULL);
INSERT INTO "message" VALUES (745,E'{lang}',NULL);
INSERT INTO "message" VALUES (746,E'{lang}',NULL);
INSERT INTO "message" VALUES (747,E'{lang}',NULL);
INSERT INTO "message" VALUES (748,E'{lang}',NULL);
INSERT INTO "message" VALUES (749,E'{lang}',NULL);
INSERT INTO "message" VALUES (750,E'{lang}',NULL);
INSERT INTO "message" VALUES (751,E'{lang}',NULL);
INSERT INTO "message" VALUES (753,E'{lang}',NULL);
INSERT INTO "message" VALUES (754,E'{lang}',NULL);
INSERT INTO "message" VALUES (755,E'{lang}',NULL);
INSERT INTO "message" VALUES (756,E'{lang}',NULL);
INSERT INTO "message" VALUES (757,E'{lang}',NULL);
INSERT INTO "message" VALUES (758,E'{lang}',NULL);
INSERT INTO "message" VALUES (759,E'{lang}',NULL);
INSERT INTO "message" VALUES (760,E'{lang}',NULL);
INSERT INTO "message" VALUES (761,E'{lang}',NULL);
INSERT INTO "message" VALUES (762,E'{lang}',NULL);
INSERT INTO "message" VALUES (764,E'{lang}',NULL);
INSERT INTO "message" VALUES (765,E'{lang}',NULL);
INSERT INTO "message" VALUES (766,E'{lang}',NULL);
INSERT INTO "message" VALUES (767,E'{lang}',NULL);
INSERT INTO "message" VALUES (770,E'{lang}',NULL);
INSERT INTO "message" VALUES (771,E'{lang}',NULL);
INSERT INTO "message" VALUES (772,E'{lang}',NULL);
INSERT INTO "message" VALUES (773,E'{lang}',NULL);
INSERT INTO "message" VALUES (774,E'{lang}',NULL);
INSERT INTO "message" VALUES (775,E'{lang}',NULL);
INSERT INTO "message" VALUES (777,E'{lang}',NULL);
INSERT INTO "message" VALUES (778,E'{lang}',NULL);
INSERT INTO "message" VALUES (783,E'{lang}',NULL);
INSERT INTO "message" VALUES (784,E'{lang}',NULL);
INSERT INTO "message" VALUES (785,E'{lang}',NULL);
INSERT INTO "message" VALUES (787,E'{lang}',NULL);
INSERT INTO "message" VALUES (788,E'{lang}',NULL);
INSERT INTO "message" VALUES (789,E'{lang}',NULL);
INSERT INTO "message" VALUES (790,E'{lang}',NULL);
INSERT INTO "message" VALUES (791,E'{lang}',NULL);
INSERT INTO "message" VALUES (792,E'{lang}',NULL);
INSERT INTO "message" VALUES (793,E'{lang}',NULL);

/*!40000 ALTER TABLE message ENABLE KEYS */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "message_id_idx" ON "message" USING btree ("id");
ALTER TABLE "message" ADD FOREIGN KEY ("id") REFERENCES "source_message" ("id");

--
-- Table structure for table migration
--

DROP TABLE IF EXISTS "migration" CASCADE;
CREATE TABLE  "migration" (
   "version"   varchar(180) NOT NULL,
   "apply_time"   int DEFAULT NULL,
   primary key ("version")
)  ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

--
-- Table structure for table motion_tag
--

DROP TABLE IF EXISTS "motion_tag" CASCADE;
DROP SEQUENCE IF EXISTS "motion_tag_id_seq" CASCADE ;

CREATE SEQUENCE "motion_tag_id_seq"  START WITH 554 ;

CREATE TABLE  "motion_tag" (
   "id" integer DEFAULT nextval('"motion_tag_id_seq"') NOT NULL,
   "name"   varchar(255) NOT NULL,
   "abr"   varchar(100) DEFAULT NULL,
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

--
-- Table structure for table panel
--

DROP TABLE IF EXISTS "panel" CASCADE;
DROP SEQUENCE IF EXISTS "panel_id_seq" CASCADE ;

CREATE SEQUENCE "panel_id_seq"  START WITH 8736 ;

CREATE TABLE  "panel" (
   "id" integer DEFAULT nextval('"panel_id_seq"') NOT NULL,
   "strength"   int NOT NULL DEFAULT '0',
   "time"   timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   "used"    smallint NOT NULL DEFAULT '1',
   "is_preset"    smallint NOT NULL DEFAULT '0',
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "panel_tournament_id_idx" ON "panel" USING btree ("tournament_id");
ALTER TABLE "panel" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");

--
-- Table structure for table publish_tab_speaker
--

DROP TABLE IF EXISTS "publish_tab_speaker" CASCADE;
DROP SEQUENCE IF EXISTS "publish_tab_speaker_id_seq" CASCADE ;

CREATE SEQUENCE "publish_tab_speaker_id_seq"  START WITH 7996 ;

CREATE TABLE  "publish_tab_speaker" (
   "id" integer DEFAULT nextval('"publish_tab_speaker_id_seq"') NOT NULL,
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   "user_id" int CHECK ("user_id" >= 0) NOT NULL,
   "enl_place"   int NOT NULL,
   "esl_place"   int DEFAULT NULL,
   "cache_results"   text NOT NULL,
   "speaks"   int NOT NULL,
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "publish_tab_speaker_user_id_idx" ON "publish_tab_speaker" USING btree ("user_id");
CREATE INDEX "publish_tab_speaker_tournament_id_idx" ON "publish_tab_speaker" USING btree ("tournament_id");
ALTER TABLE "publish_tab_speaker" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");
ALTER TABLE "publish_tab_speaker" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

--
-- Table structure for table publish_tab_team
--

DROP TABLE IF EXISTS "publish_tab_team" CASCADE;
DROP SEQUENCE IF EXISTS "publish_tab_team_id_seq" CASCADE ;

CREATE SEQUENCE "publish_tab_team_id_seq"  START WITH 4190 ;

CREATE TABLE  "publish_tab_team" (
   "id" integer DEFAULT nextval('"publish_tab_team_id_seq"') NOT NULL,
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   "team_id" int CHECK ("team_id" >= 0) NOT NULL,
   "enl_place"   int NOT NULL,
   "esl_place"   varchar(45) DEFAULT NULL,
   "cache_results"   text NOT NULL,
   "speaks"   int NOT NULL,
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "publish_tab_team_team_id_idx" ON "publish_tab_team" USING btree ("team_id");
CREATE INDEX "publish_tab_team_tournament_id_idx" ON "publish_tab_team" USING btree ("tournament_id");
ALTER TABLE "publish_tab_team" ADD FOREIGN KEY ("team_id") REFERENCES "team" ("id");
ALTER TABLE "publish_tab_team" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");

--
-- Table structure for table question
--

DROP TABLE IF EXISTS "question" CASCADE;
DROP SEQUENCE IF EXISTS "question_id_seq" CASCADE ;

CREATE SEQUENCE "question_id_seq"  START WITH 280 ;

CREATE TABLE  "question" (
   "id" integer DEFAULT nextval('"question_id_seq"') NOT NULL,
   "text"   varchar(255) NOT NULL,
   "type"   int NOT NULL,
   "apply_t2c"    smallint NOT NULL DEFAULT '0',
   "apply_c2w"    smallint NOT NULL DEFAULT '0',
   "apply_w2c"    smallint NOT NULL DEFAULT '0',
   "param"   text,
   "help"   varchar(255) DEFAULT NULL,
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

--
-- Table structure for table result
--

DROP TABLE IF EXISTS "result" CASCADE;
DROP SEQUENCE IF EXISTS "result_id_seq" CASCADE ;

CREATE SEQUENCE "result_id_seq"  START WITH 4574 ;

CREATE TABLE  "result" (
   "id" integer DEFAULT nextval('"result_id_seq"') NOT NULL,
   "debate_id" int CHECK ("debate_id" >= 0) NOT NULL,
   "og_a_speaks"    smallint NOT NULL,
   "og_b_speaks"    smallint NOT NULL,
   "og_irregular"    smallint NOT NULL DEFAULT '0',
   "og_place"    smallint NOT NULL,
   "oo_a_speaks"    smallint NOT NULL,
   "oo_b_speaks"    smallint NOT NULL,
   "oo_irregular"    smallint NOT NULL DEFAULT '0',
   "oo_place"    smallint NOT NULL,
   "cg_a_speaks"    smallint NOT NULL,
   "cg_b_speaks"    smallint NOT NULL,
   "cg_irregular"    smallint NOT NULL DEFAULT '0',
   "cg_place"    smallint NOT NULL,
   "co_a_speaks"    smallint NOT NULL,
   "co_b_speaks"    smallint NOT NULL,
   "co_irregular"    smallint NOT NULL DEFAULT '0',
   "co_place"    smallint NOT NULL,
   "time"   timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   "entered_by_id" int CHECK ("entered_by_id" >= 0) DEFAULT NULL,
   "checked"    smallint NOT NULL DEFAULT '0',
   primary key ("id"),
 unique ("debate_id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "result_debate_id_idx" ON "result" USING btree ("debate_id");
CREATE INDEX "result_entered_by_id_idx" ON "result" USING btree ("entered_by_id");
ALTER TABLE "result" ADD FOREIGN KEY ("debate_id") REFERENCES "debate" ("id");
ALTER TABLE "result" ADD FOREIGN KEY ("entered_by_id") REFERENCES "user" ("id");

--
-- Table structure for table round
--

DROP TABLE IF EXISTS "round" CASCADE;
DROP SEQUENCE IF EXISTS "round_id_seq" CASCADE ;

CREATE SEQUENCE "round_id_seq"  START WITH 542 ;

CREATE TABLE  "round" (
   "id" integer DEFAULT nextval('"round_id_seq"') NOT NULL,
   "label"   varchar(100) NOT NULL,
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   "type"    smallint NOT NULL DEFAULT '0',
   "level"    smallint NOT NULL DEFAULT '0',
   "energy"   int NOT NULL DEFAULT '0',
   "motion"   text NOT NULL,
   "infoslide"   text,
   "time"   timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   "published"    smallint NOT NULL DEFAULT '0',
   "displayed"    smallint NOT NULL DEFAULT '0',
   "closed"    smallint NOT NULL DEFAULT '0',
   "prep_started"   timestamp without time zone DEFAULT NULL,
   "finished_time"   timestamp without time zone DEFAULT NULL,
   "lastrun_temp"   float NOT NULL DEFAULT '1',
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "round_tournament_id_idx" ON "round" USING btree ("tournament_id");
ALTER TABLE "round" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");

--
-- Table structure for table society
--

DROP TABLE IF EXISTS "society" CASCADE;
DROP SEQUENCE IF EXISTS "society_id_seq" CASCADE ;

CREATE SEQUENCE "society_id_seq"  START WITH 2341 ;

CREATE TABLE  "society" (
   "id" integer DEFAULT nextval('"society_id_seq"') NOT NULL,
   "fullname"   varchar(255) DEFAULT NULL,
   "abr"   varchar(45) DEFAULT NULL,
   "city"   varchar(255) DEFAULT NULL,
   "country_id" int CHECK ("country_id" >= 0) NOT NULL,
   primary key ("id"),
 unique ("abr")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "society_country_id_idx" ON "society" USING btree ("country_id");
ALTER TABLE "society" ADD FOREIGN KEY ("country_id") REFERENCES "country" ("id");

--
-- Table structure for table source_message
--

DROP TABLE IF EXISTS "source_message" CASCADE;
DROP SEQUENCE IF EXISTS "source_message_id_seq" CASCADE ;

CREATE SEQUENCE "source_message_id_seq"  START WITH 797 ;

CREATE TABLE  "source_message" (
   "id" integer DEFAULT nextval('"source_message_id_seq"') NOT NULL,
   "category"   varchar(32) DEFAULT NULL,
   "message"   text,
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40000 ALTER TABLE source_message DISABLE KEYS */;

--
-- Dumping data for table source_message
--

INSERT INTO "source_message" VALUES (1,E'app',E'ID');
INSERT INTO "source_message" VALUES (2,E'app',E'Name');
INSERT INTO "source_message" VALUES (3,E'app',E'Import {modelClass}');
INSERT INTO "source_message" VALUES (4,E'app',E'Import');
INSERT INTO "source_message" VALUES (5,E'app',E'Societies');
INSERT INTO "source_message" VALUES (6,E'app',E'Update');
INSERT INTO "source_message" VALUES (7,E'app',E'Delete');
INSERT INTO "source_message" VALUES (8,E'app',E'Are you sure you want to delete this item?');
INSERT INTO "source_message" VALUES (9,E'app',E'Update {modelClass}: ');
INSERT INTO "source_message" VALUES (10,E'app',E'Merge Society \'{society}\' into ...');
INSERT INTO "source_message" VALUES (11,E'app',E'Select a Mother-Society ...');
INSERT INTO "source_message" VALUES (12,E'app',E'Create {modelClass}');
INSERT INTO "source_message" VALUES (13,E'app',E'View {modelClass}');
INSERT INTO "source_message" VALUES (14,E'app',E'Update {modelClass}');
INSERT INTO "source_message" VALUES (15,E'app',E'Delete {modelClass}');
INSERT INTO "source_message" VALUES (16,E'app',E'Add new element');
INSERT INTO "source_message" VALUES (17,E'app',E'Reload content');
INSERT INTO "source_message" VALUES (18,E'app',E'Import via CSV File');
INSERT INTO "source_message" VALUES (19,E'app',E'Create');
INSERT INTO "source_message" VALUES (20,E'app',E'Languages');
INSERT INTO "source_message" VALUES (21,E'app',E'Create Language');
INSERT INTO "source_message" VALUES (22,E'app',E'Special Needs');
INSERT INTO "source_message" VALUES (23,E'app',E'Motion Tags');
INSERT INTO "source_message" VALUES (24,E'app',E'Merge Motion Tag \'{tag}\' into ...');
INSERT INTO "source_message" VALUES (25,E'app',E'Select a Mother-Tag ...');
INSERT INTO "source_message" VALUES (26,E'app',E'Search');
INSERT INTO "source_message" VALUES (27,E'app',E'Reset');
INSERT INTO "source_message" VALUES (28,E'app',E'Create Motion Tag');
INSERT INTO "source_message" VALUES (29,E'app',E'API');
INSERT INTO "source_message" VALUES (30,E'app',E'Master');
INSERT INTO "source_message" VALUES (31,E'app',E'Messages');
INSERT INTO "source_message" VALUES (32,E'app',E'Create Message');
INSERT INTO "source_message" VALUES (33,E'app',E'{count} Tags switched');
INSERT INTO "source_message" VALUES (34,E'app',E'File Syntax Wrong');
INSERT INTO "source_message" VALUES (35,E'app',E'Motion Tag');
INSERT INTO "source_message" VALUES (36,E'app',E'Round');
INSERT INTO "source_message" VALUES (37,E'app',E'Abbreviation');
INSERT INTO "source_message" VALUES (38,E'app',E'Amount');
INSERT INTO "source_message" VALUES (39,E'app',E'Opening Government');
INSERT INTO "source_message" VALUES (40,E'app',E'Opening Opposition');
INSERT INTO "source_message" VALUES (41,E'app',E'Closing Government');
INSERT INTO "source_message" VALUES (42,E'app',E'Closing Opposition');
INSERT INTO "source_message" VALUES (43,E'app',E'Team');
INSERT INTO "source_message" VALUES (44,E'app',E'Active');
INSERT INTO "source_message" VALUES (45,E'app',E'Tournament');
INSERT INTO "source_message" VALUES (46,E'app',E'Speaker');
INSERT INTO "source_message" VALUES (47,E'app',E'Society');
INSERT INTO "source_message" VALUES (48,E'app',E'Swing Team');
INSERT INTO "source_message" VALUES (49,E'app',E'Language Status');
INSERT INTO "source_message" VALUES (50,E'app',E'Everything normal');
INSERT INTO "source_message" VALUES (51,E'app',E'Was replaced by swing team');
INSERT INTO "source_message" VALUES (52,E'app',E'Speaker {letter} didn\'t show up');
INSERT INTO "source_message" VALUES (53,E'app',E'Key');
INSERT INTO "source_message" VALUES (54,E'app',E'Label');
INSERT INTO "source_message" VALUES (55,E'app',E'Value');
INSERT INTO "source_message" VALUES (56,E'app',E'Team position can\'t be blank');
INSERT INTO "source_message" VALUES (57,E'app',E'Outround');
INSERT INTO "source_message" VALUES (58,E'app',E'Tabmaster User');
INSERT INTO "source_message" VALUES (59,E'app',E'User');
INSERT INTO "source_message" VALUES (60,E'app',E'ENL Place');
INSERT INTO "source_message" VALUES (61,E'app',E'ESL Place');
INSERT INTO "source_message" VALUES (62,E'app',E'Cache Results');
INSERT INTO "source_message" VALUES (63,E'app',E'Fullname');
INSERT INTO "source_message" VALUES (64,E'app',E'Abbrevation');
INSERT INTO "source_message" VALUES (65,E'app',E'City');
INSERT INTO "source_message" VALUES (66,E'app',E'Country');
INSERT INTO "source_message" VALUES (67,E'app',E'OG Team');
INSERT INTO "source_message" VALUES (68,E'app',E'OO Team');
INSERT INTO "source_message" VALUES (69,E'app',E'CG Team');
INSERT INTO "source_message" VALUES (70,E'app',E'CO Team');
INSERT INTO "source_message" VALUES (71,E'app',E'Panel');
INSERT INTO "source_message" VALUES (72,E'app',E'Venue');
INSERT INTO "source_message" VALUES (73,E'app',E'OG Feedback');
INSERT INTO "source_message" VALUES (74,E'app',E'OO Feedback');
INSERT INTO "source_message" VALUES (75,E'app',E'CG Feedback');
INSERT INTO "source_message" VALUES (76,E'app',E'CO Feedback');
INSERT INTO "source_message" VALUES (77,E'app',E'Time');
INSERT INTO "source_message" VALUES (78,E'app',E'Motion');
INSERT INTO "source_message" VALUES (79,E'app',E'Language');
INSERT INTO "source_message" VALUES (80,E'app',E'Date');
INSERT INTO "source_message" VALUES (81,E'app',E'Infoslide');
INSERT INTO "source_message" VALUES (82,E'app',E'Link');
INSERT INTO "source_message" VALUES (83,E'app',E'By User');
INSERT INTO "source_message" VALUES (84,E'app',E'Translation');
INSERT INTO "source_message" VALUES (85,E'app',E'Adjudicator');
INSERT INTO "source_message" VALUES (86,E'app',E'Answer');
INSERT INTO "source_message" VALUES (87,E'app',E'Feedback');
INSERT INTO "source_message" VALUES (88,E'app',E'Question');
INSERT INTO "source_message" VALUES (89,E'app',E'Created');
INSERT INTO "source_message" VALUES (90,E'app',E'Running');
INSERT INTO "source_message" VALUES (91,E'app',E'Closed');
INSERT INTO "source_message" VALUES (92,E'app',E'Hidden');
INSERT INTO "source_message" VALUES (93,E'app',E'Hosted by');
INSERT INTO "source_message" VALUES (94,E'app',E'Tournament Name');
INSERT INTO "source_message" VALUES (95,E'app',E'Start Date');
INSERT INTO "source_message" VALUES (96,E'app',E'End Date');
INSERT INTO "source_message" VALUES (97,E'app',E'Timezone');
INSERT INTO "source_message" VALUES (98,E'app',E'Logo');
INSERT INTO "source_message" VALUES (99,E'app',E'URL Slug');
INSERT INTO "source_message" VALUES (100,E'app',E'Tab Algorithm');
INSERT INTO "source_message" VALUES (101,E'app',E'Expected number of rounds');
INSERT INTO "source_message" VALUES (102,E'app',E'Show ESL Ranking');
INSERT INTO "source_message" VALUES (103,E'app',E'Is there a grand final');
INSERT INTO "source_message" VALUES (104,E'app',E'Is there a semifinal');
INSERT INTO "source_message" VALUES (105,E'app',E'Is there a quarterfinal');
INSERT INTO "source_message" VALUES (106,E'app',E'Is there a octofinal');
INSERT INTO "source_message" VALUES (107,E'app',E'Access Token');
INSERT INTO "source_message" VALUES (108,E'app',E'Participant Badge');
INSERT INTO "source_message" VALUES (109,E'app',E'Alpha 2');
INSERT INTO "source_message" VALUES (110,E'app',E'Alpha 3');
INSERT INTO "source_message" VALUES (111,E'app',E'Region');
INSERT INTO "source_message" VALUES (112,E'app',E'Language Code');
INSERT INTO "source_message" VALUES (113,E'app',E'Coverage');
INSERT INTO "source_message" VALUES (114,E'app',E'Last Update');
INSERT INTO "source_message" VALUES (115,E'app',E'Strength');
INSERT INTO "source_message" VALUES (116,E'app',E'can Chair');
INSERT INTO "source_message" VALUES (117,E'app',E'are Watched');
INSERT INTO "source_message" VALUES (118,E'app',E'Not Rated');
INSERT INTO "source_message" VALUES (121,E'app',E'Can Judge');
INSERT INTO "source_message" VALUES (122,E'app',E'Decent');
INSERT INTO "source_message" VALUES (124,E'app',E'High Potential');
INSERT INTO "source_message" VALUES (125,E'app',E'Chair');
INSERT INTO "source_message" VALUES (126,E'app',E'Good');
INSERT INTO "source_message" VALUES (127,E'app',E'Breaking');
INSERT INTO "source_message" VALUES (128,E'app',E'Chief Adjudicator');
INSERT INTO "source_message" VALUES (129,E'app',E'Starting');
INSERT INTO "source_message" VALUES (130,E'app',E'Ending');
INSERT INTO "source_message" VALUES (131,E'app',E'Speaker Points');
INSERT INTO "source_message" VALUES (132,E'app',E'This email address has already been taken.');
INSERT INTO "source_message" VALUES (133,E'app',E'Debater');
INSERT INTO "source_message" VALUES (134,E'app',E'Auth Key');
INSERT INTO "source_message" VALUES (135,E'app',E'Password Hash');
INSERT INTO "source_message" VALUES (136,E'app',E'Password Reset Token');
INSERT INTO "source_message" VALUES (137,E'app',E'Email');
INSERT INTO "source_message" VALUES (138,E'app',E'Account Role');
INSERT INTO "source_message" VALUES (139,E'app',E'Account Status');
INSERT INTO "source_message" VALUES (140,E'app',E'Last Change');
INSERT INTO "source_message" VALUES (141,E'app',E'First Name');
INSERT INTO "source_message" VALUES (142,E'app',E'Last Name');
INSERT INTO "source_message" VALUES (143,E'app',E'Picture');
INSERT INTO "source_message" VALUES (144,E'app',E'Placeholder');
INSERT INTO "source_message" VALUES (145,E'app',E'Tabmaster');
INSERT INTO "source_message" VALUES (146,E'app',E'Admin');
INSERT INTO "source_message" VALUES (147,E'app',E'Deleted');
INSERT INTO "source_message" VALUES (148,E'app',E'Not revealing');
INSERT INTO "source_message" VALUES (149,E'app',E'Female');
INSERT INTO "source_message" VALUES (150,E'app',E'Male');
INSERT INTO "source_message" VALUES (151,E'app',E'Other');
INSERT INTO "source_message" VALUES (152,E'app',E'mixed');
INSERT INTO "source_message" VALUES (153,E'app',E'Not yet set');
INSERT INTO "source_message" VALUES (154,E'app',E'Interview needed');
INSERT INTO "source_message" VALUES (155,E'app',E'EPL');
INSERT INTO "source_message" VALUES (157,E'app',E'ESL');
INSERT INTO "source_message" VALUES (158,E'app',E'English as a second language');
INSERT INTO "source_message" VALUES (159,E'app',E'EFL');
INSERT INTO "source_message" VALUES (160,E'app',E'English as a foreign language');
INSERT INTO "source_message" VALUES (161,E'app',E'Not set');
INSERT INTO "source_message" VALUES (162,E'app',E'Error saving InSociety Relation for {user_name}');
INSERT INTO "source_message" VALUES (163,E'app',E'Error Saving User {user_name}');
INSERT INTO "source_message" VALUES (164,E'app',E'{tournament_name}: User Account for {user_name}');
INSERT INTO "source_message" VALUES (165,E'app',E'This URL-Slug is not allowed.');
INSERT INTO "source_message" VALUES (166,E'app',E'Published');
INSERT INTO "source_message" VALUES (167,E'app',E'Displayed');
INSERT INTO "source_message" VALUES (168,E'app',E'Started');
INSERT INTO "source_message" VALUES (169,E'app',E'Judging');
INSERT INTO "source_message" VALUES (170,E'app',E'Finished');
INSERT INTO "source_message" VALUES (171,E'app',E'Main');
INSERT INTO "source_message" VALUES (172,E'app',E'Novice');
INSERT INTO "source_message" VALUES (173,E'app',E'Final');
INSERT INTO "source_message" VALUES (174,E'app',E'Semifinal');
INSERT INTO "source_message" VALUES (175,E'app',E'Quarterfinal');
INSERT INTO "source_message" VALUES (176,E'app',E'Octofinal');
INSERT INTO "source_message" VALUES (177,E'app',E'Round #{num}');
INSERT INTO "source_message" VALUES (178,E'app',E'Inround');
INSERT INTO "source_message" VALUES (179,E'app',E'Energy');
INSERT INTO "source_message" VALUES (180,E'app',E'Info Slide');
INSERT INTO "source_message" VALUES (181,E'app',E'PrepTime started');
INSERT INTO "source_message" VALUES (182,E'app',E'Last Temperature');
INSERT INTO "source_message" VALUES (183,E'app',E'ms to calculate');
INSERT INTO "source_message" VALUES (184,E'app',E'Not enough Teams to fill a single room - (active: {teams_count})');
INSERT INTO "source_message" VALUES (185,E'app',E'At least two Adjudicators are necessary - (active: {count_adju})');
INSERT INTO "source_message" VALUES (186,E'app',E'Amount of active Teams must be divided by 4 ;) - (active: {count_teams})');
INSERT INTO "source_message" VALUES (187,E'app',E'Not enough active Rooms (active: {active_rooms} required: {required})');
INSERT INTO "source_message" VALUES (188,E'app',E'Not enough adjudicators (active: {active}  min-required: {required})');
INSERT INTO "source_message" VALUES (189,E'app',E'Not enough free adjudicators with this preset panel configuration. (fillable rooms: {active}  min-required: {required})');
INSERT INTO "source_message" VALUES (190,E'app',E'Can\'t save Panel! Error: {message}');
INSERT INTO "source_message" VALUES (191,E'app',E'Can\'t save Debate! Error: {message}');
INSERT INTO "source_message" VALUES (192,E'app',E'Can\'t save debate! Errors:<br>{errors}');
INSERT INTO "source_message" VALUES (193,E'app',E'No Debate #{num} found to update');
INSERT INTO "source_message" VALUES (195,E'app',E'Type');
INSERT INTO "source_message" VALUES (196,E'app',E'Parameter if needed');
INSERT INTO "source_message" VALUES (197,E'app',E'Apply to Team -> Chair');
INSERT INTO "source_message" VALUES (198,E'app',E'Apply to Chair -> Wing');
INSERT INTO "source_message" VALUES (199,E'app',E'Apply to Wing -> Chair');
INSERT INTO "source_message" VALUES (200,E'app',E'Not Good');
INSERT INTO "source_message" VALUES (201,E'app',E'Very Good');
INSERT INTO "source_message" VALUES (202,E'app',E'Excellent');
INSERT INTO "source_message" VALUES (203,E'app',E'Star Rating (1-5) Field');
INSERT INTO "source_message" VALUES (204,E'app',E'Short Text Field');
INSERT INTO "source_message" VALUES (205,E'app',E'Long Text Field');
INSERT INTO "source_message" VALUES (206,E'app',E'Number Field');
INSERT INTO "source_message" VALUES (207,E'app',E'Checkbox List Field');
INSERT INTO "source_message" VALUES (208,E'app',E'Debate');
INSERT INTO "source_message" VALUES (209,E'app',E'Feedback To ID');
INSERT INTO "source_message" VALUES (210,E'app',E'Adjudicator Strike From ID');
INSERT INTO "source_message" VALUES (211,E'app',E'Adjudicator Strike To ID');
INSERT INTO "source_message" VALUES (212,E'app',E'Group');
INSERT INTO "source_message" VALUES (213,E'app',E'Active Room');
INSERT INTO "source_message" VALUES (214,E'app',E'Wing');
INSERT INTO "source_message" VALUES (215,E'app',E'Used');
INSERT INTO "source_message" VALUES (216,E'app',E'Is Preset Panel');
INSERT INTO "source_message" VALUES (217,E'app',E'Panel #{id} has {amount} chairs');
INSERT INTO "source_message" VALUES (218,E'app',E'Category');
INSERT INTO "source_message" VALUES (219,E'app',E'Message');
INSERT INTO "source_message" VALUES (220,E'app',E'Function');
INSERT INTO "source_message" VALUES (221,E'app',E'Legacy Motion');
INSERT INTO "source_message" VALUES (222,E'app',E'Questions');
INSERT INTO "source_message" VALUES (223,E'app',E'Clash With');
INSERT INTO "source_message" VALUES (224,E'app',E'Reason');
INSERT INTO "source_message" VALUES (225,E'app',E'Team Clash');
INSERT INTO "source_message" VALUES (226,E'app',E'Adjudicator Clash');
INSERT INTO "source_message" VALUES (227,E'app',E'No type found');
INSERT INTO "source_message" VALUES (228,E'app',E'OG A Speaks');
INSERT INTO "source_message" VALUES (229,E'app',E'OG B Speaks');
INSERT INTO "source_message" VALUES (230,E'app',E'OG Place');
INSERT INTO "source_message" VALUES (231,E'app',E'OO A Speaks');
INSERT INTO "source_message" VALUES (232,E'app',E'OO B Speaks');
INSERT INTO "source_message" VALUES (233,E'app',E'OO Place');
INSERT INTO "source_message" VALUES (234,E'app',E'CG A Speaks');
INSERT INTO "source_message" VALUES (235,E'app',E'CG B Speaks');
INSERT INTO "source_message" VALUES (236,E'app',E'CG Place');
INSERT INTO "source_message" VALUES (237,E'app',E'CO A Speaks');
INSERT INTO "source_message" VALUES (238,E'app',E'CO B Speaks');
INSERT INTO "source_message" VALUES (239,E'app',E'CO Place');
INSERT INTO "source_message" VALUES (240,E'app',E'Checked');
INSERT INTO "source_message" VALUES (241,E'app',E'Entered by User ID');
INSERT INTO "source_message" VALUES (242,E'app',E'Equal place exist');
INSERT INTO "source_message" VALUES (243,E'app',E'Ironman by');
INSERT INTO "source_message" VALUES (244,E'app',E'CA');
INSERT INTO "source_message" VALUES (245,E'app',E'Password reset token cannot be blank.');
INSERT INTO "source_message" VALUES (246,E'app',E'Wrong password reset token.');
INSERT INTO "source_message" VALUES (247,E'app',E'Comma ( , ) separated file');
INSERT INTO "source_message" VALUES (248,E'app',E'Semicolon ( ; ) separated file');
INSERT INTO "source_message" VALUES (249,E'app',E'Tab ( ->| ) separated file');
INSERT INTO "source_message" VALUES (250,E'app',E'CSV File');
INSERT INTO "source_message" VALUES (251,E'app',E'Delimiter');
INSERT INTO "source_message" VALUES (252,E'app',E'Mark as Test Data Import (prohibits Email sending)');
INSERT INTO "source_message" VALUES (253,E'app',E'Username');
INSERT INTO "source_message" VALUES (254,E'app',E'Profile Picture');
INSERT INTO "source_message" VALUES (255,E'app',E'Current Society');
INSERT INTO "source_message" VALUES (256,E'app',E'With which gender do you identify yourself the most');
INSERT INTO "source_message" VALUES (257,E'app',E'This URL is not allowed.');
INSERT INTO "source_message" VALUES (258,E'app',E'{adju} checked in!');
INSERT INTO "source_message" VALUES (259,E'app',E'{adju} already checked in!');
INSERT INTO "source_message" VALUES (260,E'app',E'{id} number not valid! Not an Adjudicator!');
INSERT INTO "source_message" VALUES (261,E'app',E'{speaker} checked in!');
INSERT INTO "source_message" VALUES (262,E'app',E'{speaker} already checked in!');
INSERT INTO "source_message" VALUES (263,E'app',E'{id} number not valid! Not a Team!');
INSERT INTO "source_message" VALUES (264,E'app',E'Not a valid input');
INSERT INTO "source_message" VALUES (265,E'app',E'Verification Code');
INSERT INTO "source_message" VALUES (266,E'app',E'DebReg');
INSERT INTO "source_message" VALUES (267,E'app',E'Password reset for {user}');
INSERT INTO "source_message" VALUES (268,E'app',E'User not found with this Email');
INSERT INTO "source_message" VALUES (269,E'app',E'Add {object}');
INSERT INTO "source_message" VALUES (270,E'app',E'Create Society');
INSERT INTO "source_message" VALUES (271,E'app',E'Hey cool! You entered an unknown Society!');
INSERT INTO "source_message" VALUES (272,E'app',E'Before we can link you, can you please complete the information about your Society:');
INSERT INTO "source_message" VALUES (273,E'app',E'Search for a country ...');
INSERT INTO "source_message" VALUES (274,E'app',E'Add new Society');
INSERT INTO "source_message" VALUES (275,E'app',E'Search for a society ...');
INSERT INTO "source_message" VALUES (276,E'app',E'Enter start date ...');
INSERT INTO "source_message" VALUES (277,E'app',E'Enter ending date if applicable ...');
INSERT INTO "source_message" VALUES (278,E'app',E'Language Officers');
INSERT INTO "source_message" VALUES (279,E'app',E'Officer');
INSERT INTO "source_message" VALUES (280,E'app',E'Any {object} ...');
INSERT INTO "source_message" VALUES (281,E'app',E'Language Status Review');
INSERT INTO "source_message" VALUES (282,E'app',E'Status');
INSERT INTO "source_message" VALUES (283,E'app',E'Request an interview');
INSERT INTO "source_message" VALUES (284,E'app',E'Set ENL');
INSERT INTO "source_message" VALUES (285,E'app',E'Set ESL');
INSERT INTO "source_message" VALUES (286,E'app',E'Language Officer');
INSERT INTO "source_message" VALUES (288,E'app',E'Add');
INSERT INTO "source_message" VALUES (289,E'app',E'Search for a User ...');
INSERT INTO "source_message" VALUES (290,E'app',E'Checkin');
INSERT INTO "source_message" VALUES (291,E'app',E'Submit');
INSERT INTO "source_message" VALUES (292,E'app',E'Generate Badges');
INSERT INTO "source_message" VALUES (293,E'app',E'Only do for User ...');
INSERT INTO "source_message" VALUES (294,E'app',E'Print Badges');
INSERT INTO "source_message" VALUES (295,E'app',E'Generate Barcodes');
INSERT INTO "source_message" VALUES (296,E'app',E'Search for a user ... or leave blank');
INSERT INTO "source_message" VALUES (297,E'app',E'Print Barcodes');
INSERT INTO "source_message" VALUES (298,E'app',E'Teams');
INSERT INTO "source_message" VALUES (299,E'app',E'Team Name');
INSERT INTO "source_message" VALUES (300,E'app',E'Speaker A');
INSERT INTO "source_message" VALUES (301,E'app',E'Speaker B');
INSERT INTO "source_message" VALUES (302,E'app',E'Make it so');
INSERT INTO "source_message" VALUES (303,E'app',E'Motion:');
INSERT INTO "source_message" VALUES (304,E'app',E'Panel:');
INSERT INTO "source_message" VALUES (305,E'app',E'Toogle Active');
INSERT INTO "source_message" VALUES (307,E'app',E'Search for a user ...');
INSERT INTO "source_message" VALUES (308,E'app',E'Tournaments');
INSERT INTO "source_message" VALUES (309,E'app',E'Overview');
INSERT INTO "source_message" VALUES (310,E'app',E'Motions');
INSERT INTO "source_message" VALUES (311,E'app',E'Team Tab');
INSERT INTO "source_message" VALUES (312,E'app',E'Speaker Tab');
INSERT INTO "source_message" VALUES (313,E'app',E'Out-Rounds');
INSERT INTO "source_message" VALUES (314,E'app',E'Breaking Adjudicators');
INSERT INTO "source_message" VALUES (315,E'app',E'Make it so!');
INSERT INTO "source_message" VALUES (316,E'app',E'DebReg Tournament');
INSERT INTO "source_message" VALUES (317,E'app',E'Show old tournaments');
INSERT INTO "source_message" VALUES (318,E'app',E'Adjudicators');
INSERT INTO "source_message" VALUES (319,E'app',E'Result');
INSERT INTO "source_message" VALUES (320,E'app',E'together with {teammate}');
INSERT INTO "source_message" VALUES (321,E'app',E'as ironman');
INSERT INTO "source_message" VALUES (322,E'app',E'You are registered as team <br> \'{team}\' {with} for {society}');
INSERT INTO "source_message" VALUES (323,E'app',E'You are registered as adjudicator for {society}');
INSERT INTO "source_message" VALUES (325,E'app',E'Registration Information');
INSERT INTO "source_message" VALUES (326,E'app',E'Enter Information');
INSERT INTO "source_message" VALUES (327,E'app',E'Round #{num} Info');
INSERT INTO "source_message" VALUES (328,E'app',E'You are <b>{pos}</b> in room <b>{room}</b>.');
INSERT INTO "source_message" VALUES (329,E'app',E'Round starts at: <b>{time}</b>');
INSERT INTO "source_message" VALUES (330,E'app',E'InfoSlide');
INSERT INTO "source_message" VALUES (331,E'app',E'Round #{num} Teams');
INSERT INTO "source_message" VALUES (332,E'app',E'My super awesome IV ... e.g. Vienna IV');
INSERT INTO "source_message" VALUES (333,E'app',E'Select the Convenors ...');
INSERT INTO "source_message" VALUES (334,E'app',E'Enter start date / time ...');
INSERT INTO "source_message" VALUES (335,E'app',E'Enter the end date / time ...');
INSERT INTO "source_message" VALUES (336,E'app',E'Chief Adjudicators');
INSERT INTO "source_message" VALUES (337,E'app',E'Choose your CAs ...');
INSERT INTO "source_message" VALUES (338,E'app',E'Choose your Tabmaster ...');
INSERT INTO "source_message" VALUES (339,E'app',E'Tournament Archive');
INSERT INTO "source_message" VALUES (340,E'app',E'The above error occurred while the Web server was processing your request.');
INSERT INTO "source_message" VALUES (341,E'app',E'Please contact us if you think this is a server error. Thank you.');
INSERT INTO "source_message" VALUES (342,E'app',E'Reset password');
INSERT INTO "source_message" VALUES (343,E'app',E'Please choose your new password:');
INSERT INTO "source_message" VALUES (344,E'app',E'Save');
INSERT INTO "source_message" VALUES (345,E'app',E'Signup');
INSERT INTO "source_message" VALUES (346,E'app',E'Please fill out the following fields to signup:');
INSERT INTO "source_message" VALUES (347,E'app',E'Most tournament allocation algorithm in this system try also to take panel diversity into account.\n					For this to work at all, we would politely ask to choose an option from this list.\n					We are aware that not every personal preference can be matched by our choises and apologise for missing options.\n					If you feel that none of the options is in any applicable please choose <Not Revealing>.\n					This option will never be shown to any user and is only for calculation purposes only!');
INSERT INTO "source_message" VALUES (348,E'app',E'Login');
INSERT INTO "source_message" VALUES (349,E'app',E'Please fill out the following fields to login:');
INSERT INTO "source_message" VALUES (350,E'app',E'If you forgot your password you can {resetIt}');
INSERT INTO "source_message" VALUES (351,E'app',E'reset it');
INSERT INTO "source_message" VALUES (352,E'app',E'Request password reset');
INSERT INTO "source_message" VALUES (353,E'app',E'Please fill out your email. A link to reset password will be sent there.');
INSERT INTO "source_message" VALUES (354,E'app',E'Send');
INSERT INTO "source_message" VALUES (355,E'app',E'Venue CSV');
INSERT INTO "source_message" VALUES (356,E'app',E'Adjudicator CSV');
INSERT INTO "source_message" VALUES (357,E'app',E'Team CSV');
INSERT INTO "source_message" VALUES (358,E'app',E'created');
INSERT INTO "source_message" VALUES (359,E'app',E'Sample Venue CSV');
INSERT INTO "source_message" VALUES (360,E'app',E'Sample Team CSV');
INSERT INTO "source_message" VALUES (361,E'app',E'Sample Adjudicator CSV');
INSERT INTO "source_message" VALUES (362,E'app',E'Current BP Debate {count, plural, =0{Tournament} =1{Tournament} other{Tournaments}}');
INSERT INTO "source_message" VALUES (363,E'app',E'Welcome to {appName}!');
INSERT INTO "source_message" VALUES (364,E'app',E'View Tournaments');
INSERT INTO "source_message" VALUES (365,E'app',E'Create Tournament');
INSERT INTO "source_message" VALUES (366,E'app',E'Before we can register you can you please complete the information about your Society:');
INSERT INTO "source_message" VALUES (367,E'app',E'Contact');
INSERT INTO "source_message" VALUES (368,E'app',E'Preset Panel #');
INSERT INTO "source_message" VALUES (369,E'app',E'Panels');
INSERT INTO "source_message" VALUES (370,E'app',E'Average Panel Strength');
INSERT INTO "source_message" VALUES (371,E'app',E'Create Panel');
INSERT INTO "source_message" VALUES (372,E'app',E'Preset Panels for next round');
INSERT INTO "source_message" VALUES (373,E'app',E'Add {object} ...');
INSERT INTO "source_message" VALUES (374,E'app',E'Place');
INSERT INTO "source_message" VALUES (375,E'app',E'Team Points');
INSERT INTO "source_message" VALUES (376,E'app',E'#{number}');
INSERT INTO "source_message" VALUES (377,E'app',E'No Breaking Adjudicators defined');
INSERT INTO "source_message" VALUES (378,E'app',E'Speaker Points Distribution');
INSERT INTO "source_message" VALUES (379,E'app',E'Run');
INSERT INTO "source_message" VALUES (380,E'app',E'Opening Gov');
INSERT INTO "source_message" VALUES (381,E'app',E'Opening Opp');
INSERT INTO "source_message" VALUES (382,E'app',E'Closing Gov');
INSERT INTO "source_message" VALUES (383,E'app',E'Closing Opp');
INSERT INTO "source_message" VALUES (384,E'app',E'Show Info Slide');
INSERT INTO "source_message" VALUES (385,E'app',E'Show Motion');
INSERT INTO "source_message" VALUES (386,E'app',E'Missing User');
INSERT INTO "source_message" VALUES (387,E'app',E'Mark missing as inactive');
INSERT INTO "source_message" VALUES (388,E'app',E'Results');
INSERT INTO "source_message" VALUES (389,E'app',E'Runner View for Round #{number}');
INSERT INTO "source_message" VALUES (390,E'app',E'Auto Update <i id=\'pjax-status\' class=\'\'></i>');
INSERT INTO "source_message" VALUES (391,E'app',E'Update individual clash');
INSERT INTO "source_message" VALUES (392,E'app',E'Individual Clash');
INSERT INTO "source_message" VALUES (393,E'app',E'Not every debater is yet in the system. :)');
INSERT INTO "source_message" VALUES (394,E'app',E'Create clash');
INSERT INTO "source_message" VALUES (395,E'app',E'Update clash');
INSERT INTO "source_message" VALUES (396,E'app',E'Energy Configs');
INSERT INTO "source_message" VALUES (397,E'app',E'Update Energy Value');
INSERT INTO "source_message" VALUES (398,E'app',E'Round #{number}');
INSERT INTO "source_message" VALUES (399,E'app',E'Rounds');
INSERT INTO "source_message" VALUES (400,E'app',E'Actions');
INSERT INTO "source_message" VALUES (401,E'app',E'Publish Tab');
INSERT INTO "source_message" VALUES (402,E'app',E'Retry to generate Draw');
INSERT INTO "source_message" VALUES (403,E'app',E'Update Round');
INSERT INTO "source_message" VALUES (404,E'app',E'Toggle Dropdown');
INSERT INTO "source_message" VALUES (405,E'app',E'Continue Improving by');
INSERT INTO "source_message" VALUES (407,E'app',E'Are you sure you want to re-draw the round? All information will be lost!');
INSERT INTO "source_message" VALUES (408,E'app',E'Print Ballots');
INSERT INTO "source_message" VALUES (411,E'app',E'Round Status');
INSERT INTO "source_message" VALUES (412,E'app',E'Average Energy');
INSERT INTO "source_message" VALUES (413,E'app',E'Creation Time');
INSERT INTO "source_message" VALUES (414,E'app',E'Color Palette');
INSERT INTO "source_message" VALUES (415,E'app',E'Gender');
INSERT INTO "source_message" VALUES (416,E'app',E'Regions');
INSERT INTO "source_message" VALUES (417,E'app',E'Points');
INSERT INTO "source_message" VALUES (418,E'app',E'Loading ...');
INSERT INTO "source_message" VALUES (419,E'app',E'View Feedback');
INSERT INTO "source_message" VALUES (420,E'app',E'View User');
INSERT INTO "source_message" VALUES (421,E'app',E'Switch venue {venue} with');
INSERT INTO "source_message" VALUES (422,E'app',E'Select a Venue ...');
INSERT INTO "source_message" VALUES (423,E'app',E'Update {modelClass} #{number}');
INSERT INTO "source_message" VALUES (424,E'app',E'Energy Level');
INSERT INTO "source_message" VALUES (425,E'app',E'Select a Team ...');
INSERT INTO "source_message" VALUES (426,E'app',E'Select a Language ...');
INSERT INTO "source_message" VALUES (427,E'app',E'Select an Adjudicator ...');
INSERT INTO "source_message" VALUES (428,E'app',E'Switch Adjudicators');
INSERT INTO "source_message" VALUES (429,E'app',E'Switch this Adjudicator ...');
INSERT INTO "source_message" VALUES (430,E'app',E'with');
INSERT INTO "source_message" VALUES (431,E'app',E'with this one ...');
INSERT INTO "source_message" VALUES (432,E'app',E'Search for a Motion tag ...');
INSERT INTO "source_message" VALUES (433,E'app',E'Rank');
INSERT INTO "source_message" VALUES (434,E'app',E'Total');
INSERT INTO "source_message" VALUES (435,E'app',E'Debate ID');
INSERT INTO "source_message" VALUES (436,E'app',E'Room');
INSERT INTO "source_message" VALUES (437,E'app',E'Outrounds');
INSERT INTO "source_message" VALUES (438,E'app',E'Motion Archive');
INSERT INTO "source_message" VALUES (439,E'app',E'Third-Party\n			Motion');
INSERT INTO "source_message" VALUES (440,E'app',E'Your amazing IV');
INSERT INTO "source_message" VALUES (441,E'app',E'Enter date ...');
INSERT INTO "source_message" VALUES (442,E'app',E'Round #1 or Final');
INSERT INTO "source_message" VALUES (443,E'app',E'THW ...');
INSERT INTO "source_message" VALUES (444,E'app',E'http://give.credit.where.credit.is.due.com');
INSERT INTO "source_message" VALUES (445,E'app',E'Enter {modelClass} Manual');
INSERT INTO "source_message" VALUES (446,E'app',E'Options');
INSERT INTO "source_message" VALUES (447,E'app',E'Continue');
INSERT INTO "source_message" VALUES (448,E'app',E'No results yet!');
INSERT INTO "source_message" VALUES (449,E'app',E'Results in Room: {venue}');
INSERT INTO "source_message" VALUES (450,E'app',E'Results for {venue}');
INSERT INTO "source_message" VALUES (451,E'app',E'Table View');
INSERT INTO "source_message" VALUES (452,E'app',E'Results for {label}');
INSERT INTO "source_message" VALUES (453,E'app',E'Switch to Venue View');
INSERT INTO "source_message" VALUES (454,E'app',E'Swing Team Score');
INSERT INTO "source_message" VALUES (455,E'app',E'View Result Details');
INSERT INTO "source_message" VALUES (456,E'app',E'Correct Result');
INSERT INTO "source_message" VALUES (457,E'app',E'Venue View');
INSERT INTO "source_message" VALUES (458,E'app',E'Switch to Tableview');
INSERT INTO "source_message" VALUES (459,E'app',E'Confirm Data for {venue}');
INSERT INTO "source_message" VALUES (460,E'app',E'start over');
INSERT INTO "source_message" VALUES (461,E'app',E'Round {number}');
INSERT INTO "source_message" VALUES (462,E'app',E'Thank you');
INSERT INTO "source_message" VALUES (463,E'app',E'Thank you!');
INSERT INTO "source_message" VALUES (464,E'app',E'Results successfully saved');
INSERT INTO "source_message" VALUES (465,E'app',E'Speeeed Bonus!');
INSERT INTO "source_message" VALUES (466,E'app',E'Hurry up! Chop Chop!');
INSERT INTO "source_message" VALUES (467,E'app',E'Bummer! Last one!');
INSERT INTO "source_message" VALUES (468,E'app',E'You are <b>#{place}</b> from {max}');
INSERT INTO "source_message" VALUES (469,E'app',E'Enter Feedback');
INSERT INTO "source_message" VALUES (470,E'app',E'Return to Tournament');
INSERT INTO "source_message" VALUES (471,E'app',E'Feedbacks');
INSERT INTO "source_message" VALUES (472,E'app',E'Target Adjudicator');
INSERT INTO "source_message" VALUES (473,E'app',E'Adjudicator name ...');
INSERT INTO "source_message" VALUES (474,E'app',E'Adjudicator Feedback');
INSERT INTO "source_message" VALUES (475,E'app',E'Submit Feedback');
INSERT INTO "source_message" VALUES (476,E'app',E'{tournament} - Language Officer');
INSERT INTO "source_message" VALUES (477,E'app',E'Review Language Status');
INSERT INTO "source_message" VALUES (478,E'app',E'made with secret alien technology');
INSERT INTO "source_message" VALUES (479,E'app',E'Report a Bug');
INSERT INTO "source_message" VALUES (480,E'app',E'{tournament} - Manager');
INSERT INTO "source_message" VALUES (481,E'app',E'List Venues');
INSERT INTO "source_message" VALUES (482,E'app',E'Create Venue');
INSERT INTO "source_message" VALUES (483,E'app',E'Import Venue');
INSERT INTO "source_message" VALUES (484,E'app',E'List Teams');
INSERT INTO "source_message" VALUES (485,E'app',E'Create Team');
INSERT INTO "source_message" VALUES (486,E'app',E'Import Team');
INSERT INTO "source_message" VALUES (487,E'app',E'Strike Team');
INSERT INTO "source_message" VALUES (488,E'app',E'List Adjudicators');
INSERT INTO "source_message" VALUES (489,E'app',E'Create Adjudicator');
INSERT INTO "source_message" VALUES (490,E'app',E'Import Adjudicator');
INSERT INTO "source_message" VALUES (491,E'app',E'View Preset Panels');
INSERT INTO "source_message" VALUES (492,E'app',E'Create Preset Panel');
INSERT INTO "source_message" VALUES (493,E'app',E'Strike Adjudicator');
INSERT INTO "source_message" VALUES (494,E'app',E'Update Tournament');
INSERT INTO "source_message" VALUES (495,E'app',E'Display Team Tab');
INSERT INTO "source_message" VALUES (496,E'app',E'Display Speaker Tab');
INSERT INTO "source_message" VALUES (497,E'app',E'Display Outrounds');
INSERT INTO "source_message" VALUES (498,E'app',E'Publishing the Tab will close and archive the tournament!! Are you sure you want to continue?');
INSERT INTO "source_message" VALUES (499,E'app',E'Missing Users');
INSERT INTO "source_message" VALUES (500,E'app',E'Checkin Form');
INSERT INTO "source_message" VALUES (501,E'app',E'Print Badgets');
INSERT INTO "source_message" VALUES (502,E'app',E'Reset Checkin');
INSERT INTO "source_message" VALUES (503,E'app',E'Are you sure you want to reset the checkin?');
INSERT INTO "source_message" VALUES (504,E'app',E'Sync with DebReg');
INSERT INTO "source_message" VALUES (505,E'app',E'Migrate to Tabbie 1');
INSERT INTO "source_message" VALUES (506,E'app',E'Extreme caution young padawan!');
INSERT INTO "source_message" VALUES (507,E'app',E'List Rounds');
INSERT INTO "source_message" VALUES (508,E'app',E'Create Round');
INSERT INTO "source_message" VALUES (509,E'app',E'Energy Options');
INSERT INTO "source_message" VALUES (510,E'app',E'List Results');
INSERT INTO "source_message" VALUES (511,E'app',E'Insert Ballot');
INSERT INTO "source_message" VALUES (512,E'app',E'Correct Cache');
INSERT INTO "source_message" VALUES (513,E'app',E'Setup Questions');
INSERT INTO "source_message" VALUES (514,E'app',E'Every Feedback');
INSERT INTO "source_message" VALUES (515,E'app',E'Feedback on Adjudicator');
INSERT INTO "source_message" VALUES (516,E'app',E'About');
INSERT INTO "source_message" VALUES (517,E'app',E'How-To');
INSERT INTO "source_message" VALUES (518,E'app',E'Users');
INSERT INTO "source_message" VALUES (519,E'app',E'Register');
INSERT INTO "source_message" VALUES (520,E'app',E'{user}\'s Profile');
INSERT INTO "source_message" VALUES (521,E'app',E'{user}\'s History');
INSERT INTO "source_message" VALUES (522,E'app',E'Logout');
INSERT INTO "source_message" VALUES (524,E'app',E'Update {label}');
INSERT INTO "source_message" VALUES (525,E'app',E'Next Step');
INSERT INTO "source_message" VALUES (526,E'app',E'Room {number}');
INSERT INTO "source_message" VALUES (527,E'app',E'Venues');
INSERT INTO "source_message" VALUES (529,E'app',E'Strikes');
INSERT INTO "source_message" VALUES (530,E'app',E'Import Strikes');
INSERT INTO "source_message" VALUES (531,E'app',E'Accept');
INSERT INTO "source_message" VALUES (532,E'app',E'Deny');
INSERT INTO "source_message" VALUES (533,E'app',E'Search for a Team ...');
INSERT INTO "source_message" VALUES (534,E'app',E'Search for an Adjudicator ...');
INSERT INTO "source_message" VALUES (535,E'app',E'Strike Adjudicators');
INSERT INTO "source_message" VALUES (536,E'app',E'Create Additional {modelClass}');
INSERT INTO "source_message" VALUES (537,E'app',E'Update team');
INSERT INTO "source_message" VALUES (538,E'app',E'Delete team');
INSERT INTO "source_message" VALUES (539,E'app',E'Search for an From Adjudicator ...');
INSERT INTO "source_message" VALUES (540,E'app',E'Search for an To Adjudicator ...');
INSERT INTO "source_message" VALUES (541,E'app',E'Strike Team with Adjudicator');
INSERT INTO "source_message" VALUES (542,E'app',E'Update Team');
INSERT INTO "source_message" VALUES (543,E'app',E'Delete Team');
INSERT INTO "source_message" VALUES (544,E'app',E'{modelClass}\'s History');
INSERT INTO "source_message" VALUES (545,E'app',E'History');
INSERT INTO "source_message" VALUES (546,E'app',E'Team Review');
INSERT INTO "source_message" VALUES (547,E'app',E'EPL Place');
INSERT INTO "source_message" VALUES (548,E'app',E'Team Speaker Points');
INSERT INTO "source_message" VALUES (549,E'app',E'No published tab available at the moment');
INSERT INTO "source_message" VALUES (550,E'app',E'Can chair');
INSERT INTO "source_message" VALUES (551,E'app',E'Should not chair');
INSERT INTO "source_message" VALUES (552,E'app',E'Break');
INSERT INTO "source_message" VALUES (553,E'app',E'Not breaking');
INSERT INTO "source_message" VALUES (554,E'app',E'Watched');
INSERT INTO "source_message" VALUES (555,E'app',E'Unwatched');
INSERT INTO "source_message" VALUES (556,E'app',E'Toogle Watch');
INSERT INTO "source_message" VALUES (557,E'app',E'Toogle Breaking');
INSERT INTO "source_message" VALUES (558,E'app',E'Reset watcher flag');
INSERT INTO "source_message" VALUES (559,E'app',E'Search for a {object} ...');
INSERT INTO "source_message" VALUES (560,E'app',E'Chaired');
INSERT INTO "source_message" VALUES (561,E'app',E'Pointer');
INSERT INTO "source_message" VALUES (562,E'app',E'Update User profile');
INSERT INTO "source_message" VALUES (563,E'app',E'Individual Clashes');
INSERT INTO "source_message" VALUES (564,E'app',E'Update Clash Info');
INSERT INTO "source_message" VALUES (565,E'app',E'Delete Clash');
INSERT INTO "source_message" VALUES (566,E'app',E'No clash known to the system.');
INSERT INTO "source_message" VALUES (567,E'app',E'Debate Society History');
INSERT INTO "source_message" VALUES (568,E'app',E'Add new society to history');
INSERT INTO "source_message" VALUES (569,E'app',E'still active');
INSERT INTO "source_message" VALUES (570,E'app',E'Update Society Info');
INSERT INTO "source_message" VALUES (571,E'app',E'Force new password for {name}');
INSERT INTO "source_message" VALUES (572,E'app',E'Cancel');
INSERT INTO "source_message" VALUES (573,E'app',E'Search for a tournament ...');
INSERT INTO "source_message" VALUES (574,E'app',E'Set new Password');
INSERT INTO "source_message" VALUES (575,E'app',E'Update User');
INSERT INTO "source_message" VALUES (576,E'app',E'Delete User');
INSERT INTO "source_message" VALUES (577,E'app',E'Create User');
INSERT INTO "source_message" VALUES (578,E'app',E'No condition matched');
INSERT INTO "source_message" VALUES (579,E'app',E'Did not pass panel check old: {old} / new: {new}');
INSERT INTO "source_message" VALUES (580,E'app',E'Can\'t save {object}! Error: {message}');
INSERT INTO "source_message" VALUES (582,E'app',E'No File available');
INSERT INTO "source_message" VALUES (583,E'app',E'No matching records found');
INSERT INTO "source_message" VALUES (584,E'app',E'Thank you for your submission.');
INSERT INTO "source_message" VALUES (585,E'app',E'Error saving Panel:');
INSERT INTO "source_message" VALUES (586,E'app',E'Panel deleted');
INSERT INTO "source_message" VALUES (587,E'app',E'Welcome! This is your first login, please check that your information are correct');
INSERT INTO "source_message" VALUES (588,E'app',E'A new society has been saved');
INSERT INTO "source_message" VALUES (589,E'app',E'There has been an error receiving your previous input. Please enter them again.');
INSERT INTO "source_message" VALUES (590,E'app',E'User registered! Welcome {user}');
INSERT INTO "source_message" VALUES (591,E'app',E'Login failed');
INSERT INTO "source_message" VALUES (592,E'app',E'Check your email for further instructions.');
INSERT INTO "source_message" VALUES (593,E'app',E'Sorry, we are unable to reset password for email provided.<br>{message}');
INSERT INTO "source_message" VALUES (594,E'app',E'New password was saved.');
INSERT INTO "source_message" VALUES (595,E'app',E'New Passwort set');
INSERT INTO "source_message" VALUES (596,E'app',E'Error saving new password');
INSERT INTO "source_message" VALUES (597,E'app',E'Society connection not saved');
INSERT INTO "source_message" VALUES (598,E'app',E'User successfully saved!');
INSERT INTO "source_message" VALUES (599,E'app',E'User not saved!');
INSERT INTO "source_message" VALUES (600,E'app',E'Society Connection not saved!');
INSERT INTO "source_message" VALUES (601,E'app',E'User successfully updated!');
INSERT INTO "source_message" VALUES (602,E'app',E'Please enter a new password!');
INSERT INTO "source_message" VALUES (603,E'app',E'User deleted');
INSERT INTO "source_message" VALUES (604,E'app',E'Cant\'t delete because of {error}');
INSERT INTO "source_message" VALUES (605,E'app',E'Cound\'t delete because already in use. <br> {ex}');
INSERT INTO "source_message" VALUES (606,E'app',E'Checking Flags reset');
INSERT INTO "source_message" VALUES (607,E'app',E'There was no need for a reset');
INSERT INTO "source_message" VALUES (608,E'app',E'Please set breaking adjudicators first - use the star icon in the action column.');
INSERT INTO "source_message" VALUES (609,E'app',E'Couldn\'t create Team.');
INSERT INTO "source_message" VALUES (610,E'app',E'Error saving Society Relation for {society}');
INSERT INTO "source_message" VALUES (611,E'app',E'Error saving team {name}!');
INSERT INTO "source_message" VALUES (613,E'app',E'Can\'t save Tournament connection');
INSERT INTO "source_message" VALUES (614,E'app',E'Can\'t delete Question');
INSERT INTO "source_message" VALUES (615,E'app',E'Society connection successfully created');
INSERT INTO "source_message" VALUES (616,E'app',E'Society could not be saved');
INSERT INTO "source_message" VALUES (617,E'app',E'Error in wakeup');
INSERT INTO "source_message" VALUES (618,E'app',E'Society Info updated');
INSERT INTO "source_message" VALUES (619,E'app',E'Tab published and tournament closed. Go have a drink!');
INSERT INTO "source_message" VALUES (620,E'app',E'Chair in Panel not found - type wrong?');
INSERT INTO "source_message" VALUES (622,E'app',E'No valid type');
INSERT INTO "source_message" VALUES (623,E'app',E'{object} successfully submitted');
INSERT INTO "source_message" VALUES (624,E'app',E'{object} created');
INSERT INTO "source_message" VALUES (625,E'app',E'Individual clash');
INSERT INTO "source_message" VALUES (626,E'app',E'Individual clash could not be saved');
INSERT INTO "source_message" VALUES (627,E'app',E'{object} updated');
INSERT INTO "source_message" VALUES (628,E'app',E'{object} could not be saved');
INSERT INTO "source_message" VALUES (629,E'app',E'{object} deleted');
INSERT INTO "source_message" VALUES (630,E'app',E'{tournament} on Tabbie2');
INSERT INTO "source_message" VALUES (631,E'app',E'{tournament} is taking place from {start} to {end} hosted by {host} in {country}');
INSERT INTO "source_message" VALUES (632,E'app',E'Tournament successfully created');
INSERT INTO "source_message" VALUES (633,E'app',E'Tournament created but Energy config failed!');
INSERT INTO "source_message" VALUES (634,E'app',E'Can\'t save Tournament!');
INSERT INTO "source_message" VALUES (635,E'app',E'DebReg Syncing successful');
INSERT INTO "source_message" VALUES (636,E'app',E'Venues switched');
INSERT INTO "source_message" VALUES (637,E'app',E'Error while switching');
INSERT INTO "source_message" VALUES (638,E'app',E'New Venues set');
INSERT INTO "source_message" VALUES (639,E'app',E'Error while setting new venue');
INSERT INTO "source_message" VALUES (640,E'app',E'Can\'t create Round: Amount of Teams is not dividable by 4');
INSERT INTO "source_message" VALUES (641,E'app',E'Successfully redrawn in {secs}s');
INSERT INTO "source_message" VALUES (642,E'app',E'Improved Energy by {diff} points in {secs}s');
INSERT INTO "source_message" VALUES (643,E'app',E'Adjudicator {n1} and {n2} switched');
INSERT INTO "source_message" VALUES (644,E'app',E'Could not switch because: {a_panel}<br>and<br>{b_panel}');
INSERT INTO "source_message" VALUES (645,E'app',E'Show Round {number}');
INSERT INTO "source_message" VALUES (646,E'app',E'No debates found in that round');
INSERT INTO "source_message" VALUES (647,E'app',E'Not a valid language options in params');
INSERT INTO "source_message" VALUES (648,E'app',E'Team upgraded to {status}');
INSERT INTO "source_message" VALUES (649,E'app',E'Language Settings saved');
INSERT INTO "source_message" VALUES (650,E'app',E'Error saving Language Settings');
INSERT INTO "source_message" VALUES (651,E'app',E'User not found!');
INSERT INTO "source_message" VALUES (652,E'app',E'{object} successfully added');
INSERT INTO "source_message" VALUES (653,E'app',E'Successfully deleted');
INSERT INTO "source_message" VALUES (654,E'app',E'File Syntax Wrong! Expecting 3 columns');
INSERT INTO "source_message" VALUES (656,E'app',E'Error saving Results.<br>Please request a paper ballot!');
INSERT INTO "source_message" VALUES (657,E'app',E'Result saved. Next one!');
INSERT INTO "source_message" VALUES (658,E'app',E'Debate #{id} does not exist');
INSERT INTO "source_message" VALUES (659,E'app',E'Correct Team Points for {team} from {old_points} to {new_points}');
INSERT INTO "source_message" VALUES (660,E'app',E'Correct Speaker {pos} speaks for {team} from {old_points} to {new_points}');
INSERT INTO "source_message" VALUES (661,E'app',E'Cache in perfect shape. No change needed!');
INSERT INTO "source_message" VALUES (662,E'app',E'Can\'t save clash decision. {reason}');
INSERT INTO "source_message" VALUES (663,E'app',E'Not enough venues');
INSERT INTO "source_message" VALUES (664,E'app',E'Too many venues');
INSERT INTO "source_message" VALUES (665,E'app',E'Max Iterations to improve the Adjudicator Allocation');
INSERT INTO "source_message" VALUES (666,E'app',E'Team and adjudicator in same society penalty');
INSERT INTO "source_message" VALUES (667,E'app',E'Both Adjudicators are clashed');
INSERT INTO "source_message" VALUES (668,E'app',E'Team with Adjudicator is clashed');
INSERT INTO "source_message" VALUES (669,E'app',E'Adjudicator is not allowed to chair');
INSERT INTO "source_message" VALUES (670,E'app',E'Chair is not perfect at the current situation');
INSERT INTO "source_message" VALUES (671,E'app',E'Adjudicator has seen the team already');
INSERT INTO "source_message" VALUES (672,E'app',E'Adjudicator has already judged in this combination');
INSERT INTO "source_message" VALUES (673,E'app',E'Panel is wrong strength for room');
INSERT INTO "source_message" VALUES (674,E'app',E'Richard\'s special ingredient');
INSERT INTO "source_message" VALUES (675,E'app',E'Adjudicator {adju} and {team} in same society.');
INSERT INTO "source_message" VALUES (676,E'app',E'Adjudicator {adju1} and {adju2} are manually clashed.');
INSERT INTO "source_message" VALUES (677,E'app',E'Adjudicator {adju} and Team {team} are manually clashed.');
INSERT INTO "source_message" VALUES (678,E'app',E'Adjudicator {adju} has been labelled a non-chair.');
INSERT INTO "source_message" VALUES (679,E'app',E'Chair not perfect by {points}.');
INSERT INTO "source_message" VALUES (680,E'app',E'Adjudicator {adju1} and {adju2} have judged together x{occ} before');
INSERT INTO "source_message" VALUES (681,E'app',E'Adjudicator {adju} has judged Team {team} x {occ} before.');
INSERT INTO "source_message" VALUES (682,E'app',E'Steepness Comparison: {comparison_factor}, Difference: {roomDifference}, Steepness Penalty: {steepnessPenalty}');
INSERT INTO "source_message" VALUES (686,E'app.country',E'Undefined');
INSERT INTO "source_message" VALUES (687,E'app.country',E'Northern Europe');
INSERT INTO "source_message" VALUES (688,E'app.country',E'Western Europe');
INSERT INTO "source_message" VALUES (689,E'app.country',E'Southern Europe');
INSERT INTO "source_message" VALUES (690,E'app.country',E'Eastern Europe');
INSERT INTO "source_message" VALUES (691,E'app.country',E'Central Asia');
INSERT INTO "source_message" VALUES (692,E'app.country',E'Eastern Asia');
INSERT INTO "source_message" VALUES (693,E'app.country',E'Western Asia');
INSERT INTO "source_message" VALUES (694,E'app.country',E'Southern Asia');
INSERT INTO "source_message" VALUES (695,E'app.country',E'South-Eastern Asia');
INSERT INTO "source_message" VALUES (696,E'app.country',E'Australia & New Zealand');
INSERT INTO "source_message" VALUES (697,E'app.country',E'Micronesia');
INSERT INTO "source_message" VALUES (698,E'app.country',E'Melanesia');
INSERT INTO "source_message" VALUES (699,E'app.country',E'Polynesia');
INSERT INTO "source_message" VALUES (700,E'app.country',E'Northern Africa');
INSERT INTO "source_message" VALUES (701,E'app.country',E'Western Africa');
INSERT INTO "source_message" VALUES (702,E'app.country',E'Central Africa');
INSERT INTO "source_message" VALUES (703,E'app.country',E'Eastern Africa');
INSERT INTO "source_message" VALUES (704,E'app.country',E'Southern Africa');
INSERT INTO "source_message" VALUES (705,E'app.country',E'Northern America');
INSERT INTO "source_message" VALUES (706,E'app.country',E'Central America');
INSERT INTO "source_message" VALUES (707,E'app.country',E'Caribbean');
INSERT INTO "source_message" VALUES (708,E'app.country',E'South America');
INSERT INTO "source_message" VALUES (709,E'app.country',E'Antarctic');
INSERT INTO "source_message" VALUES (710,E'app',E'Punished Adjudicator');
INSERT INTO "source_message" VALUES (711,E'app',E'Bad Adjudicator');
INSERT INTO "source_message" VALUES (712,E'app',E'Decent Adjudicator');
INSERT INTO "source_message" VALUES (713,E'app',E'Average Adjudicator');
INSERT INTO "source_message" VALUES (714,E'app',E'Average Chair');
INSERT INTO "source_message" VALUES (715,E'app',E'Good Chair');
INSERT INTO "source_message" VALUES (716,E'app',E'Breaking Chair');
INSERT INTO "source_message" VALUES (717,E'app',E'<b>This tournament has no teams yet.</b><br>{add_button} or {import_button}');
INSERT INTO "source_message" VALUES (718,E'app',E'Add a team');
INSERT INTO "source_message" VALUES (719,E'app',E'Import them via CSV File.');
INSERT INTO "source_message" VALUES (720,E'app',E'This tournament has no venues yet.<br>{add} or {import}');
INSERT INTO "source_message" VALUES (721,E'app',E'Add a venue');
INSERT INTO "source_message" VALUES (722,E'app',E'Import them via csv File');
INSERT INTO "source_message" VALUES (723,E'app',E'<b>This tournament has no adjudicators yet.</b><br>{add_button} or {import_button}.');
INSERT INTO "source_message" VALUES (724,E'app',E'Import them via CSV File');
INSERT INTO "source_message" VALUES (725,E'app',E'Already Results entered for this round. Can\'t redraw!');
INSERT INTO "source_message" VALUES (726,E'app',E'Already Results entered for this round. Can\'t improve!');
INSERT INTO "source_message" VALUES (727,E'app',E'Feedback #{num}');
INSERT INTO "source_message" VALUES (728,E'app',E'User ID');
INSERT INTO "source_message" VALUES (729,E'app',E'Language Maintainer');
INSERT INTO "source_message" VALUES (730,E'app',E'Language Maintainers');
INSERT INTO "source_message" VALUES (731,E'app',E'Create Language Maintainer');
INSERT INTO "source_message" VALUES (732,E'app',E'Show EFL Ranking');
INSERT INTO "source_message" VALUES (733,E'app',E'Show Novice Ranking');
INSERT INTO "source_message" VALUES (734,E'app',E'English as proficient language');
INSERT INTO "source_message" VALUES (735,E'app',E'NOV');
INSERT INTO "source_message" VALUES (736,E'app',E'Set Novice');
INSERT INTO "source_message" VALUES (737,E'app',E'ENL');
INSERT INTO "source_message" VALUES (738,E'app',E'Create new Language');
INSERT INTO "source_message" VALUES (739,E'app',E'Export Draw as JSON');
INSERT INTO "source_message" VALUES (740,E'app',E'Can\'t delete Team {name} because it is already in use');
INSERT INTO "source_message" VALUES (741,E'app',E'Can\'t delete Adjudicator {name} because he/she is already in use');
INSERT INTO "source_message" VALUES (742,E'app',E'Can\'t delete Venue {name} because it is already in use');
INSERT INTO "source_message" VALUES (743,E'app',E'Tell us in 3-4 general keywords what the motion is about. Reuse tags ...');
INSERT INTO "source_message" VALUES (744,E'app',E'Error Saving Custom Attribute: {name}');
INSERT INTO "source_message" VALUES (745,E'app',E'Error Saving Custom Value \'{key}\': {value}');
INSERT INTO "source_message" VALUES (746,E'app',E'User Attr ID');
INSERT INTO "source_message" VALUES (747,E'app',E'Tournament ID');
INSERT INTO "source_message" VALUES (748,E'app',E'Required');
INSERT INTO "source_message" VALUES (749,E'app',E'Help');
INSERT INTO "source_message" VALUES (750,E'app',E'Custom Values for {tournament}');
INSERT INTO "source_message" VALUES (751,E'app',E'File Syntax not matching. Minimal 5 columns required.');
INSERT INTO "source_message" VALUES (753,E'app',E'Trainee');
INSERT INTO "source_message" VALUES (754,E'app',E'Import {modelClass} #{number}');
INSERT INTO "source_message" VALUES (755,E'app',E'Publish approved Draw');
INSERT INTO "source_message" VALUES (756,E'app',E'Import Draw from JSON');
INSERT INTO "source_message" VALUES (757,E'app',E'This will override the current draw! All information will be lost!');
INSERT INTO "source_message" VALUES (758,E'app',E'Re-draw Round');
INSERT INTO "source_message" VALUES (759,E'app',E'Delete Round');
INSERT INTO "source_message" VALUES (760,E'app',E'Are you sure you want to DELETE the round? All information will be lost!');
INSERT INTO "source_message" VALUES (761,E'app',E'Round is already active! Can\'t override with input.');
INSERT INTO "source_message" VALUES (762,E'app',E'Uploaded file was empty. Please select a file.');
INSERT INTO "source_message" VALUES (764,E'app',E'Speakers');
INSERT INTO "source_message" VALUES (765,E'app',E'File Syntax Wrong! At least {min} columns expected; {num} provided in line {line}');
INSERT INTO "source_message" VALUES (766,E'app',E'Question Text');
INSERT INTO "source_message" VALUES (767,E'app',E'Help Text');
INSERT INTO "source_message" VALUES (770,E'app',E'Adjudicator to Adjudicator Clashes');
INSERT INTO "source_message" VALUES (771,E'app',E'Accept all');
INSERT INTO "source_message" VALUES (772,E'app',E'Deny all');
INSERT INTO "source_message" VALUES (773,E'app',E'Team to Adjudicator Clashes');
INSERT INTO "source_message" VALUES (774,E'app',E'Not a valid decision');
INSERT INTO "source_message" VALUES (775,E'app',E'Import Score for {modelClass}');
INSERT INTO "source_message" VALUES (777,E'app',E'Public Access URLs');
INSERT INTO "source_message" VALUES (778,E'app',E'Debate not found - type wrong?');
INSERT INTO "source_message" VALUES (783,E'app',E'Motion Balance');
INSERT INTO "source_message" VALUES (784,E'app',E'Round information');
INSERT INTO "source_message" VALUES (785,E'app',E'There is currently no active round. Refresh this page later.');
INSERT INTO "source_message" VALUES (787,E'app',E'PD-Octofinal');
INSERT INTO "source_message" VALUES (788,E'app',E'Replace adjudicator {adjudicator} with');
INSERT INTO "source_message" VALUES (789,E'app',E'Replace');
INSERT INTO "source_message" VALUES (790,E'app',E'View');
INSERT INTO "source_message" VALUES (791,E'app',E'Switch Team {team} with');
INSERT INTO "source_message" VALUES (792,E'app',E'Retry to set Draw');
INSERT INTO "source_message" VALUES (793,E'app',E'AVG');
INSERT INTO "source_message" VALUES (794,E'app',E'Only authorised Tabmasters can access this function');
INSERT INTO "source_message" VALUES (795,E'app',E'Tournament successfully updated');
INSERT INTO "source_message" VALUES (796,E'app',E'Tournament updated but Energy config updated failed!');

/*!40000 ALTER TABLE source_message ENABLE KEYS */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

--
-- Table structure for table special_needs
--

DROP TABLE IF EXISTS "special_needs" CASCADE;
DROP SEQUENCE IF EXISTS "special_needs_id_seq" CASCADE ;

CREATE SEQUENCE "special_needs_id_seq" ;

CREATE TABLE  "special_needs" (
   "id" integer DEFAULT nextval('"special_needs_id_seq"') NOT NULL,
   "name"   varchar(255) DEFAULT NULL,
   primary key ("id")
)  ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

--
-- Table structure for table tabmaster
--

DROP TABLE IF EXISTS "tabmaster" CASCADE;
CREATE TABLE  "tabmaster" (
   "user_id" int CHECK ("user_id" >= 0) NOT NULL,
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   primary key ("user_id", "tournament_id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "tabmaster_tournament_id_idx" ON "tabmaster" USING btree ("tournament_id");
CREATE INDEX "tabmaster_user_id_idx" ON "tabmaster" USING btree ("user_id");
ALTER TABLE "tabmaster" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");
ALTER TABLE "tabmaster" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

--
-- Table structure for table tag
--

DROP TABLE IF EXISTS "tag" CASCADE;
CREATE TABLE  "tag" (
   "motion_tag_id"   int NOT NULL,
   "round_id" int CHECK ("round_id" >= 0) NOT NULL,
   primary key ("motion_tag_id", "round_id")
)  ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "tag_round_id_idx" ON "tag" USING btree ("round_id");
CREATE INDEX "tag_motion_tag_id_idx" ON "tag" USING btree ("motion_tag_id");
ALTER TABLE "tag" ADD FOREIGN KEY ("motion_tag_id") REFERENCES "motion_tag" ("id");
ALTER TABLE "tag" ADD FOREIGN KEY ("round_id") REFERENCES "round" ("id");

--
-- Table structure for table team
--

DROP TABLE IF EXISTS "team" CASCADE;
DROP SEQUENCE IF EXISTS "team_id_seq" CASCADE ;

CREATE SEQUENCE "team_id_seq"  START WITH 6181 ;

CREATE TABLE  "team" (
   "id" integer DEFAULT nextval('"team_id_seq"') NOT NULL,
   "name"   varchar(255) DEFAULT NULL,
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   "active"    smallint NOT NULL DEFAULT '1',
   "speakera_id" int CHECK ("speakera_id" >= 0) DEFAULT NULL,
   "speakerb_id" int CHECK ("speakerb_id" >= 0) DEFAULT NULL,
   "society_id" int CHECK ("society_id" >= 0) NOT NULL,
   "isswing"    smallint NOT NULL DEFAULT '0',
   "language_status"    smallint NOT NULL DEFAULT '0',
   "points"   int NOT NULL DEFAULT '0',
   "speakera_speaks"   int NOT NULL DEFAULT '0',
   "speakerb_speaks"   int NOT NULL DEFAULT '0',
   "speakera_checkedin"    smallint NOT NULL DEFAULT '0',
   "speakerb_checkedin"    smallint NOT NULL DEFAULT '0',
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "team_speakera_id_idx" ON "team" USING btree ("speakera_id");
CREATE INDEX "team_speakerb_id_idx" ON "team" USING btree ("speakerb_id");
CREATE INDEX "team_tournament_id_idx" ON "team" USING btree ("tournament_id");
CREATE INDEX "team_society_id_idx" ON "team" USING btree ("society_id");
ALTER TABLE "team" ADD FOREIGN KEY ("society_id") REFERENCES "society" ("id");
ALTER TABLE "team" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");
ALTER TABLE "team" ADD FOREIGN KEY ("speakera_id") REFERENCES "user" ("id");
ALTER TABLE "team" ADD FOREIGN KEY ("speakerb_id") REFERENCES "user" ("id");

--
-- Table structure for table team_strike
--

DROP TABLE IF EXISTS "team_strike" CASCADE;
DROP SEQUENCE IF EXISTS "team_strike_id_seq" CASCADE ;

CREATE SEQUENCE "team_strike_id_seq"  START WITH 734 ;

CREATE TABLE  "team_strike" (
   "id" integer DEFAULT nextval('"team_strike_id_seq"') NOT NULL,
   "team_id" int CHECK ("team_id" >= 0) NOT NULL,
   "adjudicator_id" int CHECK ("adjudicator_id" >= 0) NOT NULL,
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   "user_clash_id"   int DEFAULT NULL,
   "accepted"    smallint NOT NULL DEFAULT '1',
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "team_strike_team_id_idx" ON "team_strike" USING btree ("team_id");
CREATE INDEX "team_strike_adjudicator_id_idx" ON "team_strike" USING btree ("adjudicator_id");
CREATE INDEX "team_strike_tournament_id_idx" ON "team_strike" USING btree ("tournament_id");
CREATE INDEX "team_strike_user_clash_id_idx" ON "team_strike" USING btree ("user_clash_id");
ALTER TABLE "team_strike" ADD FOREIGN KEY ("adjudicator_id") REFERENCES "adjudicator" ("id");
ALTER TABLE "team_strike" ADD FOREIGN KEY ("team_id") REFERENCES "team" ("id");
ALTER TABLE "team_strike" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");
ALTER TABLE "team_strike" ADD FOREIGN KEY ("user_clash_id") REFERENCES "user_clash" ("id");

--
-- Table structure for table tournament
--

DROP TABLE IF EXISTS "tournament" CASCADE;
DROP SEQUENCE IF EXISTS "tournament_id_seq" CASCADE ;

CREATE SEQUENCE "tournament_id_seq"  START WITH 318 ;

CREATE TABLE  "tournament" (
   "id" integer DEFAULT nextval('"tournament_id_seq"') NOT NULL,
   "url_slug"   varchar(100) NOT NULL,
   "status"   int NOT NULL DEFAULT '0',
   "hosted_by_id" int CHECK ("hosted_by_id" >= 0) NOT NULL,
   "name"   varchar(100) NOT NULL,
   "start_date"   timestamp without time zone NOT NULL,
   "end_date"   timestamp without time zone NOT NULL,
   "timezone"   varchar(100) NOT NULL,
   "logo"   varchar(255) DEFAULT NULL,
   "time"   timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   "tabalgorithmclass"   varchar(100) NOT NULL DEFAULT 'StrictWUDCRules',
   "expected_rounds"   int NOT NULL DEFAULT '6',
   "has_esl"    smallint NOT NULL DEFAULT '0',
   "has_final"    smallint NOT NULL DEFAULT '1',
   "has_semifinal"    smallint NOT NULL DEFAULT '1',
   "has_quarterfinal"    smallint NOT NULL DEFAULT '0',
   "has_octofinal"    smallint NOT NULL DEFAULT '0',
   "accesstoken"   varchar(255) DEFAULT NULL,
   "badge"   varchar(255) DEFAULT NULL,
   "has_efl"    smallint DEFAULT '0',
   "has_novice"    smallint DEFAULT '0',
   primary key ("id"),
 unique ("url_slug")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "tournament_hosted_by_id_idx" ON "tournament" USING btree ("hosted_by_id");
ALTER TABLE "tournament" ADD FOREIGN KEY ("hosted_by_id") REFERENCES "society" ("id");

--
-- Table structure for table tournament_has_question
--

DROP TABLE IF EXISTS "tournament_has_question" CASCADE;
CREATE TABLE  "tournament_has_question" (
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   "questions_id" int CHECK ("questions_id" >= 0) NOT NULL,
   primary key ("tournament_id", "questions_id")
)  ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "tournament_has_question_questions_id_idx" ON "tournament_has_question" USING btree ("questions_id");
CREATE INDEX "tournament_has_question_tournament_id_idx" ON "tournament_has_question" USING btree ("tournament_id");
ALTER TABLE "tournament_has_question" ADD FOREIGN KEY ("questions_id") REFERENCES "question" ("id");
ALTER TABLE "tournament_has_question" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");

--
-- Table structure for table user
--

DROP TABLE IF EXISTS "user" CASCADE;
DROP SEQUENCE IF EXISTS "user_id_seq" CASCADE ;

CREATE SEQUENCE "user_id_seq"  START WITH 8042 ;

CREATE TABLE  "user" (
   "id" integer DEFAULT nextval('"user_id_seq"') NOT NULL,
   "url_slug"   varchar(255) NOT NULL,
   "auth_key"   varchar(32) NOT NULL,
   "password_hash"   varchar(255) NOT NULL,
   "password_reset_token"   varchar(255) DEFAULT NULL,
   "email"   varchar(255) NOT NULL,
   "role"   smallint NOT NULL DEFAULT '10',
   "status"   smallint NOT NULL DEFAULT '10',
   "givenname"   varchar(255) DEFAULT NULL,
   "surename"   varchar(255) DEFAULT NULL,
   "gender"   int NOT NULL DEFAULT '0',
   "language_status"   int NOT NULL DEFAULT '0',
   "language_status_by_id" int CHECK ("language_status_by_id" >= 0) DEFAULT NULL,
   "language_status_update"   timestamp without time zone DEFAULT NULL,
   "picture"   varchar(255) DEFAULT NULL,
   "last_change"   timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
   "time"   timestamp without time zone NOT NULL,
   "language"   varchar(10) NOT NULL DEFAULT 'en-UK',
   primary key ("id"),
 unique ("email")
)   ;
 CREATE OR REPLACE FUNCTION update_user() RETURNS trigger AS '
BEGIN
    NEW.last_change := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
' LANGUAGE 'plpgsql';

-- before INSERT is handled by 'default CURRENT_TIMESTAMP'
CREATE TRIGGER add_current_date_to_user BEFORE UPDATE ON "user" FOR EACH ROW EXECUTE PROCEDURE
update_user();
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "user_language_status_by_id_idx" ON "user" USING btree ("language_status_by_id");
ALTER TABLE "user" ADD FOREIGN KEY ("language_status_by_id") REFERENCES "user" ("id");

--
-- Table structure for table user_attr
--

DROP TABLE IF EXISTS "user_attr" CASCADE;
DROP SEQUENCE IF EXISTS "user_attr_id_seq" CASCADE ;

CREATE SEQUENCE "user_attr_id_seq"  START WITH 3 ;

CREATE TABLE  "user_attr" (
   "id" integer DEFAULT nextval('"user_attr_id_seq"') NOT NULL,
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   "name"   varchar(100) NOT NULL,
   "required"    smallint NOT NULL DEFAULT '0',
   "help"   text,
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "user_attr_tournament_id_idx" ON "user_attr" USING btree ("tournament_id");
ALTER TABLE "user_attr" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");

--
-- Table structure for table user_clash
--

DROP TABLE IF EXISTS "user_clash" CASCADE;
DROP SEQUENCE IF EXISTS "user_clash_id_seq" CASCADE ;

CREATE SEQUENCE "user_clash_id_seq"  START WITH 1593 ;

CREATE TABLE  "user_clash" (
   "id" integer DEFAULT nextval('"user_clash_id_seq"') NOT NULL,
   "user_id" int CHECK ("user_id" >= 0) NOT NULL,
   "clash_with" int CHECK ("clash_with" >= 0) NOT NULL,
   "reason"   varchar(255) DEFAULT NULL,
   "date"   timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
   primary key ("id")
)    ;
 CREATE OR REPLACE FUNCTION update_user_clash() RETURNS trigger AS '
BEGIN
    NEW.date := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
' LANGUAGE 'plpgsql';

-- before INSERT is handled by 'default CURRENT_TIMESTAMP'
CREATE TRIGGER add_current_date_to_user_clash BEFORE UPDATE ON "user_clash" FOR EACH ROW EXECUTE PROCEDURE
update_user_clash();
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "user_clash_clash_with_idx" ON "user_clash" USING btree ("clash_with");
CREATE INDEX "user_clash_user_id_idx" ON "user_clash" USING btree ("user_id");
ALTER TABLE "user_clash" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "user_clash" ADD FOREIGN KEY ("clash_with") REFERENCES "user" ("id");

--
-- Table structure for table user_value
--

DROP TABLE IF EXISTS "user_value" CASCADE;
DROP SEQUENCE IF EXISTS "user_value_id_seq" CASCADE ;

CREATE SEQUENCE "user_value_id_seq"  START WITH 1115 ;

CREATE TABLE  "user_value" (
   "id" integer DEFAULT nextval('"user_value_id_seq"') NOT NULL,
   "user_id" int CHECK ("user_id" >= 0) NOT NULL,
   "user_attr_id"   int NOT NULL,
   "value"   varchar(45) DEFAULT NULL,
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "user_value_user_attr_id_idx" ON "user_value" USING btree ("user_attr_id");
CREATE INDEX "user_value_user_id_idx" ON "user_value" USING btree ("user_id");
ALTER TABLE "user_value" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "user_value" ADD FOREIGN KEY ("user_attr_id") REFERENCES "user_attr" ("id");

--
-- Table structure for table username_has_special_needs
--

DROP TABLE IF EXISTS "username_has_special_needs" CASCADE;
CREATE TABLE  "username_has_special_needs" (
   "username_id" int CHECK ("username_id" >= 0) NOT NULL,
   "special_needs_id" int CHECK ("special_needs_id" >= 0) NOT NULL,
   primary key ("username_id", "special_needs_id")
)  ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "username_has_special_needs_special_needs_id_idx" ON "username_has_special_needs" USING btree ("special_needs_id");
CREATE INDEX "username_has_special_needs_username_id_idx" ON "username_has_special_needs" USING btree ("username_id");
ALTER TABLE "username_has_special_needs" ADD FOREIGN KEY ("special_needs_id") REFERENCES "special_needs" ("id");
ALTER TABLE "username_has_special_needs" ADD FOREIGN KEY ("username_id") REFERENCES "user" ("id");

--
-- Table structure for table venue
--

DROP TABLE IF EXISTS "venue" CASCADE;
DROP SEQUENCE IF EXISTS "venue_id_seq" CASCADE ;

CREATE SEQUENCE "venue_id_seq"  START WITH 2102 ;

CREATE TABLE  "venue" (
   "id" integer DEFAULT nextval('"venue_id_seq"') NOT NULL,
   "tournament_id" int CHECK ("tournament_id" >= 0) NOT NULL,
   "name"   varchar(100) NOT NULL,
   "active"    smallint NOT NULL DEFAULT '1',
   "group"   varchar(100) DEFAULT NULL,
   primary key ("id")
)   ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE INDEX "venue_tournament_id_idx" ON "venue" USING btree ("tournament_id");
CREATE INDEX "venue_group_idx" ON "venue" USING btree ("group");
ALTER TABLE "venue" ADD FOREIGN KEY ("tournament_id") REFERENCES "tournament" ("id");

--
-- Table structure for table venue_provides_special_needs
--

DROP TABLE IF EXISTS "venue_provides_special_needs" CASCADE;
CREATE TABLE  "venue_provides_special_needs" (
   "venue_id" int CHECK ("venue_id" >= 0) NOT NULL,
   "special_needs_id" int CHECK ("special_needs_id" >= 0) NOT NULL,
   primary key ("venue_id", "special_needs_id")
)  ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
CREATE INDEX "venue_provides_special_needs_special_needs_id_idx" ON "venue_provides_special_needs" USING btree ("special_needs_id");
CREATE INDEX "venue_provides_special_needs_venue_id_idx" ON "venue_provides_special_needs" USING btree ("venue_id");
ALTER TABLE "venue_provides_special_needs" ADD FOREIGN KEY ("special_needs_id") REFERENCES "special_needs" ("id");
ALTER TABLE "venue_provides_special_needs" ADD FOREIGN KEY ("venue_id") REFERENCES "venue" ("id");
