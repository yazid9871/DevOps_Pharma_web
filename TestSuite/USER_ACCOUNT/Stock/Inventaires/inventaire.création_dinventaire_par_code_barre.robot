
*** Settings ***
Documentation     Tests fonctionnels de la 'Création d’un inventaire par code-barres."
Library           SeleniumLibrary
Library    Collections

Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags       Création d’un inventaire par code-barres.


*** Variables ***

${save-inventaire-CD}      xpath=//*[@data-testid="sauvegarder"]
${ecart_total}        xpath=/html/body/div[1]/div/div[1]/div[5]/div/div/div[2]/div/div[1]/div[1]/div[2]/div/div[2]/span
${ecart_product_A}        xpath=/html/body/div[1]/div/div[1]/div[5]/div/div/div[2]/div/div[1]/div[2]/div/div/div/div/div[2]/table/tbody/tr[1]/td[4]
${ecart_product_B}        xpath=/html/body/div[1]/div/div[1]/div[5]/div/div/div[2]/div/div[1]/div[2]/div/div/div/div/div[2]/table/tbody/tr[2]/td[4]
${qte_stock}        xpath=/html/body/div[1]/div/div[1]/div[5]/div/div/div[2]/div/div[1]/div[2]/div/div/div/div/div[2]/table/tbody/tr[1]/td[2]
${qye_reell}        xpath=/html/body/div[1]/div/div[1]/div[5]/div/div/div[2]/div/div[1]/div[2]/div/div/div/div/div[2]/table/tbody/tr[1]/td[3]
@{comment_date}
${date}
${comment}
#${zone_select2}    id=zone_id
${zone_select}       id=react-select-10-input

*** Test Cases ***
accède à la page de création d'inventaire.
     [Tags]
    Open Browser  ${BASE_URL}  Firefox
    Se connecter avec des identifiants valides
    Accéder à la page inventaire
    Accéder à la page de création d'un inventaire
choisis methode code bare
     choisis une date d'inventaire
     ajoute un Commentaire
     clique sur le bouton "suivant"
     Vérifier que les champs Commentaire et Date sont correctement remplis et valides
ajouter produit par code-barres
      entre un code barres invalide pour un produit
      Ajouter un produit par code-barres     6118000022480
       verifier l'affichage de produit
        Ajouter un produit par code-barres    3701069901037
Modification de la zone et du stock avec des valeurs valid
     Changer la zone
     Modifier le stock min et max avec une valeur valid
     enregistrer l'inventaire
Vérifier les détails d'un inventaire
    Sur la page des détails : vérifier que l'inventaire a été créé avec succès
    Vérifier le statut de l'inventaire : Brouillon
    vérifier les détails de l'inventaire (écart total, calcule de l'ecart, etc.)
Modifier les produits d'un inventaire
   Sur la page des détails : cliquer sur l'icône de modification (crayon) d'un produit
   Modifier les informations du produit
    #enregistrer l'inventaire
   Vérifier le total de l'écart après la modification de la quantité réelle
Supprimer un produit de l'inventaire
   Sur la page des détails : cliquer sur l'icône de suppression
   Vérifier que la suppression a été effectuée avec succès

Modifier un inventaire
   Sur la page des détails : cliquer sur le bouton Modifier
   Vérifier que les champs Commentaire et Date sont correctement remplis et valides
    Augmenter la quantité d'un produit existant
     Ajouter un produit par code-barres     6118000022480
      enregistrer l'inventaire
Dupliquer un inventaire avec des produits déjà existants dans un inventaire brouillon
   Sur la page des détails avec des produits déjà existants : cliquer sur le bouton Dupliquer
   Vérifier l'affichage d'un message d'erreur approprié
Annuler un inventaire
   Sur la page des détails : cliquer sur le bouton Annuler
   Valider que l'annulation a été effectuée avec succès
Dupliquer un inventaire
   Sur la page des détails : cliquer sur le bouton Dupliquer
   Vérifier l'affichage d'un message de succès : l'inventaire a été dupliqué avec succès

Approuver un inventaire
   Sur la page des détails : cliquer sur le bouton Approuver
   qu'un message de succès est affiché : "Inventaire approuvé avec succès"


verify que apres 6 minute l'invetaire enregistre auto
       Accéder à la page inventaire
    Accéder à la page de création d'un inventaire
        clique sur le bouton "suivant"
         Ajouter un produit par code-barres     6118000022480
        sleep    300s
        verify que l'inventaire a ete enregistre comme Brouillon
Annuler les inventaires en brouillon
           Accéder à la page inventaire
           annuler
