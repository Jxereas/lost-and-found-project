import "../styles/Sidebar.css";
import { useNavigate } from "react-router-dom";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
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
          <li>Home</li>
          <li>Add Lost Item</li>
          <li>Edit Lost Item</li>
          <li>View Reports</li>
          <li>Summary</li>
        </ul>
      </div>

      <button className="logout-button" onClick={handleLogout}>
        Logout
      </button>
    </div>
  );
}

export default Sidebar;
