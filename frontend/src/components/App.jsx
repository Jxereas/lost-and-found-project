import {BrowserRouter as Router, Routes, Route} from 'react-router-dom'
import { useState } from 'react'
import Login from './Login'
import ProtectedRoute from '../ProtectedRoute'

function App() {
    const [adminInfo, setAdminInfo] = useState(null)

    return (
        <Router>
            <Routes>
                <Route path="/" element={<Login setAdminInfo={setAdminInfo} adminInfo={adminInfo} />} />
            </Routes>
        </Router>
    )
}

export default App
