*** Settings ***
Documentation     Keywords pour tester la pagination d'un tableau
Library           SeleniumLibrary
Resource          Variables.robot


*** Variables ***
${SPAN_LOCATOR}     css=.sob-v2-TablePage
${PREVIOUS_BUTTON}    css=button.sob-v2-TablePage__btn:nth-child(1)
${NEXT_BUTTON}       css=button.sob-v2-TablePage__btn:nth-child(3)
${counter}    1
${SUPPLIER_NAME}    Fournis_Test
${REF}      jefgeugd


*** Keywords ***
# --- Pagination  ---
Tester Page Initiale
    [Documentation]    Vérifie que la page 1 est affichée par défaut et que le bouton précédent est désactivé
    Sleep    2s
    Execute JavaScript    window.scrollTo( 0, document.body.scrollHeight)
    Sleep    10s
    Wait Until Element Is Visible    css=.sob-v2-TablePage    10s
    ${current_page}=    Get Text    ${SPAN_LOCATOR}
    Should Be Equal    ${current_page}    1
    ${previous_button_state}=    Get Element Attribute    ${PREVIOUS_BUTTON}    disabled
    Should Be Equal    '${previous_button_state}'    'true'
    Set Suite Variable    ${counter}    1

Tester Clic Sur Bouton Suivant
    [Documentation]    Vérifie que le clic sur "suivant" incrémente bien le numéro de page
    Sleep    2s
    FOR    ${i}    IN RANGE    1    2
        Click Element    ${NEXT_BUTTON}
        Sleep    1s
        ${current_page}=    Get Text    ${SPAN_LOCATOR}
        ${counter}=    Evaluate    ${counter} + 1
        Set Suite Variable    ${counter}
        Should Be Equal As Strings    ${current_page}    ${counter}
    END

Tester Clic Sur Bouton Précédent
    [Documentation]    Vérifie que le clic sur "précédent" ramène bien à la page 1
    Click Element    ${PREVIOUS_BUTTON}
    Sleep    2s
    ${current_page}=    Get Text    ${SPAN_LOCATOR}
    Should Be Equal As Strings    ${current_page}    1
# --- navigation  ---

Accéder à la page
     [Arguments]    ${URL_MODULE}
    Go To    ${BASE_URL}/${URL_MODULE}
    sleep    1s
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s


# ---     Bouton créer---
Vérifier Bouton créer / Suggérer
      [Arguments]    ${button}  ${text}    ${URL_MODULE}
       sleep    1s
    Wait Until Element Is Visible    ${button}    timeout=10s
      click element     ${button}
      wait until page contains     ${text}    10s
       Go To    ${BASE_URL}/${URL_MODULE}
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s
# --- Icône éditer    client    / fourniseur ---
Vérifier Visibilité Icône Éditer
    [Documentation]    vérifier que l'icône d'édition est visible sur chaque ligne
    Wait Until Element Is Visible    ${EDIT_ICON}   timeout=10s

Vérifier Fonctionnalité Icône Éditer
    [Documentation]    vérifier que le clic sur l'icône d'édition ouvre bien le formulaire client
     [Arguments]    ${text}     ${URL_MODULE}
    Click Element      ${EDIT_ICON}
    sleep    2s
     wait until page contains    ${text}     10s
      Go To    ${BASE_URL}/${URL_MODULE}
      sleep    2s
     Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s

# --- Icône  Envoyer Message ---
Vérifier Visibilité Icône Envoyer Message
    [Documentation]    Vérifie que l'icône d'envoi de message est visible
    Wait Until Element Is Visible   ${ICONE_ENVOYER_MESSAGE}    timeout=10s

Vérifier Fonctionnalité Icône Envoyer Message
    [Documentation]    Vérifie que l'icône d'envoi de message permet d'accéder à la fonctionnalité d'envoi
    Click Element     ${ICONE_ENVOYER_MESSAGE}
    sleep    2s
     wait until page contains   Envoyer une communication à test  10s
      Go To    ${BASE_URL}/customers
      sleep    2s
     Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s

Cliquer Sur Rechercher Pour Afficher Le Champ
    [Documentation]    Clique sur le bouton Rechercher et vérifie que le champ de recherche est visible
    wait until element is visible     xpath=//*[@data-testid="recherche"]     10s
    Click Button  ${SEARCH_BUTTON}

Cliquer Sur Actualiser
    [Documentation]    Clique sur le bouton Actualiser pour réinitialiser ou actualiser la page
     Click Button  ${REFRESH_BUTTON}
