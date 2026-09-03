
*** Settings ***
Documentation     Tests fonctionnels de la ' Recheche_avance_liste_des_Inventaires"
Library           SeleniumLibrary
Library    Collections

Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags       Recheche_avance_liste_des_Inventaires


*** Variables ***

${SEARCH_BUTTON}       xpath=//*[@data-testid="recherche"]
${AD_SEARCH_BUTTON}      xpath=//*[@data-testid="recherche_avancée"]
${SEARCH_FIELD_Transaction_number}     id=transaction_number
${AD_SEARCH_FIELD_Transaction_number}     id=transaction_number.operation
${AD_SEARCH_BUTTON}      xpath=//*[@data-testid="recherche_avancée"]
${SEARCH_FIELD_date}        id=date.q
${AD_SEARCH_FIELD_date}     id=date.operation
${SEARCH_FIELD_status}   id=status.q
${AD_SEARCH_FIELD_status}      id=status.operation
${SEARCH_FIELD_method}     id=method.q
${AD_SEARCH_FIELD_method}    id=method.operation
${SEARCH_FIELD_form}     id=product_galenic_form_id.q
${AD_SEARCH_FIELD_form}    id=product_galenic_form_id.operation
${SEARCH_FIELD_zone}     id=zone_id.q
${AD_SEARCH_FIELD_zone}    id=zone_id.operation
${AD_SEARCH_DROPDOWN}       css=.sob-v2-select__option:nth-child(2)
${table}   //table[contains(@class, 'sob-v2-table')]//tbody//tr
${REFRESH_BUTTON}      xpath=//button[contains(., 'Rafraichir')]
${date_DROPDOWN}       css=.react-datepicker
${TR_value}    INV-2871
${DATE_value}    2025-02-20
${expected_result2}     0000-00-00
*** Test Cases ***
Go to inventory


    Go To inventory Listing Page
    Click Search Button To Show Input Field
    Click advanced Search Button To Show Input select
    Verify advanced Search select is Visibles

verify advanced search transaction_number
     add value to Input Search transaction_number
     sleep    5s
     Search And Verify transaction_number        1       should contain
     Search And Verify transaction_number        2      should not contain
     Search And Verify transaction_number        3      should start with
     Search And Verify transaction_number        4       should end with
     Search And Verify transaction_number        5        should be equal
     Search And Verify transaction_number        6      should not be equal
      Search And Verify transaction_number        7       should be empty
     Search And Verify transaction_number        8      should not be empty

verify advanced search date

      Click on refresh button
     add value to Input Search date
     sleep    5s
     Search And Verify date        1       should contain
     Search And Verify date        2      should not contain
     Search And Verify date        3      >
     Search And Verify date        4       <
      Search And Verify date        5      ==
     Search And Verify date        6      should not be empty
verify advanced search method
     Click on refresh button
     sleep    5s
     Search And Verify method       1       should not be equal
     Search And Verify method      2       should be equal

verify advanced search form
     Click on refresh button
     sleep    5s
     Search And Verify form       1       should not be equal
     Search And Verify form      2       should be equal

verify advanced search zone
     Click on refresh button
     sleep    5s
     Search And Verify zone       1       should not be equal
     Search And Verify zone      2       should be equal
verify advanced search status
     Click on refresh button
     #add value to Input Search status
     sleep    5s
     Search And Verify status        1       should not be equal
     Search And Verify status        2       should be equal


*** Keywords ***

Go To inventory Listing Page
    [Documentation]    Navigate to the product listing page after logging in.
    Go To    ${BASE_URL}/stock/stocktakes
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s

Click Search Button To Show Input Field
    wait until element is visible      ${SEARCH_BUTTON}  10s
    Click Button  ${SEARCH_BUTTON}

Click advanced Search Button To Show Input select
    Click Button  ${AD_SEARCH_BUTTON}

Verify advanced Search select is Visibles
    Wait Until Element Is Visible  ${AD_SEARCH_FIELD_Transaction_number}


