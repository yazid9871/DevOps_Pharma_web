*** Settings ***
Documentation     Tests fonctionnels de la page "Page details vente annulation de vente"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page details vente annulation de vente

*** Variables ***


${creer_button}      xpath=//*[@data-testid="créer"]
${approv_button}    css=button.sob-v2-btn-undefined:nth-child(3)
${search_input}         id=q
${customer_contact_table}      /html/body/div[3]/div/div/div[2]/div/div[2]/table/tbody/tr
${loop_button}   xpath=//div[@class='pageCpntent__searchProducts__serchebar']//button[@data-testid='false']


${CLIENT_NAME}      Client Organisme
${PRODUCT_NAME}     Produit A
${QUANTITY}         1

*** Test Cases ***
Annulation d'une vente avec organisme (première utilisation)
          [Documentation]    Annulation d'une vente avec organisme première utilisation sans remplire les taux de rem
     Go To    ${BASE_URL}/invoices

Choisir client avec organisme (première utilisation)

    sleep    1s
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s
      ${visible}=    Run Keyword And Return Status    Element Should Be Visible     xpath=//span[contains(@class,'sob-v2-switch-slider')]
    IF    ${visible}

       ${state}=    Get Element Attribute    xpath=//span[contains(@class,'sob-v2-switch-handle')]    style
        IF    'translateX(2px)' in '${state}'
             Click Element    xpath=//span[contains(@class,'sob-v2-switch-slider')]
        END
    END
    click element   ${creer_button}
     Wait Until Element Is Visible  ${approv_button}    timeout=30s
select sutomer
    sleep    3s
     wait until element is visible   css=.customer__info__details  10s
     click element    css=.customer__info__details
     wait until element is visible   ${search_input}
     Input Text   ${search_input}  test annulation de vente avec org
     Press Keys  ${search_input}  RETURN
      sleep     2s
        ${col}    set variable  /td[1]
          ${xpath_tab}    set variable     ${customer_contact_table}${col}
       click element      xpath=${xpath_tab}


search bu button loup
     click element    ${loop_button}
       sleep  3s
     #select products
      wait until element is visible     xpath=/html/body/div[1]/div/div[4]/div/div/div[2]/div[1]/div[4]/div[1]/div/div/div[1]
     click element     xpath=/html/body/div[1]/div/div[4]/div/div/div[2]/div[1]/div[4]/div[1]/div/div/div[1]


Valider vente
    Click Button    ${approv_button}
      wait until element is visible     css=.isCredit
      click element    css=.isCredit

Ouvrir la vente créée
     wait until element is visible     xpath=//div[@data-testid="afficher_la_facture"]     10s
      Click Element     xpath=//div[@data-testid="afficher_la_facture"]
Annuler la vente
      wait until element is visible       xpath=//*[@data-testid="annuler"]
     click element      xpath=//*[@data-testid="annuler"]
     wait until element is visible      xpath=//*[@data-testid="oui"]
     click element      xpath=//*[@data-testid="oui"]
     wait until element is visible     id=security_code
     input text     id=security_code       ${PASSWORD}
     click element        xpath=//*[@data-testid="confirmer"]

Vérification
       wait until page contains    Annulé     10s

