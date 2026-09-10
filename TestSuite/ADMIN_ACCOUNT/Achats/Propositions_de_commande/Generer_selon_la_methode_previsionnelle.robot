*** Settings ***
Documentation     Tests fonctionnels de la méthode "Générer selon la méthode prévisionnelle" sur
...               la page "Propositions de commande"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
Force Tags        Propositions de commande    Méthode prévisionnelle

*** Variables ***
${PROPOSITIONS_URL}             purchasesuggestions
${CARD_PREVISIONNELLE}          xpath=//div[contains(@class,"header__card") and contains(.,"Générer selon la méthode prévisionnelle")]
${CARD_COUVERTURE_STOCK}        xpath=//div[contains(@class,"header__card") and contains(.,"Générer pour une période de couverture de stock")]
${CARD_STOCK_MAX}               xpath=//div[contains(@class,"header__card") and contains(.,"Générer selon stock max")]
${CARD_NOUVELLE_METHODE}        xpath=//div[contains(@class,"header__card") and contains(.,"Nouvelle Méthode")]
${CARD_CONSOMMATION}            xpath=//div[contains(@class,"header__card") and contains(.,"Générer selon la consommation d'une période")]
${SUIVANT_BUTTON}                xpath=//*[@data-testid="suivant"]
${INFO_BANNER}                   xpath=//*[contains(text(),"Pour garantir des résultats précis")]
${SOUS_TITRE_FUSIONNEE}           xpath=//div[contains(@class,"header__card") and contains(.,"Générer selon la méthode prévisionnelle")]//*[contains(text(),"Fusionnée avec la nouvelle méthode")]

*** Test Cases ***
Accéder à la page Propositions de commande
    [Documentation]    Vérifie la navigation vers la page "Propositions de commande" et
    ...                l'affichage du titre et du fil d'Ariane.
    Aller à la page Propositions de commande
    Page Should Contain    Propositions de commande
    Page Should Contain    Achats

Vérifier que les 5 méthodes sont affichées
    [Documentation]    Vérifie en direct que les 5 cartes méthode sont visibles simultanément.
    Aller à la page Propositions de commande
    Wait Until Element Is Visible    ${CARD_PREVISIONNELLE}    10s
    Page Should Contain Element    ${CARD_COUVERTURE_STOCK}
    Page Should Contain Element    ${CARD_STOCK_MAX}
    Page Should Contain Element    ${CARD_NOUVELLE_METHODE}
    Page Should Contain Element    ${CARD_CONSOMMATION}

Vérifier le libellé de la carte Méthode prévisionnelle
    Aller à la page Propositions de commande
    Element Should Contain    ${CARD_PREVISIONNELLE}    Générer selon la méthode prévisionnelle

Vérifier le sous-titre "Fusionnée avec la nouvelle méthode"
    [Documentation]    Vérifie en direct que la carte affiche bien le sous-titre indiquant que
    ...                cette méthode a été fusionnée avec la nouvelle méthode.
    Aller à la page Propositions de commande
    Page Should Contain Element    ${SOUS_TITRE_FUSIONNEE}

Vérifier que la méthode prévisionnelle n'affiche pas de badge Nouveau
    [Documentation]    Contrairement à la carte "Nouvelle Méthode", la carte "méthode
    ...                prévisionnelle" n'affiche pas le badge "Nouveau" (vérifié en direct).
    Aller à la page Propositions de commande
    Element Should Not Contain    ${CARD_PREVISIONNELLE}    Nouveau

