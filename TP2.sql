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
drop sequence TP2_NO_SONDAGE_SEQ;
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
    NO_PROFIL number(6) generated by default as identity
        start with 666 increment by 1,
    THEME_PROF varchar2(40) null,
    TEXTE_PROF varchar2(40) null,
    CODE_PROJET char(4) not null,
    constraint PK_PROFIL_ACCESSIBILITE primary key(NO_PROFIL),
    constraint FK_PA_CODE_PROJET foreign key(CODE_PROJET)
        references TP2_PROJET(CODE_PROJET));
    
create table TP2_PROFIL_ACCESSIBILITE_IMAGE (
    NO_IMAGE number(6) generated by default as identity
        start with 100 increment by 2,
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
    LONGITUDE_COO number(9,6) not null, 
    LATITUDE_COO number(9,6) not null,
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
    constraint PK_SONDAGE primary key (NO_SONDAGE),
    constraint FK_SON_CODE_PROJET foreign key (CODE_PROJET)
        references TP2_PROJET(CODE_PROJET),
    constraint TP2_AK_SON_TITRE_SON unique (TITRE_SON));

create sequence TP2_NO_SONDAGE_SEQ
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
        
create or replace view TP2_ADMINISTRATEUR (COURRIEL_ADM, MOT_DE_PASSE_ADM, NOM_ADM, PRENOM_ADM) as
    select COURRIEL_UTI, MOT_DE_PASSE_UTI, NOM_UTI, PRENOM_UTI 
        from TP2_UTILISATEUR
        where TYPE_UTI = 'Administrateur';
        
-- 2c
set serveroutput on;
create or replace function FCT_GENERER_MOT_DE_PASSE(NB_DIGITS in number) return varchar2 
is
    V_PASSWORD varchar2(16);
    V_LENGTH number(2) := NB_DIGITS;
    E_DIGITS_INVALID exception;
begin
    if (NB_DIGITS < 12) then
        V_LENGTH := 12;
    elsif (NB_DIGITS > 16) then
        raise E_DIGITS_INVALID;
    end if;
    
    V_PASSWORD := dbms_random.string('p', V_LENGTH);   
    return V_PASSWORD;
    
    exception
    when E_DIGITS_INVALID then
        dbms_output.put_line('Exceed limits of caracter for password');
end FCT_GENERER_MOT_DE_PASSE;
/

-- b
insert into TP2_UTILISATEUR (NO_UTILISATEUR, COURRIEL_UTI, MOT_DE_PASSE_UTI, PRENOM_UTI, NOM_UTI, TYPE_UTI) values (NO_UTILISATEUR_SEQ.nextval, 'trym.tealeaf@gmail.com', FCT_GENERER_MOT_DE_PASSE(10), 'Trym', 'Tealeaf', 'Employ�');
insert into TP2_UTILISATEUR (NO_UTILISATEUR, COURRIEL_UTI, MOT_DE_PASSE_UTI, PRENOM_UTI, NOM_UTI, TYPE_UTI) values (NO_UTILISATEUR_SEQ.nextval, 'anahno.mistvale@gmail.com', FCT_GENERER_MOT_DE_PASSE(16), 'Anahno', 'Mistvale', 'Administrateur');

insert into TP2_ENTREPRISE (NOM_ENT, NOM_FICHIER_LOGO_ENT, ADRESSE_ENT, CODE_POSTAL_ENT, VILLE_ENT, COURRIEL_ENT) values ('King''s council', 'C:\User\Trym\KingsConcil\logo.jpg', '1 king avenue', 'R1K 1C1', 'Rexxentrum', 'king.council@gmail.com');
insert into TP2_ENTREPRISE (NOM_ENT, NOM_FICHIER_LOGO_ENT, ADRESSE_ENT, CODE_POSTAL_ENT, VILLE_ENT, COURRIEL_ENT) values ('Cobalt Soul', 'C:\User\Anahno\CobaltSoul\logo.jpg', '32 soul avenue', 'C0B 1S0', 'Zadash', 'cobalt.soul@gmail.com');

insert into TP2_PROJET (CODE_PROJET, DATE_PRO, NOM_PRO, NO_ENTREPRISE) values ('A1B2', to_date('23-11-07','RR-MM-DD'), 'Order 66', 1);
insert into TP2_PROJET (CODE_PROJET, DATE_PRO, NOM_PRO, NO_ENTREPRISE) values ('C3D4', to_date('23-11-07','RR-MM-DD'), 'Projet Nemesis', 2);

