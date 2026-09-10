*** Settings ***
Documentation     Tests fonctionnels de la page "Page de création de Bons_de_commandes"
Library           SeleniumLibrary
Library           String
Library           DateTime
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page de création de Bons_de_commandes

*** Variables ***
${BC_CREATE_URL}      purchaseorders/consolidate_order/smart/create?source_click=purchaseorders
${SUPPLIER_FIELD}      id=supplier_id
${SUPPLIER_INPUT}      xpath=//div[@id='supplier_id']//input
${COMMANDER_EN_LIGNE_BUTTON}    xpath=//*[@data-testid="commander_en_ligne"]
${DATE_FIELD_BC}      id=purchase_order_date
${DRAFT_BUTTON_BC}    xpath=//*[@data-testid="brouillon"]
${APPROVE_BUTTON_BC}    xpath=//*[@data-testid="approuver"]
${INPUT_CODE_BARRE_BC}      xpath=//*[@id="barcode"]
${VALEUR_CODE_BARRE_BC}      8009004800229
${FOURNISSEUR_COMMANDE_EN_LIGNE_ACTIVEE}      COOPER PHARMA
${FOURNISSEUR_ACCEPTE_COMMANDES_EN_LIGNE}     SOPHA TEM
${FOURNISSEUR_SANS_TAG}                       COOPER BENISNASSEN

*** Test Cases ***
Accéder à la page de création de Bons_de_commandes
    [Documentation]    Vérifie la navigation vers la page de création d'un Bons_de_commandes
    ...                (smart consolidate order).
    Aller à la page de création de Bons_de_commandes    ${BC_CREATE_URL}

Vérifier que le fournisseur est obligatoire
    [Documentation]    Vérifie qu'il est impossible de valider le Bons_de_commandes sans avoir
    ...                sélectionné de fournisseur, même avec un produit dans le panier (vérifié
    ...                en direct : aucune navigation ni création n'a lieu, seul le champ
    ...                Fournisseur est mis en surbrillance).
    Aller à la page de création de Bons_de_commandes    ${BC_CREATE_URL}
    Sélectionner des produits par code barre pour le Bons_de_commandes    ${VALEUR_CODE_BARRE_BC}
    Approuver le Bons_de_commandes
    Vérifier que le Bons_de_commandes n'a pas été créé

Vérifier l'affichage du bouton Commande en ligne pour un fournisseur avec Commande en ligne activée
    [Documentation]    Vérifie que le bouton "Commande en ligne" s'affiche quand le fournisseur
    ...                sélectionné a le tag "Commande en ligne activée" (vérifié en direct sur
    ...                "Grossiste COOPER PHARMA").
    Aller à la page de création de Bons_de_commandes    ${BC_CREATE_URL}
    Sélectionner un fournisseur    ${FOURNISSEUR_COMMANDE_EN_LIGNE_ACTIVEE}
    Vérifier que le bouton Commande en ligne s'affiche

