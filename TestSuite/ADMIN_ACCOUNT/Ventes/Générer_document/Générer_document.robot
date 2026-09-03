
*** Settings ***
Documentation     Tests fonctionnels de la page "Générer_document"
Library           SeleniumLibrary
Library    DateTime
Library    Collections
Library    String
Library    BuiltIn
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags          Générer_document

*** Variables ***

${print}        xpath=//*[@data-testid="imprimer"]
${SEARCH_FIELD_PRODUCT_NAME}      xpath=//*[@id="barcode"]
${SEARCH_FIELD_NAME}      xpath=//*[@id="name"]
${SEARCH_FIELD_PPV}      xpath=//*[@id="sale_price"]
${SEARCH_FIELD_ZONE}      id=zone_id.q
${REMISE_BUTTON}      css=button.sob-v2-btn:nth-child(2)
${DISCOUNT_INPUT}      id=global_discount
${TYPE_SELECT}        id=global_discount_type
${DISCOUNT_SELECT}      id=global_discount_application_type
${DISCOUNT_SUBMITE}       xpath=//*[@data-testid="appliquer"]
@{PU_LIST}

*** Test Cases ***
aller à la page Générer document
      Go To    ${BASE_URL}/generatetmpdocuments
    sleep    1s
    Wait Until Element Is Visible      xpath=//*[@data-testid="suivant"]    timeout=30s


Aller à la page Générer une facture
     Aller à la page Générer une facture

soumettre un formulaire vide
    cliquer sur imprimer
    vérifier le popup vide
remplir les champs
    remplir les champs
Rechercher par nom de produit
     [Tags]  recherche par  nom de produit
   Vérifier que les champs de recherche sont visibles
    Vérifier que le champ de saisie est vide
    Saisir la recherche par nom de produit
    Vérifier les résultats de recherche par nom de produit


Recherche avancée par nom (contient et commence par)
    Vérifier que le champ de saisie est vide
    Saisir la recherche par nom
    Vérifier les résultats de recherche par nom (contient)
     Vérifier les résultats de recherche par nom (commence par)
Recherche avancée par PPV
    Vérifier que le champ de saisie est vide
    Saisir la recherche par PPV
    Vérifier les résultats de recherche par PPV

Recherche avancée par zone
    Vérifier que le champ de saisie est vide
    Saisir la recherche par zone
    Vérifier les résultats de recherche par zone

Vérifier le popup produit multi-prix
    sélectionner un produit
    Vérifier le popup produit multi-prix

sélectionner un produit avec popup TVA
    Saisir la recherche par nom de produit
    Vérifier les résultats de recherche par nom de produit
    sélectionner un produit
    Vérifier le popup TVA produit

sélectionner plusieurs produits avec TVA
    sélectionner le produit 2
    Vérifier le popup prix produit
choisir le produit une seconde fois et vérifier la quantité
     [Tags]  choisir le produit une seconde fois et vérifier la quantité
    sélectionner le produit deux fois et vérifier le total et le nombre

vérifier la remise par produit (type % )
    ouvrir le popup remise
    remise par produit
    soumettre la remise
    vérifier la remise par produit %
    vérifier que le total est valide
vérifier la remise par montant produit (type % )
    ouvrir le popup remise
     remise par montant produit %

vérifier la remise par rectification du total
    ouvrir le popup remise
     remise par rectification du total
annuler la remise
    ouvrir le popup remise
    annuler la remise
    soumettre la remise
vérifier la remise par produit type montant
    ouvrir le popup remise
    remise par produit ( type montant )
    remise par produit
    soumettre la remise
    vérifier la remise par produit type montant
    vérifier que le total est valide
vérifier la remise par montant produit type montant
    ouvrir le popup remise
     remise par montant produit type montant
cliquer sur imprimer et vérifier le résultat
    cliquer sur imprimer
*** Keywords ***
Aller à la page Générer une facture
     wait until element is visible      xpath=//*[@data-testid="suivant"]
     click element      xpath=//*[@data-testid="suivant"]
     wait until element is visible      ${print}
cliquer sur imprimer
    click element    ${print}
     sleep    5s
vérifier le popup vide
     Page Should Contain    Vous devez choisir au moins un produit avec une quantité supérieur à 0.

remplir les champs
     #customer
    input text   id=customer_id     automated test
     #doctor
    input text    xpath=//*[@id="doctor"]     automated test
    #adress
    input text    xpath=//*[@id="address"]      automated test
    #city
    input text    xpath=//*[@id="city"]       automated test
    #code postal
    input text    xpath=//*[@id="postal_code"]     234567
    #Numéro de transaction
    input text    xpath=//*[@id="transaction_number"]     Fac-12


