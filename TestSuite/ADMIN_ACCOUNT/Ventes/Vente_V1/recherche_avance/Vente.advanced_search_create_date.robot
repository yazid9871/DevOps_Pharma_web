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
${SEARCH_FIELD_date}         id=created_on.q
${AD_SEARCH_FIELD_date}        id=created_on.operation
${AD_SEARCH_DROPDOWN}         css=.sob-v2-select__option:nth-child(2)
${date_DROPDOWN}       css=.react-datepicker
${date}     2024-11-06
${table}        //table[contains(@class, 'sob-v2-table')]//tbody//tr

*** Test Cases ***
Search By equal
     Accéder à la page    invoices
    Click Search Button To Show Input Field
    Click advanced Search Button To Show Input select
    Verify advanced Search select is Visibles
     Input Search date
    Verify Search Results date by equal
Search By not equal
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results date by not equal
Search By after
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results date by after
Search By before
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
   Verify Search Results date by before
Search By empty
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results date by empty

Search By not empty
    Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results date by not empty

*** Keywords ***
Click Search Button To Show Input Field
    Click Button  ${SEARCH_BUTTON}

Click advanced Search Button To Show Input select
    Click Button  ${AD_SEARCH_BUTTON}

Verify advanced Search select is Visibles
    Wait Until Element Is Visible  ${AD_SEARCH_FIELD_date}    15s

Input Search date
   Click Element    ${SEARCH_FIELD_date}
   Wait Until Element Is Visible  ${date_DROPDOWN}    10s

Submit Search
    Press Keys  ${SEARCH_FIELD_date}  RETURN

Click Input Field To Show advanced search Options
    Click Element    ${AD_SEARCH_FIELD_date}

Verify advanced search Dropdown Is Visible
    Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s

Verify Search Results date by equal
        click element    css:button.react-datepicker__navigation:nth-child(3)
     sleep    2s
     click element    css=.react-datepicker__day--006
     sleep    2s
    ${expected_result}   Set Variable   ${date}
    ${table_rows}  Get Element Count   xpath=${table}
    IF     ${table_rows} == 0
                   wait until page contains      Informations introuvables    10s
    ELSE
        Should Be True  ${table_rows} > 0
        FOR  ${row}  IN RANGE  1  ${table_rows} + 1
          ${col}    set variable    [${row}]/td[3]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
           should contain     ${cell_text}  ${expected_result}
         END
    END
Verify Search Results date by not equal
    wait until element is visible      css=.sob-v2-select__option:nth-child(2)     10s
     Click Element    css=.sob-v2-select__option:nth-child(2)
    sleep    2s
    ${expected_result}   Set Variable   ${date}
    ${table_rows}  Get Element Count    xpath=${table}
    IF     ${table_rows} == 0
                   wait until page contains      Informations introuvables    10s

    ELSE
        Should Be True  ${table_rows} > 0
        FOR  ${row}  IN RANGE  1  ${table_rows} + 1
          ${col}    set variable    [${row}]/td[3]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
           should not contain    ${cell_text}  ${expected_result}
         END
    END
Verify Search Results date by after
    wait until element is visible      css=.sob-v2-select__option:nth-child(3)   10s
     Click Element    css=.sob-v2-select__option:nth-child(3)
    sleep    2s
    ${expected_result}   Set Variable  ${date}
    ${table_rows}  Get Element Count      xpath=${table}
    IF     ${table_rows} == 0
                   wait until page contains      Informations introuvables    10s
    ELSE
        Should Be True  ${table_rows} > 0
        FOR  ${row}  IN RANGE  1  ${table_rows} + 1
          ${col}    set variable    [${row}]/td[3]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
         ${is_greater}    Evaluate    '${cell_text}' >'${expected_result}'
           Should Be True    ${is_greater}

         END
    END

Verify Search Results date by before
    wait until element is visible      css=.sob-v2-select__option:nth-child(4)   10s
     Click Element    css=.sob-v2-select__option:nth-child(4)
    sleep    2s
    ${expected_result}   Set Variable   ${date}
    ${table_rows}  Get Element Count    xpath=${table}
    IF     ${table_rows} == 0
                   wait until page contains      Informations introuvables    10s
    ELSE
        Should Be True  ${table_rows} > 0
        FOR  ${row}  IN RANGE  1  ${table_rows} + 1
           ${col}    set variable    [${row}]/td[3]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
         ${is_greater2}     Evaluate    '${cell_text}' <'${expected_result}'
           #should be equal as strings    ${is_greater2}     True
            Should Be True    ${is_greater2}
         END
    END

Verify Search Results date by empty
     wait until element is visible      css=.sob-v2-select__option:nth-child(5)   10s
     Click Element    css=.sob-v2-select__option:nth-child(5)
    sleep    2s
    ${table_rows}  Get Element Count    xpath=${table}
    IF     ${table_rows} == 0
                   wait until page contains      Informations introuvables    10s
    ELSE
        Should Be True  ${table_rows} > 0
        FOR  ${row}  IN RANGE  1  ${table_rows} + 1
          ${col}    set variable    [${row}]/td[3]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
           should be empty    ${cell_text}
         END
    END

Verify Search Results date by not empty
     wait until element is visible      css=.sob-v2-select__option:nth-child(6)   10s
     Click Element    css=.sob-v2-select__option:nth-child(6)
    sleep    2s
    ${table_rows}  Get Element Count     xpath=${table}
    IF     ${table_rows} == 0
                   wait until page contains      Informations introuvables    10s
    ELSE
        Should Be True  ${table_rows} > 0
        FOR  ${row}  IN RANGE  1  ${table_rows} + 1
          ${col}    set variable    [${row}]/td[3]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
           should not be empty    ${cell_text}
        END
    END