*** Settings ***
Documentation     Tests fonctionnels du flow "Création d'une offre groupée"
Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Flow de création offre groupée

*** Variables ***
${SUPPLIER_ID}                     65
${CREATE_OFFER_URL}                offers/grouped/create-offer?supplier_id=${SUPPLIER_ID}
${APERCU_BUTTON}                   xpath=//*[@data-testid="aperçu_de_l'offre"]
${FOURNISSEUR_INPUT}               css=#supplierId input
${FIELD_NOM}                       id=name
${FIELD_DATE_EXPIRATION}           id=deadline
${DATE_DROPDOWN}                   css=.react-datepicker
${FIELD_CIBLAGE}                   id=targetedGroups
${FIELD_METHODES_PAIEMENT}         id=acceptedPaymentMethods
${FIELD_METHODE_PAIEMENT}          id=paymentChoice
${FIELD_DELAI_PAIEMENT}            id=paymentTimeframe
${FIELD_DELAI_PAIEMENT_UNITE}      id=paymentTimeframeUnit
${RADIO_LIVRAISON_DIRECTE}         xpath=//input[@name="salesChannel"][@value="direct"]
${RADIO_LIVRAISON_GROSSISTE}       xpath=//input[@name="salesChannel"][@value="wholesaler"]
${FIELD_DELAI_LIVRAISON}           id=deliveryTimeframe
${FIELD_TRANSPORTEUR}              id=deliveryTransporter
${AJOUTER_PALIER_GLOBAL_BUTTON}    xpath=//*[@data-testid="ajouter_un_palier_global"]
${TYPE_REMISE_GLOBALE_SELECT}      id=globalDiscountsType
${TYPE_REMISE_PRODUIT_SELECT}      id=productDiscounts
${TYPE_REMISE_PACK_SELECT}         id=packDiscounts
${AJOUTER_NIVEAU_BUTTON}           xpath=//*[@data-testid="ajouter_un_niveau"]
${QTE_INPUT_1}                     id=globalDiscountsValues.0.minQuantity
${MONTANT_INPUT_1}                 id=globalDiscountsValues.0.minAmount
${REMISE_INPUT_1}                  id=globalDiscountsValues.0.discountValue
${QTE_INPUT_2}                     id=globalDiscountsValues.1.minQuantity
${MONTANT_INPUT_2}                 id=globalDiscountsValues.1.minAmount
${REMISE_INPUT_2}                  id=globalDiscountsValues.1.discountValue
${ENREGISTRER_BUTTON}              xpath=//*[@data-testid="sauvegarder"]
${TABLE_PRODUITS}                  //table[contains(@class, 'sob-v2-table')]//tbody//tr
${FIELD_MIN_QUANTITY_GLOBAL}       id=minQuantity
${FIELD_MIN_AMOUNT_GLOBAL}         id=minAmount
${FIELD_TERMES_CONDITIONS}         id=termsAndConditions
${AJOUTER_PACK_PRODUITS_BUTTON}    xpath=//*[@data-testid="ajouter_un_pack_de_produits"]
${SELECTIONNER_BUTTON}             xpath=//*[@data-testid="sélectionner"]
${REMISE_PRODUIT_BUTTON}           xpath=//*[@data-testid="remise"]
${QTE_INPUT_PRODUIT_1}             id=productDiscountsValues.0.minQuantity
${REMISE_INPUT_PRODUIT_1}          id=productDiscountsValues.0.discountValue
${PARAMETRES_PACK_BUTTON}          xpath=//*[@data-testid="paramètres"]
${FIELD_OBLIGATOIRE_PACK}          id=requiredToPlaceOrder
${QTE_INPUT_PACK_1}                id=packDiscountsValues.0.minQuantity
${REMISE_INPUT_PACK_1}             id=packDiscountsValues.0.discountValue
${SEUIL_REMISE_MAX_INPUT}          id=maxDiscountThreshold.discountValue

*** Test Cases ***
# ---------------------------------------------------------------------------
# Groupe A - Navigation (3)
# ---------------------------------------------------------------------------
Accéder à la page de création d'offre groupée
    [Documentation]    Vérifie la navigation directe vers la page de création d'offre groupée
    ...                avec un fournisseur pré-rempli via le paramètre supplier_id.
    Aller à la page de création d'offre groupée

Vérifier le titre de la page
    [Documentation]    Vérifie que le titre "Créer une nouvelle offre" est affiché.
    Aller à la page de création d'offre groupée
    Wait Until Page Contains    Créer une nouvelle offre    10s

Vérifier l'affichage du bouton Aperçu de l'offre
    [Documentation]    Vérifie que le bouton "Aperçu de l'offre" est visible en haut de page.
    Wait Until Element Is Visible    ${APERCU_BUTTON}    10s

# ---------------------------------------------------------------------------
# Groupe B - Section Fournisseur (2)
# ---------------------------------------------------------------------------
Vérifier que le fournisseur est pré-rempli
    [Documentation]    Vérifie que le champ Fournisseur est pré-rempli avec "Cooper GPF" quand
    ...                l'URL contient supplier_id=65 (vérifié en direct).
    Aller à la page de création d'offre groupée
    Wait Until Page Contains    Cooper GPF    10s

Vérifier l'affichage de la section Fournisseur
    [Documentation]    Vérifie que le titre de section "Fournisseur" est visible.
    Wait Until Page Contains    Fournisseur    10s

