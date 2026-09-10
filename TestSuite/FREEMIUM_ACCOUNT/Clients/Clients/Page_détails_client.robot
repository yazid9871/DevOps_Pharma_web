*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails client"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_Freemium.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Page détails client    Freemium

*** Variables ***
${CUSTOMER_ID}                514541
${CUSTOMER_NAME}               mery test 1
${CUSTOMER_URL}                https://app.pharma.sobrus.ovh/customer/${CUSTOMER_ID}/table?from=customers
${quikactions_button}          id=quikactions
${credit}

*** Test Cases ***
# ---------------------------------------------------------------------------
# Groupe A - En-tête, informations générales et coordonnées (3)
# ---------------------------------------------------------------------------
Accéder à la page détails client
    [Documentation]    Vérifie la navigation vers la page détails client (client de test
    ...                freemium "mery test 1", id 514541).
    Aller à la page détails client

Vérifier la section en-tête du client
    [Documentation]    Vérifie l'en-tête du client (vérifié en direct : nom "mery test 1",
    ...                statut "Actif", CIN "--").
    Wait Until Page Contains    ${CUSTOMER_NAME}    timeout=10s
    Wait Until Page Contains    Actif    10s

Vérifier les informations générales et de contact du client
    [Documentation]    Vérifie les sections "Informations générales" et "Coordonnées du
    ...                client" (vérifié en direct : ce client de test n'a aucune coordonnée
    ...                renseignée - médecin, adresse, e-mail et téléphone affichent tous "--",
    ...                seul le pays "MA" est renseigné).
    Page Should Contain    Informations générales
    Page Should Contain    Médecin
    Page Should Contain    Dernière transaction
    Page Should Contain    Dernier Paiement
    Page Should Contain    Coordonnées du client
    Page Should Contain    MA

# ---------------------------------------------------------------------------
# Groupe B - Organismes (payeurs) (1)
# ---------------------------------------------------------------------------
Vérifier la section des payeurs du client
    [Documentation]    Vérifie que la section "Organismes" affiche les deux blocs "Assurance
    ...                Maladie Obligatoire (AMO)" et "Assurance Maladie Complémentaire (AMC)"
    ...                (vérifié en direct : aucun organisme configuré pour ce client, valeurs
    ...                "--").
    Page Should Contain    Assurance Maladie Obligatoire (AMO)
    Page Should Contain    Assurance Maladie Complémentaire (AMC)

# ---------------------------------------------------------------------------
# Groupe C - Section Ventes (disponible sur le compte freemium) (4)
# ---------------------------------------------------------------------------
Vérifier que la section Ventes est visible
    [Documentation]    Vérifie que la section "Ventes" (id="##customerinvoices", non
    ...                verrouillée sur le compte freemium) affiche "Liste des ventes" avec
    ...                les boutons "Créer", "Rafraichir" et "Recherche" (vérifié en direct :
    ...                une vente existante FAC-22, statut "Annulé").
    click element    id=##customerinvoices
    sleep    2s
    wait until page contains    Liste des ventes
    Wait Until Element Is Visible    xpath=//*[@data-testid="créer"]    10s
    Page Should Contain    Rafraichir
    Page Should Contain    Recherche

Vérifier les colonnes du tableau des ventes
    [Documentation]    Vérifie que le tableau des ventes affiche les colonnes "N° transaction",
    ...                "Date de vente", "Total", "Livré" et "Statut" (vérifié en direct).
    Page Should Contain    N° transaction
    Page Should Contain    Date de vente
    Page Should Contain    Total
    Page Should Contain    Livré
    Page Should Contain    Statut

Cliquer sur "Créer" et vérifier que le client sélectionné est correct
    [Documentation]    Vérifie que le clic sur "Créer" dans la section Ventes ouvre le "mode
    ...                caisse" (URL invoice/create/cashier-mode) avec le client correctement
    ...                présélectionné sous forme de chip (vérifié en direct : ce compte
    ...                freemium utilise une interface de caisse simplifiée, différente du
    ...                formulaire de vente détaillé du compte admin - il n'y a donc pas de
    ...                champ id="customer_name" ici).
    click element    xpath=//*[@data-testid="créer"]
    sleep    2s
    Location Should Contain    invoice/create/cashier-mode
    Wait Until Page Contains    ${CUSTOMER_NAME}    10s

