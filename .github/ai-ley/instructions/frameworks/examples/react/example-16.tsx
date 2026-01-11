// React 19 form actions
function ContactForm() {
  const [pending, setPending] = useState(false);
  const [message, setMessage] = useState('');
  
  async function submitForm(formData: FormData) {
    setPending(true);
    try {
      const response = await fetch('/api/contact', {
        method: 'POST',
        body: formData
      });
      
      if (response.ok) {
        setMessage('Message sent successfully!');
      } else {
        setMessage('Failed to send message.');
      }
    } finally {
      setPending(false);
    }
  }
  
  return (
    <form action={submitForm}>
      <input 
        name="email" 
        type="email" 
        placeholder="Your email" 
        required 
      />
      <textarea 
        name="message" 
        placeholder="Your message" 
        required 
      />
      <button type="submit" disabled={pending}>
        {pending ? 'Sending...' : 'Send Message'}
      </button>
      {message && <p>{message}</p>}
    </form>
  );
}