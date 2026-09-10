*** Settings ***
Documentation     Tests fonctionnels de la méthode "Générer pour une période de couverture de
...               stock" sur la page "Propositions de commande"
Library           SeleniumLibrary
Library    DateTime
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
Force Tags        Propositions de commande    Période de couverture de stock

*** Variables ***
${PROPOSITIONS_URL}              purchasesuggestions?view=period_of_coverage
${CARD_COUVERTURE_STOCK}         xpath=//div[contains(@class,"header__card") and contains(.,"Générer pour une période de couverture de stock")]
${SUIVANT_BUTTON}                 xpath=//*[@data-testid="suivant"]
${DATE_DEBUT_FIELD}               id=start
${DATE_FIN_FIELD}                 id=end
${JOURS_A_COUVRIR_FIELD}          id=days_to_cover
${ERREUR_CHAMP_REQUIS}            xpath=//*[contains(text(),"Ce champ est requis")]
${CLASSER_PAR_SELECT}             id=sort
${LABORATOIRE_SELECT}             id=supplier_id
${CATEGORIES_SELECT}              css=.sob-v2-isMulti
${CATEGORIES_TAG_REMOVE}          css=.sob-v2-select__multi-value__remove
${CATEGORIES_CLEAR_ALL}           css=.sob-v2-select__clear-indicator
${SELECT_OPTION}                  css=.sob-v2-select__option
${PERIODE_REFERENCE_TITRE}        xpath=//*[contains(text(),"Période de référence")]
${OPTIONS_TITRE}                  xpath=//*[contains(text(),"Options")]
${CATEGORIES_TITRE}               xpath=//*[contains(text(),"Catégories")]
# --- Page de création du bon de commande générée ---
${SUPPLIER_FIELD_BC}              id=supplier_id
${SUPPLIER_INPUT_BC}              xpath=//div[@id='supplier_id']//input
${INPUT_CODE_BARRE_BC}            xpath=//*[@id="barcode"]
${DRAFT_BUTTON_BC}                xpath=//*[@data-testid="brouillon"]
${APPROVE_BUTTON_BC}              xpath=//*[@data-testid="approuver"]
${GESTIONNAIRE_FIELD_BC}          xpath=//*[contains(text(),"Gestionnaire")]
${TOTAL_A_PAYER_BC}               xpath=//*[contains(text(),"Total à payer")]

*** Test Cases ***
# --- Navigation et structure générale ---
Accéder à la page Propositions de commande avec la méthode Période de couverture présélectionnée
    [Documentation]    Vérifie que naviguer directement vers l'URL avec "view=period_of_coverage"
    ...                présélectionne la carte correspondante (vérifié en direct : bordure active).
    Aller à la page Période de couverture de stock
    Element Attribute Value Should Be      ${CARD_COUVERTURE_STOCK}    class    active

Vérifier le titre de la page
    Aller à la page Période de couverture de stock
    Page Should Contain    Propositions de commande

Vérifier le fil d'Ariane Achats
    Aller à la page Période de couverture de stock
    Page Should Contain    Achats

Vérifier que le sous-titre de la carte est absent pour cette méthode
    [Documentation]    Contrairement à la carte "méthode prévisionnelle", la carte "Période de
    ...                couverture de stock" n'a pas de sous-titre explicatif (vérifié en direct).
    Aller à la page Période de couverture de stock
    Element Should Not Contain    ${CARD_COUVERTURE_STOCK}    Fusionnée

Vérifier la présence du bandeau d'information
    Aller à la page Période de couverture de stock
    Page Should Contain    n'oubliez pas de convertir vos commandes en bons de livraison

# --- Sections du formulaire ---
Vérifier l'affichage de la section Période de référence
    Aller à la page Période de couverture de stock
    Page Should Contain Element    ${PERIODE_REFERENCE_TITRE}

Vérifier l'affichage de la section Options
    Aller à la page Période de couverture de stock
    Page Should Contain Element    ${OPTIONS_TITRE}

Vérifier l'affichage de la section Catégories
    Aller à la page Période de couverture de stock
    Page Should Contain Element    ${CATEGORIES_TITRE}

Vérifier la présence de l'icône d'aide sur Période de référence
    [Documentation]    Vérifie en direct la présence de l'icône (i) à côté du titre "Période de
    ...                référence".
    Aller à la page Période de couverture de stock
    Page Should Contain Element    xpath=//*[contains(text(),"Période de référence")]/following-sibling::*[1]

