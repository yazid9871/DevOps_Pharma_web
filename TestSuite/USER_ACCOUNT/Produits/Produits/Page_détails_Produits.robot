*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails Produits"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page détails Produits

*** Variables ***
${PRODUCT_ID}      product/176297/table
${PRODUCT_NAME}    TIFANO SABOT NOIR T42 REF 1616-1

*** Test Cases ***
Vérifier les sections (En-tête et Informations générales)
     Aller à la page détails Produits
     Vérifier la section en-tête du Produit
     Vérifier les informations générales du Produit
Vérifier la section Prix du produit
      Vérifier que la section et le button creer sont visibles   Prix du produit     id=##productsproduct_prices   Ajouter un prix au produit      ${BOUTON_CREER_PRIX_PRODUIT}
     Remplir le formulaire de contact et enregistrer
Vérifier la section Dates de péremption
      Vérifier que la section et le button creer sont visibles    Dates de péremption du produit     id=##productsproduct_expiry_dates   Créer un nouveau contact    ${BOUTON_CREER_DATE_PEREMPTION_PRODUIT}
      Remplir Prix du produit et enregistrer


Vérifier la section Historique des produits
   Vérifier que la section est visible     Historique des produits       id=##productsstock_transactions

Vérifier la section Avoirs fournisseurs reçus
   Vérifier que la section est visible     Avoirs fournisseurs reçus       id=##productspurchases_returns

Vérifier la section Informations de traçabilité
   Vérifier que la section est visible     Informations de traçabilité       id=##productsaudit_info

Vérifier la section Commentaires
   Vérifier que la section est visible     Commentaires       id=##productscomments

Vérifier Le Bouton Suggérer une modification
    [Documentation]    Vérifie la présence et le fonctionnement du bouton Suggérer une modification sur la page Produits
    Vérifier Bouton Suggérer une modification Produit

Vérifier les options du popup Autres actions
     Vérifier l'option Modifier date de péremption
     Vérifier l'option Imprimer étiquette

Vérifier le bouton Désactiver
    [Documentation]    Vérifie la présence du bouton Désactiver sur la page Produits
    Wait Until Element Is Visible    ${BOUTON_DESACTIVER_PRODUIT}    10s

Vérifier le bouton Modifier
    [Documentation]    Vérifie que le bouton Modifier ouvre bien le formulaire de modification du produit
    Vérifier le bouton Modifier du Produit

*** Keywords ***
Aller à la page détails Produits
    [Documentation]    Navigue vers la page de détails du produit après connexion.
    Go To     ${BASE_URL}/${PRODUCT_ID}

Vérifier la section en-tête du Produit
    Wait Until Page Contains    ${PRODUCT_NAME}    timeout=10s

Vérifier les informations générales du Produit
    Page Should Contain     ${PRODUCT_NAME}     10s
    Page Should Contain      1234567999128    10s
    Page Should Contain       Parapharmacie      10s
    Page Should Contain      ACCESSOIRES     10s
    Page Should Contain    180,01
    Page Should Contain    270,00



Vérifier que la section Dates de péremption est visible
     Faire défiler jusqu'à l'élément par texte    Dates de péremption du produit
     click element    id=##productsproduct_expiry_dates
     sleep    3s
     wait until page contains    Dates de péremption du produit
    Wait Until Element Is Visible       ${BOUTON_CREER_DATE_PEREMPTION_PRODUIT}    10s

Vérifier Bouton Suggérer une modification Produit
  Execute JavaScript    window.scrollTo(0, 0)
      sleep    3s
     Wait Until Element Is Visible    ${BOUTON_SUGGERER_MODIFICATION}    timeout=10s
      click element         ${BOUTON_SUGGERER_MODIFICATION}
      wait until page contains    Suggérer une modification     10s
       Go To     ${BASE_URL}/${PRODUCT_ID}
       sleep      1s
    wait until page contains     Informations générales     10s

Vérifier l'option Modifier date de péremption
   wait until element is visible   ${BOUTON_AUTRE_ACTION_PRODUIT}       10s
   click element   ${BOUTON_AUTRE_ACTION_PRODUIT}
   wait until element is visible     xpath=//div[@data-testid="modifier_date_de_péremption"]      10s
   click element    xpath=//div[@data-testid="modifier_date_de_péremption"]
    sleep    1s
    wait until page contains       Ajouter date péremption produit    10s
      Go To     ${BASE_URL}/${PRODUCT_ID}
       sleep      1s
    wait until page contains     Informations générales     10s

Vérifier l'option Imprimer étiquette
   wait until element is visible   ${BOUTON_AUTRE_ACTION_PRODUIT}       10s
   click element   ${BOUTON_AUTRE_ACTION_PRODUIT}
   wait until element is visible     xpath=//div[@data-testid="imprimer_étiquette"]      10s
   click element    xpath=//div[@data-testid="imprimer_étiquette"]
    sleep    1s
      Go To     ${BASE_URL}/${PRODUCT_ID}
       sleep      1s
    wait until page contains     Informations générales     10s

Vérifier le bouton Modifier du Produit
    click element    ${BOUTON_MODIFIER_PRODUIT}
    wait until page contains    Modifier produit : ${PRODUCT_NAME}    10s
    Go To     ${BASE_URL}/${PRODUCT_ID}
    sleep      1s
    wait until page contains     Informations générales     10s

Remplir le formulaire de contact et enregistrer
      input text      id=purchase_price     100
      input text      id=name      mery
     wait until element is visible    xpath=//*[@data-testid="\sauvegarder"]     10s
     click element      xpath=//*[@data-testid="\sauvegarder"]
        wait until page contains    Le prix du produit a été créé avec succès   15s

Remplir Prix du produit et enregistrer
      input text      id=expiry_date      2029-08-18
     wait until element is visible    xpath=//*[@data-testid="\sauvegarder"]     10s
     click element      xpath=//*[@data-testid="\sauvegarder"]
        wait until page contains   La date de péremption a été mise à jour avec succès  15s