*** Keywords ***
Se connecter avec des identifiants valides
      [Documentation]    Log in with valid username and password.
     Wait Until Element Is Visible    css:button[type="submit"]     timeout=15s
     Click Button  css:button[type="submit"]
      Wait Until Element Is Visible     xpath=//input[@id='login']     timeout=5s
     Input Text  xpath=//input[@id='login']   ${USERNAME}
     Click Button  css:button[type="submit"]
     Wait Until Element Is Visible    css:input[name="password"]    timeout=5s
     input password    css:input[name="password"]  ${PASSWORD}
     Click Button  css:button[type="submit"]
     Wait Until Element Is Visible    xpath=//button[@type = 'button' and (text() = 'Passer' or . = 'Passer')]   timeout=5s
     Click Button    xpath=//button[@type = 'button' and (text() = 'Passer' or . = 'Passer')]
      Wait Until Element Is Visible    css=#breadcrumb-title    timeout=5s

Accéder à la page inventaire
    [Documentation]    Navigate to the inventaire listing page after logging in.
    Go To    ${BASE_URL}/stock/stocktakes
    Wait Until Element Is Visible      xpath=//*[@data-testid="créer"]      timeout=30s

Accéder à la page de création d'un inventaire
    click element     xpath=//*[@data-testid="créer"]
     wait until page contains    Créer un nouvel inventaire     5s

choisis une date d'inventaire
    click element    id=date
    wait until element is visible     css=.sob-v2-select-today
    click element    css=.react-datepicker__day--014
ajoute un Commentaire
    input text       id=comment       Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus.
clique sur le bouton "suivant"
        ${commente}   get value      id=comment
         ${date}   get value       id=date
           set Global variable   ${date}    ${date}
            set Global variable   ${comment}    ${commente}
     click element      xpath=//*[@data-testid="suivant"]
     wait until page contains     Modifier inventaire     5s
entre un code barres invalide pour un produit
     input text       id=barcode      524514511542
      Press Keys     id=barcode     ENTER
     wait until page contains    Le produit est introuvable. Voulez-vous suggérer sa création ?     5s
     click element      xpath=//*[@data-testid="annuler"]
Ajouter un produit par code-barres
       [Arguments]     ${CODE_BARRE}
       input text       id=barcode     ${CODE_BARRE}
        Press Keys     id=barcode     ENTER
verifier l'affichage de produit
      wait until element is visible     css=.selectedProducts__rowpair   10s
Changer la zone
      click element    xpath=//*[@id="react-select-9-input"]
      wait until element is visible       xpath=//*[@id="react-select-9-option-2"]
      click element        xpath=//*[@id="react-select-9-option-2"]
Modifier le stock min et max avec une valeur valid
    input text     xpath=/html/body/div[1]/div/div[1]/div[5]/div/div[2]/div/div[2]/div/div/div[2]/div[2]/div/div[2]/div/div/input     2
    input text      xpath=/html/body/div[1]/div/div[1]/div[5]/div/div[2]/div/div[2]/div/div/div[2]/div[2]/div/div[3]/div/div/input     13
enregistrer l'inventaire
    click element    ${save-inventaire-CD}

Sur la page des détails : vérifier que l'inventaire a été créé avec succès
    wait until page contains      Détails de l'inventaire     5s
Vérifier le statut de l'inventaire : Brouillon
      wait until page contains   Brouillon
vérifier les détails de l'inventaire (écart total, calcule de l'ecart, etc.)
      ${ecart_total1}   get text     ${ecart_total}
     ${ecart_product_A1}   get text    ${ecart_product_A}
     ${ecart_product_B1}    get text    ${ecart_product_B}
     ${qte_stock1}        get text   ${qte_stock}
     ${qye_reell1}        get text     ${qye_reell}


        ${excepted_result}    evaluate    ${qye_reell1} - ${qte_stock1}
         ${cleaned_var1}=   Convert To Number     ${ecart_product_A1}
        ${cleaned_var2}=    Convert To Number     ${ecart_product_B1}
         ${excepted_result_total}=    Evaluate    ${cleaned_var1} + ${cleaned_var2}

        Should Be Equal As Integers    ${excepted_result}     ${ecart_product_A1}
       Should Be Equal As Integers     ${ecart_total1}     ${excepted_result_total}


Sur la page des détails : cliquer sur l'icône de modification (crayon) d'un produit
     click element    id=edit
      wait until page contains    Modifier le stock de l'inventaire     5s
