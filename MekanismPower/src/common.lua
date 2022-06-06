local common = {}


function common.formatNumber(number)
    local mill = math.floor(number/1000)
    if mill == 0 then
        return mill
    else
        local unit = math.floor(number-(mill*1000))
        if mill > 1000 then
            mill = common.formatNumber(mill)
        end
        if unit < 10 then
            return mill..".00"..unit
        elseif unit < 100 then
            return mill..".0"..unit
        elseif unit < 1000 then
            return mill.."."..unit
        end
    end
end

return common
