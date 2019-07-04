import React from 'react'
import styled from 'styled-components'

const Container = styled.div`
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    > h2 {padding-top: 80px}
    > div {
        padding-top: 60px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }
`

function App() {
    let session = sessionStorage.getItem('auth'), auth = null
    if (session) auth = JSON.parse(sessionStorage.getItem('auth'))
    return (
        <Container>
            <h1>Bem vindo ao sistema de gerenciamento de matérias!</h1>
            {auth ?
                <div>
                    <h2>Você está atualmente logado como <span style={{color: 'red'}}>{auth.login}</span></h2>
                    <h2 style={{paddingTop: 0}}>Utilizando o menu superior, clique em
                    <span style={{color: 'red'}}> Matérias</span> para começar.</h2>
                </div>
                :
                <h2>Você não está logado no momento. Por favor efetue o login para que 
                você possa associar as matérias escolhidas à sua conta</h2>
            }
            <h2>Este site é o resultado do EP3 de MAC0350</h2>
        </Container>
    )
}

export default App