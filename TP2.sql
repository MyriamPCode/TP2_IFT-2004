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
    NO_ENTREPRISE number(6) not null,
    NOM_ENT varchar2(40) not null,
    NOM_FICHIER_LOGO_ENT varchar2(200) null,
    ADRESSE_ENT varchar2(40) not null,
    CODE_POSTAL_ENT char(7) not null,
    VILLE_ENT varchar2(40) not null,
    COURRIEL_ENT varchar(2) not null,
    NO_ENTREPRISE_DIRIGEANTE number(6) not null,
    constraint PK_ENTREPRISE primary key(NO_ENTREPRISE));
    
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
        references TP2_TYPE_QUESTION(CODE_TYPE_QUESTION)/*,
    constraint FK_NO_SONDAGE foreign key(NO_SONDAGE)
        references TP2_SONDAGE(NO_SONDAGE)*/);
        
create table TP2_CHOIX_REPONSE (
    ID_CHOIX_REPONSE number(6) not null,
    ORDRE_REPONSE number(3) not null,
    TEXTE_CHO varchar2(100) not null,
    ID_QUESTION number(6) not null,
    constraint PK_CHOIX_REPONSE primary key(ID_CHOIX_REPONSE),
    constraint FK_ID_QUESTION foreign key(ID_QUESTION)
        references TP2_QUESTION(ID_QUESTION));
        
create table TP2_REPONSE_UTILISATEUR (
    NO_UTILISATEUR number(6) not null,
    ID_CHOIX_REPONSE number(6) not null,
    TEXTE_REP varchar2(1000) not null,
    constraint PK_REPONSE_UTILISATEUR primary key(NO_UTILISATEUR, ID_CHOIX_REPONSE),
    constraint FK_NO_UTILISATEUR foreign key(NO_UTILISATEUR)
        references TP2_UTILISATEUR(NO_UTILISATEUR),
    constraint FK_ID_CHOIX_REPONSE foreign key(ID_CHOIX_REPONSE)
        references TP2_CHOIX_REPONSE(ID_CHOIX_REPONSE));