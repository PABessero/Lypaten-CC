local config = require('config')
local mekanism = require('mekanism.mekanismCore')

local mainMonitor = peripheral.wrap(config.mainMonitor.code)
local mainMonitorWidth, mainMonitorHeight = mainMonitor.getSize()
local testWindow = window.create(mainMonitor, 16, 1, mainMonitorWidth-16, mainMonitorHeight)
testWindow.setCursorPos(1, 1)
testWindow.setBackgroundColor(colors.red)
testWindow.write('test')

mekanism.setup(config.matrixList, testWindow)
