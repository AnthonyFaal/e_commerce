import React from 'react';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Image from 'react-bootstrap/Image';
import './style/homeStyle/about.page.style.css'; // Import your custom styles
import TeamImage1 from '../assets/team/team1.jpg';
import TeamImage2 from '../assets/team/team2.jpg';
import TeamImage3 from '../assets/team/team3.jpg';

function AboutPage() {
  return (
    <Container fluid className="about-page-container">
      <h2 className="text-center mb-4">About Us</h2>

      <Row className="mb-5">
        <Col md={6}>
          <p>
            Welcome to Shoppy, your go-to destination for the latest trends
            in clothing, bags, watches, and more. At Shoppy, we strive to
            provide high-quality products that reflect your style and personality.
          </p>
          <p>
            Our mission is to make fashion accessible to everyone by offering a diverse range
            of products at affordable prices. Whether you're looking for the perfect outfit
            for a special occasion or a stylish accessory to complete your look, we've got you
            covered.
          </p>
        </Col>
        <Col md={6}>
          <Image src={TeamImage1} alt="Team Member 1" fluid />
        </Col>
      </Row>

      <h3 className="text-center mb-4">Our Team</h3>

      <Row className="team-members">
        <Col md={4}>
          <Image src={TeamImage1} alt="Team Member 1" fluid className="mb-3" />
          <p className="text-center">John Doe</p>
          <p className="text-center">Co-founder</p>
        </Col>
        <Col md={4}>
          <Image src={TeamImage2} alt="Team Member 2" fluid className="mb-3" />
          <p className="text-center">Jane Smith</p>
          <p className="text-center">Designer</p>
        </Col>
        <Col md={4}>
          <Image src={TeamImage3} alt="Team Member 3" fluid className="mb-3" />
          <p className="text-center">Bob Johnson</p>
          <p className="text-center">Marketing</p>
        </Col>
      </Row>
    </Container>
  );
}

export default AboutPage;
