import React, { useContext, useReducer, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';
import axios from 'axios';
import { Store } from '../Store';
import { getError } from '../utils';
import Container from 'react-bootstrap/Container';
import Form from 'react-bootstrap/Form';
import Button from 'react-bootstrap/Button';
import LoadingBox from '../components/LoadingBox';

const reducer = (state, action) => {
  switch (action.type) {
    case 'CREATE_REQUEST':
      return { ...state, loadingCreate: true };
    case 'CREATE_SUCCESS':
      return { ...state, loadingCreate: false };
    case 'CREATE_FAIL':
      return { ...state, loadingCreate: false };
    default:
      return state;
  }
};

export default function VendorCreateScreen() {
  const navigate = useNavigate();
  const [{ loadingCreate }, dispatch] = useReducer(reducer, {
    loadingCreate: false,
  });

  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  
  const { state } = useContext(Store);
  const { userInfo } = state;

  const submitHandler = async (e) => {
    e.preventDefault();
    try {
      dispatch({ type: 'CREATE_REQUEST' });
      const form = new FormData();
      form.append('name', name);
      form.append('description', description);
      if (e.target.imageFile.files[0]) {
        form.append('img', e.target.imageFile.files[0]);
      }

      await axios.post(`/vendors`, form, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
        withCredentials: true,
      });

      dispatch({ type: 'CREATE_SUCCESS' });
      toast.success('Vendor created successfully');
      navigate('/admin/vendors');
    } catch (err) {
      toast.error(getError(err));
      dispatch({ type: 'CREATE_FAIL' });
    }
  };

  return (
    <Container className="small-container">
      <h1>Create Vendor</h1>

      <Form onSubmit={submitHandler}>
        <Form.Group className="mb-3" controlId="name">
          <Form.Label>Name</Form.Label>
          <Form.Control
            value={name}
            onChange={(e) => setName(e.target.value)}
            required
          />
        </Form.Group>
        <Form.Group className="mb-3" controlId="imageFile">
          <Form.Label>Upload Image</Form.Label>
          <Form.Control type="file" />
        </Form.Group>
        <Form.Group className="mb-3" controlId="description">
          <Form.Label>Description</Form.Label>
          <Form.Control
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            required
          />
        </Form.Group>
        <div className="mb-3">
          <Button disabled={loadingCreate} type="submit">
            Create
          </Button>
          {loadingCreate && <LoadingBox></LoadingBox>}
        </div>
      </Form>
    </Container>
  );
}
