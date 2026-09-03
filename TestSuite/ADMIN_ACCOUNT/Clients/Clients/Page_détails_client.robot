*** Settings ***
Documentation     Tests fonctionnels de la page " Page étails client"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page étails client

*** Variables ***

${loop_button}   xpath=//div[@class='table__search__inputs']//button[@data-testid='false']
${approv_button}        xpath=//div[@class='sob-breadcrumb__buttons']//button[@data-testid='false']
${credit}
${avoir}
${GL_solde_client}
${GL_Loyalty_points}
${table_Factures_globales}          //tbody/tr


*** Test Cases ***
Vérifier les sections (En-tête, Infos générales et Contact)
     Accéder à la page    customers
     Aller à la page détails client
     Vérifier la section en-tête du client
     Vérifier les informations générales et de contact du client
Vérifier la section des payeurs du client
     Vérifier la section des payeurs du client
Vérifier la section Factures
    Vérifier que la section Factures est visible
     Cliquer sur "Créer une facture" et vérifier que le client sélectionné est correct
     Ajouter un produit et soumettre la facture
     Vérifier que la valeur du crédit est mise à jour
Vérifier la section Marketing
    Vérifier que la section Marketing est visible
    Ajouter des points de fidélité via le bouton Ajustement
    Ajouter un cadeau et vérifier l'impact sur le solde client et les points de fidélité
Vérifier la section Remise par défaut
    Vérifier que la section Remise par défaut est visible
    Cliquer sur Modifier et remplir le formulaire de remise
    Enregistrer et vérifier la soumission réussie
Vérifier la section Contact
     Vérifier que la section Contact est visible
     Remplir le formulaire de contact et enregistrer
Vérifier la section Devis
    Vérifier que la section Devis est visible
     Cliquer sur "Créer un devis" et vérifier que le client sélectionné est correct
      Ajouter un produit et soumettre le devis
Vérifier la section Préparations
    Vérifier que la section Préparations est visible
     Cliquer sur "Créer une préparation" et vérifier que le client sélectionné est correct
     Ajouter un produit U,P et soumettre la préparation
     Vérifier la facture après redirection
      Soumettre la facture et vérifier le résultat
Vérifier la section Retours sur ventes
    Vérifier que la section Retours sur ventes est visible
     Cliquer sur "Créer un retour sur vente" et vérifier que le client sélectionné est correct
     Ajouter un produit et soumettre le retour sur vente
     Vérifier que la valeur du crédit est mise à jour
Vérifier la section Factures globales
    Vérifier que la section Factures globales est visible
     Cliquer sur "Créer une facture globale" et sélectionner facture, retour sur vente
     Soumettre la facture globale et vérifier
Vérifier la section Avoirs
    Vérifier que la section Avoirs est visible
     Ajouter un avoir
     Vérifier que la valeur du crédit est mise à jour
Vérifier la section Ajustements de débit
    Vérifier que la section Ajustements de débit est visible
     Ajouter un ajustement de débit
     Vérifier que la valeur du crédit est mise à jour
Archiver le client avec succès
   Client avec solde
    Client sans solde
   Restaurer le client
Vérifier l'impression du relevé
    Vérifier l'impression du relevé : type simple
    Vérifier l'impression du relevé : type avancé
Vérifier les options du popup Autres actions
     Vérifier l'option Modifier
     Vérifier l'option Lier MySobrus
     Vérifier l'option Ajouter un contact
     Vérifier l'option Ajouter un devis
     Vérifier l'option Ajouter une facture
     Vérifier l'option Payer plusieurs factures
Vérifier le paiement du crédit client
    Vérifier le paiement du crédit client

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

Aller à la page détails client
    [Documentation]    Navigate to the product listing page after login in.
    Go To     https://app.pharma.sobrus.ovh/customer/514394/table

Vérifier la section en-tête du client


    Wait Until Page Contains     meryeme Compte de Teste AUTO     timeout=10s
     Wait Until Page Contains     2024-05-02 (2 ans)     10s
     Wait Until Page Contains    Actif      10s
     Wait Until Page Contains       df123465      10s

