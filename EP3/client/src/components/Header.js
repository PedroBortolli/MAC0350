import React from 'react'
import styled from 'styled-components'
import {Link} from 'react-router-dom'

const Container = styled.div`
    width: 100%;
    height: 50px;
    position: fixed;
    top: 0;
    left: 0;
    background-color: #0d4091;
    display: flex;
    align-items: center;
    justify-content: space-around;
    border-bottom: 5px solid black;
    > a {
        font-size: 22px;
        color: #ffffff;
        cursor: pointer;
        text-decoration: none;
        :hover {text-decoration: underline}
    }
`

function Header() {
    const session = sessionStorage.getItem('auth')

    const logoff = () => {
        sessionStorage.removeItem('auth')
        window.location = '/'
    }

    return <Container>
        <Link to='/'>Home</Link>
        <Link to='/dashboard'>Dashboard</Link>
        {session ?
            <a onClick={logoff}>Logout</a>
            :
            <Link to='/login'>Login</Link>
        }
    </Container>
}

export default Header