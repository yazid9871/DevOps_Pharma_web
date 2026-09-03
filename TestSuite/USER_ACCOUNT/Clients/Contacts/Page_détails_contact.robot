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
     Accéder à la page    customers
     Aller à la page détails contact
     Vérifier la section Informations générales
Vérifier la section Factures
    Vérifier que la section Factures est visible
     Cliquer sur "Créer une facture" et vérifier que le client sélectionné est correct
     Ajouter un produit et soumettre la facture
Vérifier la section Devis
    Vérifier que la section Devis est visible
     Cliquer sur "Créer un devis" et vérifier que le client sélectionné est correct
      Ajouter un produit et soumettre le devis
Vérifier les options du popup Autres actions
     Vérifier l'option Devis
     Vérifier l'option Facture
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
    Go To      https://app.pharma.sobrus.ovh/customers/contact/11964

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

Vérifier que la section Factures est visible
      Faire défiler jusqu'à l'élément par texte    ventes
      click element    id=##contactinvoices
      sleep    3s
      wait until page contains    Liste des ventes
     Wait Until Element Is Visible       xpath=//*[@data-testid="créer"]    10s



Cliquer sur "Créer une facture" et vérifier que le client sélectionné est correct
    click element       css=#contactinvoices > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > button:nth-child(1)
    wait until element is visible     id=contact_name
    ${name}=    Get Value    id=contact_name
   #  Should Be Equal    ${name}     This is a test contact created by automation.

Sélectionner des produits
      click element    ${loop_button}
       sleep  3s
        FOR  ${row}  IN RANGE  1    4
        ${col}    set variable    [${row}]/td[1]
        ${xpath_tab}    set variable     ${table}${col}
       click element     xpath=${xpath_tab}
       sleep    1s
      END

Ajouter un produit et soumettre la facture
     Sélectionner des produits
     wait until element is visible    ${approv_button}
     click element    ${approv_button}
     wait until element is visible     xpath=//*[@data-testid="vente_à_crédit"]
     click element     xpath=//*[@data-testid="vente_à_crédit"]
     wait until page contains    Vente créée avec succès !





Vérifier que la section Devis est visible
       Go To     https://app.pharma.sobrus.ovh/customers/contact/11964
        sleep     2s
       Faire défiler jusqu'à l'élément par texte    Devis
       wait until element is visible        id=##contactquotes     10s
      click element    id=##contactquotes
      sleep    3s
      wait until page contains   Devis
     Wait Until Element Is Visible       css=#contactquotes > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > button:nth-child(1)    10s

Cliquer sur "Créer un devis" et vérifier que le client sélectionné est correct
     click element      css=#contactquotes > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > button:nth-child(1)
    wait until element is visible     id=contact_name
    ${name}=    Get Value    id=contact_name
     Should Be Equal    ${name}    This is a test contact created by automation.

Ajouter un produit et soumettre le devis
     Sélectionner des produits
     wait until element is visible    ${approv_button}
     click element    ${approv_button}
     sleep    2s
     wait until page contains      Le devis a été créé avec succès     20s
       Go To     https://app.pharma.sobrus.ovh/customer/514394?from=sale
        sleep     2s

Vérifier l'option Devis
     Go To    https://app.pharma.sobrus.ovh/customers/contact/11964
        sleep     2s
   wait until element is visible     css=.sob-v2-btn-tertiary     10s
   click element    css=.sob-v2-btn-tertiary
   sleep    1s
     wait until element is visible     xpath=//div[@data-testid="créer_un_nouveau_devis"]      10s
   click element    xpath=//div[@data-testid="créer_un_nouveau_devis"]
    sleep    2s
     ${name}=    Get Value    id=contact_name
     Should Be Equal    ${name}    This is a test contact created by automation.
Vérifier l'option Facture
     Go To    https://app.pharma.sobrus.ovh/customers/contact/11964
        sleep     2s
   wait until element is visible     css=.sob-v2-btn-tertiary     10s
   click element    css=.sob-v2-btn-tertiary
   sleep    1s
     wait until element is visible     xpath=//div[@data-testid="créer_une_nouvelle_vente"]      10s
   click element    xpath=//div[@data-testid="créer_une_nouvelle_vente"]
    sleep    1s
    #wait until page contains   This is a test contact created

Vérifier le bouton Modifier
     Go To    https://app.pharma.sobrus.ovh/customers/contact/11964
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

