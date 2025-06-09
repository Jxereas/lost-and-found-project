import {BrowserRouter as Router, Routes, Route} from 'react-router-dom'
import { useState } from 'react'
import Login from './Login'
import Dashboard from './Dashboard'
import ProtectedRoute from '../ProtectedRoute'

function App() {
    const [adminInfo, setAdminInfo] = useState(null)

    return (
        <Router>
            <Routes>
                <Route path="/" element={<Login setAdminInfo={setAdminInfo} adminInfo={adminInfo} />} />
                <Route path="/dashboard"
                    element={
                        <ProtectedRoute isAuthenticated={!!adminInfo}>
                            <Dashboard setAdminInfo={setAdminInfo} adminInfo={adminInfo}/>
                        </ProtectedRoute>
                    }
                />
            </Routes>
        </Router>
    )
}

export default App
