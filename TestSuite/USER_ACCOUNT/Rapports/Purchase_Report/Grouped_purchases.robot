
*** Settings ***
Resource   ../../../../../Resources/Auth.robot
Library    SeleniumLibrary

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/01/2026
${DATE_END}       31/12/2026

${TITRE_PAGE}         Achats groupés
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
    [Documentation]    Vérifier affichage du rapport
     Open Browser  ${BASE_URL}  Firefox
      Login With Valid Credentials compt2
    Go To    ${BASE_URL}/reports/groupedpurchases
    wait until page contains    ${TITRE_PAGE}    10s

UC02 Balance par pharmacie

     #choise year warehouse and group
    [Documentation]     choise year warehouse and group    and   Vérifier affichage colonnes
    #year
     wait until element is visible        css=#year
      Click Element    css=#year
      sleep    2s
     click element    css=div.react-datepicker__year-text:nth-child(9)
    #warehouse
      click element    id=warehouse
      wait until element is visible    css=.sob-v2-select-clearable > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)
     click element      css=.sob-v2-select__option:nth-child(1)
   #group
       click element    id=groupId
       input text       id=groupId      meryt
      Press Keys         id=groupId    ENTER
       Press Keys         id=groupId   ENTER
      sleep     2s
    Wait Until Element Is Visible    xpath=//table


    #Vérifier affichage colonnes
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    Page Should Contain    Pharmacie
    Page Should Contain    Solde initial
    Page Should Contain    Total supporté
    Page Should Contain     Total consommé
    Page Should Contain     Différence
    #Solde par pharmacie
   # click element     css=tr.zoom:nth-child(1) > td:nth-child(4)
  #  wait until page contains     Solde par pharmacie 2025


UC03 Achats par fournisseur

    click element    id=tab1
    sleep    2s

      #warehouse
      click element    id=warehouse
      wait until element is visible    css=.sob-v2-select-clearable > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)
     click element      css=.sob-v2-select__option:nth-child(1)
   #group
       click element    id=groupId
       input text       id=groupId      meryt
      Press Keys         id=groupId    ENTER
       Press Keys         id=groupId   ENTER
      sleep     2s
    Wait Until Element Is Visible    xpath=//table

    #Vérifier affichage colonnes
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    Page Should Contain    Fournisseur
    Page Should Contain   Quantités totales
    Page Should Contain    Somme des achats