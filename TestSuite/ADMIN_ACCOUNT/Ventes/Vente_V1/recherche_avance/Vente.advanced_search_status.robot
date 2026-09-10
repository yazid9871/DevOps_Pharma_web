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
${SEARCH_FIELD_status}   id=status.q
${AD_SEARCH_FIELD_status}      id=status.operation
${AD_SEARCH_DROPDOWN}        css=.sob-v2-select__option:nth-child(2)
${status_DROPDOWN}         css=.sob-v2-select__option:nth-child(2)
${table}     //table[contains(@class, 'sob-v2-table')]//tbody//tr

*** Test Cases ***
Search By Contain
        Accéder à la page    invoices

    Click Search Button To Show Input Field
    Click advanced Search Button To Show Input select
    Verify advanced Search select is Visibles
     Click Input Field To Show statu Options
    Verify statu Dropdown Is Visible
     select statu and Verify Search Results

Search By not equal
        Click Input Field To Show advanced search Options
    Verify advanced search Dropdown Is Visible
    Verify Search Results dtatu by not equal

*** Keywords ***
Click Search Button To Show Input Field
    Click Button  ${SEARCH_BUTTON}

Click advanced Search Button To Show Input select
    Click Button  ${AD_SEARCH_BUTTON}

Verify advanced Search select is Visibles
    Wait Until Element Is Visible  ${AD_SEARCH_FIELD_status}

Click Input Field To Show statu Options
    Click Element    ${SEARCH_FIELD_status}

Verify statu Dropdown Is Visible
    Wait Until Element Is Visible  ${status_DROPDOWN}    10s

Select statu and Verify Search Results
    FOR  ${i}  IN RANGE  1  7

         Execute JavaScript  document.querySelector("#react-select-3-option-${i}").scrollIntoView(true);
         sleep    2s
        click element    css:#react-select-3-option-${i}
         Click Element    ${SEARCH_FIELD_status}
            Wait Until Element Is Visible  ${status_DROPDOWN}    10s
           ${value} =  Get Text  css:#react-select-3-option-${i}
         ${table_rows}  Get Element Count    xpath=${table}
        Should Be True  ${table_rows} > 0
        FOR  ${row}  IN RANGE  1  ${table_rows} + 1
          ${col}    set variable    [${row}]/td[6]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
          should be equal    ${cell_text}  ${value}
        END

    END

Click Input Field To Show advanced search Options
    Click Element    ${AD_SEARCH_FIELD_status}

Verify advanced search Dropdown Is Visible
    Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s

Verify Search Results dtatu by not equal
    click element    css:#react-select-10-option-0
       Click Element    ${SEARCH_FIELD_status}
         Wait Until Element Is Visible  ${status_DROPDOWN}    10s
       FOR  ${i}  IN RANGE  1  7

         Execute JavaScript  document.querySelector("#react-select-3-option-${i}").scrollIntoView(true);
         sleep    2s
        click element    css:#react-select-3-option-${i}
         Click Element    ${SEARCH_FIELD_status}
            Wait Until Element Is Visible  ${status_DROPDOWN}    10s
           ${value} =  Get Text  css:#react-select-3-option-${i}
         ${table_rows}  Get Element Count    xpath=${table}
        Should Be True  ${table_rows} > 0
        FOR  ${row}  IN RANGE  1  ${table_rows} + 1
          ${col}    set variable    [${row}]/td[6]
          ${xpath_tab}    set variable     ${table}${col}
          ${cell_text}  get text   xpath=${xpath_tab}
          should not be equal    ${cell_text}  ${value}
        END

    END