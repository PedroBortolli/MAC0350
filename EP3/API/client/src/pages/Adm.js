import React, {useState, useEffect} from 'react'
import styled from 'styled-components'
import fetchApi from '../utils/fetchApi'

const Container = styled.div`
    padding-top: 60px;
    text-align: center;
    > h1 {color: #074bb8}
    > div {
        display: flex;
        justify-content: center;
        > div {
            margin: 0 32 0 32;
            > p {
                margin-bottom: 4px;
            }
            > input {
                height: 30px;
            }
            > h2 {
                color: #074bb8;
            }
            > button {
                margin-top: 24px;
                height: 24px;
            }
        }
    }
        > hr {
            margin-top: 32px;
        }
`
const Role = styled.div`
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding-top: 32px;
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
const Flex = styled.div`
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    > h1 {
        padding-bottom: 16px;
        text-align: center;
        color: #074bb8;
    }
`

function Adm() {
    const [newCourse, updNewCourse] = useState({})
    const [updateCourse, updUpdateCourse] = useState({})
    const [newTrilha, updNewTrilha] = useState({})
    const [updateTrilha, updUpdateTrilha] = useState({})
    const [profile, changeProfile] = useState({})
    const [servicos, changeServicos] = useState({})
    const [usuario, changeUsuario] = useState({})
    const [success, changeSuccess] = useState(null)
    const [usuarios, changeUsuarios] = useState([])
    const [userToRemove, changeUserToRemove] = useState(null)
    const [perfis, changePerfis] = useState([])
    const [perfilServico, changePerfilServico] = useState({})

    useEffect(() => {
        const fetchServicos = async () => {
            const servicos = await fetchApi('GET', 'http://localhost:5000/api/servicos')
            let servicosState = {}
            Object.keys(servicos).forEach(id => {
                if (typeof servicos[id] === 'object')
                    servicosState = {...servicosState, [servicos[id].tipo]: false}
            })
            changePerfilServico(servicosState)
            changeServicos(servicos)
        }

        const fetchUsuarios = async () => {
            const users = await fetchApi('GET', 'http://localhost:5000/api/usuarios')
            let usuarios = []
            Object.keys(users).forEach(id => {
                if (typeof users[id] === 'object') usuarios.push(users[id])
            })
            changeUsuarios(usuarios)
        }

        const fetchPerfis = async () => {
            const profiles = await fetchApi('GET', 'http://localhost:5000/api/perfis')
            let perfis = []
            Object.keys(profiles).forEach(id => {
                if (typeof profiles[id] === 'object') perfis.push(profiles[id])
            })
            changePerfis(perfis)
        }

        fetchServicos()
        fetchUsuarios()
        fetchPerfis()
    }, [])

    const addCourse = async () => {
        const res = await fetchApi('POST', 'http://localhost:5000/api/disciplinas', {disciplina: newCourse})
        changeSuccess(res.ok)
    }
    const updCourse = async () => {
        const res = await fetchApi('PATCH', 'http://localhost:5000/api/disciplinas', {disciplina: updateCourse})
        changeSuccess(res.ok)
    }
    const addTrilha = async () => {
        const res = await fetchApi('POST', 'http://localhost:5000/api/trilhas', {trilha: newTrilha})
        changeSuccess(res.ok)
    }
    const updTrilha = async () => {
        const res = await fetchApi('PATCH', 'http://localhost:5000/api/trilhas', {trilha: updateTrilha})
        changeSuccess(res.ok)
    }
    const createProfile = async () => {
        const res = await fetchApi('POST', 'http://localhost:5000/api/perfis', {perfil: profile})
        changeSuccess(res.ok)
    }
    const createUser = async () => {
        const res = await fetchApi('POST', 'http://localhost:5000/api/usuarios', {usuario})
        changeSuccess(res.ok)
    }
    const removeUser = async () => {
        const res = await fetchApi('DELETE', 'http://localhost:5000/api/usuarios', {usuario: {login: userToRemove}})
        changeSuccess(res.ok)
    }
    const vincular = async () => {
        let promises = [], perfil
        Object.keys(perfilServico).forEach(id => {
            if (typeof perfilServico[id] === 'string') perfil = perfilServico[id]
        })
        Object.keys(perfilServico).forEach(id => {
            if (typeof perfilServico[id] === 'boolean' && perfilServico[id]) {
                promises.push(fetchApi('POST', 'http://localhost:5000/api/perfis/servico', {
                    perfil: {papel: perfil},
                    servico: {tipo: id}
                }))
            }
        })
        const res = await Promise.all(promises)
        let ok = true
        res.forEach(r => {
            if (!r.ok) ok = false
        })
        changeSuccess(ok)
    }

    
    return (
        <Container>
            <h1>Administrar sistema</h1>
            {success !== null ?
                success === true ?
                    <p style={{color: 'green'}}>Request feito com sucesso!</p>
                    :
                    <p style={{color: 'red'}}>Request falhou...</p>
                :
                null
            } 
            <div>
                <div>
                    <h2>Adicionar disciplina</h2>
                    <p>Código</p>
                    <input onChange={e => updNewCourse({...newCourse, codigo: e.target.value})}/>
                    <p>Nome</p>
                    <input onChange={e => updNewCourse({...newCourse, nome: e.target.value})}/>
                    <p>Créditos-aula</p>
                    <input type="number" onChange={e => updNewCourse({...newCourse, 'creditos_aula': Number(e.target.value)})}/>
                    <p>Créditos-trabalho</p>
                    <input type="number" onChange={e => updNewCourse({...newCourse, 'creditos_trabalho': Number(e.target.value)})}/>
                    <p>Instituto</p>
                    <input onChange={e => updNewCourse({...newCourse, instituto: e.target.value})}/>
                    <br/>
                    <button onClick={addCourse}>Adicionar disciplina</button>
                </div>
                <div>
                    <h2>Atualizar disciplina</h2>
                    <p>Código</p>
                    <input onChange={e => updUpdateCourse({...updateCourse, codigo: e.target.value})} />
                    <p>Nome</p>
                    <input onChange={e => updUpdateCourse({...updateCourse, nome: e.target.value})} />
                    <p>Créditos-aula</p>
                    <input type="number" onChange={e => updUpdateCourse({...updateCourse, 'creditos_aula': Number(e.target.value)})} />
                    <p>Créditos-trabalho</p>
                    <input type="number" onChange={e => updUpdateCourse({...updateCourse, 'creditos_trabalho': Number(e.target.value)})} />
                    <p>Instituto</p>
                    <input onChange={e => updUpdateCourse({...updateCourse, instituto: e.target.value})} />
                    <br/>
                    <button onClick={updCourse}>Atualizar disciplina</button>
                </div>
                <div>
                    <h2>Adicionar trilha</h2>
                    <p>Nome</p>
                    <input onChange={e => updNewTrilha({...newTrilha, nome: e.target.value})} />
                    <p>Descrição</p>
                    <input onChange={e => updNewTrilha({...newTrilha, descricao: e.target.value})} />
                    <p>Quantidade de módulos</p>
                    <input type="number" onChange={e => updNewTrilha({...newTrilha, 'quant_mod': Number(e.target.value)})} />
                    <br/>
                    <button onClick={addTrilha}>Adicionar trilha</button>
                </div>
                <div>
                    <h2>Atualizar trilha</h2>
                    <p>Nome</p>
                    <input onChange={e => updUpdateTrilha({...updateTrilha, nome: e.target.value})} />
                    <p>Descrição</p>
                    <input onChange={e => updUpdateTrilha({...updateTrilha, descricao: e.target.value})} />
                    <p>Quantidade de módulos</p>
                    <input type="number" onChange={e => updUpdateTrilha({...updateTrilha, 'quant_mod': Number(e.target.value)})} />
                    <br/>
                    <button onClick={updTrilha}>Atualizar trilha</button>
                </div>
            </div>

            <hr/>

            <div>
                <div>
                    <h2>Criar usuário</h2>
                    <p>Login</p>
                    <input onChange={e => changeUsuario({...usuario, login: e.target.value})} />
                    <p>Senha</p>
                    <input type="password" onChange={e => changeUsuario({...usuario, senha: e.target.value})} />
                    <p>Email</p>
                    <input onChange={e => changeUsuario({...usuario, email: e.target.value})} />
                    <br/>
                    <button onClick={createUser}>Criar usuário</button>
                </div>
                <div>
                    <h2>Remover usuário</h2>
                    <select style={{marginTop: 10}} onChange={e => changeUserToRemove(e.target.value)}>
                        <option disabled selected value>Escolha um usuário</option>
                        {usuarios.map(u => <option value={u.login}>{u.login}</option>)}
                    </select>
                    <br/>
                    <button onClick={removeUser}>Remover usuário</button>
                </div>
            </div>

            <hr/>

            <Role>
                <h1>Criar perfil</h1>

                <div>
                    <span>Papel: </span>
                    <input type="text" onChange={e => changeProfile({...profile, papel: e.target.value})} />
                </div>
                
                <div style={{marginTop: 0}}>
                    <span>Descrição: </span>
                    <input type="text" onChange={e => changeProfile({...profile, descricao: e.target.value})} />
                </div>

                <Center style={{marginTop: 0}}>
                    <button onClick={createProfile}>Criar perfil</button>
                </Center>
            </Role>

            <hr/>

            <Flex>
                <h1>Vincular perfil à serviço</h1>
                <p>Esolha um perfil</p>
                <select onChange={e => changePerfilServico({...perfilServico, perfil: e.target.value})}>
                    <option disabled selected value>Escolha um perfil</option>
                    {perfis.map(p => <option value={p.papel}>{p.papel}</option>)}
                </select>
                {Object.keys(servicos).map(id => {
                    if (typeof servicos[id] === 'object') {
                        const st = {marginTop: id === '0' ? 24 : 0}
                        return (
                            <Center key={id} style={st}>
                                <input type="checkbox" onClick={e => changePerfilServico({...perfilServico, [servicos[id].tipo]: e.target.checked})} />
                                <span>{servicos[id].tipo}:&nbsp;&nbsp;</span>
                                <span>{servicos[id].descricao}</span> 
                            </Center>
                        )
                    }
                })}
                <button onClick={vincular}>Vincular</button>
            </Flex>

            
        </Container>
    )
}

export default Adm