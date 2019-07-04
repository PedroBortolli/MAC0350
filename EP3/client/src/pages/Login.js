import React, {useState, useEffect} from 'react'
import styled from 'styled-components'

const Container = styled.form`
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100%;
    > button {
        width: 75px;
        height: 26px;
        margin-top: 12px;
    }
`
const Field = styled.div`
    > div {
        font-weight: 900;
        font-size: 18px;
        margin-bottom: 4px;
    }
    > input {
        height: 26px;
    }
    margin-bottom: 20px;
`

function Login() {
    const [login, changeLogin] = useState(null)
    const [password, changePassword] = useState(null)
    useEffect(() => {
        const session = sessionStorage.getItem('auth')
        if (session) {
            //const auth = JSON.parse(sessionStorage.getItem('auth'))
            window.location = '/dashboard'
        }
    }, [])
    const attemptLogin = () => {
        // TODO: call api to login
        const auth = {login: {login}, password: {password}}
        sessionStorage.setItem('auth', JSON.stringify(auth))
        window.location = '/dashboard'
    }

    return (
        sessionStorage.getItem('auth') ?
        <Container>
            <p>Você já está logado. Redirecionando...</p>
        </Container>
        :
        <Container onKeyDown={e => e.key === 'Enter' && attemptLogin}>
            <Field>
                <div>Login</div>
                <input type="text" onChange={e => changeLogin(e.target.value)} />
            </Field>
            <Field>
                <div>Password</div>
                <input type="password" onChange={e => changePassword(e.target.value)} />
            </Field>
            <button onClick={attemptLogin}>Login</button>
        </Container>
    )
}

export default Login