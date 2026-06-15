*** Settings ***
Documentation       This is the Test Case File
Library     SeleniumLibrary
Test Setup      Open the OrangeHRM application and login with valid credentials
Test Teardown       Closing the Browser Session
Resource    ../Resources/CommonKeywords.robot
Resource    ../PageObjects/AdminPage.robot

*** Test Cases ***
Verification of Column Header
    AdminPage.navigate to Admin Tab
    AdminPage.get all column header texts from users table
    AdminPage.get the total users
    CommonKeywords.logging the element    ${usercount}
    AdminPage.iterate through every row and read username
    CommonKeywords.logging the element    ${usernames}
    AdminPage.find the 'Admin' username and click on Edit icon