-- Daily fact of the day. Today's seems to be very intresting!
concommand.Add("matlib_fact", function()
    local frame = MatLib.Frame(-1, -1, ScrW() * 0.4, ScrH() * 0.3, "Daily Fact")
    local fw,fh = frame:GetSize()

    MatLib.HeaderText(frame, fw * 0.05, fh * 0.2, "Fact of the day!")
    MatLib.Text(frame, fw * 0.05, fh * 0.36, "Did you know Owain has a leg length of 2 foot?")
    MatLib.Text(frame, fw * 0.05, fh * 0.46, "This was proven on 23/07/2019, when a poll ran by Owain")
    MatLib.Text(frame, fw * 0.05, fh * 0.53, "made Owain vote that his legs, were indeed, 2 foot.")

    MatLib.Text(frame, fw * 0.05, fh * 0.7, "Did YOU know this?")
    local yes = MatLib.Button(frame, fw * 0.05, fh * 0.825, fw * 0.4, fh * 0.1, "Yes, I did!")
    local no = MatLib.Button(frame, fw * 0.55, fh * 0.825, fw * 0.4, fh * 0.1, "No, I didn't!")
    yes.DoClick = function()
        frame:Close()
        MatLib.Notice("Well Done!", "Well good for you!")
    end
    no.DoClick = function()
        frame:Close()
        MatLib.Notice("Well...", "Well now you know!")
    end
end)

-- An example settings page. This can also be used for showing you what color scheme/theme to use in your addon, or if you want a settings page and don't know how to make one.
concommand.Add("matlib_settings", function()
    local frame = MatLib.Frame(-1, -1, ScrW() * 0.5, ScrH() * 0.7, "MatLib - Settings")
    local scroll = MatLib.ScrollPanel(frame, 0, frame:GetHeaderHeight(), frame:GetWide(), frame:GetTall() - frame:GetHeaderHeight())

    local infoItem = MatLib.ScrollItem(scroll, frame:GetTall() * 0.1)
    MatLib.HeaderText(infoItem, infoItem:GetWide() * 0.025, infoItem:GetTall() * 0.1, "Settings")
    MatLib.Text(infoItem, infoItem:GetWide() * 0.025, infoItem:GetTall() * 0.6, "This is the settings page. Edit MatLib to your liking here.")

    local darkTheme = MatLib.ScrollItem(scroll, frame:GetTall() * 0.1)
    MatLib.HeaderText(darkTheme, darkTheme:GetWide() * 0.025, darkTheme:GetTall() * 0.1, "Dark Theme")
    MatLib.Text(darkTheme, darkTheme:GetWide() * 0.025, darkTheme:GetTall() * 0.6, "Enables Dark Theme. Some items might require you to re-open the UI.")
    local darkThemeButton = MatLib.Switch(darkTheme, darkTheme:GetWide() * 0.85, darkTheme:GetTall() * 0.3, darkTheme:GetWide() * 0.1, darkTheme:GetTall() * 0.4, MatLib.Colors.DarkMode)
    darkThemeButton.DoClick = function(self)
        self.value = !self.value -- If you are overriding doClick, you MUST include this line.
        MatLib.SetDarkMode(self.value, false)
    end

    if(!_G.MatLib_Theme) then
        _G.MatLib_Theme = "Teal"
    end
    local colorBox = MatLib.ScrollItem(scroll, frame:GetTall() * 0.1)
    MatLib.HeaderText(colorBox, colorBox:GetWide() * 0.025, colorBox:GetTall() * 0.1, "Theme Color")
    MatLib.Text(colorBox, colorBox:GetWide() * 0.025, colorBox:GetTall() * 0.6, "The Theme Color for the UI.")
    local colorBoxField = MatLib.ComboBox(colorBox, colorBox:GetWide() * 0.85, colorBox:GetTall() * 0.3, colorBox:GetWide() * 0.1, colorBox:GetTall() * 0.4, _G.MatLib_Theme, {"Teal", "Orange", "Green", "Blue", "Cyan", "Purple", "Pink", "Red", "Black"})
    colorBoxField.OnSelect = function(self)
        _G.MatLib_Theme = self:GetSelected()
        local colors = {}
        colors["Teal"] = Color(0, 128, 128)
        colors["Orange"] = Color(255, 127, 50)
        colors["Green"] = Color(0, 200, 0)
        colors["Blue"] = Color(25, 0, 255)
        colors["Cyan"] = Color(0, 200, 200)
        colors["Purple"] = Color(150, 0, 255)
        colors["Pink"] = Color(255, 0, 255)
        colors["Red"] = Color(255, 50, 50)
        colors["Black"] = Color(0, 0, 0)

        MatLib.SetThemeColor(colors[_G.MatLib_Theme])
    end
end)

-- A basic forum.
concommand.Add("matlib_forum", function()
    local frame = MatLib.Frame(-1, -1, ScrW() * 0.6, ScrH() * 0.5, "Staff Application")
    local fw,fh = frame:GetSize()
    MatLib.HeaderText(frame, frame:GetWide() * 0.025, frame:GetTall() * 0.1, "Create an Staff Application.")
    MatLib.Text(frame, frame:GetWide() * 0.025, frame:GetTall() * 0.16, "So, you think you got what it takes to be staff on our awesome server? Apply, and find out!")

    local itemList = MatLib.ScrollPanel(frame, frame:GetWide() * 0.025, frame:GetTall() * 0.25, frame:GetWide() * 0.95, frame:GetTall() * 0.7)

    local cloutBox = MatLib.ScrollItem(itemList, frame:GetTall() * 0.12)
    MatLib.HeaderText(cloutBox, cloutBox:GetWide() * 0.025, cloutBox:GetTall() * 0.1, "Your Clout")
    MatLib.Text(cloutBox, cloutBox:GetWide() * 0.025, cloutBox:GetTall() * 0.6, "How much Clout you got fam?")
    local cloutBoxField = MatLib.ComboBox(cloutBox, cloutBox:GetWide() * 0.65, cloutBox:GetTall() * 0.3, cloutBox:GetWide() * 0.3, cloutBox:GetTall() * 0.4, "None", {"None Fam", "Lil Bit", "M8 I bang yer mum every night I got enough", "I am the fucking COMMANDER."})

    local ageCheck = MatLib.ScrollItem(itemList, frame:GetTall() * 0.12)
    MatLib.HeaderText(ageCheck, ageCheck:GetWide() * 0.025, ageCheck:GetTall() * 0.1, "Over 18")
    MatLib.Text(ageCheck, ageCheck:GetWide() * 0.025, ageCheck:GetTall() * 0.6, "Are over over 18 years of age?")
    MatLib.CheckBox(ageCheck, ageCheck:GetWide() * 0.65, ageCheck:GetTall() * 0.25, ageCheck:GetWide() * 0.03, ageCheck:GetTall() * 0.5, false)
end)