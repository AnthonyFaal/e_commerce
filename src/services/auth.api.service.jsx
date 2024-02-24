export const LoginApi = async (username, password) => {
  const api_url = "https://fakestoreapi.com/auth/login";
  try {
    const response = await fetch(api_url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ username, password }),
    });
    if (!response.ok) {
      throw new Error("Login failed.");
    }
    const data = await response.json();
    return data;
  } catch (e) {
    throw new Error('Login failed, try later', e);
  }
};


export const RegisterApi = async (username, email, contact, password) => {
  const api_url = "https://fakestoreapi.com/users";

  try {
    const response = await fetch(api_url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        username,
        email,
        contact,
        password
      }),
    });

    if (!response.ok) {
      throw new Error("Registration failed.");
    }

    const data = await response.json();
    return data;
  } catch (e) {
    throw new Error('Registration failed, try later', e);
  }
};


export const logout =async()=>{

}