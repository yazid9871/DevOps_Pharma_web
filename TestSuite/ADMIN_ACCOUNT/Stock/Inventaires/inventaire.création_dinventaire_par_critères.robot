
*** Settings ***
Documentation     Tests fonctionnels de la 'Création d’un inventaire par criteres."
Library           SeleniumLibrary
Library    Collections

Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags       Création d’un inventaire par criteres.


*** Variables ***

${url_creqte_page}     0


*** Test Cases ***
accède à la page de création d'inventaire.

    Accéder à la page inventaire
    Accéder à la page de création d'un inventaire

choisis methode critères
     choisis methode critères
     clique sur le bouton "suivant"
     Vérifier que la page concerne

choisis methode critères par : Forme galénique
      Accéder à la page de création d'un inventaire par url
     choisis methode critères
     sélectionner Forme galénique
     clique sur le bouton "suivant"
     Vérifier que la page concerne
choisis methode critères par : Inclure les produits non utilisés
      Accéder à la page de création d'un inventaire par url
     choisis methode critères
     sélectionner Inclure les produits non utilisés
     clique sur le bouton "suivant"
     Vérifier que la page concerne
choisis methode critères par : Zone
     Accéder à la page de création d'un inventaire par url
     choisis methode critères
     sélectionner zone
     clique sur le bouton "suivant"
     Vérifier que la page concerne

*** Keywords ***
Accéder à la page inventaire
    [Documentation]    Navigate to the product listing page after logging in.
    Go To    ${BASE_URL}/stock/stocktakes
    Wait Until Element Is Visible     xpath=//*[@data-testid="créer"]    timeout=30s

Accéder à la page de création d'un inventaire
    click element      xpath=//*[@data-testid="créer"]
     wait until page contains    Créer un nouvel inventaire     5s
       ${url}      get location
      set Global variable   ${url_creqte_page}    ${url}

choisis methode critères
    click element     id=method
     wait until element is visible      css=.sob-v2-select__option:nth-child(2)
       click element      css=.sob-v2-select__option:nth-child(2)
clique sur le bouton "suivant"
     click element      xpath=//*[@data-testid="suivant"]
Vérifier que la page concerne
     wait until page contains     Inventaire    5s
     ${table_rows}  Get Element Count      xpath=//div[@class='zoom']
    IF     ${table_rows} == 0
                   wait until page contains      Informations introuvables    10s
    ELSE
            wait until element is visible      xpath=//div[@class='sob-v2-inputContainer']
    END
Accéder à la page de création d'un inventaire par url
        go to     ${url_creqte_page}
        sleep    3s
sélectionner Forme galénique
     click element    id=product_galenic_form_id
     wait until element is visible      css=.sob-v2-select__option:nth-child(2)
       click element      css=.sob-v2-select__option:nth-child(2)
sélectionner Inclure les produits non utilisés
     select checkbox    id=show_all_products
sélectionner zone

        Execute JavaScript  window.scrollTo(0,  0)
         sleep    3s
       click element    id=zone_id
     wait until element is visible      css=.sob-v2-select__option:nth-child(2)
       click element      css=.sob-v2-select__option:nth-child(2)