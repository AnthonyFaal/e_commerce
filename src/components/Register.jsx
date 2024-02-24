import React, { useState } from "react";
import { Link } from "react-router-dom";
import { RegisterApi } from "../services/auth.api.service";

const RegisterPage = () => {
  const [username, setUsername] = useState("");
  const [email, setEmail] = useState("");
  const [contact, setContact] = useState("");
  const [password, setPassword] = useState("");
  const[confirmpassword, setConfirmPassword]=useState("")

  const handleRegister = async (e) => {
    e.preventDefault();
  
    // Check if password and confirm password match
    if (password !== confirmpassword) {
      console.error("Password and Confirm Password do not match");
      // You can display an error message to the user if needed
      return;
    }
  
    try {
      // Call the RegisterApi function with form values
      await RegisterApi(username, email, contact, password);
      // Handle successful registration, e.g., redirect to login page
      console.log("Registration successful");
    } catch (error) {
      // Handle registration error, e.g., display an error message
      console.error("Registration failed", error);
    }
  };
  

  return (
    <div className="body">
      <div className="login-container">
        <div className="container">
          <form onSubmit={handleRegister}>
            <div className="form-group">
              <label htmlFor="username">Name:</label>
              <input
                type="text"
                className="form-control"
                id="username"
                required
                value={username}
                onChange={(e) => setUsername(e.target.value)}
              />
            </div>

            <div className="form-group">
              <label htmlFor="email">Email:</label>
              <input
                type="email"
                className="form-control"
                id="email"
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
              />
            </div>

            <div className="form-group">
              <label htmlFor="contact">Contact:</label>
              <input
                type="tel"
                className="form-control"
                id="contact"
                required
                value={contact}
                onChange={(e) => setContact(e.target.value)}
              />
            </div>

            <div className="form-group">
              <label htmlFor="password">Password:</label>
              <input
                type="password"
                className="form-control"
                id="password"
                required
                value={password}
                onChange={(e) => setPassword(e.target.value)}
              />
            </div>

            <div className="form-group">
              <label htmlFor="confirmpassword">Confirm Password:</label>
              <input
                type="password"
                className="form-control"
                id="ConfirmPassword"
                required
                value={confirmpassword}
                onChange={(e)=>setConfirmPassword(e.target.value)}
              />
            </div>

            <p className="mt-3 text-center">
              Already have an account?{' '}
              <Link to="/login">Login here</Link>
            </p>
            <button type="submit" className="btn btn-primary">
              Register
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default RegisterPage;
