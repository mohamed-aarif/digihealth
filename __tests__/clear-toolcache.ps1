param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet('Windows', 'Linux', 'macOS')]
    [string]$RunnerOs
)

$ErrorActionPreference = 'Stop'

function Invoke-Cleanup {
    param(
        [string]$Path
    )

    if ([string]::IsNullOrWhiteSpace($Path)) {
        return
    }

    if (-not (Test-Path -LiteralPath $Path)) {
        Write-Host "Skipped: $Path (not found)"
        return
    }

    Write-Host "Removing: $Path"
    Remove-Item -LiteralPath $Path -Recurse -Force -ErrorAction SilentlyContinue
}

switch ($RunnerOs) {
    'Windows' {
        Invoke-Cleanup -Path (Join-Path $env:LOCALAPPDATA 'Microsoft\dotnet')
        Invoke-Cleanup -Path (Join-Path $env:USERPROFILE '.dotnet')

        if ($env:AGENT_TOOLSDIRECTORY) {
            Invoke-Cleanup -Path (Join-Path $env:AGENT_TOOLSDIRECTORY 'dotnet')
        }

        if ($env:RUNNER_TOOL_CACHE) {
            Invoke-Cleanup -Path (Join-Path $env:RUNNER_TOOL_CACHE 'dotnet')
        }
    }
    'Linux' {
        Invoke-Cleanup -Path '/usr/share/dotnet'
        Invoke-Cleanup -Path '/opt/hostedtoolcache/dotnet'
    }
    'macOS' {
        Invoke-Cleanup -Path '/usr/local/share/dotnet'
        Invoke-Cleanup -Path '/Users/runner/hostedtoolcache/dotnet'
    }
}

Write-Host "Tool cache cleanup finished for $RunnerOs runners."
