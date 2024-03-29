import React from 'react'
import ReactDOM from 'react-dom'
import Header from './components/Header'
import Home from './pages/Home'
import Dashboard from './pages/Dashboard'
import Login from './pages/Login'
import Adm from './pages/Adm'
import User from './pages/User'
import NotFound from './pages/NotFound'
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom'

const routing = (
    <Router>
        <Header />
        <Switch>
            <Route exact path="/" component={Home} />
            <Route path="/dashboard" component={Dashboard} />
            <Route path="/login" component={Login} />
            <Route path="/adm" component={Adm} />
            <Route path="/user" component={User} />
            <Route component={NotFound} />
        </Switch>
    </Router>
)

ReactDOM.render(routing, document.getElementById('root'))