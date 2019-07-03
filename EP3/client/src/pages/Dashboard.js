import React, {useState} from 'react'
import styled from 'styled-components'
import Card from '../components/Card'
import Progress from '../components/Progress'
import useScreenSize from '../hooks/useScreenSize'

const Container = styled.div`
    padding-top: 60px;
    display: flex;
    flex-direction: column;
    width: 100%;
    align-items: center;
    justify-content: center;
    > * h1 {
        padding-left: 16px;
        color: #074bb8;
    }
`
const Wrapper = styled.div`
    padding-top: 16px;
    display: flex;
`
const CardsContainer = styled.div`
    display: grid;
    grid-template-columns: repeat(${props => props.columns}, 225px);
    grid-column-gap: 32px;
    grid-row-gap: 32px;
`
const AvailableCourses = styled.div`
    padding-right: 40px;
    > div {
        padding-top: 8px;
    }
    > h1 {
        display: ${props => props.columns <= 2 ? 'block' : 'inline-block'};
    }
    > input {
        margin-left: ${props => props.columns <= 2 ? '14px' : '48px'};
        margin-bottom: ${props => props.columns <= 2 ? '24px' : '0px'};
        height: 30px;
        font-size: 16px;
        padding-top: 4px;
        width: 240px;
    }
`
const CurrentCourses = styled.div`
    display: flex;
    flex-direction: column;
    width: 265px;
    > div {
        flex: 1;
        border-left: 2px solid rgb(0, 0, 0, 0.25);
        padding: 8 0 0 40;
        
        > div {
            margin-bottom: 32px;
        }
    }
`

function Dashboard() {
    const [selected, changeSelected] = useState([])
    const [filter, changeFilter] = useState(null)
    const [width] = useScreenSize()
    const addCourse = (course) => changeSelected([...selected, course])
    const temp = [{code: 'MAC0329', title:	'Álgebra Booleana e Aplicações no Projeto de Arquitetura de Computadores'}, {code: 'MAC0450', title:	'Algoritmos de Aproximação'}, {code: 'MAC0430', title:	'Algoritmos e Complexidade de Computação'}, {code: 'MAC0121', title:	'Algoritmos e Estruturas de Dados I'}, {code: 'MAC0323', title:	'Algoritmos e Estruturas de Dados II'}, {code: 'MAC0351', title:	'Algoritmos em Bioinformática'}, {code: 'MAC0328', title:	'Algoritmos em Grafos'}, {code: 'MAC0338', title:	'Análise de Algoritmos'}, {code: 'MAC0447', title:	'Análise e Reconhecimento de Formas: Teoria e Prática'}, {code: 'MAC0333', title:	'Armazenamento e Recuperação de Informação'}, {code: 'MAC0344', title:	'Arquitetura de Computadores'}, {code: 'MAC0213', title:	'Atividade Curricular em Comunidade'}, {code: 'MAC0214', title:	'Atividade Curricular em Cultura e Extensão'}, {code: 'MAC0215', title:	'Atividade Curricular em Pesquisa'}, {code: 'MAC0414', title:	'Autômatos, Computabilidade e Complexidade'}, {code: 'MAC0465', title:	'Biologia Computacional'}, {code: 'MAC0375', title:	'Biologia de Sistemas'}, {code: 'MAC0102', title:	'Caminhos no Bacharelado em Ciência da Computação'}, {code: 'MAC0459', title:	'Ciência e Engenharia de Dados'}, {code: 'MAC0463', title:	'Computação Móvel'}, {code: 'MAC0337', title:	'Computação Musical'}, {code: 'MAC0326', title:	'Computação, Cibernética e Sistemas Cognitivos.'}, {code: 'MAC0316', title:	'Conceitos Fundamentais de Linguagens de Programação'}, {code: 'MAC0469', title:	'Construção de Software como Serviço em Computação em Nuvem'}, {code: 'MAC0336', title:	'Criptografia para Segurança de Dados'}]
    const columns = Math.min(Math.floor((width-330)/270), 3)

    const filtered = (course) => {
        if (!filter) return true
        if (course.code.toLowerCase().indexOf(filter.toLowerCase()) > -1) return true
        if (course.title.toLowerCase().indexOf(filter.toLowerCase()) > -1) return true
        return false
    }

    return (
        <Container>
            <Progress title="Obrigatórias" done={111} total={111} color="green" />
            <Progress title="Eletivas" done={40} total={52} color="blue" />
            <Progress title="Livres" done={6} total={24} color="orange" />

            <Wrapper>
                <AvailableCourses columns={columns}>
                    <h1>Matérias disponíveis</h1>
                    <input placeholder="Procure uma disciplina..." onChange={e => changeFilter(e.target.value)} />
                    <CardsContainer columns={columns}>
                        {temp.map(course => {
                            if (selected.some(c => c.code === course.code) || !filtered(course)) return null
                            return <Card course={course} addCourse={addCourse} />
                        })}
                    </CardsContainer>
                </AvailableCourses>
                <CurrentCourses>
                    <h1>Cursando</h1>
                    <div>
                        {selected.length ?
                            selected.map(course => <Card course={course} />)
                            :
                            <div style={{fontSize: 18}}>
                                <p>Você não está cursando nenhuma matéria.</p>
                                <p>Para adicionar, clique em disciplinas no menu ao lado.</p>
                            </div>
                        }
                    </div>
                </CurrentCourses>
            </Wrapper>
        </Container>
    )
}

export default Dashboard