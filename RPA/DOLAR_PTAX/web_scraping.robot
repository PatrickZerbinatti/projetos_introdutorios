*** Settings ***
Library    RPA.Browser.Playwright
Resource   ../../LIBRARY/DOLARPTAX/WEB/LOCATORS/home_locator.robot

*** Tasks *** 
Procurando valor na tabela PTAX
    Set Browser Timeout     5
    New Browser    chromium    headless=false
    New Context    acceptDownloads=True
    New Page       https://www.bcb.gov.br/estabilidadefinanceira/historicocotacoes
    Click          ${txtProsseguir}
    ${IFRAME}    Get Element     xpath= ${frameCotacoes}
    Click         ${IFRAME} >>> xpath=${cotacaoOuBoletim}
    ${DATA}    Get Text    ${IFRAME} >>> ${txtData}
    Click      ${IFRAME} >>> ${btnPesquisar}
    ${dl_promise}          Promise To Wait For Download    ${CURDIR}/ptax_${DATA}.csv
    Click                xpath=${hyperlinkCSV}
    ${file_obj}=           Wait For  ${dl_promise}