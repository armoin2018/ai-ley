// React component example
import { useState, useEffect } from 'react';

const BrutalistHero = () => {
  const [glitch, setGlitch] = useState(false);
  
  useEffect(() => {
    const interval = setInterval(() => {
      setGlitch(true);
      setTimeout(() => setGlitch(false), 200);
    }, 3000);
    
    return () => clearInterval(interval);
  }, []);
  
  return (
    <section className={`brutal-hero ${glitch ? 'glitch-active' : ''}`}>
      <h1 className="brutal-heading">
        WELCOME\\TO\\THE_FUTURE
      </h1>
    </section>
  );
};