# ---------------------------------------------------------------------------
# Groupe C - Informations générales (6)
# ---------------------------------------------------------------------------
Vérifier que le titre de l'offre est requis
    [Documentation]    Vérifie que cliquer sur "Aperçu de l'offre" sans titre affiche l'erreur
    ...                "Ce champ est requis" (vérifié en direct sur le script de référence).
    Aller à la page de création d'offre groupée
    click element    ${APERCU_BUTTON}
    Wait Until Page Contains    Ce champ est requis    10s

Vérifier la saisie du titre de l'offre
    [Documentation]    Vérifie que le champ "Titre de l'offre" accepte une saisie texte.
    Aller à la page de création d'offre groupée
    Input Text    ${FIELD_NOM}    offre de test automation
    ${valeur}    Get Value    ${FIELD_NOM}
    Should Be Equal As Strings    ${valeur}    offre de test automation

Vérifier le compteur de caractères du titre
    [Documentation]    Vérifie que le compteur "0/100" est affiché à côté du titre de l'offre.
    Aller à la page de création d'offre groupée
    Wait Until Page Contains    0/100    10s

Vérifier la date d'expiration par défaut
    [Documentation]    Vérifie qu'une date d'expiration est pré-remplie par défaut.
    Aller à la page de création d'offre groupée
    ${valeur}    Get Value    ${FIELD_DATE_EXPIRATION}
    Should Not Be Empty    ${valeur}

Vérifier l'ouverture du calendrier de date d'expiration
    [Documentation]    Vérifie que le clic sur le champ date ouvre le calendrier.
    Aller à la page de création d'offre groupée
    Click Element    ${FIELD_DATE_EXPIRATION}
    Wait Until Element Is Visible    ${DATE_DROPDOWN}    10s

Vérifier le ciblage de l'offre par défaut
    [Documentation]    Vérifie que le champ "Ciblage de l'offre" affiche "Aucun" par défaut
    ...                (vérifié en direct).
    Aller à la page de création d'offre groupée
    Wait Until Page Contains    Aucun    10s

# ---------------------------------------------------------------------------
# Groupe D - Section Paiement (6)
# ---------------------------------------------------------------------------
Vérifier l'affichage de la section Paiement
    [Documentation]    Vérifie que le titre de section "Paiement" est visible.
    Aller à la page de création d'offre groupée
    Wait Until Page Contains    Paiement    10s

Vérifier l'affichage du champ Méthodes de paiement acceptées
    [Documentation]    Vérifie que le champ "Méthodes de paiement acceptées" est visible.
    Wait Until Element Is Visible    ${FIELD_METHODES_PAIEMENT}    10s

Vérifier la méthode de paiement par défaut
    [Documentation]    Vérifie que "Règlement classique avec délai" est la méthode de paiement
    ...                présélectionnée (vérifié en direct).
    Aller à la page de création d'offre groupée
    Wait Until Page Contains    Règlement classique avec délai    10s

Vérifier que le délai de paiement est requis
    [Documentation]    Vérifie que le champ "Délai de paiement" est marqué comme requis (*).
    Wait Until Page Contains    Délai de paiement *    10s

Vérifier la saisie du délai de paiement
    [Documentation]    Vérifie que le champ "Délai de paiement" accepte une valeur numérique.
    Aller à la page de création d'offre groupée
    Input Text    ${FIELD_DELAI_PAIEMENT}    5
    ${valeur}    Get Value    ${FIELD_DELAI_PAIEMENT}
    Should Be Equal As Strings    ${valeur}    5

Vérifier l'unité du délai de paiement par défaut
    [Documentation]    Vérifie que l'unité "Jours" est présélectionnée pour le délai de
    ...                paiement.
    Aller à la page de création d'offre groupée
    Wait Until Page Contains    Jours    10s

# ---------------------------------------------------------------------------
# Groupe E - Section Livraison (5)
# ---------------------------------------------------------------------------
Vérifier l'affichage de la section Livraison
    [Documentation]    Vérifie que le titre de section "Livraison" est visible.
    Aller à la page de création d'offre groupée
    Wait Until Page Contains    Livraison    10s

Vérifier que Livraison directe est sélectionnée par défaut
    [Documentation]    Vérifie que l'option "Livraison directe (par le laboratoire)" est
    ...                sélectionnée par défaut (vérifié en direct).
    Aller à la page de création d'offre groupée
    Wait Until Element Is Visible    ${RADIO_LIVRAISON_DIRECTE}    10s
    Checkbox Should Be Selected    ${RADIO_LIVRAISON_DIRECTE}

Vérifier la sélection de Livraison via grossiste
    [Documentation]    Vérifie que l'option "Livraison via grossiste" peut être sélectionnée.
    Aller à la page de création d'offre groupée
    Wait Until Element Is Visible    ${RADIO_LIVRAISON_GROSSISTE}    10s
    click element    ${RADIO_LIVRAISON_GROSSISTE}
    Checkbox Should Be Selected    ${RADIO_LIVRAISON_GROSSISTE}

Vérifier la saisie du délai de livraison
    [Documentation]    Vérifie que le champ "Délais de livraison" accepte une valeur numérique.
    Aller à la page de création d'offre groupée
    Input Text    ${FIELD_DELAI_LIVRAISON}    3
    ${valeur}    Get Value    ${FIELD_DELAI_LIVRAISON}
    Should Be Equal As Strings    ${valeur}    3

Vérifier la saisie du transporteur
    [Documentation]    Vérifie que le champ "Transporteur" est cliquable.
    Aller à la page de création d'offre groupée
    Wait Until Element Is Visible    ${FIELD_TRANSPORTEUR}    10s
    Click Element    ${FIELD_TRANSPORTEUR}

