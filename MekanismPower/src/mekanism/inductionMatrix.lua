local common = require('common')

local inductionMatrix = {}


function inductionMatrix.setup(matrixList, parent)
    local line = 0

    parentWidth, parentHeight = parent.getSize()

    for i, v in pairs(matrixList) do
        local matrix = matrixList[i]
        matrix.matrix = peripheral.wrap(matrix.matrixCode)
        if matrix.monitor.monitorCode then
            matrix.monitor.monitor = peripheral.wrap(matrix.monitor.monitorCode)
        end

        print('Induction Matrix: '..matrix.matrixCode)
        print(matrix.matrix)
        print('Induction Matrix Monitor: '..matrix.monitor.monitorCode)
        print(matrix.monitor.monitor)

        matrix.nameWindow = window.create(parent, 1, i+line+3, parentWidth, 1)
        matrix.nameWindow.setBackgroundColor(colors.blue)
        matrix.nameWindow.clear()
        matrix.nameWindow.setCursorPos(2 , 1)
        matrix.nameWindow.write(matrix.name)

        matrix.powerStorageWindow = window.create(parent, 1, i+line+4, parentWidth, 1)
        matrix.powerStorageWindow.setBackgroundColor(colors.lightBlue)
        matrix.powerStorageWindow.clear()
        matrix.powerStorageWindow.setCursorPos(2 , 1)
        matrix.powerStorageWindow.write('powerStorageWindow')

        matrix.powerThroughputWindow = window.create(parent, 1, i+line+5, parentWidth, 1)
        matrix.powerThroughputWindow.setBackgroundColor(colors.lightBlue)
        matrix.powerThroughputWindow.clear()
        matrix.powerThroughputWindow.setCursorPos(2 , 1)
        matrix.powerThroughputWindow.write('powerThroughputWindow')

        matrixList[i] = matrix

        line = line+3
    end
end


return inductionMatrix
