import React from "react";
import { Link } from "react-router-dom";

function EditForm() {
    return (
        <div style={{ padding: "2rem" }}>
            <a href="/dashboard" style={{ display: "inline-block", marginBottom: "1rem" }}>
                ← Back to Dashboard
            </a>
            <h1>Edit Item</h1>
        </div>
    );
}

export default EditForm;