Vérifier que les champs de recherche sont visibles
    Wait Until Element Is Visible  ${SEARCH_FIELD_PRODUCT_NAME}
    Wait Until Element Is Visible  ${SEARCH_FIELD_NAME}
    Wait Until Element Is Visible  ${SEARCH_FIELD_PPV}
    Wait Until Element Is Visible  ${SEARCH_FIELD_ZONE}

Vérifier que le champ de saisie est vide
        ${product} =    Get Value    ${SEARCH_FIELD_PRODUCT_NAME}
        ${name} =    Get Value    ${SEARCH_FIELD_NAME}
        ${ppv} =    Get Value    ${SEARCH_FIELD_PPV}
        ${zone} =    Get Value    ${SEARCH_FIELD_ZONE}
        Should Be Empty    ${product}
        Should Be Empty    ${name}
        Should Be Empty    ${ppv}
        Should Be Empty    ${zone}

Saisir la recherche par nom de produit
    ${product_input}  Set Variable    dolipran
    Input Text  ${SEARCH_FIELD_PRODUCT_NAME}  ${product_input}

Vérifier les résultats de recherche par nom de produit
    ${expected_result}   Set Variable    dolipran
       Press Keys  ${SEARCH_FIELD_PRODUCT_NAME}  RETURN
      sleep    15s
    ${table_rows}  Get Element Count      css=.prevent-select > tr:nth-child(1)
    Should Be True  ${table_rows} > 0
     FOR  ${row}  IN RANGE  1  ${table_rows} + 1
      ${cell_text}  get text      css=.prevent-select > tr:nth-child(${row}) > td:nth-child(1)
      Should Contain  ${cell_text}  ${expected_result}      ignore_case=True
    END
#name
Saisir la recherche par nom
    ${name_input}  Set Variable    test
    Input Text  ${SEARCH_FIELD_NAME}  ${name_input}
Vérifier les résultats de recherche par nom (contient)
    ${expected_result}   Set Variable    test
       Press Keys  ${SEARCH_FIELD_PRODUCT_NAME}  RETURN
      sleep    5s
    ${table_rows}  Get Element Count   css=.prevent-select > tr:nth-child(1)
    Should Be True  ${table_rows} > 0
     FOR  ${row}  IN RANGE  1  ${table_rows} + 1
      ${cell_text}  get text    css=.prevent-select > tr:nth-child(${row}) > td:nth-child(1)
      Should Contain  ${cell_text}  ${expected_result}      ignore_case=True
    END
Vérifier les résultats de recherche par nom (commence par)
     click element    css=#react-select-4-input
      sleep    2s
      click element    css=#react-select-4-option-1
    ${expected_result}   Set Variable    test
    Input Text  ${SEARCH_FIELD_NAME}  ${expected_result}
       Press Keys  ${SEARCH_FIELD_PRODUCT_NAME}  RETURN
      sleep    5s
    ${table_rows}  Get Element Count   css=.prevent-select > tr:nth-child(1)
    Should Be True  ${table_rows} > 0
     FOR  ${row}  IN RANGE  1  ${table_rows} + 1
      ${cell_text}  get text    css=.prevent-select > tr:nth-child(${row}) > td:nth-child(1)
       should start with  ${cell_text}  ${expected_result}      ignore_case=True
    END

        #ppv
Saisir la recherche par PPV
    ${ppv_input}  Set Variable    10.00
    Input Text  ${SEARCH_FIELD_PPV}  ${ppv_input}
Vérifier les résultats de recherche par PPV
    ${expected_result}   Set Variable    10.00
       Press Keys  ${SEARCH_FIELD_PRODUCT_NAME}  RETURN
      sleep    5s
    ${table_rows}  Get Element Count  css=.prevent-select > tr:nth-child(1)
    Should Be True  ${table_rows} > 0
     FOR  ${row}  IN RANGE  1  ${table_rows} + 1
      ${cell_text}  get text   css=.prevent-select > tr:nth-child(${row}) > td:nth-child(2)
      should be equal    ${cell_text}  ${expected_result}      ignore_case=True
    END
     #zone
Saisir la recherche par zone
   Click Element    ${SEARCH_FIELD_ZONE}
    Wait Until Element Is Visible   ${LISTE_DEROULANTE}     10s
Vérifier les résultats de recherche par zone
  FOR  ${i}  IN RANGE  2  4
        click element    css:#react-select-5-option-${i}
        sleep    5s
     Click Element    ${SEARCH_FIELD_ZONE}
        Wait Until Element Is Visible  ${LISTE_DEROULANTE}      10s
          ${value} =  Get Text  css:#react-select-5-option-${i}
            ${table_rows}  Get Element Count  css=.prevent-select > tr:nth-child(1)
                     Should Be True  ${table_rows} > 0
                     FOR  ${row}  IN RANGE  1  ${table_rows} + 1
                     ${cell_text}  get text    css=.prevent-select > tr:nth-child(${row}) > td:nth-child(3)
                    should be equal    ${cell_text}  ${value}
                  END
    END


