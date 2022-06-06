local common = require('/common')

---@type table
---p = Peripheral code
---pp = Peripheral (wrap)
---m = Specific monitor
---mp = Specific monitor (wrap)
---name = Name
local additionalMatrix = {
    {
        matrixCode = 'inductionPort_3',
        name = 'Main Power Storage',
        monitor = {
            code = ''
        }
    },
}

local mainPower = peripheral.wrap('inductionPort_3')

local mainMonitor = peripheral.find("monitor")
mainMonitor.setTextColor(colors.white)
mainMonitor.setTextScale(1)
mainMonitor.clear()
mainMonitor.setCursorPos(5,2)
mainMonitor.write('Stored')

local function bindPeripherals()
    local line = 0
    for i, v in pairs(additionalMatrix) do
        additionalMatrix[i].matrix = peripheral.wrap(additionalMatrix[i].matrixCode)
        if additionalMatrix[i].monitorCode then
            additionalMatrix[i].monitor = peripheral.wrap(additionalMatrix[i].m)
        end
        print(additionalMatrix[i].matrixCode)
        print(additionalMatrix[i].matrix)

        additionalMatrix[i].nameWindow = window.create(mainMonitor, 1, i+line+3, 40, 1)
        additionalMatrix[i].powerStorageWindow = window.create(mainMonitor, 1, i+line+4, 40, 1)
        additionalMatrix[i].powerThroughputWindow = window.create(mainMonitor, 1, i+line+5, 40, 1)

        additionalMatrix[i].nameWindow.setBackgroundColor(colors.blue)
        additionalMatrix[i].powerStorageWindow.setBackgroundColor(colors.lightBlue)
        additionalMatrix[i].powerThroughputWindow.setBackgroundColor(colors.lightBlue)


        additionalMatrix[i].nameWindow.clear()
        additionalMatrix[i].nameWindow.setCursorPos(2,1)
        additionalMatrix[i].nameWindow.write(additionalMatrix[i].name)

        additionalMatrix[i].powerStorageWindow.clear()
        additionalMatrix[i].powerStorageWindow.setCursorPos(2, 1)
        additionalMatrix[i].powerStorageWindow.write('powerStorageWindow')

        additionalMatrix[i].powerThroughputWindow.clear()
        additionalMatrix[i].powerThroughputWindow.setCursorPos(2, 1)
        additionalMatrix[i].powerThroughputWindow.write('powerThroughputWindow')

        line = line+3
    end
end

local function writeInfo(matrix)
    local storedRfString = common.formatNumber(matrix.matrix.getEnergy()/2.5)
    local storedRfSize = string.len(storedRfString)

    local lastRfInput = matrix.matrix.getLastInput()/2.5
    local lastRfOutput = matrix.matrix.getLastOutput()/2.5

    local rfThroughputString = common.formatNumber(math.abs(lastRfInput - lastRfOutput))

    if lastRfInput - lastRfOutput == 0 then
        rfThroughputString = '0'
    elseif lastRfInput - lastRfOutput > 0 then
        rfThroughputString = '+ '..rfThroughputString
    elseif lastRfInput - lastRfOutput < 0 then
        rfThroughputString = '- '..rfThroughputString
    end

    local rfThroughputSize = string.len(rfThroughputString)

    if rfThroughputString == '0' then
        matrix.powerThroughputWindow.setTextColor(colors.white)
    elseif lastRfInput < lastRfOutput then
        matrix.powerThroughputWindow.setTextColor(colors.red)
    else
        matrix.powerThroughputWindow.setTextColor(colors.green)
    end

    matrix.powerStorageWindow.clear()
    matrix.powerStorageWindow.setCursorPos(40-storedRfSize, 1)
    matrix.powerStorageWindow.write(storedRfString)

    matrix.powerThroughputWindow.clear()
    matrix.powerThroughputWindow.setCursorPos(40-rfThroughputSize, 1)
    matrix.powerThroughputWindow.write(rfThroughputString)
end

function main()
    bindPeripherals()
    while true do
        for i, v in pairs(additionalMatrix) do
            writeInfo(additionalMatrix[i])
        end

        sleep(5)
    end
end

main()
