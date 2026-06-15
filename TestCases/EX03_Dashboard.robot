*** Settings ***
Documentation    This is the test case file
Test Setup    Open the OrangeHRM application and login with valid credentials
Test Teardown    Closing The Browser Session
Library    SeleniumLibrary
Resource    ../Resources/CommonKeywords.robot
Resource    ../PageObjects/DashboardPage.robot

*** Test Cases ***
Verify Dashboard After Login
    CommonKeywords.wait until element is visible in the page    ${dashboardheading-loc}
    DashboardPage.verify dashboard is displayed in the page
    DashboardPage.verify the navigation menu items are visible    @{expected-navigation-items}
    DashboardPage.get the logged in username
    CommonKeywords.Verify the URL contains text    dashboard
    DashboardPage.click on the profile dropdown at the top right
    DashboardPage.verify if the logout button appears