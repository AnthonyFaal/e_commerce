import React, { useState, useEffect } from 'react';
import { Button, Container, Form, Nav, Navbar, NavDropdown } from 'react-bootstrap';
import HomePage from './Home.page';
import AboutPage from './about.page';
import Cart from './cart.page'; 
import Category from './categories.page'; 
import Logo from '../assets/icon.png';
import { fetchCategories } from '../services/categories.service';
import './style/homeStyle/dashboard.css';

function Dashboard() {
  const [currentPage, setCurrentPage] = useState('home');
  const [categories, setCategories] = useState([]);
  const [selectedCategory, setSelectedCategory] = useState(null); // New state for the selected category

  const handleNavigation = (page) => {
    setCurrentPage(page);

 
    if (page === 'category') {
      setSelectedCategory(null);
    }
  };

  const handleCategoryClick = (category) => {
    console.log('Selected Category:', category); // Log the selected category for debugging
    setSelectedCategory(category);
    setCurrentPage('category');
  };
  

  useEffect(() => {
    const fetchData = async () => {
      try {
        const data = await fetchCategories();
        setCategories(data);
      } catch (e) {
        console.error(e.message);
      }
    };
    fetchData();
  }, []);

  return (
    <div className='dash-container'>
      <Navbar expand='lg' className='bg-body-tertiary navbar fixed-top navcolor'>
        <Container fluid>
          <Navbar.Brand href='#' className='logo'>
            <img src={Logo} alt='' />
            Shoppy
          </Navbar.Brand>
          <Navbar.Toggle aria-controls='navbarScroll' />
          <Navbar.Collapse id='navbarScroll'>
            <Nav className='mx-auto nav-dec' style={{ maxHeight: '200px' }}>
              <Nav.Link href='#home' className='me-3' onClick={() => handleNavigation('home')}>
                Home
              </Nav.Link>
              <NavDropdown title='Categories' id='navbarScrollingDropdown' className='me-3'>
                {categories.map((category) => (
                  <NavDropdown.Item
                    key={category}
                    onClick={() => handleCategoryClick(category)}
                  >
                    {category}
                  </NavDropdown.Item>
                ))}
              </NavDropdown>
              <Nav.Link href='#' className='me-3' onClick={() => handleNavigation('about')}>About </Nav.Link>
              <Nav.Link href='#' className='me-3' onClick={() => handleNavigation('cart')}> Cart </Nav.Link>
            </Nav>
            <Form className='d-flex'>
              <Form.Control
                type='search'
                placeholder='Search'
                className='me-2 search'
                aria-label='Search'
              />
              <Button variant='outline-success'>Search</Button>
            </Form>
          </Navbar.Collapse>
        </Container>
      </Navbar>
      <Container fluid className='mainContent'>
        {currentPage === 'home' && <HomePage />}
        {currentPage === 'about' && <AboutPage />}
        {currentPage === 'cart' && <Cart />}
        {currentPage === 'category' && selectedCategory && (
          <Category category={selectedCategory} />
        )}
      </Container>
    </div>
  );
}

export default Dashboard;
