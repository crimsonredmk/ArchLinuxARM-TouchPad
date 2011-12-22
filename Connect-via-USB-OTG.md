#### Plugging in a keyboard and mouse ####

By default, you're logged in as the "linux" user into Gnome.
There is an on-screen keyboard in Menu -> Accessories -> Keyboard.

The HP TouchPad's microUSB port has OTG capabilities, but using them is
a pain and is much harder than you'd expect. A $3 microUSB-to-USB OTG
adapter won't work. You need to buy an adapter with "host" capabilities.
A link to such an adapter is given below.

You'll also need a special "Y-cable" to provide power to the TouchPad.
A link is given below to a known working one.

The reasoning behind this is that the TouchPad puts the USB port into
"low power" mode unless there is current flowing into it. So
plugging in an OTG cable and a keyboard or even a powered hub won't
work because you have no way of providing power to the USB port on the
TouchPad, so the port will stay in sleep mode. The Y-cable solves this
problem by charging the TouchPad while letting you use a keyboard. This
cable is a bit expensive ($15 on Amazon), but for now, it's the only
way.

Here's how to hook everything up:

    |PC USB port|[ <-------Y cable-----------[ <-----|Keyboard/Mouse/Hub|
                                      |
                                      |
    |TouchPad|[<--OTG Cable--[ <-------
    
Basically, connect one of the Y-cable's male ends into a PC and the
other into the TouchPad's OTG adapter cable. Plug in a keyboard or hub
into the Y-cable's female end.

Here are the parts that I have confirmed working:
- http://www.amazon.com/gp/product/B005GGBYJ4/

- http://www.amazon.com/gp/product/B000JIOHDE/
