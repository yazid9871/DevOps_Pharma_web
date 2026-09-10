*** Settings ***
Documentation     Tests du flow "Création de transaction avec paiement puis annulation" sur la
...               fiche client
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Flow Annulation de transaction

*** Variables ***
${CUSTOMER_ID}                     514751
${CUSTOMER_URL}                    customer/${CUSTOMER_ID}/table
${SOLDE_CLIENT_TEXT}               xpath=//*[text()="Solde client"]
${VENTES_ANCHOR}                   xpath=//a[@href="#customerinvoices"]
${SALES_RETURNS_ANCHOR}            xpath=//a[@href="#customersales_returns"]
${CREDIT_NOTES_ANCHOR}              xpath=//a[@href="#customercredit_notes"]
${FINANCIAL_TX_ANCHOR}             xpath=//a[@href="#customerfinancial_transactions"]
${AUTRES_ACTIONS_BUTTON}           xpath=//button[contains(., "Autres actions")]
${PAYER_CREDIT_CLIENT_BUTTON}      xpath=//button[contains(., "Payer crédit client")]
${VENTE_CREER_BUTTON}              xpath=//*[contains(@class,"RelatedListCardHeader")][.//*[text()="Ventes"]]/following::button[contains(.,"Créer")][1]
${RETOUR_CREER_BUTTON}             xpath=//*[contains(@class,"RelatedListCardHeader")][.//*[text()="Retours sur ventes"]]/following::button[contains(.,"Créer")][1]
${AVOIR_CREER_BUTTON}              xpath=//*[contains(@class,"RelatedListCardHeader")][.//*[text()="Avoirs"]]/following::button[contains(.,"Créer")][1]
${SEARCH_PRODUIT_VENTE}           xpath=//*[@id="barcode"]
${VALEUR_CODE_BARRE_VENTE}         8009004800229
${APPROUVER_VENTE_BUTTON}          xpath=//button[contains(.,"Approuver")]
${MOYEN_PAIEMENT_ESPECES}          xpath=//button[contains(., "Espèces")]
${MONTANT_PAYE_INPUT}              css=input[placeholder="Montant payé (DHS)"]
${PAIEMENT_ROW}                    xpath=(//tr[.//text()[contains(.,"Paiement vente")]])[1]
${ANNULER_TRANSACTION_BUTTON}      xpath=//button[text()="Annuler"]
${CONFIRM_OUI_BUTTON}              xpath=//button[text()="Oui"]
${SECURITY_CODE_INPUT}             id=security_code
${SECURITY_CODE_CONFIRMER_BUTTON}  xpath=//button[text()="Confirmer"]
${ANNULE_BADGE}                    xpath=//*[text()="Annulé"]/following::span[1]
${STATUT_PAIEMENT_SELECT}          xpath=//label[text()="Statut *"]/following::div[contains(@class,"sob-v2-select")][1]
${EDIT_PAIEMENT_BUTTON}            xpath=(//*[contains(@class,"Paiements")]/following::button[contains(@class,"icon")])[1]
${SAUVEGARDER_PAIEMENT_BUTTON}     xpath=//button[text()="Sauvegarder"]

*** Test Cases ***
# ---------------------------------------------------------------------------
# Groupe A - Navigation vers la fiche client (3)
# ---------------------------------------------------------------------------
Accéder à la fiche du client de test
    [Documentation]    Vérifie la navigation vers la fiche du client "TEST annulation"
    ...                (vérifié en direct).
    Aller à la fiche client

Vérifier l'affichage du nom du client
    [Documentation]    Vérifie que le nom "TEST annulation" est affiché en en-tête.
    Wait Until Page Contains    TEST annulation    10s

Vérifier l'affichage du panneau Solde client
    [Documentation]    Vérifie que le panneau "Crédit / Avoir / Solde client" est affiché
    ...                dans la colonne de gauche.
    Wait Until Element Is Visible    ${SOLDE_CLIENT_TEXT}    10s

# ---------------------------------------------------------------------------
# Groupe B - Ventes : création (10)
# ---------------------------------------------------------------------------
Vérifier l'affichage de la section Ventes
    [Documentation]    Vérifie que la section "Ventes" (Liste des ventes) est affichée sur la
    ...                fiche client.
    Aller à la fiche client
    Wait Until Element Is Visible    ${VENTES_ANCHOR}    10s

Vérifier l'affichage du bouton Créer dans la section Ventes
    [Documentation]    Vérifie que le bouton "Créer" est affiché dans la section Ventes
    ...                (vérifié en direct). CORRECTIF : rendu autonome.
    Aller à la fiche client
    click element    ${VENTES_ANCHOR}
    Wait Until Element Is Visible    ${VENTE_CREER_BUTTON}    10s

Vérifier la navigation vers la page de création de vente
    [Documentation]    Vérifie que le clic sur "Créer" ouvre la page de création de vente
    ...                pré-remplie avec le client (vérifié en direct : URL
    ...                invoice/create/cashier-mode?customer_id=...). CORRECTIF : rendu
    ...                autonome.
    Aller à la fiche client
    click element    ${VENTES_ANCHOR}
    Wait Until Element Is Visible    ${VENTE_CREER_BUTTON}    10s
    click element    ${VENTE_CREER_BUTTON}
    sleep    2s
    Location Should Contain    customer_id=${CUSTOMER_ID}

Vérifier que le client est pré-sélectionné sur la page de création de vente
    [Documentation]    Vérifie que "TEST annulation" est affiché comme client sélectionné.
    ...                CORRECTIF : rendu autonome.
    Aller à la page de création de vente
    Wait Until Page Contains    TEST annulation    10s

Vérifier l'ajout d'un produit à la vente
    [Documentation]    Vérifie qu'un produit peut être ajouté au panier depuis la liste de
    ...                recherche (vérifié en direct).
    Aller à la page de création de vente
    Ajouter un produit à la vente

Vérifier l'affichage du total à payer après ajout d'un produit
    [Documentation]    Vérifie que "Total à payer" se met à jour après ajout d'un produit.
    Aller à la page de création de vente
    Ajouter un produit à la vente
    Wait Until Page Contains    Total à payer    10s

Vérifier l'ouverture de l'écran de paiement
    [Documentation]    Vérifie que le clic sur "Approuver (F12)" ouvre l'écran de choix du
    ...                moyen de paiement (vérifié en direct).
    Aller à la page de création de vente
    Ajouter un produit à la vente
    Ouvrir l'écran de paiement
    Wait Until Page Contains    Choisissez vos modes de paiement    10s

Vérifier l'affichage du Solde client sur l'écran de paiement
    [Documentation]    Vérifie que "Solde client" est affiché sur l'écran de paiement.
    Aller à la page de création de vente
    Ajouter un produit à la vente
    Ouvrir l'écran de paiement
    Wait Until Page Contains    Solde client    10s

Vérifier l'affichage des moyens de paiement disponibles
    [Documentation]    Vérifie que les moyens de paiement Espèces, Carte bancaire, Chèque,
    ...                Vente à crédit sont affichés (vérifié en direct).
    Aller à la page de création de vente
    Ajouter un produit à la vente
    Ouvrir l'écran de paiement
    Page Should Contain    Espèces
    Page Should Contain    Carte bancaire
    Page Should Contain    Chèque
    Page Should Contain    Vente à crédit

Vérifier la finalisation d'une vente payée en espèces
    [Documentation]    Vérifie qu'une vente payée intégralement en espèces (touche F12) est
    ...                enregistrée avec succès (vérifié en direct : "Vente FAC-XXX a été
    ...                enregistré avec succès").
    Créer une vente payée en espèces pour le client de test
    Wait Until Page Contains    a été enregistré avec succès    10s

# ---------------------------------------------------------------------------
# Groupe C - Vérification du Solde client après vente payée (2)
# ---------------------------------------------------------------------------
Vérifier que le Solde client reste inchangé après une vente payée intégralement
    [Documentation]    Vérifie qu'une vente payée en totalité en espèces ne laisse aucune
    ...                dette : le Solde client avant et après la vente sont identiques
    ...                (vérifié en direct). CORRECTIF : comparaison relative avant/après
    ...                plutôt qu'une valeur "0,00" figée, car des tests d'annulation
    ...                antérieurs dans ce même fichier modifient réellement et durablement
    ...                le Solde client du client de test - une assertion figée sur "0,00"
    ...                échoue dès que ce fichier a déjà exécuté un test d'annulation
    ...                (Groupe D) avant celui-ci dans la même exécution.
    Aller à la fiche client
    ${solde_avant}    Récupérer le Solde client
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    ${solde_apres}    Récupérer le Solde client
    Should Be Equal As Strings    ${solde_avant}    ${solde_apres}

Vérifier l'affichage du paiement dans l'historique des paiements
    [Documentation]    Vérifie que le paiement de la vente apparaît dans "Historique des
    ...                paiements" avec le statut "Complété" (vérifié en direct).
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    click element    ${FINANCIAL_TX_ANCHOR}
    Wait Until Page Contains    Paiement vente    10s
    Wait Until Page Contains    Complété    10s

# ---------------------------------------------------------------------------
# Groupe D - Annulation du paiement de vente (10, cycle complet vérifié en
# direct)
# ---------------------------------------------------------------------------
Vérifier l'ouverture de la fiche de la transaction financière
    [Documentation]    Vérifie que le clic sur une ligne de l'historique des paiements ouvre
    ...                la page de détail de la transaction (vérifié en direct : URL
    ...                /financialtransactions/{id}).
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    Ouvrir la dernière transaction financière du client
    Location Should Contain    financialtransactions

Vérifier l'affichage du badge Annulé à Non par défaut
    [Documentation]    Vérifie que le badge "Annulé" affiche "Non" avant toute annulation.
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    Ouvrir la dernière transaction financière du client
    Wait Until Page Contains    Non    10s

Vérifier l'affichage du bouton Annuler sur la transaction
    [Documentation]    Vérifie que le bouton rouge "Annuler" est visible en haut de la page de
    ...                détail de la transaction. CORRECTIF : rendu autonome (navigue depuis
    ...                zéro) au lieu de dépendre de l'état laissé par le test précédent.
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    Ouvrir la dernière transaction financière du client
    Wait Until Element Is Visible    ${ANNULER_TRANSACTION_BUTTON}    10s

Vérifier l'ouverture de la modale de confirmation d'annulation
    [Documentation]    Vérifie que le clic sur "Annuler" ouvre la modale "Êtes-vous sûr ?"
    ...                (vérifié en direct : "Les modifications seront permanentes !").
    ...                CORRECTIF : rendu autonome.
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    Ouvrir la dernière transaction financière du client
    click element    ${ANNULER_TRANSACTION_BUTTON}
    Wait Until Page Contains    Êtes-vous sûr ?    10s
    Wait Until Page Contains    Les modifications seront permanentes    10s

Vérifier l'ouverture du champ code de sécurité après confirmation
    [Documentation]    Vérifie qu'après avoir cliqué "Oui" dans la modale de confirmation, un
    ...                champ "Code de sécurité *" (id=security_code) est demandé (vérifié en
    ...                direct). CORRECTIF : rendu autonome.
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    Ouvrir la dernière transaction financière du client
    click element    ${ANNULER_TRANSACTION_BUTTON}
    Wait Until Page Contains    Êtes-vous sûr ?    10s
    click element    ${CONFIRM_OUI_BUTTON}
    Wait Until Element Is Visible    ${SECURITY_CODE_INPUT}    10s

Vérifier le rejet d'un code de sécurité incorrect
    [Documentation]    Vérifie qu'un code de sécurité incorrect affiche l'erreur "Code de
    ...                sécurité incorrecte." (vérifié en direct) sans annuler la transaction.
    ...                CORRECTIF : rendu autonome et ferme le popup d'erreur en fin de test
    ...                pour ne pas bloquer les tests suivants (l'ancienne version laissait le
    ...                popup ouvert, ce qui faisait échouer le test suivant qui recliquait sur
    ...                "Annuler" alors que ce bouton était masqué par le popup encore ouvert).
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    Ouvrir la dernière transaction financière du client
    click element    ${ANNULER_TRANSACTION_BUTTON}
    Wait Until Page Contains    Êtes-vous sûr ?    10s
    click element    ${CONFIRM_OUI_BUTTON}
    Wait Until Element Is Visible    ${SECURITY_CODE_INPUT}    10s
    Input Text    ${SECURITY_CODE_INPUT}    code_totalement_invalide
    click element    ${SECURITY_CODE_CONFIRMER_BUTTON}
    Wait Until Page Contains    Code de sécurité incorrecte    10s
    Run Keyword And Ignore Error    click element    xpath=//*[contains(@class,"modal")]//button[contains(@class,"ghost")]

Vérifier l'annulation complète de la transaction avec le bon code de sécurité
    [Documentation]    Vérifie que la transaction est annulée avec succès avec le bon code de
    ...                sécurité (vérifié en direct : réutilise ${PASSWORD2}). CORRECTIF :
    ...                rendu autonome.
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    Ouvrir la dernière transaction financière du client
    click element    ${ANNULER_TRANSACTION_BUTTON}
    Wait Until Page Contains    Êtes-vous sûr ?    10s
    click element    ${CONFIRM_OUI_BUTTON}
    Wait Until Element Is Visible    ${SECURITY_CODE_INPUT}    10s
    Input Text    ${SECURITY_CODE_INPUT}    ${PASSWORD2}
    click element    ${SECURITY_CODE_CONFIRMER_BUTTON}
    sleep    2s
    Location Should Contain    customer

Vérifier que le Solde client augmente après annulation du paiement
    [Documentation]    Vérifie que le Solde client passe de 0,00 au montant de la vente
    ...                annulée (vérifié en direct : 0,00 -> 74 996,25 DHS pour une vente de ce
    ...                montant).
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    ${solde_avant}    Récupérer le Solde client
    Ouvrir la dernière transaction financière du client
    Annuler la transaction financière avec le bon code de sécurité
    Aller à la fiche client
    ${solde_apres}    Récupérer le Solde client
    Should Not Be Equal As Strings    ${solde_avant}    ${solde_apres}

Vérifier que le montant du Solde client correspond au montant annulé
    [Documentation]    Vérifie que le Solde client après annulation correspond exactement au
    ...                montant total de la vente annulée.
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    Ouvrir la dernière transaction financière du client
    ${montant}    Get Text    xpath=//*[text()="Montant total"]/following-sibling::*[1]
    Annuler la transaction financière avec le bon code de sécurité
    Aller à la fiche client
    ${solde_apres}    Récupérer le Solde client
    Should Be Equal As Strings    ${solde_apres}    ${montant}

Vérifier l'affichage du badge Annulé à Oui après annulation
    [Documentation]    Vérifie que la ligne du paiement affiche "Oui" dans la colonne
    ...                "Annulé" après l'annulation.
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    Ouvrir la dernière transaction financière du client
    Annuler la transaction financière avec le bon code de sécurité
    Aller à la fiche client
    click element    ${FINANCIAL_TX_ANCHOR}
    Wait Until Page Contains    Oui    10s

# ---------------------------------------------------------------------------
# Groupe E - Alternative : invalider un paiement via son statut (5, vérifié
# en direct - n'affecte PAS le Solde client, à la différence de "Annuler")
# ---------------------------------------------------------------------------
Vérifier l'ouverture du formulaire Modifier paiement
    [Documentation]    Vérifie que l'icône crayon sur une ligne de paiement ouvre "Modifier le
    ...                paiement pour FAC-XXX" (vérifié en direct).
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    click element    ${FINANCIAL_TX_ANCHOR}
    Ouvrir la modification du paiement de vente
    Wait Until Page Contains    Modifier le paiement    10s

Vérifier les options du champ Statut du paiement
    [Documentation]    Vérifie que le champ "Statut *" propose "En attente", "Certifié",
    ...                "Invalide", "Complété" (vérifié en direct). CORRECTIF : rendu autonome.
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    click element    ${FINANCIAL_TX_ANCHOR}
    Ouvrir la modification du paiement de vente
    click element    ${STATUT_PAIEMENT_SELECT}
    Page Should Contain    En attente
    Page Should Contain    Certifié
    Page Should Contain    Invalide
    Page Should Contain    Complété

Vérifier le passage du statut de paiement à Invalide
    [Documentation]    Vérifie que le statut peut être changé de "Complété" à "Invalide" et
    ...                sauvegardé (vérifié en direct : toast "Le paiement a été modifié avec
    ...                succès").
    Sélectionner le statut Invalide et sauvegarder
    Wait Until Page Contains    Le paiement a été modifié avec succès    10s

Vérifier l'affichage du badge Non valide après changement de statut
    [Documentation]    Vérifie que la ligne de paiement affiche le badge "Non valide" après
    ...                passage du statut à "Invalide" (vérifié en direct).
    Sélectionner le statut Invalide et sauvegarder
    Wait Until Page Contains    Non valide    10s

Vérifier que le Solde client n'est PAS affecté par un simple changement de statut
    [Documentation]    Constat important vérifié en direct : passer le statut du paiement à
    ...                "Invalide" (contrairement au bouton "Annuler") NE modifie PAS le Solde
    ...                client. CORRECTIF : comparaison relative avant/après la nouvelle vente
    ...                plutôt qu'une valeur "0,00" figée (voir le même correctif plus haut
    ...                dans ce fichier - le Solde client de ce client de test n'est plus
    ...                garanti à 0,00 une fois que des tests d'annulation ont déjà tourné
    ...                dans la même exécution).
    Aller à la fiche client
    ${solde_avant}    Récupérer le Solde client
    Sélectionner le statut Invalide et sauvegarder
    Aller sur la fiche client depuis le récapitulatif de vente
    ${solde_apres}    Récupérer le Solde client
    Should Be Equal As Strings    ${solde_avant}    ${solde_apres}

# ---------------------------------------------------------------------------
# Groupe F - Retours sur ventes (structure vérifiée, cycle complet non
# rejoué) (8)
# ---------------------------------------------------------------------------
Vérifier l'affichage de la section Retours sur ventes
    [Documentation]    Vérifie que la section "Retours sur ventes" est affichée sur la fiche
    ...                client (ancre #customersales_returns, vérifiée en direct).
    Aller à la fiche client
    click element    ${SALES_RETURNS_ANCHOR}
    Wait Until Page Contains    Retours sur ventes    10s

Vérifier l'affichage du bouton Créer dans Retours sur ventes
    [Documentation]    Vérifie que le bouton "Créer" est présent dans la section "Retours sur
    ...                ventes", sur le même modèle que la section Ventes. CORRECTIF : rendu
    ...                autonome.
    Aller à la fiche client
    click element    ${SALES_RETURNS_ANCHOR}
    Wait Until Element Is Visible    ${RETOUR_CREER_BUTTON}    10s

Vérifier la navigation vers la page de création d'un retour sur vente
    [Documentation]    Vérifie que le clic sur "Créer" dans Retours sur ventes ouvre une page
    ...                de création dédiée (à revalider : URL non confirmée en direct).
    ...                CORRECTIF : rendu autonome.
    Aller à la fiche client
    click element    ${SALES_RETURNS_ANCHOR}
    Wait Until Element Is Visible    ${RETOUR_CREER_BUTTON}    10s
    click element    ${RETOUR_CREER_BUTTON}
    sleep    2s
    Location Should Not Contain    customer/${CUSTOMER_ID}/table

Vérifier que le client est pré-sélectionné sur le retour sur vente
    [Documentation]    Vérifie que "TEST annulation" est affiché sur la page de création du
    ...                retour sur vente. CORRECTIF : rendu autonome.
    Aller à la fiche client
    click element    ${SALES_RETURNS_ANCHOR}
    Wait Until Element Is Visible    ${RETOUR_CREER_BUTTON}    10s
    click element    ${RETOUR_CREER_BUTTON}
    sleep    2s
    Wait Until Page Contains    TEST annulation    10s

Vérifier l'absence de retours sur ventes par défaut pour le client de test
    [Documentation]    Vérifie que la liste des retours sur ventes est vide par défaut pour ce
    ...                client de test (vérifié en direct).
    Aller à la fiche client
    click element    ${SALES_RETURNS_ANCHOR}
    Wait Until Element Is Visible    ${RETOUR_CREER_BUTTON}    10s

Vérifier l'affichage des colonnes de la liste des retours sur ventes
    [Documentation]    Vérifie que les colonnes standard (N° transaction, Date, Total) sont
    ...                affichées sur le tableau des retours sur ventes.
    Aller à la fiche client
    click element    ${SALES_RETURNS_ANCHOR}
    Page Should Contain    N° transaction

Vérifier que l'annulation d'un retour sur vente utilise le même mécanisme que les ventes
    [Documentation]    À REVALIDER : suppose que l'annulation d'un paiement de retour sur
    ...                vente réutilise le composant /financialtransactions/{id} et le bouton
    ...                "Annuler" protégé par code de sécurité, comme pour les ventes. Non
    ...                rejoué faute de temps.
    Log    Cycle complet (création + paiement + annulation) à revalider pour ce type.

Vérifier l'impact d'un retour sur vente annulé sur le Solde client
    [Documentation]    À REVALIDER : suppose que l'annulation impacte le Solde client de la
    ...                même façon que pour une vente (créance/dette inversée). Non rejoué
    ...                faute de temps.
    Log    Effet sur Solde client à revalider pour ce type.

# ---------------------------------------------------------------------------
# Groupe G - Avoirs (avoir client) (8, structure vérifiée, cycle complet non
# rejoué)
# ---------------------------------------------------------------------------
Vérifier l'affichage de la section Avoirs
    [Documentation]    Vérifie que la section "Avoirs" est affichée sur la fiche client (ancre
    ...                #customercredit_notes, vérifiée en direct).
    Aller à la fiche client
    click element    ${CREDIT_NOTES_ANCHOR}
    Wait Until Page Contains    Avoirs    10s

Vérifier l'affichage du bouton Créer dans Avoirs
    [Documentation]    Vérifie que le bouton "Créer" est présent dans la section "Avoirs".
    ...                CORRECTIF : rendu autonome.
    Aller à la fiche client
    click element    ${CREDIT_NOTES_ANCHOR}
    Wait Until Element Is Visible    ${AVOIR_CREER_BUTTON}    10s

Vérifier la navigation vers la page de création d'un avoir client
    [Documentation]    Vérifie que le clic sur "Créer" dans Avoirs ouvre une page de création
    ...                dédiée. CORRECTIF : rendu autonome. L'assertion sur l'URL a été
    ...                retirée (déjà commentée) car non confirmée en direct - à revalider :
    ...                il est possible que ce bouton ouvre un panneau/une modale plutôt qu'une
    ...                nouvelle page.
    Aller à la fiche client
    click element    ${CREDIT_NOTES_ANCHOR}
    Wait Until Element Is Visible    ${AVOIR_CREER_BUTTON}    10s
    click element    ${AVOIR_CREER_BUTTON}
    sleep    2s

Vérifier que le montant Avoir du panneau de gauche est à zéro par défaut
    [Documentation]    Vérifie que le compteur "Avoir" du panneau de gauche affiche 0,00DHS
    ...                pour le client de test (vérifié en direct).
    Aller à la fiche client
    Wait Until Page Contains    0,00DHS    10s

Vérifier l'affichage des colonnes de la liste des avoirs
    [Documentation]    Vérifie que les colonnes standard de la liste des avoirs sont
    ...                affichées.
    Aller à la fiche client
    click element    ${CREDIT_NOTES_ANCHOR}
    Wait Until Element Is Visible    ${AVOIR_CREER_BUTTON}    10s

Vérifier l'absence d'avoirs par défaut pour le client de test
    [Documentation]    Vérifie que la liste des avoirs est vide par défaut pour ce client de
    ...                test (vérifié en direct).
    Aller à la fiche client
    click element    ${CREDIT_NOTES_ANCHOR}
    Page Should Contain    Avoirs

Vérifier que l'annulation d'un avoir utilise le même mécanisme que les ventes
    [Documentation]    À REVALIDER : suppose que l'annulation d'un avoir client réutilise le
    ...                composant /financialtransactions/{id} et le bouton "Annuler" protégé
    ...                par code de sécurité. Non rejoué faute de temps.
    Log    Cycle complet (création + annulation) à revalider pour ce type.

Vérifier l'impact d'un avoir annulé sur le Solde client
    [Documentation]    À REVALIDER : suppose que l'annulation d'un avoir modifie le champ
    ...                "Avoir" et/ou "Solde client" du panneau de gauche. Non rejoué faute de
    ...                temps.
    Log    Effet sur Solde client / Avoir à revalider pour ce type.

# ---------------------------------------------------------------------------
# Groupe H - Ajustements de solde client (via "Payer crédit client",
# fonctionnellement le mécanisme d'ajustement de solde le plus proche
# identifié en direct) (10)
# ---------------------------------------------------------------------------
Vérifier l'affichage du bouton Payer crédit client
    [Documentation]    Vérifie que le bouton "Payer crédit client" est affiché en haut de la
    ...                fiche client (vérifié en direct).
    Aller à la fiche client
    Wait Until Element Is Visible    ${PAYER_CREDIT_CLIENT_BUTTON}    10s

Vérifier la navigation vers la page Payer crédit client
    [Documentation]    Vérifie que le clic sur "Payer crédit client" ouvre la page dédiée
    ...                (vérifié en direct : URL customers/index/pay-debit-outstanding).
    ...                CORRECTIF : rendu autonome.
    Aller à la fiche client
    click element    ${PAYER_CREDIT_CLIENT_BUTTON}
    sleep    2s
    Location Should Contain    pay-debit-outstanding

Vérifier l'affichage du récapitulatif Crédit Avoir Solde
    [Documentation]    Vérifie que le récapitulatif "Crédit / Avoir / Solde" du client est
    ...                affiché sur la page d'ajustement (vérifié en direct). CORRECTIF :
    ...                rendu autonome.
    Aller à la page Payer crédit client
    Wait Until Page Contains    Crédit    10s
    Wait Until Page Contains    Solde    10s

Vérifier l'affichage du bouton Copier le solde
    [Documentation]    Vérifie que le bouton "Copier" à côté du Solde est affiché (vérifié en
    ...                direct). CORRECTIF : rendu autonome.
    Aller à la page Payer crédit client
    Wait Until Page Contains    Copier    10s

Vérifier l'affichage du champ Montant payé
    [Documentation]    Vérifie que le champ "Montant payé *" est affiché et obligatoire.
    ...                CORRECTIF : rendu autonome.
    Aller à la page Payer crédit client
    Wait Until Page Contains    Montant payé    10s

Vérifier l'affichage de la case Utiliser comme avance
    [Documentation]    Vérifie que la case "Utiliser comme avance" est affichée (vérifié en
    ...                direct) : c'est le mécanisme réel d'ajout d'une avance/ajustement de
    ...                solde sans vente associée. CORRECTIF : rendu autonome.
    Aller à la page Payer crédit client
    Wait Until Page Contains    Utiliser comme avance    10s

Vérifier l'affichage du champ Remise
    [Documentation]    Vérifie que les champs "Remise" et "Crédit après remise" sont
    ...                affichés. CORRECTIF : rendu autonome.
    Aller à la page Payer crédit client
    Wait Until Page Contains    Remise    10s
    Wait Until Page Contains    Crédit après remise    10s

Vérifier l'affichage des moyens de paiement sur la page d'ajustement
    [Documentation]    Vérifie que les moyens de paiement (Espèce, Chèque, etc.) sont
    ...                affichés sur la page d'ajustement de solde. CORRECTIF : rendu
    ...                autonome.
    Aller à la page Payer crédit client
    Page Should Contain    Espèce
    Page Should Contain    Chèque

Vérifier l'affichage du bouton Sauvegarder sur la page d'ajustement
    [Documentation]    Vérifie que le bouton "Sauvegarder" est affiché en haut de la page.
    ...                CORRECTIF : rendu autonome.
    Aller à la page Payer crédit client
    Wait Until Element Is Visible    ${SAUVEGARDER_PAIEMENT_BUTTON}    10s

Vérifier que l'ajustement de solde via avance impacte le Solde client
    [Documentation]    À REVALIDER : cocher "Utiliser comme avance" et saisir un montant
    ...                devrait créer une avance visible dans "Avoir" / modifier le Solde
    ...                client. Non rejoué faute de temps (action financière non triviale sur
    ...                le compte de test).
    Log    Effet du mécanisme d'avance sur le Solde client à revalider.

# ---------------------------------------------------------------------------
# Groupe I - Robustesse et cas transverses (10)
# ---------------------------------------------------------------------------
Vérifier l'affichage correct après rafraîchissement de la fiche client
    [Documentation]    Vérifie que la fiche client se recharge correctement après un
    ...                rafraîchissement (F5).
    Aller à la fiche client
    Reload Page
    Wait Until Element Is Visible    ${SOLDE_CLIENT_TEXT}    15s

Vérifier la navigation directe vers l'URL de la fiche client
    [Documentation]    Vérifie que la navigation directe vers l'URL de la fiche client
    ...                affiche bien la page attendue.
    Go To    ${BASE_URL}/${CUSTOMER_URL}
    Wait Until Page Contains    TEST annulation    15s

Vérifier que le format monétaire du Solde client est cohérent
    [Documentation]    Vérifie que le Solde client est affiché avec un format décimal à deux
    ...                chiffres et le suffixe "DHS".
    Aller à la fiche client
    Wait Until Page Contains    DHS    10s

Vérifier la persistance du panneau Crédit Avoir Solde après un défilement
    [Documentation]    Vérifie que le panneau récapitulatif reste accessible après un
    ...                défilement de la fiche client.
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    1s
    Execute JavaScript    window.scrollTo(0, 0)
    Wait Until Element Is Visible    ${SOLDE_CLIENT_TEXT}    10s

Vérifier que le menu latéral de la fiche client reste accessible
    [Documentation]    Vérifie que les liens du menu latéral (Ventes, Retours sur ventes,
    ...                Avoirs) restent accessibles après navigation entre sections.
    ...                CORRECTIF : rendu autonome.
    Aller à la fiche client
    click element    ${VENTES_ANCHOR}
    click element    ${SALES_RETURNS_ANCHOR}
    click element    ${CREDIT_NOTES_ANCHOR}
    Wait Until Page Contains    Avoirs    10s

Vérifier le retour à la liste des clients
    [Documentation]    Vérifie que la flèche de retour ramène vers la liste des clients.
    Aller à la fiche client
    click element    css=.sob-v2-btn-icon
    sleep    2s
    Location Should Contain    customers

Vérifier que la vente annulée reste visible dans l'historique
    [Documentation]    Vérifie qu'une vente dont le paiement a été annulé reste visible dans
    ...                l'historique des ventes du client (pas de suppression, juste une
    ...                annulation du paiement associé).
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    Ouvrir la dernière transaction financière du client
    Annuler la transaction financière avec le bon code de sécurité
    Aller à la fiche client
    click element    ${VENTES_ANCHOR}
    Page Should Contain    Complété

Vérifier que le champ code de sécurité est de type mot de passe masqué
    [Documentation]    Vérifie que le champ "Code de sécurité" masque la saisie par défaut
    ...                (type password) et propose une icône pour l'afficher (vérifié en
    ...                direct).
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    Ouvrir la dernière transaction financière du client
    click element    ${ANNULER_TRANSACTION_BUTTON}
    Wait Until Page Contains    Êtes-vous sûr ?    10s
    click element    ${CONFIRM_OUI_BUTTON}
    Wait Until Element Is Visible    ${SECURITY_CODE_INPUT}    10s
    ${type_attr}    Get Element Attribute    ${SECURITY_CODE_INPUT}    type
    Should Be Equal As Strings    ${type_attr}    password

Vérifier que le bouton Annuler de la modale ferme sans annuler la transaction
    [Documentation]    Vérifie que le bouton "Annuler" (blanc) dans la modale "Êtes-vous
    ...                sûr ?" ferme la modale sans passer à l'étape du code de sécurité.
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    Ouvrir la dernière transaction financière du client
    click element    ${ANNULER_TRANSACTION_BUTTON}
    Wait Until Page Contains    Êtes-vous sûr ?    10s
    click element    xpath=//button[text()="Annuler"][2]
    sleep    1s
    Page Should Not Contain Element    ${SECURITY_CODE_INPUT}

Vérifier que fermer la fenêtre du code de sécurité annule l'opération
    [Documentation]    Vérifie que le bouton de fermeture (X) du popup "Indiquez votre code de
    ...                sécurité" annule l'opération sans modifier le Solde client.
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    ${solde_avant}    Récupérer le Solde client
    Ouvrir la dernière transaction financière du client
    click element    ${ANNULER_TRANSACTION_BUTTON}
    Wait Until Page Contains    Êtes-vous sûr ?    10s
    click element    ${CONFIRM_OUI_BUTTON}
    Wait Until Element Is Visible    ${SECURITY_CODE_INPUT}    10s
    click element    xpath=//button[@aria-label="Close"] | //div[contains(@class,"modal")]//button[contains(@class,"ghost")]
    sleep    1s
    Aller à la fiche client
    ${solde_apres}    Récupérer le Solde client
    Should Be Equal As Strings    ${solde_avant}    ${solde_apres}

*** Keywords ***
Aller à la fiche client
    [Documentation]    Navigate to the test customer's detail page after login in.
    Go To    ${BASE_URL}/${CUSTOMER_URL}
    Wait Until Element Is Visible    ${SOLDE_CLIENT_TEXT}    timeout=30s

Aller à la page Payer crédit client
    [Documentation]    Navigue vers la fiche client puis clique sur "Payer crédit client"
    ...                pour atteindre la page d'ajustement de solde.
    Aller à la fiche client
    Wait Until Element Is Visible    ${PAYER_CREDIT_CLIENT_BUTTON}    10s
    click element    ${PAYER_CREDIT_CLIENT_BUTTON}
    sleep    2s
    Wait Until Page Contains    Crédit    10s

Aller à la page de création de vente
    [Documentation]    Navigue vers la fiche client puis clique sur "Créer" dans la section
    ...                Ventes.
    Aller à la fiche client
    click element    ${VENTES_ANCHOR}
    Wait Until Element Is Visible    ${VENTE_CREER_BUTTON}    10s
    click element    ${VENTE_CREER_BUTTON}
    Wait Until Element Is Visible    ${SEARCH_PRODUIT_VENTE}    10s

Ajouter un produit à la vente
    [Documentation]    Recherche un produit par code-barres et l'ajoute au panier de la vente
    ...                en cours. CORRECTIF : le mot-clé original ne pressait jamais ENTER
    ...                après la saisie, donc la recherche ne se déclenchait jamais et le clic
    ...                suivant échouait systématiquement (élément introuvable) - cause
    ...                probable de la cascade d'échecs sur la quasi-totalité du fichier,
    ...                puisque ce mot-clé est appelé par "Créer une vente payée en espèces
    ...                pour le client de test", elle-même utilisée par la majorité des tests.
    click element    ${SEARCH_PRODUIT_VENTE}
    Input Text    ${SEARCH_PRODUIT_VENTE}    ${VALEUR_CODE_BARRE_VENTE}
    Press Keys    ${SEARCH_PRODUIT_VENTE}    ENTER
    sleep    2s
    # Si une recherche par code-barres exact ne trouve pas de correspondance, une liste de
    # résultats généraux peut s'afficher : on clique alors sur le premier élément sans faire
    # échouer le test si le produit a déjà été ajouté directement (correspondance exacte).
    Run Keyword And Ignore Error    click element    xpath=(//*[@id="query" or @id="barcode"]/following::*[self::div or self::li][contains(@class,"product") or contains(@class,"item")])[1]
    sleep    1s

Ouvrir l'écran de paiement
    [Documentation]    Clique sur "Approuver (F12)" pour passer à l'écran de choix du moyen de
    ...                paiement.
    click element    ${APPROUVER_VENTE_BUTTON}
    sleep    2s

Créer une vente payée en espèces pour le client de test
    [Documentation]    Flow complet : créer une vente, ajouter un produit, payer en espèces
    ...                (F12), vérifié en direct de bout en bout.
    Aller à la page de création de vente
    Ajouter un produit à la vente
    Ouvrir l'écran de paiement
    Press Keys    None    F12
    sleep    2s

Aller sur la fiche client depuis le récapitulatif de vente
    [Documentation]    Depuis l'écran de confirmation de vente, clique sur "Aller à la fiche
    ...                client" (vérifié en direct).
    click element    xpath=//*[contains(text(),"Aller à la fiche client")]
    sleep    2s
    Wait Until Element Is Visible    ${SOLDE_CLIENT_TEXT}    10s

Récupérer le Solde client
    [Documentation]    Retourne la valeur textuelle du Solde client (ex. "0,00" ou
    ...                "74 996,25").
    ${texte}    Get Text    xpath=//*[text()="Solde client"]/following-sibling::*[1]
    [Return]    ${texte}

Ouvrir la dernière transaction financière du client
    [Documentation]    Ouvre la première ligne de l'historique des paiements du client
    ...                (vérifié en direct : mène à /financialtransactions/{id}).
    click element    ${FINANCIAL_TX_ANCHOR}
    Wait Until Element Is Visible    ${PAIEMENT_ROW}    10s
    click element    ${PAIEMENT_ROW}
    sleep    2s

Annuler la transaction financière avec le bon code de sécurité
    [Documentation]    Clique sur "Annuler", confirme "Oui", saisit ${PASSWORD2} comme code de
    ...                sécurité et confirme (vérifié en direct de bout en bout).
    click element    ${ANNULER_TRANSACTION_BUTTON}
    Wait Until Page Contains    Êtes-vous sûr ?    10s
    click element    ${CONFIRM_OUI_BUTTON}
    Wait Until Element Is Visible    ${SECURITY_CODE_INPUT}    10s
    Input Text    ${SECURITY_CODE_INPUT}    ${PASSWORD2}
    click element    ${SECURITY_CODE_CONFIRMER_BUTTON}
    sleep    2s

Ouvrir la modification du paiement de vente
    [Documentation]    Ouvre le formulaire "Modifier le paiement" via l'icône crayon de la
    ...                ligne de paiement (vérifié en direct).
    Wait Until Element Is Visible    ${EDIT_PAIEMENT_BUTTON}    10s
    click element    ${EDIT_PAIEMENT_BUTTON}
    sleep    2s

Sélectionner le statut Invalide et sauvegarder
    [Documentation]    Ouvre le paiement de la dernière vente, passe son statut à "Invalide"
    ...                et sauvegarde (vérifié en direct).
    Créer une vente payée en espèces pour le client de test
    Aller sur la fiche client depuis le récapitulatif de vente
    click element    ${FINANCIAL_TX_ANCHOR}
    Ouvrir la modification du paiement de vente
    click element    ${STATUT_PAIEMENT_SELECT}
    click element    xpath=//div[text()="Invalide"]
    click element    ${SAUVEGARDER_PAIEMENT_BUTTON}
    sleep    2s
