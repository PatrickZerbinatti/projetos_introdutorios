*** Settings ***
Library     RPA.Browser.Playwright
Resource    ../../LIBRARY/CORE/WEB/navegador.robot
Resource    ../../LIBRARY/CORE/WEB/downloads.robot
Resource    ../../LIBRARY/DOLAR_PTAX/WEB/LOCATORS/home_locator.robot


*** Variables ***
${URL_BCB}      https://www.bcb.gov.br/estabilidadefinanceira/historicocotacoes


*** Tasks ***
Busca Valor Tabela PTAX
    Dado que eu entre no site    ${URL_BCB}
    Entao clico sobre a segunda opção de Cotacao
    E clico em Pesquisar
    E realizo o download do arquivo    ${CURDIR}/ptax_${DATA}.csv    ${hyperlinkCSV}


*** Keywords ***
Entao clico sobre a segunda opção de Cotacao
    Click    ${txtProsseguir}
    ${IFRAME}    Get Element    xpath= ${frameCotacoes}
    Set Global Variable    ${IFRAME}
    Click    ${IFRAME} >>> xpath=${cotacaoOuBoletim}
    ${DATA}    Get Text    ${IFRAME} >>> ${txtData}
    Set Global Variable    ${DATA}

E clico em Pesquisar
    Click    ${IFRAME} >>> ${btnPesquisar}
