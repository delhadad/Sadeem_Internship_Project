import { useEffect, useReducer, useContext } from "react";
import axios from "axios";
import Row from "react-bootstrap/Row";
import Col from "react-bootstrap/Col";
import Product from "../components/Product";
import { Helmet } from "react-helmet-async";
import LoadingBox from "../components/LoadingBox";
import MessageBox from "../components/MessageBox";
import { Link } from "react-router-dom"; // Link for navigation
import { Store } from "../Store"; // Import the Store context to manage sign-in state

const reducer = (state, action) => {
  switch (action.type) {
    case "FETCH_REQUEST":
      return { ...state, loading: true };
    case "FETCH_SUCCESS":
      return { ...state, products: action.payload, loading: false };
    case "FETCH_FAIL":
      return { ...state, loading: false, error: action.payload };
    default:
      return state;
  }
};

function HomeScreen() {
  const [{ loading, error, products }, dispatch] = useReducer(reducer, {
    products: [],
    loading: true,
    error: "",
  });

  const { state } = useContext(Store);
  const { userInfo } = state;

  useEffect(() => {
    const fetchData = async () => {
      dispatch({ type: "FETCH_REQUEST" });
      try {
        const result = await axios.get("/vendors");
        const vendorsArray = Array.isArray(result.data) ? result.data : result.data.vendors || [];
        dispatch({ type: "FETCH_SUCCESS", payload: vendorsArray });
      } catch (err) {
        dispatch({ type: "FETCH_FAIL", payload: err.message });
      }
    };
    fetchData();
  }, []);

  return (
    <div className="homepage-container">
      <Helmet>
        <title>Vendor Management - Home</title>
      </Helmet>

    
      {!userInfo ? (
        <div className="auth-options">
          <h1>Welcome to Vendor Management</h1>
          <p>Please sign in to access your account or create an account.</p>

          <div className="auth-links">
            <Link to="/signin" className="btn btn-primary">
              Sign In
            </Link>
            <Link to="/signup" className="btn btn-secondary">
              Sign Up
            </Link>
          </div>
        </div>
      ) : (
        <div>
          <h1>Our Vendors</h1>
          {loading ? (
            <LoadingBox />
          ) : error ? (
            <MessageBox variant="danger">{error}</MessageBox>
          ) : (
            <Row>
              {products.map((product) => (
                <Col key={product.id} sm={6} md={4} lg={3} className="mb-3">
                  <Product product={product}></Product>
                </Col>
              ))}
            </Row>
          )}
        </div>
      )}
    </div>
  );
}

export default HomeScreen;
