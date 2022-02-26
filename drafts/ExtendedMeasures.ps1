$String = (
    'RwBlAHQALQBDAGgAaQBsAGQASQB0AGUAbQAgAC0AUgBlAGMAdQByAHMAZQAgAC0ARgBvAHIAYwBl' +
    'ACAALQBGAGkAbABlACAALQBFAHIAcgBvAHIAQQBjAHQAaQBvAG4AIABJAGcAbgBvAHIAZQAgAHwA' +
    'IABHAHIAbwB1AHAALQBPAGIAagBlAGMAdAAgAEUAeAB0AGUAbgBzAGkAbwBuACAAfAAgAEYAbwBy' +
    'AEUAYQBjAGgALQBPAGIAagBlAGMAdAAgAHsAIABBAGQAZAAtAE0AZQBtAGIAZQByACAALQBJAG4A' +
    'cAB1AHQATwBiAGoAZQBjAHQAIAAkAF8AIAAtAE0AZQBtAGIAZQByAFQAeQBwAGUAIABOAG8AdABl' +
    'AFAAcgBvAHAAZQByAHQAeQAgAC0ATgBhAG0AZQAgACIAVABvAHQAYQBsAEwAZQBuAGcAdABoACIA' +
    'IAAtAFYAYQBsAHUAZQAgACgAJABfAC4ARwByAG8AdQBwACAAfAAgAE0AZQBhAHMAdQByAGUALQBP' +
    'AGIAagBlAGMAdAAgAEwAZQBuAGcAdABoACAALQBTAHUAbQApAC4AUwB1AG0AIAAtAFAAYQBzAHMA' +
    'VABoAHIAdQAgAH0AIAB8ACAAUwBvAHIAdAAtAE8AYgBqAGUAYwB0ACAAVABvAHQAYQBsAEwAZQBu' +
    'AGcAdABoACAALQBEAGUAcwBjAGUAbgBkAGkAbgBnACAAfAAgAFMAZQBsAGUAYwB0AC0ATwBiAGoA' +
    'ZQBjAHQAIAAtAEYAaQByAHMAdAAgADUAIAB8ACAARgBvAHIARQBhAGMAaAAtAE8AYgBqAGUAYwB0' +
    'ACAAewAgACQAXwAuAEcAcgBvAHUAcAAgAHwAIABTAG8AcgB0AC0ATwBiAGoAZQBjAHQAIABMAGUA' +
    'bgBnAHQAaAAgAC0ARABlAHMAYwBlAG4AZABpAG4AZwAgAHwAIABTAGUAbABlAGMAdAAtAE8AYgBq' +
    'AGUAYwB0ACAALQBGAGkAcgBzAHQAIAA2ACAAfQAgAHwAIABTAG8AcgB0AC0ATwBiAGoAZQBjAHQA' +
    'IAB7ACAAJABfAC4ATABhAHMAdABBAGMAYwBlAHMAcwBUAGkAbQBlAC4ATQBvAG4AdABoACAAfQA='
)

$Solution = {
    Get-ChildItem -Recurse -Force -File -ErrorAction Ignore |
        Group-Object Extension | Add-Member -MemberType NoteProperty -Name "TotalLength" -Value (
            $_.Group | Measure-Object Length -Sum
        ).Sum -PassThru |
        Sort-Object TotalLength -Descending |
        Select-Object -First 5 |
        ForEach-Object {
            $_.Group |
                Sort-Object Length -Descending |
                Select-Object -First 6
        } | Sort-Object { $_.LastAccessTime.Month }
}
$Solution = [scriptblock]::Create(
    [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($String))
).InvokeReturnAsIs()