Vérifier les informations générales et de contact du client

    # General information
    Page Should Contain    Aali Imesty
   # Page Should Contain   2025-08-08
    Page Should Contain      12435

    # Contact details
    Page Should Contain    agdal
    Page Should Contain    rabat
    Page Should Contain    meryeme.e@sobrus.com
    Page Should Contain    06837646353

Vérifier la section des payeurs du client

    Page Should Contain    Assurance Maladie Obligatoire (AMO)
    Page Should Contain    CNSS
    Page Should Contain    123
    Page Should Contain    123

    Page Should Contain   Assurance Maladie Complémentaire (AMC)
    Page Should Contain     Assurances AXA
    Page Should Contain    1234
    Page Should Contain    123

Vérifier que la section Factures est visible
      Faire défiler jusqu'à l'élément par texte    ventes
      click element    id=##customerinvoices
      sleep    3s
      wait until page contains    Liste des ventes
     Wait Until Element Is Visible       xpath=//*[@data-testid="créer"]    10s

    ${credit}=    Get Text    css=div.vtab__totals__container:nth-child(1) > div:nth-child(2) > span:nth-child(1)
    ${avoir}=     Get Text    css=div.vtab__totals__container:nth-child(2) > div:nth-child(2) > span:nth-child(1)

    Set Global Variable    ${credit}
    Set Global Variable    ${avoir}

Cliquer sur "Créer une facture" et vérifier que le client sélectionné est correct
    click element       xpath=//*[@data-testid="créer"]
    wait until element is visible     id=customer_name
    ${name}=    Get Value    id=customer_name
     Should Be Equal    ${name}    meryeme Compte de Teste AUTO

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

Vérifier que la valeur du crédit est mise à jour
        Go To     https://app.pharma.sobrus.ovh/customer/514394/table
      sleep    1s
     wait until element is visible     css=div.vtab__totals__container:nth-child(1) > div:nth-child(2) > span:nth-child(1)
    ${new_credit}=    Get Text    css=div.vtab__totals__container:nth-child(1) > div:nth-child(2) > span:nth-child(1)
    Should Not Be Equal    ${credit}    ${new_credit}
       wait until element is visible     css=.vtab__totals__info__totals > span:nth-child(1)      10s

Vérifier que la section Marketing est visible
      Faire défiler jusqu'à l'élément par texte    Marketing
      click element    id=##customermarketing
      sleep    3s
      wait until page contains   Points de fidélité
     Wait Until Element Is Visible       xpath=//*[@data-testid="ajustement_points_fidélité"]    10s

Ajouter des points de fidélité via le bouton Ajustement
     ${Points_fidelite}=    Get Text    css=p.point
      ${Points_fidelite}=    Replace String    ${Points_fidelite}    ,    .
      ${Points_fidelite}=    Convert To Number    ${Points_fidelite}
     click element      xpath=//*[@data-testid="ajustement_points_fidélité"]
     wait until element is visible    id=loyalty_points
     input text      id=loyalty_points     100
      click element      xpath=//*[@data-testid="\sauvegarder"]
      sleep    2s
       ${Points_fidelite_calcul}=    Evaluate    ${Points_fidelite} + 100

       Go To     https://app.pharma.sobrus.ovh/customer/514394/table
        sleep     2s
        Vérifier que la section Marketing est visible
       wait until element is visible     css=p.point     10s

        ${GL_Loyalty_points}=    Get Text    css=p.point
          Set Global Variable    ${GL_Loyalty_points}
         ${GL_solde_client}=     Get Text    css=.vtab__totals__info__totals > span:nth-child(1)
         Set Global Variable    ${GL_solde_client}
      ${Points_fidelite_new}=    Get Text    css=p.point
     ${Points_fidelite_new}=    Replace String    ${Points_fidelite_new}    ,    .
     ${Points_fidelite_new}=    Convert To Number    ${Points_fidelite_new}

     Should Be Equal As Numbers    ${Points_fidelite_new}    ${Points_fidelite_calcul}

