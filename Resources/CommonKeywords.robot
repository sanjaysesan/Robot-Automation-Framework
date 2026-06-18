*** Settings ***
Documentation    This file consists of CommonKeywords
Library    SeleniumLibrary
Resource   GlobalVariables.robot
Resource   ../PageObjects/LoginPage.robot


*** Keywords ***
Open the browser and go to OrangeHRM
   Create WebDriver    ${browser}
   Maximize Browser Window
   Set Selenium Speed    0.5 seconds
   Go To           ${url}

Closing the Browser Session
   Close Browser

wait until element is visible in the page
    [Arguments]        ${locator}
    Wait Until Element is Visible            ${locator}        timeout=25s

Open the OrangeHRM application and login with valid credentials
    Create Webdriver    ${browser}
    Maximize Browser Window
    Set Selenium Speed    0.5 seconds
    Go To    ${url}
    Wait Until Element Is Visible    ${username-loc}
    Input Text                ${username-loc}            ${validusername}
    Input Password            ${password-loc}            ${validpwd}
    Click Button            ${submitbtn-loc}

Verify the URL contains text
    [Arguments]    ${expectedurl}
    ${currenturl}=    Get Location
    Should Contain    ${currenturl}    ${expectedurl}

Click the button
    [Arguments]    ${locator}
    Click Element       ${locator}

logging the element
    [Arguments]    ${element}
    Log    ${element}
