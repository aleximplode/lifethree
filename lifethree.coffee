width = window.innerWidth
height = window.innerHeight

scene = new THREE.Scene()
camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000)

renderer = new THREE.WebGLRenderer()
renderer.setSize(width, height)
document.body.appendChild(renderer.domElement)