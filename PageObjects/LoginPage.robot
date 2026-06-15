*** Settings ***
Documentation    This file consists of Login Page related actions
Library    SeleniumLibrary
Resource        ../Resources/GlobalVariables.robot

*** Variables ***
${username-loc}            css:input[name='username']
${password-loc}            css:input[placeholder='Password']
${submitbtn-loc}            xpath://button[@type='submit']
${errormessage-loc}            xpath://p[contains(., 'Invalid credentials')]
${dashboard-loc}            css:h6.oxd-text
${required-loc}            css:span.oxd-text
${forgotpwd-loc}            xpath://p[contains(., 'Forgot your password')]
${resetpwdpage-loc}            css:h6

*** Keywords ***
Enter Username
    [Arguments]            ${uname}
    Input Text                ${username-loc}            ${uname}

Enter Password
    [Arguments]            ${pwd}
    Input Password            ${password-loc}            ${pwd}

Click Login Button
    Click Button            ${submitbtn-loc}

Verify Error
    Element Text Should Be            ${errormessage-loc}           Invalid credentials

verify the login page title or logo is visible
    ${title}=    Get Title
    Should Be Equal As Strings    ${title}            OrangeHRM

verify if dashboard page is visible
    ${actualname}=     Get Text    ${dashboard-loc}
    Should Be Equal As Strings       ${actualname}     Dashboard

verify if error message appears
    ${actualerror}=    Get Text    ${errormessage-loc}
    Should be Equal As Strings        ${actualerror}    Invalid credentials

verify the 'Required' field validation messages appear
    @{actualerrors}=    Get Webelements    ${required-loc}
    FOR    ${actualerror}    IN    @{actualerrors}
        ${text}=    Get Text    ${actualerror}
        Should Be Equal As Strings       ${text}     Required
    END

click on the forget password
    Click Element                ${forgotpwd-loc}

verify if reset password page appears
    ${actualname}=     Get Text    ${resetpwdpage-loc}
    Should be Equal As Strings        ${actualname}    Reset Password