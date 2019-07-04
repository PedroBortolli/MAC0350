import React from 'react'
import styled from 'styled-components'
import {Link} from 'react-router-dom'

const Container = styled.div`
    width: 100%;
    height: 50px;
    position: fixed;
    top: 0;
    left: 0;
    background-color: #bcd6ff;
    display: flex;
    align-items: center;
    justify-content: space-around;
    > a {
        font-size: 20px;
        color: rgb(85, 26, 139);
        cursor: pointer;
        text-decoration: underline;
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