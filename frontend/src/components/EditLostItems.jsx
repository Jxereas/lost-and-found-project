import React, { useEffect, useState } from "react";
import Select from "react-select";
import makeAnimated from "react-select/animated";
import Sidebar from "./Sidebar";
import "../styles/EditLostItems.css";

const animatedComponents = makeAnimated();

export default function EditLostItemScreen({ setAdminInfo }) {
    const [sidebarCollapsed, setSidebarCollapsed] = useState(false);
    const [lostItems, setLostItems] = useState([]);
    const [selectedLostItem, setSelectedLostItem] = useState(null);

    const [person, setPerson] = useState({
        firstName: "",
        lastName: "",
        email: "",
        phone: "",
        streetAddress: "",
        city: "",
        state: "",
        zipcode: "",
    });

    const [item, setItem] = useState({
        name: "",
        color: "",
        description: "",
        notes: "",
    });

    const [location, setLocation] = useState({
        buildingName: "",
        description: "",
        streetAddress: "",
        city: "",
        state: "",
        zipcode: "",
    });

    const [currentTags, setCurrentTags] = useState([]);
    const [tagsToRemove, setTagsToRemove] = useState([]);
    const [allTags, setAllTags] = useState([]);

    useEffect(() => {
        // Fetch list of all lost items for selection dropdown
        fetch("http://localhost:8000/api/lost-items-summary/")
            .then((res) => res.json())
            .then((data) => {
                const formatted = data.map((item) => ({
                    value: item.id,
                    label: `${item.itemName} - ${item.reporterName} (${item.dateReported})`,
                }));
                setLostItems(formatted);
            });

        // Fetch all tags for multi-select removal
        fetch("http://localhost:8000/api/tags-management/")
            .then((res) => res.json())
            .then((data) =>
                setAllTags(
                    data.tags.map((tag) => ({
                        value: tag.id,
                        label: tag.name,
                    })),
                ),
            );
    }, []);

    const handleLostItemChange = (selected) => {
        setSelectedLostItem(selected);

        fetch(`http://localhost:8000/api/lost-items/${selected.value}/`)
            .then((res) => res.json())
            .then((data) => {
                setPerson(data.person);
                setItem(data.item);
                setLocation(data.location);
                setCurrentTags(data.tags);
            });
        fetch("http://localhost:8000/api/lost-items-summary/")
            .then((res) => res.json())
            .then((data) => {
                const formatted = data.map((item) => ({
                    value: item.id,
                    label: `${item.itemName} - ${item.reporterName} (${item.dateReported})`,
                }));
                setLostItems(formatted);
            });
    };

    const handleSubmitEdit = async () => {
        if (!selectedLostItem) return;

        try {
            const response = await fetch(
                `http://localhost:8000/api/lost-items/${selectedLostItem.value}/edit/`,
                {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    credentials: "include",
                    body: JSON.stringify({
                        person,
                        item,
                        location,
                        tagsToRemove: tagsToRemove.map((tag) => tag.value),
                    }),
                },
            );

            const data = await response.json();

            if (!response.ok) {
                alert("Error: " + (data.error || "Could not update lost item"));
            } else {
                alert("Lost item updated successfully!");
                // Optionally refresh currentTags
                handleLostItemChange(selectedLostItem);
                setTagsToRemove([]);
            }
        } catch (err) {
            console.error("Error submitting changes:", err);
            alert("An error occurred while submitting changes.");
        }
    };

    return (
        <div className="edit-lost-item-container">
            <Sidebar
                setCollapsed={setSidebarCollapsed}
                collapsed={sidebarCollapsed}
                setAdminInfo={setAdminInfo}
            />
            <div
                className={`edit-lost-item-main ${sidebarCollapsed ? "sidebar-collapsed" : ""
                    }`}
            >
                <h2>Edit Lost Item</h2>

                <div className="card">
                    <h3>Select Lost Item to Edit</h3>
                    <Select
                        options={lostItems}
                        components={animatedComponents}
                        value={selectedLostItem}
                        onChange={handleLostItemChange}
                        placeholder="Choose a lost item..."
                        className="react-select-container"
                        classNamePrefix="react-select"
                    />
                </div>

                {selectedLostItem && (
                    <>
                        {/* Reporter Information */}
                        <div className="card">
                            <h3>Reporter Information</h3>
                            <input
                                type="text"
                                placeholder="First Name"
                                value={person.firstName}
                                onChange={(e) =>
                                    setPerson({ ...person, firstName: e.target.value })
                                }
                            />
                            <input
                                type="text"
                                placeholder="Last Name"
                                value={person.lastName}
                                onChange={(e) =>
                                    setPerson({ ...person, lastName: e.target.value })
                                }
                            />
                            <input
                                type="text"
                                placeholder="Email"
                                value={person.email}
                                onChange={(e) =>
                                    setPerson({ ...person, email: e.target.value })
                                }
                            />
                            <input
                                type="text"
                                placeholder="Phone"
                                value={person.phone}
                                onChange={(e) =>
                                    setPerson({ ...person, phone: e.target.value })
                                }
                            />
                            <input
                                type="text"
                                placeholder="Street Address"
                                value={person.streetAddress}
                                onChange={(e) =>
                                    setPerson({ ...person, streetAddress: e.target.value })
                                }
                            />
                            <input
                                type="text"
                                placeholder="City"
                                value={person.city}
                                onChange={(e) => setPerson({ ...person, city: e.target.value })}
                            />
                            <input
                                type="text"
                                placeholder="State"
                                value={person.state}
                                onChange={(e) =>
                                    setPerson({ ...person, state: e.target.value })
                                }
                            />
                            <input
                                type="text"
                                placeholder="Zipcode"
                                value={person.zipcode}
                                onChange={(e) =>
                                    setPerson({ ...person, zipcode: e.target.value })
                                }
                            />
                        </div>

                        {/* Item Information */}
                        <div className="card">
                            <h3>Item Information</h3>
                            <input
                                type="text"
                                placeholder="Item Name"
                                value={item.name}
                                onChange={(e) => setItem({ ...item, name: e.target.value })}
                            />
                            <input
                                type="text"
                                placeholder="Color"
                                value={item.color}
                                onChange={(e) => setItem({ ...item, color: e.target.value })}
                            />
                            <input
                                type="text"
                                placeholder="Description"
                                value={item.description}
                                onChange={(e) =>
                                    setItem({ ...item, description: e.target.value })
                                }
                            />
                            <textarea
                                placeholder="Notes"
                                value={item.notes}
                                onChange={(e) => setItem({ ...item, notes: e.target.value })}
                                maxLength={255}
                            ></textarea>
                        </div>

                        {/* Location Information */}
                        <div className="card">
                            <h3>Location Information</h3>
                            <input
                                type="text"
                                placeholder="Building Name"
                                value={location.buildingName}
                                onChange={(e) =>
                                    setLocation({ ...location, buildingName: e.target.value })
                                }
                            />
                            <input
                                type="text"
                                placeholder="Location Description"
                                value={location.description}
                                onChange={(e) =>
                                    setLocation({ ...location, description: e.target.value })
                                }
                            />
                            <input
                                type="text"
                                placeholder="Street Address"
                                value={location.streetAddress}
                                onChange={(e) =>
                                    setLocation({ ...location, streetAddress: e.target.value })
                                }
                            />
                            <input
                                type="text"
                                placeholder="City"
                                value={location.city}
                                onChange={(e) =>
                                    setLocation({ ...location, city: e.target.value })
                                }
                            />
                            <input
                                type="text"
                                placeholder="State"
                                value={location.state}
                                onChange={(e) =>
                                    setLocation({ ...location, state: e.target.value })
                                }
                            />
                            <input
                                type="text"
                                placeholder="Zipcode"
                                value={location.zipcode}
                                onChange={(e) =>
                                    setLocation({ ...location, zipcode: e.target.value })
                                }
                            />
                        </div>

                        {/* Tags to Remove */}
                        <div className="card">
                            <h3>Remove Tags</h3>
                            <p>Current Tags: {currentTags.map((t) => t.name).join(", ")}</p>
                            <Select
                                isMulti
                                options={allTags}
                                value={tagsToRemove}
                                onChange={setTagsToRemove}
                                className="react-select-container"
                                classNamePrefix="react-select"
                                placeholder="Select tags to remove"
                            />
                        </div>

                        {/* Submit Button */}
                        <div className="card">
                            <button className="submit-button" onClick={handleSubmitEdit}>Submit Changes</button>
                        </div>
                    </>
                )}
            </div>
        </div>
    );
}
