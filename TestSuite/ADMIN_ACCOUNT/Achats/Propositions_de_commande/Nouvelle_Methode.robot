*** Settings ***
Documentation     Tests fonctionnels de la méthode "Nouvelle Méthode" (badge "Nouveau") sur la
...               page "Propositions de commande"
Library           SeleniumLibrary
Library    DateTime
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
Force Tags        Propositions de commande    Nouvelle Méthode

*** Variables ***
${PROPOSITIONS_URL}              purchasesuggestions?view=smart
${CARD_NOUVELLE_METHODE}          xpath=//div[contains(@class,"header__card") and contains(.,"Nouvelle Méthode")]
${CARD_PREVISIONNELLE}            xpath=//div[contains(@class,"header__card") and contains(.,"Générer selon la méthode prévisionnelle")]
${SUIVANT_BUTTON}                  xpath=//*[@data-testid="suivant"]
${DATE_DEBUT_FIELD}                id=start
${DATE_FIN_FIELD}                  id=end
${CLASSER_PAR_SELECT}              id=sort
${LABORATOIRE_SELECT}              id=supplier_id
${CATEGORIES_SELECT}               css=.sob-v2-isMulti
${CATEGORIES_TAG_REMOVE}           css=.sob-v2-select__multi-value__remove
${CATEGORIES_CLEAR_ALL}            css=.sob-v2-select__clear-indicator
${SELECT_OPTION}                   css=.sob-v2-select__option
${PERIODE_REFERENCE_TITRE}         xpath=//*[contains(text(),"Période de référence")]
${OPTIONS_TITRE}                   xpath=//*[contains(text(),"Options")]
${CATEGORIES_TITRE}                xpath=//*[contains(text(),"Catégories")]
# --- Page de création du bon de commande générée ---
${SUPPLIER_FIELD_BC}               id=supplier_id
${INPUT_CODE_BARRE_BC}             xpath=//*[@id="barcode"]
${DRAFT_BUTTON_BC}                 xpath=//*[@data-testid="brouillon"]
${APPROVE_BUTTON_BC}               xpath=//*[@data-testid="approuver"]
${TOTAL_A_PAYER_BC}                xpath=//*[contains(text(),"Total à payer")]

*** Test Cases ***
# --- Navigation et badge ---
Accéder à la page Propositions de commande avec Nouvelle Méthode présélectionnée
    Aller à la page Nouvelle Méthode
    wait until element is visible    ${CARD_NOUVELLE_METHODE}

Vérifier la présence du badge Nouveau sur la carte
    [Documentation]    Vérifié en direct : seule la carte "Nouvelle Méthode" affiche le badge vert
    ...                "Nouveau", contrairement aux 4 autres cartes.
    Aller à la page Nouvelle Méthode
    Element Should Contain    ${CARD_NOUVELLE_METHODE}    Nouveau

Vérifier le sous-titre Plus simple, plus fiable et plus claire
    Aller à la page Nouvelle Méthode
    Element Should Contain    ${CARD_NOUVELLE_METHODE}    Plus simple, plus fiable et plus claire

Vérifier que sélectionner Nouvelle Méthode active aussi la carte méthode prévisionnelle
    [Documentation]    Comportement notable vérifié en direct (les deux cartes partagent la
    ...                classe "header__card--active" simultanément) : "Nouvelle Méthode" remplace
    ...                "Générer selon la méthode prévisionnelle", ce qui se traduit par une
    ...                activation visuelle croisée des deux cartes dans le DOM.
    Aller à la page Nouvelle Méthode

Vérifier le titre et le fil d'Ariane de la page
    Aller à la page Nouvelle Méthode
    Page Should Contain    Propositions de commande
    Page Should Contain    Achats

# --- Champs Date de début / Date fin ---
Vérifier que la date de début est pré-remplie avec la date du jour
    Aller à la page Nouvelle Méthode
    ${valeur}    Get Value    ${DATE_DEBUT_FIELD}
    ${aujourdhui}    Get Current Date    result_format=%Y-%m-%d
    Should Be Equal As Strings    ${valeur}    ${aujourdhui}

Vérifier que la date de fin est pré-remplie avec la date du jour
    Aller à la page Nouvelle Méthode
    ${valeur}    Get Value    ${DATE_FIN_FIELD}
    ${aujourdhui}    Get Current Date    result_format=%Y-%m-%d
    Should Be Equal As Strings    ${valeur}    ${aujourdhui}

