*** Settings ***
Documentation    This is the test case file
Test Setup    Open the OrangeHRM application and login with valid credentials
Test Teardown    Closing the Browser Session
Library    SeleniumLibrary
Resource    ../PageObjects/AdminPage.robot

*** Test Cases ***
Add and Verify a System User
    AdminPage.navigate to Admin Tab
    AdminPage.open add user form
    AdminPage.select the value from the dropdown    ${userroledd-loc}    ${userrolefulldd-loc}    ${userrolevalue-loc}
    AdminPage.verify the dropdown selection    ${userrolevalueselected-loc}    ESS
    AdminPage.search the value from the employee name field    ${employeenamedd-loc}    Thomas    ${empoyeesuggetsion-loc}    ${employeename-loc}
    AdminPage.select the value from the dropdown    ${statusdd-loc}    ${statusfulldd-loc}    ${statusvalue-loc}
    AdminPage.verify the dropdown selection     ${statusvalueselected-loc}    Enabled
    AdminPage.fill Username, Password, Confirm Password and click Save
    AdminPage.verify the new user appears in the table
    AdminPage.search for the user you just created using the Search Username field and verify exactly 1 result appears