sélectionner un produit
    ${cell_product_name}  get text   xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[1]/div/div/div[4]/table/tbody/tr[1]/td[1]
   click element       xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[1]/div/div/div[4]/table/tbody/tr[1]/td[1]
    Wait Until Element Is Visible   xpath=/html/body/div[3]/div/div/div[1]/div/p  15s
    click element     xpath=/html/body/div[3]/div/div/div[1]/div/p
      ${product_name_popup}  get text     css=.pricepopup__header
     should contain     ${cell_product_name}     ${product_name_popup}

Vérifier le popup produit multi-prix
    ${product_name_popup}  get text    css=.pricepopup__header
       ${product_ppv_popup}  get text  xpath=/html/body/div[3]/div/div/div[2]/div[2]/div[2]/label/span
       click element    xpath=/html/body/div[3]/div/div/div[2]/div[2]/div[2]
        ${product_name_from_list}  get text  xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[3]/table/tbody/tr[2]/td[2]/span
        ${product_ppv_from_list}  get text  xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[3]/table/tbody/tr[2]/td[3]/span

          Append To List    ${PU_LIST}    ${product_ppv_from_list}
        should contain     ${product_name_popup}     ${product_name_from_list}
        should contain     ${product_ppv_popup}     ${product_ppv_from_list}

Vérifier le popup TVA produit
    ${product_name_popup}  get text      css=.pricepopup__header
       ${product_ppv_popup}  get text  xpath=/html/body/div[3]/div/div/div[2]/div[2]/div[1]/div[1]/div/label/span/span[3]
       click element    xpath=/html/body/div[3]/div/div/div[2]/div[2]/div[1]/div[1]/div
        ${product_name_from_list}  get text  xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[3]/table/tbody/tr[2]/td[2]/span
        ${product_ppv_from_list}  get text  xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[3]/table/tbody/tr[2]/td[3]/span
        Append To List    ${PU_LIST}    ${product_ppv_from_list}
        should contain     ${product_name_from_list}     ${product_name_popup}
        should contain     ${product_ppv_popup}     ${product_ppv_from_list}

sélectionner le produit 2
    ${cell_product_name}  get text    xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[1]/div/div/div[4]/table/tbody/tr[2]/td[1]
   click element     xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[1]/div/div/div[4]/table/tbody/tr[2]
    Wait Until Element Is Visible    xpath=/html/body/div[3]/div/div/div[1]/div/p  10s
      ${product_name_popup}  get text    css=.pricepopup__header
     should contain     ${cell_product_name}     ${product_name_popup}

Vérifier le popup prix produit
      ${product_name_popup}  get text    css=.pricepopup__header
       ${product_ppv_popup}  get text    xpath=/html/body/div[3]/div/div/div[2]/div[2]/div[2]/div[2]/div/label/span/span[3]
       click element    xpath=/html/body/div[3]/div/div/div[2]/div[2]/div[2]/div[2]/div/label/span/span[3]
        ${product_name_from_list}  get text  xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[3]/table/tbody/tr[2]/td[2]/span
        ${product_ppv_from_list}  get text  xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[3]/table/tbody/tr[2]/td[3]/span
        Append To List    ${PU_LIST}    ${product_ppv_from_list}
        should contain     ${product_name_from_list}     ${product_name_popup}
        should contain     ${product_ppv_popup}     ${product_ppv_from_list}


sélectionner le produit deux fois et vérifier le total et le nombre
       ${cell_product_name}  get text    xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[1]/div/div/div[4]/table/tbody/tr[2]/td[1]
      ${cell_product_ppv}  get text    xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[1]/div/div/div[4]/table/tbody/tr[2]/td[2]
        click element     xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[1]/div/div/div[4]/table/tbody/tr[2]
        ${product_number_from_list}  get text  xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[3]/table/tbody/tr[2]/td[1]
        ${product_name_from_list}  get text  xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[3]/table/tbody/tr[2]/td[2]/span
        ${product_ppv_from_list}  get text  xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[3]/table/tbody/tr[2]/td[3]/span
        ${product_total_from_list}  get text  xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[3]/table/tbody/tr[2]/td[4]
         ${value_total}  Evaluate      ${product_ppv_from_list} * 2

        should contain     ${cell_product_name}     ${product_name_from_list}
        should be equal     ${product_number_from_list}     2
        should be equal As Numbers     ${product_total_from_list}     ${value_total}


