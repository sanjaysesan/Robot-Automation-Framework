*** Settings ***
Documentation    This file consists of Login Page related actions
Library    SeleniumLibrary
Library     Collections
Library     String
Resource    ../Resources/CommonKeywords.robot
Resource    ../Resources/GlobalVariables.robot

*** Variables ***
#  ----  Navigation  ----
${addbutton-loc}    xpath://button[@type='button' and normalize-space()='Add']
${admin-loc}    css:a[href='/web/index.php/admin/viewAdminModule']
${adduserheading-loc}    xpath://h6[contains(.,'Add')]
${savebutton-loc}    xpath://button[contains(@class,'oxd-button') and normalize-space()='Save']
${searchbtn-loc}    css:button[type='submit']


#  ----  User Role Dropdown  ----
${userroledd-loc}    xpath://label[text()='User Role']/ancestor::div[contains(@class, 'oxd-input-group')]//div[@class='oxd-select-text-input']
${userrolefulldd-loc}    xpath://div[@role='listbox']
${userrolevalue-loc}    xpath://span[text()='ESS']
${userrolevalueselected-loc}    xpath://div[text()='ESS']

# ---- Job Dropdown ----
${job-loc}          xpath://span[normalize-space()='Job']
${jobdropd}         css:ul.oxd-dropdown-menu
${jobvalue}         xpath://a[@role='menuitem' and normalize-space()='Job Titles']
${title}            css:h6.orangehrm-main-title
${jobtitles}        xpath://div[@role='rowgroup' and @class='oxd-table-body']//div[@role='row']//div[2]
${requiredmsg}      xpath://span[text()='Required']
${jobtitlefield-loc}        xpath://label[normalize-space()='Job Title']/ancestor::div[contains(@class,'oxd-input-group')]//input


#  ----  Employee Name  ----
${employeenamedd-loc}    css:input[placeholder="Type for hints..."]
${empoyeesuggetsion-loc}    xpath://div[@role='listbox']
${employeename-loc}    xpath://div[@role='listbox']//div[1]

#  ----  Status  ----
${statusdd-loc}    xpath://label[text()='Status']/ancestor::div[contains(@class,'oxd-input-group')]//div[@class='oxd-select-text-input']
${statusfulldd-loc}    css:div[role='listbox']
${statusvalue-loc}    xpath://span[text()='Enabled']
${statusvalueselected-loc}    xpath://div[text()='Enabled']

#  ----  Form Fields  ----
${formelements}    xpath://input[contains(@class,'oxd-input')]/ancestor::div[contains(@class,'oxd-input-group')]//label
${username-loc}    xpath://div[contains(@class,'oxd-form-row')]//input[contains(@class,'oxd-input')]

#  ----  Verification  ----
${recordfound-loc}    xpath://span[text()='(1) Record Found']
${userrecords-loc}    xpath://div[@class='oxd-table-card']
${usernamecolumn-loc}    xpath://div[@class='oxd-table-body']//div[@role='row']//div[2]

*** Keywords ***
navigate to Admin Tab
    CommonKeywords.wait until element is visible in the page    ${admin-loc}
    CommonKeywords.Click the button    ${admin-loc}

open add user form
    CommonKeywords.wait until element is visible in the page    ${addbutton-loc}
    CommonKeywords.Click the button    ${addbutton-loc}
    CommonKeywords.wait until element is visible in the page    ${adduserheading-loc}
    Element Text Should Be    ${adduserheading-loc}    Add User

select the value from the dropdown
    [Arguments]    ${dropdown}    ${listbox}    ${option}
    CommonKeywords.Click the button    ${dropdown}
    CommonKeywords.wait until element is visible in the page    ${listbox}
    CommonKeywords.Click the button    ${option}

verify the dropdown selection
    [Arguments]    ${locator}    ${expectedvalue}
    Element Text Should Be    ${locator}    ${expectedvalue}

search the value from the employee name field
    [Arguments]    ${dropdown}    ${text}    ${listbox}    ${value}
    Input Text    ${dropdown}    ${text}
    CommonKeywords.wait until element is visible in the page    ${listbox}
    CommonKeywords.Click the button    ${value}

