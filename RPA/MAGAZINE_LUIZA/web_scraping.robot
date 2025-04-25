*** Settings ***
Library     RPA.Browser.Playwright
Library     Collections
Resource    ../../LIBRARY/CORE/WEB/navegador.robot
Resource    ../../LIBRARY/CORE/WEB/downloads.robot
Resource    ../../LIBRARY/LINKEDIN/WEB/LOCATORS/home_locator.robot


*** Variables ***
${URL_MAGAZINE}      https://www.magazineluiza.com.br/
${PRODUTO_BUSCADO}    notebooks
${EMAIL_DESTINATARIO}    patrick.geovani357@hotmail.com


*** Tasks ***
Pesquisar lista de produtos
    Dado que eu entre no site    ${URL_MAGAZINE}
    Entao pesquiso o produto buscado    ${PRODUTO_BUSCADO}
    Entao extraio todos os resultados de todas as paginas
    Entao gero um arquivo excel com os resultados
    E envio por email
    

*** Keywords ***
 Entao pesquiso o produto buscado
    [Arguments]    ${produto_buscado}
    Type Text    //input[@id='input-search']    ${PRODUTO_BUSCADO}
    Keyboard Key    press    Enter

Entao extraio todos os resultados de todas as paginas
    @{lista_produtos}    Create List
    Wait For Elements State    //div[@data-testid='product-list']/ul/li[1]    visible
    ${existe_pagina_seguinte}    Get Element Count    //button[@aria-label='Go to next page']
    WHILE    ${existe_pagina_seguinte} != ${0}
        ${produtos_pagina}    Entao extraio todos os resultados da pagina
        Append To List    ${lista_produtos}    @{produtos_pagina}
        Click    //button[@aria-label='Go to next page']
        ${existe_pagina_seguinte}    Get Element Count    //button[@aria-label='Go to next page']
    END
    Skip
    

Entao extraio todos os resultados da pagina
    @{lista_produtos}    Create List    
    Wait For Elements State    //div[@data-testid='product-list']/ul/li[1]    visible
    ${nr_produtos_encontrados}    Get Element Count   //h2[1][@data-testid='product-title']
    FOR    ${nr_produto}    IN RANGE    1    ${nr_produtos_encontrados}
        ${dados_produto}    Create Dictionary
        ${existe_produto}    Get Element Count    //div[@data-testid='product-list']/ul/li[${nr_produto}]/a
        IF    ${existe_produto} != ${0}
            ${link_produto}    Get Attribute    //div[@data-testid='product-list']/ul/li[${nr_produto}]/a    href
            ${titulo_produto}    Get Text    //div/ul/li[${nr_produto}]/a/div[@data-testid='product-card-content']/h2
            ${existe_avaliacoes}    Get Element Count    //div/ul/li[${nr_produto}]/a/div/div/div[@data-testid='review']/span
            IF    ${existe_avaliacoes} == ${0}
                ${avaliacoes_produto}    Set Variable    (0)
            ELSE
                ${avaliacoes_produto}    Get Text       //div/ul/li[${nr_produto}]/a/div/div/div[@data-testid='review']/span
            END
            Set To Dictionary    ${dados_produto}    link_produto=${link_produto}    titulo_produto=${titulo_produto}    avaliacoes_produto=${avaliacoes_produto}
            Append To List    ${lista_produtos}    ${dados_produto}
        END
    END
    RETURN    ${lista_produtos}

Entao gero um arquivo excel com os resultados
    Skip
    
E envio por email
    Skip
