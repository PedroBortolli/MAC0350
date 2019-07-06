import React, { useEffect, useState } from 'react'
import styled from 'styled-components'
import Card from '../components/Card'
import Progress from '../components/Progress'
import useScreenSize from '../hooks/useScreenSize'
import Modal from '../components/Modal'
import fetchApi from '../utils/fetchApi'
import loadingGif from '../assets/loading.gif'

const Container = styled.div`
    padding-top: 76px;
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
const Courses = styled.div`
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding-top: 24px;
    > h2 {
        color: #074bb8;
        text-align: center;
        margin: 10 0 0 0;
        cursor: pointer;
    }
`
const Wrapper = styled.div`
    padding-top: 24px;
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
        padding-left: 4px;
        width: 240px;
        ::-webkit-input-placeholder {text-align: center}
        :-moz-placeholder {text-align: center}
        ::-moz-placeholder {text-align: center}
        :-ms-input-placeholder {text-align: center}
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
    const [courses, setCourses] = useState([])
    const [currentCourses, changeCurrentCourses] = useState([])
    const [scheduledCourses, changeScheduledCourses] = useState([])
    const [doneCourses, changeDoneCourses] = useState([])
    const [filter, changeFilter] = useState(null)
    const [modalInfo, changeModal] = useState({open: false})
    const [width] = useScreenSize()
    const columns = Math.min(Math.floor((width-330)/270), 3)

    useEffect(() => {
        const fetchDisciplinas = async () => {
            setCourses((await fetchApi('GET', 'http://localhost:5000/api/disciplinas')).data)
        }

        const session = sessionStorage.getItem('auth')
        if (!session) window.location = '/login'
        else fetchDisciplinas()
    }, [])

    const display = (course) => {
        if (currentCourses.some(c => c.codigo === course.codigo) ||
            doneCourses.some(c => c.codigo === course.codigo) ||
            scheduledCourses.some(c => c.codigo === course.codigo)) return false
        if (!filter || course.codigo.toLowerCase().indexOf(filter.toLowerCase()) > -1 ||
            course.titulo.toLowerCase().indexOf(filter.toLowerCase()) > -1) return true
        return false
    }

    const addCurrent = (course) => changeCurrentCourses([...currentCourses, course])
    const addScheduled = (course) => changeScheduledCourses([...scheduledCourses, course])
    const addDone = (course) => changeDoneCourses([...doneCourses, course])
    const removeCourse = (course) => {
        if (currentCourses.some(c => c.codigo === course.codigo)) {
            let pos = currentCourses.findIndex(c => c.codigo === course.codigo)
            changeCurrentCourses([...currentCourses.slice(0, pos), ...currentCourses.slice(pos+1, currentCourses.length)])
        }
        if (doneCourses.some(c => c.codigo === course.codigo)) {
            let pos = doneCourses.findIndex(c => c.codigo === course.codigo)
            changeDoneCourses([...doneCourses.slice(0, pos), ...doneCourses.slice(pos+1, doneCourses.length)])
        }
        if (scheduledCourses.some(c => c.codigo === course.codigo)) {
            let pos = scheduledCourses.findIndex(c => c.codigo === course.codigo)
            changeScheduledCourses([...scheduledCourses.slice(0, pos), ...scheduledCourses.slice(pos+1, scheduledCourses.length)])
        }
    }

    // TODO: functions below properly
    const obg = doneCourses.length * 6
    const ele = doneCourses.length * 4
    const liv = doneCourses.length * 2
    return (
        !courses.length ?
        <Container><img alt="" src={loadingGif} width={120} height={120} /></Container>
        :
        <Container style={{opacity: modalInfo.open ? 0.25 : 1}}>
            <Progress title="Obrigatórias" done={obg} total={111} color="green" />
            <Progress title="Eletivas" done={ele} total={52} color="blue" />
            <Progress title="Livres" done={liv} total={24} color="orange" />

            <Courses>
                <h2 onClick={() => changeModal({open: true, type: 'feitas'})}>Matérias feitas ({doneCourses.length})</h2>
                <h2 onClick={() => changeModal({open: true, type: 'planejadas'})}>Matérias planejadas ({scheduledCourses.length})</h2>
            </Courses>

            <Wrapper>
                <AvailableCourses columns={columns}>
                    <h1>Matérias disponíveis</h1>
                    <input placeholder="Procure por uma disciplina..." onChange={e => changeFilter(e.target.value)} />
                    <CardsContainer columns={columns}>
                        {courses.map(course => {
                            if (!display(course)) return null
                            return <Card key={course.codigo} course={course} status="available" set={changeModal}  />
                        })}
                    </CardsContainer>
                </AvailableCourses>
                <CurrentCourses>
                    <h1>Cursando</h1>
                    <div>
                        {currentCourses.length ?
                            currentCourses.map(course => <Card course={course} status="current" set={changeModal} />)
                            :
                            <div style={{fontSize: 18}}>
                                <p>Você não está cursando nenhuma matéria.</p>
                                <p>Para adicionar, clique em disciplinas no menu ao lado.</p>
                            </div>
                        }
                    </div>
                </CurrentCourses>
            </Wrapper>

            {modalInfo.open && 
                <Modal close={() => changeModal({open: false})} info={modalInfo} remove={removeCourse}
                    addCurrent={addCurrent} addScheduled={addScheduled} addDone={addDone} 
                    scheduled={scheduledCourses} done={doneCourses}
                />
            }
        </Container>
    )
}

export default Dashboard