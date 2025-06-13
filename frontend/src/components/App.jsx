import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import { useState } from "react";
import Login from "./Login";
import Dashboard from "./Dashboard";
import SearchLostItems from "./SearchLostItems";
import SearchLostItemsResults from "./SearchLostItemsResults";
import TagManagement from "./TagManagement";
import AddLostItems from "./AddLostItems";
import EditLostItems from "./EditLostItems";
import ProtectedRoute from "../ProtectedRoute";

function App() {
  const [adminInfo, setAdminInfo] = useState(null);

  return (
    <Router>
      <Routes>
        <Route
          path="/"
          element={<Login setAdminInfo={setAdminInfo} adminInfo={adminInfo} />}
        />
        <Route
          path="/dashboard"
          element={
            <ProtectedRoute isAuthenticated={!!adminInfo}>
              <Dashboard setAdminInfo={setAdminInfo} adminInfo={adminInfo} />
            </ProtectedRoute>
          }
        />
        <Route
          path="/lost-items-search"
          element={
            <ProtectedRoute isAuthenticated={!!adminInfo}>
              <SearchLostItems
                setAdminInfo={setAdminInfo}
                adminInfo={adminInfo}
              />
            </ProtectedRoute>
          }
        />
        <Route
          path="/lost-items-search-results"
          element={
            <ProtectedRoute isAuthenticated={!!adminInfo}>
              <SearchLostItemsResults
                setAdminInfo={setAdminInfo}
                adminInfo={adminInfo}
              />
            </ProtectedRoute>
          }
        />
        <Route
          path="/tag-management"
          element={
            <ProtectedRoute isAuthenticated={!!adminInfo}>
              <TagManagement setAdminInfo={setAdminInfo}/>
            </ProtectedRoute>
          }
        />
        <Route
          path="/lost-items-add"
          element={
            <ProtectedRoute isAuthenticated={!!adminInfo}>
              <AddLostItems adminInfo={adminInfo} setAdminInfo={setAdminInfo}/>
            </ProtectedRoute>
          }
        />
        <Route
          path="/lost-items-edit"
          element={
            <ProtectedRoute isAuthenticated={!!adminInfo}>
              <EditLostItems adminInfo={adminInfo} setAdminInfo={setAdminInfo}/>
            </ProtectedRoute>
          }
        />
      </Routes>
    </Router>
  );
}

export default App;
