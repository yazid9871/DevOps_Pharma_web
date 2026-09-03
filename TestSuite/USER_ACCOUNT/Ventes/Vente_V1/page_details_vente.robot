*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Ventes"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Ventes

*** Variables ***


${save_payement}       xpath=//*[@data-testid="sauvegarder"]
${get_status}        css=.sob-v2-status-card__title
${ADD_BUTTON}        xpath=//*[@data-testid="créer"]
${other_action}       xpath=//div[@class='sob-breadcrumb__buttons']//button[@data-testid='false']
*** Test Cases ***
aller à la page de création de vente
    Accéder à la page    invoices

ajouter un paiement à la vente "non payé"
    cliquer sur l'icône paiement      Ajouter un paiement
       soumettre le formulaire avec des données invalides
     soumettre le formulaire avec des données valides

vérifier que le statut est "Partiellement payé"
    vérifier le statut "Partiellement payé"
     vérifier le tableau des paiements

ajouter un paiement et vérifier que le statut est "Complété"
   click sur ajouter un paiement
    Choisir un moyen de paiement "crédit" pour un client qui n'en dispose pas
    Choisir un autre moyen de paiement et soumettre
    vérifier le statut "Complété"

autre action / dupliquer
    vérifier les infos du duplicata
    mettre à jour le client et vérifier que le contact est vide
    annuler le client et vérifier que les remises sont annulées
     approuver la vente sans client
    Choisir un moyen de paiement sans montant
     Décocher livré
     Choisir un moyen de paiement avec montant
ajouter un paiement et vérifier que le statut est "payé"
    aller à la page détails
    vérifier le statut
autre action / livré
      autre action / livré
      vérifier que le statut est complété

annuler la vente et vérifier que le statut est "Annulé"
      cliquer sur annuler
      vérifier que le statut est annulé

*** Keywords ***

cliquer sur l'icône paiement
    [Arguments]    ${text}
  [Documentation]     click sur  l'icône Ajouter un paiement pour accéder à la page Ajouter un paiement
    wait until element is visible     xpath=//*[@data-testid="recherche"]     10s
    Click Button  ${SEARCH_BUTTON}
     wait until element is visible    ${CHAMP_STATUT_VENTE}     10s
     Click Element    ${CHAMP_STATUT_VENTE}
    Wait Until Element Is Visible  ${LISTE_DEROULANTE}    10s
     click element     css=.sob-v2-select__option:nth-child(3)
        sleep     5s
     Wait Until Element Is Visible   ${PAIMENT_ICON}    timeout=10s
    Click Element     ${PAIMENT_ICON}
    sleep    2s
     wait until page contains    ${text}      10s


soumettre le formulaire avec des données invalides
    sleep    10s
     ${input_ammount}  get value    css=#amount
       Should not Be Empty      ${input_ammount}
       input text      css=#amount    0
         click element     ${save_payement}
            sleep    5s
      wait until page contains      Le montant doit être supérieur à 0.      15s
         click element      xpath=//div[@class='sob-v2-toastr__icon']
        sleep     3s
soumettre le formulaire avec des données valides
     input text     css=#amount   1
     input text     xpath=//*[@id="ref"]      ref4
      sleep      5s
      click element     ${save_payement}
      wait until element is visible      css=.sob-v2-toastr__close     10s
      click element       css=.sob-v2-toastr__close

vérifier le statut "Partiellement payé"
     wait until page contains    Partiellement payé     10s
vérifier le tableau des paiements
       Execute JavaScript  window.scrollTo( 0, document.body.scrollHeight)
      wait until element is visible    xpath=/html/body/div[1]/div/div[4]/div/div/div/div[4]/div/div[1]/div[2]/div/div[2]/table    20s
      Execute JavaScript    window.scrollTo(0, 0)
      sleep    5s

click sur ajouter un paiement
      wait until element is visible       xpath=//*[@data-testid="ajouter_un_paiement"]     10s
      click element       xpath=//*[@data-testid="ajouter_un_paiement"]
     wait until page contains        Ajouter un paiement     20s


Choisir un moyen de paiement "crédit" pour un client qui n'en dispose pas
       wait until element is visible     id=payment_method_id
       click element      id=payment_method_id
      wait until element is visible    css=.sob-v2-select__option:nth-child(5)      10s
         click element      css=.sob-v2-select__option:nth-child(5)
         Execute JavaScript    window.scrollTo(0, 0)
           sleep     2s
          click element     ${save_payement}
          sleep      5s
           wait until page contains    Le client ne dispose pas d'un avoir suffisant pour cette opération.      10s
         click element      xpath=//div[@class='sob-v2-toastr__icon']
        sleep     3s
