import {BrowserRouter as Router, Routes, Route} from 'react-router-dom'
import { useState } from 'react'
import Login from './Login'
import Dashboard from './Dashboard'
import ProtectedRoute from '../ProtectedRoute'
import EditForm from './EditForm'

function App() {
    const [adminInfo, setAdminInfo] = useState(() => {
        const saved = localStorage.getItem("adminInfo");
        return saved ? JSON.parse(saved) : null;
    });


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
                <Route
                    path="/edit-item"
                    element={
                        <ProtectedRoute isAuthenticated={!!adminInfo}>
                            <EditForm adminInfo={adminInfo} />
                        </ProtectedRoute>
                    }
                />
            </Routes>
        </Router>
    )
}

export default App
