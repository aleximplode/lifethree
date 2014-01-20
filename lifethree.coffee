$(() ->
    width = window.innerWidth
    height = window.innerHeight

    scene = new THREE.Scene()
    camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000)

    renderer = new THREE.WebGLRenderer()
    renderer.setSize(width, height)

    scene.add(camera)

    geometry = new THREE.CubeGeometry(1,1,1)
    material = new THREE.MeshBasicMaterial(
        color: 0x00ff00
    )
    cube = new THREE.Mesh(geometry, material)
    scene.add(cube)

    camera.position.z = 5

    document.body.appendChild(renderer.domElement)

    render = () ->
        cube.rotation.x += 0.1
        cube.rotation.y += 0.1

        requestAnimationFrame(render)
        renderer.render(scene, camera)

    render()
)