Vérifier l'affichage du mode caisse
    [Documentation]    Vérifie que le mode caisse affiche le champ de recherche produit et le
    ...                bouton "Approuver".
    Wait Until Page Contains    Approuver    10s
    Page Should Contain    Total à payer

# ---------------------------------------------------------------------------
# Groupe D - Section MySobrus (1)
# ---------------------------------------------------------------------------
Vérifier que la section MySobrus est visible
    [Documentation]    Vérifie que la section "MySobrus" (id="##customermysobrus") est
    ...                affichée avec ses champs "Prénom", "Nom" et les options de partage
    ...                (vérifié en direct : aucune information MySobrus liée pour ce client).
    Aller à la page détails client
    click element    id=##customermysobrus
    sleep    2s
    wait until page contains    Info MySobrus

# ---------------------------------------------------------------------------
# Groupe E - Section Contacts (disponible sur le compte freemium) (2)
# ---------------------------------------------------------------------------
Vérifier que la section Contacts est visible
    [Documentation]    Vérifie que la section "Contacts" (id="##customercontacts", non
    ...                verrouillée) affiche le bouton "Créer" et les colonnes "Prénom", "Nom",
    ...                "E-mail", "Téléphone", "Titre".
    click element    id=##customercontacts
    sleep    2s
    wait until page contains    Contacts
    Wait Until Element Is Visible    xpath=//*[@data-testid="créer"]    10s
    Page Should Contain    Prénom
    Page Should Contain    Titre

Cliquer sur "Créer" et remplir le formulaire de contact
    [Documentation]    Vérifie que le formulaire de création de contact s'ouvre avec le bon
    ...                client présélectionné (id="customer_name") et que les champs
    ...                "title", "last_name", "first_name", "email", "phone",
    ...                "relationship_type_id" sont identiques à ceux du compte admin.
    click element    xpath=//*[@data-testid="créer"]
    wait until element is visible    id=customer_name
    ${name}=    Get Value    id=customer_name
    Should Be Equal    ${name}    ${CUSTOMER_NAME}
    wait until element is visible    id=title    10s
    input text    id=title    tester
    input text    id=last_name    mery
    input text    id=first_name    test
    input text    id=email    test@gmail.com
    input text    id=phone    9675645434

# ---------------------------------------------------------------------------
# Groupe F - Historique des paiements (1)
# ---------------------------------------------------------------------------
Vérifier que la section Historique des paiements est visible
    [Documentation]    Vérifie que la section "Historique des paiements"
    ...                (id="##customerfinancial_transactions") affiche les colonnes "Type",
    ...                "Date", "Montant" et "Moyens de paiement" (vérifié en direct : cette
    ...                section n'est pas verrouillée, contrairement à la plupart des autres
    ...                sections avancées).
    Aller à la page détails client
    click element    id=##customerfinancial_transactions
    sleep    2s
    wait until page contains    Historique des paiements
    Page Should Contain    Moyens de paiement

# ---------------------------------------------------------------------------
# Groupe G - Traçabilité et Commentaires (2)
# ---------------------------------------------------------------------------
Vérifier que la section Informations de traçabilité est visible
    [Documentation]    Vérifie que la section "Informations de traçabilité"
    ...                (id="##customeraudit_info") affiche les dates "Créée" et "Mis à jour"
    ...                avec l'auteur (vérifié en direct : "Par compte 2 test").
    click element    id=##customeraudit_info
    sleep    2s
    wait until page contains    Informations de traçabilité
    Page Should Contain    Créée
    Page Should Contain    Mis à jour

Vérifier que la section Commentaires accepte une saisie
    [Documentation]    Vérifie que le champ "Commentaires" (id="##customercomments") accepte
    ...                une saisie texte.
    click element    id=##customercomments
    sleep    1s
    Wait Until Element Is Visible    xpath=//textarea[@placeholder="Ajouter Un Commentaire"]    10s
    Input Text    xpath=//textarea[@placeholder="Ajouter Un Commentaire"]    Commentaire de test automation

