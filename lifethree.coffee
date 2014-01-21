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

    boxes = ((null for x in [0..(columns-1)]) for x in [0..(rows-1)])
    textureempty = THREE.ImageUtils.loadTexture('textures/box.png')
    texturefull = THREE.ImageUtils.loadTexture('textures/boxfull.png')

    geometry = new THREE.CubeGeometry(1,1,1)
    material = new THREE.MeshLambertMaterial(
        color: 0xffffff
        map: textureempty
    )

    worldNode = new THREE.Object3D()
    boxNode = new THREE.Object3D()
    boxNode.position.z = -25

    worldNode.add(boxNode)
    scene.add(worldNode)

    #worldNode.position.set(0, 200, 0)
    for row in [0..(rows-1)]
        for col in [0..(columns-1)]
            cube = new THREE.Mesh(geometry, material)
            boxNode.add(cube)
            cube.position.set((columns * -0.5) + col, (rows * -0.5) + row, 0)

            boxes[row][col] = cube

    directionalLight = new THREE.DirectionalLight(0xffffff, 0.5)
    directionalLight.position.set(0, 1, 5)
    scene.add(directionalLight)

    ambientLight = new THREE.AmbientLight(0x999999)
    scene.add(ambientLight)

    camera.position.z = 5

    document.body.appendChild(renderer.domElement)

    render = () ->
        boxNode.rotation.x += 0.01
        boxNode.rotation.y += 0.01

        renderer.render(scene, camera)
        window.requestAnimationFrame(render)

    render()
)

