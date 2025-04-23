*** Settings ***
Library     RPA.Browser.Playwright
Resource    ../../LIBRARY/CORE/WEB/navegador.robot
Resource    ../../LIBRARY/CORE/WEB/downloads.robot
Resource    ../../LIBRARY/LINKEDIN/WEB/LOCATORS/home_locator.robot


*** Variables ***
${URL_LINKEDIN}      https://www.linkedin.com/login
${EMAIL}    SEU EMAIL
${SENHA}    SUA SENHA
${CARGO_BUSCADO}    dev hunter


*** Tasks ***
Adicionar pessoas ao linkedin
    Dado que eu entre no site    ${URL_LINKEDIN}
    Entao realizo o login    ${EMAIL}    ${SENHA}
    Entao busco as pessoas com cargo    ${CARGO_BUSCADO}
    E me conecto com todas
    

*** Keywords ***
Entao realizo o login
    [Arguments]    ${email}    ${senha}
    Type Text    ${inputEmail}    ${EMAIL}
    Type Text    ${inputSenha}    ${SENHA}
    Click    ${btnLogar}

Entao busco as pessoas com cargo
    [Arguments]    ${cargo}
    Go To    https://www.linkedin.com/search/results/people/?keywords=${cargo}&origin=SWITCH_SEARCH_VERTICAL&sid=Jyo

E me conecto com todas
    ${promise}=    Promise To    Wait For Elements State
    ...    //h2[text()="Você alcançou o limite semanal de convites"]
    ...    state=visible
    ...    timeout=1s
    FOR    ${pagina}    IN RANGE    ${10}
        ${limite_conexoes}    Run Keyword And Return Status
        ...    Wait For    ${promise}    timeout=1s
        
        IF    ${limite_conexoes}
            Log    Limite conexoes alcançado - Finalizado Processo com Sucesso
            RETURN
        END

        Conectar com todos da pagina
        Scroll To    vertical=bottom
        Click    ${btnAvancar}
    END
    
Conectar com todos da pagina
    @{botoes_conectar}    Get Elements    ${btnConectar}
    ${qtd_botoes}    Get Length    ${botoes_conectar}
    WHILE    ${qtd_botoes} != 0
        Clicar em conectar    ${botoes_conectar}[0]
        Clicar em enviar nota
        Wait For Load State    load
        @{botoes_conectar}    Get Elements    ${btnConectar}
        ${qtd_botoes}    Get Length    ${botoes_conectar}    
    END

Clicar em enviar nota
    TRY
        Click    ${btnEnviarSemNota}
    EXCEPT
        ${botao_retirar_encontrado}    Get Elements    ${botaoRetirar}
        ${qtd_botoes_encontrados}    Get Length    ${botao_retirar_encontrado}
        IF    ${qtd_botoes_encontrados} > 0
            Click    ${botaoCancelar}
        ELSE
            Reload
        END
    END

Clicar em conectar
    [Arguments]    ${botao_conectar}
    TRY
        Click    ${botao_conectar}
    EXCEPT
        ${botao_retirar_encontrado}    Get Elements    ${botaoEntendi}
        ${qtd_botoes_encontrados}    Get Length    ${botao_retirar_encontrado}
        IF    ${qtd_botoes_encontrados} > 0
            Click    ${botaoCancelar}
        ELSE
            Reload
        END
    END