
# E2E ASCII
With the rise of quantum computing - E2E encryption is no longer good enough.  So just don't worry about it and make your message kick-ass instead!

Also the widely used artii.herokuapp.com url stopped working so i deployed this slightly different version to partii.herokuapp.com - I really enjoy spamming it with bad words when i'm pissed at someone instead of just talking to them - so I went for it!

## Usage Examples

### Endpoints / Formats
**All request methods only accept GET**
Here's a list of current endpoints and example urls:
#### `fonts`
Examples:
- Example 1: Get a list of ASCII fonts I found - most should work but some might not
```
https://partii.herokuapp.com/fonts
```
#### `convert`
Examples:
- Example 1: Uses the default font every time if the "font" param is not specified
```
https://partii.herokuapp.com/convert?message=hello$20world
```
- Example 2: Specify specific "font" by name (must be from list)
```
#https://partii.herokuapp.com/convert?message=hello$20world&font=3-d
```
- Example 3: Randomize output font by setting "font" to "random"
```
#https://partii.herokuapp.com/convert?message=hello$20world&font=random
```

### Consuming API w/ PowerShell
PowerShell script included contains functions that consume the API (as well as the one it was based on).  

Here is a basic function example to convert a message:
```powershell
function New-ASCIIMessage{
        [CmdletBinding()]
        [Alias("ASCII-fy")]
        [outputtype([System.String])]
        param(           
            [String]
            [ValidateNotNullOrEmpty()]
                $Text,
            [String]
            [ValidateNotNullOrEmpty()]
                $Font
        )
        # Defaults
        $APIHost          = "https://partii.herokuapp.com"
        $APIEndpoint      = "convert"
        
        # Set up parameters specific to endpoint
        # [message] is always required
        $EndpointParameterList = @{
            message = $Text 
        }
        # [font] is optionsl
        if([String]::IsNullOrWhiteSpace($Font)){
            $EndpointParameterList.Add("font", "random")
        } else {
            $EndpointParameterList.Add("font", $font)
        }
        
        # Call API
        $InvocationParams = @{
            Uri              = "$APIHost/$APIEndpoint"
            Method           = "Get"
            DisableKeepAlive = $true
            ErrorAction      = "Stop"
            Body             = $EndpointParameterLis
        }
        $ASCIIText = Invoke-Restmethod @InvocationParams
        return $ASCIIText
    }
```

Call the function like this:
```powershell
New-ASCIIMessage -Text "#yolo"
```
 
Returns raw ASCII string:
```
    ::  ::.-:.     ::-.   ...      :::         ...     
__,;'_,;'_';;.   ;;;;'.;;;;;;;.   ;;;      .;;;;;;;.  
''[[''[[''  '[[,[[[' ,[[     \[[, [[[     ,[[     \[[,
 ,$" ,$"      c$$"   $$$,     $$$ $$'     $$$,     $$$
o88oo88oo   ,8P"`    "888,_ _,88Po88oo,.__"888,_ _,88P
,M" ,M"    mM"         "YMMMMMP" """"YUMMM  "YMMMMMP" 
```
