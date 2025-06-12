import React from "react";
import { useLocation, useNavigate } from "react-router-dom";
import '../styles/SearchLostItemsResults.css'

function SearchResultsPage() {
    const location = useLocation();
    const navigate = useNavigate();
    const results = location.state?.results || [];

    return (
        <div className="search-results-container">
            <h2>Search Results</h2>
            <button onClick={() => navigate(-1)}>← Back to Search</button>

            {results.length === 0 ? (
                <p>No results found.</p>
            ) : (
                <ul className="results-list">
                    {results.map((item, index) => (
                        <li key={index} className="result-card">
                            <h3>{item.itemName}</h3>
                            <p><strong>Description:</strong> {item.description}</p>
                            <p><strong>Color:</strong> {item.color}</p>
                            <p><strong>Location:</strong> {item.location}</p>
                            <p><strong>Reported by:</strong> {item.reporter.firstName} {item.reporter.lastName} on {item.reporter.dateReported}</p>
                            <p><strong>Claimed by:</strong> {item.claimer.firstName} {item.claimer.lastName} on {item.claimer.dateClaimed}</p>
                            <p><strong>Is Claimed:</strong> {item.isClaimed === "Y" ? "Yes" : "No"}</p>
                        </li>
                    ))}
                </ul>
            )}
        </div>
    );
}

export default SearchResultsPage;