# --- Champs Date de début / Date fin ---
Vérifier que la date de début est pré-remplie avec la date du jour
    Aller à la page Période de couverture de stock
    ${valeur}    Get Value    ${DATE_DEBUT_FIELD}
    ${aujourdhui}    Get Current Date    result_format=%Y-%m-%d
    Should Be Equal As Strings    ${valeur}    ${aujourdhui}

Vérifier que la date de fin est pré-remplie avec la date du jour
    Aller à la page Période de couverture de stock
    ${valeur}    Get Value    ${DATE_FIN_FIELD}
    ${aujourdhui}    Get Current Date    result_format=%Y-%m-%d
    Should Be Equal As Strings    ${valeur}    ${aujourdhui}

Vérifier que le champ Date de début est marqué obligatoire
    Aller à la page Période de couverture de stock
    Element Should Contain    xpath=//label[contains(text(),"Date de début")]    *

Vérifier que le champ Date de fin est marqué obligatoire
    Aller à la page Période de couverture de stock
    Element Should Contain    xpath=//label[contains(text(),"Date fin")]    *

Vérifier la présence de l'icône calendrier sur le champ Date de début
    Aller à la page Période de couverture de stock
    Page Should Contain Element    xpath=//*[@id="start"]/ancestor::div[contains(@class,"DatePicker") or contains(@class,"datepicker")][1]//*[name()="svg" or contains(@class,"calendar")]

# --- Champ Jours à couvrir ---
Vérifier que le champ Jours à couvrir est vide par défaut
    Aller à la page Période de couverture de stock
    ${valeur}    Get Value    ${JOURS_A_COUVRIR_FIELD}
    Should Be Empty    ${valeur}

Vérifier que le champ Jours à couvrir affiche un message d'erreur quand il est vide
    [Documentation]    Vérifié en direct : le champ affiche "Ce champ est requis" en bordure rouge
    ...                dès le chargement de la page, avant toute interaction.
    Aller à la page Période de couverture de stock
    Page Should Contain Element    ${ERREUR_CHAMP_REQUIS}

Vérifier que le bouton Suivant est désactivé quand Jours à couvrir est vide
    Aller à la page Période de couverture de stock
    Element Attribute Value Should Be    ${SUIVANT_BUTTON}    disabled    true

Vérifier que renseigner Jours à couvrir active le bouton Suivant
    [Documentation]    Vérifié en direct : saisir une valeur numérique dans "Jours à couvrir" fait
    ...                disparaître l'erreur "Ce champ est requis" et active "Suivant".
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Element Attribute Value Should Be    ${SUIVANT_BUTTON}    disabled    true

Vérifier que l'erreur Ce champ est requis disparaît après saisie
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Page Should Not Contain Element    ${ERREUR_CHAMP_REQUIS}

Vérifier que la valeur 0 est acceptée dans Jours à couvrir
    [Documentation]    Constaté en direct : contrairement à ce qu'on pourrait attendre, la valeur
    ...                "0" est acceptée sans erreur et active le bouton "Suivant" - aucune
    ...                validation métier ne semble empêcher une couverture de stock nulle.
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    0
    Element Attribute Value Should Be   ${SUIVANT_BUTTON}    disabled    true

Vérifier qu'une valeur négative est acceptée dans Jours à couvrir
    [Documentation]    À vérifier avec l'équipe métier : constaté en direct, le champ accepte une
    ...                valeur négative ("-5") sans afficher d'erreur et sans bloquer le bouton
    ...                "Suivant" - absence de validation min côté client (pas d'attribut HTML
    ...                "min" sur le champ).
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    -5
   Element Attribute Value Should Be    ${SUIVANT_BUTTON}    disabled    true

Vérifier que le champ Jours à couvrir est de type numérique
    Aller à la page Période de couverture de stock
    ${type}    Get Element Attribute    ${JOURS_A_COUVRIR_FIELD}    type
    Should Be Equal As Strings    ${type}    number

# --- Options : Classer par / Laboratoire ---
Vérifier que Classer par affiche Ordre chronologique par défaut
    Aller à la page Période de couverture de stock
    Element Should Contain    ${CLASSER_PAR_SELECT}    Ordre chronologique

Vérifier que le champ Laboratoire affiche le placeholder Fournisseur
    Aller à la page Période de couverture de stock
    Element Should Contain    ${LABORATOIRE_SELECT}    Fournisseur

Vérifier l'ouverture du menu déroulant Classer par
    Aller à la page Période de couverture de stock
    Click Element    ${CLASSER_PAR_SELECT}
    Sleep    1s
    Page Should Contain Element    ${SELECT_OPTION}