Modifier les informations du produit
     #stock
     ${qte_stock1}        get text   ${qte_stock}
     ${qte_stock_nb} =   Convert To Number    ${qte_stock1}
     input text     id=actual_quantity      ${qte_stock_nb}
       #date
       click element    id=expiry_date
       wait until element is visible      css=.react-datepicker__day--017     10s
       click element    css=.react-datepicker__day--017
       #zone
       click element  ${zone_select}
       wait until element is visible      css=.sob-v2-select__option:nth-child(2)
       click element      css=.sob-v2-select__option:nth-child(2)
       #stock min et max
        input text     id=min_stock    2
        input text      id=min_stock      20
       #save
        click element     xpath=/html/body/div[3]/div/div/div[3]/button[2]
        sleep    2s
Vérifier le total de l'écart après la modification de la quantité réelle
       ${ecart_product_A1}   get text    ${ecart_product_A}
        Should Be Equal As Integers      ${ecart_product_A1}    0
Sur la page des détails : cliquer sur l'icône de suppression
     click element     id=delete
Vérifier que la suppression a été effectuée avec succès
    wait until page contains    Etes-vous sûr de vouloir faire effectuer cette action, les modifications seront définitives !      5s
     click element    css=button.sob-v2-btn-block:nth-child(1)
    wait until page contains     Le produit a été supprimé avec succès.     5s
    sleep    1s
    click element     css=.sob-v2-toastr__icon
    sleep    1s
Sur la page des détails : cliquer sur le bouton Modifier
    click element     css=button.sob-v2-btn-primary:nth-child(4)
    wait until element is visible    css=textarea.sob-v2-form-control    5s
    sleep    1s
Vérifier que les champs Commentaire et Date sont correctement remplis et valides
       ${commente}   get value     css=textarea.sob-v2-form-control
         ${date}   get value     css=.DatePicker__input
       should contain     ${comment}     ${commente}
      should contain    ${date}       ${date}
Augmenter la quantité d'un produit existant
     click element     css=div.td:nth-child(2)
     sleep    1s
     input text   xpath=/html/body/div[1]/div/div[1]/div[5]/div/div[2]/div/div[2]/div/div/div[3]/div[2]/div/div/div/div[2]/div[1]/div[2]/div/div/input    2

Sur la page des détails avec des produits déjà existants : cliquer sur le bouton Dupliquer
       wait until element is visible     xpath=//*[@data-testid="dupliquer"]    10s
     click element      xpath=//*[@data-testid="dupliquer"]
Vérifier l'affichage d'un message d'erreur approprié
       wait until page contains     Êtes-vous sûr ?    5s
       click element     xpath=//*[@data-testid="oui"]
       wait until element is visible     xpath=/html/body/div[1]/div/div[1]/div[1]/div/div/div[1]/div/div/div[1]     5s
      click element      xpath=/html/body/div[1]/div/div[1]/div[1]/div/div/div[1]/div/div/div[1]
     sleep    8s
     click element      xpath=/html/body/div[3]/div/div/div[3]/button[2]

Sur la page des détails : cliquer sur le bouton Annuler
      click element     xpath=//*[@data-testid="annuler"]
         wait until page contains     Êtes-vous sûr ?     5s
    click element       xpath=//*[@data-testid="oui"]
    sleep     2s
    #pop up code security
    wait until element is visible     id=security_code
    input text      id=security_code     qw067012@
    click element    xpath=//*[@data-testid="confirmez"]
Valider que l'annulation a été effectuée avec succès
     wait until page contains   Annulé

Sur la page des détails : cliquer sur le bouton Dupliquer
     click element      xpath=//*[@data-testid="dupliquer"]
     wait until page contains     Êtes-vous sûr ?     5s
    click element       xpath=//*[@data-testid="oui"]
Vérifier l'affichage d'un message de succès : l'inventaire a été dupliqué avec succès
     wait until page contains     Détails de l'inventaire      5s

Sur la page des détails : cliquer sur le bouton Approuver
    wait until element is visible       xpath=//*[@data-testid="approuver"]     5s
    click element       xpath=//*[@data-testid="approuver"]
     wait until page contains     Êtes-vous sûr ?     5s
    click element       xpath=//*[@data-testid="oui"]
qu'un message de succès est affiché : "Inventaire approuvé avec succès"
      wait until page contains   Complété


verify que l'inventaire a ete enregistre comme Brouillon
       Accéder à la page inventaire
       click element    xpath=/html/body/div[1]/div/div[1]/div[6]/div[2]/div/div[2]/table/tbody/tr[1]
             wait until page contains   Brouillon

annuler
      click element     xpath=//*[@data-testid="annuler"]
         wait until page contains     Êtes-vous sûr ?     5s
    click element       xpath=//*[@data-testid="oui"]
    sleep     2s
    #pop up code security
    wait until element is visible     id=security_code
    input text      id=security_code     qw067012@
    click element    xpath=//*[@data-testid="confirmez"]