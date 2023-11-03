drop table TP2_UTILISATEUR cascade constraints;
drop table TP2_ENTREPRISE cascade constraints;
drop table TP2_PROJET cascade constraints;
drop table TP2_UTILISATEUR_PROJET cascade constraints;
drop table TP2_PROFIL_ACCESSIBILITE cascade constraints;
drop table TP2_PROFIL_ACCESSIBILITE_IMAGE cascade constraints;
drop table TP2_PROFIL_ACCESSIBILITE_IMAGE_COORDONNEE cascade constraints;
drop table TP2_PROFIL_ACCESSIBILITE_PLAN cascade constraints;
drop table TP2_PROFIL_ACCESSIBILITE_PLAN_COORDONNEE cascade constraints;
drop table TP2_SONDAGE cascade constraints;
drop table TP2_TYPE_QUESTION cascade constraints;
drop table TP2_QUESTION cascade constraints;
drop table TP2_CHOIX_REPONSE cascade constraints;
drop table TP2_REPONSE_UTILISATEUR cascade constraints;

drop sequence NO_UTILISATEUR_SEQ;
drop sequence NO_SONDAGE_SEQ;
drop sequence ID_QUESTION_SEQ;
drop sequence ID_CHOIX_REPONSE_SEQ;

-- 1
-- a

create table TP2_UTILISATEUR (
    NO_UTILISATEUR number(6) not null,
    COURRIEL_UTI varchar2(40) not null,
    MOT_DE_PASSE_UTI varchar2(40) not null,
    PRENOM_UTI varchar2(40) not null,
    NOM_UTI varchar2(40) not null,
    TYPE_UTI varchar2(14) not null,
    constraint PK_UTILISATEUR primary key(NO_UTILISATEUR));
    
create sequence NO_UTILISATEUR_SEQ
    start with 1000 increment by 5;

create table TP2_ENTREPRISE (
    NO_ENTREPRISE number(6) generated by default as identity
        start with 1 increment by 1,
    NOM_ENT varchar2(40) not null,
    NOM_FICHIER_LOGO_ENT varchar2(200) null,
    ADRESSE_ENT varchar2(40) not null,
    CODE_POSTAL_ENT char(7) not null,
    VILLE_ENT varchar2(40) not null,
    COURRIEL_ENT varchar(2) not null,
    NO_ENTREPRISE_DIRIGEANTE number(6) not null,
    constraint PK_ENTREPRISE primary key(NO_ENTREPRISE));
    
create table TP2_PROJET (
    CODE_PROJET char(4) not null,
    DATE_PRO DATE not null,
    NOM_PRO varchar2(40) null,
    NO_ENTREPRISE number(6) not null,
    constraint PK_PROJET primary key(CODE_PROJET),
    constraint FK_PROJET foreign key(NO_ENTREPRISE)references TP2_ENTREPRISE(NO_ENTREPRISE));
    
create table TP2_UTILISATEUR_PROJET (
    NO_UTILISATEUR number(6) not null,
    CODE_PROJET char(4) not null,
    constraint PK_UTILISATEUR_PROJET primary key(NO_UTILISATEUR,CODE_PROJET),
    constraint FK_UTILISATEUR_PROJET_UTILISATEUR foreign key(NO_UTILISATEUR)references TP2_UTILISATEUR(NO_UTILISATEUR),
    constraint FK_UTILISATEUR_PROJET_PROJET foreign key(CODE_PROJET)references TP2_PROJET(CODE_PROJET));
    
create table TP2_PROFIL_ACCESSIBILITE (
    NO_PROFIL number(6) not null,
    THEME_PROF varchar2(40) null,
    TEXTE_PROF varchar2(40) null,
    CODE_PROJET char(4) not null,
    constraint PK_PROFIL_ACCESSIBILITE primary key(NO_PROFIL),
    constraint FK_PROFIL_ACCESSIBILITE foreign key(CODE_PROJET)references TP2_PROJET(CODE_PROJET));
    
create table TP2_PROFIL_ACCESSIBILITE_IMAGE (
    NO_IMAGE number(6) not null,
    NO_PROFIL number(6) not null,
    HAUTEUR_IMA number(6,2) not null,
    LARGEUR_IMA number(6,2) not null,
    constraint PK_PROFIL_ACCESSIBILITE_IMAGE primary key(NO_IMAGE),
    constraint FK_PROFIL_ACCESSIBILITE_IMAGE foreign key(NO_PROFIL)references TP2_PROFIL_ACCESSIBILITE(NO_PROFIL));
 
create table TP2_PROFIL_ACCESSIBILITE_IMAGE_COORDONNEE (
    NO_IMAGE number(6) not null, 
    NOM_I_COO varchar2(40) not null, 
    DESC_CO varchar2(40) not null, 
    POSITION_X_COO number(6) not null, 
    POSITION_Y_COO number(6) not null,
    constraint TP2_PK_PROFIL_ACCESS_IM_COORDONNEE primary key (NO_IMAGE, NOM_I_COO)/*,
    constraint TP2_FK_PAIMCOO_NO_IMAGE foreign key (NO_IMAGE)
        references TP2_PROFIL_ACCESSIBILITE_IMAGE(NO_IMAGE)*/);

create table TP2_PROFIL_ACCESSIBILITE_PLAN (
    NO_PLAN number(6) generated by default as identity
        start with 1 increment by 1, 
    NO_PROFIL number(6) not null, 
    HAUTEUR_PLA number(6) not null, 
    LARGEUR_PLA number(6) not null,
    constraint TP2_PK_PROFIL_ACCESS_PLAN primary key (NO_PLAN)/*,
    constraint TP2_FK_PAPLAN_NO_PROFIL foreign key (NO_PROFIL)
        references TP2_ACCESSIBILITE(NO_PROFIL)*/);

