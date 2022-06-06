inductionMatrix = require('mekanism.inductionMatrix')

local mekanism = {}

function mekanism.setup(matrixList, parent)
    inductionMatrix.setup(matrixList, parent)
end

function mekanism.mainLoop(matrixList)
    inductionMatrix.mainLoop(matrixList)
end

return mekanism
