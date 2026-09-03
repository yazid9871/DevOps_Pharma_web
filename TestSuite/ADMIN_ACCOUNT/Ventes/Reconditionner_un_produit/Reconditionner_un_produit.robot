*** Settings ***
Documentation     Tests fonctionnels de la page "Reconditionner un produit"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags         Reconditionner un produit


*** Variables ***

${product_input}     xpath=/html/body/div/div[4]/div[3]/div[2]/form/div[1]/div[1]/input
${search_name_input}     xpath=/html/body/div[2]/div/div/div[2]/div/div[1]/div[2]/input
${search_ppv_input}      xpath=/html/body/div[2]/div/div/div[2]/div/div[1]/div[3]/input
${REFRESH_BUTTON}      xpath=/html/body/div[2]/div/div/div[2]/div/div[1]/button
*** Test Cases ***
Go to Recondition a product page
    Go To Recondition a product Page
Verify "Produit a reconditionner" pop up
     open the "Produit a reconditionner" pop up
     verify refresh button
Verify Search By product name "Produit a reconditionner" pop up
     Search By product name
Verify Search By ppv "Produit a reconditionner" pop up
     Search By ppv
Click product Row And Verify Selection
     Click product Row And Verify Selection
verify "Quantité " and "Produit reconditionné" are not empty
     verify "Quantité " and "Produit reconditionné" are not empty

click "reconditionner"
    click "reconditionner"
verify pop up success
    verify pop up success


*** Keywords ***
Go To Recondition a product Page
    [Documentation]    Navigate to the product listing page after login in.
    Go To    ${BASE_URL}/sales/stock/repackaging/create
    Wait Until Element Is Visible   xpath=//*[@id="quantity"]     5s

open the "Produit a reconditionner" pop up
     click element    ${product_input}
    Wait Until Element Is Visible     ${search_name_input}    timeout=20s
verify refresh button
      Click Button  ${REFRESH_BUTTON}
      ${search_name} =    Get Value    ${search_name_input}
      ${search_ppv} =    Get Value    ${search_ppv_input}
       Should Be Empty    ${search_name}
       Should Be Empty    ${search_ppv}

Search By product name
      Input Text   ${search_name_input}    ACON TEST DE GROSSESSE B25
     Press Keys  ${search_name_input}  RETURN
     sleep    2s
   ${expected_result}  get value    ${search_name_input}
    ${table_rows}  Get Element Count   xpath=/html/body/div[2]/div/div/div[2]/div/div[2]/table/tbody/tr[1]
     IF     ${table_rows} == 0
               Wait Until Element Is Visible  css:.sob-v2-empty-data-title    10s
      ELSE
          Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
               ${cell_text}  get text    xpath=/html/body/div[2]/div/div/div[2]/div/div[2]/table/tbody/tr[/html/body/div[2]/div/div/div[2]/div/div[2]/table/tbody/tr[1]/td[${row}]]/td[1]
                Should Contain  ${cell_text}  ${expected_result}
           END
      END
Search By ppv
      Input Text   ${search_ppv_input}     50
     Press Keys  ${search_ppv_input}  RETURN
   ${expected_result}  get value    ${search_ppv_input}
    ${table_rows}  Get Element Count   xpath=/html/body/div[2]/div/div/div[2]/div/div[2]/table/tbody/tr[1]
     IF     ${table_rows} == 0
               Wait Until Element Is Visible  css:.sob-v2-empty-data-title    10s
      ELSE
          Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
               ${cell_text}  get text    xpath=/html/body/div[2]/div/div/div[2]/div/div[2]/table/tbody/tr[/html/body/div[2]/div/div/div[2]/div/div[2]/table/tbody/tr[1]/td[${row}]]/td[2]
                Should Contain  ${cell_text}  ${expected_result}
           END
      END
Click product Row And Verify Selection
       sleep     2s
     ${cell_text}  get text   xpath=/html/body/div[2]/div/div/div[2]/div/div[2]/table/tbody/tr[1]/td[1]
     click element    xpath=/html/body/div[2]/div/div/div[2]/div/div[2]/table/tbody/tr[1]/td[1]
      sleep   2s
      ${cutomer_value}    get value   ${product_input}
      should be equal    ${cutomer_value}     ${cell_text}
verify "Quantité " and "Produit reconditionné" are not empty
     should not be empty    css=#quantity
      should not be empty    css=#result
click "reconditionner"
     click element    xpath=/html/body/div/div[4]/div[1]/div[2]/button
verify pop up success
    wait until element is visible    xpath=/html/body/div/div[1]/div/div/div[1]/div/div/div[2]/p    5s