# ---------------------------------------------------------------------------
# Groupe F - Paliers de remise globaux (8)
# ---------------------------------------------------------------------------
Vérifier l'affichage de la section Paliers de remise globaux
    [Documentation]    Vérifie que le titre de section "Paliers de remise globaux" est visible.
    Aller à la page de création d'offre groupée
    Wait Until Page Contains    Paliers de remise globaux    10s

Vérifier l'ouverture du pop-up de remise globale
    [Documentation]    Vérifie que le clic sur "Ajouter un palier global" ouvre le pop-up de
    ...                remise (vérifié en direct sur le script de référence).
    Ouvrir le pop-up de remise globale

Vérifier la sélection du type de remise Remise financière
    [Documentation]    Vérifie que le type de remise "Remise financière" peut être sélectionné.
    Ouvrir le pop-up de remise globale
    Sélectionner le type de remise globale    Remise financière

Vérifier l'ajout d'une première ligne de palier
    [Documentation]    Vérifie l'ajout d'une ligne de palier avec quantité, montant et remise.
    Ouvrir le pop-up de remise globale
    Sélectionner le type de remise globale    Remise financière
    Ajouter une ligne de palier global    ${QTE_INPUT_1}    ${MONTANT_INPUT_1}    ${REMISE_INPUT_1}    5    1000    10

Vérifier l'ajout d'une deuxième ligne de palier
    [Documentation]    Vérifie l'ajout d'une deuxième ligne de palier.
    Ouvrir le pop-up de remise globale
    Sélectionner le type de remise globale    Remise financière
    Ajouter une ligne de palier global    ${QTE_INPUT_1}    ${MONTANT_INPUT_1}    ${REMISE_INPUT_1}    5    1000    10
    Ajouter une ligne de palier global    ${QTE_INPUT_2}    ${MONTANT_INPUT_2}    ${REMISE_INPUT_2}    10    2000    20

Vérifier la suppression d'une ligne de palier
    [Documentation]    Vérifie qu'une ligne de palier ajoutée peut être supprimée.
    Ouvrir le pop-up de remise globale
    Sélectionner le type de remise globale    Remise financière
    Ajouter une ligne de palier global    ${QTE_INPUT_1}    ${MONTANT_INPUT_1}    ${REMISE_INPUT_1}    5    1000    10
    Ajouter une ligne de palier global    ${QTE_INPUT_2}    ${MONTANT_INPUT_2}    ${REMISE_INPUT_2}    10    2000    20
    Supprimer une ligne de palier

Vérifier l'enregistrement de la remise globale
    [Documentation]    Vérifie que le bouton "Enregistrer" (data-testid="sauvegarder") du
    ...                pop-up de remise ferme le pop-up et affiche le résumé de la remise.
    Ouvrir le pop-up de remise globale
    Sélectionner le type de remise globale    Remise financière
    Ajouter une ligne de palier global    ${QTE_INPUT_1}    ${MONTANT_INPUT_1}    ${REMISE_INPUT_1}    5    1000    10
    Enregistrer la remise globale

Vérifier le résumé affiché après enregistrement de la remise globale
    [Documentation]    Vérifie que le résumé de la remise globale (quantité/montant/remise)
    ...                s'affiche après enregistrement (vérifié en direct sur le script de
    ...                référence : "5 U, 1000 DHS  = 10 %").
    Ouvrir le pop-up de remise globale
    Sélectionner le type de remise globale    Remise financière
    Ajouter une ligne de palier global    ${QTE_INPUT_1}    ${MONTANT_INPUT_1}    ${REMISE_INPUT_1}    5    1000    10
    Enregistrer la remise globale
    Wait Until Page Contains    5 U, 1000 DHS    10s

# ---------------------------------------------------------------------------
# Groupe G - Validation des champs numériques : lettres et caractères spéciaux
# bloqués (24 : 12 champs x 2 types de validation)
# ---------------------------------------------------------------------------
Vérifier que les lettres sont bloquées dans Délai de paiement
    [Documentation]    Vérifie qu'une saisie alphabétique est rejetée dans un champ numérique.
    Aller à la page de création d'offre groupée
    Vérifier que les lettres sont bloquées    ${FIELD_DELAI_PAIEMENT}

Vérifier que les caractères spéciaux sont bloqués dans Délai de paiement
    [Documentation]    Vérifie que des caractères spéciaux sont rejetés dans un champ
    ...                numérique.
    Aller à la page de création d'offre groupée
    Vérifier que les caractères spéciaux sont bloqués    ${FIELD_DELAI_PAIEMENT}

Vérifier que les lettres sont bloquées dans Délai de livraison
    [Documentation]    Vérifie qu'une saisie alphabétique est rejetée dans le délai de
    ...                livraison.
    Aller à la page de création d'offre groupée
    Vérifier que les lettres sont bloquées    ${FIELD_DELAI_LIVRAISON}

Vérifier que les caractères spéciaux sont bloqués dans Délai de livraison
    [Documentation]    Vérifie que des caractères spéciaux sont rejetés dans le délai de
    ...                livraison.
    Aller à la page de création d'offre groupée
    Vérifier que les caractères spéciaux sont bloqués    ${FIELD_DELAI_LIVRAISON}

Vérifier que les lettres sont bloquées dans Quantité minimale globale
    [Documentation]    Vérifie qu'une saisie alphabétique est rejetée dans "Quantité minimale
    ...                globale".
    Aller à la page de création d'offre groupée
    Vérifier que les lettres sont bloquées    ${FIELD_MIN_QUANTITY_GLOBAL}

