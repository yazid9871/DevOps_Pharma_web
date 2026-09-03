*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Avoirs fournisseurs reçus"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Avoirs fournisseurs reçus


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Avoirs fournisseurs reçus fonctionne correctement
    Accéder à la page    purchasesreturns
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent
Vérifier La Visibilité Et La Fonctionnalité De L'Icône Imprimer
    [Documentation]    Vérifie que l'icône Imprimer est visible et fonctionnelle
    Vérifier Icône Imprimer          purchasesreturns
Vérifier Le Bouton "créer Avoirs fournisseurs reçus"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page Avoirs fournisseurs reçus
   Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    Sélectionner une option     purchasesreturns
Rechercher Par Numéro De Transaction
    [Documentation]    Vérifie que la recherche par numéro de transaction fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Avoirs fournisseurs reçus
    Vérifier La Recherche     th    RA-388   ${CHAMP_NUM_TRANSACTION_AVOIR_RECU}

Rechercher Par Référence De L'avoir
    [Documentation]    Vérifie que la recherche par référence de l'avoir fonctionne correctement
   Vérifier La Visibilité Des Champs De Recherche Avoirs fournisseurs reçus
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Avoirs fournisseurs reçus
    Vérifier La Recherche     td[1]    mery test   ${CHAMP_REFERENCE_AVOIR_RECU}

Rechercher Par Fournisseur
    [Documentation]    Vérifie que la recherche par fournisseur fonctionne correctement
   Vérifier La Visibilité Des Champs De Recherche Avoirs fournisseurs reçus
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Avoirs fournisseurs reçus
    Vérifier La Recherche     td[2]     Cooper GPF   ${CHAMP_FOURNISSEUR_AVOIR_RECU}


Rechercher Par Date
    [Documentation]    Vérifie que la recherche par date fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Avoirs fournisseurs reçus
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Avoirs fournisseurs reçus
    Vérifier La Recherche     td[3]    2026-04-30    ${CHAMP_DATE_AVOIR_RECU}

Vérifier La Recherche Par Total Accepté
    [Documentation]    Vérifie la recherche d'un Avoir fournisseur reçu par son total accepté.
     Vérifier La Visibilité Des Champs De Recherche Avoirs fournisseurs reçus
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Avoirs fournisseurs reçus
   Vérifier La Recherche     td[4]    50    ${CHAMP_TOTAL_ACCEPTE_AVOIR_RECU}

Vérifier La Recherche Par Total Refusé
    [Documentation]    Vérifie la recherche d'un Avoir fournisseur reçu par son total refusé.
     Vérifier La Visibilité Des Champs De Recherche Avoirs fournisseurs reçus
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Avoirs fournisseurs reçus
   Vérifier La Recherche     td[5]    0    ${CHAMP_TOTAL_REFUSE_AVOIR_RECU}

Vérifier La Recherche Par Montant Reçu
    [Documentation]    Vérifie la recherche d'un Avoir fournisseur reçu par son montant reçu.
     Vérifier La Visibilité Des Champs De Recherche Avoirs fournisseurs reçus
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Avoirs fournisseurs reçus
   Vérifier La Recherche     td[6]    50    ${CHAMP_MONTANT_RECU_AVOIR_RECU}

Rechercher Par Mode De Remboursement
    [Documentation]    Vérifie que la recherche par mode de remboursement fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Avoirs fournisseurs reçus
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_MODE_REMBOURSEMENT_AVOIR_RECU}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[7]  ${CHAMP_MODE_REMBOURSEMENT_AVOIR_RECU}

Rechercher Par Statut
    [Documentation]    Vérifie que la recherche par statut fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Avoirs fournisseurs reçus
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_AVOIR_RECU}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[8]  ${CHAMP_STATUT_AVOIR_RECU}
*** Keywords ***

Vérifier La Visibilité Des Champs De Recherche Avoirs fournisseurs reçus
    Wait Until Element Is Visible  ${CHAMP_NUM_TRANSACTION_AVOIR_RECU}
    Wait Until Element Is Visible  ${CHAMP_REFERENCE_AVOIR_RECU}
    Wait Until Element Is Visible  ${CHAMP_FOURNISSEUR_AVOIR_RECU}
     Wait Until Element Is Visible  ${CHAMP_DATE_AVOIR_RECU}
    Wait Until Element Is Visible    ${CHAMP_TOTAL_ACCEPTE_AVOIR_RECU}
     Wait Until Element Is Visible  ${CHAMP_TOTAL_REFUSE_AVOIR_RECU}
    Wait Until Element Is Visible    ${CHAMP_MONTANT_RECU_AVOIR_RECU}
    Wait Until Element Is Visible    ${CHAMP_MODE_REMBOURSEMENT_AVOIR_RECU}
    Wait Until Element Is Visible    ${CHAMP_STATUT_AVOIR_RECU}

Vérifier Que Le Champ De Recherche Est Vide Avoirs fournisseurs reçus
    ${reference} =    Get Value    ${CHAMP_REFERENCE_AVOIR_RECU}
    ${fournisseur} =    Get Value    ${CHAMP_FOURNISSEUR_AVOIR_RECU}
    ${date} =    Get Value    ${CHAMP_DATE_AVOIR_RECU}
    ${total_accepte} =    Get Value    ${CHAMP_TOTAL_ACCEPTE_AVOIR_RECU}
    ${total_refuse} =    Get Value    ${CHAMP_TOTAL_REFUSE_AVOIR_RECU}
    ${montant_recu} =    Get Value    ${CHAMP_MONTANT_RECU_AVOIR_RECU}

     Should Be Empty    ${reference}
     Should Be Empty    ${fournisseur}
     Should Be Empty    ${date}
     Should Be Empty    ${total_accepte}
     Should Be Empty    ${total_refuse}
     Should Be Empty    ${montant_recu}