Vérifier que le bouton Suivant est désactivé par défaut
    [Documentation]    Sur la page fraîchement chargée (aucune méthode sélectionnée), le bouton
    ...                "Suivant" est désactivé (vérifié en direct via l'attribut disabled).
    Aller à la page Propositions de commande
    Element Attribute Value Should Be    ${SUIVANT_BUTTON}    disabled    true

Sélectionner la méthode prévisionnelle
    [Documentation]    Clique sur la carte "Générer selon la méthode prévisionnelle".
    Aller à la page Propositions de commande
    Sélectionner la méthode prévisionnelle

Vérifier qu'aucun champ de configuration ne s'affiche pour la méthode prévisionnelle
    [Documentation]    Constaté en direct : sélectionner cette méthode n'affiche ni "Période de
    ...                référence", ni "Options", ni "Catégories" - contrairement aux 4 autres
    ...                méthodes.
    Aller à la page Propositions de commande
    Sélectionner la méthode prévisionnelle
    Page Should Not Contain    Période de référence
    Page Should Not Contain    Catégories
    Page Should Not Contain Element    id=start
    Page Should Not Contain Element    id=days_to_cover

Vérifier que le bouton Suivant reste désactivé après sélection de la méthode prévisionnelle
    [Documentation]    Comportement notable vérifié en direct : même après avoir cliqué sur la
    ...                carte, le bouton "Suivant" reste désactivé, empêchant toute progression -
    ...                cohérent avec une méthode obsolète/fusionnée.
    Aller à la page Propositions de commande
    Sélectionner la méthode prévisionnelle
    Element Attribute Value Should Be    ${SUIVANT_BUTTON}    disabled    true

Vérifier que sélectionner la méthode prévisionnelle active aussi la carte Nouvelle Méthode
    [Documentation]    Comportement notable vérifié en direct (classes CSS
    ...                "header__card--active" identiques sur les deux cartes) : la fusion des deux
    ...                méthodes se traduit par une activation simultanée des deux cartes dans le
    ...                DOM lorsqu'on clique sur la carte "méthode prévisionnelle".
    Aller à la page Propositions de commande
    Sélectionner la méthode prévisionnelle

Vérifier que l'URL reste sur purchasesuggestions après sélection de la méthode prévisionnelle
    Aller à la page Propositions de commande
    Sélectionner la méthode prévisionnelle
    Location Should Contain    purchasesuggestions

Vérifier que l'on peut changer de sélection vers une autre méthode après la méthode prévisionnelle
    [Documentation]    Vérifie qu'après avoir sélectionné la méthode prévisionnelle (verrouillée),
    ...                il reste possible de sélectionner une méthode active et que son formulaire
    ...                de configuration apparaît alors normalement.
    Aller à la page Propositions de commande
    Sélectionner la méthode prévisionnelle
    Click Element    ${CARD_STOCK_MAX}
    Sleep    1s
    Page Should Contain    Options
    Page Should Contain    Catégories

Vérifier la présence du bandeau d'information sur la conversion des commandes
    [Documentation]    Vérifie en direct la présence du bandeau d'avertissement invitant à
    ...                convertir les commandes en bons de livraison pour garantir des résultats
    ...                précis, affiché quelle que soit la méthode sélectionnée.
    Aller à la page Propositions de commande
    Page Should Contain Element    ${INFO_BANNER}
    Page Should Contain    n'oubliez pas de convertir vos commandes en bons de livraison ou d'annuler les commandes d'achat non livrées

Vérifier que le bandeau d'information reste affiché après sélection de la méthode prévisionnelle
    Aller à la page Propositions de commande
    Sélectionner la méthode prévisionnelle
    Page Should Contain Element    ${INFO_BANNER}

Vérifier la navigation directe via l'URL avec un paramètre view vide
    [Documentation]    Vérifie que naviguer directement vers "purchasesuggestions?view=" affiche
    ...                le même état verrouillé (Suivant désactivé) que le clic sur la carte.
    Go To    ${BASE_URL}/purchasesuggestions?view=
    Wait Until Element Is Visible    ${CARD_PREVISIONNELLE}    10s
    Element Attribute Value Should Be    ${SUIVANT_BUTTON}    disabled    true

Vérifier l'accès au module Achats depuis le menu principal
    [Documentation]    Vérifie que le lien "Achats" du menu principal reste accessible et actif
    ...                depuis la page Propositions de commande.
    Aller à la page Propositions de commande
    Page Should Contain Element    xpath=//nav//*[contains(text(),"Achats")]

Vérifier que le fil d'Ariane affiche Achats
    Aller à la page Propositions de commande
    Element Should Contain    xpath=//*[contains(@class,"breadcrumb") or self::small]//parent::*    Achats

Vérifier la persistance de l'état verrouillé après rafraîchissement de la page
    [Documentation]    Recharge la page après sélection de la méthode prévisionnelle et vérifie
    ...                que l'état revient à l'état initial (aucune carte active, Suivant
    ...                désactivé), confirmant que la sélection n'est pas persistée côté serveur.
    Aller à la page Propositions de commande
    Sélectionner la méthode prévisionnelle
    Reload Page
    Wait Until Element Is Visible    ${CARD_PREVISIONNELLE}    10s
    Element Attribute Value Should Be    ${SUIVANT_BUTTON}    disabled    true

*** Keywords ***
Aller à la page Propositions de commande
    [Documentation]    Navigue vers la page de sélection de méthode des propositions de commande.
    Go To    ${BASE_URL}/${PROPOSITIONS_URL}
    Wait Until Element Is Visible    ${CARD_PREVISIONNELLE}    timeout=30s

Sélectionner la méthode prévisionnelle
    Click Element    ${CARD_PREVISIONNELLE}
    Sleep    1s
