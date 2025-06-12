import React, { useState } from 'react';
import Sidebar from './Sidebar';
import '../styles/Dashboard.css';

function Dashboard({setAdminInfo, adminInfo }) {
    const [sidebarCollapsed, sidebarSetCollapsed] = useState(false);

    return (
    <div className="dashboard-container">
      <Sidebar setCollapsed = {sidebarSetCollapsed} collapsed={sidebarCollapsed} setAdminInfo={setAdminInfo}/>

      <main className={`dashboard-main ${sidebarCollapsed ? "sidebar-collapsed": ""}`}>
        <h1>Welcome, {adminInfo?.person?.["First Name"]}!</h1>
        <p>This is your admin dashboard landing page.</p>
        <div className="dashboard-landing-card">
          <h3>Quick Overview</h3>
          <p>You can manage lost items using the sidebar.</p>
        </div>
      </main>
    </div>
  );
}

export default Dashboard; 
