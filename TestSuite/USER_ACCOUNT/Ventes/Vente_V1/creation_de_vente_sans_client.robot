*** Settings ***
Documentation     Tests fonctionnels de la page " Page de création de vente avec client"
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
Force Tags         Page de création de vente avec client
*** Variables ***
${ADD_BUTTON}        xpath=//*[@data-testid="créer"]
${draft_button}      xpath=//*[@data-testid="brouillon"]
${loop_button}   xpath=//div[@class='table__search__inputs']//button[@data-testid='false']
${table}           //tbody[contains(@class, 'prevent-select')]//tr

${approv_button}        xpath=//div[@class='sob-breadcrumb__buttons']//button[@data-testid='false']
${amount}     0
*** Test Cases ***
Accéder À La Page De Création D'une Vente
        Go To vente Listing Page       invoice/create?source=invoices
valide le compte user par ecurity_code
     valide le compte user par ecurity_code      ${PASSWORD2}
Vérifier Que La Date De La Vente Est Valide
      Verify Date Field Is Valid
Soumettre Une Vente Vide
    submit vente
    verify pop up empty vente
Sélectionner Les Produits
    Sélectionner des produits par code barre      8009004800229
Aprouve La Vente avec Crédit
   Appouve La transaction
Modifier Le Montant À 0
     Modifier Le Montant À 0
Choisir Un Mode De Paiement Crédit
    Choisir Un Mode De Paiement Crédit
Vérifier Que Je Ne Peux Pas Valider Une Vente Avec Crédit
   Vérifier Le Message D'erreur
Retourner En Arrière
     Go To vente Listing Page       invoice/create?source=invoices
valide le compte user par ecurity_code 2 fois
     valide le compte user par ecurity_code      ${PASSWORD2}
verify l'affichage de pop up 'Récupérer l'ancien formulaire'
       verify l'affichage de pop up 'Récupérer l'ancien formulaire'
Choisir récupérer La Vente
    Choisir récupérer La Vente
Appouve La transaction
     Execute JavaScript    window.scrollTo(0, 0)
    sleep    2s
   Appouve La transaction
Choisir Un Mode De Paiement Crédit 2 fois
   Choisir Un Mode De Paiement Crédit

Ajouter Une Vente Sans Crédit
    Ajouter Une Vente Sans Crédit


*** Keywords ***

Go To vente Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the product listing page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
     Wait Until Element Is Visible   ${draft_button}  timeout=30s

verify pop up empty vente
    wait until page contains    Vous devez choisir au moins un produit avec une quantité supérieur à 0.     5s
     click element      xpath=//div[@class='sob-v2-toastr__icon']
     sleep     3s
Verify Date Field Is Valid
     sleep    1s
     wait until element is visible       id=invoice_date      20s
    ${date_value}    get value    id=invoice_date
   ${current_date_str}    Get Current Date    result_format=%Y-%m-%d
    ${current_date}    Convert Date    ${current_date_str}    result_format=datetime
      ${new_date_str}    Convert Date    ${current_date}    result_format=%d/%m/%Y
     should be equal     ${new_date_str}    ${date_value}
submit vente
    click element    ${draft_button}
     sleep    5s
search bu button loup
     click element    ${loop_button}
       sleep  3s
select products
      FOR  ${row}  IN RANGE  1    4
        ${col}    set variable    [${row}]/td[1]
        ${xpath_tab}    set variable     ${table}${col}
       click element     xpath=${xpath_tab}
       sleep    1s
      END

Modifier Le Montant À 0

      ${amount_input}    get value     id=invoice_payment_amount
      set Global variable  ${amount}   ${amount_input}
    input text  id=invoice_payment_amount    0

Vérifier Le Message D'erreur
    wait until page contains    Vous devez choisir un client pour pouvoir faire une vente à crédit     5s
    sleep    2s
verify l'affichage de pop up 'Récupérer l'ancien formulaire'
    sleep    2s
    wait until page contains    Récupérer l'ancien formulaire   10s
Choisir récupérer La Vente
      wait until element is visible       xpath=//*[@data-testid="récupérer"]      20s
        click element        xpath=//*[@data-testid="récupérer"]

verify le calcule de Monnaie
   wait until element is visible    css=.sob-v2-form-control
   input text      css=.sob-v2-form-control    100
     ${Monnaie}    get text    css=.amount
     ${Monnaie_calcule}    evaluate      100 - ${amount}

    should be equal      ${Monnaie}       ${Monnaie_calcule}

Choisir Un Mode De Paiement Crédit
     sleep     1s
     wait until element is visible         css=div.sob-v2-col-6:nth-child(1)   20 s
     click element       css=div.sob-v2-col-6:nth-child(1)
Ajouter Une Vente Sans Crédit
     sleep    1s
     wait until page contains    Vente créée avec succès !
