MatLib = MatLib or {}
MatLib.Colors = MatLib.Colors or {}
MatLib.Materials = MatLib.Materials or {}

MatLib.Colors.FrameTitle = Color(255, 255, 255)
MatLib.Colors.Text = Color(0, 0, 0)
MatLib.Colors.FrameBG = Color(250, 250, 250)
MatLib.Colors.FrameTop = Color(0, 122, 107)
MatLib.Colors.Button = Color(0, 122, 107)
MatLib.Colors.ButtonShadow = Color(0, 0, 0, 150)
MatLib.Colors.ButtonText = Color(255, 255, 255)
MatLib.Colors.PanelBG = Color(242, 242, 242)
MatLib.Colors.ToggleBackground = Color(75, 75, 75)
MatLib.Colors.ToggleBackgroundOn = Color(0, 122, 107)
MatLib.Colors.ComboBox = Color(255, 255, 255)
MatLib.Colors.DarkMode = false

MatLib.Materials.DownGradient = Material("gui/gradient_down")
MatLib.Materials.UpGradient = Material("gui/gradient_up")

surface.CreateFont("matlib.frametitle", {
    font = "Roboto",
    size = ScrH() * 0.025
})

surface.CreateFont("matlib.header", {
    font = "Roboto",
    size = ScrH() * 0.03
})

surface.CreateFont("matlib.text", {
    font = "Roboto",
    size = ScrH() * 0.02
})

surface.CreateFont("matlib.button", {
    font = "Roboto",
    size = ScrH() * 0.0175
})

--[[
-- Elements
]]--

-- Basic Frame.
function MatLib.Frame(x, y, w, h, title)
    local frame = vgui.Create("DFrame")
    frame:SetSize(w, h)
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)
    frame:SetTitle("")
    frame.headerHeight = 30 -- math.Max(h * 0.1, 30)
    if(x == -1 && y == -1) then
        frame:Center()
    else
        frame:SetPos(x, y)
    end
    frame.Paint = function(s, w, h)
        draw.RoundedBox(5, 0, 1, w, h - 1, MatLib.Colors.FrameBG)

        surface.SetDrawColor(0, 0, 0)
        surface.SetMaterial(MatLib.Materials.DownGradient)
        surface.DrawTexturedRect(0, s.headerHeight * 0.9, w, s.headerHeight * 0.25)

        draw.RoundedBox(5, 0, 0, w, s.headerHeight, MatLib.Colors.FrameTop)
        draw.RoundedBox(0, 0, s.headerHeight / 2, w, s.headerHeight / 2, MatLib.Colors.FrameTop)

        if(MatLib.Colors.DarkMode == false) then
            surface.SetDrawColor(MatLib.Colors.FrameTop.r + 25, MatLib.Colors.FrameTop.g + 25, MatLib.Colors.FrameTop.b + 25)
            surface.SetMaterial(MatLib.Materials.UpGradient)
            surface.DrawTexturedRect(0, s.headerHeight / 2, w, s.headerHeight / 2)
        end

        draw.SimpleText(title, "matlib.frametitle", w * 0.0225, s.headerHeight / 2, MatLib.Colors.FrameTitle, 0, 1)
    end
    frame:MakePopup()
    function frame:GetHeaderHeight()
        return frame.headerHeight
    end

    local closeButton = vgui.Create("DButton", frame)
    closeButton:SetPos(frame:GetWide() * 0.9, 0)
    closeButton:SetSize(frame:GetWide() * 0.1, frame.headerHeight)
    closeButton:SetText("")
    closeButton.Paint = function(s, w, h)
        draw.SimpleText("x", "matlib.frametitle", w / 2, h * 0.425, MatLib.Colors.FrameTitle, 1, 1)
    end
    closeButton.DoClick = function()
        frame:Close()
    end
    return frame
end

-- Basic Header
function MatLib.HeaderText(frame, x, y, text)
    local label = vgui.Create("DLabel", frame)
    label:SetPos(x, y)
    label:SetText(text)
    label:SetFont("matlib.header")
    label:SetContentAlignment(7)
    label:SizeToContents()
    label:SetColor(MatLib.Colors.Text)
    return label
end

-- Basic Text
function MatLib.Text(frame, x, y, text)
    local label = vgui.Create("DLabel", frame)
    label:SetPos(x, y)
    label:SetText(text)
    label:SetFont("matlib.text")
    label:SizeToContents()
    label:SetColor(MatLib.Colors.Text)
    return label
end

-- Button
function MatLib.Button(frame, x, y, w, h, text)
    local button = vgui.Create("DButton", frame)
    button:SetPos(x, y)
    button:SetSize(w, h)
    button:SetText("")
    button.Lerp = 0
    button.Paint = function(s, w, h)
        draw.RoundedBox(6, 0, 0, w, h, MatLib.Colors.Button)
        if(s:IsHovered()) then
            s.Lerp = Lerp(0.05, s.Lerp, 25)
        else
            s.Lerp = Lerp(0.05, s.Lerp, 0)
        end
        draw.RoundedBox(6, 0, 0, w, h, Color(255, 255, 255, s.Lerp))
        draw.SimpleText(text, "matlib.button", w / 2, h / 2, MatLib.Colors.ButtonText, 1, 1)
    end
    return button
end

-- Scroll Panel
function MatLib.ScrollPanel(frame, x, y, w, h)
    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:SetPos(x, y)
    scroll:SetSize(w, h)

    local scrollBar = scroll:GetVBar()
    scrollBar:SetHideButtons(true)
    scrollBar:SetWide(frame:GetWide() * 0.01)
    scrollBar.Paint = function(s, w, h)

    end
    scrollBar.btnUp.Paint = function(s, w, h)

    end
    scrollBar.btnDown.Paint = function(s, w, h)

    end
    scrollBar.btnGrip.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, MatLib.Colors.FrameTop)
    end

    return scroll
