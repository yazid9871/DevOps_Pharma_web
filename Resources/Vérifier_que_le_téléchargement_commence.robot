*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
*** Variables ***
${DOWNLOAD_DIR}        C:/Users/M.ELHAJOUJI/downloads/

*** Keywords ***
Vérifier que le téléchargement commence
     sleep     3s
    ${timestamp}=    Evaluate    int(time.time())    time
    # Firefox affiche généralement une notification de téléchargement
    Wait Until Element Is Visible    css=.downloadSubPanel    timeout=3s    error=Aucune notification de téléchargement détectée

Créer Dossier Téléchargement
    #Remove Directory    ${DOWNLOAD_DIR}    recursive=True
    Create Directory    ${DOWNLOAD_DIR}

Configurer Firefox Pour Telechargement
    ${profile}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxProfile()    sys, selenium.webdriver
    Call Method    ${profile}    set_preference    browser.download.folderList    2
    Call Method    ${profile}    set_preference    browser.download.dir    ${DOWNLOAD_DIR}
    Call Method    ${profile}    set_preference    browser.helperApps.neverAsk.saveToDisk    text/csv,application/octet-stream
    Call Method    ${profile}    set_preference    pdfjs.disabled    True
    ${FIREFOX OPTIONS}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys, selenium.webdriver
    Call Method    ${FIREFOX OPTIONS}    set_preference    browser.download.folderList    2
    Call Method    ${FIREFOX OPTIONS}    set_preference    browser.download.dir    ${DOWNLOAD_DIR}
    Call Method    ${FIREFOX OPTIONS}    set_preference    browser.helperApps.neverAsk.saveToDisk    text/csv,application/octet-stream
    Set Suite Variable    ${FIREFOX OPTIONS}