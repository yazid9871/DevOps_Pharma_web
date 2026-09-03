*** Settings ***
Documentation     Tests fonctionnels de la page "Page de création de BL obrus magic "
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page de création de BL obrus magic

*** Variables ***


${IMAGE_PATH}      C:\\Users\\M.ELHAJOUJI\\Videos\\Captures\\new\\2.JPG
${valide_scanne_BUTTON}       xpath=//*[@data-testid="valider"]
*** Test Cases ***
Verify Pagination After Login

    Go To deliverynotes Listing Page
scanne un BL
    click element    xpath=/html/body/div[1]/div/div[4]/div[2]/div[2]/div/button[1]
    sleep     3s
    wait until page contains   Scanner le bon de livraison
    sleep    2s
    wait until element is visible     css=div.ocr__card:nth-child(1)
    click element    css=div.ocr__card:nt h-child(1)
    #wait until element is visible     css=div.ocr__card:nth-child(1)
    wait until element is visible    css=.sob-v2-fileInput   20s
    Choose File    xpath=//input[@type='file']    ${IMAGE_PATH}
    sleep    2s
       click element     ${valide_scanne_BUTTON}
verifiy result
    sleep  60s
    wait until page contains    Certains noms de produits sont surlignés en orange car ils peuvent être incorrects. Veuillez les vérifier et les modifier si nécessaire.      10s
*** Keywords ***


Go To deliverynotes Listing Page
    [Documentation]    Navigate to the product listing page after logging in.
    Go To    ${BASE_URL}/deliverynotes
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s


