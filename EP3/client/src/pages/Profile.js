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
const Role = styled.div`
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

    const createProfile = () => {
        // TODO - api request
        console.log("Criando perfil: ", profile)
    }

    return (
        <Container>
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