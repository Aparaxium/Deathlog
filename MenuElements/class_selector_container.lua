--[[
Copyright 2023 Yazpad
The Deathlog AddOn is distributed under the terms of the GNU General Public License (or the Lesser GPL).
This file is part of Hardcore.

The Deathlog AddOn is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

The Deathlog AddOn is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with the Deathlog AddOn. If not, see <http://www.gnu.org/licenses/>.
--]]
--
local class_selector_container = CreateFrame("Frame")
class_selector_container:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
class_selector_container:SetSize(1000, 1000)
class_selector_container:Show()

local num_classes = 9

local function createClassIconButton(path_postfix, title_text, class_id)
	local frame = CreateFrame("Frame")
	frame.class_id = class_id
	frame.class_name = title_text
	frame:SetParent(class_selector_container)
	frame:SetPoint("TOPLEFT", class_selector_container, "TOPLEFT", 0, 0)
	frame:SetWidth(60)
	frame:SetHeight(20)
	frame:Hide()
	frame.instance_texture = frame:CreateTexture(nil, "OVERLAY")
	frame.instance_texture:SetDrawLayer("OVERLAY", 7)
	frame.instance_texture:SetVertexColor(1, 1, 1, 1)
	frame.instance_texture:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
	frame.instance_texture:SetTexture("Interface\\ICONS\\ClassIcon_" .. path_postfix)
	frame.instance_texture:SetParent(frame)
	frame.instance_texture:SetDesaturated(1)
	frame.instance_texture:Hide()

	return frame
end

class_selector_container.class_buttons = {}

local i = 1
for k, v in pairs(deathlog_class_tbl) do
	class_selector_container.class_buttons[i] = createClassIconButton(k, k, v)
	class_selector_container.class_buttons[i]:Show()
	i = i + 1
end

for i = 2, num_classes do
	class_selector_container.class_buttons[i]:SetPoint(
		"TOPLEFT",
		class_selector_container.class_buttons[i - 1],
		"TOPLEFT",
		10,
		-10
	)
end

function class_selector_container.updateMenuElement(scroll_frame, class_id, stats_tbl, setMapRegion)
	class_selector_container:SetParent(scroll_frame.frame)
	class_selector_container:SetPoint("TOPLEFT", scroll_frame.frame, "TOPLEFT", 45, -30)
	class_selector_container:SetHeight(scroll_frame.frame:GetWidth() * 0.6 * 3 / 4)
	class_selector_container:SetWidth(scroll_frame.frame:GetWidth() * 0.6)
	class_selector_container:Show()

	local vert_sep = -75

	for i = 1, #class_selector_container.class_buttons do
		class_selector_container.class_buttons[i]:SetHeight(class_selector_container:GetWidth() / 15)
		class_selector_container.class_buttons[i]:SetWidth(class_selector_container:GetWidth() / 15)
		class_selector_container.class_buttons[i].instance_texture:SetHeight(class_selector_container:GetWidth() / 15)
		class_selector_container.class_buttons[i].instance_texture:SetWidth(class_selector_container:GetWidth() / 15)
		class_selector_container.class_buttons[i]:Show()
		class_selector_container.class_buttons[i].instance_texture:Show()
		-- class_selector_container.class_buttons[i].instance_str:Show()
	end
	local h_sep = 55
	class_selector_container.class_buttons[2]:SetPoint(
		"TOPLEFT",
		class_selector_container.class_buttons[1],
		"TOPLEFT",
		h_sep,
		0
	)
	class_selector_container.class_buttons[3]:SetPoint(
		"TOPLEFT",
		class_selector_container.class_buttons[2],
		"TOPLEFT",
		h_sep,
		0
	)
	class_selector_container.class_buttons[4]:SetPoint(
		"TOPLEFT",
		class_selector_container.class_buttons[3],
		"TOPLEFT",
		h_sep,
		0
	)

	class_selector_container.class_buttons[5]:SetPoint(
		"TOPLEFT",
		class_selector_container.class_buttons[4],
		"TOPLEFT",
		h_sep,
		0
	)
	class_selector_container.class_buttons[6]:SetPoint(
		"TOPLEFT",
		class_selector_container.class_buttons[5],
		"TOPLEFT",
		h_sep,
		0
	)
	class_selector_container.class_buttons[7]:SetPoint(
		"TOPLEFT",
		class_selector_container.class_buttons[6],
		"TOPLEFT",
		h_sep,
		0
	)
	class_selector_container.class_buttons[8]:SetPoint(
		"TOPLEFT",
		class_selector_container.class_buttons[7],
		"TOPLEFT",
		h_sep,
		0
	)

	class_selector_container.class_buttons[9]:SetPoint(
		"TOPLEFT",
		class_selector_container.class_buttons[8],
		"TOPLEFT",
		h_sep,
		0
	)

	local idx = 1
	for i, v in ipairs(deathlog_class_tbl) do
		if current_instance_id == v[1] then
			idx = i
			break
		end
	end

	for _, v in ipairs(class_selector_container.class_buttons) do
		if v.class_id ~= class_id then
			v.instance_texture:SetDesaturated(1)
		else
			v.instance_texture:SetDesaturated(nil)
		end
	end

	for i, v in ipairs(class_selector_container.class_buttons) do
		class_selector_container.class_buttons[i]:SetScript("OnMouseDown", function()
			setMapRegion(
				class_selector_container.class_buttons[i].class_id,
				class_selector_container.class_buttons[i].class_name
			)
		end)
	end
end

function Deathlog_ClassSelectorContainer()
	return class_selector_container
end