Ajouter un cadeau et vérifier l'impact sur le solde client et les points de fidélité
       wait until element is visible      xpath=//*[@data-testid="attribuer_un_cadeau"]
        click element      xpath=//*[@data-testid="attribuer_un_cadeau"]
        #add gifts avoir and product
        wait until element is visible     css=tr.zoom:nth-child(2) > td:nth-child(2)
        click element    css=tr.zoom:nth-child(2) > td:nth-child(2)
        click element    css=tr.zoom:nth-child(1) > td:nth-child(2)
          #product verify Quantity Increases
       click element    css=tr.zoom:nth-child(2) > td:nth-child(2)
       sleep    1s
        ${qte}=    get value    xpath=(//input[@type='text' and contains(@class,'gift__quantity__input')])[1]
       ${qte}=    Convert To Number    ${qte}
       Should Be Equal As Numbers    ${qte}   2
        #verify delete button
        wait until element is visible    xpath=//button[@type='button' and contains(@class,'sob-v2-icon-btn-sm')]
        click element     xpath=//button[@type='button' and contains(@class,'sob-v2-icon-btn-sm')]

        click element    css=tr.zoom:nth-child(2) > td:nth-child(2)
        click element      xpath=//*[@data-testid="\sauvegarder"]
        sleep    2s

      # Verify Impact InSolde client and Loyalty points
           ${GL_Loyalty_points}=    Replace String    ${GL_Loyalty_points}    ,    .
            ${GL_solde_client}=    Replace String    ${GL_solde_client}    ,    .

           ${Points_fidelite_calcue}=    Evaluate    ${GL_Loyalty_points} - 100
           ${solde_client_calcule}=    Evaluate    ${GL_solde_client} - 50
            ${solde_client_calcule}=    Evaluate    round(${solde_client_calcule}, 2)

            ${Points_fidelite_new}=    Get Text    css=p.point
             ${Points_fidelite_new}=    Replace String    ${Points_fidelite_new}    ,    .
              ${Points_fidelite_new}=    Convert To Number    ${Points_fidelite_new}

             ${solde_client_new}=    Get Text    css=.vtab__totals__info__totals > span:nth-child(1)
             ${solde_client_new}=    Replace String    ${solde_client_new}    ,    .
              ${solde_client_new}=    Convert To Number    ${solde_client_new}


             should be equal      ${solde_client_calcule}     ${solde_client_new}
             should be equal      ${Points_fidelite_new}     ${Points_fidelite_calcue}

Vérifier que la section Remise par défaut est visible
        Faire défiler jusqu'à l'élément par texte    Remises par défaut
      click element    id=##customerdefault_discounts
      sleep    3s
      wait until page contains   Remises par défaut
     Wait Until Element Is Visible     css=#customerdefault_discounts > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > button:nth-child(1)      10s

Cliquer sur Modifier et remplir le formulaire de remise
   click element       css=#customerdefault_discounts > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > button:nth-child(1)
   wait until page contains      Modifier remise par défaut du client :     10s
   wait until element is visible       xpath=//*[@id="discount__9"]      10s

     input text    xpath=//*[@id="discount__9"]         ""
   input text    xpath=//*[@id="discount__9"]      100
   input text    xpath=//*[@id="discount__18"]      10
   input text    xpath=//*[@id="discount__3"]    115
        Execute JavaScript  document.querySelector("#discount__7").scrollIntoView(true);
        sleep    3s
    input text    xpath=//*[@id="discount__7"]    20
   input text    xpath=//*[@id="discount__8"]     34
   input text    xpath=//*[@id="discount__11"]     5
    input text    xpath=//*[@id="discount__12"]    7
       Execute JavaScript  document.querySelector("#discount__13").scrollIntoView(true);
        sleep    3s
   input text    xpath=//*[@id="discount__13"]     7
   input text    xpath=//*[@id="discount__14"]     12

   input text     xpath=//*[@id="discount__15"]    67
   input text   xpath=//*[@id="discount__4"]     09
      Execute JavaScript  document.querySelector("#discount__17").scrollIntoView(true);
        sleep    3s
    input text    xpath=//*[@id="discount__17"]     56
    input text    xpath=//*[@id="discount__19"]     45
   input text      xpath=//*[@id="discount__20"]     3
   input text     xpath=//*[@id="discount__21"]    10
      Execute JavaScript  document.querySelector("#discount__6").scrollIntoView(true);
        sleep    3s
    input text     xpath=//*[@id="discount__6"]     100
   input text       xpath=//*[@id="discount__5"]     36
   input text      xpath=//*[@id="discount__16"]     13

    Execute JavaScript  window.scrollTo(0,  0)
    sleep    2s

Enregistrer et vérifier la soumission réussie
   wait until element is visible       xpath=//*[@data-testid="sauvegarder"]     10s
    click element       xpath=//*[@data-testid="sauvegarder"]
     wait until page contains    La remise par défaut a été modifiée avec succès.   15s

Vérifier que la section Contact est visible
      Faire défiler jusqu'à l'élément par texte     Contacts
      click element     id=##customercontacts
      sleep    3s

     wait until page contains   Contacts
     Wait Until Element Is Visible       xpath=//div[@id='customercontacts']//button[@data-testid='créer']   10s
     sleep     2s
     #button creer contact
     click element       xpath=//div[@id='customercontacts']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']

Remplir le formulaire de contact et enregistrer
      wait until element is visible    id=title     10s
      input text      id=title     tester
      input text      id=last_name      mery
      input text      id=first_name     test
      input text      id=email      test@gmail.com
      input text      id=phone     9675645434
     Click Element   id=relationship_type_id
     Wait Until Element Is Visible    css=.sob-v2-select-clearable > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)      10s
     click element     css=.sob-v2-select__option:nth-child(2)

     Execute JavaScript  window.scrollTo(0,  0)
     sleep    2s
     wait until element is visible    xpath=//*[@data-testid="\sauvegarder"]     10s
     click element      xpath=//*[@data-testid="\sauvegarder"]
        wait until page contains    Le contact a été créé avec succès     15s

