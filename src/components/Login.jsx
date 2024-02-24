import React ,{useState}from 'react';
import {Link, useNavigate} from 'react-router-dom'
import {LoginApi} from "../services/auth.api.service"
import './style/LoginPage.css';

const LoginPage = () => {
  const [username, setName]=useState('');
  const[ password, setPassword]=useState('');
  const navigate=useNavigate();
  const [error, setError]=useState('')

  const handleLogin =async(e)=>{
    e.preventDefault();
    try{
      
      const response =await LoginApi(username, password)
     console.log("login successful:" , response)
     const token =response.token;
     localStorage.setItem("token", token)
     navigate(`dashboard/${token}`)
    }
    catch(error){
      console.error("Login faild: ", error);
    }
  }
  return ( 
    <div className="body">
        <div className="login-container">
      <div className="container">
        <form method='post'>
          <div className="form-group">
            <label htmlFor="name">Username:</label>
            <input type="text" className="form-control" id="name" required 
            value={username}
            onChange={(e)=>setName(e.target.value)}/>
          </div>

          <div className="form-group">
            <label htmlFor="password">Password:</label>
            <input type="password" className="form-control" id="password" required 
            value={password}
           onChange={(e)=> setPassword(e.target.value)}/>
          </div>
          <div className="form-group">
            <a href='#'>Forgot password</a>
          </div>
          <p className="mt-3 text-center">
            Don't have an account?{' '}
            <Link to="/register">Register here</Link>
          </p>
          <button type="submit" className="btn btn-primary" onClick={handleLogin}>Login</button>
        </form>
      </div>
    </div>
    </div>
  );
};

export default LoginPage;
