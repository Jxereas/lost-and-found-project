import React from 'react';
import '../styles/Sidebar.css';
import {useNavigate} from 'react-router-dom'

function Sidebar({setAdminInfo}) {
    const navigate = useNavigate()

    const handleLogout = async () => {
        setAdminInfo(null)
        navigate('/')
    }

    return (
      <div className="sidebar">
      <div className="sidebar-content">
        <h2 className="sidebar-title">Admin Panel</h2>
        <ul className="sidebar-nav">
          <li>Add Lost Item</li>
          <li>Edit Lost Item</li>
          <li>View Lost Items</li>
          <li>Summary</li>
        </ul>
      </div>

      <button className="logout-button" onClick={handleLogout}>
        Logout
      </button>
    </div>
    )
}

export default Sidebar;
