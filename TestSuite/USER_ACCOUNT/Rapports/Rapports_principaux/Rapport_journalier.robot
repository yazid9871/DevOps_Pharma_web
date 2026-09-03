*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports Rapport journalier"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Resource        ../../../../Resources/Vérifier_que_le_téléchargement_commence.robot

Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags       Rapports   Rapport journalier

Documentation    Tests fonctionnels pour la page  Rapport journalier

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryeme.e@sobrus.com
${PASSWORD}  qw067012@

${TITRE_PAGE}                              Rapport journalier
${CHAMP_DATE}                             id=date
${date_DROPDOWN}                           css=.react-datepicker
${Button_details_vente}                    xpath=//div[@class='sob-v2-tabs-container sob-v2-tabs-container-color']//button[@data-testid='details']
${Button_details_achat}                   xpath=//div[@class='sob-v2-container'][1]//button[@data-testid='details']
${Button_details_Encaissements}           xpath=/html/body/div[1]/div/div[5]/div/div[4]/div[1]/div[2]/div/div/div[1]/div/button


*** Test Cases ***
Vérifier l'affichage de la page Rapport journalier
    [Documentation]    Vérifier affichage du rapport
      Accéder à la page    reports/daily
    wait until page contains    ${TITRE_PAGE}    10s

Select a specific date
    choisir un période
  Verify all section are visibeles
Test sections
    Test Tab Navigation sur section de vente
    Tester le bouton 'Détails' sur toutes les sections    ${Button_details_vente}     Rapport sur ventes
    Tester le bouton 'Détails' sur toutes les sections    ${Button_details_achat}     Rapports sur achats
    Tester le bouton 'Détails' sur toutes les sections    ${Button_details_Encaissements}     Encaissements par méthode de paiement


*** Keywords ***
Set Browser Zoom
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"


choisir un période
    #date debut
    click element    ${CHAMP_DATE}
     Wait Until Element Is Visible  ${date_DROPDOWN}    10s
      click element    css:button.react-datepicker__navigation:nth-child(3)
     sleep    5s
     click element     css=.react-datepicker__day--006
     #Saisir la date
       Clear Element Text    ${CHAMP_DATE}
    Input Text   ${CHAMP_DATE}     15/04/2025
       Set Browser Zoom    40
          sleep    2s
Verify all section are visibeles
     wait until page contains    Ventes
     wait until page contains    Achats
     wait until page contains  Encaissements par méthode de paiement
     wait until page contains   Paiements et règlements
     wait until page contains    Confrères
     wait until page contains     Produits


Test Tab Navigation sur section de vente
    Click Element    id=tab2
    sleep     1s
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    id=apexchartsexpirjek

    IF    ${is_visible}
    Page Should Contain    %)
    END

      Click Element    id=tab3
    sleep     1s
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    id=apexchartsexpirjek

    IF    ${is_visible}
    Page Should Contain    total vendu
    END

    Click Element    id=tab4
    sleep     1s
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    id=apexchartsexpirjek

    IF    ${is_visible}
    Page Should Contain    total vendu
    END

     Click Element    id=tab5
    sleep     1s
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    id=apexchartsexpirjek

    IF    ${is_visible}
    Page Should Contain    total
    END
Tester le bouton 'Détails' sur toutes les sections
    [Arguments]    ${Button_details}    ${rapport}

     Wait Until Element Is Visible    ${Button_details}       5s

    # Enregistrer l'identifiant de la fenêtre principale
     ${main_title}=    Get Title

    # Cliquer sur le bouton Détails qui va ouvrir une nouvelle fenêtre
    Click Element   ${Button_details}

    # Attendre l'apparition de la nouvelle fenêtre et basculer dessus
    Wait Until Keyword Succeeds    5s    1s   Switch Window    NEW

    # Vérifier que la page détails est bien chargée
    Wait Until Page Contains   ${rapport}      10s
    Page Should Contain     ${rapport}

     Close Window

    # Revenir à la fenêtre principale
     Switch Window    title=${main_title}

    # Vérifier que nous sommes bien revenus sur la fenêtre principale
    Wait Until Element Is Visible    ${Button_details_vente}     10s

