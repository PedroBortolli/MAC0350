import React, {useState} from 'react'
import styled from 'styled-components'

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
    const [oldPassword, changeOldPassword] = useState(null)
    const [newPassword, changeNewPassword] = useState(null)
    const [newPasswordCheck, changeNewPasswordCheck] = useState(null)
    const [oldEmail, changeOldEmail] = useState(null)
    const [newEmail, changeNewEmail] = useState(null)
    const [newEmailCheck, changeNewEmailCheck] = useState(null)
    const [perfil, changePerfil] = useState(null)
    const [description, changeDescription] = useState(null)
    return (
        <Container>
            <h1>Perfil</h1>
            <Info>
                <div>
                    <span>Senha antiga</span>
                    <input type="text" onChange={e => changeOldPassword(e.target.value)} />
                    <span>Senha nova</span>
                    <input type="text" onChange={e => changeNewPassword(e.target.value)} />
                    <span>Confirme a senha nova</span>
                    <input type="text" onChange={e => changeNewPasswordCheck(e.target.value)} />
                    <button>Atualizar senha</button>
                </div>
                <div>
                    <span>E-mail antigo</span>
                    <input type="text" onChange={e => changeOldEmail(e.target.value)} />
                    <span>E-mail novo</span>
                    <input type="text" onChange={e => changeNewEmail(e.target.value)} />
                    <span>Confirme o e-mail novo</span>
                    <input type="text" onChange={e => changeNewEmailCheck(e.target.value)} />
                    <button>Atualizar e-mail</button>
                </div>
            </Info>

            <Role>
                <h1>Criar perfil</h1>

                <div>
                    <span>Nome do perfil: </span>
                    <input type="text" onChange={e => changePerfil(e.target.value)} />
                </div>
                
                <div>
                    <span>Descrição: </span>
                    <input type="text" onChange={e => changeDescription(e.target.value)} style={{marginLeft: 45.8}} />
                </div>

                <Center style={{marginTop: 32}}>
                    <input type="checkbox" />
                    <span>Modificar disciplina</span>
                </Center>

                <Center>
                    <input type="checkbox" />
                    <span>Remover usuário</span>
                </Center>

                <Center>
                    <input type="checkbox" />
                    <span>Modificar disciplina</span>
                </Center>
                
                
                <Center style={{marginTop: 32}}>
                <button>Criar perfil</button>
                </Center>
            </Role>
        </Container>
    )
}

export default Profile