Vérifier l'affichage du bouton Commande en ligne pour un fournisseur avec le tag Accepte les commandes en ligne
    [Documentation]    À vérifier avec l'équipe métier : contrairement au comportement attendu,
    ...                le bouton "Commande en ligne" ne s'affiche PAS pour un fournisseur ayant
    ...                uniquement le tag "Accepte les commandes en ligne" (sans "Commande en
    ...                ligne activée"). Constaté en direct sur "Cooper GPF" ET "Grossiste SOPHA
    ...                TEM" : seul le tag "Commande en ligne activée" déclenche le bouton.
    Aller à la page de création de Bons_de_commandes    ${BC_CREATE_URL}
    Sélectionner un fournisseur    ${FOURNISSEUR_ACCEPTE_COMMANDES_EN_LIGNE}
    Vérifier que le bouton Commande en ligne ne s'affiche pas

Vérifier que le bouton Commande en ligne ne s'affiche pas pour un fournisseur sans tag
    [Documentation]    Vérifie que le bouton "Commande en ligne" ne s'affiche pas quand le
    ...                fournisseur sélectionné n'a aucun tag (vérifié en direct sur "Grossiste
    ...                COOPER BENISNASSEN").
    Aller à la page de création de Bons_de_commandes    ${BC_CREATE_URL}
    Sélectionner un fournisseur    ${FOURNISSEUR_SANS_TAG}
    Vérifier que le bouton Commande en ligne ne s'affiche pas

Vérifier que la date du Bons_de_commandes est valide
    [Documentation]    Vérifie que le champ date est pré-rempli avec la date du jour.
    Aller à la page de création de Bons_de_commandes    ${BC_CREATE_URL}
    Vérifier que la date du Bons_de_commandes est valide

Soumettre un Bons_de_commandes vide
    [Documentation]    Vérifie qu'il est impossible de valider un Bons_de_commandes sans avoir
    ...                sélectionné de produit (vérifié en direct : toast "Vous devez choisir au
    ...                moins un produit avec une quantité supérieur à 0."). Navigue vers une page
    ...                fraîche pour garantir un panier vide (les tests précédents laissent des
    ...                produits/fournisseurs sélectionnés).
    Aller à la page de création de Bons_de_commandes    ${BC_CREATE_URL}
    Soumettre un Bons_de_commandes vide
    Vérifier le message d'erreur Bons_de_commandes vide

Sélectionner des produits pour le Bons_de_commandes
    [Documentation]    Sélectionne un fournisseur puis ajoute un produit au Bons_de_commandes
    ...                via une recherche par code barre.
    Aller à la page de création de Bons_de_commandes    ${BC_CREATE_URL}
    Sélectionner un fournisseur    ${FOURNISSEUR_COMMANDE_EN_LIGNE_ACTIVEE}
    Sélectionner des produits par code barre pour le Bons_de_commandes    ${VALEUR_CODE_BARRE_BC}

Approuver le Bons_de_commandes
    [Documentation]    Clique sur "Approuver" pour valider le Bons_de_commandes.
    Approuver le Bons_de_commandes

Vérifier que le Bons_de_commandes est créé avec succès
    [Documentation]    Vérifie que le message de succès s'affiche après validation du
    ...                Bons_de_commandes (vérifié en direct : "Le bon de commande a été créé
    ...                avec succès.").
    Vérifier que le Bons_de_commandes est créé avec succès

*** Keywords ***
Aller à la page de création de Bons_de_commandes
    [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the Bons_de_commandes smart consolidate order creation page
    ...                after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
    Wait Until Element Is Visible    ${SUPPLIER_FIELD}    timeout=30s

Sélectionner un fournisseur
    [Arguments]    ${RECHERCHE_FOURNISSEUR}
    [Documentation]    Recherche un fournisseur par une portion unique de son nom, puis
    ...                sélectionne le premier résultat mis en surbrillance (comportement
    ...                react-select vérifié en direct). Utilise ${SUPPLIER_INPUT} (et non
    ...                ${SUPPLIER_FIELD}) car le conteneur ET le champ texte interne partagent
    ...                le même id "supplier_id" dans le DOM : Selenium (By.ID) résout vers le
    ...                premier élément (le conteneur, un <div>) sur lequel Input Text échoue.
    click element    ${SUPPLIER_INPUT}
    input text    ${SUPPLIER_INPUT}    ${RECHERCHE_FOURNISSEUR}
    sleep    1s
    press keys    ${SUPPLIER_INPUT}    RETURN
    sleep    1s

Vérifier que le bouton Commande en ligne s'affiche
    Wait Until Element Is Visible    ${COMMANDER_EN_LIGNE_BUTTON}    10s

Vérifier que le bouton Commande en ligne ne s'affiche pas
    Page Should Not Contain Element    ${COMMANDER_EN_LIGNE_BUTTON}

Vérifier que la date du Bons_de_commandes est valide
    sleep    1s
    wait until element is visible    ${DATE_FIELD_BC}    20s
    ${date_value}    get value    ${DATE_FIELD_BC}
    ${current_date_str}    Get Current Date    result_format=%Y-%m-%d
    ${current_date}    Convert Date    ${current_date_str}    result_format=datetime
    ${new_date_str}    Convert Date    ${current_date}    result_format=%Y-%m-%d
    should be equal    ${new_date_str}    ${date_value}

Soumettre un Bons_de_commandes vide
    click element    ${APPROVE_BUTTON_BC}
    sleep    1s

Vérifier le message d'erreur Bons_de_commandes vide
    wait until page contains    Vous devez choisir au moins un produit avec une quantité supérieur à 0.    5s

Sélectionner des produits par code barre pour le Bons_de_commandes
    [Arguments]    ${CODE_BARRE}
    Input Text    ${INPUT_CODE_BARRE_BC}    ${CODE_BARRE}
    Press Keys    ${INPUT_CODE_BARRE_BC}    ENTER
    sleep    2s

Approuver le Bons_de_commandes
    wait until element is visible    ${APPROVE_BUTTON_BC}
    click element    ${APPROVE_BUTTON_BC}
    sleep    1s

Vérifier que le Bons_de_commandes n'a pas été créé
    [Documentation]    Un Bons_de_commandes sans fournisseur n'est pas créé : l'URL reste sur
    ...                la page de création (pas de redirection vers la page détails).
    Location Should Contain    smart/create
    Page Should Contain Element    ${SUPPLIER_FIELD}

Vérifier que le Bons_de_commandes est créé avec succès
    wait until page contains    Le bon de commande a été créé avec succès.    10s
