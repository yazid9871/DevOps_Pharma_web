*** Settings ***
Documentation     Tests fonctionnels de la page "Assistant Marketplace"
Library           SeleniumLibrary
Resource          ../../../Resources/Authentification_Admin.robot
Resource          ../../../Resources/MotsClesCommuns.robot
Resource          ../../../Resources/Variables.robot
Resource            ../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Assistant Marketplace

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
#${USERNAME}  ovhtest1@sobrus.com
#${PASSWORD}  123456hc
${USERNAME}  meryeme.e@sobrus.com
${PASSWORD}  qw067012@
${lets_go}        xpath=//*[@data-testid="c'est_parti"]


*** Test Cases ***
aller sur la page de création d'achat
    [Documentation]    Vérifie la navigation
    Aller sur la page de liste des assistants du marketplace
    cliquer sur 90 jours et cliquer sur suivant

tester l'ajout au panier
    tester l'ajout au panier
vérification du résultat
    vérifier le panier et finaliser la commande
fermer la commande ajouter un mode de paiement et vérifier le résultat
    ajouter un mode de paiement


*** Keywords ***
Set Browser Zoom
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"
Aller sur la page de liste des assistants du marketplace
    [Documentation]    Navigate to the Marketplace Assistant listing page after login in.
  wait until element is visible     id=assistant_btn
  click element    id=assistant_btn
  sleep     2s
   wait until element is visible      ${lets_go}    timeout=15s
   click element     ${lets_go}
   wait until page contains    Assistant Marketplace
   sleep     2s
cliquer sur 90 jours et cliquer sur suivant
    Wait Until Element Is Visible    xpath=//input[@class='marketplace_assistant__slider']     10s
    Execute Javascript
    ...    var slider = document.evaluate("//input[@class='marketplace_assistant__slider']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    if(slider) { slider.value = 75; slider.dispatchEvent(new Event('change')); }
    click element     xpath=//*[@data-testid="suivant"]
    wait until element is visible     css=.supplier__card
tester l'ajout au panier
     wait until element is visible    css=button.sob-v2-btn:nth-child(2)
  click element     css=button.sob-v2-btn:nth-child(2)
   Set Browser Zoom    30
          sleep    2s
  wait until element is visible     css=div.supplier__offer__card:nth-child(1) > div:nth-child(4) > div:nth-child(1) > button:nth-child(2)
  click element    css=div.supplier__offer__card:nth-child(1) > div:nth-child(4) > div:nth-child(1) > button:nth-child(2)

  #input text
  wait until element is visible     css=.input__maxQuantity > div:nth-child(1) > div:nth-child(2) > input:nth-child(1)
  input text     css=.input__maxQuantity > div:nth-child(1) > div:nth-child(2) > input:nth-child(1)     100
  input text     css=#product__error104867 > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(2) > input:nth-child(1)       200
  input text     xpath=/html/body/div/div/div[5]/div/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[4]/div[2]/div[1]/div[3]/div[3]/div/div[3]/div/div[1]/input     200
  sleep    1s
  click element     css=div.supplier__offer__card:nth-child(1) > div:nth-child(3) > button:nth-child(2)
  wait until element is visible     css=.selected__card__body__container
vérifier le panier et finaliser la commande
  wait until page contains    3,354.00       10s
  wait until page contains     500       10s
    wait until element is visible        xpath=//*[@data-testid="finaliser_la_commande"]     10s
    click element      xpath=//*[@data-testid="finaliser_la_commande"]
ajouter un mode de paiement
    wait until element is visible     css=.sob-v2-select__single-value
    #add comment
    click element      xpath=//*[@data-testid="ajouter_un_commentaire"]
    wait until element is visible    css=.sob-v2-form-control
    input text   css=.sob-v2-form-control   test comment
    click element      xpath=//*[@data-testid="passer_commande"]
