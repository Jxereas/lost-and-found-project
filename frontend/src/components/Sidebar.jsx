import "../styles/Sidebar.css";
import { useNavigate } from "react-router-dom";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faArrowLeft } from "@fortawesome/free-solid-svg-icons";
import { Link } from 'react-router-dom';

function Sidebar({ collapsed, setCollapsed, setAdminInfo }) {
    const navigate = useNavigate();

    const handleLogout = async () => {
        setAdminInfo(null);
        navigate("/");
    };

    const handleSearchLostItemsClick = async () => {
        navigate("/lost-item-search");
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
                    <li>
                        <Link to="/dashboard">Home</Link>
                    </li>
                    <li>
                        <Link to="/add-lost-item">Add Lost Item</Link>
                    </li>
                    <li>
                        <Link to="/edit-lost-item">Edit Lost Item</Link>
                    </li>
                    <li>
                        <Link to="/lost-items-search">Search Lost Items</Link>
                    </li>
                    <li>
                        <Link to="/tag-management">Manage Tags</Link>
                    </li>
                    <li>
                        <Link to="/summary">Summary</Link>
                    </li>
                </ul>
            </div>

            <button className="logout-button" onClick={handleLogout}>
                Logout
            </button>
        </div>
    );
}

export default Sidebar;
