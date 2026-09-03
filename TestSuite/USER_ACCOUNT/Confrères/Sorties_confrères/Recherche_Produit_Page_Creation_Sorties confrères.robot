*** Settings ***
Documentation     Tests fonctionnels de la page "Page de création de Sorties confrères"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page de création de   Sorties confrères


*** Variables ***
${INPUT_CODE_BARRE}      xpath=//*[@id="barcode"]
${INPUT_NOM}             xpath=//*[@id="name"]
${INPUT_PPV}             xpath=//*[@id="sale_price"]
${CLIENT_NAME}           aya
${CONTACT_NAME}          This is a test contact created by automation.
${table}                 //tbody[contains(@class, 'prevent-select')]//tr

${valeur_de_recheche_codebarre}       98783627517
${valeur_de_recheche_nom}       dolipran marque
${valeur_de_recheche_DCI}      ACARBOSE

*** Test Cases ***
Accéder à la page de création de Sorties confrères
     [Documentation]    Vérifie la navigation : connexion, accès à la liste des Sorties confrères
     ...                puis ouverture de la page de création d'un nouveau Sorties confrères .
     Accéder à la page     colleagues/sales/create?pricing_field=sale_price
     Wait Until Element Is Visible   ${INPUT_CODE_BARRE}  timeout=30s

Vérifier le choix du colleague
     [Documentation]    Vérifie que le champ "colleague_name" ouvre bien le popup de sélection des
     ...                clients et que le colleague_name sélectionné est correctement affiché.
     Cliquer sur le champ colleague_name
     Sélectionner le colleague_name dans le popup
     Vérifier que le colleague_name sélectionné est correct


Vérifier la recherche par code-barres
     [Documentation]    Vérifie que le champ "Nom ou code barre" est visible et permet une
     ...                recherche de produit.
     Vérifier que le champ de recherche produit est visible
     Saisir la recherche par code-barres     ${valeur_de_recheche_codebarre}
     Vérifier les résultats de recherche par code-barres

Vérifier la recherche par nom
     [Documentation]    Vérifie que la recherche avancée par nom fonctionne correctement.
     Effacer le champ de recherche produit
     Saisir la recherche par nom     ${valeur_de_recheche_nom}
     Vérifier les résultats de recherche par nom

Vérifier la recherche par PPV
     [Documentation]    Vérifie que la recherche avancée par PPV fonctionne correctement.
     Effacer le champ de recherche produit
     Saisir la recherche par PPV
     Vérifier les résultats de recherche par PPV

Vérifier la recherche par zone
     [Documentation]    Vérifie que la recherche avancée par zone fonctionne correctement.
     Effacer le champ de recherche produit
     Cliquer Sur Le Champ Zone Et Vérifier Les Résultats

Vérifier la recherche par DCI
     [Documentation]    Vérifie que la recherche avancée par DCI fonctionne correctement.
     [Documentation]    Vérifie que la recherche avancée par DCI fonctionne correctement.
     Effacer le champ de recherche produit
     Saisir la recherche par DCI
     Vérifier les résultats de recherche par DCI

*** Keywords ***

Vérifier que le champ de recherche produit est visible
    Wait Until Element Is Visible  ${INPUT_CODE_BARRE}

Effacer le champ de recherche produit
    Input Text    ${INPUT_CODE_BARRE}    ${EMPTY}

Saisir la recherche par code-barres
    [Arguments]     ${CODE_BARRE}
    Input Text       ${INPUT_CODE_BARRE}     ${CODE_BARRE}
    Press Keys     ${INPUT_CODE_BARRE}    ENTER
    sleep    2s

Vérifier les résultats de recherche par code-barres
    wait until page contains    mery testqw new from mobile 2      10s

Saisir la recherche par nom
      [Arguments]     ${Name}
    Input Text    ${INPUT_NOM}    ${Name}
    Press Keys    ${INPUT_NOM}    ENTER
    sleep    2s

Vérifier les résultats de recherche par nom
    ${expected_result}   Set Variable    ${valeur_de_recheche_nom}
    ${table_rows}  Get Element Count      xpath=${table}
    Should Be True  ${table_rows} > 0
    FOR  ${row}  IN RANGE  1  ${table_rows} + 1
        ${col}    set variable    [${row}]/td[1]
        ${xpath_tab}    set variable     ${table}${col}
        wait until element is visible     xpath=${xpath_tab}    20s
        ${cell_text}  get text   xpath=${xpath_tab}
        Should Contain  ${cell_text}  ${expected_result}      ignore_case=True
    END

Saisir la recherche par PPV
    Input Text    ${INPUT_PPV}    100.00
    Press Keys    ${INPUT_PPV}    ENTER
    sleep    2s

Vérifier les résultats de recherche par PPV
    ${expected_result}   Set Variable    100,00
    ${table_rows}  Get Element Count      xpath=${table}
    Should Be True  ${table_rows} > 0
    FOR  ${row}  IN RANGE  1  ${table_rows} + 1
        ${col}    set variable    [${row}]/td[2]
        ${xpath_tab}    set variable     ${table}${col}
        wait until element is visible     xpath=${xpath_tab}    20s
        ${cell_text}  get text   xpath=${xpath_tab}
        should be equal    ${cell_text}  ${expected_result}      ignore_case=True
    END

Cliquer Sur Le Champ Zone Et Vérifier Les Résultats
    click element    id=zone_id.q
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(2)    10s
    ${value}=    Get Text    css=.sob-v2-select__option:nth-child(2)
    click element    css=.sob-v2-select__option:nth-child(2)
    sleep    2s
    ${table_rows}  Get Element Count      xpath=${table}
    Should Be True  ${table_rows} > 0
    FOR  ${row}  IN RANGE  1  ${table_rows} + 1
        ${col}    set variable    [${row}]/td[3]
        ${xpath_tab}    set variable     ${table}${col}
        wait until element is visible     xpath=${xpath_tab}    20s
        ${cell_text}  get text   xpath=${xpath_tab}
        should be equal    ${cell_text}  ${value}
    END

Saisir la recherche par DCI
    input text    id=product_dci_id.q     ${valeur_de_recheche_DCI}
    Press Keys  id=product_dci_id.q  RETURN
    sleep    2s

Vérifier les résultats de recherche par DCI
    ${table_rows}  Get Element Count      xpath=${table}
    Should Be True  ${table_rows} > 0

Cliquer sur le champ colleague_name
    wait until element is visible      id=customer_name     10s
    click element    id=customer_name
    Wait Until Element Is Visible    css=tr.zoom:nth-child(1)     10s

Sélectionner le colleague_name dans le popup
    click element    css=tr.zoom:nth-child(1)
    sleep    1s

Vérifier que le colleague_name sélectionné est correct
    wait until element is visible    id=-supplier_name
    ${nom}=    Get Value    id=-supplier_name
    Should Not Be Empty    ${nom}
