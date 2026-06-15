*** Settings ***
Documentation    This is the test case file
Library        SeleniumLibrary
Test Setup    Open the browser and go to OrangeHRM
Test Teardown    Closing the Browser Session
Resource        ../Resources/CommonKeywords.robot
Resource        ../Resources/GlobalVariables.robot
Resource        ../PageObjects/LoginPage.robot

*** Test Cases ***
Verification of Login Page Title
    CommonKeywords.wait until element is visible in the page    ${username-loc}
    LoginPage.verify the login page title or logo is visible

Verification of Login with Valid credentials
    CommonKeywords.wait until element is visible in the page    ${username-loc}
    LoginPage.Enter Username            ${validusername}
    LoginPage.Enter Password            ${validpwd}
    LoginPage.Click Login Button
    CommonKeywords.wait until element is visible in the page    ${dashboard-loc}
    LoginPage.verify if dashboard page is visible

Verification of Login with Invalid username
    CommonKeywords.wait until element is visible in the page    ${username-loc}
    LoginPage.Enter Username            ${Invalidusername}
    LoginPage.Enter Password            ${validpwd}
    LoginPage.Click Login Button
    CommonKeywords.wait until element is visible in the page    ${errormessage-loc}
    LoginPage.verify if error message appears

Verification of Login with an Invalid Password (correct username, wrong password)
    CommonKeywords.wait until element is visible in the page    ${username-loc}
    LoginPage.Enter Username            ${validusername}
    LoginPage.Enter Password            ${Invalidpwd}
    LoginPage.Click Login Button
    CommonKeywords.wait until element is visible in the page    ${errormessage-loc}
    LoginPage.verify if error message appears


Verification of Login with both Invalid Username and Invalid Password
    CommonKeywords.wait until element is visible in the page    ${username-loc}
    LoginPage.Enter Username            ${Invalidusername}
    LoginPage.Enter Password            ${Invalidpwd}
    LoginPage.Click Login Button
    CommonKeywords.wait until element is visible in the page    ${errormessage-loc}
    LoginPage.verify if error message appears

Verification of Login with empty fields (click Login without typing)
    CommonKeywords.wait until element is visible in the page    ${username-loc}
    LoginPage.Click Login Button
    LoginPage.verify the 'Required' field validation messages appear


Verification of Clicking the 'Forgot your password?' link
     CommonKeywords.wait until element is visible in the page    ${username-loc}
     LoginPage.click on the forget password
     CommonKeywords.wait until element is visible in the page    ${resetpwdpage-loc}
     LoginPage.verify if reset password page appears