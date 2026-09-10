*** Settings ***
Documentation     Tests fonctionnels de la page " Page de création de Avoirs_fournisseurs_émis sans fournisseur"
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
Force Tags         Page de création de Avoirs_fournisseurs_émis sans fournisseur
*** Variables ***
${draft_button}      xpath=//*[@data-testid="approuver"]
${loop_button}   xpath=//div[@class='table__search__inputs']//button[@data-testid='false']
${table}           //tbody[contains(@class, 'prevent-select')]//tr

${approv_button}        xpath=//*[@data-testid="approuver"]
${amount}     0
*** Test Cases ***
Accéder À La Page De Création D'un Avoir Fournisseur Émis
        Go To Avoirs_fournisseurs_émis Listing Page       purchasesissuedreturn/create
Vérifier Que La Date De L'Avoir Fournisseur Émis Est Valide
      Verify Date Field Is Valid
Soumettre Un Avoir Fournisseur Émis Vide
    submit Avoirs_fournisseurs_émis
verify pop up empty Avoirs_fournisseurs_émis
    verify pop up empty Avoirs_fournisseurs_émis
Sélectionner Les Produits
    Sélectionner des produits par code barre      8009004800229
Tenter De Valider Sans Fournisseur
   Tenter De Valider Sans Fournisseur
Vérifier Que Je Ne Peux Pas Valider Sans Fournisseur
   Vérifier Le Message D'erreur
Sélectionner Le Fournisseur
    select supplier    ${SUPPLIER_NAME}
Cliquer Sur Sauvegarder
    Cliquer Sur Sauvegarder
Vérifier Que L'Avoir Fournisseur Émis A Été Ajouté Avec Succès
    Vérifier Que L'Avoir Fournisseur Émis A Été Ajouté Avec Succès
Aller À La Page Détails Et Vérifier Le Statut
    Aller À La Page Détails Et Vérifier Le Statut    Brouillon
Cliquer Sur Modifier
    Cliquer Sur Modifier
Cliquer Sur Approuver
    Cliquer Sur Approuver
Vérifier Que La Création Est Complétée
    Vérifier Que L'Avoir Fournisseur Émis A Été Ajouté Avec Succès
    Aller À La Page Détails Et Vérifier Le Statut    Complété

*** Keywords ***

Go To Avoirs_fournisseurs_émis Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the product listing page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
     Wait Until Element Is Visible   ${draft_button}  timeout=30s

verify pop up empty Avoirs_fournisseurs_émis
    wait until page contains    Vous devez choisir au moins un produit avec une quantité supérieur à 0.     5s
     click element      xpath=//div[@class='sob-v2-toastr__icon']
     sleep     3s
Verify Date Field Is Valid
     [Documentation]    Contrairement à Vente (id=invoice_date, format DD/MM/YYYY), le champ
     ...                Date d'un Avoir fournisseur émis a l'id "date" et un format YYYY-MM-DD.
       sleep    1s
     wait until element is visible       css=#date input      20s
    ${date_value}    get value    css=#date input
   ${current_date_str}    Get Current Date    result_format=%Y-%m-%d
    should be equal     ${current_date_str}    ${date_value}
submit Avoirs_fournisseurs_émis
    click element    ${draft_button}
     sleep    5s

Tenter De Valider Sans Fournisseur
     [Documentation]    Aucun fournisseur n'est sélectionné à ce stade : Approuver doit être
     ...                bloqué par la validation du champ Fournisseur (obligatoire), sans écran
     ...                de paiement intermédiaire (contrairement au blocage "vente à crédit sans
     ...                client" testé côté Vente).
     click element    ${approv_button}
     sleep    2s

Vérifier Le Message D'erreur
    wait until page contains    Ce champ est requis     5s
    sleep    2s

Cliquer Sur Sauvegarder
    [Documentation]    Une fois le fournisseur renseigné, Sauvegarder enregistre l'avoir en
    ...                statut Brouillon (contrairement à Retours sur ventes, où "Sauvegarder"
    ...                mène directement à un écran de paiement réel).
    wait until element is visible    xpath=//*[@data-testid="sauvegarder"]     10s
    click element    xpath=//*[@data-testid="sauvegarder"]
    sleep    2s

Vérifier Que L'Avoir Fournisseur Émis A Été Ajouté Avec Succès
    [Documentation]    Message réel confirmé en direct : "L'avoir fournisseur émis a été
    ...                enregistré avec succès!". On vérifie un extrait sans l'apostrophe
    ...                typographique pour éviter tout souci d'encodage.
    sleep    1s
    wait until page contains    a été enregistré avec succès      10s

Aller À La Page Détails Et Vérifier Le Statut
    [Arguments]    ${statut_attendu}
    wait until element is visible    xpath=//*[@data-testid="afficher_l'avoir_fournisseur"]    10s
    click element    xpath=//*[@data-testid="afficher_l'avoir_fournisseur"]
    sleep    2s
    wait until page contains    ${SUPPLIER_NAME}
    wait until page contains    ${statut_attendu}

Cliquer Sur Modifier
    wait until element is visible    xpath=//*[@data-testid="modifier"]    10s
    click element    xpath=//*[@data-testid="modifier"]
    sleep    2s

Cliquer Sur Approuver
    wait until element is visible    ${approv_button}    10s
    click element    ${approv_button}
    sleep    2s
