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
${SEARCH_FIELD_customer}       id=customer_id_name
${AD_SEARCH_FIELD_customer}     id=customer_id_name.operation
${AD_SEARCH_DROPDOWN}         css=.sob-v2-select__option:nth-child(2)
${table}        //table[contains(@class, 'sob-v2-table')]//tbody//tr

*** Test Cases ***
Search By Contain
     Accéder à la page    invoices
    Click Search Button To Show Input Field
    Click advanced Search Button To Show Input select
    Verify advanced Search select is Visibles
     Input Search customer
    Submit Search
     sleep    10s
    Verify Search Results customer by Contain

Search By not Contain
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results customer by not contain

Search By start
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    verify Search Results customer by start

Search By End
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results customer by end

Search By equal
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results customer by equal

Search By not equal
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results customer by not equal

Search By empty
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results customer by empty

Search By not empty
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results customer by not empty


*** Keywords ***
Click Search Button To Show Input Field
    Click Button  ${SEARCH_BUTTON}

Click advanced Search Button To Show Input select
    Click Button  ${AD_SEARCH_BUTTON}

Verify advanced Search select is Visibles
    Wait Until Element Is Visible  ${AD_SEARCH_FIELD_customer}     5s

Input Search customer
    ${search_name}  Set Variable  test
    Input Text  ${SEARCH_FIELD_customer}  ${search_name}

Submit Search
    Press Keys  ${SEARCH_FIELD_customer}  RETURN
    # by Contain
Verify Search Results customer by Contain
    ${expected_result}  Set Variable  test
    ${table_rows}  Get Element Count    xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[1]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              Should Contain  ${cell_text}  ${expected_result}      ignore_case=True
          END
      END
      # not contain
Verify Search Results customer by not Contain
    ${expected_result}  Set Variable  test
      wait until element is visible      css=.sob-v2-select__option:nth-child(2)   10s
     Click Element    css=.sob-v2-select__option:nth-child(2)
    ${table_rows}  Get Element Count    xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[1]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              should not contain    ${cell_text}  ${expected_result}
          END
      END


   #by start

Click Input Field To Show advanced search Options
    Click Element    ${AD_SEARCH_FIELD_customer}

Verify advanced search Dropdown Is Visible
    Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s

Verify Search Results customer by start
    ${expected_result}  Set Variable  test
     wait until element is visible      css=.sob-v2-select__option:nth-child(3)   10s
     Click Element    css=.sob-v2-select__option:nth-child(3)
     sleep    5s
    ${table_rows}  Get Element Count    xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[1]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              should start with    ${cell_text}  ${expected_result}     ignore_case=True
          END
      END
     #by end

Verify Search Results customer by end
    ${expected_result}  Set Variable  test
    wait until element is visible      css=.sob-v2-select__option:nth-child(4)   10s
     Click Element    css=.sob-v2-select__option:nth-child(4)
    sleep    2s
     ${table_rows}  Get Element Count    xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[1]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              should end with    ${cell_text}  ${expected_result}
          END
      END

Verify Search Results customer by equal
    ${expected_result}  Set Variable  test
      wait until element is visible      css=.sob-v2-select__option:nth-child(5)   10s
     Click Element    css=.sob-v2-select__option:nth-child(5)
    sleep    2s
     ${table_rows}  Get Element Count    xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[1]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
            should be equal    ${cell_text}  ${expected_result}
          END
      END

Verify Search Results customer by not equal
    ${expected_result}  Set Variable  test
      wait until element is visible      css=.sob-v2-select__option:nth-child(6)   10s
     Click Element    css=.sob-v2-select__option:nth-child(6)
    sleep    2s
     ${table_rows}  Get Element Count    xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[1]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath= ${xpath_tab}
            should not be equal     ${cell_text}  ${expected_result}
          END
      END

Verify Search Results customer by empty
    ${expected_result}  Set Variable  --
     wait until element is visible      css=.sob-v2-select__option:nth-child(7)   10s
     Click Element    css=.sob-v2-select__option:nth-child(7)
    sleep    2s
     ${table_rows}  Get Element Count    xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[1]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              should be equal    ${cell_text}  ${expected_result}
          END
      END

Verify Search Results customer by not empty
    ${expected_result}  Set Variable  test
    wait until element is visible      css=.sob-v2-select__option:nth-child(8)   10s
     Click Element    css=.sob-v2-select__option:nth-child(8)
    sleep    2s
     ${table_rows}  Get Element Count    xpath=${table}
      IF     ${table_rows} == 0
               wait until page contains      Informations introuvables     10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/td[1]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
              should not be empty     ${cell_text}
          END
      END