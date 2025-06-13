import React, { useEffect, useState } from "react";
import Select from "react-select";
import Sidebar from "./Sidebar";
import makeAnimated from "react-select/animated";
import "../styles/AddLostItems.css";

const animatedComponents = makeAnimated();

export default function AddLostItemScreen({ adminInfo, setAdminInfo }) {
  const [sidebarCollapsed, setSidebarCollapsed] = useState(false);
  const [tagOptions, setTagOptions] = useState([]);
  const [selectedTags, setSelectedTags] = useState([]);

  // Person Fields
  const [person, setPerson] = useState({
    firstname: "",
    lastname: "",
    email: "",
    phone: "",
    streetaddress: "",
    city: "",
    state: "",
    zipcode: "",
  });

  // Item Fields
  const [item, setItem] = useState({
    name: "",
    color: "",
    description: "",
    notes: "",
  });

  // Location Fields
  const [location, setLocation] = useState({
    buildingname: "",
    description: "",
    streetaddress: "",
    city: "",
    state: "",
    zipcode: "",
  });

  useEffect(() => {
    fetch("http://localhost:8000/api/tags-management/")
      .then((res) => res.json())
      .then((data) => {
        setTagOptions(
          data.tags.map((tag) => ({
            value: tag.id,
            label: tag.name,
          }))
        );
      });
  }, []);

  const handleSubmit = async () => {
        console.log(adminInfo.id);
    const payload = {
      adminId: adminInfo.id,
      person,
      item,
      location,
      tagIds: selectedTags.map((tag) => tag.value),
    };

    const res = await fetch("http://localhost:8000/api/lost-items/add/", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      credentials: "include",
      body: JSON.stringify(payload),
    });

    if (res.ok) {
      alert("Lost item successfully added.");
      setPerson({
        firstname: "",
        lastname: "",
        email: "",
        phone: "",
        streetaddress: "",
        city: "",
        state: "",
        zipcode: "",
      });
      setItem({ name: "", color: "", description: "", notes: "" });
      setLocation({
        buildingname: "",
        description: "",
        streetaddress: "",
        city: "",
        state: "",
        zipcode: "",
      });
      setSelectedTags([]);
    } else {
      alert("Error adding lost item.");
    }
  };

  const renderInput = (value, setValue, key, placeholder) => (
    <input
      type="text"
      value={value[key]}
      placeholder={placeholder}
      onChange={(e) => setValue({ ...value, [key]: e.target.value })}
    />
  );

  return (
    <div className="add-lost-container">
      <Sidebar
        collapsed={sidebarCollapsed}
        setCollapsed={setSidebarCollapsed}
        setAdminInfo={setAdminInfo}
      />
      <div className={`add-lost-main ${sidebarCollapsed ? "sidebar-collapsed" : ""}`}>
        <div className="card">
          <h2>Reporter Information</h2>
          {renderInput(person, setPerson, "firstname", "First Name")}
          {renderInput(person, setPerson, "lastname", "Last Name")}
          {renderInput(person, setPerson, "email", "Email")}
          {renderInput(person, setPerson, "phone", "Phone")}
          {renderInput(person, setPerson, "streetaddress", "Street Address")}
          {renderInput(person, setPerson, "city", "City")}
          {renderInput(person, setPerson, "state", "State")}
          {renderInput(person, setPerson, "zipcode", "Zipcode")}
        </div>

        <div className="card">
          <h2>Lost Item Information</h2>
          {renderInput(item, setItem, "name", "Item Name")}
          {renderInput(item, setItem, "color", "Color")}
          <textarea
            placeholder="Description"
            value={item.description}
            onChange={(e) => setItem({ ...item, description: e.target.value })}
            maxLength={255}
          ></textarea>
          <textarea
            placeholder="Notes (Optional)"
            value={item.notes}
            onChange={(e) => setItem({ ...item, notes: e.target.value })}
            maxLength={255}
          ></textarea>
          <Select
            isMulti
            options={tagOptions}
            components={animatedComponents}
            classNamePrefix="react-select"
            className="react-select-container"
            value={selectedTags}
            onChange={setSelectedTags}
            placeholder="Select Tags"
          />
        </div>

        <div className="card">
          <h2>Location Information</h2>
          {renderInput(location, setLocation, "buildingname", "Building Name")}
          <textarea
            placeholder="Location Description"
            value={location.description}
            onChange={(e) => setLocation({ ...location, description: e.target.value })}
            maxLength={255}
          ></textarea>
          {renderInput(location, setLocation, "streetaddress", "Street Address")}
          {renderInput(location, setLocation, "city", "City")}
          {renderInput(location, setLocation, "state", "State")}
          {renderInput(location, setLocation, "zipcode", "Zipcode")}
        </div>

        <button className="submit-button" onClick={handleSubmit}>Submit Lost Item</button>
      </div>
    </div>
  );
}

