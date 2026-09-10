*** Settings ***
Documentation     Tests fonctionnels de la page " Page de création de Sorties_confrères sans confrères"
Library           SeleniumLibrary
Library    Collections
Library    DateTime


Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/PageCreationMotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags         Page de création de Sorties_confrères sans confrères
*** Variables ***
${draft_button}      xpath=//div[@class='sob-breadcrumb__buttons']//button[@data-testid='false']
${loop_button}   xpath=//div[@class='table__search__inputs']//button[@data-testid='false']
${table}           //tbody[contains(@class, 'prevent-select')]//tr
${SEARCH_FIELD_CODEBARRE}      xpath=//*[@id="nameorbarecode.q"]

${approv_button}        xpath=//div[@class='sob-breadcrumb__buttons']//button[@data-testid='false']
${amount}     0
*** Test Cases ***
Accéder À La Page De Création D'une Sortie Confrère
        Go To Sorties_confrères Listing Page       colleagues/sales/create?pricing_field=sale_price
Vérifier Que La Date De La Sortie Confrère Est Valide
      Verify Date Field Is Valid
Soumettre Une Sortie Confrère Vide
    submit Sorties_confrères
verify pop up empty Sorties_confrères
    verify pop up empty Sorties_confrères
Sélectionner Les Produits
    Sélectionner des produits par code barre      8009004800229
Tenter De Valider Sans Confrère
   Tenter De Valider Sans Confrère
Vérifier Que Je Ne Peux Pas Valider Sans Confrère
   Vérifier Le Message D'erreur
Sélectionner Le Confrère
    Cliquer sur le champ    id=colleague_name
    Sélectionner dans le popup
Cliquer Sur Sauvegarder
    Cliquer Sur Sauvegarder
Vérifier Que La Sortie Confrère A Été Ajoutée Avec Succès
    Vérifier Que La Sortie Confrère A Été Ajoutée Avec Succès
Aller À La Page Détails Et Vérifier Le Statut
    Aller À La Page Détails Et Vérifier Le Statut    Brouillon
Cliquer Sur Modifier
    Cliquer Sur Modifier
Cliquer Sur Approuver
    Cliquer Sur Approuver
Vérifier Que La Création Est Complétée
    Vérifier Que La Sortie Confrère A Été Ajoutée Avec Succès
    Aller À La Page Détails Et Vérifier Le Statut    Complété

*** Keywords ***

Go To Sorties_confrères Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the product listing page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
     Wait Until Element Is Visible   ${draft_button}  timeout=30s

verify pop up empty Sorties_confrères
    wait until page contains    Vous devez choisir au moins un produit avec une quantité supérieur à 0.     5s
     click element      xpath=//div[@class='sob-v2-toastr__icon']
     sleep     3s
Verify Date Field Is Valid
     [Documentation]    Comme sur Entrées confrères/Avoirs fournisseurs émis, le champ Date a
     ...                un format YYYY-MM-DD. Ici l'élément id="date" est un DIV englobant (pas
     ...                l'input lui-même) : on cible donc l'input réel avec "css=#date input"
     ...                pour éviter de cibler le mauvais élément.
     sleep    1s
     wait until element is visible       css=#date input      20s
    ${date_value}    get value    css=#date input
   ${current_date_str}    Get Current Date    result_format=%Y-%m-%d
    should be equal     ${current_date_str}    ${date_value}
submit Sorties_confrères
    click element    ${draft_button}
     sleep    5s

Tenter De Valider Sans Confrère
     [Documentation]    Aucun confrère n'est sélectionné à ce stade : Approuver doit être
     ...                bloqué par la validation du champ Confrère (obligatoire), sans écran de
     ...                paiement intermédiaire.
     click element    ${approv_button}
     sleep    2s

Vérifier Le Message D'erreur
    wait until page contains    Ce champ est requis     5s
    sleep    2s

Cliquer Sur Sauvegarder
    [Documentation]    Une fois le confrère renseigné, Sauvegarder enregistre la sortie confrère
    ...                en statut Brouillon (comme Entrées confrères/Avoirs fournisseurs émis).
    wait until element is visible    xpath=//*[@data-testid="sauvegarder"]     10s
    click element    xpath=//*[@data-testid="sauvegarder"]
    sleep    2s

Vérifier Que La Sortie Confrère A Été Ajoutée Avec Succès
    [Documentation]    Message réel confirmé en direct : "La sortie du confrère a été
    ...                sauvegardé avec succès" (même formulation qu'Entrées confrères, avec
    ...                "sortie" au lieu d'"entrée"). On vérifie un extrait sans l'apostrophe
    ...                typographique pour éviter tout souci d'encodage.
    sleep    1s
    wait until page contains    a été sauvegardé avec succès      10s

Aller À La Page Détails Et Vérifier Le Statut
    [Arguments]    ${statut_attendu}
    wait until element is visible    xpath=//*[@data-testid="afficher_la_sortie_confrère"]    10s
    click element    xpath=//*[@data-testid="afficher_la_sortie_confrère"]
    sleep    2s
    wait until page contains    ${statut_attendu}

Cliquer Sur Modifier
    wait until element is visible    xpath=//*[@data-testid="modifier"]    10s
    click element    xpath=//*[@data-testid="modifier"]
    sleep    2s

Cliquer Sur Approuver
    wait until element is visible    ${approv_button}    10s
    click element    ${approv_button}
    sleep    2s