insert into TP2_UTILISATEUR_PROJET (NO_UTILISATEUR, CODE_PROJET) values (1005, 'A1B2');
insert into TP2_UTILISATEUR_PROJET (NO_UTILISATEUR, CODE_PROJET) values (1005, 'C3D4');

insert into TP2_PROFIL_ACCESSIBILITE (THEME_PROF, CODE_PROJET) values ('Jedi', 'A1B2');
insert into TP2_PROFIL_ACCESSIBILITE (THEME_PROF, CODE_PROJET) values ('Sith', 'A1B2');

insert into TP2_PROFIL_ACCESSIBILITE_IMAGE (NO_PROFIL, HAUTEUR_IMA, LARGEUR_IMA) values (666, 004587, 036259);
insert into TP2_PROFIL_ACCESSIBILITE_IMAGE (NO_PROFIL, HAUTEUR_IMA, LARGEUR_IMA) values (667, 004587, 036259);

-- ins�rer les insert des tables de St�phanie ici
insert into TP2_PROFIL_ACCESSIBILITE_IMAGE_COORDONNEE (NO_IMAGE, NOM_I_COO, DESC_CO, POSITION_X_COO, POSITION_Y_COO) values (100, 'Porte cach�e' , 'Vue porte cach�e ouest corridor jardin' , 8, 25);
insert into TP2_PROFIL_ACCESSIBILITE_IMAGE_COORDONNEE (NO_IMAGE, NOM_I_COO, DESC_CO, POSITION_X_COO, POSITION_Y_COO) values (102, 'La voute de Chtulhu' , 'Vue entr�e nord cit� R''lyeh avec voute' , 4, 6);

insert into TP2_PROFIL_ACCESSIBILITE_PLAN (NO_PROFIL, HAUTEUR_PLA, LARGEUR_PLA) values (666, 50, 100);
insert into TP2_PROFIL_ACCESSIBILITE_PLAN (NO_PROFIL, HAUTEUR_PLA, LARGEUR_PLA) values (667, 1080, 1920);

insert into TP2_PROFIL_ACCESSIBILITE_PLAN_COORDONNEE (NO_PLAN, LONGITUDE_COO, LATITUDE_COO) values (1, 48.804568, 2.121241);
insert into TP2_PROFIL_ACCESSIBILITE_PLAN_COORDONNEE (NO_PLAN, LONGITUDE_COO, LATITUDE_COO) values (2, -47.15, -126.716666);

insert into TP2_SONDAGE (NO_SONDAGE, DATE_CREATION_SON, DATE_DEBUT_SON, DATE_FIN_SON, TITRE_SON, CODE_PROJET) values (TP2_NO_SONDAGE_SEQ.nextval, to_date('23-09-08','RR-MM-DD'), to_date('23-11-11','RR-MM-DD'), to_date('23-12-12','RR-MM-DD'), 'Order 66', 'A1B2');
insert into TP2_SONDAGE (NO_SONDAGE, DATE_CREATION_SON, DATE_DEBUT_SON, DATE_FIN_SON, TITRE_SON, CODE_PROJET) values (TP2_NO_SONDAGE_SEQ.nextval, to_date('23-09-08','RR-MM-DD'), to_date('23-11-11','RR-MM-DD'), to_date('23-12-12','RR-MM-DD'), 'Chewbacca', 'A1B2');
insert into TP2_SONDAGE (NO_SONDAGE, DATE_CREATION_SON, DATE_DEBUT_SON, DATE_FIN_SON, TITRE_SON, CODE_PROJET) values (TP2_NO_SONDAGE_SEQ.nextval, to_date('2000-01-01', 'YYYY-MM-DD'), to_date('2000-04-01', 'YYYY-MM-DD'), to_date('2000-04-30', 'YYYY-MM-DD'), '�valuez votre niveau de satisfaction de l''acc�s � la salle du tr�ne.', 'A1B2');
insert into TP2_SONDAGE (NO_SONDAGE, DATE_CREATION_SON, DATE_DEBUT_SON, DATE_FIN_SON, TITRE_SON, CODE_PROJET) values (TP2_NO_SONDAGE_SEQ.nextval, to_date('1926-05-11', 'YYYY-MM-DD'), to_date('1928-02-26', 'YYYY-MM-DD'), to_date('1929-02-26', 'YYYY-MM-DD'), 'Quel(s) mode(s) de transport pr�voyez-vous utiliser pour vous rendre au lieu de dormance de Chtulu?', 'C3D4');

insert into TP2_TYPE_QUESTION (CODE_TYPE_QUESTION, DESC_TYPE_QUE) values ('MC04', 'Multiples choices with 4 options');
insert into TP2_TYPE_QUESTION (CODE_TYPE_QUESTION, DESC_TYPE_QUE) values ('EQ22', 'Explanation questions');
insert into TP2_TYPE_QUESTION (CODE_TYPE_QUESTION, DESC_TYPE_QUE) values ('RB11', '� d�veloppement');

