function Start-CountDown {
    param(
        [Parameter(Mandatory)]
        [int16]$Seconds,
        [Parameter()]
        [ValidateSet('Numeric','Bar','HalfBar')]
        [string]$Type = 'Bar'
    )
    $Cy = [console]::CursorTop
    if ($Type -eq 'Bar' -and $Seconds -gt ([console]::WindowWidth/2)) {
        $Type = 'HalfBar'
    }

    switch ($Type) {
        'Numeric' {
            for ($i = 1; $i -le $Seconds; $i++) {
                # set cursor to position before loop started (overwrite refresh counter)
                [console]::SetCursorPosition(0,$Cy)
                # output the counter, where '.' marks remaining seconds and 'o' passed seconds
                Write-Host ("Refresh in $($Seconds-$i)" + ' ' * ($Seconds.ToString().Length - ($Seconds-$i).ToString().Length))
                Start-Sleep -Seconds 1
            }            
        }
        'Bar' {
            for ($i = 1; $i -le $Seconds; $i++) {
                # set cursor to position before loop started (overwrite refresh counter)
                [console]::SetCursorPosition(0,$Cy)
                # output the counter, where '.' marks remaining seconds and 'o' passed seconds
                Write-Host ('Refresh in [' + 'o'*$i + '.'*($Seconds-$i) + ']')
                Start-Sleep -Seconds 1
            }
          }
        'HalfBar' {
            for ($i = 1; $i -le $Seconds; $i++) {
                # set cursor to position before loop started (overwrite refresh counter)
                [console]::SetCursorPosition(0,$Cy)
                # output the counter, where '.' marks remaining seconds and 'o' passed seconds
                Write-Host ('Refresh in [' + 'O'*[math]::Floor($i/2) + 'o'*($i%2) + '.'*[math]::Floor(($Seconds+($Seconds%2)-$i)/2) + ']')
                Start-Sleep -Seconds 1
            }
        }

        Default {}
    }

    [PSCustomObject]@{
        CursorY = $Cy
    }
}