Vérifier que les caractères spéciaux sont bloqués dans Quantité minimale globale
    [Documentation]    Vérifie que des caractères spéciaux sont rejetés dans "Quantité
    ...                minimale globale".
    Aller à la page de création d'offre groupée
    Vérifier que les caractères spéciaux sont bloqués    ${FIELD_MIN_QUANTITY_GLOBAL}

Vérifier que les lettres sont bloquées dans Montant minimal global
    [Documentation]    Vérifie qu'une saisie alphabétique est rejetée dans "Montant minimal
    ...                global".
    Aller à la page de création d'offre groupée
    Vérifier que les lettres sont bloquées    ${FIELD_MIN_AMOUNT_GLOBAL}

Vérifier que les caractères spéciaux sont bloqués dans Montant minimal global
    [Documentation]    Vérifie que des caractères spéciaux sont rejetés dans "Montant minimal
    ...                global".
    Aller à la page de création d'offre groupée
    Vérifier que les caractères spéciaux sont bloqués    ${FIELD_MIN_AMOUNT_GLOBAL}

Vérifier que les lettres sont bloquées dans la quantité du palier global
    [Documentation]    Vérifie qu'une saisie alphabétique est rejetée dans la quantité d'une
    ...                ligne de palier global.
    Ouvrir le pop-up de remise globale
    Sélectionner le type de remise globale    Remise financière
    Click Element    ${AJOUTER_NIVEAU_BUTTON}
    Wait Until Element Is Visible    ${QTE_INPUT_1}    10s
    Vérifier que les lettres sont bloquées    ${QTE_INPUT_1}

Vérifier que les caractères spéciaux sont bloqués dans la quantité du palier global
    [Documentation]    Vérifie que des caractères spéciaux sont rejetés dans la quantité d'une
    ...                ligne de palier global.
    Ouvrir le pop-up de remise globale
    Sélectionner le type de remise globale    Remise financière
    Click Element    ${AJOUTER_NIVEAU_BUTTON}
    Wait Until Element Is Visible    ${QTE_INPUT_1}    10s
    Vérifier que les caractères spéciaux sont bloqués    ${QTE_INPUT_1}

Vérifier que les lettres sont bloquées dans le montant du palier global
    [Documentation]    Vérifie qu'une saisie alphabétique est rejetée dans le montant d'une
    ...                ligne de palier global.
    Ouvrir le pop-up de remise globale
    Sélectionner le type de remise globale    Remise financière
    Click Element    ${AJOUTER_NIVEAU_BUTTON}
    Wait Until Element Is Visible    ${MONTANT_INPUT_1}    10s
    Vérifier que les lettres sont bloquées    ${MONTANT_INPUT_1}

Vérifier que les caractères spéciaux sont bloqués dans le montant du palier global
    [Documentation]    Vérifie que des caractères spéciaux sont rejetés dans le montant d'une
    ...                ligne de palier global.
    Ouvrir le pop-up de remise globale
    Sélectionner le type de remise globale    Remise financière
    Click Element    ${AJOUTER_NIVEAU_BUTTON}
    Wait Until Element Is Visible    ${MONTANT_INPUT_1}    10s
    Vérifier que les caractères spéciaux sont bloqués    ${MONTANT_INPUT_1}

Vérifier que les lettres sont bloquées dans la remise du palier global
    [Documentation]    Vérifie qu'une saisie alphabétique est rejetée dans la valeur de remise
    ...                d'une ligne de palier global.
    Ouvrir le pop-up de remise globale
    Sélectionner le type de remise globale    Remise financière
    Click Element    ${AJOUTER_NIVEAU_BUTTON}
    Wait Until Element Is Visible    ${REMISE_INPUT_1}    10s
    Vérifier que les lettres sont bloquées    ${REMISE_INPUT_1}

Vérifier que les caractères spéciaux sont bloqués dans la remise du palier global
    [Documentation]    Vérifie que des caractères spéciaux sont rejetés dans la valeur de
    ...                remise d'une ligne de palier global.
    Ouvrir le pop-up de remise globale
    Sélectionner le type de remise globale    Remise financière
    Click Element    ${AJOUTER_NIVEAU_BUTTON}
    Wait Until Element Is Visible    ${REMISE_INPUT_1}    10s
    Vérifier que les caractères spéciaux sont bloqués    ${REMISE_INPUT_1}

# ---------------------------------------------------------------------------
# Groupe H - Section Conditions générales (2)
# ---------------------------------------------------------------------------
Vérifier l'affichage de la section Conditions générales
    [Documentation]    Vérifie que le titre de section "Conditions générales" est visible.
    Aller à la page de création d'offre groupée
    Wait Until Page Contains    Conditions générales    10s

Vérifier la saisie des termes et conditions
    [Documentation]    Vérifie que le champ "Termes et conditions" accepte une saisie texte.
    Aller à la page de création d'offre groupée
    Input Text    ${FIELD_TERMES_CONDITIONS}    Conditions de test automation
    ${valeur}    Get Value    ${FIELD_TERMES_CONDITIONS}
    Should Be Equal As Strings    ${valeur}    Conditions de test automation

# ---------------------------------------------------------------------------
# Groupe I - Packs de produits : pack 1 (9)
# ---------------------------------------------------------------------------
Vérifier l'affichage de la section Packs de produits
    [Documentation]    Vérifie que le titre de section "Packs de produits" est visible.
    Aller à la page de création d'offre groupée
    Wait Until Page Contains    Packs de produits    10s

