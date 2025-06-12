import "../styles/Sidebar.css";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Link, useNavigate } from "react-router-dom";
import { faArrowLeft } from "@fortawesome/free-solid-svg-icons";

function Sidebar({ collapsed, setCollapsed, setAdminInfo }) {
  const navigate = useNavigate();

  const handleLogout = async () => {
    setAdminInfo(null);
    navigate("/");
  };

  return (
    <div className={`sidebar ${collapsed ? "collapsed" : ""}`}>
      <div className="sidebar-content">
        <div className="sidebar-header">
          <h2 className="sidebar-title">Dashboard</h2>
          <button
            className="collapse-toggle"
            onClick={() => setCollapsed(!collapsed)}
          >
            <FontAwesomeIcon
              className={`collapse-arrow ${collapsed ? "rotated" : ""}`}
              icon={faArrowLeft}
            />
          </button>
        </div>
        <ul className="sidebar-nav">
          <li><Link to="/dashboard">Home</Link></li>
          <li><Link to="/add">Add Lost Item</Link></li>
          <li><Link to="/edit">Edit Lost Item</Link></li>
          <li><Link to="/reports">View Reports</Link></li>
          <li><Link to="/summary">Summary</Link></li>
        </ul>
      </div>

      <button className="logout-button" onClick={handleLogout}>
        Logout
      </button>
    </div>
  );
}

export default Sidebar;
