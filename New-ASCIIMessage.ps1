#region Awesome
    function New-ASCIIMessage{
        [CmdletBinding()]
        #[alias("")]
        [outputtype([System.String])]
        param(
            [Parameter(ParameterSetName="Default",       Mandatory, Position = 1, ValueFromPipeline)]
            [Parameter(ParameterSetName="NoBlackList",   Mandatory, Position = 1, ValueFromPipeline)]
            [Parameter(ParameterSetName="WhiteListOnly", Mandatory, Position = 1, ValueFromPipeline)]
            [ValidateNotNullOrEmpty()]
            [String]
                $Text,
            [Parameter(ParameterSetName="Default",                  Position = 1, ValueFromPipeline)]
            [Parameter(ParameterSetName="NoBlackList",              Position = 1, ValueFromPipeline)]
            [Parameter(ParameterSetName="WhiteListOnly",            Position = 1, ValueFromPipeline)]
            [ValidateNotNullOrEmpty()]
            [String]
                $Font,
            [Parameter(ParameterSetName="NoBlackList",   Mandatory)]
            [Switch]
                $IgnoreBlacklist,
            [Parameter(ParameterSetName="WhiteListOnly", Mandatory)]
            [Switch]
                $WhitelistOnly
        )
        $InvocationParams = @{}
        $PSBoundParameters.Keys | %{
            $InvocationParams.Add("$_", $PSBoundParameters[$_])
        }
        return New-ASCIIMessage-partii @InvocationParams
    }
    function New-ASCIIMessage-partii{
        [CmdletBinding()]
        #[alias("")]
        [outputtype([System.String])]
        param(
            [Parameter(ParameterSetName="Default",       Mandatory, Position = 1, ValueFromPipeline)]
            [Parameter(ParameterSetName="NoBlackList",   Mandatory, Position = 1, ValueFromPipeline)]
            [Parameter(ParameterSetName="WhiteListOnly", Mandatory, Position = 1, ValueFromPipeline)]
            [ValidateNotNullOrEmpty()]
            [String]
                $Text,
            [Parameter(ParameterSetName="Default",                  Position = 1, ValueFromPipeline)]
            [Parameter(ParameterSetName="NoBlackList",              Position = 1, ValueFromPipeline)]
            [Parameter(ParameterSetName="WhiteListOnly",            Position = 1, ValueFromPipeline)]
            [ValidateNotNullOrEmpty()]
            [String]
                $Font,
            [Parameter(ParameterSetName="NoBlackList",   Mandatory)]
            [Switch]
                $IgnoreBlacklist,
            [Parameter(ParameterSetName="WhiteListOnly", Mandatory)]
            [Switch]
                $WhitelistOnly
        )
        $APIHost     = "https://partii.herokuapp.com"
        $APIEndpoint = "convert"
        $InvocationParams = @{
            Uri              = "$APIHost/$APIEndpoint"
            Method           = "Get"
            DisableKeepAlive = $true
            ErrorAction      = "Stop"
        }
        $EndpointParameterList = @{
            message = $Text
        }
        if([String]::IsNullOrWhiteSpace($Font)){
            $EndpointParameterList.Add("font", "random")
            
        } else {
            $EndpointParameterList.Add("font", $font)
        }
        $InvocationParams.Add("Body", $EndpointParameterList)
        #$EncodedText  = [uri]::EscapeDataString($Text)
        #$APIMethodUrl = "$APIHost/make?text=$EncodedText&font=$Font"
        #Write-Debug "[APIMethodUrl] $APIMethodUrl"
        $ASCIIText = Invoke-Restmethod @InvocationParams

        return $ASCIIText
    }
    function New-ASCIIMessage-artii{
        [CmdletBinding()]
        #[alias("")]
        [outputtype([System.String])]
        param(
            [Parameter(ParameterSetName="Default",       Mandatory, Position = 1, ValueFromPipeline)]
            [Parameter(ParameterSetName="NoBlackList",   Mandatory, Position = 1, ValueFromPipeline)]
            [Parameter(ParameterSetName="WhiteListOnly", Mandatory, Position = 1, ValueFromPipeline)]
            [ValidateNotNullOrEmpty()]
            [string]
                $Text,
            [Parameter(ParameterSetName="Default",                  Position = 1, ValueFromPipeline)]
            [Parameter(ParameterSetName="NoBlackList",              Position = 1, ValueFromPipeline)]
            [Parameter(ParameterSetName="WhiteListOnly",            Position = 1, ValueFromPipeline)]
            [ValidateNotNullOrEmpty()]
            [string]
                $Font,
            [Parameter(ParameterSetName="NoBlackList",   Mandatory)]
            [Switch]
                $IgnoreBlacklist,
            [Parameter(ParameterSetName="WhiteListOnly", Mandatory)]
            [Switch]
                $WhitelistOnly
        )
        #region Sub-Functions
            function Get-RandomFont{
                param(
                    [String]$APIHost,
                    [Switch]$IgnoreBlacklist,
                    [Switch]$WhitelistOnly
                )
                $Font_WhiteList = @(
                        'larry3d'
                        'nancyj-fancy'
                        'cursive'
                        'usaflag'
                        '5x7', '6x9', 'clr4x6', 'clr5x8'
                        'house_of'
                        'sans'
                        'xtty', 'tty'
                        'new_asci'
                        'shadow'
                        'sbooki'
                        'univers'
                        'lcd'
                        'tinker-toy'
                        'lockergnome'
                        'serifcap'
                        'contessa'
                        'smisome1'
                        'lean'
                        'sketch_s'
                        'xttyb'
                        'alphabet'
                        'helv'
                        'ucf_fan_'
                        'diamond'
                        'fraktur'
                        'rev'
                    )
                # odel_lak = Mirrored 
                # eftipiti = 
                # goofy
                $Font_BlackList = @(
                        'd_dragon'
                        'tsalagi'
                        'e__fist_'
                        'relief2'
                        'notie_ca'
                        'eftichess'
                        'star_war'
                        'dcs_bfmo'
                        'skateroc'
                        'tecrvs__'
                        'fp2_____'
                        'fbr1____'
                        'jerusalem'
                        'green_be'
                        'sm______'
                        'char4___'
                        'baz__bil'
                        'war_of_w'
                        'usa_____'
                    )
                if(-Not $script:ASCIIFontList){
                    $script:ASCIIFontList = @($(Invoke-RestMethod "$APIHost/fonts_list").Split([Environment]::NewLine))
                }
                $FontList = @(if(-Not $IgnoreBlacklist){
                    if($WhitelistOnly){
                        $script:ASCIIFontList | Where { ($_ -in $Font_WhiteList) -and ($_ -notlike '*__') }
                    } else {
                        $script:ASCIIFontList | Where { ($_ -notin $Font_BlackList) -and ($_ -notlike '*__') }
                    }
                } else {
                    $script:ASCIIFontList
                })
                $RandomFontIndex = Get-Random -Maximum ($FontList.Count -1)
                $Font            = $FontList[$RandomFontIndex]
                Write-Debug "Font Name:  $Font"
                Write-Debug "Font Index: $RandomFontIndex"
                return $Font
            }
        #endregion

        $APIHost = "https://artii.herokuapp.com"

        if([String]::IsNullOrWhiteSpace($Font)){
            $Font = Get-RandomFont -APIHost $APIHost -IgnoreBlacklist:$IgnoreBlacklist -WhiteListOnly:$WhiteListOnly
        }
        $EncodedText  = [uri]::EscapeDataString($Text)
        $APIMethodUrl = "$APIHost/make?text=$EncodedText&font=$Font"
        Write-Debug "[APIMethodUrl] $APIMethodUrl"
        $ASCIIText = Invoke-Restmethod -Uri $APIMethodUrl -DisableKeepAlive -ErrorAction Stop

        return $ASCIIText
    }
#endregion