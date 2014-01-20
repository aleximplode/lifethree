$(() ->
    width = window.innerWidth
    height = window.innerHeight
    columns = 40
    rows = 40
    transitionPeriod = 1.5
    backgroundColour = 0xffffff

    scene = new THREE.Scene()
    camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000)

    renderer = new THREE.WebGLRenderer()
    renderer.setSize(width, height)
    renderer.setClearColor(new THREE.Color(backgroundColour))

    scene.add(camera)

    texture = THREE.ImageUtils.loadTexture('textures/box.png')
    geometry = new THREE.CubeGeometry(1,1,1)
    material = new THREE.MeshLambertMaterial(
        color: 0xffffff
        map: texture
    )
    cube = new THREE.Mesh(geometry, material)
    scene.add(cube)

    directionalLight = new THREE.DirectionalLight(0xffffff, 0.5)
    directionalLight.position.set(0, 1, 5)
    scene.add(directionalLight)

    ambientLight = new THREE.AmbientLight(0x999999)
    scene.add(ambientLight)

    camera.position.z = 5

    document.body.appendChild(renderer.domElement)

    render = () ->
        cube.rotation.x += 0.01
        cube.rotation.y += 0.01

        renderer.render(scene, camera)
        window.requestAnimationFrame(render)

    render()
)

