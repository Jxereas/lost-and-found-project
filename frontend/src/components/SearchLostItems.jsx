// SearchLostItems.jsx
import React, { useEffect, useState } from "react";
import "../styles/SearchLostItems.css";
import Select from "react-select";
import makeAnimated from "react-select/animated";

function SearchLostItems() {
    const [itemName, setItemName] = useState("");
    const [reporterFirstName, setReporterFirstName] = useState("");
    const [reporterLastName, setReporterLastName] = useState("");
    const [claimerFirstName, setClaimerFirstName] = useState("");
    const [claimerLastName, setClaimerLastName] = useState("");
    const [selectedLocation, setSelectedLocation] = useState(null);
    const [reportedStartDate, setReportedStartDate] = useState("");
    const [reportedEndDate, setReportedEndDate] = useState("");
    const [claimedStartDate, setClaimedStartDate] = useState("");
    const [claimedEndDate, setClaimedEndDate] = useState("");
    const [selectedTags, setSelectedTags] = useState([]);
    const [locations, setLocations] = useState([]);
    const [tags, setTags] = useState([]);

    const animatedComponents = makeAnimated();

    const tagOptions = tags.map((tag) => ({ value: tag, label: tag }));
    const locationOptions = [
        { value: "", label: "All Locations" },
        ...locations.map((loc) => ({ value: loc, label: loc })),
    ];

    useEffect(() => {
        fetch("http://localhost:8000/api/locations/")
            .then((res) => res.json())
            .then((data) => setLocations(data.locations))
            .catch((err) => console.error("Failed to fetch locations:", err));

        fetch("http://localhost:8000/api/tags/")
            .then((res) => res.json())
            .then((data) => setTags(data.tags))
            .catch((err) => console.error("Failed to fetch tags:", err));
    }, []);

    const handleSearch = () => {
        console.log({
            itemName,
            reporterFirstName,
            reporterLastName,
            claimerFirstName,
            claimerLastName,
            selectedLocation,
            selectedTags,
            reportedStartDate,
            reportedEndDate,
            claimedStartDate,
            claimedEndDate,
        });
    };

    return (
        <div className="search-container">
            <h2 className="search-title">Search Lost Items</h2>
            <div className="group-container">
                <div className="search-group">
                    <h3 className="search-group-title">Item</h3>
                    <input
                        type="text"
                        placeholder="Item Name"
                        value={itemName}
                        onChange={(e) => setItemName(e.target.value)}
                        className=""
                    />
                    <Select
                        components={animatedComponents}
                        options={locationOptions}
                        value={selectedLocation}
                        onChange={setSelectedLocation}
                        placeholder="Select a location"
                    />
                    <Select
                        closeMenuOnSelect={false}
                        components={animatedComponents}
                        isMulti
                        options={tagOptions}
                        value={selectedTags}
                        onChange={setSelectedTags}
                        placeholder="Select tags"
                    />
                </div>

                <div className="search-group">
                    <h3 className="search-group-title">Reporter</h3>
                    <input
                        type="text"
                        placeholder="First Name"
                        value={reporterFirstName}
                        onChange={(e) => setReporterFirstName(e.target.value)}
                    />
                    <input
                        type="text"
                        placeholder="Last Name"
                        value={reporterLastName}
                        onChange={(e) => setReporterLastName(e.target.value)}
                    />
                    <label>Reported Start Date:</label>
                    <input
                        type="date"
                        value={reportedStartDate}
                        onChange={(e) => setReportedStartDate(e.target.value)}
                    />
                    <label>Reported End Date:</label>
                    <input
                        type="date"
                        value={reportedEndDate}
                        onChange={(e) => setReportedEndDate(e.target.value)}
                    />
                </div>

                <div className="search-group">
                    <h3 className="search-group-title">Claimer</h3>
                    <input
                        type="text"
                        placeholder="First Name"
                        value={claimerFirstName}
                        onChange={(e) => setClaimerFirstName(e.target.value)}
                    />
                    <input
                        type="text"
                        placeholder="Last Name"
                        value={claimerLastName}
                        onChange={(e) => setClaimerLastName(e.target.value)}
                    />
                    <label>Claimed Start Date:</label>
                    <input
                        type="date"
                        value={claimedStartDate}
                        onChange={(e) => setClaimedStartDate(e.target.value)}
                    />
                    <label>Claimed End Date:</label>
                    <input
                        type="date"
                        value={claimedEndDate}
                        onChange={(e) => setClaimedEndDate(e.target.value)}
                    />
                </div>
            </div>
            <button className="search-button" onClick={handleSearch}>Search</button>
        </div>
    );
}

export default SearchLostItems;