insert into TP2_QUESTION (ID_QUESTION, ORDRE_QUESTION, CODE_TYPE_QUESTION, TEXTE_QUE, NO_SONDAGE) values (ID_QUESTION_SEQ.nextval, 002, 'MC04', 'Which jedi survives order 66', 5200);
insert into TP2_QUESTION (ID_QUESTION, ORDRE_QUESTION, CODE_TYPE_QUESTION, TEXTE_QUE, NO_SONDAGE) values (ID_QUESTION_SEQ.nextval, 004, 'EQ22', 'What is Order 66', 5200);
insert into TP2_QUESTION (ID_QUESTION, ORDRE_QUESTION, CODE_TYPE_QUESTION, TEXTE_QUE, NO_SONDAGE) values (ID_QUESTION_SEQ.nextval, 006, 'RB11', 'How start Order 66', 5200);

insert into TP2_CHOIX_REPONSE (ID_CHOIX_REPONSE, ORDRE_REPONSE, TEXTE_CHO, ID_QUESTION) values (ID_CHOIX_REPONSE_SEQ.nextval, 015, 'Anakin Skywalker, Yoda, Master Windu, Ashoka Tano', 1);
insert into TP2_CHOIX_REPONSE (ID_CHOIX_REPONSE, ORDRE_REPONSE, TEXTE_CHO, ID_QUESTION) values (ID_CHOIX_REPONSE_SEQ.nextval, 016, 'Obi-wan Kenobi, Luke Skywalker, Darth Vader, Padme Amidala', 2);
insert into TP2_CHOIX_REPONSE (ID_CHOIX_REPONSE, ORDRE_REPONSE, TEXTE_CHO, ID_QUESTION) values (ID_CHOIX_REPONSE_SEQ.nextval, 017, 'Obi-wan Kenobi, Luke Skywalker, Darth Vader, Padme Amidala', 3);

insert into TP2_REPONSE_UTILISATEUR (NO_UTILISATEUR, ID_CHOIX_REPONSE, TEXTE_REP) values (1000, 10000, 'Yoda');
insert into TP2_REPONSE_UTILISATEUR (NO_UTILISATEUR, ID_CHOIX_REPONSE, TEXTE_REP) values (1000, 10001, 'Obi-Wan Kenobi');
insert into TP2_REPONSE_UTILISATEUR (NO_UTILISATEUR, ID_CHOIX_REPONSE, TEXTE_REP) values (1000, 10002, 'Darth Vader');

-- c
insert into TP2_PROFIL_ACCESSIBILITE_IMAGE (NO_PROFIL)
    select NO_PROFIL
        from TP2_PROFIL_ACCESSIBILITE_PLAN
        where NO_PROFIL = 12;

-- d
delete from TP2_REPONSE_UTILISATEUR 
    where NO_UTILISATEUR in (select U.NO_UTILISATEUR
                                from TP2_UTILISATEUR U
                                join TP2_UTILISATEUR_PROJET P ON U.NO_UTILISATEUR = P.NO_UTILISATEUR
                                join TP2_SONDAGE S ON P.CODE_PROJET = S.CODE_PROJET
                                where sysdate - interval '6' month > S.DATE_FIN_SON);

delete from TP2_REPONSE_UTILISATEUR
    where ID_CHOIX_REPONSE is null;
                                
-- e
insert into TP2_QUESTION (ID_QUESTION, ORDRE_QUESTION, CODE_TYPE_QUESTION, TEXTE_QUE, NO_SONDAGE) values (ID_QUESTION_SEQ.nextval, 003, 'EQ22', 'En route vers lan 3000', 5000);

update TP2_TYPE_QUESTION 
    set DESC_TYPE_QUE = 'Vrai ou Faux' 
    where CODE_TYPE_QUESTION = (select CODE_TYPE_QUESTION 
                                    from TP2_QUESTION 
                                    where ORDRE_QUESTION = 3 and TEXTE_QUE = 'En route vers lan 3000' );

-- f
insert into TP2_ENTREPRISE (NOM_ENT, ADRESSE_ENT, CODE_POSTAL_ENT, VILLE_ENT, COURRIEL_ENT, NO_ENTREPRISE_DIRIGEANTE) values ('centre de dragon', '123 Dragon', 'D6A 6O3', 'Zadash', '123dragon@gmail.com', 000001);