Vérifier que la section Devis est visible
      Faire défiler jusqu'à l'élément par texte    Devis
      click element    id=##customerquotes
      sleep    3s
      wait until page contains   Devis
     Wait Until Element Is Visible       xpath=//div[@id='customerquotes']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']   10s

Cliquer sur "Créer un devis" et vérifier que le client sélectionné est correct
     click element       xpath=//div[@id='customerquotes']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
    wait until element is visible     id=customer_name
    ${name}=    Get Value    id=customer_name
     Should Be Equal    ${name}    meryeme Compte de Teste AUTO

Ajouter un produit et soumettre le devis
     Sélectionner des produits
     wait until element is visible    ${approv_button}
     click element    ${approv_button}
     wait until page contains      Le devis a été créé avec succès
       Go To     https://app.pharma.sobrus.ovh/customer/514394/table
      sleep     2s

Vérifier que la section Préparations est visible
      Faire défiler jusqu'à l'élément par texte    Préparations
      click element    id=##customerpreparations
      sleep    3s
      wait until page contains   Préparations
     Wait Until Element Is Visible       xpath=//div[@id='customerpreparations']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']   10s

Cliquer sur "Créer une préparation" et vérifier que le client sélectionné est correct
      click element         xpath=//div[@id='customerpreparations']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
      wait until element is visible     id=customer_name
    ${name}=    Get Value    id=customer_name
     Should Be Equal    ${name}    meryeme Compte de Teste AUTO

Ajouter un produit U,P et soumettre la préparation
      Sélectionner des produits
      input text    id=resulting_product_price       200
     wait until element is visible       xpath=//*[@data-testid="approuver"]
     click element      xpath=//*[@data-testid="approuver"]
     wait until page contains   Créer une nouvelle vente

Vérifier la facture après redirection
    sleep    2s
      wait until element is visible     id=customer_name     10s
    ${name}=    Get Value    id=customer_name
     Should Be Equal    ${name}    meryeme Compte de Teste AUTO
      wait until page contains     200,00 DHS
      wait until page contains     PREPARATION OFFICINALE

