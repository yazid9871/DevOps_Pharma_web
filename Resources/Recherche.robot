*** Settings ***
Documentation     Fichier contenant les tests fonctionnels liés aux différentes fonctionnalités de recherche.
Library           SeleniumLibrary
Resource          Variables.robot


*** Keywords ***
Cliquer Sur Le Champ Pour Afficher Les Options
    [Arguments]     ${SEARCH_FIELD}
    Click Element    ${SEARCH_FIELD}
Vérifier Que La Liste Déroulante Est Visible
    [Arguments]       ${status_DROPDOWN}
    Wait Until Element Is Visible  ${status_DROPDOWN}    10s
# ---Vérifier La Recherche   ---
Vérifier La Recherche
     [Documentation]      Vérifie la recherche d'un client .
      [Arguments]    ${td}    ${name}     ${champ}
    ${search_name}  Set Variable  ${name}
    Input Text  ${champ}  ${search_name}
    Click Button  ${SEARCH_BUTTON2}
    sleep    10s

     ${expected_result}   Set Variable  ${name}
    ${table_rows}  Get Element Count    xpath=${table}
    IF     ${table_rows} == 0
                    Wait Until Element Is Visible  css:.sob-v2-empty-data-title    10s
       ELSE
        Should Be True  ${table_rows} > 0
         FOR  ${row}  IN RANGE  1  ${table_rows} + 1
             ${col}    set variable    [${row}]/${td}
          ${xpath_tab}    set variable     ${table}${col}
          wait until element is visible   xpath= ${xpath_tab}  10s
          ${cell_text}  get text   xpath= ${xpath_tab}
                  Should Contain  ${cell_text}  ${expected_result}
          END
     END
# --- rechehce par select option    ---

Sélectionner Un option Et Vérifier Les Résultats De Recherche
      [Arguments]    ${td}  ${champ}
    FOR  ${i}  IN RANGE  2  4

        click element     css=.sob-v2-select__option:nth-child(${i})
        sleep     5s
         Click Element    ${champ}
            Wait Until Element Is Visible  ${LISTE_DEROULANTE}    10s
          ${value} =  Get Text      css=.sob-v2-select__option:nth-child(${i})
            ${table_rows}  Get Element Count    xpath=${table}
             IF     ${table_rows} == 0
                    Wait Until Element Is Visible  css:.sob-v2-empty-data-title    10s
              ELSE
                     Should Be True  ${table_rows} > 0

                     FOR  ${row}  IN RANGE  1  ${table_rows} + 1
                    ${col}    set variable    [${row}]/${td}
          ${xpath_tab}    set variable     ${table}${col}
          wait until element is visible    xpath= ${xpath_tab}    15s
          ${cell_text}  get text   xpath= ${xpath_tab}
                    Should Contain  ${cell_text}  ${value}
                  END
          END
    END