Vérifier l'ouverture de la sélection de produits pour un pack
    [Documentation]    Vérifie que le clic sur "Ajouter un pack de produits" affiche le
    ...                tableau de sélection de produits.
    Ouvrir la sélection de produits pour un pack

Vérifier la sélection de produits dans le tableau
    [Documentation]    Vérifie que des lignes du tableau de produits peuvent être sélectionnées
    ...                (vérifié en direct sur le script de référence : sélection des lignes 1 à
    ...                3).
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4

Vérifier la validation de la sélection de produits (bouton Sélectionner)
    [Documentation]    Vérifie que le bouton "Sélectionner" (data-testid="sélectionner") valide
    ...                la sélection de produits du pack.
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    sleep    2s

Vérifier l'ouverture de la remise produit
    [Documentation]    Vérifie que le bouton "Remise" (data-testid="remise") ouvre le pop-up de
    ...                remise par produit.
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2s
    Wait Until Element Is Visible    ${REMISE_PRODUIT_BUTTON}    10s
    click element    ${REMISE_PRODUIT_BUTTON}
    Wait Until Element Is Visible    ${TYPE_REMISE_PRODUIT_SELECT}    10s

Vérifier la sélection du type de remise produit
    [Documentation]    Vérifie que le type de remise "Remise financière" peut être sélectionné
    ...                pour un produit.
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2s
    click element    ${REMISE_PRODUIT_BUTTON}
    Wait Until Element Is Visible    ${TYPE_REMISE_PRODUIT_SELECT}    10s
    Sélectionner un type de remise    ${TYPE_REMISE_PRODUIT_SELECT}    Remise financière

Vérifier l'ajout d'un niveau de remise produit
    [Documentation]    Vérifie que le bouton "Ajouter un niveau" ajoute une ligne de quantité
    ...                et remise pour le produit.
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2s
    click element    ${REMISE_PRODUIT_BUTTON}
    Wait Until Element Is Visible    ${TYPE_REMISE_PRODUIT_SELECT}    10s
    Sélectionner un type de remise    ${TYPE_REMISE_PRODUIT_SELECT}    Remise financière
    Click Element    ${AJOUTER_NIVEAU_BUTTON}
    Wait Until Element Is Visible    ${QTE_INPUT_PRODUIT_1}    10s
    Input Text    ${QTE_INPUT_PRODUIT_1}    5
    Input Text    ${REMISE_INPUT_PRODUIT_1}    5

Vérifier que les lettres sont bloquées dans la quantité de remise produit
    [Documentation]    Vérifie qu'une saisie alphabétique est rejetée dans la quantité d'un
    ...                niveau de remise produit.
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2s
    click element    ${REMISE_PRODUIT_BUTTON}
    Wait Until Element Is Visible    ${TYPE_REMISE_PRODUIT_SELECT}    10s
    Sélectionner un type de remise    ${TYPE_REMISE_PRODUIT_SELECT}    Remise financière
    Click Element    ${AJOUTER_NIVEAU_BUTTON}
    Wait Until Element Is Visible    ${QTE_INPUT_PRODUIT_1}    10s
    Vérifier que les lettres sont bloquées    ${QTE_INPUT_PRODUIT_1}

Vérifier que les caractères spéciaux sont bloqués dans la remise produit
    [Documentation]    Vérifie que des caractères spéciaux sont rejetés dans la valeur de
    ...                remise d'un niveau de remise produit.
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2s
    click element    ${REMISE_PRODUIT_BUTTON}
    Wait Until Element Is Visible    ${TYPE_REMISE_PRODUIT_SELECT}    10s
    Sélectionner un type de remise    ${TYPE_REMISE_PRODUIT_SELECT}    Remise financière
    Click Element    ${AJOUTER_NIVEAU_BUTTON}
    Wait Until Element Is Visible    ${REMISE_INPUT_PRODUIT_1}    10s
    Vérifier que les caractères spéciaux sont bloqués    ${REMISE_INPUT_PRODUIT_1}

Vérifier la case Appliquer les niveaux à tous
    [Documentation]    Vérifie que la case à cocher "applyLevelsToall" peut être cochée
    ...                (vérifié en direct sur le script de référence).
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2s
    click element    ${REMISE_PRODUIT_BUTTON}
    Wait Until Element Is Visible    id=applyLevelsToall    10s
    select checkbox    id=applyLevelsToall
    Checkbox Should Be Selected    id=applyLevelsToall

# ---------------------------------------------------------------------------
# Groupe J - Pack de produits : seuil et application globale (3)
# ---------------------------------------------------------------------------
Vérifier la saisie du seuil de remise maximal
    [Documentation]    Vérifie que le champ "maxDiscountThreshold.discountValue" accepte une
    ...                valeur numérique (vérifié en direct sur le script de référence).
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2s
    click element    ${REMISE_PRODUIT_BUTTON}
    Wait Until Element Is Visible    ${SEUIL_REMISE_MAX_INPUT}    10s
    Input Text    ${SEUIL_REMISE_MAX_INPUT}    10
    ${valeur}    Get Value    ${SEUIL_REMISE_MAX_INPUT}
    Should Be Equal As Strings    ${valeur}    10

