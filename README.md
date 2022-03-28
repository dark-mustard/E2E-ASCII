
# E2E ASCII
With the rise of quantum computing - E2E encryption is no longer good enough.  So just don't worry about it and make your message kick-ass instead!

Also the widely used artii.herokuapp.com url stopped working so i deployed this slightly different version to partii.herokuapp.com - I really enjoy spamming it with bad words when i'm pissed about someone instead of just talking to them - so I went for it!

## Here's a conclusive list of example urls:

#### Gets a list of ASCII fonts I found - most should work but some might not
```
https://partii.herokuapp.com/fonts
```

#### Uses the default font every time if the "font" param is not specified
```
https://partii.herokuapp.com/convert?message=hello$20world
```

#### If "font" is equal to a valid font name, then hells yeah
```
#https://partii.herokuapp.com/convert?message=hello$20world&font=3-d
```

#### You can also set that shit to "random" and it'll roll trips
```
#https://partii.herokuapp.com/convert?message=hello$20world&font=random
```

PowerShell script included that consumes the API / as well as the old one too.

```powershell

PS E:\> New-Asciimessage -Text "I AM A HUGE ASSHOLE"
o-O-o       O  o   o       O      o  o o   o  o-o  o--o 
  |        / \ |\ /|      / \     |  | |   | o     |
  |       o---o| O |     o---o    O--O |   | |  -o O-o
  |       |   ||   |     |   |    |  | |   | o   | |
o-O-o     o   oo   o     o   o    o  o  o-o   o-o  o--o 


  O   o-o   o-o  o  o  o-o  o    o--o
 / \ |     |     |  | o   o |    |
o---o o-o   o-o  O--O |   | |    O-o
|   |    |     | |  | o   o |    |
o   oo--o  o--o  o  o  o-o  O---oo--o

 ```
