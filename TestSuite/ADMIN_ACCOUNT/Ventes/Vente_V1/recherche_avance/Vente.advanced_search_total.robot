*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Ventes"
Library           SeleniumLibrary
Resource          ../../../../../Resources/Authentification_Admin.robot
Resource          ../../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../../Resources/Variables.robot
Resource          ../../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Ventes
*** Variables ***


${SEARCH_BUTTON}       xpath=//*[@data-testid="recherche"]
${AD_SEARCH_BUTTON}      xpath=//*[@data-testid="recherche_avancée"]
${SEARCH_FIELD_total}     id=total
${AD_SEARCH_FIELD_total}     id=total.operation
${AD_SEARCH_DROPDOWN}    css=.sob-v2-select__option:nth-child(2)
${table}     //table[contains(@class, 'sob-v2-table')]//tbody//tr

*** Test Cases ***
Search By equal
       Accéder à la page    invoices

    Click Search Button To Show Input Field
    Click advanced Search Button To Show Input select
    Verify advanced Search select is Visibles
     Input Search total
    Submit Search
     sleep    10s
    Verify Search Results total by eqaul
Search By not eqauml
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results total by not eqaul

Search By not Superior
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results total by Superior

Search By not Superior or equal
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results total by Superior or equal

Search By Inferior
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results total by Inferior

Search By Inferior or eqaul
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results total by Inferior or equal

Search By empty
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results total by empty

Search By not empty
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results total by not empty


*** Keywords ***

Click Search Button To Show Input Field
    Click Button  ${SEARCH_BUTTON}

Click advanced Search Button To Show Input select
    Click Button  ${AD_SEARCH_BUTTON}

Verify advanced Search select is Visibles
    Wait Until Element Is Visible  ${AD_SEARCH_FIELD_total}

Input Search total
    ${search_total}  Set Variable  10.00
    Input Text  ${SEARCH_FIELD_total}  ${search_total}

Submit Search
    Press Keys  ${SEARCH_FIELD_total}  RETURN
    # by Contain
Verify Search Results total by eqaul
    ${expected_result}    get value    ${SEARCH_FIELD_total}
    ${table_rows}  Get Element Count  xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[4]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              should be equal    ${cell_text}  ${expected_result}
          END
      END
Click Input Field To Show advanced search Options
    Click Element    ${AD_SEARCH_FIELD_total}

Verify advanced search Dropdown Is Visible
    Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s

Verify Search Results total by not eqaul
    ${expected_result}    get value    ${SEARCH_FIELD_total}
     click element    css:#react-select-8-option-1
    sleep    2s
    ${table_rows}  Get Element Count  xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[4]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              should not be equal    ${cell_text}  ${expected_result}
          END
      END

Verify Search Results total by Superior
    ${expected_result}    get value    ${SEARCH_FIELD_total}
     click element    css:#react-select-8-option-2
    sleep    2s
    ${table_rows}  Get Element Count  xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[4]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              ${condition}=  Evaluate    ${cell_text} > ${expected_result}
              Should Be True  ${condition}
          END
      END

Verify Search Results total by Superior or equal
    ${expected_result}    get value    ${SEARCH_FIELD_total}
     click element    css:#react-select-8-option-3
    sleep    2s
    ${table_rows}  Get Element Count  xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[4]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              ${condition}=  Evaluate    ${cell_text} >= ${expected_result}
              Should Be True  ${condition}
          END
      END

Verify Search Results total by Inferior
    ${expected_result}    get value    ${SEARCH_FIELD_total}
     click element    css:#react-select-8-option-4
    sleep    2s
    ${table_rows}  Get Element Count  xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[4]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              ${condition}=  Evaluate    ${cell_text} < ${expected_result}
              Should Be True  ${condition}
          END
      END

Verify Search Results total by Inferior or equal
    ${expected_result}    get value    ${SEARCH_FIELD_total}
     click element    css:#react-select-8-option-5
    sleep    2s
    ${table_rows}  Get Element Count  xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[4]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              ${condition}=  Evaluate    ${cell_text} <= ${expected_result}
              Should Be True  ${condition}
          END
      END

Verify Search Results total by empty
     click element    css:#react-select-8-option-6
    sleep    2s
    ${table_rows}  Get Element Count  xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     15s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[4]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
             ${condition}=  Evaluate    ${cell_text} == 0.00
              Should Be True  ${condition}
          END
      END

Verify Search Results total by not empty
    ${expected_result}    get value    ${SEARCH_FIELD_total}
     click element    css:#react-select-8-option-7
    sleep    2s
    ${table_rows}  Get Element Count  xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[4]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
               should not be empty    ${cell_text}  ${expected_result}
          END
      END