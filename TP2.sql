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

-- 1
create table TP2_UTILISATEUR (
    NO_UTILISATEUR number(6) not null,
    COURRIEL_UTI varchar2(40) not null,
    MOT_DE_PASSE_UTI varchar2(40) not null,
    PRENOM_UTI varchar2(40) not null,
    NOM_UTI varchar2(40) not null,
    TYPE_UTI varchar2(14) not null,
    constraint PK_UTILISATEUR primary key(NO_UTILISATEUR));
    
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
    
    
--partie SK
create table TP2_PROFIL_ACCESSIBILITE_IMAGE_COORDONNEE (
    NO_IMAGE number(6) not null, 
    NOM_I_COO varchar2(40) not null, 
    DESC_CO varchar2(40) not null, 
    POSITION_X_COO number(6) not null, 
    POSITION_Y_COO number(6) not null,
    constraint TP2_PK_PROFIL_ACCESS_IM_COORDONNEE primary key (NO_IMAGE, NOM_I_COO),
    constraint TP2_FK_PAIMCOO_NO_IMAGE foreign key (NO_IMAGE)
        references TP2_PROFIL_ACCESSIBILITE_IMAGE(NO_IMAGE));

create table TP2_PROFIL_ACCESSIBILITE_PLAN (
    NO_PLAN number(6) generated by default as identity
        start with 1 increment by 1, 
    NO_PROFIL number(6) not null, 
    HAUTEUR_PLA number(6) not null, 
    LARGEUR_PLA number(6) not null,
    constraint TP2_PK_PROFIL_ACCESS_PLAN primary key (NO_PLAN),
    constraint TP2_FK_PAPLAN_NO_PROFIL foreign key (NO_PROFIL)
        references TP2_ACCESSIBILITE(NO_PROFIL));

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
        
drop sequence TP2_NO_UTILISATEUR_SEQ;
drop sequence TP2_NO_SONDAGE_SEQ;

create sequence TP2_NO_UTILISATEUR_SEQ
    start with 1000
    increment by 5;
    
create sequence TP2_NO_SONDAGE_SEQ
    start with 5000
    increment by 100;

