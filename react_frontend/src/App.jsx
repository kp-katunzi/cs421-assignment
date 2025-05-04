
import React, { useState } from 'react';
import Students from './Students';
import Courses from './Subjects';
import NodeIndicator from './NodeIndicator';
import './App.css'; 

function App() {
  const [view, setView] = useState(null);

  return (
    <div className="app-container">
      <div className="header">
        <h1>University of Dodoma</h1>
        <NodeIndicator />
      </div>
      
      <div className="buttons-container">
        <button 
          className="view-button" 
          onClick={() => setView('students')}
        >
          Students
        </button>
        <button 
          className="view-button" 
          onClick={() => setView('courses')}
        >
          Courses
        </button>
      </div>

      {view === 'students' && <Students />}
      {view === 'courses' && <Courses />}
    </div>
  );
}

export default App;
