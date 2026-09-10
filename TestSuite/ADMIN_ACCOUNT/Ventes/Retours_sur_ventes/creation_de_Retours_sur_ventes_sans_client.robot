*** Settings ***
Documentation     Tests fonctionnels de la page " Page de création de Retours_sur_ventes sans client"
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
Force Tags         Page de création de Retours_sur_ventes sans client
*** Variables ***
${approv_button}        xpath=//*[@data-testid="approuver"]

*** Test Cases ***
Accéder À La Page De Création D'un Retour Sur Vente
    [Documentation]    Accède à la page de création d'un retour sur vente sans sélectionner de client.
        Go To Retours_sur_ventes Listing Page       salesreturn/create?source=sales_return_saved
Vérifier Que La Date Du Retour Sur Vente Est Valide
    [Documentation]    Vérifie que le champ "Date" est pré-rempli avec la date du jour.
      Verify Date Field Is Valid
Soumettre Un Retour Sur Vente Vide
    [Documentation]    Vérifie qu'il est impossible de valider un retour sur vente sans avoir sélectionné de produit.
    verify pop up empty Retour Sur Vente
Sélectionner Les Produits
    [Documentation]    Ajoute un produit au retour sur vente via une recherche par code barre.
    Sélectionner des produits par code barre      8009004800229
Valider Le Retour Sur Vente Sans Client
    [Documentation]    Contrairement à un Devis, Approuver un Retour sur vente ouvre un écran réel
    ...                de remboursement ("Choisir un mode de paiement"). Sans client sélectionné,
    ...                seul le mode "Espèces" est proposé. On complète en Espèces pour finaliser
    ...                le retour, comme le fait déjà le flux avec client.
    Valider Le Retour Sur Vente Sans Client
Vérifier Que Le Retour Sur Vente A Été Créé Avec Succès Sans Client
    [Documentation]    Vérifie que le retour sur vente est créé avec succès même en l'absence de client.
    Vérifier Que Le Retour Sur Vente A Été Créé Avec Succès

*** Keywords ***
Go To Retours_sur_ventes Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the retour sur vente creation page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
     Wait Until Element Is Visible   ${approv_button}  timeout=30s

Verify Date Field Is Valid
     sleep    1s
     wait until element is visible       id=date      20s
    ${date_value}    get value    id=date
   ${current_date_str}    Get Current Date    result_format=%Y-%m-%d
    ${current_date}    Convert Date    ${current_date_str}    result_format=datetime
      ${new_date_str}    Convert Date    ${current_date}    result_format=%Y-%m-%d
     should be equal     ${new_date_str}    ${date_value}

verify pop up empty Retour Sur Vente
    wait until element is visible    ${approv_button}     3s
    click element     ${approv_button}
    wait until page contains    Vous devez choisir au moins un produit avec une quantité supérieur à 0.     5s
     click element      xpath=//div[@class='sob-v2-toastr__icon']
     sleep     3s

Valider Le Retour Sur Vente Sans Client
     wait until element is visible    ${approv_button}     3s
     click element     ${approv_button}
      sleep    2s
      wait until element is visible    xpath=//button[contains(., "Espèces")]     10s
      click element     xpath=//button[contains(., "Espèces")]
      sleep    2s

Vérifier Que Le Retour Sur Vente A Été Créé Avec Succès
     sleep    1s
     wait until page contains    Le retour sur vente a été crée avec succès!
