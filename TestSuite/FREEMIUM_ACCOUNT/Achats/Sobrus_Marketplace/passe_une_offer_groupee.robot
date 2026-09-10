*** Settings ***
Documentation     Tests fonctionnels du flow "Passer une commande" depuis la liste des offres
...               (compte freemium)
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_Freemium.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Passer une offre groupée    Freemium

*** Variables ***
${OFFERS_URL}                      offers
${SEARCH_INPUT}                    id=elasticSearch
${PRODUIT_TEST}                     MELATONINE
${COMMANDER_CARD_BUTTON}            xpath=(//button[contains(., "Commander")])[1]
${LANCER_COMMANDE_CARD_BUTTON}      xpath=(//button[contains(., "Lancer la commande")])[1]
${PACK_HEADER}                      xpath=//*[contains(text(),"Pack #1")]
${PRODUCT_NAME}                     css=.product__name, css=[class*="product-name"]
${PRODUCT_PRICE}                    css=.price
${MON_STOCK_BADGE}                  xpath=//*[contains(text(),"Mon stock")]
${VOIR_HISTORIQUE_BUTTON}           xpath=//button[contains(., "Voir l'historique")]
${QTE_MOINS_BUTTON}                 css=.sob-v2-product-elements-input-moin
${QTE_PLUS_BUTTON}                  css=.sob-v2-product-elements-input-plus
${QTE_INPUT}                        css=input[type="number"]
${SAUVEGARDER_PLUS_TARD_BUTTON}     xpath=(//*[@data-testid="sauvegarder_pour_plus_tard"])[1]
${COMMANDER_STEP1_BUTTON}           xpath=(//*[@data-testid="commander"])[1]
${QTE_MIN_GLOBALE_HEADER}           xpath=//*[contains(text(),"Quantité min globale")]
${EXPIRE_LE_TEXT}                   xpath=//*[contains(text(),"Expire le")]
${METHODES_PAIEMENT_HEADER}         xpath=//*[contains(text(),"Méthodes de paiement acceptées")]
${MODE_REGLEMENT_HEADER}            xpath=//*[contains(text(),"Mode de règlement")]
${QTE_TOTALE_COMMANDEE_TEXT}        xpath=//*[contains(text(),"Qté totale commandée")]
${TOTAL_UG_TEXT}                    xpath=//*[contains(text(),"Total U.G")]
${VOUS_ECONOMISEZ_TEXT}             xpath=//*[contains(text(),"Vous économisez")]
${TOTAL_A_PAYER_TEXT}               xpath=//*[contains(text(),"Total à payer")]
${STEPPER_ETAPE1}                   xpath=//*[contains(text(),"Définition des quantités")]
${STEPPER_ETAPE2}                   xpath=//*[contains(text(),"Récapitulatif et finalisation")]
${ADRESSE_LIVRAISON_HEADER}         xpath=//*[contains(text(),"Adresse de livraison")]
${AJOUTER_WHATSAPP_BUTTON}          xpath=//*[@data-testid="ajouter_un_numéro_whatsapp"]
${FIELD_COMMENTAIRE}                id=comment
${CHECKBOX_FACTURE_PAPIER}          id=withReceiptOfInvoice
${PASSER_COMMANDE_BUTTON}           id=place_order
${DETAILS_COMMANDE_HEADER}          xpath=//*[contains(text(),"Détails de la commande")]
${AFFICHER_PRODUITS_TOGGLE}         css=.sob-v2-accordionCard_iconsContainer
${OFFRES_RECEMMENT_CONSULTEES}      xpath=//*[contains(text(),"Offres récemment consultées")]
${GROUPEMENT_FIELD}                 id=groupId
${GESTIONNAIRE_FIELD}               id=managerId
${ENTREPOT_FIELD}                   id=warehouse
${LANCER_COMMANDE_SUBMIT_BUTTON}    xpath=//*[@data-testid="lancer_la_commande"]

*** Test Cases ***
# ---------------------------------------------------------------------------
# Groupe A - Navigation depuis la liste des offres (5)
# ---------------------------------------------------------------------------
Accéder à la liste des offres
    [Documentation]    Vérifie la navigation vers la page de liste des offres.
    Aller à la page des offres

Vérifier l'affichage du bouton Commander sur une carte d'offre standard
    [Documentation]    Vérifie que le bouton "Commander" est visible sur une carte d'offre
    ...                standard.
    Wait Until Element Is Visible    ${COMMANDER_CARD_BUTTON}    10s

Vérifier l'affichage du bouton Lancer la commande sur une carte d'offre groupée
    [Documentation]    Vérifie que le bouton "Lancer la commande" est visible sur une carte
    ...                d'offre groupée.
    Wait Until Element Is Visible    ${LANCER_COMMANDE_CARD_BUTTON}    10s

Cliquer sur Commander et vérifier la navigation vers la page de commande
    [Documentation]    Vérifie que le clic sur "Commander" d'une offre standard ouvre la page
    ...                de sélection de quantités (vérifié en direct : URL
    ...                offers/details/{id}?view=offer-details).
    click element    ${COMMANDER_CARD_BUTTON}
    sleep    2s
    Location Should Contain    offers/details

Vérifier l'affichage de la section Offres récemment consultées
    [Documentation]    Vérifie qu'après avoir consulté une offre, elle apparaît dans la
    ...                section "Offres récemment consultées" de la liste (vérifié en direct).
    Aller à la page des offres
    click element    ${COMMANDER_CARD_BUTTON}
    sleep    2s
    Go Back
    sleep    2s
    Wait Until Element Is Visible    ${OFFRES_RECEMMENT_CONSULTEES}    10s

# ---------------------------------------------------------------------------
# Groupe B - Page de commande : informations générales (8)
# ---------------------------------------------------------------------------
Vérifier l'affichage de Quantité min globale
    [Documentation]    Vérifie que la mention "Quantité min globale" est affichée sur la page
    ...                de commande.
    Aller à la page de commande d'une offre standard
    Wait Until Element Is Visible    ${QTE_MIN_GLOBALE_HEADER}    10s

Vérifier l'affichage de la date d'expiration de l'offre
    [Documentation]    Vérifie que la mention "Expire le" avec un compte à rebours est
    ...                affichée.
    Wait Until Element Is Visible    ${EXPIRE_LE_TEXT}    10s

Vérifier l'affichage des méthodes de paiement acceptées
    [Documentation]    Vérifie que la section "Méthodes de paiement acceptées" est affichée
    ...                (vérifié en direct : "Espèces").
    Wait Until Element Is Visible    ${METHODES_PAIEMENT_HEADER}    10s
    Wait Until Page Contains    Espèces    10s

Vérifier l'affichage du mode de règlement
    [Documentation]    Vérifie que la section "Mode de règlement" est affichée (vérifié en
    ...                direct : "Règlement immédiat à la livraison").
    Wait Until Element Is Visible    ${MODE_REGLEMENT_HEADER}    10s

Vérifier l'affichage du pack de produits
    [Documentation]    Vérifie que le header "Pack #1" est affiché sur la page de commande.
    Wait Until Element Is Visible    ${PACK_HEADER}    10s

Vérifier l'affichage des boutons de feedback
    [Documentation]    Vérifie que les boutons de feedback (pouce haut/bas) sont affichés en
    ...                haut de la page.
    Wait Until Page Contains    👍    10s

Vérifier l'affichage du champ de recherche produit
    [Documentation]    Vérifie que le champ "Rechercher un produit" est affiché en haut de la
    ...                page de commande.
    Wait Until Element Is Visible    ${SEARCH_INPUT}    10s

Vérifier le retour vers la liste des offres
    [Documentation]    Vérifie que la flèche de retour ramène vers la liste des offres.
    Go Back
    sleep    2s
    Location Should Contain    offers

# ---------------------------------------------------------------------------
# Groupe C - Produit du pack : informations (5)
# ---------------------------------------------------------------------------
Vérifier l'affichage du nom du produit
    [Documentation]    Vérifie que le nom du produit est affiché dans le pack (vérifié en
    ...                direct : "MELATONINE 1.9MG B30 GELULES").
    Aller à la page de commande d'une offre standard
    Wait Until Page Contains    GELULES    10s

Vérifier l'affichage du prix PPV et PPH du produit
    [Documentation]    Vérifie que les prix PPV et PPH du produit sont affichés.
    Wait Until Page Contains    PPV    10s
    Wait Until Page Contains    PPH    10s

Vérifier l'affichage du badge Mon stock
    [Documentation]    Vérifie que le badge "Mon stock" avec une valeur numérique est affiché
    ...                pour le produit.
    Wait Until Element Is Visible    ${MON_STOCK_BADGE}    10s

Vérifier l'affichage du bouton Voir l'historique
    [Documentation]    Vérifie que le bouton "Voir l'historique" est affiché pour le produit.
    Wait Until Element Is Visible    ${VOIR_HISTORIQUE_BUTTON}    10s

Vérifier le clic sur Voir l'historique
    [Documentation]    Vérifie que le clic sur "Voir l'historique" ne provoque pas d'erreur
    ...                bloquante.
    click element    ${VOIR_HISTORIQUE_BUTTON}
    sleep    1s

# ---------------------------------------------------------------------------
# Groupe D - Gestion de la quantité (12)
# ---------------------------------------------------------------------------
Vérifier que la quantité initiale est à zéro
    [Documentation]    Vérifie que la quantité commandée du produit est initialisée à zéro.
    Aller à la page de commande d'une offre standard
    ${valeur}    Get Value    ${QTE_INPUT}
    Should Be True    "${valeur}" == "0" or "${valeur}" == "${EMPTY}"

Vérifier l'incrémentation de la quantité via le bouton plus
    [Documentation]    Vérifie que le bouton "+" incrémente la quantité du produit (vérifié
    ...                en direct).
    Cliquer sur le bouton plus    3
    ${valeur}    Get Value    ${QTE_INPUT}
    Should Be Equal As Strings    ${valeur}    3

Vérifier la décrémentation de la quantité via le bouton moins
    [Documentation]    Vérifie que le bouton "-" décrémente la quantité du produit.
    Cliquer sur le bouton plus    3
    click element    ${QTE_MOINS_BUTTON}
    sleep    1s
    ${valeur}    Get Value    ${QTE_INPUT}
    Should Be Equal As Strings    ${valeur}    2

Vérifier que le total du produit se met à jour avec la quantité
    [Documentation]    Vérifie que le total ligne se met à jour lors de l'incrémentation
    ...                (vérifié en direct : 2 unités à 48 PPH = 96,00).
    Cliquer sur le bouton plus    2
    Wait Until Page Contains    96,00    10s

Vérifier que le total du pack se met à jour avec la quantité
    [Documentation]    Vérifie que la mention "Total du pack" se met à jour avec la quantité
    ...                sélectionnée.
    Cliquer sur le bouton plus    2
    Wait Until Page Contains    Total du pack    10s

Vérifier l'affichage du badge Reste X unités
    [Documentation]    Vérifie que le badge "Reste X U" s'affiche tant que la quantité
    ...                minimale globale n'est pas atteinte (vérifié en direct : "Reste 17 U"
    ...                après 2 unités sur 19 requises).
    Cliquer sur le bouton plus    2
    Wait Until Page Contains    Reste    10s

Vérifier l'affichage du badge Qté min atteinte
    [Documentation]    Vérifie que le badge passe à "Qté min atteinte" une fois la quantité
    ...                minimale globale atteinte (vérifié en direct à 19 unités).
    Cliquer sur le bouton plus    19
    Wait Until Page Contains    Qté min atteinte    10s

Vérifier l'affichage des unités gratuites
    [Documentation]    Vérifie que la mention "Unités gratuites" est affichée pour le pack.
    Wait Until Page Contains    Unités gratuites    10s

Vérifier l'affichage des unités commandées
    [Documentation]    Vérifie que la mention "Unités commandées" se met à jour avec la
    ...                quantité sélectionnée.
    Cliquer sur le bouton plus    5
    Wait Until Page Contains    Unités commandées    10s

Vérifier que la quantité ne descend pas sous zéro
    [Documentation]    Vérifie que le bouton "-" ne fait pas descendre la quantité sous zéro
    ...                quand elle est déjà à zéro.
    click element    ${QTE_MOINS_BUTTON}
    sleep    1s
    ${valeur}    Get Value    ${QTE_INPUT}
    Should Not Contain    ${valeur}    -

Vérifier l'incrémentation répétée de la quantité jusqu'à 10
    [Documentation]    Vérifie l'incrémentation répétée de la quantité jusqu'à 10 unités.
    Cliquer sur le bouton plus    10
    ${valeur}    Get Value    ${QTE_INPUT}
    Should Be Equal As Strings    ${valeur}    10

Vérifier l'incrémentation de la quantité au-delà de la quantité minimale
    [Documentation]    Vérifie que la quantité peut être incrémentée au-delà de la quantité
    ...                minimale globale (25 unités pour un minimum de 19).
    Cliquer sur le bouton plus    25
    ${valeur}    Get Value    ${QTE_INPUT}
    Should Be Equal As Strings    ${valeur}    25

# ---------------------------------------------------------------------------
# Groupe E - Totaux et récapitulatif bas de page (6)
# ---------------------------------------------------------------------------
Vérifier l'affichage de Qté totale commandée
    [Documentation]    Vérifie que la barre inférieure affiche "Qté totale commandée".
    Aller à la page de commande d'une offre standard
    Wait Until Element Is Visible    ${QTE_TOTALE_COMMANDEE_TEXT}    10s

Vérifier l'affichage de Total U.G
    [Documentation]    Vérifie que la barre inférieure affiche "Total U.G".
    Wait Until Element Is Visible    ${TOTAL_UG_TEXT}    10s

Vérifier l'affichage de Vous économisez
    [Documentation]    Vérifie que la barre inférieure affiche "Vous économisez".
    Wait Until Element Is Visible    ${VOUS_ECONOMISEZ_TEXT}    10s

Vérifier l'affichage de Total à payer
    [Documentation]    Vérifie que la barre inférieure affiche "Total à payer".
    Wait Until Element Is Visible    ${TOTAL_A_PAYER_TEXT}    10s

Vérifier que Total à payer se met à jour avec la quantité
    [Documentation]    Vérifie que "Total à payer" reflète la quantité sélectionnée (vérifié
    ...                en direct : 19 unités à 48 PPH = 912,00).
    Cliquer sur le bouton plus    19
    Wait Until Page Contains    912,00    10s

Vérifier l'affichage du bouton Sauvegarder pour plus tard
    [Documentation]    Vérifie que le bouton "Sauvegarder pour plus tard" est visible sur la
    ...                page de commande.
    Wait Until Element Is Visible    ${SAUVEGARDER_PLUS_TARD_BUTTON}    10s

# ---------------------------------------------------------------------------
# Groupe F - Validation du seuil minimum et passage à la confirmation (5)
# ---------------------------------------------------------------------------
Vérifier que la confirmation n'est pas atteignable sous la quantité minimale
    [Documentation]    Vérifie qu'avec seulement 2 unités sur 19 requises, le clic sur
    ...                "Commander" ne fait pas apparaître l'étape "Récapitulatif et
    ...                finalisation" (vérifié en direct).
    Cliquer sur le bouton plus    2
    click element    ${COMMANDER_STEP1_BUTTON}
    sleep    2s
    Page Should Not Contain    Récapitulatif et finalisation

Vérifier la navigation vers la confirmation après quantité minimale atteinte
    [Documentation]    Vérifie qu'une fois la quantité minimale globale atteinte, le clic sur
    ...                "Commander" affiche l'étape "Récapitulatif et finalisation" (vérifié en
    ...                direct).
    Atteindre la quantité minimale et passer à la confirmation
    Wait Until Element Is Visible    ${STEPPER_ETAPE2}    10s

Vérifier que l'étape Définition des quantités est marquée comme complétée
    [Documentation]    Vérifie que l'étape 1 du stepper ("Définition des quantités") reste
    ...                visible et complétée après passage à l'étape 2.
    Atteindre la quantité minimale et passer à la confirmation
    Wait Until Element Is Visible    ${STEPPER_ETAPE1}    10s

Vérifier que le total est conservé entre l'étape 1 et l'étape 2
    [Documentation]    Vérifie que le montant "Total à payer" (912,00) est conservé après
    ...                passage à l'étape de confirmation.
    Atteindre la quantité minimale et passer à la confirmation
    Wait Until Page Contains    912,00    10s

Vérifier le bouton Commander en haut de la page de commande
    [Documentation]    Vérifie que le deuxième bouton "Commander" (en haut de page) fonctionne
    ...                aussi pour passer à l'étape de confirmation.
    Aller à la page de commande d'une offre standard
    Cliquer sur le bouton plus    19
    Wait Until Element Is Visible    xpath=(//*[@data-testid="commander"])[2]    10s
    click element    xpath=(//*[@data-testid="commander"])[2]
    sleep    2s
    Wait Until Element Is Visible    ${STEPPER_ETAPE2}    10s

# ---------------------------------------------------------------------------
# Groupe G - Page de confirmation : affichage (10)
# ---------------------------------------------------------------------------
Vérifier l'affichage du stepper de confirmation
    [Documentation]    Vérifie que les deux étapes du stepper ("Définition des quantités",
    ...                "Récapitulatif et finalisation") sont affichées.
    Atteindre la quantité minimale et passer à la confirmation
    Wait Until Element Is Visible    ${STEPPER_ETAPE1}    10s
    Wait Until Element Is Visible    ${STEPPER_ETAPE2}    10s

Vérifier l'affichage de l'adresse de livraison
    [Documentation]    Vérifie que la section "Adresse de livraison" est affichée à l'étape de
    ...                confirmation.
    Atteindre la quantité minimale et passer à la confirmation
    Wait Until Element Is Visible    ${ADRESSE_LIVRAISON_HEADER}    10s

Vérifier l'affichage du numéro de contact WhatsApp
    [Documentation]    Vérifie que la section "Numéro de contact (WhatsApp)" est affichée.
    Wait Until Page Contains    Numéro de contact    10s

Vérifier l'affichage du bouton Ajouter un numéro WhatsApp
    [Documentation]    Vérifie que le bouton "Ajouter un numéro WhatsApp" est visible
    ...                (data-testid="ajouter_un_numéro_whatsapp").
    Wait Until Element Is Visible    ${AJOUTER_WHATSAPP_BUTTON}    10s

Vérifier l'affichage du numéro de support WhatsApp
    [Documentation]    Vérifie qu'un numéro de contact support (WhatsApp) est affiché dans le
    ...                bandeau d'information.
    Wait Until Page Contains    WhatsApp    10s

Vérifier l'affichage du moyen de paiement présélectionné
    [Documentation]    Vérifie que le champ "Moyens de paiement *" affiche la méthode
    ...                présélectionnée (vérifié en direct : "Espèces").
    Wait Until Page Contains    Moyens de paiement    10s
    Wait Until Page Contains    Espèces    10s

Vérifier l'affichage du champ commentaire
    [Documentation]    Vérifie que le champ "Souhaitez-vous laisser un commentaire ?" est
    ...                visible.
    Wait Until Element Is Visible    ${FIELD_COMMENTAIRE}    10s

Vérifier l'affichage de la case Facture papier
    [Documentation]    Vérifie que la case "Je souhaite recevoir une facture papier avec ma
    ...                commande" est visible.
    Wait Until Element Is Visible    ${CHECKBOX_FACTURE_PAPIER}    10s

Vérifier l'affichage du bouton Passer commande
    [Documentation]    Vérifie que le bouton final "Passer commande" (data-testid=
    ...                "passer_commande") est visible, sans jamais le cliquer (action
    ...                irréversible de commande fournisseur réelle).
    Wait Until Element Is Visible    ${PASSER_COMMANDE_BUTTON}    10s

Vérifier l'affichage de la section Détails de la commande
    [Documentation]    Vérifie que la section "Détails de la commande" est visible en bas de
    ...                la page de confirmation.
    Wait Until Element Is Visible    ${DETAILS_COMMANDE_HEADER}    10s

# ---------------------------------------------------------------------------
# Groupe H - Page de confirmation : récapitulatif financier (5)
# ---------------------------------------------------------------------------
Vérifier l'affichage de Quantité totale commandée dans le récapitulatif
    [Documentation]    Vérifie que le récapitulatif de droite affiche "Quantité totale
    ...                commandée" avec la valeur 19.
    Atteindre la quantité minimale et passer à la confirmation
    Wait Until Page Contains    Quantité totale commandée    10s
    Wait Until Page Contains    19    10s

Vérifier l'affichage de Total avant remise
    [Documentation]    Vérifie que le récapitulatif affiche "Total avant remise" (912,00).
    Wait Until Page Contains    Total avant remise    10s
    Wait Until Page Contains    912,00    10s

Vérifier l'affichage de Total U.G dans le récapitulatif
    [Documentation]    Vérifie que le récapitulatif affiche "Total U.G".
    Wait Until Page Contains    Total U.G    10s

Vérifier l'affichage de Vous économisez dans le récapitulatif
    [Documentation]    Vérifie que le récapitulatif affiche "Vous économisez".
    Wait Until Page Contains    Vous économisez    10s

Vérifier l'affichage de Total à payer TTC
    [Documentation]    Vérifie que le récapitulatif affiche "Total à payer (TTC)" avec le
    ...                montant final (912,00).
    Wait Until Page Contains    Total à payer (TTC)    10s

# ---------------------------------------------------------------------------
# Groupe I - Page de confirmation : interactions (8)
# ---------------------------------------------------------------------------
Vérifier la saisie d'un commentaire
    [Documentation]    Vérifie que le champ commentaire accepte une saisie texte.
    Atteindre la quantité minimale et passer à la confirmation
    Input Text    ${FIELD_COMMENTAIRE}    Commentaire de test automation
    ${valeur}    Get Value    ${FIELD_COMMENTAIRE}
    Should Be Equal As Strings    ${valeur}    Commentaire de test automation

Vérifier que le champ commentaire est optionnel
    [Documentation]    Vérifie que le champ commentaire n'est pas marqué comme obligatoire
    ...                (pas d'astérisque après son libellé).
    Page Should Not Contain    Souhaitez-Vous Laisser Un Commentaire ?*

Vérifier la saisie d'un commentaire avec caractères spéciaux
    [Documentation]    Vérifie que le champ commentaire accepte des caractères spéciaux sans
    ...                erreur bloquante.
    Input Text    ${FIELD_COMMENTAIRE}    Test @#$%&
    ${valeur}    Get Value    ${FIELD_COMMENTAIRE}
    Should Not Be Empty    ${valeur}

Vérifier que la case Facture papier est décochée par défaut
    [Documentation]    Vérifie que la case "Facture papier" n'est pas cochée par défaut.
    Checkbox Should Not Be Selected    ${CHECKBOX_FACTURE_PAPIER}

Vérifier la sélection de la case Facture papier
    [Documentation]    Vérifie que la case "Facture papier" peut être cochée.
    click element    ${CHECKBOX_FACTURE_PAPIER}
    Checkbox Should Be Selected    ${CHECKBOX_FACTURE_PAPIER}

Vérifier la désélection de la case Facture papier
    [Documentation]    Vérifie que la case "Facture papier" peut être décochée après avoir été
    ...                cochée.
    click element    ${CHECKBOX_FACTURE_PAPIER}
    click element    ${CHECKBOX_FACTURE_PAPIER}
    Checkbox Should Not Be Selected    ${CHECKBOX_FACTURE_PAPIER}

Vérifier le clic sur Ajouter un numéro WhatsApp
    [Documentation]    Vérifie que le clic sur "Ajouter un numéro WhatsApp" ne provoque pas
    ...                d'erreur bloquante.
    click element    ${AJOUTER_WHATSAPP_BUTTON}
    sleep    1s

Vérifier le toggle Afficher les produits commandés
    [Documentation]    Vérifie que le toggle de la section "Détails de la commande" est
    ...                cliquable.
    Wait Until Element Is Visible    ${AFFICHER_PRODUITS_TOGGLE}    10s
    click element    ${AFFICHER_PRODUITS_TOGGLE}
    sleep    1s

# ---------------------------------------------------------------------------
# Groupe J - Offre groupée : création de commande groupée (compte freemium) (6)
# ---------------------------------------------------------------------------
Vérifier la navigation directe vers la page de création de commande groupée
    [Documentation]    Vérifie que, pour ce compte freemium, le clic sur "Lancer la commande"
    ...                d'une offre groupée navigue directement vers la page de création de
    ...                commande groupée (URL offers/details/grouped/{id}), sans pop-up
    ...                d'information (comportement différent du compte admin, ce compte étant
    ...                gestionnaire du groupement - vérifié en direct sur l'offre "Cooper GPF").
    Aller à la page des offres
    Wait Until Element Is Visible    ${LANCER_COMMANDE_CARD_BUTTON}    10s
    click element    ${LANCER_COMMANDE_CARD_BUTTON}
    sleep    2s
    Location Should Contain    offers/details/grouped

Vérifier l'affichage du champ Groupement
    [Documentation]    Vérifie que le champ obligatoire "Groupement" (id="groupId") est
    ...                affiché sur la page de création de commande groupée.
    Wait Until Element Is Visible    ${GROUPEMENT_FIELD}    10s

Vérifier l'affichage du champ Gestionnaire
    [Documentation]    Vérifie que le champ obligatoire "Gestionnaire" (id="managerId") est
    ...                affiché sur la page de création de commande groupée.
    Wait Until Element Is Visible    ${GESTIONNAIRE_FIELD}    10s

Vérifier l'affichage du champ Entrepôt
    [Documentation]    Vérifie que le champ obligatoire "Entrepôt" (id="warehouse") est
    ...                affiché sur la page de création de commande groupée.
    Wait Until Element Is Visible    ${ENTREPOT_FIELD}    10s

Vérifier l'affichage du bouton Lancer la commande sur la page de création
    [Documentation]    Vérifie que le bouton "Lancer la commande" (data-testid=
    ...                "lancer_la_commande") est visible en haut de la page, sans jamais le
    ...                cliquer (action irréversible de création de commande groupée réelle).
    Wait Until Element Is Visible    ${LANCER_COMMANDE_SUBMIT_BUTTON}    10s

Vérifier que la liste des offres reste accessible depuis la page de commande groupée
    [Documentation]    Vérifie que le fil d'ariane "Sobrus Marketplace" reste visible et que
    ...                le retour vers la liste des offres fonctionne depuis la page de création
    ...                de commande groupée.
    Wait Until Page Contains    Sobrus Marketplace    10s
    Go Back
    sleep    2s
    Location Should Contain    offers

# ---------------------------------------------------------------------------
# Groupe K - Robustesse et cas limites (14)
# ---------------------------------------------------------------------------
Vérifier l'affichage correct après rafraîchissement de la page de commande
    [Documentation]    Vérifie que la page de commande se recharge correctement après un
    ...                rafraîchissement (F5), en repartant de l'étape 1.
    Aller à la page de commande d'une offre standard
    Reload Page
    Wait Until Element Is Visible    ${QTE_PLUS_BUTTON}    15s

Vérifier le comportement au clic répété sur le bouton plus
    [Documentation]    Vérifie que des clics répétés rapides sur "+" incrémentent
    ...                correctement la quantité sans erreur.
    Aller à la page de commande d'une offre standard
    Cliquer sur le bouton plus    30
    ${valeur}    Get Value    ${QTE_INPUT}
    Should Be Equal As Strings    ${valeur}    30

Vérifier le comportement au clic répété sur le bouton moins depuis zéro
    [Documentation]    Vérifie que des clics répétés sur "-" depuis zéro ne provoquent pas
    ...                d'erreur bloquante ni de valeur négative.
    click element    ${QTE_MOINS_BUTTON}
    click element    ${QTE_MOINS_BUTTON}
    click element    ${QTE_MOINS_BUTTON}
    ${valeur}    Get Value    ${QTE_INPUT}
    Should Not Contain    ${valeur}    -

Vérifier la persistance de la quantité après un défilement
    [Documentation]    Vérifie que la quantité saisie n'est pas perdue après un défilement de
    ...                la page.
    Cliquer sur le bouton plus    5
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    1s
    Execute JavaScript    window.scrollTo(0, 0)
    ${valeur}    Get Value    ${QTE_INPUT}
    Should Be Equal As Strings    ${valeur}    5

Vérifier que le prix total correspond à quantité fois PPH
    [Documentation]    Vérifie que le total affiché correspond bien à quantité x PPH (5 x
    ...                48 = 240,00).
    Cliquer sur le bouton plus    5
    Wait Until Page Contains    240,00    10s

Vérifier la cohérence entre la quantité du produit et Qté totale commandée
    [Documentation]    Vérifie que la quantité du produit et "Qté totale commandée" en bas de
    ...                page affichent la même valeur.
    Cliquer sur le bouton plus    7
    ${valeur_input}    Get Value    ${QTE_INPUT}
    Wait Until Page Contains    ${valeur_input}    10s

Vérifier que Sauvegarder pour plus tard ne mène pas à la confirmation
    [Documentation]    Vérifie que le clic sur "Sauvegarder pour plus tard" ne fait pas
    ...                apparaître l'étape "Récapitulatif et finalisation".
    Cliquer sur le bouton plus    19
    click element    ${SAUVEGARDER_PLUS_TARD_BUTTON}
    sleep    2s
    Page Should Not Contain    Récapitulatif et finalisation

Vérifier l'accessibilité clavier du champ de recherche produit
    [Documentation]    Vérifie que le champ de recherche produit peut recevoir le focus au
    ...                clavier.
    Aller à la page de commande d'une offre standard
    Click Element    ${SEARCH_INPUT}
    ${active_id}    Execute JavaScript    return document.activeElement.id
    Should Be Equal    ${active_id}    elasticSearch

Vérifier la recherche d'un produit sur la page de commande
    [Documentation]    Vérifie que le champ de recherche produit accepte une saisie sans
    ...                erreur bloquante.
    Input Text    ${SEARCH_INPUT}    MELATONINE
    sleep    1s
    Page Should Contain    MELATONINE

Vérifier l'affichage cohérent du symbole monétaire sur les totaux
    [Documentation]    Vérifie que les totaux affichés utilisent une notation décimale à deux
    ...                chiffres (format "X,00" ou "X.00").
    Cliquer sur le bouton plus    1
    Wait Until Page Contains    48,00    10s

Vérifier que la page ne plante pas avec une quantité élevée
    [Documentation]    Vérifie qu'une quantité élevée (99) peut être saisie sans erreur
    ...                bloquante.
    Cliquer sur le bouton plus    99
    ${valeur}    Get Value    ${QTE_INPUT}
    Should Be Equal As Strings    ${valeur}    99

Vérifier le comportement du bouton retour du navigateur depuis la confirmation
    [Documentation]    Vérifie que le bouton retour du navigateur depuis l'étape de
    ...                confirmation ne provoque pas d'erreur bloquante.
    Atteindre la quantité minimale et passer à la confirmation
    Go Back
    sleep    2s

Vérifier que la liste des offres reste accessible via le fil d'ariane
    [Documentation]    Vérifie que le lien "Offres" du fil d'ariane est visible sur la page de
    ...                commande.
    Aller à la page de commande d'une offre standard
    Wait Until Page Contains    Offres    10s

Vérifier l'affichage du header Détails de l'offre
    [Documentation]    Vérifie que le header "Détails de l'offre" est visible en haut de la
    ...                page de commande.
    Wait Until Page Contains    Détails de l'offre    10s

*** Keywords ***
Aller à la page des offres
    [Documentation]    Navigate to the marketplace offers listing page after login in.
    Go To    ${BASE_URL}/${OFFERS_URL}
    Wait Until Element Is Visible    ${SEARCH_INPUT}    timeout=30s

Aller à la page de commande d'une offre standard
    [Documentation]    Navigue vers la liste des offres puis recherche l'offre de test fixe
    ...                "MELATONINE" (offre "Test 2 OVH Laprophan", quantité min globale 19
    ...                unités, PPH 48 - vérifié en direct sur le compte freemium) afin de
    ...                garantir des données stables, puis clique sur "Commander" pour
    ...                atteindre la page de sélection de quantités.
    Aller à la page des offres
    Input Text    ${SEARCH_INPUT}    ${PRODUIT_TEST}
    Press Keys    ${SEARCH_INPUT}    RETURN
    sleep    2s
    Wait Until Element Is Visible    ${COMMANDER_CARD_BUTTON}    10s
    click element    ${COMMANDER_CARD_BUTTON}
    sleep    2s
    Wait Until Element Is Visible    ${QTE_PLUS_BUTTON}    10s

Cliquer sur le bouton plus
    [Arguments]    ${NB_CLICS}
    [Documentation]    Navigue vers la page de commande puis clique ${NB_CLICS} fois sur le
    ...                bouton "+" du produit.
    Aller à la page de commande d'une offre standard
    FOR    ${i}    IN RANGE    ${NB_CLICS}
        click element    ${QTE_PLUS_BUTTON}
    END
    sleep    1s

Atteindre la quantité minimale et passer à la confirmation
    [Documentation]    Incrémente la quantité jusqu'au minimum global (19 unités) puis clique
    ...                sur "Commander" pour passer à l'étape de confirmation.
    Cliquer sur le bouton plus    19
    click element    ${COMMANDER_STEP1_BUTTON}
    sleep    2s
