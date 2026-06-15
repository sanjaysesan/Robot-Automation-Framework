*** Settings ***
Documentation    This is the test case file
Library    SeleniumLibrary
Resource    ../PageObjects/AdminPage.robot
Resource    ../Resources/CommonKeywords.robot
Test Setup    Open the OrangeHRM application and login with valid credentials
Test Teardown    Closing the Browser Session

*** Test Cases ***
Verification of Adding and Verifying required fields
    AdminPage.navigate to Admin Tab
    CommonKeywords.wait until element is visible in the page        ${job-loc}
    AdminPage.select the value from the dropdown    ${job-loc}      ${jobdropd}     ${jobvalue}
    AdminPage.verify the job titles page and the count of jobs
    CommonKeywords.logging the element      ${count}
    AdminPage.click add and verify the add job title form opens
    AdminPage.click save without filling the job title and verify the validation
    AdminPage.fill the job title field and verify the title appears in the list
    AdminPage.locate the element on this page