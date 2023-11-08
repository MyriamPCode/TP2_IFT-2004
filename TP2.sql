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
    COURRIEL_ENT varchar2(40) not null,
    NO_ENTREPRISE_DIRIGEANTE number(6) null,
    constraint PK_ENTREPRISE primary key(NO_ENTREPRISE));
    
create table TP2_PROJET (
    CODE_PROJET char(4) not null,
    DATE_PRO DATE not null,
    NOM_PRO varchar2(40) null,
    NO_ENTREPRISE number(6) not null,
    constraint PK_PROJET primary key(CODE_PROJET),
    constraint FK_PROJET foreign key(NO_ENTREPRISE)
        references TP2_ENTREPRISE(NO_ENTREPRISE));
    
create table TP2_UTILISATEUR_PROJET (
    NO_UTILISATEUR number(6) not null,
    CODE_PROJET char(4) not null,
    constraint PK_UTILISATEUR_PROJET primary key(NO_UTILISATEUR,CODE_PROJET),
    constraint FK_UTILISATEUR_PROJET_UTILISATEUR foreign key(NO_UTILISATEUR)
        references TP2_UTILISATEUR(NO_UTILISATEUR),
    constraint FK_UTILISATEUR_PROJET_PROJET foreign key(CODE_PROJET)
        references TP2_PROJET(CODE_PROJET));
    
create table TP2_PROFIL_ACCESSIBILITE (
    NO_PROFIL number(6) not null,
    THEME_PROF varchar2(40) null,
    TEXTE_PROF varchar2(40) null,
    CODE_PROJET char(4) not null,
    constraint PK_PROFIL_ACCESSIBILITE primary key(NO_PROFIL),
    constraint FK_PA_CODE_PROJET foreign key(CODE_PROJET)
        references TP2_PROJET(CODE_PROJET));
    
create table TP2_PROFIL_ACCESSIBILITE_IMAGE (
    NO_IMAGE number(6) not null,
    NO_PROFIL number(6) not null,
    HAUTEUR_IMA number(6) not null,
    LARGEUR_IMA number(6) not null,
    constraint PK_PROFIL_ACCESSIBILITE_IMAGE primary key(NO_IMAGE),
    constraint FK_PROFIL_ACCESSIBILITE_IMAGE foreign key(NO_PROFIL)
        references TP2_PROFIL_ACCESSIBILITE(NO_PROFIL));
 
create table TP2_PROFIL_ACCESSIBILITE_IMAGE_COORDONNEE (
    NO_IMAGE number(6) not null, 
    NOM_I_COO varchar2(40) not null, 
    DESC_CO varchar2(40) not null, 
    POSITION_X_COO number(6) not null, 
    POSITION_Y_COO number(6) not null,
    constraint PK_PROFIL_ACCESS_IM_COORDONNEE primary key (NO_IMAGE, NOM_I_COO),
    constraint FK_PAIMCOO_NO_IMAGE foreign key (NO_IMAGE)
        references TP2_PROFIL_ACCESSIBILITE_IMAGE(NO_IMAGE));

create table TP2_PROFIL_ACCESSIBILITE_PLAN (
    NO_PLAN number(6) generated by default as identity
        start with 1 increment by 1, 
    NO_PROFIL number(6) not null, 
    HAUTEUR_PLA number(6) not null, 
    LARGEUR_PLA number(6) not null,
    constraint PK_PROFIL_ACCESS_PLAN primary key (NO_PLAN),
    constraint FK_PAPLAN_NO_PROFIL foreign key (NO_PROFIL)
        references TP2_PROFIL_ACCESSIBILITE(NO_PROFIL));

