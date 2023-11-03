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

