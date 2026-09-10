*** Settings ***
Documentation     Tests fonctionnels de la page " Page de création de Devis sans client"
Library           SeleniumLibrary
Library    Collections
Library    DateTime


Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/PageCreationMotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags         Page de création de Devis sans client
*** Variables ***
${draft_button}      xpath=//*[@data-testid="brouillon"]

*** Test Cases ***
Accéder À La Page De Création D'un Devis
    [Documentation]    Accède à la page de création d'un devis sans sélectionner de client.
        Go To devis Listing Page       quote/create
Vérifier Que La Date Du Devis Est Valide
    [Documentation]    Vérifie que le champ "Valable jusqu'au" est pré-rempli avec la date du jour.
      Verify Date Field Is Valid
Soumettre Un Devis Vide
    [Documentation]    Vérifie qu'il est impossible de valider un devis sans avoir sélectionné de produit.
    submit devis
    verify pop up empty devis
Sélectionner Les Produits
    [Documentation]    Ajoute un produit au devis via une recherche par code barre.
    Sélectionner des produits par code barre      8009004800229
Valider Le Devis Sans Client
    [Documentation]    Valide le devis sans avoir renseigné de client.
    submit devis
Vérifier Que Le Devis A Été Créé Avec Succès Sans Client
    [Documentation]    Vérifie que le devis est créé avec succès même en l'absence de client.
    Vérifier Que Le Devis A Été Créé Avec Succès

*** Keywords ***
Go To devis Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the devis creation page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
     Wait Until Element Is Visible   ${draft_button}  timeout=30s

Verify Date Field Is Valid
     sleep    1s
     wait until element is visible       id=valid_until      20s
    ${date_value}    get value    id=valid_until
   ${current_date_str}    Get Current Date    result_format=%Y-%m-%d
    ${current_date}    Convert Date    ${current_date_str}    result_format=datetime
      ${new_date_str}    Convert Date    ${current_date}    result_format=%Y-%m-%d
     should be equal     ${new_date_str}    ${date_value}

submit devis
    click element    ${draft_button}
     sleep    5s

verify pop up empty devis
    wait until page contains    Vous devez choisir au moins un produit avec une quantité supérieur à 0.     5s
     click element      xpath=//div[@class='sob-v2-toastr__icon']
     sleep     3s

Vérifier Que Le Devis A Été Créé Avec Succès
     sleep    1s
     wait until page contains    Le devis a été créé avec succès
