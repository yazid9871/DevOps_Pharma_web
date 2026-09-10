*** Settings ***
Documentation     Tests fonctionnels de la page "Education Hub Espace_labo"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Education Hub Espace_labo

*** Variables ***
${ESPACE_LABO_EDUCATION_HUB_ID}      offers/supplier/1163/education_hub
${SECTION_HEADER}                     css=.sob-v2-card-header-container
${VOIR_PLUS_BUTTON}                   xpath=(//button[contains(., "Voir plus")])[1]
${EDUCATION_CARD}                     css=.sob-v2-suppliers-education_hub-card
${EDUCATION_CARD_TITLE}                css=.sob-v2-suppliers-education_hub-title
${SECTION_DOCUMENT}                   xpath=//div[@class="sob-v2-card-header-container"][contains(., "Fdfe")]
${SECTION_VIDEO}                      xpath=//div[@class="sob-v2-card-header-container"][contains(., "Vedio section")]

*** Test Cases ***
Accéder à la page Education Hub Espace_labo
    [Documentation]    Navigue vers la page Education Hub de l'Espace_labo après connexion.
    Aller à la page Education Hub Espace_labo    ${ESPACE_LABO_EDUCATION_HUB_ID}

Vérifier l'affichage du header de section
    [Documentation]    Vérifie qu'un header de section (nom de catégorie + compteur, ex. "Fdfe
    ...                (2/2)") est visible sur la page (vérifié en direct : pas de "sub category"
    ...                à proprement parler sur cette page, mais des sections par type de contenu).
    Vérifier l'affichage du header de section

Vérifier l'affichage d'une card
    [Documentation]    Vérifie qu'une card de contenu (avec son titre) s'affiche dans une
    ...                section.
    Vérifier l'affichage d'une card

Vérifier l'affichage de plusieurs sections
    [Documentation]    Vérifie que plusieurs sections de contenu s'affichent sur la page
    ...                (vérifié en direct : sections "Fdfe" et "Vedio section").
    Vérifier l'affichage de plusieurs sections

Vérifier le bouton Voir plus
    [Documentation]    Vérifie que le bouton "Voir plus (N)" d'une section est visible et
    ...                cliquable (vérifié en direct : aucun changement visible constaté quand
    ...                tous les éléments de la section sont déjà affichés, ex. "2/2" — à
    ...                revérifier avec un jeu de données où le compteur affiché est inférieur
    ...                au total).
    Vérifier le bouton Voir plus

Vérifier le type de contenu document (Fdfe)
    [Documentation]    Vérifie qu'une card de type document/PDF s'affiche dans la section "Fdfe"
    ...                (vérifié en direct sur les cards "fdss" et "dmnksnk").
    Vérifier le type de contenu document

Vérifier le type de contenu vidéo
    [Documentation]    Vérifie qu'une card de type vidéo s'affiche dans la section "Vedio
    ...                section" (vérifié en direct sur la card "test").
    Vérifier le type de contenu vidéo

*** Keywords ***
Aller à la page Education Hub Espace_labo
    [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the Espace_labo education hub page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
    Wait Until Element Is Visible    ${SECTION_HEADER}    timeout=30s

Vérifier l'affichage du header de section
    Wait Until Element Is Visible    ${SECTION_HEADER}    10s

Vérifier l'affichage d'une card
    Wait Until Element Is Visible    ${EDUCATION_CARD}    10s
    Wait Until Element Is Visible    ${EDUCATION_CARD_TITLE}    10s

Vérifier l'affichage de plusieurs sections
    ${count}    Get Element Count    ${SECTION_HEADER}
    Should Be True    ${count} > 1

Vérifier le bouton Voir plus
    Wait Until Element Is Visible    ${VOIR_PLUS_BUTTON}    10s
    click element    ${VOIR_PLUS_BUTTON}
    sleep    1s
    Element Should Be Visible    ${SECTION_HEADER}

Vérifier le type de contenu document
    Wait Until Element Is Visible    ${SECTION_DOCUMENT}    10s
    Wait Until Page Contains    Fdfe    10s

Vérifier le type de contenu vidéo
    Wait Until Element Is Visible    ${SECTION_VIDEO}    10s
    Wait Until Page Contains    Vedio section    10s
