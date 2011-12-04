CreateFrame('GameTooltip', 'NecroticTooltip', nil, 'GameTooltipTemplate'):SetOwner(WorldFrame, 'ANCHOR_NONE')

local function GetNecroticStrikeAbsorption(buff)
  NecroticTooltip:ClearLines()
  NecroticTooltip:SetUnitDebuff('player', buff:GetID())
  return tonumber(NecroticTooltipTextLeft2:GetText():match('.* (%d+%s?) .*'))
end

local function short(n)
  return n >= 1000 and ('%dk'):format(floor(n / 1000)) or
         n >= 100  and ('%dh'):format(floor(n / 100 )) or n
end

local NecroticStrike = GetSpellInfo(73975)

hooksecurefunc('AuraButton_Update', function(buttonName, index, filter)
  local name = UnitAura('player', index, filter)

  if name ~= NecroticStrike then return end

  local buffName = buttonName .. index
  local buff = _G[ buffName ]

  if buff and buff.count then
    local absorption = GetNecroticStrikeAbsorption(buff)
    if absorption then
      buff.count:SetText(short(absorption))
      buff.count:Show()
      return true
    end
  end
end)
