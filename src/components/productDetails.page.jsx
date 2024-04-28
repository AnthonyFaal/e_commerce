/*import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { fetchProduct } from '../services/product.service';
import StarRatings from 'react-star-ratings';

function ProductDetailsPage() {
  const { productId } = useParams();
  const [product, setProduct] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const data = await fetchProductById(productId);
        setProduct(data);
      } catch (error) {
        console.error(error.message);
      }
    };

    fetchData();
  }, [productId]);

  if (!product) {
    return <div>Loading...</div>;
  }

  return (
    <div className="product-details-container">
      <img className="product-image" src={product.image} alt={product.title} />
      <div className="product-details">
        <h2 className="product-title">{product.title}</h2>
        <p className="product-price">$ {product.price}</p>
        <p className="product-rating">
          <StarRatings
            rating={product.rating.rate}
            starRatedColor="blue"
            starDimension="25px"
            starSpacing="2px"
          />
          ({product.rating.count} reviews)
        </p>
        <p className="product-description">{product.description}</p>
        {/* Add more details as needed }
      </div>
    </div>
  );
}

export default ProductDetailsPage;*/