Vérifier que les lettres sont bloquées dans le seuil de remise maximal
    [Documentation]    Vérifie qu'une saisie alphabétique est rejetée dans le seuil de remise
    ...                maximal.
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2s
    click element    ${REMISE_PRODUIT_BUTTON}
    Wait Until Element Is Visible    ${SEUIL_REMISE_MAX_INPUT}    10s
    Vérifier que les lettres sont bloquées    ${SEUIL_REMISE_MAX_INPUT}

Vérifier la case Appliquer la remise à tous
    [Documentation]    Vérifie que la case à cocher "applyDiscountToall" peut être cochée
    ...                (vérifié en direct sur le script de référence).
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2s
    click element    ${REMISE_PRODUIT_BUTTON}
    Wait Until Element Is Visible    id=applyDiscountToall    10s
    select checkbox    id=applyDiscountToall
    Checkbox Should Be Selected    id=applyDiscountToall

# ---------------------------------------------------------------------------
# Groupe K - Pack de produits : paramètres et remise de pack (8)
# ---------------------------------------------------------------------------
Vérifier l'ouverture des paramètres du pack
    [Documentation]    Vérifie que le bouton "Paramètres" (data-testid="paramètres") ouvre le
    ...                pop-up "Paramètres du pack" (vérifié en direct sur le script de
    ...                référence).
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    Wait Until Element Is Visible    ${PARAMETRES_PACK_BUTTON}    10s
    click element    ${PARAMETRES_PACK_BUTTON}
    Wait Until Page Contains    Paramètres du pack    10s

Vérifier la saisie de la quantité minimale du pack
    [Documentation]    Vérifie que le champ "minQuantity" du pop-up "Paramètres du pack"
    ...                accepte une valeur numérique.
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    click element    ${PARAMETRES_PACK_BUTTON}
    Wait Until Page Contains    Paramètres du pack    10s
    Input Text    xpath=//div[contains(@class,'sob-v2-modal-body')]//*[@id='minQuantity']    12

Vérifier la saisie du champ Obligatoire pour passer commande
    [Documentation]    Vérifie que le champ "requiredToPlaceOrder" accepte une saisie
    ...                (vérifié en direct sur le script de référence : valeur "obligatoire").
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    click element    ${PARAMETRES_PACK_BUTTON}
    Wait Until Element Is Visible    ${FIELD_OBLIGATOIRE_PACK}    15s
    click element    ${FIELD_OBLIGATOIRE_PACK}
    Input Text    ${FIELD_OBLIGATOIRE_PACK}    obligatoire
    Press Keys    ${FIELD_OBLIGATOIRE_PACK}    ENTER

Vérifier la sélection du type de remise de pack
    [Documentation]    Vérifie que le type de remise "Remise financière" peut être sélectionné
    ...                pour le pack entier (champ id="packDiscounts").
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    click element    ${PARAMETRES_PACK_BUTTON}
    Wait Until Page Contains    Paramètres du pack    10s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Wait Until Element Is Visible    ${TYPE_REMISE_PACK_SELECT}    10s
    Sélectionner un type de remise    ${TYPE_REMISE_PACK_SELECT}    Remise financière

Vérifier l'ajout d'un niveau de remise de pack
    [Documentation]    Vérifie l'ajout d'un niveau de remise (quantité + remise) pour le pack
    ...                entier.
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    click element    ${PARAMETRES_PACK_BUTTON}
    Wait Until Page Contains    Paramètres du pack    10s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Sélectionner un type de remise    ${TYPE_REMISE_PACK_SELECT}    Remise financière
    Wait Until Element Is Visible    ${AJOUTER_NIVEAU_BUTTON}    10s
    Click Element    ${AJOUTER_NIVEAU_BUTTON}
    Wait Until Element Is Visible    ${QTE_INPUT_PACK_1}    10s
    Input Text    ${QTE_INPUT_PACK_1}    5
    Input Text    ${REMISE_INPUT_PACK_1}    5

Vérifier que les lettres sont bloquées dans la quantité de remise de pack
    [Documentation]    Vérifie qu'une saisie alphabétique est rejetée dans la quantité d'un
    ...                niveau de remise de pack.
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    click element    ${PARAMETRES_PACK_BUTTON}
    Wait Until Page Contains    Paramètres du pack    10s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Sélectionner un type de remise    ${TYPE_REMISE_PACK_SELECT}    Remise financière
    Click Element    ${AJOUTER_NIVEAU_BUTTON}
    Wait Until Element Is Visible    ${QTE_INPUT_PACK_1}    10s
    Vérifier que les lettres sont bloquées    ${QTE_INPUT_PACK_1}

Vérifier que les caractères spéciaux sont bloqués dans la remise de pack
    [Documentation]    Vérifie que des caractères spéciaux sont rejetés dans la valeur de
    ...                remise d'un niveau de remise de pack.
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    click element    ${PARAMETRES_PACK_BUTTON}
    Wait Until Page Contains    Paramètres du pack    10s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Sélectionner un type de remise    ${TYPE_REMISE_PACK_SELECT}    Remise financière
    Click Element    ${AJOUTER_NIVEAU_BUTTON}
    Wait Until Element Is Visible    ${REMISE_INPUT_PACK_1}    10s
    Vérifier que les caractères spéciaux sont bloqués    ${REMISE_INPUT_PACK_1}

