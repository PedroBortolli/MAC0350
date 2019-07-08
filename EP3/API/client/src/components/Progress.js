import React from 'react'
import {Line} from 'rc-progress'
import styled from 'styled-components'

const ProgressContainer = styled.div`
    display: grid;
    grid-template-columns: 130px 200px 50px; 
    align-items: center;
    > svg {
        width: 200px;
    }
`
const Title = styled.span`
    text-align: end;
    padding-right: 20px;
    font-size: 22px;
`
const Numbers = styled.span`
    font-size: 22px;
    padding-left: 20px;
`

function Progress({title, done, total, color, stroke = 5}) {
    const percent = (done/total)*100
    return (
        <ProgressContainer>
            <Title>{title}:</Title>
            <Line percent={percent} strokeWidth={stroke} strokeColor={color} />
            <Numbers>{done}/{total}</Numbers>
        </ProgressContainer>
    )
}

export default Progress