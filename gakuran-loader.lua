local GAKURAN_SCRIPT_URL = "https://hub.bagahproject.com/api/script/4bf3ab6b-757f-4523-a80f-ae163b73b030"

local function createLoaderUI()
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Theme colors
    local THEME = {
        bg       = Color3.fromRGB(16, 17, 23),
        surface  = Color3.fromRGB(22, 24, 32),
        surface2 = Color3.fromRGB(28, 30, 40),
        stroke   = Color3.fromRGB(45, 48, 62),
        text     = Color3.fromRGB(240, 240, 245),
        subtext  = Color3.fromRGB(140, 142, 160),
        muted    = Color3.fromRGB(95, 97, 115),
        primary  = Color3.fromRGB(140, 90, 245),
        primary2 = Color3.fromRGB(90, 60, 210),
        accent   = Color3.fromRGB(70, 170, 255),
        accent2  = Color3.fromRGB(40, 110, 220),
        danger   = Color3.fromRGB(240, 90, 100),
    }

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "GakuranLoader"
    ScreenGui.DisplayOrder = 999
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Parent = PlayerGui

    local function corner(parent, radius)
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, radius or 10)
        c.Parent = parent
        return c
    end

    local function stroke(parent, color, thickness, transparency)
        local s = Instance.new("UIStroke")
        s.Color = color or THEME.stroke
        s.Thickness = thickness or 1
        s.Transparency = transparency or 0
        s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        s.Parent = parent
        return s
    end

    local Backdrop = Instance.new("Frame")
    Backdrop.Name = "Backdrop"
    Backdrop.Size = UDim2.new(1, 0, 1, 0)
    Backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Backdrop.BackgroundTransparency = 1
    Backdrop.BorderSizePixel = 0
    Backdrop.Parent = ScreenGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Size = UDim2.new(0, 320, 0, 260)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = THEME.bg
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    corner(MainFrame, 14)
    stroke(MainFrame, THEME.stroke, 1, 0.2)

    local BgGradient = Instance.new("UIGradient")
    BgGradient.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 22, 48)),
        ColorSequenceKeypoint.new(0.5, THEME.bg),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 24, 38))
    }
    BgGradient.Rotation = 135
    BgGradient.Parent = MainFrame

    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, -24, 0, 40)
    Header.Position = UDim2.new(0, 12, 0, 12)
    Header.BackgroundTransparency = 1
    Header.Parent = MainFrame

    local LogoHolder = Instance.new("Frame")
    LogoHolder.Size = UDim2.new(0, 32, 0, 32)
    LogoHolder.Position = UDim2.new(0, 0, 0.5, -16)
    LogoHolder.BackgroundColor3 = THEME.primary
    LogoHolder.BorderSizePixel = 0
    LogoHolder.Parent = Header
    corner(LogoHolder, 8)

    local LogoGradient = Instance.new("UIGradient")
    LogoGradient.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0, THEME.primary),
        ColorSequenceKeypoint.new(1, THEME.accent)
    }
    LogoGradient.Rotation = 135
    LogoGradient.Parent = LogoHolder

    local LogoIcon = Instance.new("TextLabel")
    LogoIcon.Size = UDim2.new(1, 0, 1, 0)
    LogoIcon.BackgroundTransparency = 1
    LogoIcon.Text = "G"
    LogoIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    LogoIcon.TextSize = 18
    LogoIcon.Font = Enum.Font.GothamBold
    LogoIcon.Parent = LogoHolder

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -80, 0, 18)
    TitleLabel.Position = UDim2.new(0, 42, 0, 2)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "Gakuran Loader"
    TitleLabel.TextColor3 = THEME.text
    TitleLabel.TextSize = 15
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Header

    local SubtitleLabel = Instance.new("TextLabel")
    SubtitleLabel.Size = UDim2.new(1, -80, 0, 14)
    SubtitleLabel.Position = UDim2.new(0, 42, 0, 20)
    SubtitleLabel.BackgroundTransparency = 1
    SubtitleLabel.Text = "Auto Parry Edition"
    SubtitleLabel.TextColor3 = THEME.subtext
    SubtitleLabel.TextSize = 11
    SubtitleLabel.Font = Enum.Font.Gotham
    SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubtitleLabel.Parent = Header

    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 26, 0, 26)
    CloseButton.Position = UDim2.new(1, -26, 0.5, -13)
    CloseButton.BackgroundColor3 = THEME.surface
    CloseButton.BorderSizePixel = 0
    CloseButton.AutoButtonColor = false
    CloseButton.Text = "X"
    CloseButton.TextColor3 = THEME.subtext
    CloseButton.TextSize = 13
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = Header
    corner(CloseButton, 7)

    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.12), {
            BackgroundColor3 = THEME.danger,
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end)
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.12), {
            BackgroundColor3 = THEME.surface,
            TextColor3 = THEME.subtext
        }):Play()
    end)

    local Divider = Instance.new("Frame")
    Divider.Size = UDim2.new(1, -24, 0, 1)
    Divider.Position = UDim2.new(0, 12, 0, 58)
    Divider.BackgroundColor3 = THEME.stroke
    Divider.BackgroundTransparency = 0.4
    Divider.BorderSizePixel = 0
    Divider.Parent = MainFrame

    local LoadButton = Instance.new("TextButton")
    LoadButton.Name = "LoadButton"
    LoadButton.Size = UDim2.new(1, -24, 0, 140)
    LoadButton.Position = UDim2.new(0, 12, 0, 68)
    LoadButton.BackgroundColor3 = THEME.surface
    LoadButton.BorderSizePixel = 0
    LoadButton.AutoButtonColor = false
    LoadButton.Text = ""
    LoadButton.Parent = MainFrame
    corner(LoadButton, 10)
    stroke(LoadButton, THEME.primary, 1, 0.3)

    local IconHolder = Instance.new("Frame")
    IconHolder.Size = UDim2.new(0, 50, 0, 50)
    IconHolder.Position = UDim2.new(0.5, -25, 0, 15)
    IconHolder.BackgroundColor3 = THEME.primary
    IconHolder.BorderSizePixel = 0
    IconHolder.Parent = LoadButton
    corner(IconHolder, 12)

    local IconGrad = Instance.new("UIGradient")
    IconGrad.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0, THEME.primary),
        ColorSequenceKeypoint.new(1, THEME.accent)
    }
    IconGrad.Rotation = 135
    IconGrad.Parent = IconHolder

    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(1, 0, 1, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = "⚔"
    Icon.TextColor3 = Color3.fromRGB(255, 255, 255)
    Icon.TextScaled = true
    Icon.Font = Enum.Font.GothamBold
    Icon.Parent = IconHolder

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 20)
    Title.Position = UDim2.new(0, 10, 0, 75)
    Title.BackgroundTransparency = 1
    Title.Text = "Load Gakuran"
    Title.TextColor3 = THEME.text
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.Parent = LoadButton

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -20, 0, 40)
    Desc.Position = UDim2.new(0, 10, 0, 100)
    Desc.BackgroundTransparency = 1
    Desc.Text = "Auto Parry, ESP,\nVisuals & More"
    Desc.TextColor3 = THEME.muted
    Desc.TextSize = 12
    Desc.Font = Enum.Font.Gotham
    Desc.TextWrapped = true
    Desc.Parent = LoadButton

    LoadButton.MouseEnter:Connect(function()
        TweenService:Create(LoadButton, TweenInfo.new(0.15), {
            BackgroundColor3 = THEME.surface2
        }):Play()
    end)
    LoadButton.MouseLeave:Connect(function()
        TweenService:Create(LoadButton, TweenInfo.new(0.15), {
            BackgroundColor3 = THEME.surface
        }):Play()
    end)

    local LoadingOverlay = Instance.new("Frame")
    LoadingOverlay.Name = "LoadingOverlay"
    LoadingOverlay.Size = UDim2.new(1, -24, 0, 140)
    LoadingOverlay.Position = UDim2.new(0, 12, 0, 68)
    LoadingOverlay.BackgroundColor3 = THEME.surface
    LoadingOverlay.BorderSizePixel = 0
    LoadingOverlay.Visible = false
    LoadingOverlay.Parent = MainFrame
    corner(LoadingOverlay, 10)

    local LoadingStatus = Instance.new("TextLabel")
    LoadingStatus.Name = "LoadingStatus"
    LoadingStatus.Size = UDim2.new(1, -20, 0, 16)
    LoadingStatus.Position = UDim2.new(0, 10, 0, 50)
    LoadingStatus.BackgroundTransparency = 1
    LoadingStatus.Text = "Loading..."
    LoadingStatus.TextColor3 = THEME.text
    LoadingStatus.TextSize = 12
    LoadingStatus.Font = Enum.Font.GothamMedium
    LoadingStatus.TextXAlignment = Enum.TextXAlignment.Center
    LoadingStatus.Parent = LoadingOverlay

    local ProgressBG = Instance.new("Frame")
    ProgressBG.Size = UDim2.new(1, -20, 0, 3)
    ProgressBG.Position = UDim2.new(0, 10, 0, 80)
    ProgressBG.BackgroundColor3 = THEME.stroke
    ProgressBG.BorderSizePixel = 0
    ProgressBG.Parent = LoadingOverlay
    corner(ProgressBG, 2)

    local ProgressFill = Instance.new("Frame")
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    ProgressFill.BackgroundColor3 = THEME.primary
    ProgressFill.BorderSizePixel = 0
    ProgressFill.Parent = ProgressBG
    corner(ProgressFill, 2)

    local Footer = Instance.new("TextLabel")
    Footer.Size = UDim2.new(1, -24, 0, 12)
    Footer.Position = UDim2.new(0, 12, 1, -18)
    Footer.BackgroundTransparency = 1
    Footer.Text = "Gakuran Script Loader"
    Footer.TextColor3 = THEME.muted
    Footer.TextSize = 9
    Footer.Font = Enum.Font.Gotham
    Footer.TextXAlignment = Enum.TextXAlignment.Right
    Footer.Parent = MainFrame

    local dragging, dragStart, startPos
    local function beginDrag(input)
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end

    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            beginDrag(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.BackgroundTransparency = 1
    TweenService:Create(Backdrop, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.5
    }):Play()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 320, 0, 260),
        BackgroundTransparency = 0
    }):Play()

    local close
    close = function()
        local fadeTween = TweenService:Create(MainFrame,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 0, 0, 0),
                BackgroundTransparency = 1
            })
        TweenService:Create(Backdrop, TweenInfo.new(0.2), {
            BackgroundTransparency = 1
        }):Play()
        fadeTween:Play()
        fadeTween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end

    CloseButton.MouseButton1Click:Connect(close)

    return {
        LoadButton = LoadButton,
        LoadingOverlay = LoadingOverlay,
        LoadingStatus = LoadingStatus,
        ProgressFill = ProgressFill,
        close = close
    }
