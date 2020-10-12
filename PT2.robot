*** Settings ***
Suite Setup       BeforeSuite
Library           SeleniumLibrary
Library           ExcelLibrary
Library           OperatingSystem
Variables         config.py

*** Test Cases ***
TC1
    FOR    ${r}    IN RANGE    ${start2}    ${stop2}
        ${link}=    getExcelData    ${r}
        Open Browser    ${link}    chrome
        ${title}=    Run Keyword And Ignore Error    Get Text    css=.title
        Run Keyword If    '${title[0]}'=='PASS'    Append To File    output2.txt    ${title[1]}\n
        Close Browser
    END

*** Keywords ***
getExcelData
    [Arguments]    ${row}
    ${rowdata}=    Read Excel Cell    ${row}    1
    [Return]    ${rowdata}

BeforeSuite
    Open Excel Document    filename=input.xlsx    doc_id=inp
