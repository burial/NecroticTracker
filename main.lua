CreateFrame('GameTooltip', 'NecroticTrackerTooltip', nil, 'GameTooltipTemplate'):SetOwner(WorldFrame, 'ANCHOR_NONE')

local function GetAbsorption(buff)
  NecroticTrackerTooltip:ClearLines()
  NecroticTrackerTooltip:SetUnitDebuff('player', buff:GetID())
  return tonumber(NecroticTrackerTooltipTextLeft2:GetText():match('.* (%d+%s?) .*'))
end

local function short(n)
  return n >= 1000 and ('%dk'):format(floor(n / 1000)) or
         n >= 100  and ('%dh'):format(floor(n / 100 )) or n
end

hooksecurefunc('AuraButton_Update', function(buttonName, index, filter)
  if select(7, UnitAura('player', index, filter)) ~= 73975 then return end

  local buff = _G[ buttonName .. index ]
  local absorption = GetAbsorption(buff)

  if absorption then
    buff.count:SetText(short(absorption))
    buff.count:Show()
    return true
  end
end)
