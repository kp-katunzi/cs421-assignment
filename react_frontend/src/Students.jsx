import React, { useEffect, useState } from 'react';
import './Students.css';

function Students() {
  const [students, setStudents] = useState([]);

  useEffect(() => {
    fetch('http://localhost:5000/students')
      .then(res => res.json())
      .then(data => setStudents(data))
      .catch(console.error);
  }, []);

  return (
    <div className="student-table-container">
      <h2>Student List</h2>
      <table className="student-table">
        <thead>
          <tr>
            <th>#</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Program</th>
          </tr>
        </thead>
        <tbody>
          {students.map((s, idx) => (
            <tr key={idx}>
              <td>{idx + 1}</td>
              <td>{s.first_name}</td>
              <td>{s.last_name}</td>
              <td>{s.program}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default Students;
