import React, {useState} from 'react'
import styled from 'styled-components'

const Container = styled.div`
    padding-top: 60px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    > h1 {
        color: #074bb8;
    }
`
const Info = styled.div`
    border: 1px solid rgba(0, 0, 0, 0.25);
    border-radius: 8px;
    width: 600px;
    height: 230px;
    display: flex;
    justify-content: space-between;
    > div {
        width: 200px;
        height: 200px;
        padding: 25px;
        > input {
            width: 100%;
            height: 30px;
            margin-bottom: 20px;
        }
        > button {
            margin-top: 8px;
        }
    }
`

function User() {
    const [password, changePassword] = useState({})
    const [email, changeEmail] = useState({})

    const updPassword = () => {
        // TODO - api request
        console.log("Atualizando senha: ", password)
    }
    const updEmail = () => {
        // TODO - api request
        console.log("Atualizando email: ", email)
    }

    return (
        <Container>
            <h1>Usuário</h1>
            <Info>
                <div>
                    <span>Nova senha</span>
                    <input type="password" onChange={e => changePassword({...password, senhaNova: e.target.value})} />
                    <span>Confirme a nova senha</span>
                    <input type="password" onChange={e => changePassword({...password, senhaNovaCheck: e.target.value})} />
                    <button onClick={updPassword}>Atualizar senha</button>
                </div>
                <div>
                    <span>Novo e-mail</span>
                    <input type="text" onChange={e => changeEmail({...email, emailNovo: e.target.value})} />
                    <span>Confirme o novo e-mail</span>
                    <input type="text" onChange={e => changeEmail({...email, emailNovoCheck: e.target.value})} />
                    <button onClick={updEmail}>Atualizar e-mail</button>
                </div>
            </Info>
        </Container>
    )
}

export default User