# --- Icône Imprimer ---
Vérifier Icône Imprimer
      [Documentation]    vérifier que le clic sur l'icône Imprimer ouvre bien le formulaire
    # [Arguments]    ${text}     ${URL_MODULE}
      [Arguments]       ${URL_MODULE}
    Click Element      ${ICONE_IMPRIMER}
    sleep    2s
    # wait until page contains    ${text}     10s
      Go To    ${BASE_URL}/${URL_MODULE}
      sleep    2s
     Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s

# --- Icône Imprimer ---
VérifierL'Icône Éditer
  [Arguments]    ${text}     ${URL_MODULE}
  [Documentation]    Vérifie que l'icône Éditerpermet d'accéder à la fonctionnalité Éditer
     wait until element is visible     xpath=//*[@data-testid="recherche"]     10s
    Click Button  ${SEARCH_BUTTON}
     Click Element    ${CHAMP_STATUT_VENTE}
    Wait Until Element Is Visible  ${LISTE_DEROULANTE}    10s
     click element     css=.sob-v2-select__option:nth-child(2)
        sleep     5s
     Wait Until Element Is Visible   ${EDIT_ICON}    timeout=10s
    Click Element     ${EDIT_ICON}
    sleep    2s
     wait until page contains    ${text}      10s
      Go To    ${BASE_URL}/${URL_MODULE}
      sleep    2s
     Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s
      wait until element is visible           ${BOUTON_FERMER_RECHECHE}
      click element         ${BOUTON_FERMER_RECHECHE}
      wait until element is visible     ${SEARCH_BUTTON}

# --- Icône Ajouter un paiement  ---
VérifierL'Icône Ajouter un paiement
  [Arguments]    ${text}     ${URL_MODULE}
  [Documentation]    Vérifie que l'icône Ajouter un paiement permet d'accéder à la fonctionnalité Ajouter un paiement
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
      Go To    ${BASE_URL}/${URL_MODULE}
      sleep    2s
     Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s
     wait until element is visible           ${BOUTON_FERMER_RECHECHE}
      click element         ${BOUTON_FERMER_RECHECHE}
      wait until element is visible     ${SEARCH_BUTTON}


#****************** page details ****************8*** Keywords ***
Sélectionner des produits
      click element    ${loop_button}
       sleep  3s
        FOR  ${row}  IN RANGE  1    4
        ${col}    set variable    [${row}]/td[1]
        ${xpath_tab}    set variable     ${table}${col}
       click element     xpath=${xpath_tab}
       sleep    1s
      END

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
Vérifier que la section et le button creer sont visibles
      [Arguments]    ${module_sur_menu}     ${id_module_sur_menu}   ${text}     ${BOUTON_CREER_CONTACT_FOURNISSEUR}
      Faire défiler jusqu'à l'élément par texte    ${module_sur_menu}
      click element    ${id_module_sur_menu}
      sleep    3s
     Wait Until Element Is Visible       xpath=//*[@data-testid="créer"]    10s

       Wait Until Element Is Visible       ${BOUTON_CREER_CONTACT_FOURNISSEUR}      10s
     sleep     3s
     #button creer contact
     click element        ${BOUTON_CREER_CONTACT_FOURNISSEUR}
     wait until page contains   ${text}     10s
Vérifier que la section est visible
     [Arguments]    ${module_sur_menu}     ${id_module_sur_menu}
      Faire défiler jusqu'à l'élément par texte    ${module_sur_menu}
      click element    ${id_module_sur_menu}
      sleep    1s

vérifier que le fournisseur sélectionné est correct
     [Arguments]    ${CHAMP}    ${SUPPLIER_NAME}     ${SUPPLIER_ID}
    wait until element is visible    ${CHAMP}
    wait until page contains    ${SUPPLIER_NAME}

Ajouter des produits et soumettre
         [Arguments]     ${SUPPLIER_ID}      ${text}
     Sélectionner des produits
     ${is_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible   id=delivery_reference   timeout=3s
     IF    ${is_visible}
      input text      id=delivery_reference      ${REF}
     END

     wait until element is visible    ${BOUTON_APPROUVER}
     click element    ${BOUTON_APPROUVER}
     wait until page contains      ${text}
       Go To    ${BASE_URL}/${SUPPLIER_ID}
      sleep     2s


select supplier
   [Arguments]    ${search_text}

     Wait Until Element Is Visible    id=supplier_id    15s
     Click Element    id=supplier_id
     ${input_selector}=    Set Variable    css=#supplier_id .sob-v2-select__input

     Wait Until Element Is Visible    ${input_selector}    5s
    Press Keys    ${input_selector}    ${search_text}
    Sleep    2s
     Press Keys    ${input_selector}    RETURN
