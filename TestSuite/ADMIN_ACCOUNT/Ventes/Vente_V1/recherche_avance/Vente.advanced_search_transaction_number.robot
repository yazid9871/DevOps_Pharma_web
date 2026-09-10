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
${SEARCH_FIELD_Transaction_number}     id=transaction_number
${AD_SEARCH_FIELD_Transaction_number}     id=transaction_number.operation
${AD_SEARCH_DROPDOWN}       css=.sob-v2-select__option:nth-child(2)
${table}   //table[contains(@class, 'sob-v2-table')]//tbody//tr


*** Test Cases ***
Search By Contain
         Accéder à la page    invoices

    Click Search Button To Show Input Field
    Click advanced Search Button To Show Input select
    Verify advanced Search select is Visibles
     Input Search transaction_number
    Submit Search
     sleep    10s
    Verify Search Results transaction_number by Contain
    sleep    3s

Search By not Contain
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results transaction_number by not contain

Search By start
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    verify Search Results transaction_number by start

Search By End
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results transaction_number by end

Search By equal
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results transaction_number by equal

Search By not equal
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results transaction_number by not equal

Search By empty
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results transaction_number by empty

Search By not empty
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results transaction_number by not empty

*** Keywords ***
Click Search Button To Show Input Field
    Click Button  ${SEARCH_BUTTON}

Click advanced Search Button To Show Input select
    Click Button  ${AD_SEARCH_BUTTON}

Verify advanced Search select is Visibles
    Wait Until Element Is Visible  ${AD_SEARCH_FIELD_Transaction_number}

Input Search transaction_number
    ${search_number}  Set Variable  FAC-2
    Input Text  ${SEARCH_FIELD_Transaction_number}  ${search_number}

Submit Search
    Press Keys  ${SEARCH_FIELD_Transaction_number}  RETURN
    # by Contain
Verify Search Results transaction_number by Contain
    ${expected_result}  Set Variable  FAC-2
    ${table_rows}  Get Element Count   xpath=${table}
      IF     ${table_rows} == 0
              wait until page contains     Informations introuvables   10s

      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
              ${col}    set variable    [${row}]/th
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              Should Contain  ${cell_text}  ${expected_result}
          END
      END
      # not contain
Verify Search Results transaction_number by not Contain
    ${expected_result}  Set Variable   FAC-2
    click element    css:#react-select-4-option-1
    sleep    5s
    ${table_rows}  Get Element Count   xpath=${table}
      IF     ${table_rows} == 0
              wait until page contains     Informations introuvables   10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
              ${col}    set variable    [${row}]/th
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              should not contain    ${cell_text}  ${expected_result}
          END
      END


   #by start

Click Input Field To Show advanced search Options
    Click Element    ${AD_SEARCH_FIELD_Transaction_number}

Verify advanced search Dropdown Is Visible
    Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s

Verify Search Results transaction_number by start
    ${expected_result}  Set Variable    FAC-2
    click element    css:#react-select-4-option-2
     sleep    5s
    ${table_rows}  Get Element Count   xpath=${table}
      IF     ${table_rows} == 0
              wait until page contains     Informations introuvables   10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
              ${col}    set variable    [${row}]/th
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              should start with    ${cell_text}  ${expected_result}
          END
      END
     #by end

Verify Search Results transaction_number by end
    ${expected_result}  Set Variable   FAC-2
    click element    css:#react-select-4-option-3
    sleep    5s
     ${table_rows}  Get Element Count   xpath=${table}
      IF     ${table_rows} == 0
              wait until page contains     Informations introuvables   10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
              ${col}    set variable    [${row}]/th
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              should end with    ${cell_text}  ${expected_result}
          END
      END

Verify Search Results transaction_number by equal
    ${expected_result}  Set Variable   FAC-2
    click element    css:#react-select-4-option-4
    sleep    5s
     ${table_rows}  Get Element Count   xpath=${table}
      IF     ${table_rows} == 0
              wait until page contains     Informations introuvables   10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
              ${col}    set variable    [${row}]/th
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
            should be equal    ${cell_text}  ${expected_result}
          END
      END

Verify Search Results transaction_number by not equal
    ${expected_result}  Set Variable   FAC-2
    click element    css:#react-select-4-option-5
    sleep    5s
     ${table_rows}  Get Element Count   xpath=${table}
      IF     ${table_rows} == 0
              wait until page contains     Informations introuvables   10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
              ${col}    set variable    [${row}]/th
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
            should not be equal     ${cell_text}  ${expected_result}
          END
      END

Verify Search Results transaction_number by empty
    ${expected_result}  Set Variable   FAC-2
    click element    css:#react-select-4-option-6
    sleep    5s
     ${table_rows}  Get Element Count   xpath=${table}
      IF     ${table_rows} == 0
              wait until page contains     Informations introuvables   15s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
              ${col}    set variable    [${row}]/th
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              should be empty    ${cell_text}  ${expected_result}
          END
      END

Verify Search Results transaction_number by not empty
    ${expected_result}  Set Variable   FAC-2
    click element    css:#react-select-4-option-7
    sleep    5s
     ${table_rows}  Get Element Count   xpath=${table}
      IF     ${table_rows} == 0
              wait until page contains     Informations introuvables   10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
              ${col}    set variable    [${row}]/th
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              should not be empty     ${cell_text}  ${expected_result}
          END
      END