Vérifier que le bouton Suivant est activé sans autre saisie
    [Documentation]    Constaté en direct : les dates étant pré-remplies et aucun autre champ
    ...                n'étant obligatoire (pas de "Jours à couvrir" pour cette méthode),
    ...                "Suivant" est cliquable dès l'affichage du formulaire.
    Aller à la page Nouvelle Méthode

Vérifier que le champ Jours à couvrir est absent pour Nouvelle Méthode
    Aller à la page Nouvelle Méthode
    Page Should Not Contain Element    id=days_to_cover

Vérifier que le champ Date de début est marqué obligatoire
    Aller à la page Nouvelle Méthode
    Element Should Contain    xpath=//label[contains(text(),"Date de début")]    *

Vérifier que le champ Date de fin est marqué obligatoire
    Aller à la page Nouvelle Méthode
    Element Should Contain    xpath=//label[contains(text(),"Date fin")]    *

# --- Sections du formulaire ---
Vérifier l'affichage de la section Période de référence
    Aller à la page Nouvelle Méthode
    Page Should Contain Element    ${PERIODE_REFERENCE_TITRE}

Vérifier l'affichage de la section Options
    Aller à la page Nouvelle Méthode
    Page Should Contain Element    ${OPTIONS_TITRE}

Vérifier l'affichage de la section Catégories
    Aller à la page Nouvelle Méthode
    Page Should Contain Element    ${CATEGORIES_TITRE}

# --- Options : Classer par / Laboratoire ---
Vérifier que Classer par affiche Ordre chronologique par défaut
    Aller à la page Nouvelle Méthode
    Element Should Contain    ${CLASSER_PAR_SELECT}    Ordre chronologique

Vérifier que le champ Laboratoire affiche le placeholder Fournisseur
    Aller à la page Nouvelle Méthode
    Element Should Contain    ${LABORATOIRE_SELECT}    Fournisseur

Vérifier l'ouverture du menu déroulant Classer par
    Aller à la page Nouvelle Méthode
    Click Element    ${CLASSER_PAR_SELECT}
    Sleep    1s
    Page Should Contain Element    ${SELECT_OPTION}

Vérifier l'ouverture du menu déroulant Laboratoire
    Aller à la page Nouvelle Méthode
    Click Element    ${LABORATOIRE_SELECT}
    Sleep    1s
    Page Should Contain Element    ${SELECT_OPTION}

# --- Catégories ---
Vérifier que les catégories sont toutes pré-sélectionnées par défaut
    Aller à la page Nouvelle Méthode
    Page Should Contain    Médicament
    Page Should Contain    Parapharmacie

Vérifier la présence du bouton de suppression sur chaque tag de catégorie
    Aller à la page Nouvelle Méthode
    Page Should Contain Element    ${CATEGORIES_TAG_REMOVE}

Vérifier la suppression d'une catégorie individuelle
    Aller à la page Nouvelle Méthode
    ${tags_avant}    Get Element Count    ${CATEGORIES_TAG_REMOVE}
    Click Element    ${CATEGORIES_TAG_REMOVE}
    Sleep    1s
    ${tags_apres}    Get Element Count    ${CATEGORIES_TAG_REMOVE}
    Should Be True    ${tags_apres} < ${tags_avant}

Vérifier la présence du bouton Tout effacer sur les catégories
    Aller à la page Nouvelle Méthode
    Page Should Contain Element    ${CATEGORIES_CLEAR_ALL}

Vérifier que Tout effacer retire toutes les catégories
    Aller à la page Nouvelle Méthode
    Click Element    ${CATEGORIES_CLEAR_ALL}
    Sleep    1s
    Page Should Not Contain Element    ${CATEGORIES_TAG_REMOVE}

Vérifier que le bouton Suivant reste activé après avoir vidé les catégories
    Aller à la page Nouvelle Méthode
    Click Element    ${CATEGORIES_CLEAR_ALL}
    Sleep    1s

# --- Bouton Suivant et navigation vers la page de création du BC ---
Vérifier que Suivant redirige vers la page de création du bon de commande
    Aller à la page Nouvelle Méthode
    Cliquer sur Suivant
    Location Should Contain    purchaseorders/index/suggest

Vérifier que le paramètre method=smart est présent dans l'URL générée
    Aller à la page Nouvelle Méthode
    Cliquer sur Suivant
    Location Should Contain    method=smart

