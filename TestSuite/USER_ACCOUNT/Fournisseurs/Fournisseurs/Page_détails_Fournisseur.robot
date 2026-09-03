*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails Fournisseur"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page détails Fournisseur

*** Variables ***
${SUPPLIER_ID}       supplier/3966/table
${SUPPLIER_NAME}    Fournis_Test

*** Test Cases ***
Vérifier les sections (En-tête et Informations générales)
     Aller à la page détails Fournisseur
     Vérifier la section en-tête du Fournisseur
     Vérifier les informations générales du Fournisseur

Vérifier la section Contacts
      Vérifier que la section et le button creer sont visibles   Contacts     id=##suppliercontacts   Créer un nouveau contact    ${BOUTON_CREER_CONTACT_FOURNISSEUR}
     Remplir le formulaire de contact et enregistrer

Vérifier la section Transactions financières
   Vérifier que la section est visible     Historique des paiements       id=##supplierfinancial_transactions

Vérifier la section Transactions de stock
    Vérifier que la section est visible       Historique des produits       id=##supplierstock_transactions

#Vérifier la section Bons de commande
      #Vérifier que la section et le button creer sont visibles   Bons de commandes     id=##supplierpurchase_orders   Créer un nouveau bon de commande    ${BOUTON_CREER_BC_FOURNISSEUR}
    #vérifier que le fournisseur sélectionné est correct      id=supplier_id     ${SUPPLIER_NAME}    ${SUPPLIER_ID}
  #  Ajouter un produit et soumettre       ${SUPPLIER_ID}
Vérifier la section Bons de livraison
      Vérifier que la section et le button creer sont visibles     Bons de livraison     id=##supplierdelivery_notes     Créer un nouveau bon de livraison    ${BOUTON_CREER_BL_FOURNISSEUR}
    vérifier que le fournisseur sélectionné est correct      id=supplier_id     ${SUPPLIER_NAME}    ${SUPPLIER_ID}
    Ajouter des produits et soumettre       ${SUPPLIER_ID}       Créer un nouveau bon de livraison

Vérifier la section Avoirs fournisseurs émis
      Vérifier que la section et le button creer sont visibles    Avoirs fournisseurs émis     id=##supplierissued_purchases_returns     Créer un nouvel avoir fournisseur émis   ${BOUTON_CREER_VOIR_EMIE_FOURNISSEUR}
    vérifier que le fournisseur sélectionné est correct      id=supplier_id     ${SUPPLIER_NAME}    ${SUPPLIER_ID}
    Ajouter des produits et soumettre       ${SUPPLIER_ID}       L’avoir fournisseur émis a été enregistré avec succès!


Vérifier la section Avoirs fournisseurs reçus
      Vérifier que la section et le button creer sont visibles    Avoirs fournisseurs reçus     id=##supplierpurchases_returns    Sélectionner une option    ${BOUTON_CREER_VOIR_RECUE_FOURNISSEUR}
    vérifier que le fournisseur sélectionné est correct      id=supplier_id     ${SUPPLIER_NAME}    ${SUPPLIER_ID}
   # Ajouter des produits et soumettre       ${SUPPLIER_ID}       L’avoir fournisseur émis a été enregistré avec succès!
     Aller à la page détails Fournisseur

Vérifier la section Emails
   Vérifier que la section est visible     Emails     id=##supplieremails
érifier la section Informations de traçabilité
   Vérifier que la section est visible     Informations de traçabilité     id=##supplieraudit_info

érifier la section Commentaires
   Vérifier que la section est visible     Commentaires     id=##suppliercomments

Vérifier Le Bouton Suggérer une modification
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    Vérifier Bouton Suggérer une modification

Vérifier les options du popup Autres actions
     Vérifier l'option Créer un nouveau contact
     Vérifier l'option Créer un nouveau bon de commande
     Vérifier l'option Créer un nouveau bon de livraison
     Vérifier l'option Créer un nouvel avoir fournisseur émis
     Vérifier l'option Avoirs fournisseurs reçus

Vérifier le bouton Payer les bons de livraison impayés
    Vérifier le bouton Payer les bons de livraison impayés

*** Keywords ***
Aller à la page détails Fournisseur
    [Documentation]    Navigue vers la page de détails du fournisseur après connexion.
    Go To     ${BASE_URL}/${SUPPLIER_ID}

Vérifier la section en-tête du Fournisseur
    Wait Until Page Contains    ${SUPPLIER_NAME}    timeout=10s

Vérifier les informations générales du Fournisseur
    # General information
    Page Should Contain     Fournis_Test     10s
    Page Should Contain      FournisTest@gmail.com    110s
    Page Should Contain       https://app.pharma.sobrus.ovh/      10s
    Page Should Contain      123456     1os

    # Adresse
    Page Should Contain    fes
    Page Should Contain    fes
    Page Should Contain   1234

    # Informations descriptives
        Page Should Contain   fes test



