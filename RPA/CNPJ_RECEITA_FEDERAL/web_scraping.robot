*** Settings ***
Library     RPA.Browser.Playwright
Resource    ../../LIBRARY/CORE/WEB/navegador.robot
Resource    ../../LIBRARY/CORE/WEB/downloads.robot
Resource    ../../LIBRARY/CNPJ_RECEITA_FEDERAL/WEB/LOCATORS/home_locator.robot


*** Variables ***
${URL_CVM}      https://dados.cvm.gov.br/dataset/fi-doc-inf_diario


*** Tasks ***
Busca de Informes Diarios
    Dado que eu entre no site    ${URL_CVM}
    Entao realizo busco pelo ultimo informe
    E realizo o download do arquivo    ${CURDIR}/informeRendimentos.zip    ${btnDownload}


*** Keywords ***
Entao realizo busco pelo ultimo informe
    ${informes_diarios}    Get Elements    ${itensListaInformeRendimentos}
    ${ultimo_informe}    Get Element    ${informes_diarios}[-1]
    Click    ${ultimo_informe}