create table TP2_PROFIL_ACCESSIBILITE_PLAN_COORDONNEE (
    NO_P_COO number(6) generated by default as identity
        start with 1 increment by 1, 
    NO_PLAN number(6) not null, 
    LONGITUDE_COO number(4,2) not null, 
    LATITUDE_COO number(4,2) not null,
    constraint TP2_PK_PROFIL_ACCESS_PLAN_COORDONNEE primary key (NO_P_COO),
    constraint TP2_FK_PAPCOO_NO_PLAN foreign key (NO_PLAN)
        references TP2_PROFIL_ACCESSIBILITE_PLAN(NO_PLAN));

 create table TP2_SONDAGE (
    NO_SONDAGE number(8) not null, 
    DATE_CREATION_SON date not null, 
    DATE_DEBUT_SON date null, 
    DATE_FIN_SON date null, 
    TITRE_SON varchar2(100) not null, 
    CODE_PROJET char(4) not null,
    constraint TP2_PK_SONDAGE primary key (NO_SONDAGE),
    constraint TP2_FK_SON_CODE_PROJET foreign key (CODE_PROJET)
        references TP2_PROJET(CODE_PROJET),
    constraint TP2_AK_SON_TITRE_SON unique (TITRE_SON));

create sequence NO_SONDAGE_SEQ
    start with 5000
    increment by 100;

create table TP2_TYPE_QUESTION (
    CODE_TYPE_QUESTION char(4) not null,
    DESC_TYPE_QUE varchar2(40) not null,
    constraint PK_TYPE_QUESTION primary key(CODE_TYPE_QUESTION));
    
create table TP2_QUESTION (
    ID_QUESTION number(6) not null,
    ORDRE_QUESTION number(3) default 1 not null,
    CODE_TYPE_QUESTION char(4) not null,
    TEXTE_QUE varchar2(100) not null,
    NO_SONDAGE number(6) not null,
    constraint PK_QUESTION primary key(ID_QUESTION),
    constraint FK_CODE_TYPE_QUESTION foreign key(CODE_TYPE_QUESTION)
        references TP2_TYPE_QUESTION(CODE_TYPE_QUESTION),
    constraint FK_NO_SONDAGE foreign key(NO_SONDAGE)
        references TP2_SONDAGE(NO_SONDAGE));
    
create sequence ID_QUESTION_SEQ
    start with 1 increment by 1;
    
create table TP2_CHOIX_REPONSE (
    ID_CHOIX_REPONSE number(6) not null,
    ORDRE_REPONSE number(3) not null,
    TEXTE_CHO varchar2(100) not null,
    ID_QUESTION number(6) not null,
    constraint PK_CHOIX_REPONSE primary key(ID_CHOIX_REPONSE),
    constraint FK_ID_QUESTION foreign key(ID_QUESTION)
        references TP2_QUESTION(ID_QUESTION));
        
create sequence ID_CHOIX_REPONSE_SEQ
    start with 10000 increment by 1;
        
create table TP2_REPONSE_UTILISATEUR (
    NO_UTILISATEUR number(6) not null,
    ID_CHOIX_REPONSE number(6) not null,
    TEXTE_REP varchar2(1000) not null,
    constraint PK_REPONSE_UTILISATEUR primary key(NO_UTILISATEUR, ID_CHOIX_REPONSE),
    constraint FK_NO_UTILISATEUR foreign key(NO_UTILISATEUR)
        references TP2_UTILISATEUR(NO_UTILISATEUR),
    constraint FK_ID_CHOIX_REPONSE foreign key(ID_CHOIX_REPONSE)
        references TP2_CHOIX_REPONSE(ID_CHOIX_REPONSE));
        
-- b
-- les mots de passe ne sont pas final
insert into TP2_UTILISATEUR (NO_UTILISATEUR, COURRIEL_UTI, MOT_DE_PASSE_UTI, PRENOM_UTI, NOM_UTI, TYPE_UTI) values (123456, 'trym.tealeaf@gmail.com', 'motDePasse', 'Trym', 'Tealeaf', 'employ�');
insert into TP2_UTILISATEUR (NO_UTILISATEUR, COURRIEL_UTI, MOT_DE_PASSE_UTI, PRENOM_UTI, NOM_UTI, TYPE_UTI) values (234567, 'anahno.mistvale@gmail.com', 'motDePasse', 'Anahno', 'Mistvale', 'administrateur');

insert into TP2_ENTREPRISE (NO_ENTREPRISE, NOM_ENT, NOM_FICHIER_LOGO_ENT, ADRESSE_ENT, CODE_POSTAL_ENT, VILLE_ENT, COURRIEL_ENT, NO_ENTREPRISE_DIREIGEANTE) values (2, 'Cobalt Soul', '32 soul avenue', 'C0B 1S0', 'Zadash', 'cobalt.soul@gmail.com', 1);
insert into TP2_ENTREPRISE (NO_ENTREPRISE, NOM_ENT, NOM_FICHIER_LOGO_ENT, ADRESSE_ENT, CODE_POSTAL_ENT, VILLE_ENT, COURRIEL_ENT) values (1, 'King''s council', '1 king avenue', 'R1K 1C1', 'Rexxentrum', 'king.council@gmail.com');