ouvrir le popup remise
    click element   ${REMISE_BUTTON}
     Wait Until Element Is Visible    ${DISCOUNT_INPUT}    20s
remise par produit
    input text    ${DISCOUNT_INPUT}     10
soumettre la remise
      click element   ${DISCOUNT_SUBMITE}
vérifier la remise par produit %
    ${table_rows}  Get Element Count    css=.prevent-select > tr:nth-child(1)
        Should Be True  ${table_rows} > 0
        FOR  ${row}  IN RANGE  2    ${table_rows} - 2  5
          ${cell_text}  get text    xpath=/html/body/div/div[4]/div/div/div[2]/div/div[2]/div/div/div[3]/table/tbody/tr[${row}]/td[3]/span[1]
           @{result_list}    Create List
           FOR  ${index}  IN RANGE    0    3
              ${value}  Get From List    ${PU_LIST}  ${index}
               ${result}     Evaluate     format(round( ${value} - (( ${value} * 10) / 100) , 2), ".2f").replace("0.00", "0")
               append To List    ${result_list}    ${result}
            END

           Should Contain  ${result_list}  ${cell_text}  in
        END

vérifier que le total est valide
    ${product1}    get text    xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[3]/table/tbody/tr[2]/td[4]
    ${product2}    get text    xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[3]/table/tbody/tr[7]/td[4]
    ${product3}    get text    xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[3]/table/tbody/tr[12]/td[4]
    ${totals}     Evaluate    float(${product1}) + float(${product2}) + float(${product3})
     ${totals_string}    convert to string    ${totals}
     ${total_span}    get text    xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[2]/div[2]/p/span[1]
       should be equal    ${totals_string}  ${total_span}

remise par montant produit %
           ${tota}    get text    xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[2]/div[2]/p/span[1]
          ${result}     Evaluate     format(round( ${tota} - (( ${tota} * 10) / 100) , 2), ".2f").replace("0.00", "0")
        ${result}    convert to string    ${result}
        ${t}      set variable     ${result}
        click element    ${discount_select}
        sleep     2s
      click element        css=#react-select-18-option-1
      sleep    2s
      input text    ${DISCOUNT_INPUT}     10
        click element   ${DISCOUNT_SUBMITE}
      ${total_span}    get text     xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[2]/div[2]/p/span[1]
       should be equal    ${t}  ${total_span}

remise par rectification du total
     ${tota}    get text     xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[2]/div[2]/p/span[1]
        click element    css=#react-select-20-input
        sleep    2s
      click element       css=#react-select-20-option-2
      sleep    2s
       input text   xpath=/html/body/div[3]/div/div/div[2]/div[2]/div/input  60
        click element   ${DISCOUNT_SUBMITE}
         ${total_span}    get text     xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[2]/div[2]/p/span[1]
          should be equal    ${total_span}     60

annuler la remise
  input text    ${DISCOUNT_INPUT}     0
remise par produit ( type montant )
      click element    ${type_select}
      click element       css=#react-select-25-option-1
       sleep     2s
vérifier la remise par produit type montant
    ${table_rows}  Get Element Count    css=.prevent-select > tr:nth-child(1)
        Should Be True  ${table_rows} > 0
        FOR  ${row}  IN RANGE  2    ${table_rows} - 2  5
          ${cell_text}  get text   xpath=/html/body/div/div[4]/div/div/div[2]/div/div[2]/div/div/div[3]/table/tbody/tr[${row}]/td[3]/span[1]
           @{result_list}    Create List
           FOR  ${index}  IN RANGE    0    3
              ${value}  Get From List    ${PU_LIST}  ${index}
               ${result}     Evaluate     (${value} - 10 ) + ( ${value} - 10 ) +( ${value} - 10 )
               append To List    ${result_list}    ${result}
            END

           Should Contain  ${PU_LIST}  ${cell_text}  in
        END

remise par montant produit type montant
           ${tota}    get text     xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[2]/div[2]/p/span[1]
            ${result}     Evaluate     ${tota} - 10
            ${result}    convert to string    ${result}
            ${t}      set variable     ${result}
      click element    css=#react-select-26-input
      click element       css=#react-select-26-option-1
       sleep     2s
       click element   css=#react-select-27-input
      click element        css=#react-select-27-option-1
      sleep    2s
      input text    ${DISCOUNT_INPUT}     10
        click element   ${DISCOUNT_SUBMITE}
      ${total_span}    get text     xpath=/html/body/div[1]/div[4]/div/div[2]/div/div[2]/div/div/div[2]/div[2]/p/span[1]
       should be equal    ${t}  ${total_span}

