
*** Settings ***
Documentation     Tests fonctionnels de la 'Création d’un inventaire par vendu."
Library           SeleniumLibrary
Library    Collections

Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags       Création d’un inventaire par vendu.



*** Test Cases ***
accède à la page de création d'inventaire.

    Accéder à la page inventaire
    Accéder à la page de création d'un inventaire

choisis methode vendu
     choisis methode vendu
clique sur le bouton "suivant"
     clique sur le bouton "suivant"
sauvegarder et verifier resultat
     Vérifier la page
     sauvegarder
*** Keywords ***

Accéder à la page inventaire
    [Documentation]    Navigate to the product listing page after logging in.
    Go To    ${BASE_URL}/stock/stocktakes
    Wait Until Element Is Visible       xpath=/html/body/div/div[1]/div[5]/div[1]/div[2]/button[3]   timeout=30s

Accéder à la page de création d'un inventaire
    click element     xpath=/html/body/div/div[1]/div[5]/div[1]/div[2]/button[3]
     wait until page contains    Créer un nouvel inventaire     5s




choisis methode vendu
    click element     id=method
     wait until element is visible      css=.sob-v2-select__option:nth-child(3)
       click element      css=.sob-v2-select__option:nth-child(3)
selectionne une period
     click element    id=start_date
     wait until element is visible        css=.react-datepicker__day--01
       click element        css=.react-datepicker__day--01
         click element    id=end_date
     wait until element is visible     css=.react-datepicker__day--010
       click element     css=.react-datepicker__day--010
clique sur le bouton "suivant"
     click element      xpath=//*[@data-testid="suivant"]
Vérifier la page
     wait until page contains     Inventaire    5s
     ${table_rows}  Get Element Count      xpath=//div[@class='zoom']
    IF     ${table_rows} == 0
                   wait until page contains      Informations introuvables    10s
    ELSE
            wait until element is visible      xpath=//div[@class='sob-v2-inputContainer']
    END
sauvegarder
     click element     xpath=//*[@data-testid="sauvegarder_&_continuer"]
     wait until page contains     Votre inventaire a été modifié avec succès    10s
     click element     xpath=//*[@data-testid="sauvegarder"]
     wait until page contains