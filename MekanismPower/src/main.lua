local config = require('config')
local mekanism = require('mekanism.mekanismCore')

local mainMonitor = config.mainMonitor

mainMonitor.monitor = peripheral.wrap(mainMonitor.code)
mainMonitor.width, mainMonitor.height = mainMonitor.monitor.getSize()
mainMonitor.monitor.clear()

local monitorWindow = window.create(mainMonitor.monitor, 1, 1, mainMonitor.width, mainMonitor.height)


local configWindow = window.create(monitorWindow, config.configWindow.width, 1, mainMonitor.width-config.configWindow.width, mainMonitor.height)

local oldTerm = term.redirect(monitorWindow)
    paintutils.drawLine(config.configWindow.width+1,1,config.configWindow.width+1,mainMonitor.height,colors.red)
    monitorWindow.setBackgroundColor(colors.black)
term.redirect(oldTerm)

local mainWindow = window.create(monitorWindow, 16, 1, mainMonitor.width-16, mainMonitor.height)
mainWindow.setCursorPos(1, 1)


mekanism.setup(config.matrixList, mainWindow)
