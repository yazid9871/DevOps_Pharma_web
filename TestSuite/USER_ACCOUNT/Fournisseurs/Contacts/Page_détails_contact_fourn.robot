*** Settings ***
Documentation     Tests fonctionnels de la page " Page étails contact"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page étails contact

*** Variables ***

${loop_button}   xpath=//div[@class='table__search__inputs']//button[@data-testid='false']
${table}           //tbody[contains(@class, 'prevent-select')]//tr
${approv_button}        xpath=//div[@class='sob-breadcrumb__buttons']//button[@data-testid='false']
${avoir}
${GL_solde_client}
${GL_Loyalty_points}
${table_Factures_globales}          //tbody/tr



*** Test Cases ***
Vérifier plusieurs sections (Informations générales, Infos descriptives)
     Accéder à la page    suppliers
     Aller à la page détails contact
     Vérifier la section Informations générales
Vérifier la section Bons de commandes
    Vérifier que la section Bons de commandes est visible
     Cliquer sur "Créer un Bons de commandes"
     Ajouter un produit et soumettre Bons de commandes
Vérifier la section Bons de livraison
    Vérifier que la section Bons de livraison est visible
     Cliquer sur "Créer un Bons de livraison"
      Ajouter un produit et soumettre Bons de livraison
Vérifier les options du popup Autres actions
     Vérifier l'option Bons de commandes
     Vérifier l'option Bons de livraison
Vérifier le bouton Modifier
    Vérifier le bouton Modifier
*** Keywords ***
Définir le zoom du navigateur
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"

Faire défiler jusqu'à l'élément par texte
       [Arguments]    ${text}    # The text you're looking for
    # Using JavaScript to find and scroll to element containing the text
    Execute JavaScript
    ...    var elements = Array.from(document.getElementsByTagName('p'));
    ...    var targetElement = elements.find(el => el.textContent.trim() === '${text}');
    ...    if(targetElement) {
    ...        targetElement.scrollIntoView({block: 'center'});
    ...        window.scrollBy(0, -100);
    ...    }
    Sleep    2s

Aller à la page détails contact
    [Documentation]    Navigate to the product listing page after login in.
    Go To     https://app.pharma.sobrus.ovh/suppliers/contact/11990

Vérifier la section Informations générales


    Wait Until Page Contains       This is a test contact created     timeout=10s
     Wait Until Page Contains     tester    10s
     Wait Until Page Contains    by automation.      10s
     Wait Until Page Contains       Spouse      10s
    Page Should Contain      0509876756

    Page Should Contain     2026-05-21
    Page Should Contain     test@gmail.com
    Page Should Contain     0697859876

    #Descriptive info
    Page Should Contain    500

Vérifier que la section Bons de commandes est visible
      Faire défiler jusqu'à l'élément par texte    Bons de commandes
      click element    id=##contactpurchase_orders
      sleep    3s
      wait until page contains   Bons de commandes
     Wait Until Element Is Visible        xpath=//div[@id='contactpurchase_orders']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']     10s



Cliquer sur "Créer un Bons de commandes"
    click element       xpath=//div[@id='contactpurchase_orders']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']


Sélectionner des produits
      click element    ${loop_button}
       sleep  3s
        FOR  ${row}  IN RANGE  1    4
        ${col}    set variable    [${row}]/td[1]
        ${xpath_tab}    set variable     ${table}${col}
       click element     xpath=${xpath_tab}
       sleep    1s
      END

Ajouter un produit et soumettre Bons de commandes
     Sélectionner des produits
     wait until element is visible    ${approv_button}
     click element    ${approv_button}
     wait until element is visible     xpath=//*[@data-testid="vente_à_crédit"]
     click element     xpath=//*[@data-testid="vente_à_crédit"]
     wait until page contains    Vente créée avec succès !





Vérifier que la section Bons de livraison est visible
       Go To     https://app.pharma.sobrus.ovh/suppliers/contact/11990
        sleep     2s
       Faire défiler jusqu'à l'élément par texte    Bons de livraison
       wait until element is visible        id=##contactdelivery_notes     10s
      click element    id=##contactdelivery_notes
      sleep    3s
      wait until page contains   Bons de livraison
     Wait Until Element Is Visible      xpath=//div[@id='contactdelivery_notes']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']     10s

Cliquer sur "Créer un Bons de livraison"
     click element       xpath=//div[@id='contactdelivery_notes']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']

Ajouter un produit et soumettre Bons de livraison
     Sélectionner des produits
     wait until element is visible    ${approv_button}
     click element    ${approv_button}
     sleep    2s
     wait until page contains      Le devis a été créé avec succès     20s
       Go To     https://app.pharma.sobrus.ovh/customer/514394?from=sale
        sleep     2s

Vérifier l'option Bons de commandes
     Go To    https://app.pharma.sobrus.ovh/suppliers/contact/11990
        sleep     2s
   wait until element is visible     css=.sob-v2-btn-tertiary     10s
   click element    css=.sob-v2-btn-tertiary
   sleep    1s
     wait until element is visible     xpath=//div[@data-testid="créer_un_nouveau_bon_de_commande"]      10s
   click element    xpath=//div[@data-testid="créer_un_nouveau_bon_de_commande"]

Vérifier l'option Bons de livraison
     Go To    https://app.pharma.sobrus.ovh/suppliers/contact/11990
        sleep     2s
   wait until element is visible     css=.sob-v2-btn-tertiary     10s
   click element    css=.sob-v2-btn-tertiary
   sleep    1s
     wait until element is visible     xpath=//div[@data-testid="créer_un_nouveau_bon_de_livraison"]      10s
   click element    xpath=//div[@data-testid="créer_un_nouveau_bon_de_livraison"]
    sleep    1s


Vérifier le bouton Modifier
     Go To     https://app.pharma.sobrus.ovh/suppliers/contact/11990
        sleep     2s
   wait until element is visible    css=button.sob-v2-btn-primary:nth-child(2)    10s
   click element    css=button.sob-v2-btn-primary:nth-child(2)
    sleep    2s
    wait until page contains     Modifier le contact : This is a test contact created by automation.    10s
     Définir le zoom du navigateur      60
     wait until element is visible     id=title
     input text     id=title      tester
   click element      xpath=//*[@data-testid="\sauvegarder"]
    wait until page contains     Le contact a été modifié avec succès    10s