add value to Input Search transaction_number
    ${search_number}  Set Variable    ${TR_value}
    wait until element is visible     ${SEARCH_FIELD_Transaction_number}    10s
    Input Text  ${SEARCH_FIELD_Transaction_number}  ${search_number}
    Press Keys  ${SEARCH_FIELD_Transaction_number}  RETURN

Search And Verify transaction_number
          [Arguments]    ${option_number}    ${comparison_type}

    Click Element    ${AD_SEARCH_FIELD_Transaction_number}
    Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s

    ${expected_result}  Set Variable  ${TR_value}
    click element   css=.sob-v2-select__option:nth-child(${option_number})
    sleep    5s
    ${table_rows}  Get Element Count   xpath=${table}
      IF     ${table_rows} == 0
              wait until page contains     Informations introuvables   10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
              ${col}    set variable    [${row}]/th
          ${xpath_tab}    set variable     ${table}${col}
          wait until element is visible     xpath=${xpath_tab}    300s
          ${cell_text}  get text   xpath=${xpath_tab}
            Run Keyword     ${comparison_type}    ${cell_text}  ${expected_result}
          END
      END
Click on refresh button
     Click Button  ${REFRESH_BUTTON}
     sleep     2s

add value to Input Search date
   Click Element    ${SEARCH_FIELD_date}
   Wait Until Element Is Visible  ${date_DROPDOWN}    10s
    click element    css:button.react-datepicker__navigation:nth-child(3)
     sleep    2s
     click element    css=.react-datepicker__day--020
     sleep    2s

Search And Verify date
          [Arguments]    ${option_number}    ${comparison_type}

    Click Element    ${AD_SEARCH_FIELD_date}
   Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s

     wait until element is visible      css=.sob-v2-select__option:nth-child(${option_number})   10s
     Click Element    css=.sob-v2-select__option:nth-child(${option_number})
    sleep    5s
    ${expected_result}   Set Variable  ${DATE_value}
    ${table_rows}  Get Element Count      xpath=${table}
      IF     ${table_rows} == 0
              wait until page contains     Informations introuvables   10s
      ELSE
           Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
              ${col}    set variable    [${row}]/td[1]
          ${xpath_tab}    set variable     ${table}${col}
           wait until element is visible     xpath=${xpath_tab}    40s
          ${cell_text}  get text   xpath=${xpath_tab}
                     IF    ${option_number}==3
                            ${is_greater}    Evaluate    '${cell_text}' ${comparison_type}'${expected_result}'
                             Should Be True    ${is_greater}
                     ELSE IF     ${option_number}==4
                            ${is_greater2}    Evaluate    '${cell_text}' ${comparison_type} '${expected_result}'
                              Should Be True    ${is_greater2}
                       ELSE IF     ${option_number}==5
                            ${is_greater2}    Evaluate    '${cell_text}' ${comparison_type} '${expected_result2}'
                              Should Be True    ${is_greater2}
                     ELSE
                           Run Keyword     ${comparison_type}    ${cell_text}  ${expected_result}
                     END

          END
      END

Search And Verify method
         [Arguments]    ${option_number}    ${comparison_type}

     Click Element    ${AD_SEARCH_FIELD_method}
     Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s
      click element   css=.sob-v2-select__option:nth-child(${option_number})

      Click Element    ${SEARCH_FIELD_method}
       Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s
           FOR  ${i}  IN RANGE  2  6

                Execute JavaScript  document.querySelector(".sob-v2-select__option:nth-child(${i})").scrollIntoView(true);
                 sleep    2s
                 click element    css=.sob-v2-select__option:nth-child(${i})
                Click Element    ${SEARCH_FIELD_method}
                 Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s
                 ${expected_result} =  Get Text     css=.sob-v2-select__option:nth-child(${i})
                 sleep    5s
                 ${table_rows}  Get Element Count    xpath=${table}
                  Should Be True  ${table_rows} > 0
                     FOR  ${row}  IN RANGE  1  ${table_rows} + 1
                            ${col}    set variable    [${row}]/td[2]
                             ${xpath_tab}    set variable     ${table}${col}
                              wait until element is visible     xpath=${xpath_tab}    20s
                                ${cell_text}  get text   xpath=${xpath_tab}
                                Run Keyword     ${comparison_type}    ${cell_text}  ${expected_result}
                      END

            END

