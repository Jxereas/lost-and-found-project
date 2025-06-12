import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';

function AddLostItem ({adminInfo}){
    const [itemName, setItemName] = useState('');
    const [color, setColor] = useState('');
    const [description, setDescription]= useState('');
    const [lastSeen, setLastSeen] = useState('');
    const [tagIds,SetTagIds]= useState([]);
    const [locations,setLocations]= useState([]);
    const [tags,setTags]= useState([]);
    const [isClaimed,setIsClaimed]= useState('N');

    const navigate = useNavigate();
    useEffect(() => {
        fetch('http://localhost:8000/api/locations/')
            .then(res => res.json())
            .then(data => setLocations(data));

        fetch('http://localhost:8000/api/tags/')
            .then(res => res.json())
            .then(data => setTags(data));
    }, []);

    const handleSubmit = async (e) => {
        e.preventDefault();

        const payload = {
            item: {
                name: itemName,
                color: color,
                description: description
            },
            last_seen: lastSeen,
            tag_ids: tagIds,
            admin_id: adminInfo.id,
            is_claimed: isClaimed
        };

        try {
            const response = await fetch('http://localhost:8000/api/lostitems/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                credentials: 'include',
                body: JSON.stringify(payload)
            });

            if (response.ok) {
                alert('Item added!');
                navigate('/dashboard');
            } else {
                const errorText = await response.text();
                console.error('Server error:', errorText);
                alert('Error adding item!');
            }
        } catch (error) {
            console.error('Error:', error);
            alert('Something went wrong!');
        }
    };

return (
    <div className="add-lost-item-container">
        <h2>Add Lost Item</h2>
        <form onSubmit={handleSubmit}>
            <input placeholder="Item Name" value={itemName} onChange={e => setItemName(e.target.value)} required/>
            <input placeholder="Color" value={color} onChange={e => setColor(e.target.value)}/>
            <textarea placeholder="Description" value={description} onChange={e => setDescription(e.target.value)}/>

            <input
                type="text"
                placeholder="Last seen location"
                value={lastSeen}
                onChange={e => setLastSeen(e.target.value)}
                required
            />

            <label>Last Seen:</label>
            <div>
                {tags.map(tag => (
                    <label key={tag.id}>
                        <input
                            type="checkbox"
                            value={tag.id}
                            checked={tagIds.includes(tag.id)}
                            onChange={e => {
                                const checked = e.target.checked;
                                SetTagIds(prev =>
                                    checked ? [...prev, tag.id] : prev.filter(id => id !== tag.id)
                                );
                            }}
                        />
                        {tag.name}
                    </label>
                ))}
            </div>

            <label>Claimed:</label>
            <select value={isClaimed} onChange={e => setIsClaimed(e.target.value)}>
                <option value="N">No</option>
                <option value="Y">Yes</option>
            </select>

            <button type="submit">Add Item</button>
        </form>
    </div>
);
}

export default AddLostItem;

