*** Settings ***
Documentation     Tests fonctionnels de la page "Produits Espace_labo"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Produits Espace_labo

*** Variables ***
${ESPACE_LABO_PRODUITS_ID}      offers/supplier/1163/products
${PRODUIT_CARD}                  css=.sob-v2-marketplace-offer-product-card
${DECOUVRIR_BUTTON}              xpath=(//*[@data-testid="découvrir"])[1]
${SEARCH_INPUT}                  id=query
${REFRESH_BUTTON}                css=.sob-v2-tableHeader-btn
${SUBCATEGORY_HEADER}            css=.subcategorie__name
${PRODUCT_ROW}                    css=.product__container
${PRODUCT_NAME}                  xpath=(//*[@class="product__name"])[1]
${PRODUCT_PRICE}                 css=div.subcategorie__container:nth-child(3) > button:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2)
${MON_STOCK}                      xpath=(//*[@class="stock"])[1]
${FICHE_PRODUIT_BUTTON}             xpath=//*[@data-testid="fiche_produit"]
${OFFRE_TEST_HAMZA}              xpath=//*[@data-testid="test_hamza"]

*** Test Cases ***
Accéder à la page Produits Espace_labo
    Aller à la page Produits Espace_labo    ${ESPACE_LABO_PRODUITS_ID}

Vérifier l'affichage d'une produit card
    Vérifier l'affichage d'une produit card

Accéder à la sous-catégorie via le bouton Découvrir
    Accéder à la sous-catégorie via le bouton Découvrir

Vérifier l'affichage du header de sub category
    Vérifier l'affichage du header de sub category

Vérifier le bouton refresh
    Vérifier le bouton refresh

Vérifier l'affichage des infos produit de la sub category (titre, prix, mon stock)
    Vérifier l'affichage des infos produit de la sub category

Vérifier le click sur mon stock
    Vérifier le click sur mon stock

Vérifier le click sur fiche produit

    Vérifier le click sur fiche produit

Vérifier l'offre disponible : test hamza

    Vérifier l'offre disponible test hamza

*** Keywords ***
Aller à la page Produits Espace_labo
    [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the Espace_labo produits page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
    Wait Until Element Is Visible    ${PRODUIT_CARD}    timeout=30s

Vérifier l'affichage d'une produit card
    Wait Until Element Is Visible    ${PRODUIT_CARD}    10s
    Wait Until Element Is Visible    ${DECOUVRIR_BUTTON}    10s

Accéder à la sous-catégorie via le bouton Découvrir
    click element    ${DECOUVRIR_BUTTON}
    Wait Until Element Is Visible    ${SUBCATEGORY_HEADER}    10s
Set Browser Zoom
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"

Vérifier l'affichage du header de sub category
     Set Browser Zoom     40
      sleep     2s
    Wait Until Element Is Visible    ${SUBCATEGORY_HEADER}    10s
    sleep      1s

Vérifier le bouton refresh
    Wait Until Element Is Visible    ${REFRESH_BUTTON}    10s
    click element    ${REFRESH_BUTTON}
    sleep    1s
    Wait Until Element Is Visible    ${SUBCATEGORY_HEADER}    10s

Vérifier l'affichage des infos produit de la sub category
    Wait Until Element Is Visible    ${PRODUCT_NAME}    10s
    Wait Until Element Is Visible    ${PRODUCT_PRICE}    10s
    Wait Until Element Is Visible    ${MON_STOCK}    10s

Vérifier le click sur mon stock
    Wait Until Element Is Visible    ${MON_STOCK}    10s
    click element    ${MON_STOCK}
    sleep    1s
    Element Should Be Visible    ${PRODUCT_ROW}

Vérifier le click sur fiche produit
    ${handles_avant}    Get Window Handles
    Wait Until Element Is Visible    ${FICHE_PRODUIT_BUTTON}    10s
    click element    ${FICHE_PRODUIT_BUTTON}
    sleep    2s
    ${handles_apres}    Get Window Handles
    Should Be True    len($handles_apres) > len($handles_avant)
    Switch Window    NEW
    Wait Until Location Contains    /product/    10s
    Close Window
    Switch Window    MAIN

Vérifier l'offre disponible test hamza
     sleep     2s
    Wait Until Element Is Visible    ${OFFRE_TEST_HAMZA}    10s
    Wait Until Page Contains    Disponible sur :    10s
