*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports  Journal produits"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Resource        ../../../../Resources/Vérifier_que_le_téléchargement_commence.robot

Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags       Rapports  Journal produits


*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryeme.e@sobrus.com
${PASSWORD}  qw067012@


${TITRE_PAGE}               Journal produits
${CHAMP_DATE_DEBUT}          id=start_date
${CHAMP_DATE_FIN}           id=start_date
${date_DROPDOWN}      css=.react-datepicker


*** Test Cases ***
Vérifier l'affichage de la page Journal produits
      [Documentation]    Vérifier affichage du rapport
      Accéder à la page     reports/inventorymain
    wait until page contains    ${TITRE_PAGE}    10s

Recherche Par une period
     choisir un période
earch By Product Name
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Verify Search Fields are Visibles
    Vérifier La Recherche     th      +CARE SPRAY ANTI-CHUTE 120ML      ${CHAMP_NOM_PRODUIT}
Search By Code bare
     [Tags]  search  Code bare
    Verify Search Fields are Visibles
    Cliquer Sur Actualiser
    Verify Input Field Is Empty
    Vérifier La Recherche     td[2]     98783627517    ${CHAMP_CODE_BARRE_PRODUIT}
Search By Category
     [Tags]  search  category
    Verify Search Fields are Visibles
    Cliquer Sur Actualiser
     Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_CATEGORIE_PRODUIT}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[3]    ${CHAMP_CATEGORIE_PRODUIT}

Search By PPV
     [Tags]  search  PPV
    Verify Search Fields are Visibles
    Cliquer Sur Actualiser
    Verify Input Field Is Empty
    Vérifier La Recherche     td[1]     100,00   ${CHAMP_PPV_PRODUIT}

Search By Zone
     [Tags]  search  Zone
    Verify Search Fields are Visibles
    Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_ZONE_PRODUIT}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche   td[6]         ${CHAMP_ZONE_PRODUIT}

verify la section marketplace
    verify l'affichage et click sur voir offre

*** Keywords ***

Set Browser Zoom
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"

Vérifier la présence des éléments de formulaire
    Element Should Be Visible    ${CHAMP_DATE_DEBUT}
    Element Should Be Visible    ${CHAMP_DATE_FIN}

choisir un période
    #date debut
    click element     ${CHAMP_DATE_DEBUT}
     Wait Until Element Is Visible  ${date_DROPDOWN}    10s
     click element     css=.react-datepicker__day--006
     input text      ${CHAMP_DATE_DEBUT}     2025-04-06
    #date fin
       click element    ${CHAMP_DATE_FIN}
     Wait Until Element Is Visible  ${date_DROPDOWN}    10s
      click element    css:button.react-datepicker__navigation:nth-child(3)
     sleep    5s
     click element     css=.react-datepicker__day--006


Verify Search Fields are Visibles
     Wait Until Element Is Visible  ${CHAMP_NOM_PRODUIT}
        Wait Until Element Is Visible  ${CHAMP_PPV_PRODUIT}
    Wait Until Element Is Visible  ${CHAMP_PPH_PRODUIT}
     Wait Until Element Is Visible  ${CHAMP_CODE_BARRE_PRODUIT}
    Wait Until Element Is Visible  ${CHAMP_CATEGORIE_PRODUIT}
    Wait Until Element Is Visible  ${CHAMP_FORME_GALENIQUE_PRODUIT}
    Wait Until Element Is Visible  ${CHAMP_ZONE_PRODUIT}
    Wait Until Element Is Visible  ${CHAMP_RAISON_PRODUIT}
Verify Input Field Is Empty
    ${name} =    Get Value    ${CHAMP_NOM_PRODUIT}
    ${ppv} =    Get Value    ${CHAMP_PPV_PRODUIT}
    ${pph} =    Get Value    ${CHAMP_PPH_PRODUIT}
    ${code_barre} =    Get Value    ${CHAMP_CODE_BARRE_PRODUIT}


     Should Be Empty    ${name}
     Should Be Empty    ${ppv}
     Should Be Empty    ${pph}
     Should Be Empty    ${code_barre}

verify l'affichage et click sur voir offre
     sleep    2s
      Set Browser Zoom    50
          sleep    2s
      ${offre} =     get text     css=div.InventoryMain__offer__card:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2)
       click element       xpath=//*[@data-testid="voir_l'offre"]
       wait until page contains    ${offre}
