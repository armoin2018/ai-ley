// src/components/FileManager.jsx - File Management Component
import React, { useState, useEffect, useCallback } from 'react';
import { neutralinoAPI } from '../services/neutralino-api';

const FileManager = () => {
  const [currentPath, setCurrentPath] = useState('');
  const [files, setFiles] = useState([]);
  const [selectedFile, setSelectedFile] = useState(null);
  const [fileContent, setFileContent] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  // Initialize with user's documents folder
  useEffect(() => {
    const initializeFileManager = async () => {
      setLoading(true);
      try {
        const pathResult = await neutralinoAPI.getPath('documents');
        if (pathResult.success) {
          setCurrentPath(pathResult.data);
          await loadDirectory(pathResult.data);
        } else {
          setError('Failed to get documents path');
        }
      } catch (err) {
        setError('Failed to initialize file manager');
      } finally {
        setLoading(false);
      }
    };

    initializeFileManager();
  }, []);

  const loadDirectory = useCallback(async (path) => {
    setLoading(true);
    setError(null);

    try {
      const result = await neutralinoAPI.readDirectory(path);
      if (result.success) {
        setFiles(result.data);
        setCurrentPath(path);
      } else {
        setError(`Failed to load directory: ${result.error}`);
      }
    } catch (err) {
      setError('Error loading directory');
    } finally {
      setLoading(false);
    }
  }, []);

  const handleFileSelect = async (file) => {
    if (file.type === 'FILE') {
      setSelectedFile(file);

      // Try to read file content if it's a text file
      const filePath = `${currentPath}/${file.entry}`;
      const result = await neutralinoAPI.readFile(filePath);

      if (result.success) {
        setFileContent(result.data);
      } else {
        setFileContent('Cannot read file content');
      }
    } else if (file.type === 'DIRECTORY') {
      const newPath = `${currentPath}/${file.entry}`;
      await loadDirectory(newPath);
    }
  };

  const handleGoUp = () => {
    const parentPath = currentPath.split('/').slice(0, -1).join('/');
    if (parentPath) {
      loadDirectory(parentPath);
    }
  };

  const handleCreateFile = async () => {
    const fileName = prompt('Enter file name:');
    if (fileName) {
      const filePath = `${currentPath}/${fileName}`;
      const result = await neutralinoAPI.writeFile(filePath, '');

      if (result.success) {
        await loadDirectory(currentPath); // Refresh directory
      } else {
        setError(`Failed to create file: ${result.error}`);
      }
    }
  };

  const handleCreateFolder = async () => {
    const folderName = prompt('Enter folder name:');
    if (folderName) {
      const folderPath = `${currentPath}/${folderName}`;
      const result = await neutralinoAPI.createDirectory(folderPath);

      if (result.success) {
        await loadDirectory(currentPath); // Refresh directory
      } else {
        setError(`Failed to create folder: ${result.error}`);
      }
    }
  };

  const handleDeleteFile = async (file) => {
    if (confirm(`Delete ${file.entry}?`)) {
      const filePath = `${currentPath}/${file.entry}`;
      const result = await neutralinoAPI.removeFile(filePath);

      if (result.success) {
        await loadDirectory(currentPath); // Refresh directory
        if (selectedFile && selectedFile.entry === file.entry) {
          setSelectedFile(null);
          setFileContent('');
        }
      } else {
        setError(`Failed to delete file: ${result.error}`);
      }
    }
  };

  const handleSaveFile = async () => {
    if (selectedFile) {
      const filePath = `${currentPath}/${selectedFile.entry}`;
      const result = await neutralinoAPI.writeFile(filePath, fileContent);

      if (result.success) {
        alert('File saved successfully!');
      } else {
        setError(`Failed to save file: ${result.error}`);
      }
    }
  };

  if (loading && files.length === 0) {
    return <div className="loading">Loading file manager...</div>;
  }

  return (
    <div className="file-manager">
      <div className="toolbar">
        <button onClick={handleGoUp} disabled={!currentPath}>
          ↑ Up
        </button>
        <span className="current-path">{currentPath}</span>
        <div className="actions">
          <button onClick={handleCreateFile}>New File</button>
          <button onClick={handleCreateFolder}>New Folder</button>
        </div>
      </div>

      {error && <div className="error">{error}</div>}

      <div className="file-manager-content">
        <div className="file-list">
          <h3>Files and Folders</h3>
          {loading && <div className="loading">Loading...</div>}
          <ul>
            {files.map((file, index) => (
              <li
                key={index}
                className={`file-item ${file.type.toLowerCase()} ${
                  selectedFile && selectedFile.entry === file.entry ? 'selected' : ''
                }`}
                onClick={() => handleFileSelect(file)}
              >
                <span className="file-icon">{file.type === 'DIRECTORY' ? '📁' : '📄'}</span>
                <span className="file-name">{file.entry}</span>
                <span className="file-type">{file.type}</span>
                {file.type === 'FILE' && (
                  <button
                    className="delete-btn"
                    onClick={(e) => {
                      e.stopPropagation();
                      handleDeleteFile(file);
                    }}
                  >
                    🗑️
                  </button>
                )}
              </li>
            ))}
          </ul>
        </div>

        {selectedFile && selectedFile.type === 'FILE' && (
          <div className="file-editor">
            <h3>
              Editing: {selectedFile.entry}
              <button onClick={handleSaveFile} className="save-btn">
                Save
              </button>
            </h3>
            <textarea
              value={fileContent}
              onChange={(e) => setFileContent(e.target.value)}
              className="file-content-editor"
              rows={20}
              cols={80}
            />
          </div>
        )}
      </div>
    </div>
  );
};

export default FileManager;