*** Settings ***
Library     RPA.Browser.Playwright

*** Keywords ***
Dado que eu entre no site
    [Arguments]    ${URL}
    New Browser    chromium    headless=false    downloadsPath=./
    New Context    acceptDownloads=True
    New Page    ${URL}