create table TP2_PROFIL_ACCESSIBILITE_PLAN_COORDONNEE (
    NO_P_COO number(6) generated by default as identity
        start with 1 increment by 1, 
    NO_PLAN number(6) not null, 
    LONGITUDE_COO number(4,2) not null, 
    LATITUDE_COO number(4,2) not null,
    constraint PK_PROFIL_ACCESS_PLAN_COORDONNEE primary key (NO_P_COO),
    constraint FK_PAPCOO_NO_PLAN foreign key (NO_PLAN)
        references TP2_PROFIL_ACCESSIBILITE_PLAN(NO_PLAN));

 create table TP2_SONDAGE (
    NO_SONDAGE number(8) not null, 
    DATE_CREATION_SON date not null, 
    DATE_DEBUT_SON date null, 
    DATE_FIN_SON date null, 
    TITRE_SON varchar2(100) not null, 
    CODE_PROJET char(4) not null,
    constraint PK_SONDAGE primary key (NO_SONDAGE),
    constraint FK_SON_CODE_PROJET foreign key (CODE_PROJET)
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
    ORDRE_QUESTION number(3) default 001 not null,
    CODE_TYPE_QUESTION char(4) not null,
    TEXTE_QUE varchar2(100) not null,
    NO_SONDAGE number(8) not null,
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
insert into TP2_UTILISATEUR (NO_UTILISATEUR, COURRIEL_UTI, MOT_DE_PASSE_UTI, PRENOM_UTI, NOM_UTI, TYPE_UTI) values (123456, 'trym.tealeaf@gmail.com', 'motDePasse', 'Trym', 'Tealeaf', 'employe');
insert into TP2_UTILISATEUR (NO_UTILISATEUR, COURRIEL_UTI, MOT_DE_PASSE_UTI, PRENOM_UTI, NOM_UTI, TYPE_UTI) values (234567, 'anahno.mistvale@gmail.com', 'motDePasse', 'Anahno', 'Mistvale', 'administrateur');

insert into TP2_ENTREPRISE (NO_ENTREPRISE, NOM_ENT, ADRESSE_ENT, CODE_POSTAL_ENT, VILLE_ENT, COURRIEL_ENT) values (000001, 'King''s council', '1 king avenue', 'R1K 1C1', 'Rexxentrum', 'king.council@gmail.com');
insert into TP2_ENTREPRISE (NO_ENTREPRISE, NOM_ENT, ADRESSE_ENT, CODE_POSTAL_ENT, VILLE_ENT, COURRIEL_ENT, NO_ENTREPRISE_DIRIGEANTE) values (000002, 'Cobalt Soul', '32 soul avenue', 'C0B 1S0', 'Zadash', 'cobalt.soul@gmail.com', 000001);

insert into TP2_PROJET (CODE_PROJET, DATE_PRO, NOM_PRO, NO_ENTREPRISE) values ('A1B2', to_date('23-11-07','RR-MM-DD'), 'Order 66', 1);
insert into TP2_PROJET (CODE_PROJET, DATE_PRO, NOM_PRO, NO_ENTREPRISE) values ('C3D4', to_date('23-11-07','RR-MM-DD'), 'Projet Nemesis', 2);

insert into TP2_UTILISATEUR_PROJET (NO_UTILISATEUR, CODE_PROJET) values (234567, 'A1B2');
insert into TP2_UTILISATEUR_PROJET (NO_UTILISATEUR, CODE_PROJET) values (234567, 'C3D4');

insert into TP2_PROFIL_ACCESSIBILITE (NO_PROFIL, THEME_PROF, CODE_PROJET) values (143602, 'Jedi', 'A1B2');
insert into TP2_PROFIL_ACCESSIBILITE (NO_PROFIL, THEME_PROF, CODE_PROJET) values (999666, 'Sith', 'A1B2');

insert into TP2_PROFIL_ACCESSIBILITE_IMAGE (NO_IMAGE, NO_PROFIL, HAUTEUR_IMA, LARGEUR_IMA) values (842635, 143602, 004587, 036259);
insert into TP2_PROFIL_ACCESSIBILITE_IMAGE (NO_IMAGE, NO_PROFIL, HAUTEUR_IMA, LARGEUR_IMA) values (489968, 999666, 004587, 036259);

-- ins�rer les insert des tables de St�phanie ici
insert into TP2_SONDAGE (NO_SONDAGE, DATE_CREATION_SON, DATE_DEBUT_SON, DATE_FIN_SON, TITRE_SON, CODE_PROJET) values (66666666, to_date('22-11-08','RR-MM-DD'), to_date('23-04-11','RR-MM-DD'), to_date('23-12-12','RR-MM-DD'), 'Order 66', 'A1B2');

insert into TP2_TYPE_QUESTION (CODE_TYPE_QUESTION, DESC_TYPE_QUE) values ('MC04', 'Multiples choices with 4 options');
insert into TP2_TYPE_QUESTION (CODE_TYPE_QUESTION, DESC_TYPE_QUE) values ('EQ22', 'Explanation questions');

insert into TP2_QUESTION (ID_QUESTION, ORDRE_QUESTION, CODE_TYPE_QUESTION, TEXTE_QUE, NO_SONDAGE) values (574689, 002, 'MC04', 'Which jedi survives order 66', 66666666);
insert into TP2_QUESTION (ID_QUESTION, ORDRE_QUESTION, CODE_TYPE_QUESTION, TEXTE_QUE, NO_SONDAGE) values (784132, 004, 'EQ22', 'What is Order 66', 66666666);

insert into TP2_CHOIX_REPONSE (ID_CHOIX_REPONSE, ORDRE_REPONSE, TEXTE_CHO, ID_QUESTION) values (589998, 015, 'Anakin Skywalker, Yoda, Master Windu, Ashoka Tano', 574689);
insert into TP2_CHOIX_REPONSE (ID_CHOIX_REPONSE, ORDRE_REPONSE, TEXTE_CHO, ID_QUESTION) values (589999, 016, 'Obi-wan Kenobi, Luke Skywalker, Darth Vader, Padme Amidala', 574689);

insert into TP2_REPONSE_UTILISATEUR (NO_UTILISATEUR, ID_CHOIX_REPONSE, TEXTE_REP) values (123456, 589998, 'Yoda');
insert into TP2_REPONSE_UTILISATEUR (NO_UTILISATEUR, ID_CHOIX_REPONSE, TEXTE_REP) values (123456, 589999, 'Obi-Wan Kenobi');

-- c
insert into TP2_PROFIL_ACCESSIBILITE_IMAGE (NO_PROFIL)
    select NO_PROFIL
        from TP2_PROFIL_ACCESSIBILITE_PLAN
        where NO_PROFIL = 12;

-- d
-- � revoir
delete from TP2_CHOIX_REPONSE 
    where ID_CHOIX_REPONSE = (select ID_CHOIX_REPONSE
                                from TP2_CHOIX_REPONSE
                                where ID_QUESTION = (select ID_QUESTION
                                                        from TP2_QUESTION
                                                        where NO_SONDAGE = (select NO_SONDAGE
                                                                                from TP2_SONDAGE
                                                                                where to_char(add_months(DATE_FIN_SON, 6), 'RR-MM-DD') < to_char(SYSDATE, 'RR-MM-DD'))));

delete from TP2_REPONSE_UTILISATEUR
    where ID_CHOIX_REPONSE is null;
                                
-- e
insert into TP2_QUESTION (ID_QUESTION, ORDRE_QUESTION, CODE_TYPE_QUESTION, TEXTE_QUE, NO_SONDAGE) values (478651, 003, 'EQ22', 'En route vers lan 3000', 66666666);

update TP2_TYPE_QUESTION 
    set DESC_TYPE_QUE = 'Vrai ou Faux' 
    where CODE_TYPE_QUESTION = (select CODE_TYPE_QUESTION 
                                    from TP2_QUESTION 
                                    where ORDRE_QUESTION = 3 and TEXTE_QUE = 'En route vers lan 3000' );

