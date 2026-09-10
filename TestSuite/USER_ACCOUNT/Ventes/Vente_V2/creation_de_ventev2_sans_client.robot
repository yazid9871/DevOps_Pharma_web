*** Settings ***
Documentation     Tests fonctionnels de la page " Page de création de ventev2 sans client"
Library           SeleniumLibrary
Library    Collections
Library    DateTime


Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/PageCreationMotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags         Page de création de ventev2 sans client
*** Variables ***
${draft_button}      xpath=//*[@data-testid="brouillon"]
${approv_button_v2}        xpath=//div[@class='actions']//button[@data-testid='false']
${payment_mode_v2}    css=div.sob-v2-col-6:nth-child(1)
${amount}     0
*** Test Cases ***
Accéder À La Page De Création D'une Ventev2
    [Documentation]    Accède à la page de création d'une ventev2 (interface cashier-mode) sans sélectionner de client.
        Go To ventev2 Listing Page       invoice/create/cashier-mode?source=invoices
valide le compte user par ecurity_code
     valide le compte user par ecurity_code      ${PASSWORD2}
Vérifier Que La Date De La Ventev2 Est Valide
    [Documentation]    Vérifie que le champ date est pré-rempli avec la date du jour.
      Verify Date Field Is Valid
Soumettre Une Ventev2 Vide
    [Documentation]    Vérifie qu'il est impossible de valider une ventev2 sans avoir sélectionné de produit.
    submit ventev2
    verify pop up empty ventev2
Sélectionner Les Produits
    [Documentation]    Ajoute un produit à la ventev2 via une recherche par code barre.
    Sélectionner des produits par code barre      8009004800229
Approuve La Ventev2
    [Documentation]    Clique sur "Approuver" pour accéder à l'étape de choix du mode de paiement.
    Approuve La transaction v2
Vérifier Qu'Aucun Mode De Paiement Crédit N'Est Proposé Sans Client
    [Documentation]    Vérifie que le mode de paiement "Crédit" n'est pas proposé tant qu'aucun client n'est sélectionné.
    Vérifier Qu'Aucun Mode De Paiement Crédit N'Est Proposé Sans Client
Choisir Un Mode De Paiement Espèces
    [Documentation]    Sélectionne le premier mode de paiement disponible (Espèces) en l'absence de client.
    Choisir Un Mode De Paiement Espèces
Vérifier Que Je Peux Valider Une Ventev2 Sans Crédit
    [Documentation]    Vérifie que la ventev2 est créée avec succès en paiement espèces, sans client ni crédit.
    Vérifier Que Je Peux Valider Une Ventev2 Sans Crédit


*** Keywords ***

Go To ventev2 Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the ventev2 creation page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
     Wait Until Element Is Visible   ${draft_button}  timeout=30s

verify pop up empty ventev2
    wait until page contains    Vous devez choisir au moins un produit avec une quantité supérieur à 0.     5s
     click element      xpath=//div[@class='sob-v2-toastr__icon']
     sleep     3s
Verify Date Field Is Valid
     sleep    1s
     wait until element is visible       id=invoice_date      20s
    ${date_value}    get value    id=invoice_date
   ${current_date_str}    Get Current Date    result_format=%Y-%m-%d
    ${current_date}    Convert Date    ${current_date_str}    result_format=datetime
      ${new_date_str}    Convert Date    ${current_date}    result_format=%Y-%m-%d
     should be equal     ${new_date_str}    ${date_value}
submit ventev2
    click element    ${draft_button}
     sleep    5s

Approuve La transaction v2
     wait until element is visible      ${approv_button_v2}
    click element      ${approv_button_v2}
    sleep    2s

Vérifier Qu'Aucun Mode De Paiement Crédit N'Est Proposé Sans Client
    Page Should Not Contain    Crédit

Choisir Un Mode De Paiement Espèces
     sleep     1s
     wait until element is visible         ${payment_mode_v2}   20 s
     click element       ${payment_mode_v2}

Vérifier Que Je Peux Valider Une Ventev2 Sans Crédit
     sleep    1s
     wait until page contains    a été enregistré avec succès
