import { useState } from 'react'
import * as ColorUtil from './utils/colors' 
import './App.css'

function App() {
    const [bgColor, setBgColor] = useState(null)
    
    async function handleColorButtonClick() {
        const {r, g, b} = ColorUtil.getRandomColor()
        setBgColor(ColorUtil.rgbToString(r, g, b))

        try {
            const res = await fetch("http://127.0.0.1:8000/api/test")
            const data = await res.json()
            console.log("Django response: ", data)
        } catch (err) {
            console.error("Failed to fetch from backend: ", err)
        }
    }

    return (
        <div className="fullscreen-container" 
            style={{
                padding: '25px', 
                backgroundColor: 'rgb(35, 35, 35)'
            }}>
            
            <button onClick={handleColorButtonClick}
                    className="custom-button"
                    style={{
                        height: '100px',
                        width: '400px',
                        margin: '0 auto',
                        display: 'block',
                        ...(bgColor && { backgroundColor: bgColor })
                    }}>
                Console Log Test
            </button>
        </div>
    )
}

export default App
