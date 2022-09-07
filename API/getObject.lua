if not getgenv().object then
    getgenv().object = {
    child = {},
    descendant = {},
    check = {},
    Local_Connections = {}
} elseif getgenv().object.Local_Connections == nil then
    getgenv().object.Local_Connections = {
} end do
    local self,getObject = getgenv().object,Instance.new("Part")
    
    self.cget = getObject.GetChildren
    self.dget = getObject.GetDescendants
    
    print("Disconnecting Old Connections") do
        for i,v in pairs(self.Local_Connections) do
            v:Disconnect()
        end
        self.Local_Connections = {}
    end
    
    print("Loading Child Module") do

        
        function self.child.find(parent,name)
            for _, v in pairs(self.cget(parent)) do
                if v.Name == name then
                    return v
                end
            end
        end
        
        function self.child.foreach(parent,name,func)
            for _, v in pairs(self.cget(parent)) do
                if v.Name == name then
                    func(v)
                end
            end
        end
        
        function self.child.on_add(parent,func)
            local code = Random.new(tick()+parent.Name:byte()):NextNumber()
            self.Local_Connections[parent.Name..code] = parent.ChildAdded:Connect(func)
            return self.Local_Connections[parent.Name..code],code
        end
    
    end
    
    print("Loading Descendant Module") do
        function self.descendant.find(parent,name)
            for _, v in pairs(self.dget(parent)) do
                if v.Name == name then
                    return v
                end
            end
        end
        
        function self.descendant.foreach(parent,name,func)
            for _, v in pairs(self.dget(parent)) do
                if v.Name == name then
                    func(v)
                end
            end
        end
        
        function self.descendant.on_add(parent,func)
            local code = Random.new(tick()+parent.Name:byte()):NextNumber()
            self.Local_Connections[parent.Name..code] = parent.DescendantAdded:Connect(func)
            return self.Local_Connections[parent.Name..code],code
        end
    end
    
    print("Loading Check Module") do
        function self.check.it(proper,func)
            if proper then func() end
        end
    end
end
