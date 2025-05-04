import React, { useEffect, useState } from 'react';

function NodeIndicator() {
  const [nodeId, setNodeId] = useState('');

  useEffect(() => {
    fetch('/', { method: 'HEAD' })
      .then(res => setNodeId(res.headers.get('X-Node-ID')))
      .catch(console.error);
  }, []);

  return <p>Served by: {nodeId || 'Loading...'}</p>;
}

export default NodeIndicator;