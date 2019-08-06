local PocketAdeptus = PocketAdeptus
local LAM2 = LibAddonMenu2

function PocketAdeptus.createSettingsWindow()
     if PocketAdeptus.useGlobalVars then
          svsettings = PocketAdeptusVars.Default[GetDisplayName()]['$AccountWide']
     else
          svsettings = PocketAdeptusCharacterVars.Default[GetDisplayName()][GetCurrentCharacterId()]
     end

     local panelData = {
          type = "panel",
          name = "Pocket Adeptus",
          displayName = "|cAD601CPocket Adeptus Settings|r",
          author = "|c513DEB" .. PocketAdeptus.author .. "|r",
          version = "|c513DEB" .. PocketAdeptus.version .. "|r",
          slashCommand = "/pocket",
          registerForRefresh = true,
          registerForDefaults = true,
     }
     LAM2:RegisterAddonPanel(PocketAdeptus.version .. "Settings", panelData)

     local Settings = {
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
               getFunc = function() return svsettings.autoConfirm end,
               setFunc = function(value) svsettings.autoConfirm = value end,
               disabled = false,
               default = false,
               requiresReload = true
          },
          {
               type = "checkbox",
               name = "Auto-set CP when entering trial",
               tooltip = "If enabled, the addon will set your CP upon entering the trial. If enabled, this setting will only work in Veteran instances. If you want to set your CP in a normal instance, use the /cpset command",
               getFunc = function() return svsettings.SetOnZoneChange end,
               setFunc = function(value) svsettings.SetOnZoneChange = value end,
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
               func = function() PocketAdeptus.UpdateCP() end
          },
          {
               type = "submenu",
               name = "|cAD601CAetherian Archive|r",
               tooltip = "CP Settings for Veteran Aetherian Archive",
               controls = {
                    {
                         type = "header",
                         name = "|c513DEBThe Steed|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Ironclad",
                         tooltip = "Reduces your damage taken against direct damage attacks",
                         reference = "Pocket_AA_Ironclad",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.aa.ironclad end,
                         getFunc = function() return svsettings.aa.ironclad end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.aa.ironclad = tonumber(value)
                                   else
                                        Pocket_AA_Ironclad.editbox:SetText(svsettings.aa.ironclad)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AA_Ironclad.editbox:SetText(svsettings.aa.ironclad)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Spell Shield",
                         tooltip = "Increases your Spell Resistance",
                         reference = "Pocket_AA_SpellShield",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.aa.spellShield end,
                         getFunc = function() return svsettings.aa.spellShield end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.aa.spellShield = tonumber(value)
                                   else
                                        Pocket_AA_SpellShield.editbox:SetText(svsettings.aa.spellShield)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AA_SpellShield.editbox:SetText(svsettings.aa.spellShield)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Medium Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Medium Armor",
                         reference = "Pocket_AA_MediumArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.aa.mediumArmorFocus end,
                         getFunc = function() return svsettings.aa.mediumArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.aa.mediumArmorFocus = tonumber(value)
                                   else
                                        Pocket_AA_MediumArmorFocus.editbox:SetText(svsettings.aa.mediumArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AA_MediumArmorFocus.editbox:SetText(svsettings.aa.mediumArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Resistant",
                         tooltip = "Increases your Critical Resistance",
                         reference = "Pocket_AA_Resistant",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.aa.resistant end,
                         getFunc = function() return svsettings.aa.resistant end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.aa.resistant = tonumber(value)
                                   else
                                        Pocket_AA_Resistant.editbox:SetText(svsettings.aa.resistant)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AA_Resistant.editbox:SetText(svsettings.aa.resistant)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lady|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Hardy",
                         tooltip = "Reduces your damage taken from Physical, Poison, and Disease Damage",
                         reference = "Pocket_AA_Hardy",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.aa.hardy end,
                         getFunc = function() return svsettings.aa.hardy end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.aa.hardy = tonumber(value)
                                   else
                                        Pocket_AA_Hardy.editbox:SetText(svsettings.aa.hardy)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AA_Hardy.editbox:SetText(svsettings.aa.hardy)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Thick Skinned",
                         tooltip = "Reduces your damage taken from damage over time effects",
                         reference = "Pocket_AA_ThickSkinned",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.aa.thickSkinned end,
                         getFunc = function() return svsettings.aa.thickSkinned end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.aa.thickSkinned = tonumber(value)
                                   else
                                        Pocket_AA_ThickSkinned.editbox:SetText(svsettings.aa.thickSkinned)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AA_ThickSkinned.editbox:SetText(svsettings.aa.thickSkinned)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Elemental Defender",
                         tooltip = "Reduces your damage taken from Flame, Frost, Shock, and Magic Damage",
                         reference = "Pocket_AA_EleDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.aa.eleDefender end,
                         getFunc = function() return svsettings.aa.eleDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.aa.eleDefender = tonumber(value)
                                   else
                                        Pocket_AA_EleDefender.editbox:SetText(svsettings.aa.eleDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AA_EleDefender.editbox:SetText(svsettings.aa.eleDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Light Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Light Armor",
                         reference = "Pocket_AA_LightArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.aa.lightArmorFocus end,
                         getFunc = function() return svsettings.aa.lightArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.aa.lightArmorFocus = tonumber(value)
                                   else
                                        Pocket_AA_LightArmorFocus.editbox:SetText(svsettings.aa.lightArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AA_LightArmorFocus.editbox:SetText(svsettings.aa.lightArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lord|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Bastion",
                         tooltip = "Increases the effectiveness of your damage shields",
                         reference = "Pocket_AA_Bastion",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.aa.bastion end,
                         getFunc = function() return svsettings.aa.bastion end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.aa.bastion = tonumber(value)
                                   else
                                        Pocket_AA_Bastion.editbox:SetText(svsettings.aa.bastion)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AA_Bastion.editbox:SetText(svsettings.aa.bastion)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Quick Recovery",
                         tooltip = "Increases your healing received",
                         reference = "Pocket_AA_QuickRecovery",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.aa.quickRecovery end,
                         getFunc = function() return svsettings.aa.quickRecovery end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.aa.quickRecovery = tonumber(value)
                                   else
                                        Pocket_AA_QuickRecovery.editbox:SetText(svsettings.aa.quickRecovery)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AA_QuickRecovery.editbox:SetText(svsettings.aa.quickRecovery)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Expert Defender",
                         tooltip = "Reduces your damage taken from player Light and Heavy Attacks",
                         reference = "Pocket_AA_ExpertDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.aa.expertDefender end,
                         getFunc = function() return svsettings.aa.expertDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.aa.expertDefender = tonumber(value)
                                   else
                                        Pocket_AA_ExpertDefender.editbox:SetText(svsettings.aa.expertDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AA_ExpertDefender.editbox:SetText(svsettings.aa.expertDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Heavy Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Heavy Armor",
                         reference = "Pocket_AA_HeavyArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.aa.heavyArmorFocus end,
                         getFunc = function() return svsettings.aa.heavyArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.aa.heavyArmorFocus = tonumber(value)
                                   else
                                        Pocket_AA_HeavyArmorFocus.editbox:SetText(svsettings.aa.heavyArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AA_HeavyArmorFocus.editbox:SetText(svsettings.aa.heavyArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
               },
          },
          {
               type = "submenu",
               name = "|cAD601CAsylum Sanctorium|r",
               tooltip = "CP Settings for Veteran Asylum Sanctorium",
               controls = {
                    {
                         type = "header",
                         name = "|c513DEBThe Steed|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Ironclad",
                         tooltip = "Reduces your damage taken against direct damage attacks",
                         reference = "Pocket_AS_Ironclad",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.as.ironclad end,
                         getFunc = function() return svsettings.as.ironclad end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.as.ironclad = tonumber(value)
                                   else
                                        Pocket_AS_Ironclad.editbox:SetText(svsettings.as.ironclad)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AS_Ironclad.editbox:SetText(svsettings.as.ironclad)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Spell Shield",
                         tooltip = "Increases your Spell Resistance",
                         reference = "Pocket_AS_SpellShield",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.as.spellShield end,
                         getFunc = function() return svsettings.as.spellShield end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.as.spellShield = tonumber(value)
                                   else
                                        Pocket_AS_SpellShield.editbox:SetText(svsettings.as.spellShield)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AS_SpellShield.editbox:SetText(svsettings.as.spellShield)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Medium Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Medium Armor",
                         reference = "Pocket_AS_MediumArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.as.mediumArmorFocus end,
                         getFunc = function() return svsettings.as.mediumArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.as.mediumArmorFocus = tonumber(value)
                                   else
                                        Pocket_AS_MediumArmorFocus.editbox:SetText(svsettings.as.mediumArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AS_MediumArmorFocus.editbox:SetText(svsettings.as.mediumArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Resistant",
                         tooltip = "Increases your Critical Resistance",
                         reference = "Pocket_AS_Resistant",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.as.resistant end,
                         getFunc = function() return svsettings.as.resistant end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.as.resistant = tonumber(value)
                                   else
                                        Pocket_AS_Resistant.editbox:SetText(svsettings.as.resistant)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AS_Resistant.editbox:SetText(svsettings.as.resistant)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lady|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Hardy",
                         tooltip = "Reduces your damage taken from Physical, Poison, and Disease Damage",
                         reference = "Pocket_AS_Hardy",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.as.hardy end,
                         getFunc = function() return svsettings.as.hardy end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.as.hardy = tonumber(value)
                                   else
                                        Pocket_AS_Hardy.editbox:SetText(svsettings.as.hardy)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AS_Hardy.editbox:SetText(svsettings.as.hardy)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Thick Skinned",
                         tooltip = "Reduces your damage taken from damage over time effects",
                         reference = "Pocket_AS_ThickSkinned",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.as.thickSkinned end,
                         getFunc = function() return svsettings.as.thickSkinned end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.as.thickSkinned = tonumber(value)
                                   else
                                        Pocket_AS_ThickSkinned.editbox:SetText(svsettings.as.thickSkinned)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AS_ThickSkinned.editbox:SetText(svsettings.as.thickSkinned)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Elemental Defender",
                         tooltip = "Reduces your damage taken from Flame, Frost, Shock, and Magic Damage",
                         reference = "Pocket_AS_EleDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.as.eleDefender end,
                         getFunc = function() return svsettings.as.eleDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.as.eleDefender = tonumber(value)
                                   else
                                        Pocket_AS_EleDefender.editbox:SetText(svsettings.as.eleDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AS_EleDefender.editbox:SetText(svsettings.as.eleDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Light Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Light Armor",
                         reference = "Pocket_AS_LightArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.as.lightArmorFocus end,
                         getFunc = function() return svsettings.as.lightArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.as.lightArmorFocus = tonumber(value)
                                   else
                                        Pocket_AS_LightArmorFocus.editbox:SetText(svsettings.as.lightArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AS_LightArmorFocus.editbox:SetText(svsettings.as.lightArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lord|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Bastion",
                         tooltip = "Increases the effectiveness of your damage shields",
                         reference = "Pocket_AS_Bastion",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.as.bastion end,
                         getFunc = function() return svsettings.as.bastion end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.as.bastion = tonumber(value)
                                   else
                                        Pocket_AS_Bastion.editbox:SetText(svsettings.as.bastion)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AS_Bastion.editbox:SetText(svsettings.as.bastion)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Quick Recovery",
                         tooltip = "Increases your healing received",
                         reference = "Pocket_AS_QuickRecovery",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.as.quickRecovery end,
                         getFunc = function() return svsettings.as.quickRecovery end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.as.quickRecovery = tonumber(value)
                                   else
                                        Pocket_AS_QuickRecovery.editbox:SetText(svsettings.as.quickRecovery)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AS_QuickRecovery.editbox:SetText(svsettings.as.quickRecovery)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Expert Defender",
                         tooltip = "Reduces your damage taken from player Light and Heavy Attacks",
                         reference = "Pocket_AS_ExpertDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.as.expertDefender end,
                         getFunc = function() return svsettings.as.expertDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.as.expertDefender = tonumber(value)
                                   else
                                        Pocket_AS_ExpertDefender.editbox:SetText(svsettings.as.expertDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AS_ExpertDefender.editbox:SetText(svsettings.as.expertDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Heavy Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Heavy Armor",
                         reference = "Pocket_AS_HeavyArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.as.heavyArmorFocus end,
                         getFunc = function() return svsettings.as.heavyArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.as.heavyArmorFocus = tonumber(value)
                                   else
                                        Pocket_AS_HeavyArmorFocus.editbox:SetText(svsettings.as.heavyArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_AS_HeavyArmorFocus.editbox:SetText(svsettings.as.heavyArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
               },
          },
          {
               type = "submenu",
               name = "|cAD601CCloudrest|r",
               tooltip = "CP Settings for Veteran Cloudrest",
               controls = {
                    {
                         type = "header",
                         name = "|c513DEBThe Steed|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Ironclad",
                         tooltip = "Reduces your damage taken against direct damage attacks",
                         reference = "Pocket_CR_Ironclad",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.cr.ironclad end,
                         getFunc = function() return svsettings.cr.ironclad end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.cr.ironclad = tonumber(value)
                                   else
                                        Pocket_CR_Ironclad.editbox:SetText(svsettings.cr.ironclad)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_CR_Ironclad.editbox:SetText(svsettings.cr.ironclad)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Spell Shield",
                         tooltip = "Increases your Spell Resistance",
                         reference = "Pocket_CR_SpellShield",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.cr.spellShield end,
                         getFunc = function() return svsettings.cr.spellShield end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.cr.spellShield = tonumber(value)
                                   else
                                        Pocket_CR_SpellShield.editbox:SetText(svsettings.cr.spellShield)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_CR_SpellShield.editbox:SetText(svsettings.cr.spellShield)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Medium Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Medium Armor",
                         reference = "Pocket_CR_MediumArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.cr.mediumArmorFocus end,
                         getFunc = function() return svsettings.cr.mediumArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.cr.mediumArmorFocus = tonumber(value)
                                   else
                                        Pocket_CR_MediumArmorFocus.editbox:SetText(svsettings.cr.mediumArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_CR_MediumArmorFocus.editbox:SetText(svsettings.cr.mediumArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Resistant",
                         tooltip = "Increases your Critical Resistance",
                         reference = "Pocket_CR_Resistant",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.cr.resistant end,
                         getFunc = function() return svsettings.cr.resistant end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.cr.resistant = tonumber(value)
                                   else
                                        Pocket_CR_Resistant.editbox:SetText(svsettings.cr.resistant)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_CR_Resistant.editbox:SetText(svsettings.cr.resistant)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lady|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Hardy",
                         tooltip = "Reduces your damage taken from Physical, Poison, and Disease Damage",
                         reference = "Pocket_CR_Hardy",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.cr.hardy end,
                         getFunc = function() return svsettings.cr.hardy end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.cr.hardy = tonumber(value)
                                   else
                                        Pocket_CR_Hardy.editbox:SetText(svsettings.cr.hardy)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_CR_Hardy.editbox:SetText(svsettings.cr.hardy)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Thick Skinned",
                         tooltip = "Reduces your damage taken from damage over time effects",
                         reference = "Pocket_CR_ThickSkinned",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.cr.thickSkinned end,
                         getFunc = function() return svsettings.cr.thickSkinned end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.cr.thickSkinned = tonumber(value)
                                   else
                                        Pocket_CR_ThickSkinned.editbox:SetText(svsettings.cr.thickSkinned)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_CR_ThickSkinned.editbox:SetText(svsettings.cr.thickSkinned)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Elemental Defender",
                         tooltip = "Reduces your damage taken from Flame, Frost, Shock, and Magic Damage",
                         reference = "Pocket_CR_EleDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.cr.eleDefender end,
                         getFunc = function() return svsettings.cr.eleDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.cr.eleDefender = tonumber(value)
                                   else
                                        Pocket_CR_EleDefender.editbox:SetText(svsettings.cr.eleDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_CR_EleDefender.editbox:SetText(svsettings.cr.eleDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Light Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Light Armor",
                         reference = "Pocket_CR_LightArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.cr.lightArmorFocus end,
                         getFunc = function() return svsettings.cr.lightArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.cr.lightArmorFocus = tonumber(value)
                                   else
                                        Pocket_CR_LightArmorFocus.editbox:SetText(svsettings.cr.lightArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_CR_LightArmorFocus.editbox:SetText(svsettings.cr.lightArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lord|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Bastion",
                         tooltip = "Increases the effectiveness of your damage shields",
                         reference = "Pocket_CR_Bastion",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.cr.bastion end,
                         getFunc = function() return svsettings.cr.bastion end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.cr.bastion = tonumber(value)
                                   else
                                        Pocket_CR_Bastion.editbox:SetText(svsettings.cr.bastion)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_CR_Bastion.editbox:SetText(svsettings.cr.bastion)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Quick Recovery",
                         tooltip = "Increases your healing received",
                         reference = "Pocket_CR_QuickRecovery",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.cr.quickRecovery end,
                         getFunc = function() return svsettings.cr.quickRecovery end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.cr.quickRecovery = tonumber(value)
                                   else
                                        Pocket_CR_QuickRecovery.editbox:SetText(svsettings.cr.quickRecovery)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_CR_QuickRecovery.editbox:SetText(svsettings.cr.quickRecovery)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Expert Defender",
                         tooltip = "Reduces your damage taken from player Light and Heavy Attacks",
                         reference = "Pocket_CR_ExpertDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.cr.expertDefender end,
                         getFunc = function() return svsettings.cr.expertDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.cr.expertDefender = tonumber(value)
                                   else
                                        Pocket_CR_ExpertDefender.editbox:SetText(svsettings.cr.expertDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_CR_ExpertDefender.editbox:SetText(svsettings.cr.expertDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Heavy Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Heavy Armor",
                         reference = "Pocket_CR_HeavyArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.cr.heavyArmorFocus end,
                         getFunc = function() return svsettings.cr.heavyArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.cr.heavyArmorFocus = tonumber(value)
                                   else
                                        Pocket_CR_HeavyArmorFocus.editbox:SetText(svsettings.cr.heavyArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_CR_HeavyArmorFocus.editbox:SetText(svsettings.cr.heavyArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
               },
          },
          {
               type = "submenu",
               name = "|cAD601CHalls of Fabrication|r",
               tooltip = "CP Settings for Veteran Halls of Fabrication",
               controls = {
                    {
                         type = "header",
                         name = "|c513DEBThe Steed|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Ironclad",
                         tooltip = "Reduces your damage taken against direct damage attacks",
                         reference = "Pocket_HOF_Ironclad",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hof.ironclad end,
                         getFunc = function() return svsettings.hof.ironclad end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hof.ironclad = tonumber(value)
                                   else
                                        Pocket_HOF_Ironclad.editbox:SetText(svsettings.hof.ironclad)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HOF_Ironclad.editbox:SetText(svsettings.hof.ironclad)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Spell Shield",
                         tooltip = "Increases your Spell Resistance",
                         reference = "Pocket_HOF_SpellShield",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hof.spellShield end,
                         getFunc = function() return svsettings.hof.spellShield end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hof.spellShield = tonumber(value)
                                   else
                                        Pocket_HOF_SpellShield.editbox:SetText(svsettings.hof.spellShield)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HOF_SpellShield.editbox:SetText(svsettings.hof.spellShield)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Medium Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Medium Armor",
                         reference = "Pocket_HOF_MediumArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hof.mediumArmorFocus end,
                         getFunc = function() return svsettings.hof.mediumArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hof.mediumArmorFocus = tonumber(value)
                                   else
                                        Pocket_HOF_MediumArmorFocus.editbox:SetText(svsettings.hof.mediumArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HOF_MediumArmorFocus.editbox:SetText(svsettings.hof.mediumArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Resistant",
                         tooltip = "Increases your Critical Resistance",
                         reference = "Pocket_HOF_Resistant",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hof.resistant end,
                         getFunc = function() return svsettings.hof.resistant end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hof.resistant = tonumber(value)
                                   else
                                        Pocket_HOF_Resistant.editbox:SetText(svsettings.hof.resistant)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HOF_Resistant.editbox:SetText(svsettings.hof.resistant)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lady|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Hardy",
                         tooltip = "Reduces your damage taken from Physical, Poison, and Disease Damage",
                         reference = "Pocket_HOF_Hardy",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hof.hardy end,
                         getFunc = function() return svsettings.hof.hardy end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hof.hardy = tonumber(value)
                                   else
                                        Pocket_HOF_Hardy.editbox:SetText(svsettings.hof.hardy)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HOF_Hardy.editbox:SetText(svsettings.hof.hardy)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Thick Skinned",
                         tooltip = "Reduces your damage taken from damage over time effects",
                         reference = "Pocket_HOF_ThickSkinned",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hof.thickSkinned end,
                         getFunc = function() return svsettings.hof.thickSkinned end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hof.thickSkinned = tonumber(value)
                                   else
                                        Pocket_HOF_ThickSkinned.editbox:SetText(svsettings.hof.thickSkinned)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HOF_ThickSkinned.editbox:SetText(svsettings.hof.thickSkinned)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Elemental Defender",
                         tooltip = "Reduces your damage taken from Flame, Frost, Shock, and Magic Damage",
                         reference = "Pocket_HOF_EleDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hof.eleDefender end,
                         getFunc = function() return svsettings.hof.eleDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hof.eleDefender = tonumber(value)
                                   else
                                        Pocket_HOF_EleDefender.editbox:SetText(svsettings.hof.eleDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HOF_EleDefender.editbox:SetText(svsettings.hof.eleDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Light Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Light Armor",
                         reference = "Pocket_HOF_LightArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hof.lightArmorFocus end,
                         getFunc = function() return svsettings.hof.lightArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hof.lightArmorFocus = tonumber(value)
                                   else
                                        Pocket_HOF_LightArmorFocus.editbox:SetText(svsettings.hof.lightArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HOF_LightArmorFocus.editbox:SetText(svsettings.hof.lightArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lord|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Bastion",
                         tooltip = "Increases the effectiveness of your damage shields",
                         reference = "Pocket_HOF_Bastion",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hof.bastion end,
                         getFunc = function() return svsettings.hof.bastion end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hof.bastion = tonumber(value)
                                   else
                                        Pocket_HOF_Bastion.editbox:SetText(svsettings.hof.bastion)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HOF_Bastion.editbox:SetText(svsettings.hof.bastion)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Quick Recovery",
                         tooltip = "Increases your healing received",
                         reference = "Pocket_HOF_QuickRecovery",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hof.quickRecovery end,
                         getFunc = function() return svsettings.hof.quickRecovery end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hof.quickRecovery = tonumber(value)
                                   else
                                        Pocket_HOF_QuickRecovery.editbox:SetText(svsettings.hof.quickRecovery)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HOF_QuickRecovery.editbox:SetText(svsettings.hof.quickRecovery)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Expert Defender",
                         tooltip = "Reduces your damage taken from player Light and Heavy Attacks",
                         reference = "Pocket_HOF_ExpertDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hof.expertDefender end,
                         getFunc = function() return svsettings.hof.expertDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hof.expertDefender = tonumber(value)
                                   else
                                        Pocket_HOF_ExpertDefender.editbox:SetText(svsettings.hof.expertDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HOF_ExpertDefender.editbox:SetText(svsettings.hof.expertDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Heavy Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Heavy Armor",
                         reference = "Pocket_HOF_HeavyArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hof.heavyArmorFocus end,
                         getFunc = function() return svsettings.hof.heavyArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hof.heavyArmorFocus = tonumber(value)
                                   else
                                        Pocket_HOF_HeavyArmorFocus.editbox:SetText(svsettings.hof.heavyArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HOF_HeavyArmorFocus.editbox:SetText(svsettings.hof.heavyArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
               },
          },
          {
               type = "submenu",
               name = "|cAD601CHel Ra Citadel|r",
               tooltip = "CP Settings for Veteran Hel Ra Citadel",
               controls = {
                    {
                         type = "header",
                         name = "|c513DEBThe Steed|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Ironclad",
                         tooltip = "Reduces your damage taken against direct damage attacks",
                         reference = "Pocket_HRC_Ironclad",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hrc.ironclad end,
                         getFunc = function() return svsettings.hrc.ironclad end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hrc.ironclad = tonumber(value)
                                   else
                                        Pocket_HRC_Ironclad.editbox:SetText(svsettings.hrc.ironclad)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HRC_Ironclad.editbox:SetText(svsettings.hrc.ironclad)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Spell Shield",
                         tooltip = "Increases your Spell Resistance",
                         reference = "Pocket_HRC_SpellShield",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hrc.spellShield end,
                         getFunc = function() return svsettings.hrc.spellShield end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hrc.spellShield = tonumber(value)
                                   else
                                        Pocket_HRC_SpellShield.editbox:SetText(svsettings.hrc.spellShield)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HRC_SpellShield.editbox:SetText(svsettings.hrc.spellShield)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Medium Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Medium Armor",
                         reference = "Pocket_HRC_MediumArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hrc.mediumArmorFocus end,
                         getFunc = function() return svsettings.hrc.mediumArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hrc.mediumArmorFocus = tonumber(value)
                                   else
                                        Pocket_HRC_MediumArmorFocus.editbox:SetText(svsettings.hrc.mediumArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HRC_MediumArmorFocus.editbox:SetText(svsettings.hrc.mediumArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Resistant",
                         tooltip = "Increases your Critical Resistance",
                         reference = "Pocket_HRC_Resistant",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hrc.resistant end,
                         getFunc = function() return svsettings.hrc.resistant end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hrc.resistant = tonumber(value)
                                   else
                                        Pocket_HRC_Resistant.editbox:SetText(svsettings.hrc.resistant)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HRC_Resistant.editbox:SetText(svsettings.hrc.resistant)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lady|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Hardy",
                         tooltip = "Reduces your damage taken from Physical, Poison, and Disease Damage",
                         reference = "Pocket_HRC_Hardy",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hrc.hardy end,
                         getFunc = function() return svsettings.hrc.hardy end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hrc.hardy = tonumber(value)
                                   else
                                        Pocket_HRC_Hardy.editbox:SetText(svsettings.hrc.hardy)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HRC_Hardy.editbox:SetText(svsettings.hrc.hardy)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Thick Skinned",
                         tooltip = "Reduces your damage taken from damage over time effects",
                         reference = "Pocket_HRC_ThickSkinned",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hrc.thickSkinned end,
                         getFunc = function() return svsettings.hrc.thickSkinned end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hrc.thickSkinned = tonumber(value)
                                   else
                                        Pocket_HRC_ThickSkinned.editbox:SetText(svsettings.hrc.thickSkinned)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HRC_ThickSkinned.editbox:SetText(svsettings.hrc.thickSkinned)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Elemental Defender",
                         tooltip = "Reduces your damage taken from Flame, Frost, Shock, and Magic Damage",
                         reference = "Pocket_HRC_EleDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hrc.eleDefender end,
                         getFunc = function() return svsettings.hrc.eleDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hrc.eleDefender = tonumber(value)
                                   else
                                        Pocket_HRC_EleDefender.editbox:SetText(svsettings.hrc.eleDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HRC_EleDefender.editbox:SetText(svsettings.hrc.eleDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Light Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Light Armor",
                         reference = "Pocket_HRC_LightArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hrc.lightArmorFocus end,
                         getFunc = function() return svsettings.hrc.lightArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hrc.lightArmorFocus = tonumber(value)
                                   else
                                        Pocket_HRC_LightArmorFocus.editbox:SetText(svsettings.hrc.lightArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HRC_LightArmorFocus.editbox:SetText(svsettings.hrc.lightArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lord|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Bastion",
                         tooltip = "Increases the effectiveness of your damage shields",
                         reference = "Pocket_HRC_Bastion",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hrc.bastion end,
                         getFunc = function() return svsettings.hrc.bastion end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hrc.bastion = tonumber(value)
                                   else
                                        Pocket_HRC_Bastion.editbox:SetText(svsettings.hrc.bastion)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HRC_Bastion.editbox:SetText(svsettings.hrc.bastion)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Quick Recovery",
                         tooltip = "Increases your healing received",
                         reference = "Pocket_HRC_QuickRecovery",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hrc.quickRecovery end,
                         getFunc = function() return svsettings.hrc.quickRecovery end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hrc.quickRecovery = tonumber(value)
                                   else
                                        Pocket_HRC_QuickRecovery.editbox:SetText(svsettings.hrc.quickRecovery)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HRC_QuickRecovery.editbox:SetText(svsettings.hrc.quickRecovery)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Expert Defender",
                         tooltip = "Reduces your damage taken from player Light and Heavy Attacks",
                         reference = "Pocket_HRC_ExpertDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hrc.expertDefender end,
                         getFunc = function() return svsettings.hrc.expertDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hrc.expertDefender = tonumber(value)
                                   else
                                        Pocket_HRC_ExpertDefender.editbox:SetText(svsettings.hrc.expertDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HRC_ExpertDefender.editbox:SetText(svsettings.hrc.expertDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Heavy Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Heavy Armor",
                         reference = "Pocket_HRC_HeavyArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.hrc.heavyArmorFocus end,
                         getFunc = function() return svsettings.hrc.heavyArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.hrc.heavyArmorFocus = tonumber(value)
                                   else
                                        Pocket_HRC_HeavyArmorFocus.editbox:SetText(svsettings.hrc.heavyArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_HRC_HeavyArmorFocus.editbox:SetText(svsettings.hrc.heavyArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
               },
          },
          {
               type = "submenu",
               name = "|cAD601CMaw of Lorkhaj|r",
               tooltip = "CP Settings for Veteran Maw of Lorkhaj",
               controls = {
                    {
                         type = "header",
                         name = "|c513DEBThe Steed|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Ironclad",
                         tooltip = "Reduces your damage taken against direct damage attacks",
                         reference = "Pocket_MOL_Ironclad",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.mol.ironclad end,
                         getFunc = function() return svsettings.mol.ironclad end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.mol.ironclad = tonumber(value)
                                   else
                                        Pocket_MOL_Ironclad.editbox:SetText(svsettings.mol.ironclad)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MOL_Ironclad.editbox:SetText(svsettings.mol.ironclad)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Spell Shield",
                         tooltip = "Increases your Spell Resistance",
                         reference = "Pocket_MOL_SpellShield",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.mol.spellShield end,
                         getFunc = function() return svsettings.mol.spellShield end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.mol.spellShield = tonumber(value)
                                   else
                                        Pocket_MOL_SpellShield.editbox:SetText(svsettings.mol.spellShield)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MOL_SpellShield.editbox:SetText(svsettings.mol.spellShield)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Medium Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Medium Armor",
                         reference = "Pocket_MOL_MediumArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.mol.mediumArmorFocus end,
                         getFunc = function() return svsettings.mol.mediumArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.mol.mediumArmorFocus = tonumber(value)
                                   else
                                        Pocket_MOL_MediumArmorFocus.editbox:SetText(svsettings.mol.mediumArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MOL_MediumArmorFocus.editbox:SetText(svsettings.mol.mediumArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Resistant",
                         tooltip = "Increases your Critical Resistance",
                         reference = "Pocket_MOL_Resistant",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.mol.resistant end,
                         getFunc = function() return svsettings.mol.resistant end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.mol.resistant = tonumber(value)
                                   else
                                        Pocket_MOL_Resistant.editbox:SetText(svsettings.mol.resistant)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MOL_Resistant.editbox:SetText(svsettings.mol.resistant)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lady|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Hardy",
                         tooltip = "Reduces your damage taken from Physical, Poison, and Disease Damage",
                         reference = "Pocket_MOL_Hardy",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.mol.hardy end,
                         getFunc = function() return svsettings.mol.hardy end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.mol.hardy = tonumber(value)
                                   else
                                        Pocket_MOL_Hardy.editbox:SetText(svsettings.mol.hardy)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MOL_Hardy.editbox:SetText(svsettings.mol.hardy)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Thick Skinned",
                         tooltip = "Reduces your damage taken from damage over time effects",
                         reference = "Pocket_MOL_ThickSkinned",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.mol.thickSkinned end,
                         getFunc = function() return svsettings.mol.thickSkinned end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.mol.thickSkinned = tonumber(value)
                                   else
                                        Pocket_MOL_ThickSkinned.editbox:SetText(svsettings.mol.thickSkinned)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MOL_ThickSkinned.editbox:SetText(svsettings.mol.thickSkinned)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Elemental Defender",
                         tooltip = "Reduces your damage taken from Flame, Frost, Shock, and Magic Damage",
                         reference = "Pocket_MOL_EleDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.mol.eleDefender end,
                         getFunc = function() return svsettings.mol.eleDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.mol.eleDefender = tonumber(value)
                                   else
                                        Pocket_MOL_EleDefender.editbox:SetText(svsettings.mol.eleDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MOL_EleDefender.editbox:SetText(svsettings.mol.eleDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Light Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Light Armor",
                         reference = "Pocket_MOL_LightArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.mol.lightArmorFocus end,
                         getFunc = function() return svsettings.mol.lightArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.mol.lightArmorFocus = tonumber(value)
                                   else
                                        Pocket_MOL_LightArmorFocus.editbox:SetText(svsettings.mol.lightArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MOL_LightArmorFocus.editbox:SetText(svsettings.mol.lightArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lord|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Bastion",
                         tooltip = "Increases the effectiveness of your damage shields",
                         reference = "Pocket_MOL_Bastion",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.mol.bastion end,
                         getFunc = function() return svsettings.mol.bastion end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.mol.bastion = tonumber(value)
                                   else
                                        Pocket_MOL_Bastion.editbox:SetText(svsettings.mol.bastion)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MOL_Bastion.editbox:SetText(svsettings.mol.bastion)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Quick Recovery",
                         tooltip = "Increases your healing received",
                         reference = "Pocket_MOL_QuickRecovery",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.mol.quickRecovery end,
                         getFunc = function() return svsettings.mol.quickRecovery end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.mol.quickRecovery = tonumber(value)
                                   else
                                        Pocket_MOL_QuickRecovery.editbox:SetText(svsettings.mol.quickRecovery)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MOL_QuickRecovery.editbox:SetText(svsettings.mol.quickRecovery)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Expert Defender",
                         tooltip = "Reduces your damage taken from player Light and Heavy Attacks",
                         reference = "Pocket_MOL_ExpertDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.mol.expertDefender end,
                         getFunc = function() return svsettings.mol.expertDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.mol.expertDefender = tonumber(value)
                                   else
                                        Pocket_MOL_ExpertDefender.editbox:SetText(svsettings.mol.expertDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MOL_ExpertDefender.editbox:SetText(svsettings.mol.expertDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Heavy Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Heavy Armor",
                         reference = "Pocket_MOL_HeavyArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.mol.heavyArmorFocus end,
                         getFunc = function() return svsettings.mol.heavyArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.mol.heavyArmorFocus = tonumber(value)
                                   else
                                        Pocket_MOL_HeavyArmorFocus.editbox:SetText(svsettings.mol.heavyArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MOL_HeavyArmorFocus.editbox:SetText(svsettings.mol.heavyArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
               },
          },
          {
               type = "submenu",
               name = "|cAD601CSanctum Ophidia|r",
               tooltip = "CP Settings for Veteran Sanctum Ophidia",
               controls = {
                    {
                         type = "header",
                         name = "|c513DEBThe Steed|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Ironclad",
                         tooltip = "Reduces your damage taken against direct damage attacks",
                         reference = "Pocket_SO_Ironclad",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.so.ironclad end,
                         getFunc = function() return svsettings.so.ironclad end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.so.ironclad = tonumber(value)
                                   else
                                        Pocket_SO_Ironclad.editbox:SetText(svsettings.so.ironclad)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SO_Ironclad.editbox:SetText(svsettings.so.ironclad)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Spell Shield",
                         tooltip = "Increases your Spell Resistance",
                         reference = "Pocket_SO_SpellShield",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.so.spellShield end,
                         getFunc = function() return svsettings.so.spellShield end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.so.spellShield = tonumber(value)
                                   else
                                        Pocket_SO_SpellShield.editbox:SetText(svsettings.so.spellShield)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SO_SpellShield.editbox:SetText(svsettings.so.spellShield)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Medium Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Medium Armor",
                         reference = "Pocket_SO_MediumArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.so.mediumArmorFocus end,
                         getFunc = function() return svsettings.so.mediumArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.so.mediumArmorFocus = tonumber(value)
                                   else
                                        Pocket_SO_MediumArmorFocus.editbox:SetText(svsettings.so.mediumArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SO_MediumArmorFocus.editbox:SetText(svsettings.so.mediumArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Resistant",
                         tooltip = "Increases your Critical Resistance",
                         reference = "Pocket_SO_Resistant",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.so.resistant end,
                         getFunc = function() return svsettings.so.resistant end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.so.resistant = tonumber(value)
                                   else
                                        Pocket_SO_Resistant.editbox:SetText(svsettings.so.resistant)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SO_Resistant.editbox:SetText(svsettings.so.resistant)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lady|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Hardy",
                         tooltip = "Reduces your damage taken from Physical, Poison, and Disease Damage",
                         reference = "Pocket_SO_Hardy",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.so.hardy end,
                         getFunc = function() return svsettings.so.hardy end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.so.hardy = tonumber(value)
                                   else
                                        Pocket_SO_Hardy.editbox:SetText(svsettings.so.hardy)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SO_Hardy.editbox:SetText(svsettings.so.hardy)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Thick Skinned",
                         tooltip = "Reduces your damage taken from damage over time effects",
                         reference = "Pocket_SO_ThickSkinned",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.so.thickSkinned end,
                         getFunc = function() return svsettings.so.thickSkinned end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.so.thickSkinned = tonumber(value)
                                   else
                                        Pocket_SO_ThickSkinned.editbox:SetText(svsettings.so.thickSkinned)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SO_ThickSkinned.editbox:SetText(svsettings.so.thickSkinned)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Elemental Defender",
                         tooltip = "Reduces your damage taken from Flame, Frost, Shock, and Magic Damage",
                         reference = "Pocket_SO_EleDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.so.eleDefender end,
                         getFunc = function() return svsettings.so.eleDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.so.eleDefender = tonumber(value)
                                   else
                                        Pocket_SO_EleDefender.editbox:SetText(svsettings.so.eleDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SO_EleDefender.editbox:SetText(svsettings.so.eleDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Light Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Light Armor",
                         reference = "Pocket_SO_LightArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.so.lightArmorFocus end,
                         getFunc = function() return svsettings.so.lightArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.so.lightArmorFocus = tonumber(value)
                                   else
                                        Pocket_SO_LightArmorFocus.editbox:SetText(svsettings.so.lightArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SO_LightArmorFocus.editbox:SetText(svsettings.so.lightArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lord|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Bastion",
                         tooltip = "Increases the effectiveness of your damage shields",
                         reference = "Pocket_SO_Bastion",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.so.bastion end,
                         getFunc = function() return svsettings.so.bastion end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.so.bastion = tonumber(value)
                                   else
                                        Pocket_SO_Bastion.editbox:SetText(svsettings.so.bastion)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SO_Bastion.editbox:SetText(svsettings.so.bastion)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Quick Recovery",
                         tooltip = "Increases your healing received",
                         reference = "Pocket_SO_QuickRecovery",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.so.quickRecovery end,
                         getFunc = function() return svsettings.so.quickRecovery end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.so.quickRecovery = tonumber(value)
                                   else
                                        Pocket_SO_QuickRecovery.editbox:SetText(svsettings.so.quickRecovery)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SO_QuickRecovery.editbox:SetText(svsettings.so.quickRecovery)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Expert Defender",
                         tooltip = "Reduces your damage taken from player Light and Heavy Attacks",
                         reference = "Pocket_SO_ExpertDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.so.expertDefender end,
                         getFunc = function() return svsettings.so.expertDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.so.expertDefender = tonumber(value)
                                   else
                                        Pocket_SO_ExpertDefender.editbox:SetText(svsettings.so.expertDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SO_ExpertDefender.editbox:SetText(svsettings.so.expertDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Heavy Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Heavy Armor",
                         reference = "Pocket_SO_HeavyArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.so.heavyArmorFocus end,
                         getFunc = function() return svsettings.so.heavyArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.so.heavyArmorFocus = tonumber(value)
                                   else
                                        Pocket_SO_HeavyArmorFocus.editbox:SetText(svsettings.so.heavyArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SO_HeavyArmorFocus.editbox:SetText(svsettings.so.heavyArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
               },
          },
          {
               type = "submenu",
               name = "|cAD601CDragonstar Arena|r",
               tooltip = "CP Settings for Veteran Dragonstar Arena",
               controls = {
                    {
                         type = "header",
                         name = "|c513DEBThe Steed|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Ironclad",
                         tooltip = "Reduces your damage taken against direct damage attacks",
                         reference = "Pocket_DSA_Ironclad",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.dsa.ironclad end,
                         getFunc = function() return svsettings.dsa.ironclad end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.dsa.ironclad = tonumber(value)
                                   else
                                        Pocket_DSA_Ironclad.editbox:SetText(svsettings.dsa.ironclad)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_DSA_Ironclad.editbox:SetText(svsettings.dsa.ironclad)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Spell Shield",
                         tooltip = "Increases your Spell Resistance",
                         reference = "Pocket_DSA_SpellShield",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.dsa.spellShield end,
                         getFunc = function() return svsettings.dsa.spellShield end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.dsa.spellShield = tonumber(value)
                                   else
                                        Pocket_DSA_SpellShield.editbox:SetText(svsettings.dsa.spellShield)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_DSA_SpellShield.editbox:SetText(svsettings.dsa.spellShield)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Medium Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Medium Armor",
                         reference = "Pocket_DSA_MediumArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.dsa.mediumArmorFocus end,
                         getFunc = function() return svsettings.dsa.mediumArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.dsa.mediumArmorFocus = tonumber(value)
                                   else
                                        Pocket_DSA_MediumArmorFocus.editbox:SetText(svsettings.dsa.mediumArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_DSA_MediumArmorFocus.editbox:SetText(svsettings.dsa.mediumArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Resistant",
                         tooltip = "Increases your Critical Resistance",
                         reference = "Pocket_DSA_Resistant",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.dsa.resistant end,
                         getFunc = function() return svsettings.dsa.resistant end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.dsa.resistant = tonumber(value)
                                   else
                                        Pocket_DSA_Resistant.editbox:SetText(svsettings.dsa.resistant)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_DSA_Resistant.editbox:SetText(svsettings.dsa.resistant)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lady|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Hardy",
                         tooltip = "Reduces your damage taken from Physical, Poison, and Disease Damage",
                         reference = "Pocket_DSA_Hardy",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.dsa.hardy end,
                         getFunc = function() return svsettings.dsa.hardy end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.dsa.hardy = tonumber(value)
                                   else
                                        Pocket_DSA_Hardy.editbox:SetText(svsettings.dsa.hardy)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_DSA_Hardy.editbox:SetText(svsettings.dsa.hardy)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Thick Skinned",
                         tooltip = "Reduces your damage taken from damage over time effects",
                         reference = "Pocket_DSA_ThickSkinned",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.dsa.thickSkinned end,
                         getFunc = function() return svsettings.dsa.thickSkinned end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.dsa.thickSkinned = tonumber(value)
                                   else
                                        Pocket_DSA_ThickSkinned.editbox:SetText(svsettings.dsa.thickSkinned)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_DSA_ThickSkinned.editbox:SetText(svsettings.dsa.thickSkinned)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Elemental Defender",
                         tooltip = "Reduces your damage taken from Flame, Frost, Shock, and Magic Damage",
                         reference = "Pocket_DSA_EleDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.dsa.eleDefender end,
                         getFunc = function() return svsettings.dsa.eleDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.dsa.eleDefender = tonumber(value)
                                   else
                                        Pocket_DSA_EleDefender.editbox:SetText(svsettings.dsa.eleDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_DSA_EleDefender.editbox:SetText(svsettings.dsa.eleDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Light Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Light Armor",
                         reference = "Pocket_DSA_LightArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.dsa.lightArmorFocus end,
                         getFunc = function() return svsettings.dsa.lightArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.dsa.lightArmorFocus = tonumber(value)
                                   else
                                        Pocket_DSA_LightArmorFocus.editbox:SetText(svsettings.dsa.lightArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_DSA_LightArmorFocus.editbox:SetText(svsettings.dsa.lightArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lord|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Bastion",
                         tooltip = "Increases the effectiveness of your damage shields",
                         reference = "Pocket_DSA_Bastion",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.dsa.bastion end,
                         getFunc = function() return svsettings.dsa.bastion end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.dsa.bastion = tonumber(value)
                                   else
                                        Pocket_DSA_Bastion.editbox:SetText(svsettings.dsa.bastion)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_DSA_Bastion.editbox:SetText(svsettings.dsa.bastion)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Quick Recovery",
                         tooltip = "Increases your healing received",
                         reference = "Pocket_DSA_QuickRecovery",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.dsa.quickRecovery end,
                         getFunc = function() return svsettings.dsa.quickRecovery end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.dsa.quickRecovery = tonumber(value)
                                   else
                                        Pocket_DSA_QuickRecovery.editbox:SetText(svsettings.dsa.quickRecovery)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_DSA_QuickRecovery.editbox:SetText(svsettings.dsa.quickRecovery)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Expert Defender",
                         tooltip = "Reduces your damage taken from player Light and Heavy Attacks",
                         reference = "Pocket_DSA_ExpertDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.dsa.expertDefender end,
                         getFunc = function() return svsettings.dsa.expertDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.dsa.expertDefender = tonumber(value)
                                   else
                                        Pocket_DSA_ExpertDefender.editbox:SetText(svsettings.dsa.expertDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_DSA_ExpertDefender.editbox:SetText(svsettings.dsa.expertDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Heavy Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Heavy Armor",
                         reference = "Pocket_DSA_HeavyArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.dsa.heavyArmorFocus end,
                         getFunc = function() return svsettings.dsa.heavyArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.dsa.heavyArmorFocus = tonumber(value)
                                   else
                                        Pocket_DSA_HeavyArmorFocus.editbox:SetText(svsettings.dsa.heavyArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_DSA_HeavyArmorFocus.editbox:SetText(svsettings.dsa.heavyArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
               },
          },
          {
               type = "submenu",
               name = "|cAD601CMaelstrom Arena|r",
               tooltip = "CP Settings for Veteran Maelstrom Arena",
               controls = {
                    {
                         type = "header",
                         name = "|c513DEBThe Steed|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Ironclad",
                         tooltip = "Reduces your damage taken against direct damage attacks",
                         reference = "Pocket_MA_Ironclad",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ma.ironclad end,
                         getFunc = function() return svsettings.ma.ironclad end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ma.ironclad = tonumber(value)
                                   else
                                        Pocket_MA_Ironclad.editbox:SetText(svsettings.ma.ironclad)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MA_Ironclad.editbox:SetText(svsettings.ma.ironclad)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Spell Shield",
                         tooltip = "Increases your Spell Resistance",
                         reference = "Pocket_MA_SpellShield",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ma.spellShield end,
                         getFunc = function() return svsettings.ma.spellShield end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ma.spellShield = tonumber(value)
                                   else
                                        Pocket_MA_SpellShield.editbox:SetText(svsettings.ma.spellShield)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MA_SpellShield.editbox:SetText(svsettings.ma.spellShield)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Medium Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Medium Armor",
                         reference = "Pocket_MA_MediumArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ma.mediumArmorFocus end,
                         getFunc = function() return svsettings.ma.mediumArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ma.mediumArmorFocus = tonumber(value)
                                   else
                                        Pocket_MA_MediumArmorFocus.editbox:SetText(svsettings.ma.mediumArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MA_MediumArmorFocus.editbox:SetText(svsettings.ma.mediumArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Resistant",
                         tooltip = "Increases your Critical Resistance",
                         reference = "Pocket_MA_Resistant",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ma.resistant end,
                         getFunc = function() return svsettings.ma.resistant end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ma.resistant = tonumber(value)
                                   else
                                        Pocket_MA_Resistant.editbox:SetText(svsettings.ma.resistant)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MA_Resistant.editbox:SetText(svsettings.ma.resistant)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lady|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Hardy",
                         tooltip = "Reduces your damage taken from Physical, Poison, and Disease Damage",
                         reference = "Pocket_MA_Hardy",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ma.hardy end,
                         getFunc = function() return svsettings.ma.hardy end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ma.hardy = tonumber(value)
                                   else
                                        Pocket_MA_Hardy.editbox:SetText(svsettings.ma.hardy)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MA_Hardy.editbox:SetText(svsettings.ma.hardy)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Thick Skinned",
                         tooltip = "Reduces your damage taken from damage over time effects",
                         reference = "Pocket_MA_ThickSkinned",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ma.thickSkinned end,
                         getFunc = function() return svsettings.ma.thickSkinned end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ma.thickSkinned = tonumber(value)
                                   else
                                        Pocket_MA_ThickSkinned.editbox:SetText(svsettings.ma.thickSkinned)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MA_ThickSkinned.editbox:SetText(svsettings.ma.thickSkinned)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Elemental Defender",
                         tooltip = "Reduces your damage taken from Flame, Frost, Shock, and Magic Damage",
                         reference = "Pocket_MA_EleDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ma.eleDefender end,
                         getFunc = function() return svsettings.ma.eleDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ma.eleDefender = tonumber(value)
                                   else
                                        Pocket_MA_EleDefender.editbox:SetText(svsettings.ma.eleDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MA_EleDefender.editbox:SetText(svsettings.ma.eleDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Light Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Light Armor",
                         reference = "Pocket_MA_LightArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ma.lightArmorFocus end,
                         getFunc = function() return svsettings.ma.lightArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ma.lightArmorFocus = tonumber(value)
                                   else
                                        Pocket_MA_LightArmorFocus.editbox:SetText(svsettings.ma.lightArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MA_LightArmorFocus.editbox:SetText(svsettings.ma.lightArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lord|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Bastion",
                         tooltip = "Increases the effectiveness of your damage shields",
                         reference = "Pocket_MA_Bastion",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ma.bastion end,
                         getFunc = function() return svsettings.ma.bastion end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ma.bastion = tonumber(value)
                                   else
                                        Pocket_MA_Bastion.editbox:SetText(svsettings.ma.bastion)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MA_Bastion.editbox:SetText(svsettings.ma.bastion)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Quick Recovery",
                         tooltip = "Increases your healing received",
                         reference = "Pocket_MA_QuickRecovery",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ma.quickRecovery end,
                         getFunc = function() return svsettings.ma.quickRecovery end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ma.quickRecovery = tonumber(value)
                                   else
                                        Pocket_MA_QuickRecovery.editbox:SetText(svsettings.ma.quickRecovery)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MA_QuickRecovery.editbox:SetText(svsettings.ma.quickRecovery)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Expert Defender",
                         tooltip = "Reduces your damage taken from player Light and Heavy Attacks",
                         reference = "Pocket_MA_ExpertDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ma.expertDefender end,
                         getFunc = function() return svsettings.ma.expertDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ma.expertDefender = tonumber(value)
                                   else
                                        Pocket_MA_ExpertDefender.editbox:SetText(svsettings.ma.expertDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MA_ExpertDefender.editbox:SetText(svsettings.ma.expertDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Heavy Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Heavy Armor",
                         reference = "Pocket_MA_HeavyArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ma.heavyArmorFocus end,
                         getFunc = function() return svsettings.ma.heavyArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ma.heavyArmorFocus = tonumber(value)
                                   else
                                        Pocket_MA_HeavyArmorFocus.editbox:SetText(svsettings.ma.heavyArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_MA_HeavyArmorFocus.editbox:SetText(svsettings.ma.heavyArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
               },
          },
          {
               type = "submenu",
               name = "|cAD601CBlackrose Prison|r",
               tooltip = "CP Settings for Blackrose Prison",
               controls = {
                    {
                         type = "header",
                         name = "|c513DEBThe Steed|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Ironclad",
                         tooltip = "Reduces your damage taken against direct damage attacks",
                         reference = "Pocket_BRP_Ironclad",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.brp.ironclad end,
                         getFunc = function() return svsettings.brp.ironclad end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.brp.ironclad = tonumber(value)
                                   else
                                        Pocket_BRP_Ironclad.editbox:SetText(svsettings.brp.ironclad)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_BRP_Ironclad.editbox:SetText(svsettings.brp.ironclad)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Spell Shield",
                         tooltip = "Increases your Spell Resistance",
                         reference = "Pocket_BRP_SpellShield",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.brp.spellShield end,
                         getFunc = function() return svsettings.brp.spellShield end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.brp.spellShield = tonumber(value)
                                   else
                                        Pocket_BRP_SpellShield.editbox:SetText(svsettings.brp.spellShield)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_BRP_SpellShield.editbox:SetText(svsettings.brp.spellShield)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Medium Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Medium Armor",
                         reference = "Pocket_BRP_MediumArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.brp.mediumArmorFocus end,
                         getFunc = function() return svsettings.brp.mediumArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.brp.mediumArmorFocus = tonumber(value)
                                   else
                                        Pocket_BRP_MediumArmorFocus.editbox:SetText(svsettings.brp.mediumArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_BRP_MediumArmorFocus.editbox:SetText(svsettings.brp.mediumArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Resistant",
                         tooltip = "Increases your Critical Resistance",
                         reference = "Pocket_BRP_Resistant",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.brp.resistant end,
                         getFunc = function() return svsettings.brp.resistant end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.brp.resistant = tonumber(value)
                                   else
                                        Pocket_BRP_Resistant.editbox:SetText(svsettings.brp.resistant)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_BRP_Resistant.editbox:SetText(svsettings.brp.resistant)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lady|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Hardy",
                         tooltip = "Reduces your damage taken from Physical, Poison, and Disease Damage",
                         reference = "Pocket_BRP_Hardy",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.brp.hardy end,
                         getFunc = function() return svsettings.brp.hardy end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.brp.hardy = tonumber(value)
                                   else
                                        Pocket_BRP_Hardy.editbox:SetText(svsettings.brp.hardy)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_BRP_Hardy.editbox:SetText(svsettings.brp.hardy)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Thick Skinned",
                         tooltip = "Reduces your damage taken from damage over time effects",
                         reference = "Pocket_BRP_ThickSkinned",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.brp.thickSkinned end,
                         getFunc = function() return svsettings.brp.thickSkinned end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.brp.thickSkinned = tonumber(value)
                                   else
                                        Pocket_BRP_ThickSkinned.editbox:SetText(svsettings.brp.thickSkinned)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_BRP_ThickSkinned.editbox:SetText(svsettings.brp.thickSkinned)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Elemental Defender",
                         tooltip = "Reduces your damage taken from Flame, Frost, Shock, and Magic Damage",
                         reference = "Pocket_BRP_EleDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.brp.eleDefender end,
                         getFunc = function() return svsettings.brp.eleDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.brp.eleDefender = tonumber(value)
                                   else
                                        Pocket_BRP_EleDefender.editbox:SetText(svsettings.brp.eleDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_BRP_EleDefender.editbox:SetText(svsettings.brp.eleDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Light Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Light Armor",
                         reference = "Pocket_BRP_LightArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.brp.lightArmorFocus end,
                         getFunc = function() return svsettings.brp.lightArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.brp.lightArmorFocus = tonumber(value)
                                   else
                                        Pocket_BRP_LightArmorFocus.editbox:SetText(svsettings.brp.lightArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_BRP_LightArmorFocus.editbox:SetText(svsettings.brp.lightArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lord|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Bastion",
                         tooltip = "Increases the effectiveness of your damage shields",
                         reference = "Pocket_BRP_Bastion",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.brp.bastion end,
                         getFunc = function() return svsettings.brp.bastion end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.brp.bastion = tonumber(value)
                                   else
                                        Pocket_BRP_Bastion.editbox:SetText(svsettings.brp.bastion)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_BRP_Bastion.editbox:SetText(svsettings.brp.bastion)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Quick Recovery",
                         tooltip = "Increases your healing received",
                         reference = "Pocket_BRP_QuickRecovery",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.brp.quickRecovery end,
                         getFunc = function() return svsettings.brp.quickRecovery end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.brp.quickRecovery = tonumber(value)
                                   else
                                        Pocket_BRP_QuickRecovery.editbox:SetText(svsettings.brp.quickRecovery)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_BRP_QuickRecovery.editbox:SetText(svsettings.brp.quickRecovery)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Expert Defender",
                         tooltip = "Reduces your damage taken from player Light and Heavy Attacks",
                         reference = "Pocket_BRP_ExpertDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.brp.expertDefender end,
                         getFunc = function() return svsettings.brp.expertDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.brp.expertDefender = tonumber(value)
                                   else
                                        Pocket_BRP_ExpertDefender.editbox:SetText(svsettings.brp.expertDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_BRP_ExpertDefender.editbox:SetText(svsettings.brp.expertDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Heavy Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Heavy Armor",
                         reference = "Pocket_BRP_HeavyArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.brp.heavyArmorFocus end,
                         getFunc = function() return svsettings.brp.heavyArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.brp.heavyArmorFocus = tonumber(value)
                                   else
                                        Pocket_BRP_HeavyArmorFocus.editbox:SetText(svsettings.brp.heavyArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_BRP_HeavyArmorFocus.editbox:SetText(svsettings.brp.heavyArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
               },
          },
          {
               type = "submenu",
               name = "|cAD601CSunspire|r",
               tooltip = "CP Settings for Sunspire",
               controls = {
                    {
                         type = "header",
                         name = "|c513DEBThe Steed|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Ironclad",
                         tooltip = "Reduces your damage taken against direct damage attacks",
                         reference = "Pocket_SS_Ironclad",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ss.ironclad end,
                         getFunc = function() return svsettings.ss.ironclad end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ss.ironclad = tonumber(value)
                                   else
                                        Pocket_SS_Ironclad.editbox:SetText(svsettings.ss.ironclad)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SS_Ironclad.editbox:SetText(svsettings.ss.ironclad)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Spell Shield",
                         tooltip = "Increases your Spell Resistance",
                         reference = "Pocket_SS_SpellShield",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ss.spellShield end,
                         getFunc = function() return svsettings.ss.spellShield end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ss.spellShield = tonumber(value)
                                   else
                                        Pocket_SS_SpellShield.editbox:SetText(svsettings.ss.spellShield)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SS_SpellShield.editbox:SetText(svsettings.ss.spellShield)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Medium Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Medium Armor",
                         reference = "Pocket_SS_MediumArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ss.mediumArmorFocus end,
                         getFunc = function() return svsettings.ss.mediumArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ss.mediumArmorFocus = tonumber(value)
                                   else
                                        Pocket_SS_MediumArmorFocus.editbox:SetText(svsettings.ss.mediumArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SS_MediumArmorFocus.editbox:SetText(svsettings.ss.mediumArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Resistant",
                         tooltip = "Increases your Critical Resistance",
                         reference = "Pocket_SS_Resistant",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ss.resistant end,
                         getFunc = function() return svsettings.ss.resistant end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ss.resistant = tonumber(value)
                                   else
                                        Pocket_SS_Resistant.editbox:SetText(svsettings.ss.resistant)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SS_Resistant.editbox:SetText(svsettings.ss.resistant)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lady|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Hardy",
                         tooltip = "Reduces your damage taken from Physical, Poison, and Disease Damage",
                         reference = "Pocket_SS_Hardy",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ss.hardy end,
                         getFunc = function() return svsettings.ss.hardy end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ss.hardy = tonumber(value)
                                   else
                                        Pocket_SS_Hardy.editbox:SetText(svsettings.ss.hardy)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SS_Hardy.editbox:SetText(svsettings.ss.hardy)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Thick Skinned",
                         tooltip = "Reduces your damage taken from damage over time effects",
                         reference = "Pocket_SS_ThickSkinned",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ss.thickSkinned end,
                         getFunc = function() return svsettings.ss.thickSkinned end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ss.thickSkinned = tonumber(value)
                                   else
                                        Pocket_SS_ThickSkinned.editbox:SetText(svsettings.ss.thickSkinned)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SS_ThickSkinned.editbox:SetText(svsettings.ss.thickSkinned)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Elemental Defender",
                         tooltip = "Reduces your damage taken from Flame, Frost, Shock, and Magic Damage",
                         reference = "Pocket_SS_EleDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ss.eleDefender end,
                         getFunc = function() return svsettings.ss.eleDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ss.eleDefender = tonumber(value)
                                   else
                                        Pocket_SS_EleDefender.editbox:SetText(svsettings.ss.eleDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SS_EleDefender.editbox:SetText(svsettings.ss.eleDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Light Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Light Armor",
                         reference = "Pocket_SS_LightArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ss.lightArmorFocus end,
                         getFunc = function() return svsettings.ss.lightArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ss.lightArmorFocus = tonumber(value)
                                   else
                                        Pocket_SS_LightArmorFocus.editbox:SetText(svsettings.ss.lightArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SS_LightArmorFocus.editbox:SetText(svsettings.ss.lightArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lord|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Bastion",
                         tooltip = "Increases the effectiveness of your damage shields",
                         reference = "Pocket_SS_Bastion",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ss.bastion end,
                         getFunc = function() return svsettings.ss.bastion end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ss.bastion = tonumber(value)
                                   else
                                        Pocket_SS_Bastion.editbox:SetText(svsettings.ss.bastion)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SS_Bastion.editbox:SetText(svsettings.ss.bastion)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Quick Recovery",
                         tooltip = "Increases your healing received",
                         reference = "Pocket_SS_QuickRecovery",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ss.quickRecovery end,
                         getFunc = function() return svsettings.ss.quickRecovery end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ss.quickRecovery = tonumber(value)
                                   else
                                        Pocket_SS_QuickRecovery.editbox:SetText(svsettings.ss.quickRecovery)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SS_QuickRecovery.editbox:SetText(svsettings.ss.quickRecovery)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Expert Defender",
                         tooltip = "Reduces your damage taken from player Light and Heavy Attacks",
                         reference = "Pocket_SS_ExpertDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ss.expertDefender end,
                         getFunc = function() return svsettings.ss.expertDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ss.expertDefender = tonumber(value)
                                   else
                                        Pocket_SS_ExpertDefender.editbox:SetText(svsettings.ss.expertDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SS_ExpertDefender.editbox:SetText(svsettings.ss.expertDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Heavy Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Heavy Armor",
                         reference = "Pocket_SS_HeavyArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.ss.heavyArmorFocus end,
                         getFunc = function() return svsettings.ss.heavyArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.ss.heavyArmorFocus = tonumber(value)
                                   else
                                        Pocket_SS_HeavyArmorFocus.editbox:SetText(svsettings.ss.heavyArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_SS_HeavyArmorFocus.editbox:SetText(svsettings.ss.heavyArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
               },
          },
          {
               type = "submenu",
               name = "|cAD601CGeneral PvE|r",
               tooltip = "CP Settings for General PvE",
               controls = {
                    {
                         type = "header",
                         name = "|c513DEBThe Steed|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Ironclad",
                         tooltip = "Reduces your damage taken against direct damage attacks",
                         reference = "Pocket_GEN_Ironclad",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.gen.ironclad end,
                         getFunc = function() return svsettings.gen.ironclad end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.gen.ironclad = tonumber(value)
                                   else
                                        Pocket_GEN_Ironclad.editbox:SetText(svsettings.gen.ironclad)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_GEN_Ironclad.editbox:SetText(svsettings.gen.ironclad)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Spell Shield",
                         tooltip = "Increases your Spell Resistance",
                         reference = "Pocket_GEN_SpellShield",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.gen.spellShield end,
                         getFunc = function() return svsettings.gen.spellShield end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.gen.spellShield = tonumber(value)
                                   else
                                        Pocket_GEN_SpellShield.editbox:SetText(svsettings.gen.spellShield)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_GEN_SpellShield.editbox:SetText(svsettings.gen.spellShield)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Medium Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Medium Armor",
                         reference = "Pocket_GEN_MediumArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.gen.mediumArmorFocus end,
                         getFunc = function() return svsettings.gen.mediumArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.gen.mediumArmorFocus = tonumber(value)
                                   else
                                        Pocket_GEN_MediumArmorFocus.editbox:SetText(svsettings.gen.mediumArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_GEN_MediumArmorFocus.editbox:SetText(svsettings.gen.mediumArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Resistant",
                         tooltip = "Increases your Critical Resistance",
                         reference = "Pocket_GEN_Resistant",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.gen.resistant end,
                         getFunc = function() return svsettings.gen.resistant end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.gen.resistant = tonumber(value)
                                   else
                                        Pocket_GEN_Resistant.editbox:SetText(svsettings.gen.resistant)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_GEN_Resistant.editbox:SetText(svsettings.gen.resistant)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lady|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Hardy",
                         tooltip = "Reduces your damage taken from Physical, Poison, and Disease Damage",
                         reference = "Pocket_GEN_Hardy",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.gen.hardy end,
                         getFunc = function() return svsettings.gen.hardy end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.gen.hardy = tonumber(value)
                                   else
                                        Pocket_GEN_Hardy.editbox:SetText(svsettings.gen.hardy)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_GEN_Hardy.editbox:SetText(svsettings.gen.hardy)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Thick Skinned",
                         tooltip = "Reduces your damage taken from damage over time effects",
                         reference = "Pocket_GEN_ThickSkinned",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.gen.thickSkinned end,
                         getFunc = function() return svsettings.gen.thickSkinned end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.gen.thickSkinned = tonumber(value)
                                   else
                                        Pocket_GEN_ThickSkinned.editbox:SetText(svsettings.gen.thickSkinned)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_GEN_ThickSkinned.editbox:SetText(svsettings.gen.thickSkinned)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Elemental Defender",
                         tooltip = "Reduces your damage taken from Flame, Frost, Shock, and Magic Damage",
                         reference = "Pocket_GEN_EleDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.gen.eleDefender end,
                         getFunc = function() return svsettings.gen.eleDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.gen.eleDefender = tonumber(value)
                                   else
                                        Pocket_GEN_EleDefender.editbox:SetText(svsettings.gen.eleDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_GEN_EleDefender.editbox:SetText(svsettings.gen.eleDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Light Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Light Armor",
                         reference = "Pocket_GEN_LightArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.gen.lightArmorFocus end,
                         getFunc = function() return svsettings.gen.lightArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.gen.lightArmorFocus = tonumber(value)
                                   else
                                        Pocket_GEN_LightArmorFocus.editbox:SetText(svsettings.gen.lightArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_GEN_LightArmorFocus.editbox:SetText(svsettings.gen.lightArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "header",
                         name = "|c513DEBThe Lord|r",
                         title = nil,
                         width = "full",
                    },
                    {
                         type = "editbox",
                         name = "Bastion",
                         tooltip = "Increases the effectiveness of your damage shields",
                         reference = "Pocket_GEN_Bastion",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.gen.bastion end,
                         getFunc = function() return svsettings.gen.bastion end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.gen.bastion = tonumber(value)
                                   else
                                        Pocket_GEN_Bastion.editbox:SetText(svsettings.gen.bastion)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_GEN_Bastion.editbox:SetText(svsettings.gen.bastion)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Quick Recovery",
                         tooltip = "Increases your healing received",
                         reference = "Pocket_GEN_QuickRecovery",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.gen.quickRecovery end,
                         getFunc = function() return svsettings.gen.quickRecovery end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.gen.quickRecovery = tonumber(value)
                                   else
                                        Pocket_GEN_QuickRecovery.editbox:SetText(svsettings.gen.quickRecovery)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_GEN_QuickRecovery.editbox:SetText(svsettings.gen.quickRecovery)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Expert Defender",
                         tooltip = "Reduces your damage taken from player Light and Heavy Attacks",
                         reference = "Pocket_GEN_ExpertDefender",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.gen.expertDefender end,
                         getFunc = function() return svsettings.gen.expertDefender end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.gen.expertDefender = tonumber(value)
                                   else
                                        Pocket_GEN_ExpertDefender.editbox:SetText(svsettings.gen.expertDefender)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_GEN_ExpertDefender.editbox:SetText(svsettings.gen.expertDefender)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
                    {
                         type = "editbox",
                         name = "Heavy Armor Focus",
                         tooltip = "Increases your Physical Resistance while wearing 5 or more pieces of Heavy Armor",
                         reference = "Pocket_GEN_HeavyArmorFocus",
                         isMultiline = false,
                         width = "full",
                         default = function() return PocketAdeptus.defaults.gen.heavyArmorFocus end,
                         getFunc = function() return svsettings.gen.heavyArmorFocus end,
                         setFunc = function(value)
                              if type(tonumber(value)) == "number" then
                                   if (tonumber(value) >= 0 and tonumber(value) <= 100) then
                                        svsettings.gen.heavyArmorFocus = tonumber(value)
                                   else
                                        Pocket_GEN_HeavyArmorFocus.editbox:SetText(svsettings.gen.heavyArmorFocus)
                                        PocketAdeptus.alert("You must specify a number between 0 and 100")
                                   end
                              else
                                   Pocket_GEN_HeavyArmorFocus.editbox:SetText(svsettings.gen.heavyArmorFocus)
                                   PocketAdeptus.alert("You must specify a number between 0 and 100")
                              end
                         end,
                    },
               },
          },
     }
     LAM2:RegisterOptionControls(PocketAdeptus.version .. "Settings", Settings)
end
