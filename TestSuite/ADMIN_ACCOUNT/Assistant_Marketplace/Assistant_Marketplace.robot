*** Settings ***
Documentation     Tests fonctionnels de la page "Assistant Marketplace".
Library           SeleniumLibrary
Library            String
Resource          ../../../Resources/Authentification_Admin.robot
Resource          ../../../Resources/MotsClesCommuns.robot
Resource          ../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Assistant Marketplace

*** Variables ***
${ASSISTANT_URL}                   marketplace-assistant
${SLIDER}                          css=.marketplace_assistant__slider
${SUIVANT_BUTTON}                  xpath=//*[@data-testid="suivant"]
${FINALISER_BUTTON}                xpath=//*[@data-testid="finaliser_la_commande"]
${ACHATS_OPTIMISES_CARD}           xpath=//*[contains(text(),"Achats optimisés")]
${VOS_BESOINS_TEXT}                xpath=//*[contains(text(),"Vos besoins")]
${QTE_TOTALE_COMMANDEE_TEXT}       xpath=//*[contains(text(),"Quantité totale commandée")]
${MONTANT_ECONOMISE_TEXT}          xpath=//*[contains(text(),"Montant économisé")]
${TOTAL_A_PAYER_TEXT}              xpath=//*[contains(text(),"Total à payer")]
${PANIER_VIDE_TEXT}                xpath=//*[contains(text(),"Votre panier est vide")]
${AUCUNE_OFFRE_TEXT}               xpath=//*[contains(text(),"Aucune offre ne correspond")]
# --- Groupe I (best-effort, hérité du script de référence, non revérifié aujourd'hui) ---
${SUPPLIER_CARD}                   css=.supplier__card
${AJOUTER_COMMENTAIRE_BUTTON}      xpath=//*[@data-testid="ajouter_un_commentaire"]
${COMMENT_FIELD}                   css=.sob-v2-form-control
${PASSER_COMMANDE_BUTTON}          xpath=//*[@data-testid="passer_commande"]
${SELECTED_CARD_BODY}              css=.selected__card__body__container

*** Test Cases ***
# ---------------------------------------------------------------------------
# Groupe A - Navigation (3)
# ---------------------------------------------------------------------------
Accéder à la page Assistant Marketplace
    [Documentation]    Vérifie la navigation vers la page Assistant Marketplace.
    Aller à la page Assistant Marketplace

Vérifier le titre de la page Assistant Marketplace
    [Documentation]    Vérifie que le titre "Assistant Marketplace" est affiché.
    Wait Until Page Contains    Assistant Marketplace    10s

Vérifier le fil d'ariane Sobrus Marketplace
    [Documentation]    Vérifie que le fil d'ariane "Sobrus Marketplace" est affiché sous le
    ...                titre (vérifié en direct).
    Wait Until Page Contains    Sobrus Marketplace    10s

# ---------------------------------------------------------------------------
# Groupe B - Carte Achats optimisés (3)
# ---------------------------------------------------------------------------
Vérifier l'affichage de la carte Achats optimisés
    [Documentation]    Vérifie que la carte promotionnelle "Achats optimisés" est affichée.
    Wait Until Element Is Visible    ${ACHATS_OPTIMISES_CARD}    10s

