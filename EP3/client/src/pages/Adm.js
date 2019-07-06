import React from 'react'
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
    return (
        <Container>
            <h1>Administrar sistema</h1>
            <div>
                <div>
                    <h2>Adicionar disciplina</h2>
                    <p>Sigla</p>
                    <input />
                    <p>Nome</p>
                    <input />
                    <p>Créditos-aula</p>
                    <input />
                    <p>Créditos-trabalho</p>
                    <input />
                    <br/>
                    <button>Adicionar disciplina</button>
                </div>
                <div>
                    <h2>Atualizar disciplina</h2>
                    <p>Sigla</p>
                    <input />
                    <p>Nova sigla</p>
                    <input />
                    <p>Novo nome</p>
                    <input />
                    <p>Novo créditos-aula</p>
                    <input />
                    <p>Novo créditos-trabalho</p>
                    <input />
                    <br/>
                    <button>Atualizar disciplina</button>
                </div>
                <div>
                    <h2>Adicionar trilha</h2>
                    <p>Nome</p>
                    <input />
                    <p>Quantidade de disciplinas</p>
                    <input />
                    <br/>
                    <button>Adicionar trilha</button>
                </div>
                <div>
                    <h2>Atualizar trilha</h2>
                    <p>Nome</p>
                    <input />
                    <p>Novo nome</p>
                    <input />
                    <p>Quantidade de disciplinas</p>
                    <input />
                    <br/>
                    <button>Atualizar trilha</button>
                </div>
            </div>
        </Container>
    )
}

export default Adm