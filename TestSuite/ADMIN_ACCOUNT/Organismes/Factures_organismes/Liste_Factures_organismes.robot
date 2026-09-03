*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Factures organismes"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste Factures organismes


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Factures organismes fonctionne correctement
    Accéder à la page    payers/invoices
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent
Vérifier La Visibilité Et La Fonctionnalité De L'Icône Imprimer
    [Documentation]    Vérifie que l'icône Imprimer est visible et fonctionnelle
    Vérifier Icône Imprimer          payers/invoices
Vérifier Le Bouton "créer Factures organismes"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page Factures organismes
   Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    organisme     payers/invoices

Rechercher Par Numéro De Transaction
    [Documentation]    Vérifie que la recherche par numéro de transaction fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Factures organismes
    Vérifier La Recherche     th    FAC-7992      ${CHAMP_NUM_TRANSACTION_FACTURE_ORGANISME}

Rechercher Par Bénéficiaire
    [Documentation]    Vérifie que la recherche par bénéficiaire fonctionne correctement
   Vérifier La Visibilité Des Champs De Recherche Factures organismes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Factures organismes
    Vérifier La Recherche     td[1]    asAs   ${CHAMP_BENEFICIAIRE_FACTURE_ORGANISME}

Rechercher Par Date De Facture
    [Documentation]    Vérifie que la recherche par date de facture fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Factures organismes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Factures organismes
    Vérifier La Recherche     td[2]    2026-04-15    ${CHAMP_DATE_FACTURE_ORGANISME}

Rechercher Par Numéro De Dossier
    [Documentation]    Vérifie la recherche d'une Facture organisme par son numéro de dossier.
    Vérifier La Visibilité Des Champs De Recherche Factures organismes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Factures organismes
    Vérifier La Recherche     td[3]    tfy    ${CHAMP_NUM_DOSSIER_FACTURE_ORGANISME}

Rechercher Par Numéro De Prise En Charge
    [Documentation]    Vérifie la recherche d'une Facture organisme par son numéro de prise en charge.
    Vérifier La Visibilité Des Champs De Recherche Factures organismes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Factures organismes
    Vérifier La Recherche     td[4]    kjhjk    ${CHAMP_NUM_PRISE_EN_CHARGE_FACTURE_ORGANISME}

Vérifier La Recherche Par Total Client
    [Documentation]    Vérifie la recherche d'une Facture organisme par son total client.
    Vérifier La Visibilité Des Champs De Recherche Factures organismes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Factures organismes
    Vérifier La Recherche     td[5]    15    ${CHAMP_TOTAL_CLIENT_FACTURE_ORGANISME}

Vérifier La Recherche Par Total Organisme
    [Documentation]    Vérifie la recherche d'une Facture organisme par son total organisme.
    Vérifier La Visibilité Des Champs De Recherche Factures organismes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Factures organismes
    Vérifier La Recherche     td[6]    5    ${CHAMP_TOTAL_ORGANISME_FACTURE_ORGANISME}

Rechercher Par Statut Organisme
    [Documentation]    Vérifie que la recherche par statut organisme fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Factures organismes
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_ORGANISME_FACTURE_ORGANISME}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[7]  ${CHAMP_STATUT_ORGANISME_FACTURE_ORGANISME}

Rechercher Par Statut
    [Documentation]    Vérifie que la recherche par statut fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Factures organismes
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_FACTURE_ORGANISME}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[8]  ${CHAMP_STATUT_FACTURE_ORGANISME}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche Factures organismes
    Wait Until Element Is Visible  ${CHAMP_NUM_TRANSACTION_FACTURE_ORGANISME}
    Wait Until Element Is Visible  ${CHAMP_BENEFICIAIRE_FACTURE_ORGANISME}
     Wait Until Element Is Visible  ${CHAMP_DATE_FACTURE_ORGANISME}
     Wait Until Element Is Visible  ${CHAMP_NUM_DOSSIER_FACTURE_ORGANISME}
    Wait Until Element Is Visible    ${CHAMP_NUM_PRISE_EN_CHARGE_FACTURE_ORGANISME}
     Wait Until Element Is Visible  ${CHAMP_TOTAL_CLIENT_FACTURE_ORGANISME}
    Wait Until Element Is Visible    ${CHAMP_TOTAL_ORGANISME_FACTURE_ORGANISME}
    Wait Until Element Is Visible    ${CHAMP_STATUT_ORGANISME_FACTURE_ORGANISME}
    Wait Until Element Is Visible    ${CHAMP_STATUT_FACTURE_ORGANISME}

Vérifier Que Le Champ De Recherche Est Vide Factures organismes
    ${num_transaction} =    Get Value    ${CHAMP_NUM_TRANSACTION_FACTURE_ORGANISME}
    ${beneficiaire} =    Get Value    ${CHAMP_BENEFICIAIRE_FACTURE_ORGANISME}
    ${date} =    Get Value    ${CHAMP_DATE_FACTURE_ORGANISME}
    ${num_dossier} =    Get Value    ${CHAMP_NUM_DOSSIER_FACTURE_ORGANISME}
    ${num_prise_en_charge} =    Get Value    ${CHAMP_NUM_PRISE_EN_CHARGE_FACTURE_ORGANISME}
    ${total_client} =    Get Value    ${CHAMP_TOTAL_CLIENT_FACTURE_ORGANISME}
    ${total_organisme} =    Get Value    ${CHAMP_TOTAL_ORGANISME_FACTURE_ORGANISME}

     Should Be Empty    ${num_transaction}
     Should Be Empty    ${beneficiaire}
     Should Be Empty    ${date}
     Should Be Empty    ${num_dossier}
     Should Be Empty    ${num_prise_en_charge}
     Should Be Empty    ${total_client}
     Should Be Empty    ${total_organisme}