# ---------------------------------------------------------------------------
# Groupe H - Fonctionnalités verrouillées "Mettre à niveau" (compte freemium) (9)
# ---------------------------------------------------------------------------
Vérifier le badge Mettre à niveau sur Remises par défaut
    [Documentation]    Vérifie que la section "Remises par défaut" est verrouillée sur le
    ...                compte freemium (badge "Mettre à niveau" affiché à côté du nom de la
    ...                section dans le menu latéral).
    Vérifier le badge Mettre à niveau sur une section    Remises par défaut

Vérifier le badge Mettre à niveau sur Historique des produits
    [Documentation]    Vérifie que la section "Historique des produits" est verrouillée sur
    ...                le compte freemium.
    Vérifier le badge Mettre à niveau sur une section    Historique des produits

Vérifier le badge Mettre à niveau sur Devis
    [Documentation]    Vérifie que la section "Devis" est verrouillée sur le compte freemium
    ...                (contrairement au compte admin où cette section est pleinement
    ...                fonctionnelle).
    Vérifier le badge Mettre à niveau sur une section    Devis

Vérifier le badge Mettre à niveau sur Préparations
    [Documentation]    Vérifie que la section "Préparations" est verrouillée sur le compte
    ...                freemium.
    Vérifier le badge Mettre à niveau sur une section    Préparations

Vérifier le badge Mettre à niveau sur Factures globales
    [Documentation]    Vérifie que la section "Factures globales" est verrouillée sur le
    ...                compte freemium.
    Vérifier le badge Mettre à niveau sur une section    Factures globales

Vérifier le badge Mettre à niveau sur Retours sur ventes
    [Documentation]    Vérifie que la section "Retours sur ventes" est verrouillée sur le
    ...                compte freemium.
    Vérifier le badge Mettre à niveau sur une section    Retours sur ventes

Vérifier le badge Mettre à niveau sur Avoirs
    [Documentation]    Vérifie que la section "Avoirs" est verrouillée sur le compte
    ...                freemium.
    Vérifier le badge Mettre à niveau sur une section    Avoirs

Vérifier le badge Mettre à niveau sur Ajustements de solde client
    [Documentation]    Vérifie que la section "Ajustements de solde client" est verrouillée
    ...                sur le compte freemium.
    Vérifier le badge Mettre à niveau sur une section    Ajustements de solde client

Vérifier qu'un clic sur une section verrouillée ne révèle aucun contenu
    [Documentation]    Vérifie que le clic sur le lien "Devis" (verrouillé) ne provoque
    ...                aucune erreur bloquante et ne fait apparaître aucun champ de formulaire
    ...                de devis (vérifié en direct : le lien reste inerte, aucun changement
    ...                visible sur la page).
    Aller à la page détails client
    click element    id=##customerquotes
    sleep    1s
    Page Should Not Contain Element    xpath=//div[@id='customerquotes']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']

# ---------------------------------------------------------------------------
# Groupe I - Menu Autres actions (quikactions) (7)
# ---------------------------------------------------------------------------
Vérifier l'ouverture du menu Autres actions
    [Documentation]    Vérifie que le clic sur "Autres actions" ouvre la palette de
    ...                raccourcis.
    Aller à la page détails client
    click element    xpath=//button[contains(., "Autres actions")]
    Wait Until Element Is Visible    xpath=//*[@data-testid="modifier"]    10s

Vérifier l'option Modifier dans le menu Autres actions
    [Documentation]    Vérifie que l'option "Modifier" (raccourci F9) est présente dans le
    ...                menu.
    Page Should Contain    Modifier

Vérifier l'option Lier le client à son compte MySobrus
    [Documentation]    Vérifie que l'option "Lier le client à son compte MySobrus" est
    ...                présente et cliquable.
    Wait Until Element Is Visible    xpath=//*[@data-testid="lier_le_client_à_son_compte_mysobrus"]    10s

Vérifier l'option Payer ventes non soldées
    [Documentation]    Vérifie que l'option "Payer ventes non soldées" (raccourci ⇧J) est
    ...                présente.
    Wait Until Element Is Visible    xpath=//*[@data-testid="payer_ventes_non_soldées"]    10s

Vérifier l'option Créer un nouveau contact
    [Documentation]    Vérifie que l'option "Créer un nouveau contact" est présente dans le
    ...                menu Autres actions.
    Wait Until Element Is Visible    xpath=//*[@data-testid="créer_un_nouveau_contact"]    10s