Remplir le formulaire de contact et enregistrer
      wait until element is visible    id=title     10s
      input text      id=title     tester
      input text      id=last_name      mery
      input text      id=first_name     test
      input text      id=email      test@gmail.com
      input text      id=phone     9675645434

     Execute JavaScript  window.scrollTo(0,  0)
     sleep    2s
     wait until element is visible    xpath=//*[@data-testid="\sauvegarder"]     10s
     click element      xpath=//*[@data-testid="\sauvegarder"]
        wait until page contains    Le contact a été créé avec succès     15s

Vérifier Bouton Suggérer une modification
  Execute JavaScript    window.scrollTo(0, 0)
      sleep    2s
     Wait Until Element Is Visible    ${BOUTON_SUGGERER_MODIFICATION}    timeout=10s
      click element         ${BOUTON_SUGGERER_MODIFICATION}
      wait until page contains    Suggérer un fournisseur     10s
       Go To     ${BASE_URL}/${SUPPLIER_ID}
       sleep      1s
    wait until page contains     Informations générales     10s

Vérifier l'option Créer un nouveau contact
   wait until element is visible   ${BOUTON_AUTRE_ACTION}       10s
   click element   ${BOUTON_AUTRE_ACTION}
   wait until element is visible     xpath=//div[@data-testid="créer_un_nouveau_contact"]      10s
   click element    xpath=//div[@data-testid="créer_un_nouveau_contact"]
    sleep    1s
    wait until page contains       Créer un nouveau contact    10s
      Go To     ${BASE_URL}/${SUPPLIER_ID}
       sleep      1s
    wait until page contains     Informations générales     10s

Vérifier l'option Créer un nouveau bon de commande
   wait until element is visible   ${BOUTON_AUTRE_ACTION}       10s
   click element   ${BOUTON_AUTRE_ACTION}
   wait until element is visible     xpath=//div[@data-testid="créer_un_nouveau_bon_de_commande"]      10s
   click element    xpath=//div[@data-testid="créer_un_nouveau_bon_de_commande"]
    sleep    1s
    wait until page contains       Créer un nouveau bon de commande    10s
      Go To     ${BASE_URL}/${SUPPLIER_ID}
       sleep      1s
    wait until page contains     Informations générales     10s


Vérifier l'option Créer un nouveau bon de livraison
   wait until element is visible   ${BOUTON_AUTRE_ACTION}       10s
   click element   ${BOUTON_AUTRE_ACTION}
   wait until element is visible     xpath=//div[@data-testid="créer_un_nouveau_bon_de_livraison"]      10s
   click element    xpath=//div[@data-testid="créer_un_nouveau_bon_de_livraison"]
    sleep    1s
    wait until page contains      Créer un nouveau bon de livraison    10s
      Go To     ${BASE_URL}/${SUPPLIER_ID}
       sleep      1s
    wait until page contains     Informations générales     10s

Vérifier l'option Créer un nouvel avoir fournisseur émis
   wait until element is visible   ${BOUTON_AUTRE_ACTION}       10s
   click element   ${BOUTON_AUTRE_ACTION}
   wait until element is visible     xpath=//div[@data-testid="créer_un_nouvel_avoir_fournisseur_émis"]      10s
   click element    xpath=//div[@data-testid="créer_un_nouvel_avoir_fournisseur_émis"]
    sleep    1s
    wait until page contains      Créer un nouvel avoir fournisseur émis    10s
      Go To     ${BASE_URL}/${SUPPLIER_ID}
       sleep      1s
    wait until page contains     Informations générales     10s


Vérifier l'option Avoirs fournisseurs reçus
   wait until element is visible   ${BOUTON_AUTRE_ACTION}       10s
   click element   ${BOUTON_AUTRE_ACTION}
   wait until element is visible     xpath=//div[@data-testid="créer_un_nouvel_avoir_fournisseur_reçu"]      10s
   click element    xpath=//div[@data-testid="créer_un_nouvel_avoir_fournisseur_reçu"]
    sleep    1s
    wait until page contains      Sélectionner une option   10s
      Go To     ${BASE_URL}/${SUPPLIER_ID}
       sleep      1s
    wait until page contains     Informations générales     10s


Vérifier le bouton Payer les bons de livraison impayés
       Wait Until Element Is Visible    ${BOUTON_PAYER_BL_IMPAYEE}    timeout=10s
      click element         ${BOUTON_PAYER_BL_IMPAYEE}
      wait until page contains     Payer les bons de livraison impayés    10s
      wait until element is visible      xpath=//*[@data-testid="suivant"]     10s
       click element        xpath=//*[@data-testid="suivant"]
       wait until page contains      Payer plusieurs bons de livraison    10s
       Go To     ${BASE_URL}/${SUPPLIER_ID}
       sleep      1s
    wait until page contains     Informations générales     10s