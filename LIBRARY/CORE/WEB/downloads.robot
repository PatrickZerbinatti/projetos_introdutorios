
*** Settings ***
Library    RPA.Browser.Playwright

*** Keywords ***
E realizo o download do arquivo
    [Arguments]    ${nome_arquivo}    ${locator_download}
    ${espera_download}    Promise To Wait For Download    ${nome_arquivo}
    Click    ${locator_download}
    Wait For    ${espera_download}

