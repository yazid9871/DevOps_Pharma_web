*** Settings ***
Resource   ../../Resources/Auth.robot
Library    SeleniumLibrary


*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryeme.e@sobrus.com
${PASSWORD}  qw067012@


*** Keywords ***
Go To confreres Listing Page
    [Documentation]    Navigate to the cpnfreres listing page after login in.
    Go To    ${BASE_URL}/colleagues

*** Test Cases ***
Verify Pagination After Login
     [Tags]   PSV-7
    Open Browser  ${BASE_URL}  Firefox
    Login With Valid Credentials
    Go To ventes Listing Page