select NOM_ENT, CODE_POSTAL_ENT
    from TP2_ENTREPRISE
    where NOM_ENT like'%centre%';
    
-- g
select Q.ORDRE_QUESTION, Q.TEXTE_QUE
    from TP2_QUESTION Q
    inner join TP2_SONDAGE S on Q.NO_SONDAGE = S.NO_SONDAGE
    where extract(year from S.DATE_CREATION_SON) = 2023
    and extract(month from S.DATE_CREATION_SON) = 9
    order by S.NO_SONDAGE, Q.ORDRE_QUESTION;

    
-- h
select TEXTE_REP 
    from TP2_REPONSE_UTILISATEUR
    where ID_CHOIX_REPONSE in (select ID_CHOIX_REPONSE 
                                   from TP2_CHOIX_REPONSE
                                   where ID_QUESTION in (select ID_QUESTION 
                                                            from TP2_QUESTION
                                                            where CODE_TYPE_QUESTION in (select CODE_TYPE_QUESTION 
                                                                                         from TP2_TYPE_QUESTION 
                                                                                         where DESC_TYPE_QUE in ('� d�veloppement'))));

select R.TEXTE_REP 
    from TP2_REPONSE_UTILISATEUR R, TP2_CHOIX_REPONSE C
    where R.ID_CHOIX_REPONSE = C.ID_CHOIX_REPONSE 
    and R.ID_CHOIX_REPONSE = (select C.ID_CHOIX_REPONSE  
                                  from TP2_CHOIX_REPONSE C, TP2_QUESTION Q
                                  where C.ID_QUESTION = Q.ID_QUESTION 
                                  and C.ID_QUESTION = (select Q.ID_QUESTION 
                                                          from TP2_QUESTION Q, TP2_TYPE_QUESTION T
                                                          where Q.CODE_TYPE_QUESTION = T.CODE_TYPE_QUESTION 
                                                          and Q.CODE_TYPE_QUESTION = (select CODE_TYPE_QUESTION 
                                                                                      from TP2_TYPE_QUESTION 
                                                                                      where DESC_TYPE_QUE = '� d�veloppement')));
                                                                                      
select TEXTE_REP 
    from TP2_REPONSE_UTILISATEUR R
    where exists ( select ID_CHOIX_REPONSE
                    from TP2_CHOIX_REPONSE C
                    where R.ID_CHOIX_REPONSE = C.ID_CHOIX_REPONSE 
                    and exists (select ID_QUESTION  
                                    from TP2_QUESTION Q
                                    where C.ID_QUESTION = Q.ID_QUESTION 
                                    and exists (select CODE_TYPE_QUESTION
                                                    from TP2_TYPE_QUESTION T
                                                    where Q.CODE_TYPE_QUESTION = T.CODE_TYPE_QUESTION 
                                                    and  DESC_TYPE_QUE = '� d�veloppement')));
 
 --i                                                   
select U.PRENOM_UTI || ' ' || U.NOM_UTI as NOM_COMPLET, S.TITRE_SON as NOM_SONDAGE, count(R.NO_UTILISATEUR) as NB_REPONSE
    from TP2_UTILISATEUR U
    join TP2_REPONSE_UTILISATEUR R on U.NO_UTILISATEUR = R.NO_UTILISATEUR
    join TP2_SONDAGE S on R.ID_CHOIX_REPONSE = S.NO_SONDAGE
    group by U.PRENOM_UTI, U.NOM_UTI, S.TITRE_SON
    order by NB_REPONSE desc; 

--j
select NOM_ENT
    from TP2_ENTREPRISE
    where NO_ENTREPRISE not in (select NO_ENTREPRISE
                                    from TP2_PROJET
                                    group by NO_ENTREPRISE
                                    having count(*) = 2);
                                    
select NOM_ENT
    from TP2_ENTREPRISE
    minus
    select E.NOM_ENT 
        from TP2_ENTREPRISE E 
        join TP2_PROJET P on E.NO_ENTREPRISE = P.NO_ENTREPRISE
        group by E.NO_ENTREPRISE, E.NOM_ENT
        having count(*) = 2;
        
select NOM_ENT
    from TP2_ENTREPRISE E
    where not exists (select 1
                          from TP2_PROJET P
                          where E.NO_ENTREPRISE = P.NO_ENTREPRISE
                          group by P.NO_ENTREPRISE
                          having count(*) = 2);
                                                  
--k
select NOM_ENT
    from TP2_ENTREPRISE
    where NO_ENTREPRISE not in (select NO_ENTREPRISE
                                   from TP2_PROJET
                                   where DATE_PRO >= sysdate - interval '12' month)
order by NOM_ENT asc;
