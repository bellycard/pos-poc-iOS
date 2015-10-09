# POS-POC-iOS

Would you like Belly's Merchant iPad to display transaction information from your point of sale terminal? You've come to the right place! This sample project will show you how easy it is to connect with our iPad across a LAN via Bonjour.

## Connecting and Sending Information

Start in `BELBonjourServer.m`. This example code is looking for a specific type of service, created based on the 4 digit PIN entered here and in the Belly iPad's admin console. Once the two servers are looking for one another the Belly iPad will send a [pairing request](Payloads/pairing.json).

In this sample project all pairing requests are accepted.

Once a pairing request is received the server will return its [configuration](Payloads/config.json).

Once the Belly iPad receives your configuration it will begin waiting for [sale information](Payloads/sale.json). If you have a Belly iPad properly configured you would see the current transaction on screen.

As long as both applications are open the Belly iPad will wait to display new sale information. The Belly iPad is a dumb terminal in this relationship. There is no state, only the current sale. Every time an item is added or the prices change a new sale object should be sent across the wire.

## Acknowledgements

Thanks to [Cocoanetics](https://github.com/Cocoanetics) and [DTBonjour](https://github.com/Cocoanetics/DTBonjour).

## Learn More

In order to see the complete integration you will need a properly configured Belly iPad. Please get in touch with Belly Engineering if you'd like to learn more.
