import React, { useEffect, useState } from "react";
import Select from "react-select";
import Sidebar from "./Sidebar";
import makeAnimated from "react-select/animated";
import "../styles/TagManagement.css";

const animatedComponents = makeAnimated();

export default function TagManagementScreen({setAdminInfo}) {
  const [sidebarCollapsed, sidebarSetCollapsed] = useState(false);
  const [tags, setTags] = useState([]);
  const [selectedTag, setSelectedTag] = useState(null);
  const [addName, setAddName] = useState("");
  const [addDescription, setAddDescription] = useState("");
  const [editNewName, setEditNewName] = useState("");
  const [editNewDescription, setEditNewDescription] = useState("");
  const [currentDescription, setCurrentDescription] = useState("");
  const [currentName, setCurrentName] = useState("");

  useEffect(() => {
    fetch("http://localhost:8000/api/tags-management/")
      .then((res) => res.json())
      .then((data) => {
        setTags(
          data.tags.map((tag) => ({
            value: tag.id,
            label: tag.name,
            description: tag.description,
          })),
        );
      });
  }, []);

  const handleTagChange = (selected) => {
    setSelectedTag(selected);
    setCurrentDescription(selected?.description || "");
    setEditNewName(selected?.label || "");
    setEditNewDescription(selected?.description || "");
    setCurrentName(selected?.label || "");
  };

  const handleAddTag = async () => {
    if (!addName || !addDescription) return;
    const res = await fetch("http://localhost:8000/api/tags/create/", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      credentials: "include",
      body: JSON.stringify({ name: addName, description: addDescription }),
    });
    if (res.ok) {
      setAddName("");
      setAddDescription("");

      fetch("http://localhost:8000/api/tags-management/")
        .then((res) => res.json())
        .then((data) => {
          setTags(
            data.tags.map((tag) => ({
              value: tag.id,
              label: tag.name,
              description: tag.description,
            })),
          );
        });
    }
  };

  const handleUpdateTag = async () => {
    if (!selectedTag || (!editNewName && !editNewDescription)) return;
    const res = await fetch("http://localhost:8000/api/tags/update/", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      credentials: "include",
      body: JSON.stringify({
        id: selectedTag.value,
        newName: editNewName,
        newDescription: editNewDescription,
      }),
    });
    if (res.ok) {
      setCurrentDescription(editNewDescription);
      setCurrentName(editNewName);
    }
  };

  return (
    <div className="tag-screen-container">
      <Sidebar
        setCollapsed={sidebarSetCollapsed}
        collapsed={sidebarCollapsed}
        setAdminInfo={setAdminInfo}
      />
      <div className={`tag-screen-main ${sidebarCollapsed ? "sidebar-collapsed" : ""}`}>
        <div className="card">
          <h2>Add Tag</h2>
          <input
            type="text"
            placeholder="Tag Name"
            value={addName}
            onChange={(e) => setAddName(e.target.value)}
          />
          <textarea
            placeholder="Tag Description"
            value={addDescription}
            onChange={(e) => setAddDescription(e.target.value)}
            maxLength={255}
          ></textarea>
          <button onClick={handleAddTag}>Add Tag</button>
        </div>

        <div className="card">
          <h2>Edit Tag</h2>
          <Select
            options={tags}
            components={animatedComponents}
            classNamePrefix="react-select"
            className="react-select-container"
            value={selectedTag}
            onChange={handleTagChange}
            placeholder="Select a tag to edit"
          />
          {selectedTag && (
            <>
              <p className="current-description">
                <strong>Current Name:</strong> {currentName}
              </p>
              <p className="current-description">
                <strong>Current Description:</strong> {currentDescription}
              </p>
              <input
                type="text"
                placeholder="New Tag Name"
                value={editNewName}
                onChange={(e) => setEditNewName(e.target.value)}
              />
              <textarea
                placeholder="New Tag Description"
                value={editNewDescription}
                onChange={(e) => setEditNewDescription(e.target.value)}
                maxLength={255}
              ></textarea>
              <button onClick={handleUpdateTag}>Update Tag</button>
            </>
          )}
        </div>
      </div>
    </div>
  );
}
