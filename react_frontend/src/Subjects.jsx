import React, { useEffect, useState } from 'react';
import './Courses.css'; 

function Courses() {
  const [subjects, setSubjects] = useState([]);

  useEffect(() => {
    fetch('http://localhost:5000/subjects')
      .then(res => res.json())
      .then(data => setSubjects(data))
      .catch(console.error);
  }, []);

  return (
    <div className="course-table-container">
      <h2>Software Engineering Subjects</h2>
      <table className="course-table">
        <thead>
          <tr>
            <th>#</th>
            <th>Course Name</th>
            <th>Course Code</th>
            <th>Year</th>
          </tr>
        </thead>
        <tbody>
          {subjects.map((s, idx) => (
            <tr key={idx}>
              <td>{idx + 1}</td>
              <td>{s.course_name}</td>
              <td>{s.course_code}</td>
              <td>{s.year}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default Courses;
