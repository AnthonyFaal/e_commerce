import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { fetchProductsByCategory } from '../services/categories.service';

function Category() {
  const { category } = useParams();
  const [products, setProducts] = useState([]);
  console.log('Category component received category:', category);


  useEffect(() => {
    const fetchData = async () => {
      try {
        const productsData = await fetchProductsByCategory(category);
        setProducts(productsData);
      } catch (error) {
        console.error(`Error fetching products for category ${category}:`, error.message);
        // Handle the error as needed
      }
    };

    fetchData();
  }, [category]);

  return (
    <div>
      <h2>{category} Products</h2>
      <ul>
        {products.map((product) => (
          <li key={product.id}>{product.title}</li>
        ))}
      </ul>
    </div>
  );
}

export default Category;
