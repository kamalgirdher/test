*** Settings ***
Suite Setup       BeforeSuite
Library           SeleniumLibrary
Library           ExcelLibrary
Library           OperatingSystem
Variables         config.py

*** Test Cases ***
TC1
    FOR    ${r}    IN RANGE    ${start1}    ${stop1}
        ${link}=    getExcelData    ${r}
        Open Browser    https://www.partstree.com${link}    chrome
        ${title}=    Run Keyword And Ignore Error    Get Text    css=.title
        ${desc}=    Run Keyword And Ignore Error    Get Text    css=.description
        ${price}=    Run Keyword And Ignore Error    Get Text    css=.price
        ${img}=    Run Keyword And Ignore Error    Get Text    css=.genuine img
        Run Keyword If    '${title[0]}'=='PASS'    Append To File    output/output1.txt    ${title[1]}##${desc[1]}##${price[1]}##${img[1]}\n

        Close Browser
    END

*** Keywords ***
getExcelData
    [Arguments]    ${row}
    ${rowdata}=    Read Excel Cell    ${row}    1
    [Return]    ${rowdata}

BeforeSuite
    Open Excel Document    filename=input/1.xlsx    doc_id=inp
