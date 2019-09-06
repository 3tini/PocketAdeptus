local PA = PocketAdeptus
local LAM2 = LibAddonMenu2
local WM = WINDOW_MANAGER

local trials = {
     ["aa"] = "Aetherian Archive",
     ["as"] = "Asylum Sanctorium",
     ["cr"] = "Cloudrest",
     ["hof"] = "Halls of Fabrication",
     ["hrc"] = "Hel Ra Citadel",
     ["mol"] = "Maw of Lorkhaj",
     ["so"] = "Sanctum Ophidia",
     ["dsa"] = "Dragonstar Arena",
     ["ma"] = "Maelstrom Arena",
     ["brp"] = "Blackrose Prison",
     ["ss"] = "Sunspire",
     ["gen"] = "General PvE",
}
local cpNames = {
     ["ironclad"] = "Ironclad",
     ["spellShield"] = "Spell Shield",
     ["mediumArmorFocus"] = "Medium Armor Focus",
     ["resistant"] = "Resistant",
     ["hardy"] = "Hardy",
     ["thickSkinned"] = "Thick Skinned",
     ["eleDefender"] = "Elemental Defender",
     ["lightArmorFocus"] = "Light Armor Focus",
     ["bastion"] = "Bastion",
     ["quickRecovery"] = "Quick Recovery",
     ["expertDefender"] = "Expert Defender",
     ["heavyArmorFocus"] = "Heavy Armor Focus",
}

local cps = {
     [1] = "ironclad",
     [2] = "spellShield",
     [3] = "mediumArmorFocus",
     [4] = "resistant",
     [5] = "hardy",
     [6] = "thickSkinned",
     [7] = "eleDefender",
     [8] = "lightArmorFocus",
     [9] = "bastion",
     [10] = "quickRecovery",
     [11] = "expertDefender",
     [12] = "heavyArmorFocus",
}

local function SortTrials()
     local t = {}
     for key in pairs(trials) do
          table.insert(t, key)
     end
     table.sort(t)
     return t
end

local function GetToolTip(cpType)
     if        cpType == "ironclad" then
          return "Reduces your damage taken against direct damage attacks"
     elseif    cpType == "spellShield" then
          return "Increases your Spell Resistance"
     elseif    cpType == "mediumArmorFocus" then
          return "Increases your Physical Resistance while wearing 5 or more pieces of Medium Armor"
     elseif    cpType == "resistant" then
          return "Increases your Critical Resistance"
     elseif    cpType == "hardy" then
          return "Reduces your damage taken from Physical, Poison, and Disease Damage"
     elseif    cpType == "thickSkinned" then
          return "Reduces your damage taken from damage over time effects"
     elseif    cpType == "eleDefender" then
          return "Reduces your damage taken from Flame, Frost, Shock, and Magic Damage"
     elseif    cpType == "lightArmorFocus" then
          return "Increases your Physical Resistance while wearing 5 or more pieces of Light Armor"
     elseif    cpType == "bastion" then
          return "Increases the effectiveness of your damage shields"
     elseif    cpType == "quickRecovery" then
          return "Increases your healing received"
     elseif    cpType == "expertDefender" then
          return "Reduces your damage taken from player Light and Heavy Attacks"
     elseif    cpType == "heavyArmorFocus" then
          return "Increases your Physical Resistance while wearing 5 or more pieces of Heavy Armor"
     else
          return ""
     end
end

local function GetReference(instance, cpType)
     instance = string.upper(instance)
     cpType = cpType:sub(1,1):upper()..cpType:sub(2)
     return "Pocket_" .. instance .. "_" .. cpType
end

