local WarlockTalentGuide = CreateFrame("Frame", "WarlockTalentGuide", UIParent)
WarlockTalentGuide:SetWidth(220)  
WarlockTalentGuide:SetHeight(160)
WarlockTalentGuide:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
WarlockTalentGuide:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",  
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",    
    tile = true,                                         
    tileSize = 16,                                     
    edgeSize = 16,                                       
    insets = { left = 4, right = 4, top = 4, bottom = 4 } 
})
WarlockTalentGuide:SetBackdropColor(0, 0, 0, 0.8)
WarlockTalentGuide:SetBackdropBorderColor(1, 1, 1, 1)  
WarlockTalentGuide:EnableMouse(true)
WarlockTalentGuide:SetMovable(true)
WarlockTalentGuide:RegisterForDrag("LeftButton")
WarlockTalentGuide:SetScript("OnDragStart", function() WarlockTalentGuide:StartMoving() end)
WarlockTalentGuide:SetScript("OnDragStop", function() WarlockTalentGuide:StopMovingOrSizing() end)

-- Sample talent order (Level -> {Talent Name, Icon Path})
local talentOrder = {
    [10] = {"Improved Corruption Rank 1", "Interface\\Icons\\spell_shadow_abominationexplosion"},
    [11] = {"Improved Corruption Rank 2", "Interface\\Icons\\spell_shadow_abominationexplosion"},
    [12] = {"Improved Corruption Rank 3", "Interface\\Icons\\spell_shadow_abominationexplosion"},
    [13] = {"Improved Corruption Rank 4", "Interface\\Icons\\spell_shadow_abominationexplosion"},
    [14] = {"Improved Corruption Rank 5", "Interface\\Icons\\spell_shadow_abominationexplosion"},
    [15] = {"Demonic Embrace Rank 1", "Interface\\Icons\\spell_shadow_metamorphosis"},
    [16] = {"Demonic Embrace Rank 2", "Interface\\Icons\\spell_shadow_metamorphosis"},
    [17] = {"Demonic Embrace Rank 3", "Interface\\Icons\\spell_shadow_metamorphosis"},
    [18] = {"Demonic Embrace Rank 4", "Interface\\Icons\\spell_shadow_metamorphosis"},
    [19] = {"Demonic Embrace Rank 5", "Interface\\Icons\\spell_shadow_metamorphosis"},
    [20] = {"Improved Voidwalker Rank 1", "Interface\\Icons\\spell_shadow_summonvoidwalker"},
    [21] = {"Improved Voidwalker Rank 2", "Interface\\Icons\\spell_shadow_summonvoidwalker"},
    [22] = {"Improved Voidwalker Rank 3", "Interface\\Icons\\spell_shadow_summonvoidwalker"},
    [23] = {"Improved Healthstone Rank 1", "Interface\\Icons\\inv_stone_04"},
    [24] = {"Improved Healthstone Rank 2", "Interface\\Icons\\inv_stone_04"},
    [25] = {"Fel Domination", "Interface\\Icons\\spell_nature_removecurse"},
    [26] = {"Fel Stamina Rank 1", "Interface\\Icons\\spell_shadow_antishadow"},
    [27] = {"Fel Stamina Rank 2", "Interface\\Icons\\spell_shadow_antishadow"},
    [28] = {"Fel Stamina Rank 3", "Interface\\Icons\\spell_shadow_antishadow"},
    [29] = {"Fel Stamina Rank 4", "Interface\\Icons\\spell_shadow_antishadow"},
    [30] = {"Master Summoner Rank 1", "Interface\\Icons\\spell_shadow_impphaseshift"},
    [31] = {"Master Summoner Rank 2", "Interface\\Icons\\spell_shadow_impphaseshift"},
    [32] = {"Fel Stamina Rank 5", "Interface\\Icons\\spell_shadow_antishadow"},
    [33] = {"Unholy Power Rank 1", "Interface\\Icons\\spell_shadow_shadowworddominate"},
    [34] = {"Unholy Power Rank 2", "Interface\\Icons\\spell_shadow_shadowworddominate"},
    [35] = {"Unholy Power Rank 3", "Interface\\Icons\\spell_shadow_shadowworddominate"},
    [36] = {"Unholy Power Rank 4", "Interface\\Icons\\spell_shadow_shadowworddominate"},
    [37] = {"Unholy Power Rank 5", "Interface\\Icons\\spell_shadow_shadowworddominate"},
    [38] = {"Fel Intellect Rank 1", "Interface\\Icons\\spell_holy_magicalsentry"},
    [39] = {"Demonic Sacrifice", "Interface\\Icons\\spell_shadow_psychicscream"},
    [40] = {"Master Demonologist Rank 1", "Interface\\Icons\\spell_shadow_shadowpact"},
    [41] = {"Master Demonologist Rank 2", "Interface\\Icons\\spell_shadow_shadowpact"},
    [42] = {"Master Demonologist Rank 3", "Interface\\Icons\\spell_shadow_shadowpact"},
    [43] = {"Master Demonologist Rank 4", "Interface\\Icons\\spell_shadow_shadowpact"},
    [44] = {"Master Demonologist Rank 5", "Interface\\Icons\\spell_shadow_shadowpact"},
    [45] = {"Soul Link", "Interface\\Icons\\spell_shadow_gathershadows"},
    [46] = {"Improved Drain Life Rank 1", "Interface\\Icons\\spell_shadow_lifedrain"},
    [47] = {"Improved Drain Life Rank 2", "Interface\\Icons\\spell_shadow_lifedrain"},
    [48] = {"Improved Drain Life Rank 3", "Interface\\Icons\\spell_shadow_lifedrain"},
    [49] = {"Improved Drain Life Rank 4", "Interface\\Icons\\spell_shadow_lifedrain"},
    [50] = {"Improved Drain Life Rank 5", "Interface\\Icons\\spell_shadow_lifedrain"},
    [51] = {"Fel Concentration Rank 1", "Interface\\Icons\\spell_shadow_fingerofdeath"},
    [52] = {"Fel Concentration Rank 2", "Interface\\Icons\\spell_shadow_fingerofdeath"},
    [53] = {"Fel Concentration Rank 3", "Interface\\Icons\\spell_shadow_fingerofdeath"},
    [54] = {"Fel Concentration Rank 4", "Interface\\Icons\\spell_shadow_fingerofdeath"},
    [55] = {"Fel Concentration Rank 5", "Interface\\Icons\\spell_shadow_fingerofdeath"},
    [56] = {"Nightfall Rank 1", "Interface\\Icons\\spell_shadow_twilight"},
    [57] = {"Nightfall Rank 2", "Interface\\Icons\\spell_shadow_twilight"},
    [58] = {"Grim Reach Rank 1", "Interface\\Icons\\spell_shadow_callofbone"},
    [59] = {"Grim Reach Rank 2", "Interface\\Icons\\spell_shadow_callofbone"},
    [60] = {"Improved Life Tap Rank 1", "Interface\\Icons\\spell_shadow_impphaseshift"}
}