Search And Verify form
         [Arguments]    ${option_number}    ${comparison_type}

     Click Element    ${AD_SEARCH_FIELD_form}
     Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s
      click element   css=.sob-v2-select__option:nth-child(${option_number})

      Click Element    ${SEARCH_FIELD_form}
       Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s
           FOR  ${i}  IN RANGE  2  6

                Execute JavaScript  document.querySelector(".sob-v2-select__option:nth-child(${i})").scrollIntoView(true);
                 sleep    2s
                 click element    css=.sob-v2-select__option:nth-child(${i})
                Click Element    ${SEARCH_FIELD_form}
                 Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s
                 ${expected_result} =  Get Text     css=.sob-v2-select__option:nth-child(${i})
                 sleep    5s
                 ${table_rows}  Get Element Count    xpath=${table}
                  Should Be True  ${table_rows} > 0
                     FOR  ${row}  IN RANGE  1  ${table_rows} + 1
                            ${col}    set variable    [${row}]/td[3]
                             ${xpath_tab}    set variable     ${table}${col}
                              wait until element is visible     xpath=${xpath_tab}    20s
                                ${cell_text}  get text   xpath=${xpath_tab}
                                Run Keyword     ${comparison_type}    ${cell_text}  ${expected_result}
                      END

            END

Search And Verify zone
         [Arguments]    ${option_number}    ${comparison_type}

     Click Element    ${AD_SEARCH_FIELD_zone}
     Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s
      click element   css=.sob-v2-select__option:nth-child(${option_number})

      Click Element    ${SEARCH_FIELD_zone}
       Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s
           FOR  ${i}  IN RANGE  2  6

                Execute JavaScript  document.querySelector(".sob-v2-select__option:nth-child(${i})").scrollIntoView(true);
                 sleep    2s
                 click element    css=.sob-v2-select__option:nth-child(${i})
                Click Element    ${SEARCH_FIELD_zone}
                 Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s
                 ${expected_result} =  Get Text     css=.sob-v2-select__option:nth-child(${i})
                 sleep    5s
                 ${table_rows}  Get Element Count    xpath=${table}
                  Should Be True  ${table_rows} > 0
                     FOR  ${row}  IN RANGE  1  ${table_rows} + 1
                            ${col}    set variable    [${row}]/td[4]
                             ${xpath_tab}    set variable     ${table}${col}
                              wait until element is visible     xpath=${xpath_tab}    20s
                                ${cell_text}  get text   xpath=${xpath_tab}
                                Run Keyword     ${comparison_type}    ${cell_text}  ${expected_result}
                      END

            END

Search And Verify status
         [Arguments]    ${option_number}    ${comparison_type}

     Click Element    ${AD_SEARCH_FIELD_status}
     Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s
      click element   css=.sob-v2-select__option:nth-child(${option_number})

      Click Element    ${SEARCH_FIELD_status}
       Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s
           FOR  ${i}  IN RANGE  2  4

                Execute JavaScript  document.querySelector(".sob-v2-select__option:nth-child(${i})").scrollIntoView(true);
                 sleep    2s
                 click element    css=.sob-v2-select__option:nth-child(${i})
                Click Element    ${SEARCH_FIELD_status}
                 Wait Until Element Is Visible  ${AD_SEARCH_DROPDOWN}    10s
                 ${expected_result} =  Get Text     css=.sob-v2-select__option:nth-child(${i})
                 sleep    5s
                 ${table_rows}  Get Element Count    xpath=${table}
                  Should Be True  ${table_rows} > 0
                     FOR  ${row}  IN RANGE  1  ${table_rows} + 1
                            ${col}    set variable    [${row}]/td[5]
                             ${xpath_tab}    set variable     ${table}${col}
                              wait until element is visible     xpath=${xpath_tab}    20s
                                ${cell_text}  get text   xpath=${xpath_tab}
                                Run Keyword     ${comparison_type}    ${cell_text}  ${expected_result}
                      END

            END