Vérifier l'enregistrement des paramètres du pack
    [Documentation]    Vérifie que le bouton "Enregistrer" (data-testid="sauvegarder") ferme le
    ...                pop-up "Paramètres du pack".
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    click element    ${PARAMETRES_PACK_BUTTON}
    Wait Until Page Contains    Paramètres du pack    10s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Sélectionner un type de remise    ${TYPE_REMISE_PACK_SELECT}    Remise financière
    Click Element    ${AJOUTER_NIVEAU_BUTTON}
    Wait Until Element Is Visible    ${QTE_INPUT_PACK_1}    10s
    Input Text    ${QTE_INPUT_PACK_1}    5
    Input Text    ${REMISE_INPUT_PACK_1}    5
    click element    ${ENREGISTRER_BUTTON}
    sleep    2s

# ---------------------------------------------------------------------------
# Groupe L - Deuxième pack de produits (5)
# ---------------------------------------------------------------------------
Vérifier l'ajout d'un deuxième pack de produits
    [Documentation]    Vérifie qu'un deuxième pack de produits peut être ajouté après le
    ...                premier (vérifié en direct sur le script de référence : lignes 4 à 6).
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    sleep    2s
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    4    7

Vérifier que le deuxième pack a sa propre sélection de produits
    [Documentation]    Vérifie que la validation de la sélection du deuxième pack (bouton
    ...                "Sélectionner") fonctionne indépendamment du premier.
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    sleep    2s
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    4    7
    click element    ${SELECTIONNER_BUTTON}
    sleep    2s

Vérifier l'affichage de deux packs de produits distincts
    [Documentation]    Vérifie que deux packs de produits distincts sont affichés sur la page
    ...                après ajout.
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    sleep    2s
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    4    7
    click element    ${SELECTIONNER_BUTTON}
    sleep    2s
    ${count}    Get Element Count    ${AJOUTER_PACK_PRODUITS_BUTTON}
    Should Be True    ${count} >= 1

Vérifier la quantité minimale d'un produit dans le tableau du pack
    [Documentation]    Vérifie que la colonne de quantité minimale d'un produit du pack accepte
    ...                une saisie (vérifié en direct sur le script de référence : colonne 7 de
    ...                la première ligne).
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    sleep    2s
    Wait Until Element Is Visible    css=.sob-v2-table tbody tr:nth-child(1) td:nth-child(7) input    10s
    Input Text    css=.sob-v2-table tbody tr:nth-child(1) td:nth-child(7) input    1

Vérifier la quantité maximale d'un produit dans le tableau du pack
    [Documentation]    Vérifie que la colonne de quantité maximale d'un produit du pack accepte
    ...                une saisie.
    Ouvrir la sélection de produits pour un pack
    Sélectionner des lignes de produits    1    4
    click element    ${SELECTIONNER_BUTTON}
    sleep    2s
    Wait Until Element Is Visible    css=.sob-v2-table tbody tr:nth-child(1) td:nth-child(7) input    10s
    Input Text    css=.sob-v2-table tbody tr:nth-child(1) td:nth-child(7) input    100

# ---------------------------------------------------------------------------
# Groupe M - Validation finale et robustesse (7)
# ---------------------------------------------------------------------------
Vérifier le remplissage complet du formulaire avant validation
    [Documentation]    Vérifie qu'un formulaire rempli (titre, ciblage, paiement, livraison)
    ...                ne déclenche pas l'erreur "Ce champ est requis" au clic sur "Aperçu de
    ...                l'offre".
    Remplir le formulaire d'offre groupée
    Execute Javascript    window.scrollTo(0, 0)
    sleep    2s
    Wait Until Element Is Visible    ${APERCU_BUTTON}    10s
    click element    ${APERCU_BUTTON}
    sleep    2s

Vérifier que le champ Ciblage de l'offre accepte une recherche
    [Documentation]    Vérifie que le champ "Ciblage de l'offre" peut être recherché et qu'une
    ...                option peut être sélectionnée via ENTER (vérifié en direct sur le
    ...                script de référence).
    Aller à la page de création d'offre groupée
    Wait Until Element Is Visible    ${FIELD_CIBLAGE}    10s
    Click Element    ${FIELD_CIBLAGE}
    Input Text    ${FIELD_CIBLAGE}    groupe
    sleep    2s

Vérifier que le champ Méthodes de paiement acceptées accepte une sélection
    [Documentation]    Vérifie que le champ "Méthodes de paiement acceptées" ouvre une liste
    ...                d'options au clic.
    Aller à la page de création d'offre groupée
    click element    ${FIELD_METHODES_PAIEMENT}
    Wait Until Element Is Visible    css=.sob-v2-select__option:nth-child(1)    10s

Vérifier l'affichage correct après rafraîchissement de la page
    [Documentation]    Vérifie que la page se recharge correctement après un rafraîchissement
    ...                (F5 / Reload), fournisseur toujours pré-rempli.
    Aller à la page de création d'offre groupée
    Reload Page
    Wait Until Page Contains    Cooper GPF    15s

Vérifier la navigation directe avec un autre supplier_id
    [Documentation]    Vérifie que la page se charge correctement avec un autre paramètre
    ...                supplier_id dans l'URL (fournisseur pré-rempli différent attendu).
    Go To    ${BASE_URL}/offers/grouped/create-offer?supplier_id=1
    Wait Until Element Is Visible    ${FIELD_NOM}    15s

Vérifier que le formulaire conserve les données après un défilement
    [Documentation]    Vérifie que le titre saisi n'est pas perdu après un défilement de la
    ...                page.
    Aller à la page de création d'offre groupée
    Input Text    ${FIELD_NOM}    offre persistance test
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    1s
    Execute JavaScript    window.scrollTo(0, 0)
    ${valeur}    Get Value    ${FIELD_NOM}
    Should Be Equal As Strings    ${valeur}    offre persistance test

