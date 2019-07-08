import React, {useState, useEffect} from 'react'
import styled from 'styled-components'
import fetchApi from '../utils/fetchApi'
import loadingGif from '../assets/loading.gif'

const Container = styled.div`
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
const Response = styled.div`
    display: flex;
    justify-content: center;
    align-items: center;
    height: 92px;
    width: 92px;
    > img {
        height: 100%;
        width: 100%;
    }
    > p {color: red}
`

function Login() {
    const [login, changeLogin] = useState(null)
    const [success, changeSuccess] = useState(true)
    const [password, changePassword] = useState(null)
    const [loading, changeLoading] = useState(false)
    useEffect(() => {
        const session = sessionStorage.getItem('auth')
        if (session) window.location = '/dashboard'
    }, [])
    const attemptLogin = async () => {
        changeSuccess(true)
        changeLoading(true)
        const response = await fetchApi('POST', 'http://localhost:5000/api/auth/login', 
            {auth: {
                login: login,
                senha: password
            }
        })
        if (response.ok) {
            const auth = {username: login, senha: password, nusp: response.nusp}
            sessionStorage.setItem('auth', JSON.stringify(auth))
            window.location = '/dashboard'
        }
        else changeSuccess(false)
        changeLoading(false)
    }

    return (
        sessionStorage.getItem('auth') ?
        <Container>
            <p>Você já está logado. Redirecionando...</p>
        </Container>
        :
        <Container>
            <Field>
                <div>Login</div>
                <input type="text" onChange={e => changeLogin(e.target.value)} onKeyDown={e => e.key === 'Enter' && attemptLogin()} />
            </Field>
            <Field>
                <div>Password</div>
                <input type="password" onChange={e => changePassword(e.target.value)} onKeyDown={e => e.key === 'Enter' && attemptLogin()} />
            </Field>
            <button onClick={attemptLogin}>Login</button>
            <Response>
                {loading && <img alt="" src={loadingGif} />}
                {!success && <p style={{color: 'red'}}>Login falhou</p>}
            </Response>
        </Container>
    )
}

export default Login