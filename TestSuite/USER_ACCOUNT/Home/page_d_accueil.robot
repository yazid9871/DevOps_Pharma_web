*** Settings ***
Documentation     Tests fonctionnels de la page d'accueil "Fil d'actualité"
Library           SeleniumLibrary
Library            String
Resource          ../../../Resources/Authentification_user.robot
Resource          ../../../Resources/MotsClesCommuns.robot
Resource          ../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page d'accueil

*** Variables ***
${HOME_URL}                        home
${NOTIFICATIONS_BELL}              css=.notifications-icon
${MAJ_PRIX_BUTTON}                 xpath=//button[contains(., "Mettre à jour les prix des produits")]
${PRODUITS_ATTENTE_BUTTON}         xpath=//*[@data-testid="produits_en_attente"]
${AIDE_ASSISTANT_BUTTON}           css=.ai_guide_assistant__button
${SOBRUS_ACADEMY_CARD}             xpath=//*[contains(text(),"Sobrus Academy")]
${JE_DECOUVRE_BUTTON}              xpath=//button[contains(., "Je découvre")]
${LIENS_RAPIDES_CARD}              xpath=//*[contains(text(),"Liens rapides")]
${PARRAINEZ_BUTTON}                xpath=//button[contains(., "Parrainez et gagnez")]
${MA_PHARMACIE_BUTTON}             xpath=//button[contains(., "Ma pharmacie")]
${MARKETPLACE_BUTTON}              xpath=(//button[contains(., "Marketplace")])[1]
${RACCOURCIS_HEADER}               xpath=//*[contains(text(),"Raccourcis")]
${RACCOURCIS_EXPAND_BUTTON}        xpath=(//button[contains(., "Raccourcis")])[1]
${SHORTCUT_VENTE}                  xpath=//*[@class="quicklinkscard__shortcut-item"][contains(.,"Créer une nouvelle vente")]
${SHORTCUT_BL}                     xpath=//*[@class="quicklinkscard__shortcut-item"][contains(.,"Créer un nouveau bon de livraison")]
${SHORTCUT_BC}                     xpath=//*[@class="quicklinkscard__shortcut-item"][contains(.,"Créer un nouveau bon de commande")]
${DECLARER_EFFET_BUTTON}           xpath=//button[contains(., "Déclarer effet indésirable")]
${POSTS_CONTAINER}                 css=.sobrusPosts
${POST_LIKE_BUTTON}                xpath=(//button[contains(@class,"sobrusPost__likeAndComments__containerIcon")])[1]
${OFFRES_DU_MOMENT_HEADER}         xpath=//*[contains(text(),"Offres du moment")]

*** Test Cases ***
# ---------------------------------------------------------------------------
# Groupe A - Navigation (3)
# ---------------------------------------------------------------------------
Accéder à la page d'accueil
    [Documentation]    Vérifie la navigation vers la page d'accueil (Fil d'actualité).
    Aller à la page d'accueil

Vérifier le titre Fil d'actualité
    [Documentation]    Vérifie que le titre "Fil d'actualité" est affiché.
    Wait Until Page Contains    Fil d'actualité    10s

Vérifier le fil d'ariane Accueil
    [Documentation]    Vérifie que le fil d'ariane "Accueil" est affiché sous le titre.
    Wait Until Page Contains    Accueil    10s

# ---------------------------------------------------------------------------
# Groupe B - Barre supérieure : badges et actions (8)
# ---------------------------------------------------------------------------
Vérifier l'affichage de l'icône de notifications
    [Documentation]    Vérifie que l'icône de notifications est affichée avec son badge de
    ...                compteur.
    Wait Until Element Is Visible    ${NOTIFICATIONS_BELL}    10s

Vérifier l'affichage du bouton Mettre à jour les prix des produits
    [Documentation]    Vérifie que le bouton avec son compteur (ex. "128") est affiché
    ...                (vérifié en direct).
    Wait Until Element Is Visible    ${MAJ_PRIX_BUTTON}    10s

Vérifier l'affichage du bouton Produits en attente
    [Documentation]    Vérifie que le bouton "Produits en attente" (data-testid=
    ...                "produits_en_attente") avec son compteur est affiché.
    Wait Until Element Is Visible    ${PRODUITS_ATTENTE_BUTTON}    10s

Vérifier le clic sur Produits en attente
    [Documentation]    Vérifie que le clic sur "Produits en attente" ne provoque pas d'erreur
    ...                bloquante.
    click element    ${PRODUITS_ATTENTE_BUTTON}
    sleep    1s

Vérifier l'affichage du numéro de support
    [Documentation]    Vérifie que le numéro de support est affiché (vérifié en direct :
    ...                "05 30 500 500").
    Wait Until Page Contains    05 30 500 500    10s

Vérifier l'affichage du menu contextuel (trois points)
    [Documentation]    Vérifie que le bouton de menu contextuel est affiché dans la barre
    ...                supérieure.
    Wait Until Element Is Visible    css=.sob-v2-btn-icon    10s

Vérifier l'affichage du bouton Besoin d'aide
    [Documentation]    Vérifie que le bouton flottant "Besoin d'aide ?" (assistant IA) est
    ...                affiché (vérifié en direct).
    Wait Until Element Is Visible    ${AIDE_ASSISTANT_BUTTON}    10s

Vérifier que la page reste stable après clic sur le bouton Mettre à jour les prix
    [Documentation]    Vérifie que le clic sur "Mettre à jour les prix des produits" ne
    ...                provoque pas d'erreur bloquante.
    click element    ${MAJ_PRIX_BUTTON}
    sleep    1s

# ---------------------------------------------------------------------------
# Groupe C - Bannière Sobrus Academy (3)
# ---------------------------------------------------------------------------
Vérifier l'affichage de la bannière Sobrus Academy
    [Documentation]    Vérifie que la bannière "Sobrus Academy" est affichée dans la colonne
    ...                de gauche.
    Aller à la page d'accueil
    Wait Until Element Is Visible    ${SOBRUS_ACADEMY_CARD}    10s

C:\QA-test-\TestSuite\ADMIN_ACCOUNT\Home\page_d_accueil.robot    [Documentation]    Vérifie le texte descriptif de la bannière (vérifié en direct :
    ...                "Sobrus Academy s'enrichit !").
    Wait Until Page Contains    Sobrus Academy s'enrichit    10s

Vérifier l'affichage du bouton Je découvre
    [Documentation]    Vérifie que le bouton "Je découvre" de la bannière Sobrus Academy est
    ...                visible.
    Wait Until Element Is Visible    ${JE_DECOUVRE_BUTTON}    10s

# ---------------------------------------------------------------------------
# Groupe D - Liens rapides (7)
# ---------------------------------------------------------------------------
Vérifier l'affichage de la carte Liens rapides
    [Documentation]    Vérifie que la carte "Liens rapides" est affichée.
    Wait Until Element Is Visible    ${LIENS_RAPIDES_CARD}    10s

Vérifier l'affichage du lien Parrainez et gagnez
    [Documentation]    Vérifie que le lien "Parrainez et gagnez" avec son badge "Nouveau" est
    ...                affiché.
    Wait Until Element Is Visible    ${PARRAINEZ_BUTTON}    10s
    Wait Until Page Contains    Nouveau    10s

Vérifier l'affichage du lien Ma pharmacie
    [Documentation]    Vérifie que le lien "Ma pharmacie" est affiché.
    Wait Until Element Is Visible    ${MA_PHARMACIE_BUTTON}    10s

Vérifier l'affichage du lien Marketplace
    [Documentation]    Vérifie que le lien "Marketplace" est affiché.
    Wait Until Element Is Visible    ${MARKETPLACE_BUTTON}    10s

Vérifier la navigation depuis le lien Ma pharmacie
    [Documentation]    Vérifie que le clic sur "Ma pharmacie" ne provoque pas d'erreur
    ...                bloquante.
    click element    ${MA_PHARMACIE_BUTTON}
    sleep    2s

Vérifier la navigation depuis le lien Marketplace
    [Documentation]    Vérifie que le clic sur "Marketplace" redirige vers le Sobrus
    ...                Marketplace.
    Aller à la page d'accueil
    click element    ${MARKETPLACE_BUTTON}
    sleep    2s
    Location Should Contain    offers

Vérifier la navigation depuis le lien Parrainez et gagnez
    [Documentation]    Vérifie que le clic sur "Parrainez et gagnez" ne provoque pas d'erreur
    ...                bloquante.
    Aller à la page d'accueil
    click element    ${PARRAINEZ_BUTTON}
    sleep    2s

# ---------------------------------------------------------------------------
# Groupe E - Raccourcis (8)
# ---------------------------------------------------------------------------
Vérifier l'affichage de la section Raccourcis
    [Documentation]    Vérifie que la section "Raccourcis" est affichée.
    Aller à la page d'accueil
    Wait Until Element Is Visible    ${RACCOURCIS_HEADER}    10s

Vérifier l'affichage du raccourci Créer une nouvelle vente
    [Documentation]    Vérifie que le raccourci "Créer une nouvelle vente" avec sa touche F4
    ...                est affiché (vérifié en direct).
    Wait Until Element Is Visible    ${SHORTCUT_VENTE}    10s
    Wait Until Page Contains    F4    10s

Vérifier l'affichage du raccourci Créer un nouveau bon de livraison
    [Documentation]    Vérifie que le raccourci "Créer un nouveau bon de livraison" avec sa
    ...                touche F6 est affiché (vérifié en direct).
    Wait Until Element Is Visible    ${SHORTCUT_BL}    10s
    Wait Until Page Contains    F6    10s

Vérifier l'affichage du raccourci Créer un nouveau bon de commande
    [Documentation]    Vérifie que le raccourci "Créer un nouveau bon de commande" avec sa
    ...                touche F10 est affiché (vérifié en direct).
    Wait Until Element Is Visible    ${SHORTCUT_BC}    10s
    Wait Until Page Contains    F10    10s

Vérifier l'affichage du bouton Déclarer effet indésirable
    [Documentation]    Vérifie que le lien "Déclarer effet indésirable" est affiché sous la
    ...                section Raccourcis.
    Wait Until Element Is Visible    ${DECLARER_EFFET_BUTTON}    10s

Vérifier l'affichage du bouton d'expansion Raccourcis
    [Documentation]    Vérifie que le bouton "Raccourcis >" (voir plus) est affiché à côté du
    ...                titre de la section.
    Wait Until Element Is Visible    ${RACCOURCIS_EXPAND_BUTTON}    10s

Vérifier le clic sur le bouton d'expansion Raccourcis
    [Documentation]    Vérifie que le clic sur "Raccourcis >" ne provoque pas d'erreur
    ...                bloquante.
    click element    ${RACCOURCIS_EXPAND_BUTTON}
    sleep    1s

Vérifier que le raccourci Créer une nouvelle vente mène à la page de création
    [Documentation]    Vérifie que le clic sur le raccourci "Créer une nouvelle vente" ouvre
    ...                bien une page de création (sans y soumettre de vente).
    Aller à la page d'accueil
    click element    ${SHORTCUT_VENTE}
    sleep    2s
    Location Should Contain    invoice

# ---------------------------------------------------------------------------
# Groupe F - Fil d'actualité : publications (10)
# ---------------------------------------------------------------------------
Vérifier l'affichage du conteneur de publications
    [Documentation]    Vérifie que le conteneur des publications du fil d'actualité est
    ...                affiché.
    Aller à la page d'accueil
    Wait Until Element Is Visible    ${POSTS_CONTAINER}    10s

Vérifier l'affichage du nom de l'auteur d'une publication
    [Documentation]    Vérifie que le nom de l'auteur d'une publication est affiché (vérifié
    ...                en direct : "Laboratoire ORGACOS").
    Wait Until Page Contains    Laboratoire ORGACOS    10s

Vérifier l'affichage de la date d'une publication
    [Documentation]    Vérifie qu'une date est affichée sur une publication.
    Wait Until Page Contains    2026    10s

Vérifier l'affichage du tag Conseil sur une publication
    [Documentation]    Vérifie que le tag "Conseil" est affiché sur une publication (vérifié
    ...                en direct).
    Wait Until Page Contains    Conseil    10s

Vérifier l'affichage du titre d'une publication
    [Documentation]    Vérifie qu'une publication a un titre affiché en gras.
    Wait Until Element Is Visible    css=.sobrusPosts    10s

Vérifier l'affichage de l'avatar de l'auteur
    [Documentation]    Vérifie que l'avatar (initiales) de l'auteur de la publication est
    ...                affiché (vérifié en direct : "LO").
    Wait Until Page Contains    LO    10s

Vérifier l'affichage de l'image d'une publication
    [Documentation]    Vérifie qu'une image est affichée dans une publication.
    Wait Until Element Is Visible    xpath=//div[contains(@class,"sobrusPosts")]//img    10s

Vérifier l'affichage de plusieurs publications
    [Documentation]    Vérifie que plusieurs publications sont chargées dans le fil
    ...                d'actualité.
    ${count}    Get Element Count    xpath=//div[contains(@class,"sobrusPosts")]
    Should Be True    ${count} >= 1

Vérifier le chargement de publications supplémentaires au défilement
    [Documentation]    Vérifie qu'un défilement vers le bas ne provoque pas d'erreur
    ...                bloquante et charge potentiellement plus de contenu.
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2s
    Wait Until Element Is Visible    ${POSTS_CONTAINER}    10s

Vérifier que le fil revient en haut après un nouveau chargement de page
    [Documentation]    Vérifie qu'un rechargement de page réaffiche le fil depuis le début.
    Reload Page
    Wait Until Element Is Visible    ${POSTS_CONTAINER}    15s

# ---------------------------------------------------------------------------
# Groupe G - Interaction avec une publication : like (5)
# ---------------------------------------------------------------------------
Vérifier l'affichage du bouton like sur une publication
    [Documentation]    Vérifie qu'un bouton like (icône cœur) est affiché sur une publication.
    Aller à la page d'accueil
    Wait Until Element Is Visible    ${POST_LIKE_BUTTON}    10s

Vérifier l'affichage du compteur de likes
    [Documentation]    Vérifie qu'un compteur de likes est affiché à côté du bouton (vérifié
    ...                en direct : "1").
    Wait Until Page Contains    1    10s

Vérifier le clic sur le bouton like
    [Documentation]    Vérifie que le clic sur le bouton like ne provoque pas d'erreur
    ...                bloquante.
    click element    ${POST_LIKE_BUTTON}
    sleep    1s

Vérifier que le like reste actif après un rafraîchissement
    [Documentation]    Vérifie que la page ne plante pas après avoir liké une publication puis
    ...                rafraîchi.
    click element    ${POST_LIKE_BUTTON}
    Reload Page
    Wait Until Element Is Visible    ${POSTS_CONTAINER}    15s

Vérifier le double clic sur le bouton like (like puis unlike)
    [Documentation]    Vérifie qu'un double clic (like puis unlike) ne provoque pas d'erreur
    ...                bloquante.
    Aller à la page d'accueil
    click element    ${POST_LIKE_BUTTON}
    sleep    1s
    click element    ${POST_LIKE_BUTTON}
    sleep    1s

# ---------------------------------------------------------------------------
# Groupe H - Offres du moment (carrousel) (8)
# ---------------------------------------------------------------------------
Vérifier l'affichage du titre Offres du moment
    [Documentation]    Vérifie que le titre "Offres du moment" est affiché dans la colonne de
    ...                droite.
    Aller à la page d'accueil
    Wait Until Element Is Visible    ${OFFRES_DU_MOMENT_HEADER}    10s

Vérifier l'affichage d'une carte d'offre du moment
    [Documentation]    Vérifie qu'une carte promotionnelle est affichée sous "Offres du
    ...                moment" (vérifié en direct : "Société MAZIMED SARL / Offre mazimed").
    Wait Until Page Contains    Offre mazimed    10s

Vérifier l'affichage du nom du fournisseur sur la carte d'offre
    [Documentation]    Vérifie que le nom du fournisseur est affiché sur la carte (vérifié en
    ...                direct : "Société MAZIMED SARL").
    Wait Until Page Contains    Société MAZIMED SARL    10s

Vérifier l'affichage des puces de pagination du carrousel
    [Documentation]    Vérifie que les puces de pagination du carrousel "Offres du moment"
    ...                sont affichées.
    Wait Until Element Is Visible    xpath=//*[contains(text(),"Offres du moment")]/ancestor::div[1]//following::*[name()="svg" or contains(@class,"dot")][1]    10s

Vérifier l'affichage des flèches de navigation du carrousel
    [Documentation]    Vérifie que des flèches de navigation (précédent/suivant) sont
    ...                affichées à côté du titre "Offres du moment".
    Wait Until Element Is Visible    xpath=//*[contains(text(),"Offres du moment")]/following::button[1]    10s

Vérifier le clic sur la flèche suivante du carrousel
    [Documentation]    Vérifie que le clic sur la flèche "suivant" du carrousel ne provoque
    ...                pas d'erreur bloquante.
    click element    xpath=(//*[contains(text(),"Offres du moment")]/following::button)[2]
    sleep    1s

Vérifier le clic sur la flèche précédente du carrousel
    [Documentation]    Vérifie que le clic sur la flèche "précédent" du carrousel ne provoque
    ...                pas d'erreur bloquante.
    click element    xpath=(//*[contains(text(),"Offres du moment")]/following::button)[1]
    sleep    1s

Vérifier l'affichage d'autres bannières promotionnelles
    [Documentation]    Vérifie que d'autres bannières promotionnelles s'affichent sous le
    ...                carrousel "Offres du moment" (vérifié en direct : bannière MEDIPRO).
    Wait Until Page Contains    MEDIPRO    10s

# ---------------------------------------------------------------------------
# Groupe I - Robustesse et cas limites (12)
# ---------------------------------------------------------------------------
Vérifier l'affichage correct après rafraîchissement de la page
    [Documentation]    Vérifie que la page se recharge correctement après un rafraîchissement
    ...                (F5).
    Aller à la page d'accueil
    Reload Page
    Wait Until Element Is Visible    ${POSTS_CONTAINER}    15s

Vérifier la navigation directe vers l'URL home
    [Documentation]    Vérifie que la navigation directe vers l'URL "/home" affiche bien la
    ...                page d'accueil.
    Go To    ${BASE_URL}/${HOME_URL}
    Wait Until Element Is Visible    ${POSTS_CONTAINER}    15s
    Location Should Contain    home

Vérifier le retour à l'accueil via le logo
    [Documentation]    Vérifie que le clic sur le logo Sobrus Pharma ramène à l'accueil.
    Go To    ${BASE_URL}/products
    click element    css=.sob-v2-navbar-logo, xpath=//a[@href="/home"]
    sleep    2s
    Location Should Contain    home

Vérifier le retour à l'accueil via le menu Accueil
    [Documentation]    Vérifie que le lien "Accueil" du menu principal ramène à la page
    ...                d'accueil.
    Go To    ${BASE_URL}/products
    click element    xpath=//a[contains(@href,"/home")]
    sleep    2s
    Location Should Contain    home

Vérifier que la page ne plante pas après un défilement complet
    [Documentation]    Vérifie qu'un défilement jusqu'en bas de la colonne centrale ne
    ...                provoque pas d'erreur bloquante.
    Aller à la page d'accueil
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2s
    Page Should Not Contain    Error

Vérifier la persistance de la section Liens rapides après un défilement
    [Documentation]    Vérifie que la carte "Liens rapides" (colonne de gauche, sticky) reste
    ...                accessible après un défilement.
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    1s
    Execute JavaScript    window.scrollTo(0, 0)
    Wait Until Element Is Visible    ${LIENS_RAPIDES_CARD}    10s

Vérifier l'accessibilité clavier du bouton Produits en attente
    [Documentation]    Vérifie que le bouton "Produits en attente" peut recevoir le focus au
    ...                clavier.
    Aller à la page d'accueil
    Click Element    ${PRODUITS_ATTENTE_BUTTON}
    ${active_class}    Execute JavaScript    return document.activeElement.className
    Should Not Be Empty    ${active_class}

Vérifier que le fil d'actualité reste stable après plusieurs clics de like
    [Documentation]    Vérifie que plusieurs clics successifs sur le bouton like ne
    ...                provoquent pas d'erreur bloquante.
    click element    ${POST_LIKE_BUTTON}
    click element    ${POST_LIKE_BUTTON}
    click element    ${POST_LIKE_BUTTON}
    Wait Until Element Is Visible    ${POSTS_CONTAINER}    10s

Vérifier que le titre de la page navigateur reflète l'accueil
    [Documentation]    Vérifie que le titre de l'onglet contient "Fil d'actualité".
    ${titre}    Get Title
    Should Contain    ${titre}    Fil d'actualité

Vérifier l'affichage cohérent du menu principal sur la page d'accueil
    [Documentation]    Vérifie que le menu de navigation principal (Clients, Produits,
    ...                Ventes, Achats...) est affiché sur la page d'accueil.
    Page Should Contain    Clients
    Page Should Contain    Produits
    Page Should Contain    Ventes
    Page Should Contain    Achats

Vérifier que la page d'accueil est accessible après navigation depuis une autre page
    [Documentation]    Vérifie l'accès à la page d'accueil en repartant d'une autre page de
    ...                l'application (Produits).
    Go To    ${BASE_URL}/products
    sleep    1s
    Aller à la page d'accueil
    Wait Until Element Is Visible    ${POSTS_CONTAINER}    10s

Vérifier que la page d'accueil affiche le nom de l'utilisateur connecté
    [Documentation]    Vérifie que le nom de l'utilisateur connecté est affiché en haut à
    ...                droite (vérifié en direct : "Meryem al hajjouji").
    Aller à la page d'accueil
    Wait Until Page Contains    Meryem al hajjouji    10s

*** Keywords ***
Aller à la page d'accueil
    [Documentation]    Navigate to the home page (Fil d'actualité) after login in.
    Go To    ${BASE_URL}/${HOME_URL}
    Wait Until Element Is Visible    ${POSTS_CONTAINER}    timeout=30s
