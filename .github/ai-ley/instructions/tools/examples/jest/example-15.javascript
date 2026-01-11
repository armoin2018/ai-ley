import React from 'react'
import { render, screen, fireEvent, waitFor } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import '@testing-library/jest-dom'
import TodoList from '../TodoList'

describe('TodoList component', () => {
  const mockTodos = [
    { id: 1, text: 'Learn Jest', completed: false },
    { id: 2, text: 'Write tests', completed: true }
  ]
  
  test('renders todo items', () => {
    render(<TodoList todos={mockTodos} />)
    
    expect(screen.getByText('Learn Jest')).toBeInTheDocument()
    expect(screen.getByText('Write tests')).toBeInTheDocument()
  })
  
  test('adds new todo', async () => {
    const mockOnAdd = jest.fn()
    const user = userEvent.setup()
    
    render(<TodoList todos={[]} onAdd={mockOnAdd} />)
    
    const input = screen.getByPlaceholderText('Add new todo')
    const button = screen.getByText('Add')
    
    await user.type(input, 'New todo item')
    await user.click(button)
    
    expect(mockOnAdd).toHaveBeenCalledWith('New todo item')
  })
  
  test('toggles todo completion', async () => {
    const mockOnToggle = jest.fn()
    const user = userEvent.setup()
    
    render(<TodoList todos={mockTodos} onToggle={mockOnToggle} />)
    
    const checkbox = screen.getByRole('checkbox', { name: /learn jest/i })
    await user.click(checkbox)
    
    expect(mockOnToggle).toHaveBeenCalledWith(1)
  })
  
  test('handles loading state', () => {
    render(<TodoList todos={[]} loading={true} />)
    expect(screen.getByText('Loading...')).toBeInTheDocument()
  })
  
  test('handles error state', () => {
    render(<TodoList todos={[]} error="Failed to load todos" />)
    expect(screen.getByText('Failed to load todos')).toBeInTheDocument()
  })
})