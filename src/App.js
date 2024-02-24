import React from 'react';
import { BrowserRouter as Router, Route, Routes,} from 'react-router-dom';
import Login from "./components/Login"
import Register from "./components/Register"
import Dashboard  from './components/dashboard.page';

function App() {
  return (
    <div className="App">
     <Router>
       <Routes>
       <Route path="/*" element={<Login/>} />   
       <Route path='/login' element={<Login/>}/>
       <Route path= "/register" element={<Register/>}/> 
       <Route path='dashboard/:token'element={<Dashboard/>} />   
       </Routes>
     </Router>
    </div>
  );
}

export default App;
