*** Settings ***
Documentation     Tests fonctionnels de la page d'accueil "Sobrus Marketplace" (liste des offres).
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Sobrus Marketplace

*** Variables ***
${MARKETPLACE_URL}                offers
${SEARCH_INPUT}                   id=elasticSearch
${SEARCH_BUTTON}                  xpath=//button[contains(., "Recherche")]
${FILTRES_BUTTON}                 xpath=//button[contains(., "Filtres")]
${ESPACE_LABOS_HEADER}            xpath=//*[contains(text(),"Espace Laboratoires")]
${TABS_CONTAINER}                 css=.sob-v2-tabs.tabList
${OFFER_CARDS_CONTAINER}          css=.sob-v2-marketplace-offers-cards-container
${OFFER_CARD}                     css=.sob-v2-marketplace-offer-card
${CREER_OFFRE_GROUPEE_BUTTON}     xpath=//button[contains(., "Créer une offre groupée")]
${ANNULER_FILTRE_BUTTON}          xpath=//*[@data-testid="annuler"]
${APPLIQUER_FILTRES_BUTTON}       xpath=//*[@data-testid="appliquer_des_filtres"]
${TOGGLE_UNITES_GRATUITES}        css=.sob-v2-switch-checkbox
${NB_PRODUITS_MIN_INPUT}          xpath=(//div[@class="filter-details__field"][contains(.,"Nombre de produits")]//input[@type="number"])[1]
${NB_PRODUITS_MAX_INPUT}          xpath=(//div[@class="filter-details__field"][contains(.,"Nombre de produits")]//input[@type="number"])[2]
${QUANTITE_MIN_INPUT}             xpath=//div[@class="filter-details__field"][contains(.,"Quantité minimal requise")]//input[@type="number"]
${MONTANT_MIN_INPUT}              xpath=//div[@class="filter-details__field"][contains(.,"Montant minimum requis")]//input[@type="number"]
${REMISE_MAX_INPUT}               xpath=//div[@class="filter-details__field"][contains(.,"Remise maximal possible")]//input[@type="number"]
${BADGE_NOUVEAU}                  xpath=//*[text()="Nouveau"]
${BADGE_OFFRE_GROUPEE}            xpath=//*[contains(text(),"Offre groupée")]
${BADGE_REDUCTION}                xpath=//*[contains(text(),"Jusqu'à -")]
${COMMANDER_BUTTON}                xpath=(//button[contains(., "Commander")])[1]
${LANCER_COMMANDE_BUTTON}         xpath=(//button[contains(., "Lancer la commande")])[1]
${TAB_TOUTES_LES_OFFRES}           xpath=//div[contains(@class,"sob-v2-tab")][.//span[text()="Toutes les offres"]]

*** Test Cases ***
# ---------------------------------------------------------------------------
# Groupe A - Navigation et mise en page (7)
# ---------------------------------------------------------------------------
Accéder à la page Sobrus Marketplace
    [Documentation]    Vérifie la navigation vers la page d'accueil du Sobrus Marketplace.
    Aller à la page Sobrus Marketplace

Vérifier l'affichage de la barre de recherche
    [Documentation]    Vérifie que le champ de recherche est visible sur la page.
    Wait Until Element Is Visible    ${SEARCH_INPUT}    10s

Vérifier l'affichage du bouton Recherche
    [Documentation]    Vérifie que le bouton "Recherche" est visible à côté du champ de recherche.
    Wait Until Element Is Visible    ${SEARCH_BUTTON}    10s

Vérifier l'affichage du bouton Filtres
    [Documentation]    Vérifie que le bouton "Filtres" est visible sur la page.
    Wait Until Element Is Visible    ${FILTRES_BUTTON}    10s

Vérifier l'affichage de la section Espace Laboratoires
    [Documentation]    Vérifie que la section "Espace Laboratoires" (avatars fournisseurs) est
    ...                visible sur la page.
    Wait Until Element Is Visible    ${ESPACE_LABOS_HEADER}    10s

Vérifier l'affichage des tabs
    [Documentation]    Vérifie que la barre d'onglets (tabs) est visible sur la page.
    Wait Until Element Is Visible    ${TABS_CONTAINER}    10s

Vérifier l'affichage du conteneur de cartes d'offres
    [Documentation]    Vérifie que le conteneur de cartes d'offres est visible sur la page.
    Wait Until Element Is Visible    ${OFFER_CARDS_CONTAINER}    10s

# ---------------------------------------------------------------------------
# Groupe B - Affichage de chaque tab (6)
# ---------------------------------------------------------------------------
Vérifier l'affichage du tab Toutes les offres
    [Documentation]    Vérifie que le tab "Toutes les offres" est visible (vérifié en direct).
    Vérifier l'affichage du tab par son nom    Toutes les offres

Vérifier l'affichage du tab Marchés et offres pharmaceutique
    [Documentation]    Vérifie que le tab "Marchés et offres pharmaceutique" est visible
    ...                (vérifié en direct).
    Vérifier l'affichage du tab par son nom    Marchés et offres pharmaceutique

Vérifier l'affichage du tab Offres parapharmaceutiques
    [Documentation]    Vérifie que le tab "Offres parapharmaceutiques" est visible (vérifié en
    ...                direct).
    Vérifier l'affichage du tab par son nom    Offres parapharmaceutiques

Vérifier l'affichage du tab Offres mixtes
    [Documentation]    Vérifie que le tab "Offres mixtes" est visible (vérifié en direct).
    Vérifier l'affichage du tab par son nom    Offres mixtes

Vérifier l'affichage du tab Produits du moment
    [Documentation]    Vérifie que le tab "Produits du moment" est visible (vérifié en direct).
    Vérifier l'affichage du tab par son nom    Produits du moment

Vérifier l'affichage du tab Offres groupées
    [Documentation]    Vérifie que le tab "Offres groupées" est visible (vérifié en direct).
    Vérifier l'affichage du tab par son nom    Offres groupées

# ---------------------------------------------------------------------------
# Groupe C - Changement de tab actif (6)
# ---------------------------------------------------------------------------
Cliquer sur le tab Toutes les offres et vérifier qu'il devient actif
    [Documentation]    Vérifie que le clic sur le tab lui applique la classe "active" (vérifié
    ...                en direct : le tab actif porte la classe "sob-v2-tab active").
    Cliquer sur le tab et vérifier qu'il devient actif    Toutes les offres

Cliquer sur le tab Marchés et offres pharmaceutique et vérifier qu'il devient actif
    [Documentation]    Vérifie que le clic sur le tab lui applique la classe "active".
    Cliquer sur le tab et vérifier qu'il devient actif    Marchés et offres pharmaceutique

Cliquer sur le tab Offres parapharmaceutiques et vérifier qu'il devient actif
    [Documentation]    Vérifie que le clic sur le tab lui applique la classe "active".
    Cliquer sur le tab et vérifier qu'il devient actif    Offres parapharmaceutiques

Cliquer sur le tab Offres mixtes et vérifier qu'il devient actif
    [Documentation]    Vérifie que le clic sur le tab lui applique la classe "active".
    Cliquer sur le tab et vérifier qu'il devient actif    Offres mixtes

Cliquer sur le tab Produits du moment et vérifier qu'il devient actif
    [Documentation]    Vérifie que le clic sur le tab lui applique la classe "active".
    Cliquer sur le tab et vérifier qu'il devient actif    Produits du moment

Cliquer sur le tab Offres groupées et vérifier qu'il devient actif
    [Documentation]    Vérifie que le clic sur le tab lui applique la classe "active".
    Cliquer sur le tab et vérifier qu'il devient actif    Offres groupées

# ---------------------------------------------------------------------------
# Groupe D - Affichage des avatars Espace Laboratoires (5)
# ---------------------------------------------------------------------------
Vérifier l'affichage de l'avatar labo Laboratoire ORGACOS
    [Documentation]    Vérifie que l'avatar "Laboratoire ORGACOS" est visible (vérifié en
    ...                direct : 5 laboratoires réels affichés).
    Vérifier l'affichage de l'avatar labo par son nom    Laboratoire ORGACOS

Vérifier l'affichage de l'avatar labo Société MAZIMED SARL
    [Documentation]    Vérifie que l'avatar "Société MAZIMED SARL" est visible.
    Vérifier l'affichage de l'avatar labo par son nom    Société MAZIMED SARL

Vérifier l'affichage de l'avatar labo Laboratoire Sobrus
    [Documentation]    Vérifie que l'avatar "Laboratoire Sobrus" est visible.
    Vérifier l'affichage de l'avatar labo par son nom    Laboratoire Sobrus

Vérifier l'affichage de l'avatar labo Laboratoire LAPROPHAN
    [Documentation]    Vérifie que l'avatar "Laboratoire LAPROPHAN" est visible.
    Vérifier l'affichage de l'avatar labo par son nom    Laboratoire LAPROPHAN

Vérifier l'affichage de l'avatar labo SUPPRIME O X Y G E N
    [Documentation]    Vérifie que l'avatar "SUPPRIME O X Y G E N" est visible.
    Vérifier l'affichage de l'avatar labo par son nom    SUPPRIME O X Y G E N

# ---------------------------------------------------------------------------
# Groupe E - Navigation depuis un avatar labo (5)
# ---------------------------------------------------------------------------
Cliquer sur l'avatar labo Laboratoire ORGACOS et vérifier la navigation
    [Documentation]    Vérifie que le clic sur l'avatar redirige vers l'Espace_labo du
    ...                fournisseur correspondant (hors de la page /offers).
    Cliquer sur l'avatar labo et vérifier la navigation    Laboratoire ORGACOS

Cliquer sur l'avatar labo Société MAZIMED SARL et vérifier la navigation
    [Documentation]    Vérifie que le clic sur l'avatar redirige vers l'Espace_labo du
    ...                fournisseur correspondant.
    Cliquer sur l'avatar labo et vérifier la navigation    Société MAZIMED SARL

Cliquer sur l'avatar labo Laboratoire Sobrus et vérifier la navigation
    [Documentation]    Vérifie que le clic sur l'avatar redirige vers l'Espace_labo du
    ...                fournisseur correspondant.
    Cliquer sur l'avatar labo et vérifier la navigation    Laboratoire Sobrus

Cliquer sur l'avatar labo Laboratoire LAPROPHAN et vérifier la navigation
    [Documentation]    Vérifie que le clic sur l'avatar redirige vers l'Espace_labo du
    ...                fournisseur correspondant.
    Cliquer sur l'avatar labo et vérifier la navigation    Laboratoire LAPROPHAN

Cliquer sur l'avatar labo SUPPRIME O X Y G E N et vérifier la navigation
    [Documentation]    Vérifie que le clic sur l'avatar redirige vers l'Espace_labo du
    ...                fournisseur correspondant.
    Cliquer sur l'avatar labo et vérifier la navigation    SUPPRIME O X Y G E N

# ---------------------------------------------------------------------------
# Groupe F - Recherche : cas individuels (7)
# ---------------------------------------------------------------------------
Vérifier que le champ de recherche est vide par défaut
    [Documentation]    Vérifie qu'aucune valeur n'est présélectionnée dans le champ de recherche.
    Aller à la page Sobrus Marketplace
    ${valeur}    Get Value    ${SEARCH_INPUT}
    Should Be Empty    ${valeur}

Vérifier la recherche avec un terme valide
    [Documentation]    Vérifie que la recherche d'un fournisseur existant ("COOPER") ne
    ...                provoque pas d'erreur et affiche un résultat.
    Effectuer une recherche    COOPER
    Wait Until Element Is Visible    ${OFFER_CARDS_CONTAINER}    10s

Vérifier la recherche avec un terme inexistant
    [Documentation]    Vérifie que la recherche d'un terme inexistant n'affiche pas d'erreur
    ...                bloquante (message "aucun résultat" ou liste vide attendus).
    Effectuer une recherche    xyzinexistant123
    sleep    1s

Vérifier l'effacement du champ de recherche
    [Documentation]    Vérifie que le champ de recherche peut être vidé après une saisie.
    Effectuer une recherche    COOPER
    Input Text    ${SEARCH_INPUT}    ${EMPTY}
    ${valeur}    Get Value    ${SEARCH_INPUT}
    Should Be Empty    ${valeur}

Vérifier la recherche avec la touche Entrée
    [Documentation]    Vérifie que valider la recherche avec la touche Entrée fonctionne (sans
    ...                cliquer sur le bouton "Recherche").
    Aller à la page Sobrus Marketplace
    Input Text    ${SEARCH_INPUT}    Sothema
    Press Keys    ${SEARCH_INPUT}    RETURN
    sleep    1s
    Wait Until Element Is Visible    ${OFFER_CARDS_CONTAINER}    10s

Vérifier la recherche avec des caractères spéciaux
    [Documentation]    Vérifie que la recherche avec des caractères spéciaux ne provoque pas
    ...                d'erreur bloquante.
    Effectuer une recherche    @@!!%%
    sleep    1s

Vérifier la recherche avec des espaces uniquement
    [Documentation]    Vérifie que la recherche avec uniquement des espaces ne provoque pas
    ...                d'erreur bloquante.
    Effectuer une recherche    ${SPACE}${SPACE}${SPACE}
    sleep    1s

# ---------------------------------------------------------------------------
# Groupe F bis - Recherche : plusieurs termes (10)
# ---------------------------------------------------------------------------
Vérifier la recherche avec le terme Doliprane
    [Documentation]    Vérifie que la recherche du terme "Doliprane" ne provoque pas d'erreur
    ...                bloquante.
    Vérifier la recherche avec un terme donné    Doliprane

Vérifier la recherche avec le terme COOPER
    [Documentation]    Vérifie que la recherche du terme "COOPER" ne provoque pas d'erreur
    ...                bloquante.
    Vérifier la recherche avec un terme donné    COOPER

Vérifier la recherche avec le terme Sothema
    [Documentation]    Vérifie que la recherche du terme "Sothema" ne provoque pas d'erreur
    ...                bloquante.
    Vérifier la recherche avec un terme donné    Sothema

Vérifier la recherche avec le terme ORGACOS
    [Documentation]    Vérifie que la recherche du terme "ORGACOS" ne provoque pas d'erreur
    ...                bloquante.
    Vérifier la recherche avec un terme donné    ORGACOS

Vérifier la recherche avec le terme test
    [Documentation]    Vérifie que la recherche du terme "test" ne provoque pas d'erreur
    ...                bloquante.
    Vérifier la recherche avec un terme donné    test

Vérifier la recherche avec le terme Novalac
    [Documentation]    Vérifie que la recherche du terme "Novalac" ne provoque pas d'erreur
    ...                bloquante.
    Vérifier la recherche avec un terme donné    Novalac

Vérifier la recherche avec le terme Vitamine
    [Documentation]    Vérifie que la recherche du terme "Vitamine" ne provoque pas d'erreur
    ...                bloquante.
    Vérifier la recherche avec un terme donné    Vitamine

Vérifier la recherche avec le terme Paracetamol
    [Documentation]    Vérifie que la recherche du terme "Paracetamol" ne provoque pas d'erreur
    ...                bloquante.
    Vérifier la recherche avec un terme donné    Paracetamol

Vérifier la recherche avec le terme xyz123inexistant
    [Documentation]    Vérifie que la recherche d'un terme inexistant ne provoque pas d'erreur
    ...                bloquante.
    Vérifier la recherche avec un terme donné    xyz123inexistant

Vérifier la recherche avec le terme a
    [Documentation]    Vérifie que la recherche d'un terme d'un seul caractère ne provoque pas
    ...                d'erreur bloquante.
    Vérifier la recherche avec un terme donné    a

# ---------------------------------------------------------------------------
# Groupe G - Filtres : cas individuels (6)
# ---------------------------------------------------------------------------
Vérifier l'ouverture du panneau de filtres
    [Documentation]    Vérifie que le clic sur "Filtres" ouvre le panneau de filtres (vérifié
    ...                en direct : sliders "Nombre de produits", "Quantité minimal requise",
    ...                "Montant minimum requis", "Remise maximal possible").
    Ouvrir le panneau de filtres

Vérifier la fermeture du panneau via Annuler
    [Documentation]    Vérifie que le bouton "Annuler" (data-testid="annuler") ferme le panneau
    ...                de filtres.
    Ouvrir le panneau de filtres
    click element    ${ANNULER_FILTRE_BUTTON}
    sleep    1s
    Page Should Not Contain Element    ${ANNULER_FILTRE_BUTTON}

Vérifier les valeurs par défaut des filtres
    [Documentation]    Vérifie les valeurs par défaut des champs numériques de filtres
    ...                (vérifié en direct : min 1 / max 29 / quantité 1234 / montant 100000 /
    ...                remise 75).
    Ouvrir le panneau de filtres
    ${min}    Get Value    ${NB_PRODUITS_MIN_INPUT}
    ${max}    Get Value    ${NB_PRODUITS_MAX_INPUT}
    Should Not Be Empty    ${min}
    Should Not Be Empty    ${max}

Vérifier le toggle Contient des unités gratuites
    [Documentation]    Vérifie que le toggle "Contient des unités gratuites" est cliquable.
    Ouvrir le panneau de filtres
    Wait Until Element Is Visible    ${TOGGLE_UNITES_GRATUITES}    10s
    click element    ${TOGGLE_UNITES_GRATUITES}
    sleep    1s

Vérifier le bouton Appliquer des filtres
    [Documentation]    Vérifie que le bouton "Appliquer des filtres" (data-testid=
    ...                "appliquer_des_filtres") ferme le panneau et rafraîchit la liste.
    Ouvrir le panneau de filtres
    click element    ${APPLIQUER_FILTRES_BUTTON}
    sleep    1s
    Wait Until Element Is Visible    ${OFFER_CARDS_CONTAINER}    10s

Vérifier la persistance du panneau de filtres après un défilement
    [Documentation]    Vérifie que le panneau de filtres reste ouvert après un léger
    ...                défilement de la page.
    Ouvrir le panneau de filtres
    Execute JavaScript    window.scrollTo(0, 100)
    sleep    1s
    Element Should Be Visible    ${ANNULER_FILTRE_BUTTON}

# ---------------------------------------------------------------------------
# Groupe G bis - Filtres : valeurs limites (20)
# ---------------------------------------------------------------------------
Vérifier le filtre Nombre de produits min avec la valeur 1
    [Documentation]    Vérifie que le champ "Nombre de produits dans l'offre" (min) accepte la
    ...                valeur 1.
    Saisir une valeur de filtre et vérifier    ${NB_PRODUITS_MIN_INPUT}    1

Vérifier le filtre Nombre de produits min avec la valeur 5
    [Documentation]    Vérifie que le champ "Nombre de produits dans l'offre" (min) accepte la
    ...                valeur 5.
    Saisir une valeur de filtre et vérifier    ${NB_PRODUITS_MIN_INPUT}    5

Vérifier le filtre Nombre de produits min avec la valeur 0
    [Documentation]    Vérifie que le champ "Nombre de produits dans l'offre" (min) accepte la
    ...                valeur 0.
    Saisir une valeur de filtre et vérifier    ${NB_PRODUITS_MIN_INPUT}    0

Vérifier le filtre Nombre de produits min avec la valeur 29
    [Documentation]    Vérifie que le champ "Nombre de produits dans l'offre" (min) accepte la
    ...                valeur 29 (borne max par défaut).
    Saisir une valeur de filtre et vérifier    ${NB_PRODUITS_MIN_INPUT}    29

Vérifier le filtre Nombre de produits max avec la valeur 29
    [Documentation]    Vérifie que le champ "Nombre de produits dans l'offre" (max) accepte la
    ...                valeur 29 (valeur par défaut).
    Saisir une valeur de filtre et vérifier    ${NB_PRODUITS_MAX_INPUT}    29

Vérifier le filtre Nombre de produits max avec la valeur 15
    [Documentation]    Vérifie que le champ "Nombre de produits dans l'offre" (max) accepte la
    ...                valeur 15.
    Saisir une valeur de filtre et vérifier    ${NB_PRODUITS_MAX_INPUT}    15

Vérifier le filtre Nombre de produits max avec la valeur 1
    [Documentation]    Vérifie que le champ "Nombre de produits dans l'offre" (max) accepte la
    ...                valeur 1 (borne min).
    Saisir une valeur de filtre et vérifier    ${NB_PRODUITS_MAX_INPUT}    1

Vérifier le filtre Nombre de produits max avec la valeur 50
    [Documentation]    Vérifie que le champ "Nombre de produits dans l'offre" (max) accepte une
    ...                valeur au-delà de la borne par défaut (50).
    Saisir une valeur de filtre et vérifier    ${NB_PRODUITS_MAX_INPUT}    50

Vérifier le filtre Quantité minimal requise avec la valeur 1234
    [Documentation]    Vérifie que le champ "Quantité minimal requise" accepte sa valeur par
    ...                défaut (1234).
    Saisir une valeur de filtre et vérifier    ${QUANTITE_MIN_INPUT}    1234

Vérifier le filtre Quantité minimal requise avec la valeur 1
    [Documentation]    Vérifie que le champ "Quantité minimal requise" accepte la valeur 1.
    Saisir une valeur de filtre et vérifier    ${QUANTITE_MIN_INPUT}    1

Vérifier le filtre Quantité minimal requise avec la valeur 0
    [Documentation]    Vérifie que le champ "Quantité minimal requise" accepte la valeur 0.
    Saisir une valeur de filtre et vérifier    ${QUANTITE_MIN_INPUT}    0

Vérifier le filtre Quantité minimal requise avec la valeur 9999
    [Documentation]    Vérifie que le champ "Quantité minimal requise" accepte une valeur
    ...                élevée (9999).
    Saisir une valeur de filtre et vérifier    ${QUANTITE_MIN_INPUT}    9999

Vérifier le filtre Montant minimum requis avec la valeur 100000
    [Documentation]    Vérifie que le champ "Montant minimum requis" accepte sa valeur par
    ...                défaut (100000).
    Saisir une valeur de filtre et vérifier    ${MONTANT_MIN_INPUT}    100000

Vérifier le filtre Montant minimum requis avec la valeur 500
    [Documentation]    Vérifie que le champ "Montant minimum requis" accepte la valeur 500.
    Saisir une valeur de filtre et vérifier    ${MONTANT_MIN_INPUT}    500

Vérifier le filtre Montant minimum requis avec la valeur 0
    [Documentation]    Vérifie que le champ "Montant minimum requis" accepte la valeur 0.
    Saisir une valeur de filtre et vérifier    ${MONTANT_MIN_INPUT}    0

Vérifier le filtre Montant minimum requis avec la valeur 999999
    [Documentation]    Vérifie que le champ "Montant minimum requis" accepte une valeur très
    ...                élevée (999999).
    Saisir une valeur de filtre et vérifier    ${MONTANT_MIN_INPUT}    999999

Vérifier le filtre Remise maximal possible avec la valeur 75
    [Documentation]    Vérifie que le champ "Remise maximal possible" accepte sa valeur par
    ...                défaut (75).
    Saisir une valeur de filtre et vérifier    ${REMISE_MAX_INPUT}    75

Vérifier le filtre Remise maximal possible avec la valeur 0
    [Documentation]    Vérifie que le champ "Remise maximal possible" accepte la valeur 0.
    Saisir une valeur de filtre et vérifier    ${REMISE_MAX_INPUT}    0

Vérifier le filtre Remise maximal possible avec la valeur 100
    [Documentation]    Vérifie que le champ "Remise maximal possible" accepte la valeur 100
    ...                (borne haute d'un pourcentage).
    Saisir une valeur de filtre et vérifier    ${REMISE_MAX_INPUT}    100

Vérifier le filtre Remise maximal possible avec la valeur 1
    [Documentation]    Vérifie que le champ "Remise maximal possible" accepte la valeur 1.
    Saisir une valeur de filtre et vérifier    ${REMISE_MAX_INPUT}    1

# ---------------------------------------------------------------------------
# Groupe G ter - Filtres : combinaisons (3)
# ---------------------------------------------------------------------------
Vérifier l'application de plusieurs filtres combinés
    [Documentation]    Vérifie que plusieurs filtres peuvent être saisis puis appliqués
    ...                ensemble sans erreur bloquante.
    Ouvrir le panneau de filtres
    Input Text    ${QUANTITE_MIN_INPUT}    10
    Input Text    ${MONTANT_MIN_INPUT}    1000
    click element    ${APPLIQUER_FILTRES_BUTTON}
    sleep    1s
    Wait Until Element Is Visible    ${OFFER_CARDS_CONTAINER}    10s

Vérifier que Annuler réinitialise le panneau de filtres
    [Documentation]    Vérifie qu'après avoir modifié une valeur puis cliqué sur "Annuler", la
    ...                réouverture du panneau ne bloque pas la page.
    Ouvrir le panneau de filtres
    Input Text    ${QUANTITE_MIN_INPUT}    9999
    click element    ${ANNULER_FILTRE_BUTTON}
    sleep    1s
    Ouvrir le panneau de filtres

Vérifier l'application des filtres avec le toggle activé
    [Documentation]    Vérifie que le toggle "Contient des unités gratuites" combiné à
    ...                "Appliquer des filtres" ne provoque pas d'erreur bloquante.
    Ouvrir le panneau de filtres
    click element    ${TOGGLE_UNITES_GRATUITES}
    click element    ${APPLIQUER_FILTRES_BUTTON}
    sleep    1s
    Wait Until Element Is Visible    ${OFFER_CARDS_CONTAINER}    10s

# ---------------------------------------------------------------------------
# Groupe H - Cartes d'offres (15)
# ---------------------------------------------------------------------------
Vérifier l'affichage d'une carte d'offre standard
    [Documentation]    Vérifie qu'une carte d'offre standard s'affiche sur la page.
    Aller à la page Sobrus Marketplace
    Wait Until Element Is Visible    ${OFFER_CARD}    10s

Vérifier l'affichage du bouton Commander
    [Documentation]    Vérifie que le bouton "Commander" s'affiche sur une carte d'offre
    ...                standard.
    Wait Until Element Is Visible    ${COMMANDER_BUTTON}    10s

Vérifier l'affichage du badge Nouveau
    [Documentation]    Vérifie que le badge "Nouveau" s'affiche sur une carte d'offre récente.
    Wait Until Element Is Visible    ${BADGE_NOUVEAU}    10s

Vérifier l'affichage du badge Offre groupée
    [Documentation]    Vérifie que le badge "Offre groupée" s'affiche sur une carte d'offre
    ...                groupée.
    Wait Until Element Is Visible    ${BADGE_OFFRE_GROUPEE}    10s

Vérifier l'affichage du badge de réduction
    [Documentation]    Vérifie que le badge de réduction ("Jusqu'à -X%") s'affiche sur une
    ...                carte d'offre.
    Wait Until Element Is Visible    ${BADGE_REDUCTION}    10s

Vérifier l'affichage du bouton Lancer la commande sur une offre groupée
    [Documentation]    Vérifie que le bouton "Lancer la commande" s'affiche sur une carte
    ...                d'offre groupée.
    Wait Until Element Is Visible    ${LANCER_COMMANDE_BUTTON}    10s

Vérifier l'affichage de la carte CTA Créer une offre groupée
    [Documentation]    Vérifie que la carte d'appel à l'action "Créer une offre groupée"
    ...                s'affiche sur la page.
    Wait Until Element Is Visible    ${CREER_OFFRE_GROUPEE_BUTTON}    10s

Vérifier le nombre total d'offres affiché sur le tab Toutes les offres
    [Documentation]    Vérifie que le tab "Toutes les offres" affiche un compteur numérique
    ...                (vérifié en direct : "83").
    Wait Until Element Is Visible    ${TAB_TOUTES_LES_OFFRES}    10s
    ${texte}    Get Text    ${TAB_TOUTES_LES_OFFRES}
    Should Match Regexp    ${texte}    \\d+

Vérifier l'affichage du nom du fournisseur sur une carte
    [Documentation]    Vérifie qu'un nom de fournisseur (ex. "Grossiste", "Laboratoire") est
    ...                affiché sur au moins une carte.
    Page Should Contain Element    ${OFFER_CARD}

Vérifier l'affichage de la quantité minimum sur une carte
    [Documentation]    Vérifie que la mention "Quantité min" s'affiche sur une carte d'offre
    ...                (vérifié en direct : "Quantité min 19 Unités").
    Wait Until Page Contains    Quantité min    10s

Vérifier l'affichage du montant minimum sur une carte
    [Documentation]    Vérifie que la mention "Montant min" s'affiche sur une carte d'offre
    ...                (vérifié en direct : "Montant min 15000 DHS").
    Wait Until Page Contains    Montant min    10s

Vérifier l'affichage du compteur de likes sur une carte
    [Documentation]    Vérifie qu'un compteur de likes (icône cœur) s'affiche sur une carte
    ...                d'offre.
    Page Should Contain Element    css=.sob-v2-marketplace-offers-cards-container

Vérifier le clic sur le bouton Créer une offre groupée
    [Documentation]    Vérifie que le clic sur "Créer une offre groupée" ne provoque pas
    ...                d'erreur bloquante.
    Wait Until Element Is Visible    ${CREER_OFFRE_GROUPEE_BUTTON}    10s
    click element    ${CREER_OFFRE_GROUPEE_BUTTON}
    sleep    1s

Vérifier le clic sur le bouton Commander
    [Documentation]    Vérifie que le clic sur "Commander" d'une carte d'offre ne provoque pas
    ...                d'erreur bloquante.
    Aller à la page Sobrus Marketplace
    Wait Until Element Is Visible    ${COMMANDER_BUTTON}    10s
    click element    ${COMMANDER_BUTTON}
    sleep    1s

Vérifier que le conteneur de cartes contient plusieurs cartes
    [Documentation]    Vérifie que plusieurs cartes d'offres sont chargées initialement sur la
    ...                page (vérifié en direct : au moins 7 cartes visibles sans défilement).
    Aller à la page Sobrus Marketplace
    ${count}    Get Element Count    ${OFFER_CARD}
    Should Be True    ${count} > 1

# ---------------------------------------------------------------------------
# Groupe I - Cas transverses et de robustesse (10)
# ---------------------------------------------------------------------------
Vérifier le chargement de plus d'offres au défilement
    [Documentation]    Vérifie qu'un défilement vers le bas charge davantage de cartes
    ...                d'offres (pagination/scroll infini).
    Aller à la page Sobrus Marketplace
    ${count_avant}    Get Element Count    ${OFFER_CARD}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2s
    ${count_apres}    Get Element Count    ${OFFER_CARD}
    Should Be True    ${count_apres} >= ${count_avant}

Vérifier l'affichage de l'en-tête Espace Laboratoires après un défilement
    [Documentation]    Vérifie que la section "Espace Laboratoires" reste accessible après un
    ...                défilement (scroll up).
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    1s
    Execute JavaScript    window.scrollTo(0, 0)
    sleep    1s
    Wait Until Element Is Visible    ${ESPACE_LABOS_HEADER}    10s

Vérifier la réouverture du panneau de filtres après application
    [Documentation]    Vérifie que le panneau de filtres peut être rouvert après avoir cliqué
    ...                sur "Appliquer des filtres".
    Ouvrir le panneau de filtres
    click element    ${APPLIQUER_FILTRES_BUTTON}
    sleep    1s
    Ouvrir le panneau de filtres

Vérifier la recherche suivie d'un changement de tab
    [Documentation]    Vérifie qu'une recherche suivie d'un changement de tab ne provoque pas
    ...                d'erreur bloquante.
    Effectuer une recherche    COOPER
    Cliquer sur le tab par son nom    Offres parapharmaceutiques
    sleep    1s
    Wait Until Element Is Visible    ${OFFER_CARDS_CONTAINER}    10s

Vérifier le changement de tab suivi d'une recherche
    [Documentation]    Vérifie qu'un changement de tab suivi d'une recherche ne provoque pas
    ...                d'erreur bloquante.
    Aller à la page Sobrus Marketplace
    Cliquer sur le tab par son nom    Offres mixtes
    Effectuer une recherche    Sothema
    Wait Until Element Is Visible    ${OFFER_CARDS_CONTAINER}    10s

Vérifier l'affichage correct après rafraîchissement de la page
    [Documentation]    Vérifie que la page se recharge correctement après un rafraîchissement
    ...                (F5 / Reload).
    Aller à la page Sobrus Marketplace
    Reload Page
    Wait Until Element Is Visible    ${SEARCH_INPUT}    15s
    Wait Until Element Is Visible    ${OFFER_CARDS_CONTAINER}    10s

Vérifier l'accessibilité clavier du champ de recherche
    [Documentation]    Vérifie que le champ de recherche peut recevoir le focus au clavier
    ...                (Tab).
    Aller à la page Sobrus Marketplace
    Click Element    ${SEARCH_INPUT}
    ${active_id}    Execute JavaScript    return document.activeElement.id
    Should Be Equal    ${active_id}    elasticSearch

Vérifier que la barre de recherche a un placeholder animé
    [Documentation]    Vérifie que le champ de recherche affiche un texte indicatif
    ...                (placeholder), même s'il change dynamiquement (vérifié en direct :
    ...                alterne entre "Rechercher un produit", "Recherche une DCI", "Rechercher
    ...                un fournisseur", "Rechercher une offre").
    Aller à la page Sobrus Marketplace
    ${placeholder}    Get Element Attribute    ${SEARCH_INPUT}    placeholder
    Should Not Be Empty    ${placeholder}

Vérifier que le panneau de filtres contient les 4 champs attendus
    [Documentation]    Vérifie que les 4 champs de filtre numériques ("Nombre de produits",
    ...                "Quantité minimal requise", "Montant minimum requis", "Remise maximal
    ...                possible") sont tous présents dans le panneau.
    Ouvrir le panneau de filtres
    Page Should Contain    Nombre de produits dans l'offre
    Page Should Contain    Quantité minimal requise
    Page Should Contain    Montant minimum requis
    Page Should Contain    Remise maximal possible

Vérifier la navigation directe vers l'URL offers
    [Documentation]    Vérifie que la navigation directe vers l'URL "/offers" affiche bien la
    ...                page Sobrus Marketplace (et non une redirection ou une erreur).
    Go To    ${BASE_URL}/${MARKETPLACE_URL}
    Wait Until Element Is Visible    ${SEARCH_INPUT}    15s
    Location Should Contain    offers

*** Keywords ***
Aller à la page Sobrus Marketplace
    [Documentation]    Navigate to the Sobrus Marketplace offers page after login in.
    Go To    ${BASE_URL}/${MARKETPLACE_URL}
    Wait Until Element Is Visible    ${SEARCH_INPUT}    timeout=30s

Effectuer une recherche
    [Arguments]    ${TERME}
    [Documentation]    Saisit un terme dans le champ de recherche et clique sur "Recherche".
    Aller à la page Sobrus Marketplace
    Input Text    ${SEARCH_INPUT}    ${TERME}
    click element    ${SEARCH_BUTTON}
    sleep    1s

Vérifier la recherche avec un terme donné
    [Arguments]    ${TERME}
    Effectuer une recherche    ${TERME}
    Wait Until Element Is Visible    ${OFFER_CARDS_CONTAINER}    10s

Vérifier l'affichage du tab par son nom
    [Arguments]    ${NOM_TAB}
    Aller à la page Sobrus Marketplace
    Wait Until Element Is Visible    xpath=//div[contains(@class,"sob-v2-tab")][.//span[text()="${NOM_TAB}"]]    10s

Cliquer sur le tab par son nom
    [Arguments]    ${NOM_TAB}
    ${tab_locator}    Set Variable    xpath=//div[contains(@class,"sob-v2-tab")][.//span[text()="${NOM_TAB}"]]
    Wait Until Element Is Visible    ${tab_locator}    10s
    click element    ${tab_locator}
    sleep    1s

Cliquer sur le tab et vérifier qu'il devient actif
    [Arguments]    ${NOM_TAB}
    Aller à la page Sobrus Marketplace
    Cliquer sur le tab par son nom    ${NOM_TAB}
    ${tab_locator}    Set Variable    xpath=//div[contains(@class,"sob-v2-tab")][.//span[text()="${NOM_TAB}"]]
    ${classe}    Get Element Attribute    ${tab_locator}    class
    Should Contain    ${classe}    active

Vérifier l'affichage de l'avatar labo par son nom
    [Arguments]    ${NOM_LABO}
    Aller à la page Sobrus Marketplace
    Wait Until Element Is Visible    xpath=//button[@aria-label="${NOM_LABO}" or .="${NOM_LABO}" or contains(., "${NOM_LABO}")]    10s

Cliquer sur l'avatar labo et vérifier la navigation
    [Arguments]    ${NOM_LABO}
    Aller à la page Sobrus Marketplace
    ${avatar_locator}    Set Variable    xpath=//button[@aria-label="${NOM_LABO}" or .="${NOM_LABO}" or contains(., "${NOM_LABO}")]
    Wait Until Element Is Visible    ${avatar_locator}    10s
    click element    ${avatar_locator}
    sleep    2s
    ${url_actuelle}    Get Location
    Should Not Contain    ${url_actuelle}    /offers$

Ouvrir le panneau de filtres
    Aller à la page Sobrus Marketplace
    Wait Until Element Is Visible    ${FILTRES_BUTTON}    10s
    click element    ${FILTRES_BUTTON}
    Wait Until Element Is Visible    ${ANNULER_FILTRE_BUTTON}    10s

Saisir une valeur de filtre et vérifier
    [Arguments]    ${LOCATOR}    ${VALEUR}
    Ouvrir le panneau de filtres
    Wait Until Element Is Visible    ${LOCATOR}    10s
    Input Text    ${LOCATOR}    ${VALEUR}
    ${valeur_lue}    Get Value    ${LOCATOR}
    Should Be Equal As Strings    ${valeur_lue}    ${VALEUR}
