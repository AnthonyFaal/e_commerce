import React, { useEffect, useState } from 'react';
import { fetchProducts } from '../services/product.service';
import { Link } from 'react-router-dom';
import StarRatings from 'react-star-ratings';
import './style/homeStyle/homepage.style.css'; 

function HomePage() {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const data = await fetchProducts();
        setProducts(data);
      } catch (error) {
        console.error(error.message);
      }
    };

    fetchData();
  }, []);

  return (
    <div className="home-page-container">
      <div className="product-list">
        {products.map((product) => (
          <div key={product.id} className="product-item">
            <img className="product-image" src={product.image} alt={product.title} />
            <div className="product-details">
              <h3 className="product-title">{product.title}</h3>
              <p className="product-price">$ <span>{product.price}</span></p>
              <p className="product-rating"> 
               <div>
               <StarRatings
                rating={product.rating.rate}
                 starRatedColor="blue"
                  starDimension="25px"
                 starSpacing="2px"
                 />
                 ({product.rating.count} reviews)
               </div>
               {product.rating.rate}   
              </p>
            </div>
            
          </div>
        ))}
      </div>
    </div>
  );
} 

export default HomePage;
