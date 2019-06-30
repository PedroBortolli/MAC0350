import React from 'react'
import styled from 'styled-components'

const Course = styled.div`
    display: grid;
    grid-template-columns: 75px 75px 75px;
    grid-template-rows: auto;
    grid-template-areas: "code  code  code"
                         "name  name  name"
                         "ca  .  ct";
    border: 1px solid rgb(0, 0, 0, 0.25);
    border-radius: 8px;
    > div {
        display: flex;
        justify-content: center;
    }
`
const Code = styled.div`
    grid-area: code;
    font-size: 20px;
    font-weight: 900;
`
const Name = styled.div`
    grid-area: name;
    text-align: center;
    padding: 6px;
    font-size: 12px;
`
const CA = styled.div`
    grid-area: ca;
    color: #068049;
`
const CT = styled.div`
    grid-area: ct;
    color: #4298f5;
`

function Card({code, title, addCourse}) {
    return (
        <Course onClick={() => addCourse(code)}>
            <Code>{code}</Code>
            <Name>{title}</Name>
            <CA>+4 CA</CA>
            <CT>+2 CT</CT>
        </Course>
    )
}

export default Card