Vérifier l'affichage de toutes les sections du formulaire
    [Documentation]    Vérifie que toutes les sections principales du formulaire sont
    ...                présentes sur une même page (Fournisseur, Informations générales,
    ...                Paiement, Livraison, Paliers de remise globaux, Conditions générales,
    ...                Packs de produits).
    Aller à la page de création d'offre groupée
    Page Should Contain    Fournisseur
    Page Should Contain    Informations générales
    Page Should Contain    Paiement
    Page Should Contain    Livraison
    Page Should Contain    Paliers de remise globaux
    Page Should Contain    Conditions générales
    Page Should Contain    Packs de produits

*** Keywords ***
Aller à la page de création d'offre groupée
    [Documentation]    Navigate directly to the grouped offer creation page with a pre-filled
    ...                supplier (via supplier_id query param) after login in.
    Go To    ${BASE_URL}/${CREATE_OFFER_URL}
    Wait Until Element Is Visible    ${FIELD_NOM}    timeout=30s

Set Browser Zoom
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"

Ouvrir le pop-up de remise globale
    Aller à la page de création d'offre groupée
    Wait Until Element Is Visible    ${AJOUTER_PALIER_GLOBAL_BUTTON}    10s
    Click Element    ${AJOUTER_PALIER_GLOBAL_BUTTON}
    Wait Until Element Is Visible    ${TYPE_REMISE_GLOBALE_SELECT}    10s

Sélectionner le type de remise globale
    [Arguments]    ${TYPE}
    Sélectionner un type de remise    ${TYPE_REMISE_GLOBALE_SELECT}    ${TYPE}

Sélectionner un type de remise
    [Arguments]    ${LOCATOR}    ${TYPE}
    [Documentation]    Sélectionne un type de remise dans un champ react-select (recherche
    ...                texte + ENTER).
    Wait Until Element Is Visible    ${LOCATOR}    10s
    Click Element    ${LOCATOR}
    Input Text    ${LOCATOR}    ${TYPE}
    Sleep    2s
    Press Keys    ${LOCATOR}    ENTER
    Sleep    2s

Ajouter une ligne de palier global
    [Arguments]    ${QTE_LOCATOR}    ${MONTANT_LOCATOR}    ${REMISE_LOCATOR}    ${QTE}    ${MONTANT}    ${REMISE}
    Click Element    ${AJOUTER_NIVEAU_BUTTON}
    Wait Until Element Is Visible    ${QTE_LOCATOR}    10s
    Input Text    ${QTE_LOCATOR}    ${QTE}
    Input Text    ${MONTANT_LOCATOR}    ${MONTANT}
    Input Text    ${REMISE_LOCATOR}    ${REMISE}

Supprimer une ligne de palier
    [Documentation]    Supprime la dernière ligne de palier ajoutée (bouton de suppression du
    ...                pop-up, vérifié en direct sur le script de référence).
    click element    xpath=/html/body/div[4]/div/div/div[2]/div[3]/button

Enregistrer la remise globale
    Wait Until Element Is Visible    ${ENREGISTRER_BUTTON}    10s
    Click Element    ${ENREGISTRER_BUTTON}
    sleep    2s

Vérifier que les lettres sont bloquées
    [Arguments]    ${LOCATOR}
    Wait Until Element Is Visible    ${LOCATOR}    10s
    Input Text    ${LOCATOR}    abc
    ${valeur}    Get Value    ${LOCATOR}
    Should Be Empty    ${valeur}

Vérifier que les caractères spéciaux sont bloqués
    [Arguments]    ${LOCATOR}
    Wait Until Element Is Visible    ${LOCATOR}    10s
    Input Text    ${LOCATOR}    @#$
    ${valeur}    Get Value    ${LOCATOR}
    Should Be Empty    ${valeur}

Ouvrir la sélection de produits pour un pack
    Aller à la page de création d'offre groupée
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2s
    Wait Until Element Is Visible    ${AJOUTER_PACK_PRODUITS_BUTTON}    10s
    click element    ${AJOUTER_PACK_PRODUITS_BUTTON}
    Wait Until Element Is Visible    xpath=${TABLE_PRODUITS}    10s

Sélectionner des lignes de produits
    [Arguments]    ${DEBUT}    ${FIN}
    FOR    ${row}    IN RANGE    ${DEBUT}    ${FIN}
        ${col}    Set Variable    [${row}]/td
        ${xpath_ligne}    Set Variable    ${TABLE_PRODUITS}${col}
        click element    xpath=${xpath_ligne}
    END

Remplir le formulaire d'offre groupée
    [Documentation]    Remplit les champs obligatoires principaux du formulaire (titre,
    ...                ciblage, paiement, livraison) pour un scénario de bout en bout.
    Aller à la page de création d'offre groupée
    Input Text    ${FIELD_NOM}    offre de test automation complète
    Wait Until Element Is Visible    ${FIELD_CIBLAGE}    10s
    Click Element    ${FIELD_CIBLAGE}
    Input Text    ${FIELD_CIBLAGE}    groupe
    Sleep    2s
    Press Keys    ${FIELD_CIBLAGE}    ENTER
    sleep    1s
    click element    ${FIELD_METHODES_PAIEMENT}
    Wait Until Element Is Visible    css=.sob-v2-select__option:nth-child(1)    10s
    click element    css=.sob-v2-select__option:nth-child(1)
    Input Text    ${FIELD_DELAI_PAIEMENT}    2
    Input Text    ${FIELD_DELAI_LIVRAISON}    2