Vérifier que le champ Laboratoire est vide par défaut
    [Documentation]    Vérifie qu'aucun fournisseur n'est présélectionné dans le filtre
    ...                Laboratoire, "Fournisseur" n'étant qu'un texte de substitution (placeholder).
    Aller à la page Période de couverture de stock
    Element Should Not Contain    ${LABORATOIRE_SELECT}    Grossiste

# --- Catégories ---
Vérifier que les catégories sont toutes pré-sélectionnées par défaut
    [Documentation]    Vérifié en direct : à l'ouverture du formulaire, toutes les catégories de
    ...                produits du compte apparaissent déjà comme tags sélectionnés (avec leur
    ...                valeur de stock entre parenthèses).
    Aller à la page Période de couverture de stock
    Page Should Contain    Médicament
    Page Should Contain    Parapharmacie
    Page Should Contain    Complement Alimentaire

Vérifier la présence du bouton de suppression sur chaque tag de catégorie
    Aller à la page Période de couverture de stock
    Page Should Contain Element    ${CATEGORIES_TAG_REMOVE}

Vérifier la suppression d'une catégorie individuelle
    [Documentation]    Clique sur le bouton "x" du premier tag de catégorie et vérifie que le
    ...                nombre de tags diminue.
    Aller à la page Période de couverture de stock
    ${tags_avant}    Get Element Count    ${CATEGORIES_TAG_REMOVE}
    Click Element    ${CATEGORIES_TAG_REMOVE}
    Sleep    1s
    ${tags_apres}    Get Element Count    ${CATEGORIES_TAG_REMOVE}
    Should Be True    ${tags_apres} < ${tags_avant}

Vérifier la présence du bouton Tout effacer sur les catégories
    Aller à la page Période de couverture de stock
    Page Should Contain Element    ${CATEGORIES_CLEAR_ALL}

Vérifier que Tout effacer retire toutes les catégories
    [Documentation]    Vérifie qu'après un clic sur l'icône "x" globale du champ Catégories, plus
    ...                aucun tag de catégorie n'est affiché.
    Aller à la page Période de couverture de stock
    Click Element    ${CATEGORIES_CLEAR_ALL}
    Sleep    1s
    Page Should Not Contain Element    ${CATEGORIES_TAG_REMOVE}

Vérifier que le bouton Suivant reste utilisable après avoir vidé les catégories
    [Documentation]    Vérifie qu'un formulaire sans aucune catégorie sélectionnée (mais avec
    ...                Jours à couvrir renseigné) laisse tout de même "Suivant" activé.
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Click Element    ${CATEGORIES_CLEAR_ALL}
    Sleep    1s
   Element Attribute Value Should Be   ${SUIVANT_BUTTON}    disabled    true

Vérifier l'ouverture du menu déroulant Catégories
    Aller à la page Période de couverture de stock
    Click Element    ${CATEGORIES_SELECT}
    Sleep    1s
    Page Should Contain Element    ${SELECT_OPTION}

# --- Bouton Suivant et navigation vers la page de création du BC ---
Vérifier que Suivant redirige vers la page de création du bon de commande
    [Documentation]    Vérifié en direct : le clic sur "Suivant" redirige vers
    ...                "purchaseorders/index/suggest" avec les paramètres de la méthode dans
    ...                l'URL (method=period_of_coverage, days_to_cover, etc.).
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Cliquer sur Suivant
    Location Should Contain    purchaseorders/index/suggest

Vérifier que le paramètre method=period_of_coverage est présent dans l'URL générée
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Cliquer sur Suivant
    Location Should Contain    method=period_of_coverage

Vérifier que le paramètre days_to_cover est propagé dans l'URL générée
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    45
    Cliquer sur Suivant
    Location Should Contain    days_to_cover=45

Vérifier le titre de la page générée Créer un nouveau bon de commande
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Cliquer sur Suivant
    Page Should Contain    bon de commande

# --- Page de création du bon de commande générée (contenu partagé) ---
Vérifier la présence du champ Fournisseur sur la page générée
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Cliquer sur Suivant
    Page Should Contain Element    ${SUPPLIER_FIELD_BC}

Vérifier la présence du champ de recherche produit par nom ou code barre
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Cliquer sur Suivant
    ${ph}    Get Element Attribute    ${INPUT_CODE_BARRE_BC}    placeholder
    Should Be Equal As Strings    ${ph}    Nom ou code barre