Soumettre la facture et vérifier le résultat
       wait until element is visible    ${approv_button}
     click element    ${approv_button}
      wait until element is visible     xpath=//*[@data-testid="vente_à_crédit"]
     click element     xpath=//*[@data-testid="vente_à_crédit"]
     wait until page contains    Vente créée avec succès !
       Go To     https://app.pharma.sobrus.ovh/customer/514394/table
      sleep     2s

Vérifier que la section Retours sur ventes est visible
       Faire défiler jusqu'à l'élément par texte    Retours sur ventes
      click element    id=##customersales_returns
      sleep    3s
      wait until page contains      Retours sur ventes
     Wait Until Element Is Visible       xpath=//div[@id='customersales_returns']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']     10s

    ${credit}=    Get Text    css=div.vtab__totals__container:nth-child(1) > div:nth-child(2) > span:nth-child(1)

    Set Global Variable    ${credit}

Cliquer sur "Créer un retour sur vente" et vérifier que le client sélectionné est correct
        click element           xpath=//div[@id='customersales_returns']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
      wait until element is visible     id=customer_name
    ${name}=    Get Value    id=customer_name
     Should Be Equal    ${name}    meryeme Compte de Teste AUTO

Ajouter un produit et soumettre le retour sur vente
      Sélectionner des produits
     wait until element is visible       xpath=//*[@data-testid="approuver"]
     click element      xpath=//*[@data-testid="approuver"]
     wait until element is visible     css=div.sob-v2-container:nth-child(5) > div:nth-child(1) > div:nth-child(2) > button:nth-child(1)
     click element      css=div.sob-v2-container:nth-child(5) > div:nth-child(1) > div:nth-child(2) > button:nth-child(1)
     wait until page contains      Le retour sur vente a été crée avec succès!

Vérifier que la section Factures globales est visible
      Faire défiler jusqu'à l'élément par texte   Factures globales
      click element    id=##customerglobal_invoices
      sleep    3s
      wait until page contains     Factures globales
      wait until element is visible         xpath=//div[@id='customerglobal_invoices']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']        10s

Cliquer sur "Créer une facture globale" et sélectionner facture, retour sur vente
      click element           xpath=//div[@id='customerglobal_invoices']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
      wait until element is visible      xpath=//tbody/tr[1]/td[1]    20s
      #select incoice
      click element      xpath=//tbody/tr[1]/td[1]
      #select Sales Returns
      Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
      sleep     2s
       wait until element is visible        xpath=//tbody/tr[1]/td[1]    20s
      click element           css=div.sob-v2-card:nth-child(3) > div:nth-child(1) > div:nth-child(2) > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(1) > th:nth-child(1)

Soumettre la facture globale et vérifier
      Execute JavaScript    window.scrollTo(0, 0)
      sleep    2s
      click element      xpath=//*[@data-testid="\sauvegarder"]
      sleep    2s
      wait until page contains    La facture globale a été enregistrée avec succès
       Go To     https://app.pharma.sobrus.ovh/customer/514394/table
        sleep     2s

Vérifier que la section Avoirs est visible
      Faire défiler jusqu'à l'élément par texte     Avoirs
      click element    id=##customercredit_notes
      sleep    3s
      wait until page contains    Avoirs client
      wait until element is visible         xpath=//div[@id='customercredit_notes']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']        10s

Ajouter un avoir
      click element        xpath=//div[@id='customercredit_notes']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
      wait until element is visible      id=amount
      input text      id=amount        10
     Click Element   id=payment_method_id
     Wait Until Element Is Visible    css=div.sob-v2-form-group:nth-child(6) > div:nth-child(2) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)     10s
     click element     css=.sob-v2-select__option:nth-child(1)
      Execute JavaScript    window.scrollTo(0, 0)
      sleep    2s
      click element      xpath=//*[@data-testid="\sauvegarder"]

     # verify creation with succès
      Wait Until Page Contains     meryeme Compte de Teste AUTO     timeout=10s
     Wait Until Page Contains    10,00    10s
     Wait Until Page Contains   Espèce   10s

