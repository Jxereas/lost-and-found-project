import React, { useState } from 'react';
import '../styles/Login.css'
import {useNavigate} from 'react-router-dom'

function Login({ setAdminInfo, adminInfo }) {
  const navigate = useNavigate()
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  const handleLogin = async () => {
    try {
      const response = await fetch('http://localhost:8000/api/login/', {
        method: 'POST',
        credentials: 'include',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ username, password }),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || 'Login failed');
      }

      setAdminInfo(data);
      localStorage.setItem("adminInfo", JSON.stringify(data));

      setError('');
      navigate('/dashboard')
    } catch (err) {
      setError(err.message);
      setAdminInfo(null);
    }
  };

  return (
    <div className='login-container'>
      <div className='login-card'>
        <h2>Admin Login</h2>
        <input
          placeholder="Username"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
          className='login-input'
        />
        <input
          placeholder="Password"
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          className='login-input'
        />
        <button onClick={handleLogin} className='login-button'>
          Login
        </button>

        {error && <p className='login-error'>{error}</p>}

        {adminInfo && (
          <div className='login-welcome'>
            <h3>Welcome!</h3>
            <p>ID: {adminInfo.id}</p>
            {Object.entries(adminInfo.person || {}).map(([key, value]) => (
              <p key={key}><strong>{key}:</strong> {value}</p>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}

export default Login;