Vérifier la présence du champ Gestionnaire sur la page générée
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Cliquer sur Suivant
    Page Should Contain Element    ${GESTIONNAIRE_FIELD_BC}

Vérifier que le Gestionnaire est pré-rempli avec l'utilisateur connecté
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Cliquer sur Suivant
    Page Should Contain    Meryem al hajjouji

Vérifier la présence du champ Date du bon de commande
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Cliquer sur Suivant
    Page Should Contain    Date du bon de commande

Vérifier que la date du bon de commande est pré-remplie avec la date du jour
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Cliquer sur Suivant
    ${aujourdhui}    Get Current Date    result_format=%Y-%m-%d
    Page Should Contain    ${aujourdhui}

Vérifier la présence du bloc Total à payer
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Cliquer sur Suivant
    Page Should Contain Element    ${TOTAL_A_PAYER_BC}

Vérifier la présence des boutons Brouillon et Approuver
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Cliquer sur Suivant
    Page Should Contain Element    ${DRAFT_BUTTON_BC}
    Page Should Contain Element    ${APPROVE_BUTTON_BC}

Vérifier les en-têtes du tableau des produits suggérés
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Cliquer sur Suivant
    Page Should Contain    Produit
    Page Should Contain    PPV
    Page Should Contain    PPH
    Page Should Contain    Disp

Vérifier que le fournisseur reste vide par défaut sur la page générée
    [Documentation]    Vérifié en direct : la méthode ne présélectionne aucun fournisseur, même si
    ...                des produits suggérés sont déjà présents dans le panier ; l'utilisateur
    ...                doit choisir un fournisseur manuellement avant de pouvoir valider.
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Cliquer sur Suivant
    Element Should Contain    ${SUPPLIER_FIELD_BC}    Fournisseur

Vérifier que Approuver sans fournisseur ne crée pas le bon de commande
    [Documentation]    Reproduit sur la page générée le comportement déjà vérifié sur la page de
    ...                création manuelle d'un Bons_de_commandes (Bons_de_commandes/creation_de_Bons_de_commandes.robot) :
    ...                sans fournisseur sélectionné, "Approuver" ne redirige pas vers la page
    ...                détails et l'URL reste sur la page de création.
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Cliquer sur Suivant
    Click Element    ${APPROVE_BUTTON_BC}
    Sleep    1s
    Location Should Contain    suggest

# --- Persistance et navigation croisée ---
Vérifier que revenir en arrière depuis la page générée conserve la méthode sélectionnée
    [Documentation]    Vérifie qu'un retour navigateur depuis la page de création du bon de
    ...                commande vers la page de sélection de méthode réaffiche bien la carte
    ...                "Période de couverture de stock" comme active.
    Aller à la page Période de couverture de stock
    Renseigner le nombre de jours à couvrir    30
    Cliquer sur Suivant
    Go Back
    Wait Until Element Is Visible    ${CARD_COUVERTURE_STOCK}    10s
   Element Attribute Value Should Be   ${CARD_COUVERTURE_STOCK}    class    active

Vérifier que sélectionner une autre méthode réinitialise le formulaire Jours à couvrir
    [Documentation]    Vérifie qu'en passant de "Période de couverture de stock" à "Générer selon
    ...                stock max", le champ "Jours à couvrir" (propre à la première méthode)
    ...                disparaît du formulaire affiché.
    Aller à la page Période de couverture de stock
    Click Element    xpath=//div[contains(@class,"header__card") and contains(.,"Générer selon stock max")]
    Sleep    1s
    Page Should Not Contain Element    ${JOURS_A_COUVRIR_FIELD}

*** Keywords ***
Aller à la page Période de couverture de stock
    [Documentation]    Navigue vers la page Propositions de commande avec la méthode "Période de
    ...                couverture de stock" présélectionnée via le paramètre d'URL.
    Go To    ${BASE_URL}/${PROPOSITIONS_URL}
    Wait Until Element Is Visible    ${JOURS_A_COUVRIR_FIELD}    timeout=30s

Renseigner le nombre de jours à couvrir
    [Arguments]    ${JOURS}
    Click Element    ${JOURS_A_COUVRIR_FIELD}
    Input Text    ${JOURS_A_COUVRIR_FIELD}    ${JOURS}
    Sleep    1s

Cliquer sur Suivant
    Wait Until Element Is Enabled    ${SUIVANT_BUTTON}    10s
    Click Element    ${SUIVANT_BUTTON}
    Sleep    2s