Vérifier que la section Ajustements de débit est visible
       Faire défiler jusqu'à l'élément par texte    Ajustements de solde client
      click element    id=##customerdebit_adjustments
      sleep    3s
      wait until page contains    Ajustements de solde client
      wait until element is visible         xpath=//div[@id='customerdebit_adjustments']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']        10s

Ajouter un ajustement de débit
     click element        xpath=//div[@id='customerdebit_adjustments']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
      wait until element is visible      id=amount
      input text      id=amount        10
      Execute JavaScript    window.scrollTo(0, 0)
      sleep    2s
      click element      xpath=//*[@data-testid="\sauvegarder"]

     # verify creation with succès
      Wait Until Page Contains     meryeme Compte de Teste AUTO     timeout=10s
     Wait Until Page Contains    10,00      10s

Client avec solde
        Execute JavaScript    window.scrollTo(0, 0)
      sleep    2s
      wait until element is visible       xpath=//*[@data-testid="archiver"]      10s
       click element      xpath=//*[@data-testid="archiver"]
       wait until page contains      Vous ne pouvez pas archiver un client avec un crédit supérieur à 0.      10s
Client sans solde
      Go To      https://app.pharma.sobrus.ovh/customer/514294/table
        sleep     2s
        wait until element is visible       xpath=//*[@data-testid="archiver"]      10s
       click element      xpath=//*[@data-testid="archiver"]
       wait until page contains    Archivé      10s
       wait until element is not visible      xpath=//*[@data-testid="payer_crédit_client"]       10s
       wait until element is not visible      id=exportStatment
       wait until element is not visible       id=quikactions

Restaurer le client
      wait until element is visible       xpath=//*[@data-testid="restaurer"]      10s
       click element      xpath=//*[@data-testid="restaurer"]
       wait until page contains      Actif     10s
       wait until element is visible      xpath=//*[@data-testid="payer_crédit_client"]       10s

Vérifier l'impression du relevé : type simple
       Go To     https://app.pharma.sobrus.ovh/customer/514394?from=sale
        sleep     2s
     wait until element is visible       css=#exportStatment      10s
    click element    css=#exportStatment
     wait until element is visible       xpath=//*[@data-testid="télécharger"]     10s
     # Save the first window
      ${windows}=    Get Window Handles
       ${main_window}=    Set Variable    ${windows}[0]
      click element       xpath=//*[@data-testid="télécharger"]

      Sleep    2s
      # Get all windows
      ${windows_after}=    Get Window Handles
       Switch Window    ${main_window}
    wait until page contains    Imprimer le relevé     10s

Vérifier l'impression du relevé : type avancé
     sleep    4s
     wait until element is visible    id=type       10s
    Click Element   id=type
     Wait Until Element Is Visible    css=div.sob-v2-container:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)     10s
     click element     css=.sob-v2-select__option:nth-child(2)
     wait until page contains      Afficher les détails     10s
      # Save the first window
      ${windows}=    Get Window Handles
       ${main_window}=    Set Variable    ${windows}[0]
      click element       xpath=//*[@data-testid="télécharger"]

      Sleep    2s
      # Get all windows
      ${windows_after}=    Get Window Handles
       Switch Window    ${main_window}

Vérifier l'option Modifier
     Go To     https://app.pharma.sobrus.ovh/customer/514394?from=sale
        sleep     2s
   wait until element is visible     id=quikactions     10s
   click element    id=quikactions
   wait until element is visible     xpath=//div[@data-testid="modifier"]      10s
   click element    xpath=//div[@data-testid="modifier"]
    sleep    1s
    wait until page contains       Modifier client : meryeme Compte de Teste AUTO     10s
     Définir le zoom du navigateur      60
     wait until element is visible     id=debit_limit
     input text     id=debit_limit      700
   click element      xpath=//*[@data-testid="\sauvegarder"]
    wait until page contains     Le client a été modifié avec succès      10s

