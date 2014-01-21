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
    materialEmpty = new THREE.MeshLambertMaterial(
        color: 0xffffff
        map: textureempty
    )
    materialFull = new THREE.MeshLambertMaterial(
        color: 0xffffff
        map: texturefull
    )

    worldNode = new THREE.Object3D()
    boxNode = new THREE.Object3D()
    boxNode.position.z = -25

    worldNode.add(boxNode)
    scene.add(worldNode)

    #worldNode.position.set(0, 200, 0)
    for row in [0..(rows-1)]
        for col in [0..(columns-1)]
            cube = new THREE.Mesh(geometry, materialEmpty)
            boxNode.add(cube)
            cube.position.set((columns * -0.5) + col, (rows * -0.5) + row, 0)

            boxes[row][col] = cube

    cells = ((0 for x in [0..(columns-1)]) for x in [0..(rows-1)])
    cells[3][6] = 1
    cells[4][7] = 1
    cells[5][5] = 1
    cells[5][6] = 1
    cells[5][7] = 1

    directionalLight = new THREE.DirectionalLight(0xffffff, 0.5)
    directionalLight.position.set(0, 1, 5)
    scene.add(directionalLight)

    ambientLight = new THREE.AmbientLight(0x999999)
    scene.add(ambientLight)

    camera.position.z = 5

    getCell = (cells, y, x) ->
        resolvedX = x
        resolvedY = y

        if x < 0
            resolvedX = columns + x
        else if x >= columns
            resolvedX = x % columns

        if y < 0
            resolvedY = rows + y
        else if y >= rows
            resolvedY = y % rows

        cells[resolvedY][resolvedX]

    countsiblingcells = (cells, x, y) ->
        return getCell(cells, y - 1, x - 1) +
               getCell(cells, y, x - 1) +
               getCell(cells, y + 1, x - 1) +
               getCell(cells, y - 1, x) +
               getCell(cells, y + 1, x) +
               getCell(cells, y - 1, x + 1) +
               getCell(cells, y, x + 1) +
               getCell(cells, y + 1, x + 1)

    processcells = (cells) ->
        # Make a deep copy to reference
        newcells = $.map(cells, (object) ->
            [object.slice()]
        )

        for row in [0..(rows-1)]
            for col in [0..(columns-1)]
                neighbours = countsiblingcells(newcells, col, row)

                if newcells[row][col] == 1
                    if neighbours < 2
                        cells[row][col] = 0
                    else if 2 <= neighbours <= 3
                        @
                    else if neighbours > 3
                        cells[row][col] = 0
                else
                    if neighbours == 3
                        cells[row][col] = 1

    document.body.appendChild(renderer.domElement)

    render = () ->
        processcells(cells)

        for row in [0..(rows-1)]
            for col in [0..(columns-1)]
                if cells[row][col] == 1
                    boxes[row][col].material = materialFull
                else
                    boxes[row][col].material = materialEmpty

        renderer.render(scene, camera)
        window.requestAnimationFrame(render)

    render()
)