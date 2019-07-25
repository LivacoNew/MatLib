# MatLib
MatLib is a simple and easy to use UI Library that allows you to make Material VGUIs easialy and hassle free.
<br>
## So, what can I do with this?
You can create your entire VGUI, but instead of the usual 200-300 lines you might have, you might only need about 30. MatLib allows you to make almost everything with a simple function, and also allows you to change colors, ect.
<br>
## Example
```lua
-- Creates a frame, and has an example text inside it.

-- MatLib.Frame(posX[-1 for center], posY[-1 for center], width, height, title)
local frame = MatLib.Frame(-1, -1, ScrW() * 0.5, ScrH() * 0.5, "Example Frame")
-- MatLib.Text(parentItem, posX, posY, text)
MatLib.Text(frame, frame:GetWide() * 0.1, frame:GetTall() * 0.2, "This is an example frame with example text!")
```
It's about as easy as that. If you need any more help, you can view cl_example.lua and get more insight into it.
<br>
## Images 
Here's some images of how the UI looks.
<br><br>
Image of the example above.
![First Image](https://upload.livaco.dev/u/uK1NWk2c5i.png)
<br>
One of the built-in examples (matlib_fact command).
![Second Image](https://upload.livaco.dev/u/p02SrKybg8.png)
<br>
## Can I Use this?
Anyone is free to use this. If your re-distributing it (In an addon per-say), please credit me. You can also use this for Gmodstore/Paid addons if you so wish.
<br>
## Credits
If anyone choses to contribute, you will also be listed here.
<br><br>
- [Livaco](https://github.com/LivacoNew) for actually doing it.
- [Owain](https://github.com/OwjoTheGreat) for the idea of it.
