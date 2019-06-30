import React, {useState} from 'react'
import styled from 'styled-components'
import Card from '../components/Card'

const Container = styled.div`
    padding-top: 50px;
    display: flex;
    flex-direction: column;
    width: 100%;
    align-items: center;
    justify-content: center;
`
const CardsContainer = styled.div`
    display: grid;
    grid-template-columns: repeat(5, 225px);
    grid-column-gap: 32px;
    grid-row-gap: 32px;
`
const SelectedCourses = styled.div`
    border: 1px solid rgb(0, 0, 0, 0.25);
    width: 400px;
    height: 100px;
    > span {
        padding-right: 20px;
    }
`

function Dashboard() {
    const [selected, changeSelected] = useState([])
    const addCourse = (code) => changeSelected([...selected, code])
    const temp = [{code: 'MAC0329', title:	'Álgebra Booleana e Aplicações no Projeto de Arquitetura de Computadores'}, {code: 'MAC0450', title:	'Algoritmos de Aproximação'}, {code: 'MAC0430', title:	'Algoritmos e Complexidade de Computação'}, {code: 'MAC0121', title:	'Algoritmos e Estruturas de Dados I'}, {code: 'MAC0323', title:	'Algoritmos e Estruturas de Dados II'}, {code: 'MAC0351', title:	'Algoritmos em Bioinformática'}, {code: 'MAC0328', title:	'Algoritmos em Grafos'}, {code: 'MAC0338', title:	'Análise de Algoritmos'}, {code: 'MAC0447', title:	'Análise e Reconhecimento de Formas: Teoria e Prática'}, {code: 'MAC0333', title:	'Armazenamento e Recuperação de Informação'}, {code: 'MAC0344', title:	'Arquitetura de Computadores'}, {code: 'MAC0213', title:	'Atividade Curricular em Comunidade'}, {code: 'MAC0214', title:	'Atividade Curricular em Cultura e Extensão'}, {code: 'MAC0215', title:	'Atividade Curricular em Pesquisa'}, {code: 'MAC0414', title:	'Autômatos, Computabilidade e Complexidade'}, {code: 'MAC0465', title:	'Biologia Computacional'}, {code: 'MAC0375', title:	'Biologia de Sistemas'}, {code: 'MAC0102', title:	'Caminhos no Bacharelado em Ciência da Computação'}, {code: 'MAC0459', title:	'Ciência e Engenharia de Dados'}, {code: 'MAC0463', title:	'Computação Móvel'}, {code: 'MAC0337', title:	'Computação Musical'}, {code: 'MAC0326', title:	'Computação, Cibernética e Sistemas Cognitivos.'}, {code: 'MAC0316', title:	'Conceitos Fundamentais de Linguagens de Programação'}, {code: 'MAC0469', title:	'Construção de Software como Serviço em Computação em Nuvem'}, {code: 'MAC0336', title:	'Criptografia para Segurança de Dados'}]
    return (
        <Container>
            <h1>Matérias selecionadas</h1>
            <SelectedCourses>
                {selected.map(code => <span>{code}</span>)}
            </SelectedCourses>

            <h1>Matérias disponíveis</h1>
            <CardsContainer>
                {temp.map(course => {
                    if (selected.indexOf(course.code) > -1) return null
                    return <Card code={course.code} title={course.title} addCourse={addCourse} />
                })}
            </CardsContainer>
        </Container>
    )
}

export default Dashboard