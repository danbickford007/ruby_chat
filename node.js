var client, net;
net = require("net");
client = net.createConnection(2000);
console.log("connected");
client.on("data", function (data) {
  console.log(data);
});
client.on("end", function () {
  return console.log("client closed");
});