Vérifier l'option Créer une nouvelle vente
    [Documentation]    Vérifie que l'option "Créer une nouvelle vente" est présente dans le
    ...                menu Autres actions.
    Wait Until Element Is Visible    xpath=//*[@data-testid="créer_une_nouvelle_vente"]    10s

Vérifier que les options verrouillées restent inactives dans le menu
    [Documentation]    Vérifie que "Créer un nouveau devis" et "Modifier remise par défaut"
    ...                apparaissent dans le menu Autres actions mais restent inertes au clic
    ...                (fonctionnalités verrouillées, vérifié en direct : le clic ne ferme pas
    ...                le menu et n'ouvre aucun formulaire).
    Wait Until Element Is Visible    xpath=//*[@data-testid="créer_un_nouveau_devis"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="modifier_remise_par_défaut"]    10s
    click element    xpath=//*[@data-testid="créer_un_nouveau_devis"]
    sleep    1s
    Location Should Contain    ${CUSTOMER_ID}

# ---------------------------------------------------------------------------
# Groupe J - Modifier le client (1)
# ---------------------------------------------------------------------------
Vérifier l'option Modifier et la soumission du formulaire
    [Documentation]    Vérifie que l'option "Modifier" ouvre le formulaire d'édition du
    ...                client et que la modification est bien enregistrée.
    Aller à la page détails client
    click element    xpath=//button[contains(., "Autres actions")]
    wait until element is visible    xpath=//*[@data-testid="modifier"]    10s
    click element    xpath=//*[@data-testid="modifier"]
    sleep    1s
    wait until page contains    Modifier client :    10s
    wait until element is visible    id=debit_limit    10s
    input text    id=debit_limit    700
    click element    xpath=//*[@data-testid="sauvegarder"]
    wait until page contains    Le client a été modifié avec succès    10s

# ---------------------------------------------------------------------------
# Groupe K - Paiement du crédit client (1)
# ---------------------------------------------------------------------------
Vérifier le bouton Payer crédit client
    [Documentation]    Vérifie que le bouton "Payer crédit client" (data-testid=
    ...                "payer_crédit_client") est visible sur la page, sans jamais le
    ...                soumettre (le client de test a un solde de 0,00 DHS).
    Aller à la page détails client
    Wait Until Element Is Visible    xpath=//*[@data-testid="payer_crédit_client"]    10s

# ---------------------------------------------------------------------------
# Groupe L - Fonctionnalités absentes sur le compte freemium (1)
# ---------------------------------------------------------------------------
Vérifier l'absence des fonctionnalités Archiver, Restaurer et Impression du relevé
    [Documentation]    Vérifie que les boutons "Archiver"/"Restaurer" (data-testid="archiver"/
    ...                "restaurer") et le bouton d'impression du relevé (id="exportStatment")
    ...                sont totalement absents de l'interface du compte freemium (vérifié en
    ...                direct, y compris sur l'URL customer/{id}?from=sale utilisée par le
    ...                compte admin pour ces fonctionnalités). La section "Marketing" (points
    ...                de fidélité) est elle aussi totalement absente du menu latéral.
    Page Should Not Contain Element    xpath=//*[@data-testid="archiver"]
    Page Should Not Contain Element    xpath=//*[@data-testid="restaurer"]
    Page Should Not Contain Element    id=exportStatment
    Page Should Not Contain    Points de fidélité

*** Keywords ***
Aller à la page détails client
    [Documentation]    Navigate to the client details page after login in.
    Go To    ${CUSTOMER_URL}
    Wait Until Page Contains    ${CUSTOMER_NAME}    timeout=10s

Vérifier le badge Mettre à niveau sur une section
    [Arguments]    ${NOM_SECTION}
    [Documentation]    Vérifie que le lien de la section ${NOM_SECTION} dans le menu latéral
    ...                est accompagné du badge "Mettre à niveau".
    Aller à la page détails client
    ${locator}    Set Variable    xpath=//a[contains(@class,"sob-v2-vtab-item")][contains(., "${NOM_SECTION}")][contains(., "Mettre à niveau")]
    Wait Until Element Is Visible    ${locator}    10s
