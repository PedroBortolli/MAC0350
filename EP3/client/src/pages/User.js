import React, {useState} from 'react'
import styled from 'styled-components'
import fetchApi from '../utils/fetchApi'

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
    height: 290px;
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
    const [success, changeSuccess] = useState(null)

    const updPassword = async () => {
        if (password.senhaNova === password.senhaNovaCheck) {
            const res = await fetchApi('PATCH', 'http://localhost:5000/api/usuarios', {
                usuario: {
                    login: password.login,
                    senha: password.senhaNova
                }
            })
            if (res.ok) changeSuccess(true)
            else changeSuccess(false)
        }
        else changeSuccess(false)
    }
    const updEmail = async () => {
        if (email.emailNovo === email.emailNovoCheck) {
            const res = await fetchApi('PATCH', 'http://localhost:5000/api/usuarios', {
                usuario: {
                    login: email.login,
                    email: email.emailNovo
                }
            })
            if (res.ok) changeSuccess(true)
            else changeSuccess(false)
        }
        else changeSuccess(false)
    }

    return (
        <Container>
            <h1>Usuário</h1>
            <Info>
                <div>
                    <span>Login</span>
                    <input onChange={e => changePassword({...password, login: e.target.value})} />
                    <span>Nova senha</span>
                    <input type="password" onChange={e => changePassword({...password, senhaNova: e.target.value})} />
                    <span>Confirme a nova senha</span>
                    <input type="password" onChange={e => changePassword({...password, senhaNovaCheck: e.target.value})} />
                    <button onClick={updPassword}>Atualizar senha</button>
                </div>
                <div>
                    <span>Login</span>
                    <input onChange={e => changeEmail({...email, login: e.target.value})} />
                    <span>Novo e-mail</span>
                    <input type="text" onChange={e => changeEmail({...email, emailNovo: e.target.value})} />
                    <span>Confirme o novo e-mail</span>
                    <input type="text" onChange={e => changeEmail({...email, emailNovoCheck: e.target.value})} />
                    <button onClick={updEmail}>Atualizar e-mail</button>
                </div>
            </Info>
            {typeof success === 'boolean' ?
                success ?
                    <p style={{color: 'green'}}>Request bem sucedido!</p>
                :
                    <p style={{color: 'red'}}>Request falhou...</p>
            : null}
        </Container>
    )
}

export default User