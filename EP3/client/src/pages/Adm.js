import React, {useState} from 'react'
import styled from 'styled-components'

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
`

function Adm() {
    const [newCourse, updNewCourse] = useState({})
    const [updateCourse, updUpdateCourse] = useState({})
    const [newTrilha, updNewTrilha] = useState({})
    const [updateTrilha, updUpdateTrilha] = useState({})

    const addCourse = () => {
        // TODO - api request
        console.log("Adicionando disciplina: ", newCourse)
    }
    const updCourse = () => {
        // TODO - api request
        console.log("Atualizando disciplina: ", updateCourse)
    }
    const addTrilha = () => {
        // TODO - api request
        console.log("Adicionando trilha: ", newTrilha)
    }
    const updTrilha = () => {
        // TODO - api request
        console.log("Atualizando trilha: ", updateTrilha)
    }

    return (
        <Container>
            <h1>Administrar sistema</h1>
            <div>
                <div>
                    <h2>Adicionar disciplina</h2>
                    <p>Sigla</p>
                    <input onChange={e => updNewCourse({...newCourse, sigla: e.target.value})}/>
                    <p>Nome</p>
                    <input onChange={e => updNewCourse({...newCourse, nome: e.target.value})}/>
                    <p>Créditos-aula</p>
                    <input type="number" onChange={e => updNewCourse({...newCourse, creditosAula: Number(e.target.value)})}/>
                    <p>Créditos-trabalho</p>
                    <input type="number" onChange={e => updNewCourse({...newCourse, creditosTrabalho: Number(e.target.value)})}/>
                    <br/>
                    <button onClick={addCourse}>Adicionar disciplina</button>
                </div>
                <div>
                    <h2>Atualizar disciplina</h2>
                    <p>Sigla</p>
                    <input onChange={e => updUpdateCourse({...updateCourse, sigla: e.target.value})} />
                    <p>Nova sigla</p>
                    <input onChange={e => updUpdateCourse({...updateCourse, novaSigla: e.target.value})} />
                    <p>Novo nome</p>
                    <input onChange={e => updUpdateCourse({...updateCourse, novoNome: e.target.value})} />
                    <p>Novo créditos-aula</p>
                    <input type="number" onChange={e => updUpdateCourse({...updateCourse, novoCreditosAula: Number(e.target.value)})} />
                    <p>Novo créditos-trabalho</p>
                    <input type="number" onChange={e => updUpdateCourse({...updateCourse, novoCreditosTrabalho: Number(e.target.value)})} />
                    <br/>
                    <button onClick={updCourse}>Atualizar disciplina</button>
                </div>
                <div>
                    <h2>Adicionar trilha</h2>
                    <p>Nome</p>
                    <input onChange={e => updNewTrilha({...newTrilha, nome: e.target.value})} />
                    <p>Quantidade de disciplinas</p>
                    <input type="number" onChange={e => updNewTrilha({...newTrilha, qntdDisciplinas: Number(e.target.value)})} />
                    <br/>
                    <button onClick={addTrilha}>Adicionar trilha</button>
                </div>
                <div>
                    <h2>Atualizar trilha</h2>
                    <p>Nome</p>
                    <input onChange={e => updUpdateTrilha({...updateTrilha, nome: e.target.value})} />
                    <p>Novo nome</p>
                    <input onChange={e => updUpdateTrilha({...updateTrilha, novoNome: e.target.value})} />
                    <p>Quantidade de disciplinas</p>
                    <input onChange={e => updUpdateTrilha({...updateTrilha, novaQntdDisciplinas: Number(e.target.value)})} />
                    <br/>
                    <button onClick={updTrilha}>Atualizar trilha</button>
                </div>
            </div>
        </Container>
    )
}

export default Adm