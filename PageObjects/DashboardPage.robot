*** Settings ***
Documentation    This file consist of DashboardPage related locators and keywords
Library    SeleniumLibrary

*** Variables ***
${dashboardheading-loc}    css:h6.oxd-text
@{expected-navigation-items}    Admin    PIM    Leave    Time    My Info
${loginusername-loc}    xpath://p[@class='oxd-userdropdown-name']
${logout-loc}    css:a[href='/web/index.php/auth/logout']

*** Keywords ***
verify dashboard is displayed in the page
    Element Text Should Be    ${dashboardheading-loc}    Dashboard

verify the navigation menu items are visible
    [Arguments]    @{expected-navigation-items}
    FOR    ${item}    IN    @{expected-navigation-items}
        ${element}=    Set Variable    xpath://a//span[contains(., '${item}')]
        Element Text Should Be    ${element}    ${item}
    END

get the logged in username
    Get Text    ${loginusername-loc}

click on the profile dropdown at the top right
    Click Element    ${loginusername-loc}

verify if the logout button appears
    Element Text Should Be    ${logout-loc}    Logout