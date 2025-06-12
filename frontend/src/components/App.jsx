import {BrowserRouter as Router, Routes, Route} from 'react-router-dom'
import { useState } from 'react'
import Login from './Login'
import Dashboard from './Dashboard'
import AddLostItem from './AddLostItem'
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
                <Route
                    path="/add"
                    element={
                        <ProtectedRoute isAuthenticated={!!adminInfo}>
                            <AddLostItem adminInfo={adminInfo} />
                        </ProtectedRoute>
                    }
                />
                <Route
                    path="/edit"
                    element={
                        <ProtectedRoute isAuthenticated={!!adminInfo}>
                            <div style={{ padding: '1rem' }}>
                                <h2>Edit Lost Item (Coming Soon)</h2>
                            </div>
                        </ProtectedRoute>
                    }
                />
                <Route
                    path="/reports"
                    element={
                        <ProtectedRoute isAuthenticated={!!adminInfo}>
                            <div style={{ padding: '1rem' }}>
                                <h2>Reports View (Coming Soon)</h2>
                            </div>
                        </ProtectedRoute>
                    }
                />
                <Route
                    path="/summary"
                    element={
                        <ProtectedRoute isAuthenticated={!!adminInfo}>
                            <div style={{ padding: '1rem' }}>
                                <h2>Summary View (Coming Soon)</h2>
                            </div>
                        </ProtectedRoute>
                    }
                />
            </Routes>
        </Router>
    );
}
export default App
