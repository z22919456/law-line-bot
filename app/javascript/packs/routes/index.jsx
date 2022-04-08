import React from 'react'
import {
  BrowserRouter,
  Routes,
  Route,
} from "react-router-dom";
import Edit from '../pages/user/Edit'

function Index() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<div>index</div>} />
        <Route path="/user/edit" element={<Edit />} />
      </Routes>
    </BrowserRouter>
  )
}

export default Index