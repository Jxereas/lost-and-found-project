function getRandomColor() {
    const r = Math.floor(Math.random() * 256)
    const g = Math.floor(Math.random() * 256)
    const b = Math.floor(Math.random() * 256)
    return {r, g, b}
}

function rgbToString(r, g, b) {
    return `rgb(${r}, ${g}, ${b})`
}

export {getRandomColor, rgbToString}
