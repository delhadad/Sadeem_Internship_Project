import React, { useContext, useEffect, useReducer } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Button from 'react-bootstrap/Button';
import { toast } from 'react-toastify';
import { Store } from '../Store';
import LoadingBox from '../components/LoadingBox';
import MessageBox from '../components/MessageBox';
import { getError } from '../utils';

const reducer = (state, action) => {
  switch (action.type) {
    case 'FETCH_REQUEST':
      return { ...state, loading: true };
    case 'FETCH_SUCCESS':
      return {
        ...state,
        vendors: action.payload.data,  
        meta: action.payload.meta,     
        loading: false,
      };
    case 'FETCH_FAIL':
      return { ...state, loading: false, error: action.payload };
    case 'CREATE_REQUEST':
      return { ...state, loadingCreate: true };
    case 'CREATE_SUCCESS':
      return { ...state, loadingCreate: false };
    case 'CREATE_FAIL':
      return { ...state, loadingCreate: false };
    case 'DELETE_REQUEST':
      return { ...state, loadingDelete: true, successDelete: false };
    case 'DELETE_SUCCESS':
      return { ...state, loadingDelete: false, successDelete: true };
    case 'DELETE_FAIL':
      return { ...state, loadingDelete: false, successDelete: false };
    case 'DELETE_RESET':
      return { ...state, loadingDelete: false, successDelete: false };
    default:
      return state;
  }
};

export default function VendorListScreen() {
  const [{ loading, error, vendors, meta, loadingCreate, loadingDelete, successDelete }, dispatch] = useReducer(reducer, {
    loading: true,
    error: '',
  });

  const navigate = useNavigate();
  const { state } = useContext(Store);
  const { userInfo } = state;  

  useEffect(() => {
    const fetchData = async () => {
      try {
        dispatch({ type: 'FETCH_REQUEST' });
        const { data } = await axios.get(`/vendors`, {
          withCredentials: true,  
        });
        dispatch({ type: 'FETCH_SUCCESS', payload: data });
      } catch (err) {
        dispatch({ type: 'FETCH_FAIL', payload: getError(err) });
      }
    };

    if (successDelete) {
      dispatch({ type: 'DELETE_RESET' });
    } else {
      fetchData();
    }
  }, [successDelete]);

  const createHandler = () => {
    navigate('/admin/vendor/create');
  };

  const deleteHandler = async (vendor) => {
    if (window.confirm('Are you sure to delete?')) {
      try {
        dispatch({ type: 'DELETE_REQUEST' });
        await axios.delete(`/vendors/${vendor.id}`, {
          withCredentials: true,  
        });
        toast.success('Vendor deleted successfully');
        dispatch({ type: 'DELETE_SUCCESS' });
      } catch (err) {
        toast.error(getError(err));
        dispatch({
          type: 'DELETE_FAIL',
        });
      }
    }
  };

  return (
    <div>
      <Row>
        <Col>
          <h1>Vendors</h1>
        </Col>
        <Col className="col text-end">
          <div>
            <Button type="button" onClick={createHandler}>
              Create Vendor
            </Button>
          </div>
        </Col>
      </Row>

      {loadingCreate && <LoadingBox></LoadingBox>}
      {loadingDelete && <LoadingBox></LoadingBox>}

      {loading ? (
        <LoadingBox></LoadingBox>
      ) : error ? (
        <MessageBox variant="danger">{error}</MessageBox>
      ) : (
        <>
          <table className="table">
            <thead>
              <tr>
                <th>ID</th>
                <th>NAME</th>
                <th>DESCRIPTION</th>
                <th>IMAGE</th>
                <th>ACTIONS</th>
              </tr>
            </thead>
            <tbody>
              {vendors.map((vendor) => (
                <tr key={vendor.id}>
                  <td>{vendor.id}</td>
                  <td>{vendor.name}</td>
                  <td>{vendor.description}</td>
                  <td><img src={vendor.img} width={100} alt={vendor.name} /></td>
                  <td>
                    <Button
                      type="button"
                      variant="light"
                      onClick={() => navigate(`/admin/vendor/${vendor.id}`)}
                    >
                      Edit
                    </Button>
                    &nbsp;
                    <Button
                      type="button"
                      variant="light"
                      onClick={() => deleteHandler(vendor)}
                    >
                      Delete
                    </Button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>

          {/* Add pagination controls if meta information is provided */}
          {meta && (
            <div>
              Page {meta.current_page} of {Math.ceil(meta.total / meta.per_page)}
            </div>
          )}
        </>
      )}
    </div>
  );
}
