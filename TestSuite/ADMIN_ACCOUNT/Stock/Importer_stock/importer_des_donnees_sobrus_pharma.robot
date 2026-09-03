
*** Settings ***
Documentation     Tests fonctionnels de la ' page importer des donnees sobrus pharma"
Library           SeleniumLibrary
Library    Collections

Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags       page importer des donnees sobrus pharma



*** Variables ***



${IMAGE_PATH}      C:\\Users\\M.ELHAJOUJI\\Videos\\Captures\\test.xlsx
${INPUT_TEXT}       xpath=//*[@id="import_file"]
${BUTTON_SUIVANT}       xpath=//*[@data-testid="suivant"]



*** Test Cases ***
go to Import page

    Go To import page
    Open Pharma Import Modal
Verify Replace Existing Stock Checked and Import Pharma File
    Verify Replace Existing Stock Checked and Import Pharma File
Verify Result
    Verify Result and No Failed Lines
    Click Next On Import
    verify resuls

*** Keywords ***
Set Browser Zoom
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"
Go To import page
    Go To    ${BASE_URL}/stock/import
    wait until element is visible     xpath=//*[@data-testid="importer"]
Open Pharma Import Modal
  click element      xpath=//*[@data-testid="importer"]
  sleep     1s
  wait until element is visible    css=button.stockImportModal__card:nth-child(1)
  click element    css=button.stockImportModal__card:nth-child(1)

Verify Replace Existing Stock Checked and Import Pharma File
    sleep    8s
   #wait until element is visible          ${INPUT_TEXT}          20s
    Choose File    ${INPUT_TEXT}      ${IMAGE_PATH}
    sleep    2s

       click element     ${BUTTON_SUIVANT}
Verify Result and No Failed Lines

     sleep     2s
     wait until page contains    34
     wait until element is visible    css=.sob-v2-table > tbody:nth-child(2) > tr:nth-child(1)
     wait until element is visible     xpath=//*[@data-testid="importer"]
     wait until page contains      Certaines lignes contiennent des erreurs et seront ignorées lors de l’importation.

      ${Cod_barre}     get text    css=.sob-v2-table > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(2)
   ${Product_name}     get text        css=.sob-v2-table > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(3)
   ${Stock_quantity}     get text      css=.sob-v2-table > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(4)
    ${Imported_quantity}     get text      css=.sob-v2-table > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(5)
     ${Final_quantity}     get text     css=.sob-v2-table > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(6)

  should be equal      ${Cod_barre}         6118000000000
  should be equal       ${Product_name}       Mahdi 7
  should be equal      ${Stock_quantity}     98
  should be equal      ${Imported_quantity}     100
  should be equal      ${Final_quantity}      100
Click Next On Import
  click element     xpath=//*[@data-testid="importer"]

verify resuls
   wait until page contains    	Le produit n'a pas été trouv
verify the table filter
    click element        xpath=//*[@data-testid="succès_(33)"]
     wait until page does not contain       	Le produit n'a pas été trouv
    click element       xpath=//*[@data-testid="échecs_(1)"]
      wait until page contains    	Le produit n'a pas été trouv

Click on inventory and verify results on product



