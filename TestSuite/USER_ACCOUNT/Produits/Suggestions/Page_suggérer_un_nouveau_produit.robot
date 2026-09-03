*** Settings ***
Documentation     Tests fonctionnels de la page " Suggérer produit"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page Suggérer produit

*** Variables ***
${INPUT_NOM}    xpath=//*[@id="name"]
${INPUT_CODE_BARRE}    xpath=//*[@id="barcode"]
${INPUT_PPH}    xpath=//*[@id="purchase_price"]
${INPUT_PPV}    xpath=//*[@id="sale_price"]
${SUBMIT}    xpath=//*[@data-testid="sauvegarder"]
${PRODUCT_NAME}    test suggestion produit automation

*** Test Cases ***
Aller à la page de création d'une nouvelle Suggérer produit
     Accéder à la page    products/suggestions
    Aller à la page de création d'une nouvelle Suggérer produit

Vérifier que la soumission du formulaire réussit avec des données valides
     Vérifier que la soumission du formulaire réussit avec des données valides

Vérifier la redirection vers la page Suggérer produit
    Rediriger vers la page Suggérer produit

*** Keywords ***

Aller à la page de liste des Suggérer produit
    [Documentation]    Navigate to the product suggestions listing page after login in.
    Go To    ${BASE_URL}/products/suggestions
    Wait Until Element Is Visible      xpath=//*[@data-testid="suggérer_un_nouveau_produit"]     timeout=30s

Aller à la page de création d'une nouvelle Suggérer produit
     click element     xpath=//*[@data-testid="suggérer_un_nouveau_produit"]
      Wait Until Element Is Visible     ${INPUT_NOM}    5s
      Définir le zoom du navigateur    70
       sleep    2s

Définir le zoom du navigateur
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"

Vérifier que la soumission du formulaire réussit avec des données valides

 #Informations générales
    # Nom input
    Input Text    ${INPUT_NOM}      ${PRODUCT_NAME}
    #  Code barre  input
    Input Text    ${INPUT_CODE_BARRE}      9988776655
    #  Code barre 2  input
    Input Text    id=barcode_2      1122334455

      # Catégorie   dropdown
      Input Text     id=product_category_id      Parapharmacie
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(1)    5s
    click element    css=.sob-v2-select__option:nth-child(1)
     sleep    2s

      # Classe thérapeutique  dropdown
      Input Text     css=#product_therapeutic_class_id input      ADSORB
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(1)    5s
    click element    css=.sob-v2-select__option:nth-child(1)
     sleep    2s

    Execute JavaScript    window.scrollBy(0, 400);
    sleep    1s

      # Forme galénique  dropdown
      Input Text     css=#product_galenic_form_id input      COMPRIME
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(1)    5s
    click element    css=.sob-v2-select__option:nth-child(1)
     sleep    2s

      # DCI  dropdown
      Input Text     css=#product_dci_id input      ACARB
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(1)    5s
    click element    css=.sob-v2-select__option:nth-child(1)
     sleep    2s

      # Gamme  dropdown
      Input Text     css=#product_line_id input      pharma
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(1)    5s
    click element    css=.sob-v2-select__option:nth-child(1)
     sleep    2s

      # Produit tableau  dropdown
      Input Text     css=#product_schedule input      A
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(2)    5s
    click element    css=.sob-v2-select__option:nth-child(2)
     sleep    2s

      # Nécessite une prescription   checkbox
      click element    id=requires_prescription
      # Produit marché   checkbox
      click element    id=is_market_product

    Execute JavaScript    window.scrollBy(0, 500);
    sleep    1s

    # PPH input
    Input Text    ${INPUT_PPH}      50
    # PPV input
    Input Text    ${INPUT_PPV}      75

      # TVA sur achat  dropdown
      Input Text     css=#purchase_tax_id input      TVA
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(1)    5s
    click element    css=.sob-v2-select__option:nth-child(1)
     sleep    2s

      # TVA sur vente  dropdown
      Input Text     css=#sale_tax_id input      TVA
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(1)    5s
    click element    css=.sob-v2-select__option:nth-child(1)
     sleep    2s

      # Est remboursable  dropdown
      click element     css=#is_refundable input
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(2)    5s
    click element    css=.sob-v2-select__option:nth-child(2)
     sleep    2s

    # Base de remboursement input
    Input Text    id=refund_basis      80

    Execute JavaScript    window.scrollBy(0, 500);
    sleep    1s

    # Présentation input
    Input Text    id=presentation      Boite de 20 comprimés
    # Excipients input
    Input Text    id=excipients      Lactose
    # Posologie pour Adulte input
    Input Text    id=dosage_adult      1 comprimé par jour
    # Posologie pour Enfant input
    Input Text    id=dosage_children      Non recommandé
    # Indications input
    Input Text    id=indications      Douleurs

      # Contre-indication conduite  dropdown
      click element     css=#contraindication_driving input
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(2)    5s
    click element    css=.sob-v2-select__option:nth-child(2)
     sleep    2s

      # Contre-indication allaitement  dropdown
      click element     css=#contraindication_nursing input
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(2)    5s
    click element    css=.sob-v2-select__option:nth-child(2)
     sleep    2s

      # Contre-indication grossesse  dropdown
      click element     css=#contraindication_pregnancy input
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(2)    5s
    click element    css=.sob-v2-select__option:nth-child(2)
     sleep    2s

    Execute JavaScript    window.scrollBy(0, 500);
    sleep    1s

    # Référence Labo du Produit input
    Input Text    id=laboratory_product_ref      REF-TEST-001
    # Conditionnement input
    Input Text    id=packaging      20
    # Monographie input
    Input Text    id=monograph      Monographie de test automation
    # Description input
    Input Text    id=description      This is a test product suggestion created by automation.

     Execute Javascript    window.scrollTo(0, 0);
     sleep    2s

      wait until element is visible     ${SUBMIT}   15s
    click element      ${SUBMIT}

    wait until page contains      Votre produit a été suggéré avec succès.     10s

Rediriger vers la page Suggérer produit
     wait until page contains    Suggestions des produits     10s
     wait until page contains    ${PRODUCT_NAME}     10s
