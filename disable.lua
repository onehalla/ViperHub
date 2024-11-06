for i,v in pairs(game.Workspace:GetDescendants ()) do
    if v:IsA("Texture") or v:IsA("Decal") then 
        v.Transparency  = 1
    end 

end 