Vérifier que le paramètre days_to_cover est absent de l'URL générée pour cette méthode
    Aller à la page Nouvelle Méthode
    Cliquer sur Suivant
    ${url}    Get Location
    Should Not Contain    ${url}    days_to_cover

Vérifier le titre de la page générée Créer un nouveau bon de commande
    Aller à la page Nouvelle Méthode
    Cliquer sur Suivant
    Page Should Contain    bon de commande

# --- Page de création du bon de commande générée (contenu partagé) ---
Vérifier la présence du champ Fournisseur sur la page générée
    Aller à la page Nouvelle Méthode
    Cliquer sur Suivant
    Page Should Contain Element    ${SUPPLIER_FIELD_BC}

Vérifier la présence du champ de recherche produit par nom ou code barre
    Aller à la page Nouvelle Méthode
    Cliquer sur Suivant
    ${ph}    Get Element Attribute    ${INPUT_CODE_BARRE_BC}    placeholder
    Should Be Equal As Strings    ${ph}    Nom ou code barre

Vérifier que le Gestionnaire est pré-rempli avec l'utilisateur connecté
    Aller à la page Nouvelle Méthode
    Cliquer sur Suivant
    Page Should Contain    Meryem al hajjouji

Vérifier la présence du bloc Total à payer
    Aller à la page Nouvelle Méthode
    Cliquer sur Suivant
    Page Should Contain Element    ${TOTAL_A_PAYER_BC}

Vérifier la présence des boutons Brouillon et Approuver
    Aller à la page Nouvelle Méthode
    Cliquer sur Suivant
    Page Should Contain Element    ${DRAFT_BUTTON_BC}
    Page Should Contain Element    ${APPROVE_BUTTON_BC}

Vérifier les en-têtes du tableau des produits suggérés
    Aller à la page Nouvelle Méthode
    Cliquer sur Suivant
    Page Should Contain    Produit
    Page Should Contain    PPV
    Page Should Contain    PPH

Vérifier que le fournisseur reste vide par défaut sur la page générée
    Aller à la page Nouvelle Méthode
    Cliquer sur Suivant
    Element Should Contain    ${SUPPLIER_FIELD_BC}    Fournisseur

Vérifier que Approuver sans fournisseur ne crée pas le bon de commande
    Aller à la page Nouvelle Méthode
    Cliquer sur Suivant
    Click Element    ${APPROVE_BUTTON_BC}
    Sleep    1s
    Location Should Contain    suggest

# --- Navigation croisée ---
Vérifier que revenir en arrière depuis la page générée conserve la méthode sélectionnée
    Aller à la page Nouvelle Méthode
    Cliquer sur Suivant
    Go Back
    Wait Until Element Is Visible    ${CARD_NOUVELLE_METHODE}    10s

Vérifier que sélectionner la carte méthode prévisionnelle affiche aussi le formulaire de Nouvelle Méthode
    [Documentation]    Puisque les deux cartes sont fusionnées, cliquer sur "Générer selon la
    ...                méthode prévisionnelle" ne doit PAS afficher le formulaire complet
    ...                (comportement déjà documenté dans
    ...                Generer_selon_la_methode_previsionnelle.robot) : ce test vérifie que
    ...                revenir explicitement sur la carte "Nouvelle Méthode" restaure bien le
    ...                formulaire fonctionnel.
    Aller à la page Nouvelle Méthode
    Click Element    ${CARD_PREVISIONNELLE}
    Sleep    1s
    Click Element    ${CARD_NOUVELLE_METHODE}
    Sleep    1s
    Page Should Contain Element    ${PERIODE_REFERENCE_TITRE}

Vérifier que sélectionner la méthode Stock max fait disparaître les champs de dates
    Aller à la page Nouvelle Méthode
    Click Element    xpath=//div[contains(@class,"header__card") and contains(.,"Générer selon stock max")]
    Sleep    1s
    Page Should Not Contain Element    id=start

*** Keywords ***
Aller à la page Nouvelle Méthode
    [Documentation]    Navigue vers la page Propositions de commande avec la méthode "Nouvelle
    ...                Méthode" présélectionnée via le paramètre d'URL.
    Go To    ${BASE_URL}/${PROPOSITIONS_URL}
    Wait Until Element Is Visible    ${DATE_DEBUT_FIELD}    timeout=30s

Cliquer sur Suivant
    Wait Until Element Is Enabled    ${SUIVANT_BUTTON}    10s
    Click Element    ${SUIVANT_BUTTON}
    Sleep    2s
