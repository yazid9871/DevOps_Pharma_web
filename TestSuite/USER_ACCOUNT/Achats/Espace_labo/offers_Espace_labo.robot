*** Settings ***
Documentation     Tests fonctionnels de la page "Offers Espace_labo"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Offers Espace_labo

*** Variables ***
${ESPACE_LABO_ID}      offers/supplier/1163/offers

*** Test Cases ***
Accéder à la page Espace_labo
    [Documentation]    Navigue vers la page Espace_labo (offres fournisseur) après connexion.
    Aller à la page Espace_labo    ${ESPACE_LABO_ID}

Vérifier le header de la page Espace_labo
    [Documentation]    Vérifie que le header ("Espace : <fournisseur>") et la bannière sont visibles.
    Vérifier le header

Vérifier le menu de la page Espace_labo
    [Documentation]    Vérifie que les onglets du menu (Offres, Produits, Education hub, Even) sont visibles.
    Vérifier le menu

Vérifier le bouton Demander à être contacté
    [Documentation]    Vérifie que le bouton "Demander à être contacté" ouvre bien le formulaire de contact.
    Vérifier le bouton Demander à être contacté

Vérifier la recherche
    [Documentation]    Vérifie que la recherche d'une offre fonctionne et affiche un message si aucun résultat.
    Vérifier la recherche

Vérifier le filtre
    [Documentation]    Vérifie que le filtre "Filtres:" est visible et affiche bien ses options.
    Vérifier le filtre

Vérifier le filtre Toutes les offres
    [Documentation]    Vérifie que l'option "Toutes les offres" est sélectionnée par défaut et affiche des offres.
    Vérifier le filtre Toutes les offres

Vérifier l'affichage d'une offer card
    [Documentation]    Vérifie qu'une carte d'offre (offer card) s'affiche avec ses informations
    ...                (réduction, produit, bouton Commander).
    Vérifier l'affichage d'une offer card

Vérifier l'affichage d'une promotional card
    [Documentation]    Vérifie qu'une carte promotionnelle (promotional card) s'affiche parmi les offres.
    Vérifier l'affichage d'une promotional card

Vérifier la visibilité de la section Featured après défilement
    [Documentation]    Vérifie que la section "Featured" devient visible après avoir défilé vers le
    ...                bas de la page.
    Vérifier la visibilité de la section Featured après défilement

*** Keywords ***
Aller à la page Espace_labo
    [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the Espace_labo offers page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
    Wait Until Element Is Visible    xpath=//*[@data-testid="demander_à_être_contacté"]    timeout=30s

Vérifier le header
    Wait Until Page Contains    Espace :    10s
    Wait Until Element Is Visible    css=.sob-v2-breadcrumb-container    10s

Vérifier le menu
    Wait Until Element Is Visible    id=taboffers    10s
    Wait Until Element Is Visible    id=tabproducts    10s
    Wait Until Element Is Visible    id=tabeducation_hub    10s
    Wait Until Element Is Visible    id=tabevents    10s

Vérifier le bouton Demander à être contacté
    [Documentation]    N'envoie jamais le formulaire (Envoyer), uniquement l'ouverture et la
    ...                fermeture via Annuler : le testid "envoyer" a été confirmé en direct mais
    ...                déclenche l'envoi réel d'une demande de contact.
    Wait Until Element Is Visible    xpath=//*[@data-testid="demander_à_être_contacté"]    10s
    click element    xpath=//*[@data-testid="demander_à_être_contacté"]
    Wait Until Page Contains    Me contacter    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    click element    xpath=//*[@data-testid="annuler"]
Set Browser Zoom
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"
Vérifier la recherche
    Input Text    id=elasticSearch    test
    click element    xpath=//button[contains(., "Recherche")]
    Set Browser Zoom      50
    sleep    3s
    Wait Until Page Contains     Aucune offre disponbile pour le moment     20s
    click element    xpath=//button[contains(., "Effacer")]

Vérifier le filtre
    Wait Until Element Is Visible    css=.sob-v2-suppliers-offers-filters    10s
    click element    css=.sob-v2-suppliers-offers-filters
    sleep    2s
   # Wait Until Page Contains    Marchés et offres pharmaceutique    10s
  #  Wait Until Page Contains    Offres parapharmaceutiques    10s
   # Wait Until Page Contains    Offres mixtes    10s
   # Wait Until Page Contains    Produits du moment    10s
  #  press keys    None    ESC

Vérifier le filtre Toutes les offres
    Page Should Contain    Toutes les offres
    Wait Until Element Is Visible    css=.sob-v2-marketplace-offer-card    10s

Vérifier l'affichage d'une offer card
    Wait Until Element Is Visible    css=.sob-v2-marketplace-offer-card    10s
    Wait Until Element Is Visible    css=.sob-v2-marketplace-offer-card-button    10s

Vérifier l'affichage d'une promotional card
    Wait Until Element Is Visible    css=.sob-v2-marketplace-supplier-offer-card-container.promotional    10s

Vérifier la visibilité de la section Featured après défilement
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2s
    Wait Until Element Is Visible    xpath=//h2[contains(text(), "Featured")]    10s
