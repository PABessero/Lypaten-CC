local config = require('config')
local mekanism = require('mekanism.mekanismCore')

local mainMonitor = config.mainMonitor

mainMonitor.monitor = peripheral.wrap(mainMonitor.code)
mainMonitor.width, mainMonitor.height = mainMonitor.monitor.getSize()
mainMonitor.monitor.clear()



local configWindow = window.create(mainMonitor, config.configWindow.width, 1, mainMonitor.width-config.configWindow.width, mainMonitor.height)

local oldTerm = term.redirect(mainMonitor)
    paintutils.drawLine(config.configWindow.width+2, 1, config.configWindow.width+2, mainMonitor.height, colors.red)
term.redirect(oldTerm)

local mainWindow = window.create(mainMonitor, 16, 1, mainMonitor.width-16, mainMonitor.height)
mainWindow.setCursorPos(1, 1)


mekanism.setup(config.matrixList, mainWindow)
