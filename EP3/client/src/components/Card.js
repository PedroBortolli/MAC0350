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
    transition: transform 0.15s;
    > div {
        display: flex;
        justify-content: center;
    }
    :hover {
        transform: scale(1.15);
        cursor: pointer;
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

function Card({course, addCourse}) {
    return (
        <Course onClick={() => addCourse(course)}>
            <Code>{course.code}</Code>
            <Name>{course.title}</Name>
            <CA>+4 CA</CA>
            <CT>+2 CT</CT>
        </Course>
    )
}

export default Card