local function GenerateTrialSettings(instance)
     local trialName = trials[instance]
     local settingsIndex = #PA.Settings + 1
     PA.Settings[settingsIndex] = {
          type = "submenu",
          name = "|cAD601C" .. trialName .. "|r",
          tooltip = "CP Settings for Veteran " .. trialName,
          controls = {},
     }
     local count = 1
     for i = 1, 15 do
          if i == 1 then
               PA.Settings[settingsIndex].controls[i] = {
                    type = "header",
                    name = "|c513DEBThe Steed|r",
                    title = nil,
                    width = "full",
               }
          elseif i == 6 then
               PA.Settings[settingsIndex].controls[i] = {
                    type = "header",
                    name = "|c513DEBThe Lady|r",
                    title = nil,
                    width = "full",
               }
          elseif i == 11 then
               PA.Settings[settingsIndex].controls[i] = {
                    type = "header",
                    name = "|c513DEBThe Lord|r",
                    title = nil,
                    width = "full",
               }
          else
               local cpType = cps[count]
               count = count + 1
               PA.Settings[settingsIndex].controls[i] = {
                    type = "editbox",
                    name = cpNames[cpType],
                    tooltip = GetToolTip(cpType),
                    reference = GetReference(instance, cpType),
                    isMultiline = false,
                    width = "full",
                    default = function() return PA.defaults[instance][cpType] end,
                    getFunc = function() return PA.sv[instance][cpType] end,
                    setFunc = function(value)
                         local referenceFunc = WM:GetControlByName(GetReference(instance, cpType))
                         if type(tonumber(value)) == "number" then
                              if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                   PA.sv[instance][cpType] = tonumber(value)
                              else
                                   referenceFunc.editbox:SetText(PA.sv[instance][cpType])
                                   PA.alert("You must specify a number between 0 and 100")
                              end
                         else
                              referenceFunc.editbox:SetText(PA.sv[instance][cpType])
                              PA.alert("You must specify a number between 0 and 100")
                         end
                    end
               }
          end
     end
end

function PA.CreateSettingsWindow()
     local panelData = {
          type = "panel",
          name = "Pocket Adeptus",
          displayName = "|cAD601CPocket Adeptus Settings|r",
          author = "|c513DEB" .. PA.author .. "|r",
          version = "|c513DEB" .. PA.version .. "|r",
          slashCommand = "/pocket",
          registerForRefresh = true,
          registerForDefaults = true,
     }
     LAM2:RegisterAddonPanel(PA.name .. "Settings", panelData)

     PA.Settings = {
          {
               type = "header",
               name = "|cAD601CPocket Adeptus Information|r",
               width = "full"
          },
          {
               type = "description",
               text = "Pocket Adeptus was created to easily save and share raid CP settings",
               width = "full"
          },
          {
               type = "checkbox",
               name = "Auto-confirm CP changes",
               getFunc = function() return PA.sv.autoConfirm end,
               setFunc = function(value) PA.sv.autoConfirm = value end,
               disabled = false,
               default = false,
               requiresReload = true
          },
          {
               type = "checkbox",
               name = "Auto-set CP when entering trial",
               tooltip = "If enabled, the addon will set your CP upon entering the trial. If enabled, this setting will only work in Veteran instances. If you want to set your CP in a normal instance, use the /cpset command",
               getFunc = function() return PA.sv.SetOnZoneChange end,
               setFunc = function(value) PA.sv.SetOnZoneChange = value end,
               default = false,
               requiresReload = true
          },
          {
               type = "checkbox",
               name = "Use Global Configuration",
               tooltip = "If enabled, this character will use the global configuration, otherwise it will use per character settings",
               getFunc = function() return PocketAdeptusCharacterVars.Default[GetDisplayName()][GetCurrentCharacterId()].useGlobalVars end,
               setFunc = function(value) PocketAdeptusCharacterVars.Default[GetDisplayName()][GetCurrentCharacterId()].useGlobalVars = value end,
               default = true,
               requiresReload = true
          },
          {
               type = "button",
               name = "Update CP",
               warning = "Updates to the newest version of Pocket Adeptus CP. THIS WILL OVERRIDE CUSTOM TRIAL PRESETS",
               func = function() PA.UpdateCP() end
          },
     }
     local sortedTrials = SortTrials()
     for key, instance in ipairs(sortedTrials) do
          GenerateTrialSettings(instance)
     end
     LAM2:RegisterOptionControls(PA.name .. "Settings", PA.Settings)
end