fill username, password, confirm password and click save
    @{elements}=    Get Webelements    ${formelements}
    FOR    ${element}    IN    @{elements}
        ${label-name}=    Get Text    ${element}
        IF    '${label-name}' == 'Username'
            Input Text    xpath://label[text()='${label-name}']/ancestor::div[contains(@class,'oxd-input-group')]//input[contains(@class,'oxd-input')]    ${user-username}
        ELSE
            Input Password    xpath://label[text()='${label-name}']/ancestor::div[contains(@class,'oxd-input-group')]//input[contains(@class,'oxd-input')]    ${user-password}
        END
    END

    Click Button    ${savebutton-loc}
    Sleep    10s

verify the new user appears in the table
    Element Should Be Visible       xpath://div[text()='${user-username}']

search for the user you just created using the Search Username field and verify exactly 1 result appears
    Input Text    ${username-loc}    ${user-username}
    Click Button    ${searchbtn-loc}
    Wait Until Element Is Visible    xpath://div[text()='${user-username}']
    Element Should Be Visible    xpath://div[text()='${user-username}']
    Element Should Be Visible    ${recordfound-loc}

get all column header texts from users table
    CommonKeywords.wait until element is visible in the page    ${addbutton-loc}
    @{expectedlist}=   Create List   Username   User Role   Employee Name   Status   Actions
    @{actualList}=    Create List
    FOR   ${element}   IN    @{expectedlist}
        ${text}=    Get Text    xpath://div[@role='columnheader' and text()='${element}']
        Append to List    ${actualList}    ${text}
    END
    Lists Should Be Equal     ${expectedlist}    ${actualList}

get the total users
    ${usercount}=    Set Variable    0
    @{elements}=    Get Webelements    ${userrecords-loc}
    FOR    ${element}    IN    @{elements}
        ${usercount}=    Evaluate    ${usercount}+1
    END
    Set Global Variable    ${usercount}

iterate through every row and read username
    @{elements}=    Get Webelements    ${usernamecolumn-loc}
    @{usernames}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${usernames}    ${text}
    END
    Set Global Variable    ${usernames}

find the 'Admin' username and click on Edit icon
    @{elements}=    Get Webelements    ${usernamecolumn-loc}
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        IF    '${text}'=='Admin'
            Click Element    xpath://div[@role='rowgroup']//div[text()='${text}']/ancestor::div[@role='row']//div[@class='oxd-table-cell-actions']//button[2]
            BREAK
        END
    END
    Sleep    5s

verify the job titles page and the count of jobs
    CommonKeywords.wait until element is visible in the page        ${title}
    Element Text Should Be      ${title}        Job Titles
    ${count}=   Set Variable    0
    @{elements}=    Get Webelements     ${jobtitles}
    FOR     ${element}      IN      @{elements}
        ${count}=       Evaluate    ${count}+1
    END
    Set Global Variable     ${count}

click add and verify the add job title form opens
    CommonKeywords.Click the button     ${addbutton-loc}
    CommonKeywords.wait until element is visible in the page       ${title}
    Element Text Should Be       ${title}       Add Job Title

click save without filling the job title and verify the validation
    CommonKeywords.Click the button         ${savebutton-loc}
    Element Text Should Be      ${requiredmsg}      Required

fill the job title field and verify the title appears in the list
    Input Text    ${jobtitlefield-loc}      ${jobtitle-name}
    CommonKeywords.Click the button         ${savebutton-loc}
    CommonKeywords.wait until element is visible in the page        ${addbutton-loc}
    sleep   5s
    @{elements}=     Get Webelements     ${jobtitles}
    FOR     ${element}      IN      @{elements}
         ${text}=   Get Text    ${element}
         IF    '${text}'=='${jobtitle-name}'
                Log     ${text}
                BREAK
         END
    END

locate the element on this page
    #used xpath with starts-with() function
    @{words}=   Split String    ${jobtitle-name}    ${space}
    ${first-word}=      Set Variable      ${words[0]}
    Element Should Be Visible       xpath://div[starts-with(text(),'${first-word}')]
























