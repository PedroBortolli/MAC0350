import React, {useState, useEffect} from 'react'
import styled from 'styled-components'
import fetchApi from '../utils/fetchApi'

const Container = styled.div`
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding-top: 60px;
    > h1 {
        color: #074bb8;
    }
`

const Info = styled.div`
    border: 1px solid rgba(0, 0, 0, 0.25);
    border-radius: 8px;
    width: 600px;
    height: 300px;
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
const Role = styled.div`
    padding-top: 60px;
    > h1 {
        padding-bottom: 16px;
        text-align: center;
        color: #074bb8;
    }
    > div {
        margin-top: 8px;
    }
    > * input {
        height: 30px;
        margin-left: 12px;
    }
`
const Center = styled.div`
    display: flex;
    align-items: center;
    justify-content: center;
`

function Profile() {
    const [password, changePassword] = useState({})
    const [email, changeEmail] = useState({})
    const [profile, changeProfile] = useState({})
    const [servicos, changeServicos] = useState({})

    useEffect(() => {
        const fetchServicos = async () => {
            const servicos = await fetchApi('GET', 'http://localhost:5000/api/servicos')
            let servicosState = {}
            Object.keys(servicos).forEach(id => {
                if (typeof servicos[id] === 'object')
                    servicosState = {...servicosState, [servicos[id].tipo]: false}
            })
            changeProfile(servicosState)
            changeServicos(servicos)
        }

        fetchServicos()
    }, [])

    const updPassword = () => {
        // TODO - api request
        console.log("Atualizando senha: ", password)
    }
    const updEmail = () => {
        // TODO - api request
        console.log("Atualizando email: ", email)
    }
    const createProfile = () => {
        // TODO - api request
        console.log("Criando perfil: ", profile)
    }

    return (
        <Container>
            <h1>Perfil</h1>
            <Info>
                <div>
                    <span>Nova senha</span>
                    <input type="text" onChange={e => changePassword({...password, senhaNova: e.target.value})} />
                    <span>Confirme a nova senha</span>
                    <input type="text" onChange={e => changePassword({...password, senhaNovaCheck: e.target.value})} />
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

            <Role>
                <h1>Criar perfil</h1>

                <div>
                    <span>Nome do perfil: </span>
                    <input type="text" onChange={e => changeProfile({...profile, nome: e.target.value})} />
                </div>
                
                <div>
                    <span>Descrição: </span>
                    <input type="text" onChange={e => changeProfile({...profile, descricao: e.target.value})} style={{marginLeft: 45.8}} />
                </div>

                {Object.keys(servicos).map(id => {
                    if (typeof servicos[id] === 'object') {
                        const st = {marginTop: id === '0' ? 24 : 0}
                        return (
                            <Center key={id} style={st}>
                                <input type="checkbox" onClick={e => changeProfile({...profile, [servicos[id].tipo]: e.target.checked})} />
                                <span>{servicos[id].tipo}:&nbsp;&nbsp;</span>
                                <span>{servicos[id].descricao}</span> 
                            </Center>
                        )
                    }
                })}
                
                <Center style={{marginTop: 32}}>
                <button onClick={createProfile}>Criar perfil</button>
                </Center>
            </Role>
        </Container>
    )
}

export default Profile