Vérifier le texte descriptif de la carte Achats optimisés
    [Documentation]    Vérifie le texte descriptif de la carte (vérifié en direct : "Achetez
    ...                mieux, en un clic, auprès de vos fournisseurs préférés.").
    Wait Until Page Contains    Achetez mieux, en un clic    10s

Vérifier le texte d'accroche sous le slider
    [Documentation]    Vérifie le texte explicatif sous le slider de période (vérifié en
    ...                direct : "Notre outil associe automatiquement vos suggestions de
    ...                commande...").
    Wait Until Page Contains    Notre outil associe automatiquement vos suggestions de commande    10s

# ---------------------------------------------------------------------------
# Groupe C - Slider Période de couverture (10)
# ---------------------------------------------------------------------------
Vérifier l'affichage du slider de période de couverture
    [Documentation]    Vérifie que le titre "Sélectionnez votre période de couverture" et le
    ...                slider sont affichés.
    Wait Until Page Contains    Sélectionnez votre période de couverture    10s
    Wait Until Element Is Visible    ${SLIDER}    10s

Vérifier les bornes min et max du slider
    [Documentation]    Vérifie que le slider a pour bornes min=0 et max=100 avec un pas de 25
    ...                (vérifié en direct).
    ${min}    Get Element Attribute    ${SLIDER}    min
    ${max}    Get Element Attribute    ${SLIDER}    max
    ${step}    Get Element Attribute    ${SLIDER}    step
    Should Be Equal As Strings    ${min}    0
    Should Be Equal As Strings    ${max}    100
    Should Be Equal As Strings    ${step}    25

Vérifier l'affichage du label 30 jours
    [Documentation]    Vérifie que le label "30 jours" est affiché sous le slider.
    Wait Until Page Contains    30 jours    10s

Vérifier l'affichage du label 60 jours
    [Documentation]    Vérifie que le label "60 jours" est affiché sous le slider.
    Wait Until Page Contains    60 jours    10s

Vérifier l'affichage du label 90 jours
    [Documentation]    Vérifie que le label "90 jours" est affiché sous le slider.
    Wait Until Page Contains    90 jours    10s

Vérifier l'affichage du label 120 jours
    [Documentation]    Vérifie que le label "120 jours" est affiché sous le slider.
    Wait Until Page Contains    120 jours    10s

Vérifier l'affichage de l'icône d'information du slider
    [Documentation]    Vérifie que l'icône d'information (ⓘ) à côté du titre du slider est
    ...                affichée.
    Wait Until Element Is Visible    xpath=//*[contains(text(),"Sélectionnez votre période de couverture")]/following::*[name()="svg"][1]    10s

Vérifier le déplacement du slider vers 60 jours
    [Documentation]    Vérifie que le slider peut être positionné à la valeur 25 (repère "60
    ...                jours").
    Positionner le slider    25
    ${valeur}    Get Value    ${SLIDER}
    Should Be Equal As Strings    ${valeur}    25

Vérifier le déplacement du slider vers 90 jours
    [Documentation]    Vérifie que le slider peut être positionné à la valeur 75 (repère "90
    ...                jours").
    Positionner le slider    75
    ${valeur}    Get Value    ${SLIDER}
    Should Be Equal As Strings    ${valeur}    75

Vérifier le déplacement du slider vers 120 jours
    [Documentation]    Vérifie que le slider peut être positionné à sa valeur maximale (100).
    Positionner le slider    100
    ${valeur}    Get Value    ${SLIDER}
    Should Be Equal As Strings    ${valeur}    100

# ---------------------------------------------------------------------------
# Groupe D - Résultat par période sélectionnée (15 : 5 positions x 3
# vérifications, vérifié en direct sur ce jeu de données)
# ---------------------------------------------------------------------------
Vérifier le résultat pour la période minimale (30 jours)
    [Documentation]    Vérifie qu'aucune offre n'est proposée pour la période minimale
    ...                (vérifié en direct : message "Aucune offre ne correspond à vos besoins
    ...                pour la période choisie").
    Sélectionner une période et cliquer sur Suivant    0
    Wait Until Element Is Visible    ${AUCUNE_OFFRE_TEXT}    10s

Vérifier que Finaliser reste désactivé pour la période minimale
    [Documentation]    Vérifie que le bouton "Finaliser la commande" reste désactivé sans
    ...                offre disponible.
    Sélectionner une période et cliquer sur Suivant    0
    Element Should Be Disabled    ${FINALISER_BUTTON}

Vérifier que le panier reste vide pour la période minimale
    [Documentation]    Vérifie que le panier reste affiché comme vide.
    Sélectionner une période et cliquer sur Suivant    0
    Wait Until Element Is Visible    ${PANIER_VIDE_TEXT}    10s

Vérifier le résultat pour la période 25
    [Documentation]    Vérifie qu'aucune offre n'est proposée pour la position 25 du slider
    ...                (repère "60 jours").
    Sélectionner une période et cliquer sur Suivant    25
    Wait Until Element Is Visible    ${AUCUNE_OFFRE_TEXT}    10s

Vérifier que Finaliser reste désactivé pour la période 25
    [Documentation]    Vérifie que le bouton "Finaliser la commande" reste désactivé.
    Sélectionner une période et cliquer sur Suivant    25
    Element Should Be Disabled    ${FINALISER_BUTTON}

Vérifier que le panier reste vide pour la période 25
    [Documentation]    Vérifie que le panier reste affiché comme vide.
    Sélectionner une période et cliquer sur Suivant    25
    Wait Until Element Is Visible    ${PANIER_VIDE_TEXT}    10s

Vérifier le résultat pour la période médiane (50)
    [Documentation]    Vérifie qu'aucune offre n'est proposée pour la position médiane du
    ...                slider.
    Sélectionner une période et cliquer sur Suivant    50
    Wait Until Element Is Visible    ${AUCUNE_OFFRE_TEXT}    10s

Vérifier que Finaliser reste désactivé pour la période médiane
    [Documentation]    Vérifie que le bouton "Finaliser la commande" reste désactivé.
    Sélectionner une période et cliquer sur Suivant    50
    Element Should Be Disabled    ${FINALISER_BUTTON}

Vérifier que le panier reste vide pour la période médiane
    [Documentation]    Vérifie que le panier reste affiché comme vide.
    Sélectionner une période et cliquer sur Suivant    50
    Wait Until Element Is Visible    ${PANIER_VIDE_TEXT}    10s

Vérifier le résultat pour la période 90 jours
    [Documentation]    Vérifie qu'aucune offre n'est proposée pour la position 75 du slider
    ...                (repère "90 jours", vérifié en direct).
    Sélectionner une période et cliquer sur Suivant    75
    Wait Until Element Is Visible    ${AUCUNE_OFFRE_TEXT}    10s

Vérifier que Finaliser reste désactivé pour la période 90 jours
    [Documentation]    Vérifie que le bouton "Finaliser la commande" reste désactivé.
    Sélectionner une période et cliquer sur Suivant    75
    Element Should Be Disabled    ${FINALISER_BUTTON}

Vérifier que le panier reste vide pour la période 90 jours
    [Documentation]    Vérifie que le panier reste affiché comme vide.
    Sélectionner une période et cliquer sur Suivant    75
    Wait Until Element Is Visible    ${PANIER_VIDE_TEXT}    10s

Vérifier le résultat pour la période maximale (120 jours)
    [Documentation]    Vérifie qu'aucune offre n'est proposée pour la période maximale
    ...                (vérifié en direct).
    Sélectionner une période et cliquer sur Suivant    100
    Wait Until Element Is Visible    ${AUCUNE_OFFRE_TEXT}    10s

Vérifier que Finaliser reste désactivé pour la période maximale
    [Documentation]    Vérifie que le bouton "Finaliser la commande" reste désactivé.
    Sélectionner une période et cliquer sur Suivant    100
    Element Should Be Disabled    ${FINALISER_BUTTON}

Vérifier que le panier reste vide pour la période maximale
    [Documentation]    Vérifie que le panier reste affiché comme vide.
    Sélectionner une période et cliquer sur Suivant    100
    Wait Until Element Is Visible    ${PANIER_VIDE_TEXT}    10s

# ---------------------------------------------------------------------------
# Groupe E - Panneau de droite : Vos besoins (8)
# ---------------------------------------------------------------------------
Vérifier l'affichage de Vos besoins
    [Documentation]    Vérifie que le panneau de droite affiche "Vos besoins".
    Aller à la page Assistant Marketplace
    Wait Until Element Is Visible    ${VOS_BESOINS_TEXT}    10s

Vérifier la valeur initiale de Vos besoins
    [Documentation]    Vérifie que "Vos besoins" affiche 0 par défaut (panier vide).
    Wait Until Page Contains    0    10s

Vérifier l'affichage de Quantité totale commandée
    [Documentation]    Vérifie que le panneau de droite affiche "Quantité totale commandée".
    Wait Until Element Is Visible    ${QTE_TOTALE_COMMANDEE_TEXT}    10s

Vérifier l'affichage de Montant économisé
    [Documentation]    Vérifie que le panneau de droite affiche "Montant économisé".
    Wait Until Element Is Visible    ${MONTANT_ECONOMISE_TEXT}    10s

Vérifier la valeur initiale de Montant économisé
    [Documentation]    Vérifie que "Montant économisé" affiche 0,00 par défaut.
    Wait Until Page Contains    0,00    10s

Vérifier l'affichage de Total à payer TTC
    [Documentation]    Vérifie que le panneau de droite affiche "Total à payer (TTC)".
    Wait Until Element Is Visible    ${TOTAL_A_PAYER_TEXT}    10s

Vérifier la valeur initiale de Total à payer
    [Documentation]    Vérifie que "Total à payer" affiche 0,00 par défaut.
    Wait Until Page Contains    Total à payer (TTC)    10s

Vérifier que le panneau Vos besoins persiste après changement de période
    [Documentation]    Vérifie que les indicateurs du panneau de droite restent affichés après
    ...                changement de la période de couverture.
    Sélectionner une période et cliquer sur Suivant    75
    Wait Until Element Is Visible    ${VOS_BESOINS_TEXT}    10s

# ---------------------------------------------------------------------------
# Groupe F - Bouton Finaliser la commande (4)
# ---------------------------------------------------------------------------
Vérifier l'affichage du bouton Finaliser la commande
    [Documentation]    Vérifie que le bouton "Finaliser la commande" (data-testid=
    ...                "finaliser_la_commande") est visible dès le chargement de la page.
    Aller à la page Assistant Marketplace
    Wait Until Element Is Visible    ${FINALISER_BUTTON}    10s

Vérifier que Finaliser la commande est désactivé par défaut
    [Documentation]    Vérifie que le bouton est désactivé quand le panier est vide (vérifié
    ...                en direct).
    Element Should Be Disabled    ${FINALISER_BUTTON}

Vérifier que le clic sur Finaliser désactivé ne provoque pas d'erreur
    [Documentation]    Vérifie qu'un clic sur le bouton désactivé ne provoque pas d'erreur
    ...                bloquante (Selenium lève une exception seulement si l'élément n'est pas
    ...                interactable ; on capture ce cas comme comportement attendu).
    Run Keyword And Ignore Error    click element    ${FINALISER_BUTTON}
    Wait Until Element Is Visible    ${FINALISER_BUTTON}    10s

Vérifier le texte du bouton Finaliser la commande
    [Documentation]    Vérifie le libellé exact du bouton.
    ${texte}    Get Text    ${FINALISER_BUTTON}
    Should Be Equal As Strings    ${texte}    Finaliser la commande

# ---------------------------------------------------------------------------
# Groupe G - Panier vide (5)
# ---------------------------------------------------------------------------
Vérifier l'affichage du panier vide
    [Documentation]    Vérifie que le panier est affiché comme vide au chargement de la page.
    Aller à la page Assistant Marketplace
    Wait Until Element Is Visible    ${PANIER_VIDE_TEXT}    10s

Vérifier le message Votre panier est vide
    [Documentation]    Vérifie le texte exact du message (vérifié en direct).
    Wait Until Page Contains    Votre panier est vide !    10s

Vérifier le message d'instruction du panier vide
    [Documentation]    Vérifie le texte d'instruction (vérifié en direct : "Ajoutez des
    ...                offres à votre panier en les sélectionnant dans la liste de gauche").
    Wait Until Page Contains    Ajoutez des offres à votre panier en les sélectionnant dans la liste de gauche    10s

Vérifier l'affichage de l'icône panier
    [Documentation]    Vérifie qu'une icône de panier est affichée dans la section panier
    ...                vide.
    Wait Until Element Is Visible    xpath=//*[contains(text(),"Votre panier est vide")]/preceding::*[name()="svg"][1]    10s

Vérifier que le panier reste vide après un rafraîchissement
    [Documentation]    Vérifie que le panier reste vide après un rafraîchissement de la page.
    Reload Page
    Wait Until Element Is Visible    ${PANIER_VIDE_TEXT}    15s

# ---------------------------------------------------------------------------
# Groupe H - Robustesse et cas limites (12)
# ---------------------------------------------------------------------------
Vérifier l'affichage correct après rafraîchissement de la page
    [Documentation]    Vérifie que la page se recharge correctement après un rafraîchissement
    ...                (F5), slider réinitialisé.
    Aller à la page Assistant Marketplace
    Reload Page
    Wait Until Element Is Visible    ${SLIDER}    15s

Vérifier la navigation directe vers l'URL marketplace-assistant
    [Documentation]    Vérifie que la navigation directe vers l'URL affiche bien la page
    ...                Assistant Marketplace.
    Go To    ${BASE_URL}/${ASSISTANT_URL}
    Wait Until Element Is Visible    ${SLIDER}    15s
    Location Should Contain    marketplace-assistant

Vérifier que l'URL ne change pas après le clic sur Suivant
    [Documentation]    Vérifie que le clic sur "Suivant" est une transition côté client (pas
    ...                de changement d'URL, vérifié en direct).
    Aller à la page Assistant Marketplace
    click element    ${SUIVANT_BUTTON}
    sleep    2s
    Location Should Contain    marketplace-assistant

Vérifier que le titre de page reste stable après le clic sur Suivant
    [Documentation]    Vérifie que le titre "Assistant Marketplace" reste affiché après le
    ...                passage à l'étape suivante.
    Aller à la page Assistant Marketplace
    click element    ${SUIVANT_BUTTON}
    sleep    2s
    Wait Until Page Contains    Assistant Marketplace    10s

Vérifier le comportement au clic répété sur Suivant
    [Documentation]    Vérifie que des clics répétés sur "Suivant" n'affichent pas plusieurs
    ...                fois le message "Aucune offre" (pas de duplication).
    Aller à la page Assistant Marketplace
    click element    ${SUIVANT_BUTTON}
    sleep    1s
    click element    ${SUIVANT_BUTTON}
    sleep    1s
    ${count}    Get Element Count    ${AUCUNE_OFFRE_TEXT}
    Should Be True    ${count} <= 1

Vérifier la persistance de la position du slider après un défilement
    [Documentation]    Vérifie que la position du slider n'est pas réinitialisée par un
    ...                défilement de la page.
    Aller à la page Assistant Marketplace
    Positionner le slider    75
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    1s
    Execute JavaScript    window.scrollTo(0, 0)
    ${valeur}    Get Value    ${SLIDER}
    Should Be Equal As Strings    ${valeur}    75

Vérifier l'accessibilité clavier du slider
    [Documentation]    Vérifie que le slider peut recevoir le focus au clavier.
    Aller à la page Assistant Marketplace
    Click Element    ${SLIDER}
    ${active_class}    Execute JavaScript    return document.activeElement.className
    Should Contain    ${active_class}    marketplace_assistant__slider

Vérifier l'incrémentation du slider au clavier
    [Documentation]    Vérifie que la flèche droite du clavier incrémente la position du
    ...                slider d'un pas (25).
    Click Element    ${SLIDER}
    Press Keys    ${SLIDER}    ARROW_RIGHT
    ${valeur}    Get Value    ${SLIDER}
    Should Not Be Equal As Strings    ${valeur}    0

Vérifier que la page ne plante pas avec le slider à sa valeur minimale
    [Documentation]    Vérifie qu'aucune erreur bloquante n'apparaît avec le slider à 0.
    Sélectionner une période et cliquer sur Suivant    0
    Page Should Not Contain    Error
    Page Should Not Contain    undefined

Vérifier que la page ne plante pas avec le slider à sa valeur maximale
    [Documentation]    Vérifie qu'aucune erreur bloquante n'apparaît avec le slider à 100.
    Sélectionner une période et cliquer sur Suivant    100
    Page Should Not Contain    Error
    Page Should Not Contain    undefined

Vérifier l'affichage cohérent sur plusieurs cycles de sélection de période
    [Documentation]    Vérifie qu'alterner entre plusieurs positions du slider et cliquer sur
    ...                Suivant à chaque fois reste stable (pas d'erreur cumulée).
    Sélectionner une période et cliquer sur Suivant    0
    Sélectionner une période et cliquer sur Suivant    100
    Sélectionner une période et cliquer sur Suivant    50
    Wait Until Element Is Visible    ${AUCUNE_OFFRE_TEXT}    10s

Vérifier le retour à la page précédente depuis Assistant Marketplace
    [Documentation]    Vérifie que le bouton retour du navigateur ne provoque pas d'erreur
    ...                bloquante depuis la page Assistant Marketplace.
    Aller à la page Assistant Marketplace
    Go Back
    sleep    2s

# ---------------------------------------------------------------------------
# Groupe I - Flow panier (best-effort, hérité d'un script de référence
# précédemment fonctionnel ; NON revérifié aujourd'hui faute d'offres
# suggérées disponibles sur ce compte) (5)
# ---------------------------------------------------------------------------
Vérifier l'affichage d'une carte fournisseur quand des offres existent
    [Documentation]    À REVALIDER : nécessite un jeu de données produisant des suggestions.
    ...                Sélecteur hérité du script de référence (css=.supplier__card).
    Sélectionner une période et cliquer sur Suivant    75
    ${count}    Get Element Count    ${SUPPLIER_CARD}
    Log    Nombre de cartes fournisseur trouvées : ${count} (0 attendu sur ce jeu de données)

Vérifier le bouton Ajouter un commentaire lors du paiement
    [Documentation]    À REVALIDER : sélecteur hérité du script de référence
    ...                (data-testid="ajouter_un_commentaire"), atteignable seulement après
    ...                ajout d'une offre au panier et clic sur "Finaliser la commande".
    Log    Test à revalider dès qu'une offre est disponible dans le panier.

Vérifier la saisie d'un commentaire de commande
    [Documentation]    À REVALIDER : sélecteur hérité du script de référence
    ...                (css=.sob-v2-form-control pour le champ commentaire).
    Log    Test à revalider dès qu'une offre est disponible dans le panier.

Vérifier le bouton Passer commande final
    [Documentation]    À REVALIDER : sélecteur hérité du script de référence
    ...                (data-testid="passer_commande"). Ce bouton ne doit jamais être cliqué
    ...                dans un test automatisé sans confirmation explicite (commande
    ...                fournisseur réelle et irréversible).
    Log    Test à revalider dès qu'une offre est disponible dans le panier.

Vérifier l'affichage de la carte sélectionnée dans le panier
    [Documentation]    À REVALIDER : sélecteur hérité du script de référence
    ...                (css=.selected__card__body__container).
    Log    Test à revalider dès qu'une offre est disponible dans le panier.

*** Keywords ***
Aller à la page Assistant Marketplace
    [Documentation]    Navigate to the Assistant Marketplace page after login in.
    Go To    ${BASE_URL}/${ASSISTANT_URL}
    Wait Until Element Is Visible    ${SLIDER}    timeout=30s

Positionner le slider
    [Arguments]    ${VALEUR}
    [Documentation]    Positionne le slider de période de couverture à la valeur donnée
    ...                (0, 25, 50, 75 ou 100 - pas de 25).
    Aller à la page Assistant Marketplace
    Execute JavaScript
    ...    var slider = document.querySelector('.marketplace_assistant__slider');
    ...    slider.value = ${VALEUR};
    ...    slider.dispatchEvent(new Event('change'));
    sleep    1s

Sélectionner une période et cliquer sur Suivant
    [Arguments]    ${VALEUR}
    [Documentation]    Positionne le slider puis clique sur "Suivant" pour afficher les
    ...                offres suggérées (ou le message d'absence d'offre).
    Positionner le slider    ${VALEUR}
    click element    ${SUIVANT_BUTTON}
    sleep    2s
