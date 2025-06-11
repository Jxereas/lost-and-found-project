import React, { useState } from 'react';
import '../styles/Sidebar.css';
import {useNavigate} from 'react-router-dom'

function Sidebar({collapsed, setCollapsed, setAdminInfo}) {
    const navigate = useNavigate()

    const handleLogout = async () => {
        setAdminInfo(null)
        navigate('/')
    }

    return (
    <div className={`sidebar ${collapsed ? 'collapsed' : ''}`}>
      <div className="sidebar-content">
        <button className="collapse-toggle" onClick={() => setCollapsed(!collapsed)}>
          {collapsed ? '→' : '←'}
        </button>

        <h2 className="sidebar-title">Dashboard</h2>

        <ul className="sidebar-nav">
          <li>Home</li>
          <li>Add Lost Item</li>
          <li>Edit Lost Item</li>
          <li>View Reports</li>
          <li>Summary</li>
        </ul>
      </div>

      <button className="logout-button" onClick={handleLogout}>Logout</button>
    </div>
    )
}

export default Sidebar;