end

local function fetchScript(url)
    local cacheBuster = string.format("?v=%d&r=%d&t=%d",
        tick() * 1000,
        math.random(100000, 999999),
        os.time()
    )
    local success, result = pcall(function()
        return game:HttpGet(url .. cacheBuster, true)
    end)
    return success and result or nil
end

local function main()
    local ui = createLoaderUI()
    task.wait(0.2)

    local function loadScript()
        ui.LoadButton.Visible = false
        ui.LoadingOverlay.Visible = true

        ui.LoadingStatus.Text = "Fetching script..."
        task.wait(0.2)

        local scriptContent = fetchScript(GAKURAN_SCRIPT_URL)

        if not scriptContent then
            ui.LoadingStatus.Text = "Fetch failed"
            task.wait(3)
            ui.close()
            return
        end

        ui.LoadingStatus.Text = "Loading Gakuran..."
        task.wait(0.2)

        local success, err = pcall(function()
            local scriptFunc = load(scriptContent)
            if scriptFunc then
                scriptFunc()
            else
                error("Failed to compile script")
            end
        end)

        if success then
            ui.LoadingStatus.Text = "Loaded!"
            task.wait(1)
            ui.close()
        else
            ui.LoadingStatus.Text = "Error: " .. tostring(err)
            task.wait(5)
            ui.close()
        end
    end

    ui.LoadButton.MouseButton1Click:Connect(loadScript)
end

main()