local function UpdateTalentDisplay()
    local level = UnitLevel("player")
    
    for i = 1, 3 do
        local talentLevel = level + (i - 1)
        local talentInfo = talentOrder[talentLevel]
        
        if talentInfo then
            local talentName, iconPath = unpack(talentInfo)
            
            if not WarlockTalentGuide["Talent" .. i] then
                local talentFrame = CreateFrame("Frame", nil, WarlockTalentGuide)
                talentFrame:SetWidth(190)
                talentFrame:SetHeight(30)
                talentFrame:SetPoint("TOP", WarlockTalentGuide, "TOP", 0, -((i - 1) * 35))

                local levelText = talentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                levelText:SetPoint("LEFT", talentFrame, "LEFT", 0, -20)
                levelText:SetText("lvl " .. talentLevel .. " :")

                local icon = talentFrame:CreateTexture(nil, "ARTWORK")
                icon:SetWidth(30)
                icon:SetHeight(30)
                icon:SetPoint("LEFT", levelText, "RIGHT", 5, -5)
                icon:SetTexture(iconPath)

                local text = talentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                text:SetPoint("LEFT", icon, "RIGHT", 8, 0)  
                text:SetWidth(120)  
                text:SetJustifyH("LEFT")
                text:SetText(talentName)

                talentFrame.levelText = levelText
                talentFrame.icon = icon
                talentFrame.text = text
                WarlockTalentGuide["Talent" .. i] = talentFrame
            else
                local talentFrame = WarlockTalentGuide["Talent" .. i]
                talentFrame.levelText:SetText("lvl " .. talentLevel .. " :")
                talentFrame.icon:SetTexture(iconPath)
                talentFrame.text:SetText(talentName)
            end
        end
    end
end

-- Event handling for level-up updates
WarlockTalentGuide:RegisterEvent("PLAYER_LEVEL_UP")
WarlockTalentGuide:RegisterEvent("PLAYER_ENTERING_WORLD")
WarlockTalentGuide:SetScript("OnEvent", function(self, event, ...) 
    UpdateTalentDisplay()
    if event == "PLAYER_LEVEL_UP" or event == "PLAYER_ENTERING_WORLD" then
        UpdateTalentDisplay()
    end 
end)

-- Initial update
UpdateTalentDisplay()
