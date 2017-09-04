local module = {}

module.SSID = {}
module.SSID["wifi"] = "Someone@2.4Ghz"

module.HOST = "some-one.me"
module.PORT = "1883"
module.ID = node.chipid()

module.ENDPOINT = "nodemcu/"
return module