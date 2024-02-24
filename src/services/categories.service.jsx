
export const fetchCategories = async () => {
    const api_url = "https://fakestoreapi.com/products/categories";
  
    try {
      const response = await fetch(api_url);
  
      if (!response.ok) {
        throw new Error("Failed to fetch categories.");
      }
  
      const data = await response.json();
      return data;
    } catch (error) {
      throw new Error("Failed to fetch categories: " + error.message);
    }
  };


export const fetchProductsByCategory= async (category)=> {
 const   url= `https://fakestoreapi.com/products/category/${category}`;
    try {
      const response = await fetch(url);
  
      if (!response.ok) {
        throw new Error(`Failed to fetch products for category: ${category}`);
      }
  
      const products = await response.json();
      return products;
    } catch (error) {
      console.error(`Error fetching products for category ${category}:`, error.message);
      throw error;
    }
  }
  
  
  