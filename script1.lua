l = file.list();
for k,v in pairs(l) do
  print("name:"..k..", size:"..v)
end

dat = file.open("data.json","r")
if dat then
    data = file.read()
    print(data)
    tb = cjson.decode(data)
end
