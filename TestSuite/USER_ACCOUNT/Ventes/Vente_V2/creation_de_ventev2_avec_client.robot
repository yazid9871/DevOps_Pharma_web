*** Settings ***
Documentation     Tests fonctionnels de la page " Page de création de ventev2 avec client"
Library           SeleniumLibrary
Library    Collections

Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/PageCreationMotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags         Page de création de ventev2 avec client
*** Variables ***

${draft_button}      xpath=//*[@data-testid="brouillon"]
${customer_field_v2}      css=.customer__info
${total}        css=.totals__info .data p
${approv_button_v2}        xpath=//div[@class='actions']//button[@data-testid='false']
${total_pay}    0
${ventev2_customer}
*** Test Cases ***
Accéder à la page de création d'une ventev2
        Go To ventev2 Listing Page       invoice/create/cashier-mode?source=invoices
valide le compte user par ecurity_code
     valide le compte user par ecurity_code      ${PASSWORD2}
Sélectionner le client dans le popup
     Cliquer sur le champ client v2     ${customer_field_v2}
    Sélectionner dans le popup
Sélectionner des produits
    Sélectionner des produits par code barre      8009004800229
Valider La Ventev2
   Valider La transaction
Vérifier Que Je Peux Valider Une Ventev2 Sans Crédit
   Vérifier Que Je Peux Valider Une Ventev2 Sans Crédit
Afficher Les Détails De La Ventev2
  Afficher Les Détails De La Ventev2
Vérifier Les Informations De La Ventev2
     Vérifier Les Informations De La Ventev2
Cliquer Sur Modifier La Ventev2
    Cliquer Sur Modifier La Ventev2
modifier la ventev2
    Sélectionner des produits par code barre      8009004800229
Aprouve La Ventev2 avec Crédit
   Approuve La transaction v2
Choisir Un Mode De Paiement Crédit
    Choisir Un Mode De Paiement Crédit
Vérifier Que Je Peux Valider Une Ventev2 Avec Crédit
    Vérifier Que Je Peux Valider Une Ventev2 Avec Crédit



*** Keywords ***
Go To ventev2 Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the ventev2 creation page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
     Wait Until Element Is Visible   ${draft_button}  timeout=30s

Cliquer sur le champ client v2
      [Arguments]    ${CHAMP}
     sleep       1s
    wait until element is visible      ${CHAMP}   10s
    click element     ${CHAMP}
    Wait Until Element Is Visible    css=tr.zoom:nth-child(1)     30s

Afficher Les Détails De La Ventev2
       click element     xpath=//*[@data-testid="afficher_la_facture"]
        sleep    2s
Cliquer Sur Modifier La Ventev2
   wait until element is visible      xpath=//*[@data-testid="modifier"]     3s
       click element     xpath=//*[@data-testid="modifier"]
   wait until element is visible      ${approv_button_v2}     3s

Vérifier Les Informations De La Ventev2
       wait until page contains  ${total_pay}
          # wait until page contains    ${ventev2_customer}

Vérifier Que Je Peux Valider Une Ventev2 Sans Crédit

     sleep    1s
     wait until page contains    Vente créée avec succès !

Choisir Un Mode De Paiement Crédit
     sleep     1s
     wait until element is visible      xpath=//*[@data-testid="vente_à_crédit"]     20 s
     click element      xpath=//*[@data-testid="vente_à_crédit"]

Approuve La transaction v2
     wait until element is visible      ${approv_button_v2}
    click element      ${approv_button_v2}
    sleep    1s

Vérifier Que Je Peux Valider Une Ventev2 Avec Crédit
    sleep    1s
     wait until page contains    a été enregistré avec succès