end

-- Scroll Panel Item
function MatLib.ScrollItem(scroll, height)
    local panel = vgui.Create("DPanel", scroll)
    panel:Dock(TOP)
    panel:DockMargin(0, 0, 0, 5)
    panel:SetSize(scroll:GetWide(), height)
    panel.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, MatLib.Colors.PanelBG)
    end
    return panel
end

-- Switch
function MatLib.Switch(frame, x, y, w, h, defaultValue)
    local button = vgui.Create("DButton", frame)
    button:SetPos(x, y)
    button:SetSize(w, h)
    button:SetText("")
    button.Lerp = 0
    button.LerpR = 0
    button.LerpG = 0
    button.LerpB = 0
    button.value = defaultValue
    button.Paint = function(s, w, h)
        if(button.value == true) then
            button.Lerp = Lerp(0.05, button.Lerp, w - (w * 0.325))
            button.LerpR = Lerp(0.05, button.LerpR, MatLib.Colors.ToggleBackgroundOn.r)
            button.LerpG = Lerp(0.05, button.LerpG, MatLib.Colors.ToggleBackgroundOn.g)
            button.LerpB = Lerp(0.05, button.LerpB, MatLib.Colors.ToggleBackgroundOn.b)
        else
            button.Lerp = Lerp(0.05, button.Lerp, 0)
            button.LerpR = Lerp(0.05, button.LerpR, MatLib.Colors.ToggleBackground.r)
            button.LerpG = Lerp(0.05, button.LerpG, MatLib.Colors.ToggleBackground.g)
            button.LerpB = Lerp(0.05, button.LerpB, MatLib.Colors.ToggleBackground.b)
        end
        draw.RoundedBox(14, 0, 0, w, h, Color(button.LerpR, button.LerpG, button.LerpB))
        draw.RoundedBox(14, button.Lerp, 0, w * 0.325, h, Color(220, 220, 220))
    end
    return button
end

-- Combo Box
function MatLib.ComboBox(frame, x, y, w, h, defaultValue, fields)
    local box = vgui.Create("DComboBox", frame)
    box:SetPos(x, y)
    box:SetSize(w, h)
    for k,v in pairs(fields) do
        box:AddChoice(v)
    end
    box:SetValue(defaultValue)
    box.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0))
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, MatLib.Colors.ComboBox)
    end
    return box
end

-- Check Box
function MatLib.CheckBox(frame, x, y, w, h, defaultValue)
    local box = vgui.Create("DCheckBox", frame)
    box:SetPos(x, y)
    box:SetSize(w, h)
    box:SetChecked(defaultValue)
    box.Lerp = 0
    box.Paint = function(s, w, h)
        draw.RoundedBox(5, 0, 0, w, h, MatLib.Colors.FrameTop)
        if(s:GetChecked() == true) then
            box.Lerp = Lerp(0.05, box.Lerp, 255)
        else
            box.Lerp = Lerp(0.05, box.Lerp, 0)
        end
        draw.SimpleText("✔", "matlib.text", w / 2, h / 2, Color(255, 255, 255, box.Lerp), 1, 1) -- I can hear people screaming at me for using emojis instead of icons now....
    end
    return box
end

-- Notice.
function MatLib.Notice(title, text)
    local frame = MatLib.Frame(-1, -1, ScrW() * 0.3, ScrH() * 0.075, title)
    MatLib.HeaderText(frame, frame:GetWide() * 0.025, frame:GetTall() * 0.5, text)
end



--[[
-- Themes and stuff.
]]--

-- Sets the theme color.
function MatLib.SetThemeColor(color)
    MatLib.Colors.FrameTop = color
    MatLib.Colors.Button = color
    MatLib.Colors.ToggleBackgroundOn = color
end

-- Reset the theme color back to normal.
function MatLib.ResetTheme()
    MatLib.Colors.FrameTop = Color(0, 122, 107)
    MatLib.Colors.Button = Color(0, 122, 107)
    MatLib.Colors.ToggleBackgroundOn = Color(0, 122, 107)
end

-- Sets up Dark Mode.
function MatLib.SetDarkMode(dark, themeOverride)
    if(dark == true) then
        MatLib.Colors.FrameTitle = Color(255, 255, 255)
        MatLib.Colors.Text = Color(255, 255, 255)
        MatLib.Colors.FrameBG = Color(25, 25, 25)
        MatLib.Colors.ButtonShadow = Color(255, 255, 255, 150)
        MatLib.Colors.ButtonText = Color(255, 255, 255)
        MatLib.Colors.PanelBG = Color(20, 20, 20)
        MatLib.Colors.ComboBox = Color(0, 0, 0)

        MatLib.Colors.DarkMode = true
        if(themeOverride == true) then
            MatLib.Colors.ToggleBackgroundOn = Color(0, 122, 107)
            MatLib.Colors.FrameTop = Color(50, 50, 50)
            MatLib.Colors.Button = Color(50, 50, 50)
        end
    else
        MatLib.Colors.FrameTitle = Color(255, 255, 255)
        MatLib.Colors.Text = Color(0, 0, 0)
        MatLib.Colors.FrameBG = Color(250, 250, 250)
        MatLib.Colors.ButtonShadow = Color(0, 0, 0, 150)
        MatLib.Colors.ButtonText = Color(255, 255, 255)
        MatLib.Colors.PanelBG = Color(242, 242, 242)
        MatLib.Colors.ToggleBackground = Color(75, 75, 75)
        MatLib.Colors.ComboBox = Color(255, 255, 255)
        MatLib.Colors.DarkMode = false
    end
end