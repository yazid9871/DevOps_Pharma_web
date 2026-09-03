*** Settings ***
Documentation     Tests fonctionnels de la page "Page de création de Préparations :verify_calcule_de_discount"
Library           SeleniumLibrary
Library    Collections

Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page de création de Préparations: verify_calcule_de_discount

*** Variables ***


${ADD_BUTTON}        xpath=//*[@data-testid="créer"]
${Gestionnaire}        css=.sob-v2-navbar-user-fullName
${draft_button}      xpath=//*[@data-testid="brouillon"]
${table}           //tbody[contains(@class, 'prevent-select')]//tr
${SEARCH_FIELD_CODEBARRE}      xpath=//*[@id="barcode"]
${REMISE_BUTTON}         xpath=//div[@class='text']//button[@data-testid='false']
${DISCOUNT_INPUT}        id=global_discount
${TYPE_SELECT}       id=global_discount_type
${DISCOUNT_SELECT}     id=global_discount_application_type
${DISCOUNT_SUBMITE}         xpath=//*[@data-testid="appliquer"]
${table2}                 //table[contains(@class, 'sob-v2-table')]//tbody//tr
@{PU_LIST}
${total_pay}        css=.selectedPrducts__total--payment > p:nth-child(2) > span:nth-child(1)

*** Test Cases ***
aller à la page de création de Préparations

    Aller à la page de liste des Préparations
    aller à la page de création de Préparations


Sélectionner des produits
    Sélectionner des produits    8009004800229
    Sélectionner des produits      5903205740977
vérifier la remise par produit (type % )
    ouvrir le popup remise
    remise par produit
    soumettre la remise
    vérifier la remise par produit %
vérifier la remise par montant produit (type % )
    ouvrir le popup remise
     remise par montant produit %
vérifier la remise par rectification du total
    ouvrir le popup remise
     remise par rectification du total
annuler la remise
    ouvrir le popup remise
    annuler la remise
    soumettre la remise
vérifier la remise par produit type montant
    ouvrir le popup remise
    remise par produit ( type montant )
    remise par produit
    soumettre la remise
    vérifier la remise par produit type montant

vérifier la remise par montant produit type montant
    ouvrir le popup remise
     remise par montant produit type montant
*** Keywords ***

Aller à la page de liste des Préparations
    [Documentation]    Naviguer vers la page de liste après connexion.
    Go To    ${BASE_URL}/preparations
   wait until element is visible      ${ADD_BUTTON}    timeout=15s
aller à la page de création de Préparations
    click element    ${ADD_BUTTON}
     Wait Until Element Is Visible   ${draft_button}  timeout=30s



Sélectionner des produits
     [Arguments]     ${product1}
    Input Text    ${SEARCH_FIELD_CODEBARRE}    ${product1}
    Press Keys    ${SEARCH_FIELD_CODEBARRE}    RETURN
    sleep    2s
       ${col}    set variable       [2]/td[3]
          ${xpath_tab}    set variable     ${table2}${col}
          ${product_ppv_from_list}  get text   xpath=${xpath_tab}
        Append To List    ${PU_LIST}    ${product_ppv_from_list}
ouvrir le popup remise
    click element   ${REMISE_BUTTON}
    wait until page contains    Remise globale    10s
remise par produit
    input text    ${DISCOUNT_INPUT}     10
soumettre la remise
      click element   ${DISCOUNT_SUBMITE}
      sleep    2s
vérifier la remise par produit %
    ${table_rows}  Get Element Count      xpath=${table2}
        Should Be True  ${table_rows} > 0
        FOR  ${row}  IN RANGE  2    ${table_rows} + 1    7
             ${col}    set variable    [${row}]/td[3]/span[1]
          ${xpath_tab}    set variable     ${table2}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
           @{result_list}    Create List
           ${list_length}=    Get Length    ${PU_LIST}
           FOR  ${index}  IN RANGE    0   ${list_length}
              ${value}  Get From List    ${PU_LIST}  ${index}
              ${value_num}    Evaluate    float('${value}'.strip().replace(',', '.'))
               ${result}     Evaluate     format(round( ${value_num} - (( ${value_num} * 10) / 100) , 2), ".2f").replace('.', ',')
               append To List    ${result_list}    ${result}
            END

           Should Contain  ${result_list}  ${cell_text}  in
        END
remise par montant produit %
           ${tota}    get text    ${total_pay}
          ${tota_num}    Evaluate    float('${tota}'.strip().replace(',', '.'))
          ${result}     Evaluate     format(round( ${tota_num} - (( ${tota_num} * 10) / 100) , 2), ".2f").replace('.', ',')
        ${t}      set variable     ${result}
        click element    ${discount_select}
        sleep    2s
      click element       css=.sob-v2-select__option:nth-child(2)
      sleep    2s
      input text    ${DISCOUNT_INPUT}     10
        click element   ${DISCOUNT_SUBMITE}
      sleep    2s
      ${total_span}    get text    ${total_pay}
      ${total_span}    Strip String    ${total_span}
       should be equal    ${t}  ${total_span}
remise par rectification du total
     ${tota}    get text    ${total_pay}
        click element     ${discount_select}
        sleep    2s
      click element        css=.sob-v2-select__option:nth-child(3)
      sleep    2s
       input text    id=global_discount__total  160
        click element   ${DISCOUNT_SUBMITE}
        sleep    2s
         ${total_span}    get text    ${total_pay}
         ${total_span}    Strip String    ${total_span}
          should be equal    ${total_span}     160,00

annuler la remise
  input text    ${DISCOUNT_INPUT}     0

remise par produit ( type montant )
      click element    ${type_select}
      click element      css=.sob-v2-select__option:nth-child(2)
       sleep     2s
vérifier la remise par produit type montant
   ${table_rows}  Get Element Count      xpath=${table2}
        Should Be True  ${table_rows} > 0
        FOR  ${row}  IN RANGE    2    ${table_rows} + 1    7
            ${col}    set variable    [${row}]/td[3]/span[1]
          ${xpath_tab}    set variable     ${table2}${col}
          ${cell_text}  get text   xpath= ${xpath_tab}
           @{result_list}    Create List
            ${list_length}=    Get Length    ${PU_LIST}
           FOR  ${index}  IN RANGE    0     ${list_length}
              ${value}  Get From List    ${PU_LIST}  ${index}
              ${value_num}    Evaluate    float('${value}'.strip().replace(',', '.'))
               ${result}     Evaluate     format(round( ${value_num} - 10 , 2), ".2f").replace('.', ',')
               append To List    ${result_list}    ${result}
            END

           Should Contain  ${result_list}  ${cell_text}  in
        END

remise par montant produit type montant
           ${tota}    get text    ${total_pay}
            ${tota_num}    Evaluate    float('${tota}'.strip().replace(',', '.'))
            ${result}     Evaluate     format(round( ${tota_num} - 10, 2), ".2f").replace('.', ',')
            ${t}      set variable     ${result}
      click element       ${discount_select}
      click element         css=.sob-v2-select__option:nth-child(2)
       sleep     2s
       click element         ${type_select}
      click element          css=.sob-v2-select__option:nth-child(2)
      sleep    2s
      input text    ${DISCOUNT_INPUT}     10
        click element   ${DISCOUNT_SUBMITE}
      sleep    2s
      ${total_span}    get text    ${total_pay}
      ${total_span}    Strip String    ${total_span}
       should be equal    ${t}  ${total_span}
