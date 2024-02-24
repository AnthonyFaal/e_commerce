
export const fetchProducts = async () => {
    const api_url = "https://fakestoreapi.com/products";
  
    try {
      const response = await fetch(api_url);
  
      if (!response.ok) {
        throw new Error("Failed to fetch products.");
      }
  
      const data = await response.json();
      return data;
    } catch (error) {
      throw new Error("Failed to fetch products: " + error.message);
    }
  };
  