// components/UserProfile.tsx
import React, { useEffect } from 'react'
import { useAuth } from '../hooks/redux'
import { useAppDispatch, useAppSelector } from '../hooks/redux'
import { updateUserProfile, clearError } from '../store/slices/userSlice'

const UserProfile: React.FC = () => {
  const dispatch = useAppDispatch()
  const { user, loading, error } = useAuth()
  const [isEditing, setIsEditing] = React.useState(false)
  const [formData, setFormData] = React.useState({
    name: user?.name || '',
    email: user?.email || '',
  })

  useEffect(() => {
    if (user) {
      setFormData({
        name: user.name,
        email: user.email,
      })
    }
  }, [user])

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    if (user) {
      dispatch(updateUserProfile({
        ...user,
        name: formData.name,
        email: formData.email,
      }))
      setIsEditing(false)
    }
  }

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    })
  }

  if (loading) return <div>Loading...</div>
  if (!user) return <div>Please log in</div>

  return (
    <div className="user-profile">
      <h2>User Profile</h2>
      
      {error && (
        <div className="error-message">
          {error}
          <button onClick={() => dispatch(clearError())}>✕</button>
        </div>
      )}

      {isEditing ? (
        <form onSubmit={handleSubmit}>
          <div>
            <label htmlFor="name">Name:</label>
            <input
              type="text"
              id="name"
              name="name"
              value={formData.name}
              onChange={handleInputChange}
              required
            />
          </div>
          <div>
            <label htmlFor="email">Email:</label>
            <input
              type="email"
              id="email"
              name="email"
              value={formData.email}
              onChange={handleInputChange}
              required
            />
          </div>
          <button type="submit">Save</button>
          <button type="button" onClick={() => setIsEditing(false)}>
            Cancel
          </button>
        </form>
      ) : (
        <div className="profile-display">
          <p><strong>Name:</strong> {user.name}</p>
          <p><strong>Email:</strong> {user.email}</p>
          <button onClick={() => setIsEditing(true)}>Edit Profile</button>
        </div>
      )}
    </div>
  )
}

export default UserProfile