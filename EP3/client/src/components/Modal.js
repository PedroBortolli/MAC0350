import React from 'react'
import Modal from 'react-modal'
import styled from 'styled-components'
import './styles/Modal.scss'

const Close = styled.div`
    position: absolute;
    right: 10px;
    top: 4px;
    cursor: pointer;
`
const Title = styled.div`
    padding-top: 6px;
    text-align: center;
    font-weight: 900;
    font-size: 20px;
`
const Info = styled.div`
    padding: 24 0 24 12;    
`
const Selector = styled.div`
    padding: 0 16 0 16;
    display: flex;
    justify-content: space-between;
    > div {
        font-size: 18px;
        font-weight: 900;
        cursor: pointer;
        transition: transform 0.1s;
        :nth-child(1) {color: #1028a1}
        :nth-child(2) {color: #a3892c}
        :nth-child(3) {color: #268c08}
        :hover {transform: scale(1.3)}
    }
`
const Center = styled.div`
    width: 100%;
    text-align: center;
`
const Course = styled.p`
    > span {
        :nth-child(1) {
            width: 320px;
            text-align: center;
        }
        :nth-child(2) {
            position: absolute;
            right: 20px;
            cursor: pointer;
        }
    }
`

Modal.setAppElement('#root')

function CustomModal({close, info, addCurrent, remove, addScheduled, addDone, scheduled, done}) {
    let actions = null
    const performAction = (fun, course) => {
        if (!course) course = info.course
        fun(course)
        if (info.status === 'available') close()
    }

    switch(info.status) {
        case 'available':
            actions = (
                <Selector>
                    <div onClick={() => performAction(addCurrent)}>Cursar</div>
                    <div onClick={() => performAction(addScheduled)}>Planejar</div>
                    <div onClick={() => performAction(addDone)}>Feito</div>
                </Selector>
            )
            break
        case 'current':
            actions = (
                <Selector>
                    <div onClick={() => performAction(remove)} style={{color: 'red'}}>Remover</div>
                    <div onClick={() => performAction(addScheduled)}>Planejar</div>
                    <div onClick={() => performAction(addDone)}>Feito</div>
                </Selector>
            )
            break
        default:
            break
    }

    return (
        <Modal className="custom-modal" isOpen>
            <Close onClick={close}>x</Close>
            {info.type === 'default' ?
                <div>
                    <Title>
                        {info.course.codigo} - {info.course.titulo}
                    </Title>
                    <Info>
                        <p>Disciplina <b>{info.course.categoria || 'obrigatória'}</b></p>
                        <p>Créditos-aula: <b>{info.course.ca || 4}</b></p>
                        <p>Créditos-trabalho: <b>{info.course.ct || 2}</b></p>
                    </Info>
                    {actions}
                </div>
                :
                <div>
                    <Title>Matérias {info.type}</Title>
                    {info.type === 'feitas' ?
                        <Info>
                            {!done.length && <Center>Nenhuma matéria feita</Center>}
                            {done.map(course => {
                                return <Course>
                                    <span><b>{course.codigo}</b> - {course.titulo}</span>
                                    <span onClick={() => performAction(remove, course)}>x</span>
                                </Course>
                            })}
                        </Info>
                        :
                        <Info>
                            {!scheduled.length && <Center>Nenhuma matéria planejada</Center>}
                            {scheduled.map(course => {
                                return <Course>
                                    <span><b>{course.codigo}</b> - {course.titulo}</span>
                                    <span onClick={() => performAction(remove, course)}>x</span>
                                </Course>
                            })}
                        </Info>
                    }
                </div>
            }
        </Modal>
    )
}

export default CustomModal