Choisir un autre moyen de paiement et soumettre
       click element   id=payment_method_id
      wait until element is visible       css=.sob-v2-select__option:nth-child(3)   5s
         click element     css=.sob-v2-select__option:nth-child(3)
         Execute JavaScript    window.scrollTo(0, 0)
         sleep     3s

         click element     ${save_payement}
        wait until element is visible      css=.sob-v2-toastr__close     10s
      click element       css=.sob-v2-toastr__close


vérifier le statut "Complété"
    wait until page contains     Complété      10s

vérifier les infos du duplicata
    wait until element is visible     ${other_action}     10s
   click element     ${other_action}
     wait until page contains     Dupliquer   20s
     wait until element is visible       xpath=//*[@data-testid="dupliquer"]       10s
    click element    xpath=//*[@data-testid="dupliquer"]
    wait until page contains     Créer une nouvelle vente   20s
mettre à jour le client et vérifier que le contact est vide
      click element       id=customer_name
    Wait Until Element Is Visible   xpath=//div[@id='root']/div[4]/div[2]/div/div[2]/table/tbody/tr       10s
    sleep    8s
    click element      xpath=//div[@id='root']/div[4]/div[2]/div/div[2]/table/tbody/tr
    sleep     5s
    ${contact_value}    get value   id=contact_name
      should be empty    ${contact_value}

annuler le client et vérifier que les remises sont annulées
      sleep     5s
      click element      css=.close__svg
      ${customer_value}    get value   id=customer_name
        should be empty    ${customer_value}
        click element    xpath=//*[@id="invoice_date"]
        sleep     5s
        click element     css=.react-datepicker__day--013
        sleep     10s
approuver la vente sans client
     click element    xpath=//div[@class='sob-breadcrumb__buttons']//button[@data-testid='false']
     #page payment
      wait until page contains    Total à payer par client   20s
Choisir un moyen de paiement sans montant
     input text     id=invoice_payment_amount     0
       click element     xpath=//button[@class='payment__card']
       sleep      5s
       wait until page contains    Vous devez choisir un client pour pouvoir faire une vente à crédit      5s
         click element      xpath=//div[@class='sob-v2-toastr__icon']
        sleep     3s

Décocher livré
     Checkbox Should Be Selected    xpath://input[@class='sob-v2-checkbox']
     Unselect Checkbox     xpath://input[@class='sob-v2-checkbox']
Choisir un moyen de paiement avec montant
      input text     id=invoice_payment_amount     160
aller à la page détails
    wait until element is visible     xpath=/html/body/div[1]/div[4]/div/div[3]/div/div/div[3]/div[1]/div[1]/div[1]/div/button  25s
     click element    xpath=/html/body/div[1]/div[4]/div/div[3]/div/div/div[3]/div[1]/div[1]/div[1]/div/button
vérifier le statut
         wait until element is visible    xpath=/html/body/div[1]/div[4]/div/div/div[4]/div/div[2]/div[1]/div/p        15s
       ${statu}    get text    xpath=/html/body/div[1]/div[4]/div/div/div[4]/div/div[2]/div[1]/div/p
    should be equal    ${statu}     Payé

autre action / livré
       click element       css=.sob-v2-btn-secon
    wait until element is visible   xpath=/html/body/div[2]/div/div/div[2]/div[9]/div[1]/div/button   15s
    click element     xpath=/html/body/div[2]/div/div/div[2]/div[9]/div[1]/div/button
     wait until page contains    Êtes-vous sûr ?    20s
     click element      aria-label=Oui
vérifier que le statut est complété
      sleep    5s
       wait until element is visible    xpath=/html/body/div[1]/div[4]/div/div/div[4]/div/div[2]/div[1]/div/p        15s
       ${statu}    get text    xpath=/html/body/div[1]/div[4]/div/div/div[4]/div/div[2]/div[1]/div/p
    should be equal    ${statu}     Complété

cliquer sur annuler
    click element      xpath=/html/body/div[1]/div[4]/div/div/div[3]/div[2]/button[1]
     wait until element is visible      xpath=//*[@data-testid="oui"]
     click element      xpath=//*[@data-testid="oui"]
     wait until element is visible     xpath=//*[@id="security_code"]    20s
     input text      xpath=//*[@id="security_code"]    ${PASSWORD}
     click element        xpath=//*[@data-testid="confirmez"]

vérifier que le statut est annulé
      sleep    5s
         wait until element is visible    xpath=/html/body/div[1]/div[4]/div/div/div[4]/div/div[2]/div[1]/div/p        15s
       ${statu}    get text    xpath=/html/body/div[1]/div[4]/div/div/div[4]/div/div[2]/div[1]/div/p
    should be equal    ${statu}     Annulé
