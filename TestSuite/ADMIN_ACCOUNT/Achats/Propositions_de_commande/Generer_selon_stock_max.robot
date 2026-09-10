*** Settings ***
Documentation     Tests fonctionnels de la méthode "Générer selon stock max" sur la page
...               "Propositions de commande"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
Force Tags        Propositions de commande    Stock max

*** Variables ***
${PROPOSITIONS_URL}              purchasesuggestions?view=max
${CARD_STOCK_MAX}                 xpath=//div[contains(@class,"header__card") and contains(.,"Générer selon stock max")]
${SUIVANT_BUTTON}                  xpath=//*[@data-testid="suivant"]
${CLASSER_PAR_SELECT}              id=sort
${LABORATOIRE_SELECT}              id=supplier_id
${CATEGORIES_SELECT}               css=.sob-v2-isMulti
${CATEGORIES_TAG_REMOVE}           css=.sob-v2-select__multi-value__remove
${CATEGORIES_CLEAR_ALL}            css=.sob-v2-select__clear-indicator
${SELECT_OPTION}                   css=.sob-v2-select__option
${OPTIONS_TITRE}                   xpath=//*[contains(text(),"Options")]
${CATEGORIES_TITRE}                xpath=//*[contains(text(),"Catégories")]
${PERIODE_REFERENCE_TITRE}         xpath=//*[contains(text(),"Période de référence")]
# --- Page de création du bon de commande générée ---
${SUPPLIER_FIELD_BC}               id=supplier_id
${INPUT_CODE_BARRE_BC}             xpath=//*[@id="barcode"]
${DRAFT_BUTTON_BC}                 xpath=//*[@data-testid="brouillon"]
${APPROVE_BUTTON_BC}               xpath=//*[@data-testid="approuver"]
${TOTAL_A_PAYER_BC}                xpath=//*[contains(text(),"Total à payer")]

*** Test Cases ***
# --- Navigation et structure ---
Accéder à la page Propositions de commande avec la méthode Stock max présélectionnée
    Aller à la page Stock max
    wait until element is visible    ${CARD_STOCK_MAX}

Vérifier le titre de la page
    Aller à la page Stock max
    Page Should Contain    Propositions de commande

Vérifier le fil d'Ariane Achats
    Aller à la page Stock max
    Page Should Contain    Achats

Vérifier que le bouton Suivant est activé dès l'affichage de la méthode Stock max
    [Documentation]    Constaté en direct : contrairement à la méthode "Période de couverture de
    ...                stock" (qui exige "Jours à couvrir"), "Stock max" n'a aucun champ
    ...                obligatoire et "Suivant" est immédiatement cliquable.
    Aller à la page Stock max

Vérifier que la section Période de référence est absente
    [Documentation]    Différence clé vérifiée en direct par rapport aux méthodes "Période de
    ...                couverture de stock", "Nouvelle Méthode" et "Générer selon la consommation
    ...                d'une période" : "Stock max" n'affiche aucun champ de dates.
    Aller à la page Stock max
    Page Should Not Contain Element    ${PERIODE_REFERENCE_TITRE}
    Page Should Not Contain Element    id=start
    Page Should Not Contain Element    id=end

Vérifier que le champ Jours à couvrir est absent
    Aller à la page Stock max
    Page Should Not Contain Element    id=days_to_cover

# --- Sections du formulaire ---
Vérifier l'affichage de la section Options
    Aller à la page Stock max
    Page Should Contain Element    ${OPTIONS_TITRE}

Vérifier l'affichage de la section Catégories
    Aller à la page Stock max
    Page Should Contain Element    ${CATEGORIES_TITRE}

Vérifier la présence du bandeau d'information
    Aller à la page Stock max
    Page Should Contain    n'oubliez pas de convertir vos commandes en bons de livraison

# --- Options : Classer par / Laboratoire ---
Vérifier que Classer par affiche Ordre chronologique par défaut
    Aller à la page Stock max
    Element Should Contain    ${CLASSER_PAR_SELECT}    Ordre chronologique

Vérifier que le champ Laboratoire affiche le placeholder Fournisseur
    Aller à la page Stock max
    Element Should Contain    ${LABORATOIRE_SELECT}    Fournisseur

Vérifier l'ouverture du menu déroulant Classer par
    Aller à la page Stock max
    Click Element    ${CLASSER_PAR_SELECT}
    Sleep    1s
    Page Should Contain Element    ${SELECT_OPTION}

Vérifier l'ouverture du menu déroulant Laboratoire
    Aller à la page Stock max
    Click Element    ${LABORATOIRE_SELECT}
    Sleep    1s
    Page Should Contain Element    ${SELECT_OPTION}

# --- Catégories ---
Vérifier que les catégories sont toutes pré-sélectionnées par défaut
    Aller à la page Stock max
    Page Should Contain    Médicament
    Page Should Contain    Parapharmacie

Vérifier la présence du bouton de suppression sur chaque tag de catégorie
    Aller à la page Stock max
    Page Should Contain Element    ${CATEGORIES_TAG_REMOVE}