Vérifier l'option Lier MySobrus
    sleep    2s
     wait until element is visible       css=.sob-v2-toastr__close      10s
     click element     css=.sob-v2-toastr__close
     sleep    7s
       wait until element is visible     id=quikactions      10s
   click element    id=quikactions
   wait until element is visible     xpath=//div[@data-testid="lier_le_client_à_son_compte_mysobrus"]    10s
   click element    xpath=//div[@data-testid="lier_le_client_à_son_compte_mysobrus"]
    wait until page contains      Entrer le code de vérification      10s
   wait until element is visible      id=verification_code      10s
   input text        id=verification_code      23874657
   click element      xpath=//*[@data-testid="valider"]
   wait until page contains     Could not link patient      10s
     click element    css=button.sob-v2-icon-btn:nth-child(2)

Vérifier l'option Ajouter un contact
       sleep    2s
     wait until element is visible       css=.sob-v2-toastr__close      10s
     click element     css=.sob-v2-toastr__close
    sleep     2s
      wait until element is visible     id=quikactions      10s
   click element    id=quikactions
   wait until element is visible     xpath=//div[@data-testid="créer_un_nouveau_contact"]    10s
   click element    xpath=//div[@data-testid="créer_un_nouveau_contact"]
    wait until element is visible     id=customer_name
    ${name}=    Get Value    id=customer_name
     Should Be Equal    ${name}    meryeme Compte de Teste AUTO

Vérifier l'option Ajouter un devis
      Go To     https://app.pharma.sobrus.ovh/customer/514394?from=sale
        sleep     2s
         wait until element is visible     id=quikactions      10s
   click element    id=quikactions
   wait until element is visible     xpath=//div[@data-testid="créer_un_nouveau_devis"]    10s
   click element    xpath=//div[@data-testid="créer_un_nouveau_devis"]
    wait until element is visible     id=customer_name
    ${name}=    Get Value    id=customer_name
     Should Be Equal    ${name}    meryeme Compte de Teste AUTO

Vérifier l'option Ajouter une facture
      Go To     https://app.pharma.sobrus.ovh/customer/514394?from=sale
        sleep     2s
         wait until element is visible     id=quikactions      10s
   click element    id=quikactions
   wait until element is visible     xpath=//div[@data-testid="créer_une_nouvelle_vente"]    10s
   click element    xpath=//div[@data-testid="créer_une_nouvelle_vente"]
    wait until element is visible     id=customer_name
    ${name}=    Get Value    id=customer_name
     Should Be Equal    ${name}    meryeme Compte de Teste AUTO

Vérifier l'option Payer plusieurs factures
   Go To     https://app.pharma.sobrus.ovh/customer/514394?from=sale
        sleep     2s
         wait until element is visible     id=quikactions      10s
   click element    id=quikactions
   wait until element is visible     xpath=//div[@data-testid="payer_ventes_non_soldées"]    10s
   click element    xpath=//div[@data-testid="payer_ventes_non_soldées"]
   wait until element is visible      xpath=//*[@data-testid="suivant"]    10s
   click element     xpath=//*[@data-testid="suivant"]
     Définir le zoom du navigateur      60
     sleep    2s
     unselect checkbox    css=div.sob-v2-checkbox-wrapper:nth-child(3) > span:nth-child(1) > input:nth-child(1)
     select checkbox    css=.sob-v2-card-content > div:nth-child(7) > div:nth-child(1) > span:nth-child(1) > input:nth-child(1)
     click element       xpath=//*[@data-testid="payer"]
     wait until page contains     Le paiement a été enregistré avec succès!     10s

Vérifier le paiement du crédit client
      sleep    2s
     wait until element is visible       css=.sob-v2-toastr__close      10s
     click element     css=.sob-v2-toastr__close
    sleep     2s
      wait until element is visible      xpath=//*[@data-testid="payer_crédit_client"]    10s
   click element     xpath=//*[@data-testid="payer_crédit_client"]
   wait until page contains     meryeme Compte de Teste AUTO     10s
   wait until element is visible     id=amount_paid
   input text    id=amount_paid     10
     click element     css=div.sob-v2-col-6:nth-child(1)
     wait until element is visible      xpath=//*[@data-testid="sauvegarder"]    10s
   click element     xpath=//*[@data-testid="sauvegarder"]
   wait until page contains      Le paiement a été enregistré avec succès!    10s
