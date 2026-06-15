*** Settings ***
Documentation    This is the test case file
Library    SeleniumLibrary
Library    DataDriver    file=../TestData/login_data.csv    encoding=utf_8    dialect=unix
Test Setup    Open the browser and go to OrangeHRM
Test Teardown    Closing the Browser Session
Resource    ../Resources/CommonKeywords.robot
Resource    ../PageObjects/LoginPage.robot
Test Template    Verification of User Login

*** Test Cases ***
Login with the ${username} and ${password}

*** Keywords ***
Verification of User Login
    [Arguments]    ${username}    ${password}
    CommonKeywords.wait until element is visible in the page    ${username-loc}

    IF    '${username}' != '${EMPTY}'
        LoginPage.Enter Username    ${username}
    END

    IF    '${password}' != '${EMPTY}'
        LoginPage.Enter Password    ${password}
    END

    IF    '${username}' != '${EMPTY}'
        LoginPage.Click Login Button
        CommonKeywords.wait until element is visible in the page    ${errormessage-loc}
    ELSE
        LoginPage.Click Login Button
    END

    IF    '${username}' == '${EMPTY}'
        LoginPage.verify the 'Required' field validation messages appear
    ELSE
        LoginPage.Verify Error
    END