Vérifier la suppression d'une catégorie individuelle
    Aller à la page Stock max
    ${tags_avant}    Get Element Count    ${CATEGORIES_TAG_REMOVE}
    Click Element    ${CATEGORIES_TAG_REMOVE}
    Sleep    1s
    ${tags_apres}    Get Element Count    ${CATEGORIES_TAG_REMOVE}
    Should Be True    ${tags_apres} < ${tags_avant}

Vérifier la présence du bouton Tout effacer sur les catégories
    Aller à la page Stock max
    Page Should Contain Element    ${CATEGORIES_CLEAR_ALL}

Vérifier que Tout effacer retire toutes les catégories
    Aller à la page Stock max
    Click Element    ${CATEGORIES_CLEAR_ALL}
    Sleep    1s
    Page Should Not Contain Element    ${CATEGORIES_TAG_REMOVE}

Vérifier que le bouton Suivant reste activé après avoir vidé les catégories
    Aller à la page Stock max
    Click Element    ${CATEGORIES_CLEAR_ALL}
    Sleep    1s
    element attribute value should be    ${SUIVANT_BUTTON}    disabled    true

# --- Bouton Suivant et navigation vers la page de création du BC ---
Vérifier que Suivant redirige vers la page de création du bon de commande
    Aller à la page Stock max
    Cliquer sur Suivant
    Location Should Contain    purchaseorders/index/suggest

Vérifier que le paramètre method=max est présent dans l'URL générée
    Aller à la page Stock max
    Cliquer sur Suivant
    Location Should Contain    method=max

Vérifier que le paramètre days_to_cover est absent de l'URL générée pour cette méthode
    [Documentation]    Vérifie que l'URL générée pour "Stock max" ne contient pas le paramètre
    ...                "days_to_cover", propre à la méthode "Période de couverture de stock".
    Aller à la page Stock max
    Cliquer sur Suivant
    ${url}    Get Location
    Should Not Contain    ${url}    days_to_cover

# --- Page de création du bon de commande générée (contenu partagé) ---
Vérifier la présence du champ Fournisseur sur la page générée
    Aller à la page Stock max
    Cliquer sur Suivant
    Page Should Contain Element    ${SUPPLIER_FIELD_BC}

Vérifier la présence du champ de recherche produit par nom ou code barre
    Aller à la page Stock max
    Cliquer sur Suivant
    ${ph}    Get Element Attribute    ${INPUT_CODE_BARRE_BC}    placeholder
    Should Be Equal As Strings    ${ph}    Nom ou code barre

Vérifier que le Gestionnaire est pré-rempli avec l'utilisateur connecté
    Aller à la page Stock max
    Cliquer sur Suivant
    Page Should Contain    Meryem al hajjouji

Vérifier la présence du bloc Total à payer
    Aller à la page Stock max
    Cliquer sur Suivant
    Page Should Contain Element    ${TOTAL_A_PAYER_BC}

Vérifier la présence des boutons Brouillon et Approuver
    Aller à la page Stock max
    Cliquer sur Suivant
    Page Should Contain Element    ${DRAFT_BUTTON_BC}
    Page Should Contain Element    ${APPROVE_BUTTON_BC}

Vérifier les en-têtes du tableau des produits suggérés
    Aller à la page Stock max
    Cliquer sur Suivant
    Page Should Contain    Produit
    Page Should Contain    PPV
    Page Should Contain    PPH

Vérifier que le fournisseur reste vide par défaut sur la page générée
    Aller à la page Stock max
    Cliquer sur Suivant
    Element Should Contain    ${SUPPLIER_FIELD_BC}    Fournisseur

Vérifier que Approuver sans fournisseur ne crée pas le bon de commande
    Aller à la page Stock max
    Cliquer sur Suivant
    Click Element    ${APPROVE_BUTTON_BC}
    Sleep    1s
    Location Should Contain    suggest

# --- Navigation croisée ---
Vérifier que revenir en arrière depuis la page générée conserve la méthode sélectionnée
    Aller à la page Stock max
    Cliquer sur Suivant
    Go Back
    Wait Until Element Is Visible    ${CARD_STOCK_MAX}    10s

Vérifier que sélectionner la méthode Période de couverture de stock fait apparaître Jours à couvrir
    [Documentation]    Vérifie qu'en passant de "Stock max" à "Période de couverture de stock",
    ...                le champ "Jours à couvrir" (absent de Stock max) apparaît bien dans le
    ...                formulaire.
    Aller à la page Stock max
    Click Element    xpath=//div[contains(@class,"header__card") and contains(.,"Générer pour une période de couverture de stock")]
    Sleep    1s
    Page Should Contain Element    id=days_to_cover

*** Keywords ***
Aller à la page Stock max
    [Documentation]    Navigue vers la page Propositions de commande avec la méthode "Stock max"
    ...                présélectionnée via le paramètre d'URL.
    Go To    ${BASE_URL}/${PROPOSITIONS_URL}
    Wait Until Element Is Visible    ${CATEGORIES_TITRE}    timeout=30s

Cliquer sur Suivant
    Wait Until Element Is Enabled    ${SUIVANT_BUTTON}    10s
    Click Element    ${SUIVANT_BUTTON}
    Sleep    2s
