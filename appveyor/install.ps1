# Sample script to install Python and pip under Windowsr
# Authors: Olivier Grisel, Jonathan Helmus and Kyle Kastnerr
# License: CC0 1.0 Universal: http://creativecommons.org/publicdomain/zero/1.0/r
r
$MINICONDA_URL = "http://repo.continuum.io/miniconda/"r
$BASE_URL = "https://www.python.org/ftp/python/"r
$GET_PIP_URL = "https://bootstrap.pypa.io/get-pip.py"r
$GET_PIP_PATH = "C:\get-pip.py"r
r
r
function DownloadPython ($python_version, $platform_suffix) {r
    $webclient = New-Object System.Net.WebClientr
    $filename = "python-" + $python_version + $platform_suffix + ".msi"r
    $url = $BASE_URL + $python_version + "/" + $filenamer
r
    $basedir = $pwd.Path + "\"r
    $filepath = $basedir + $filenamer
    if (Test-Path $filename) {r
        Write-Host "Reusing" $filepathr
        return $filepathr
    }r
r
    # Download and retry up to 3 times in case of network transient errors.r
    Write-Host "Downloading" $filename "from" $urlr
    $retry_attempts = 2r
    for($i=0; $i -lt $retry_attempts; $i++){r
        try {r
            $webclient.DownloadFile($url, $filepath)r
            breakr
        }r
        Catch [Exception]{r
            Start-Sleep 1r
        }r
   }r
   if (Test-Path $filepath) {r
       Write-Host "File saved at" $filepathr
   } else {r
       # Retry once to get the error message if any at the last tryr
       $webclient.DownloadFile($url, $filepath)r
   }r
   return $filepathr
}r
r
r
function InstallPython ($python_version, $architecture, $python_home) {r
    Write-Host "Installing Python" $python_version "for" $architecture "bit architecture to" $python_homer
    if (Test-Path $python_home) {r
        Write-Host $python_home "already exists, skipping."r
        return $falser
    }r
    if ($architecture -eq "32") {r
        $platform_suffix = ""r
    } else {r
        $platform_suffix = ".amd64"r
    }r
    $filepath = DownloadPython $python_version $platform_suffixr
    Write-Host "Installing" $filepath "to" $python_homer
    $install_log = $python_home + ".log"r
    $args = "/qn  /log $install_log /i $filepath TARGETDIR=$python_home"r
    Write-Host "msiexec.exe" $argsr
    Start-Process -FilePath "msiexec.exe" -ArgumentList $args -Wait -Passthrur
    if (Test-Path $python_home) {r
        Write-Host "Python $python_version ($architecture) installation complete"r
    } else {r
        Write-Host "Failed to install Python in $python_home"r
        Get-Content -Path $install_logr
        Exit 1r
    }r
}r
r
r
function InstallPip ($python_home) {r
    $pip_path = $python_home + "\Scripts\pip.exe"r
    $python_path = $python_home + "\python.exe"r
    if (-not(Test-Path $pip_path)) {r
        Write-Host "Installing pip..."r
        $webclient = New-Object System.Net.WebClientr
        $webclient.DownloadFile($GET_PIP_URL, $GET_PIP_PATH)r
        Write-Host "Executing:" $python_path $GET_PIP_PATHr
        Start-Process -FilePath "$python_path" -ArgumentList "$GET_PIP_PATH" -Wait -Passthrur
    } else {r
        Write-Host "pip already installed."r
    }r
}r
r
r
function DownloadMiniconda ($python_version, $platform_suffix) {r
    $webclient = New-Object System.Net.WebClientr
    if ($python_version -eq "3.4") {r
        $filename = "Miniconda3-3.5.5-Windows-" + $platform_suffix + ".exe"r
    } else {r
        $filename = "Miniconda-3.5.5-Windows-" + $platform_suffix + ".exe"r
    }r
    $url = $MINICONDA_URL + $filenamer
r
    $basedir = $pwd.Path + "\"r
    $filepath = $basedir + $filenamer
    if (Test-Path $filename) {r
        Write-Host "Reusing" $filepathr
        return $filepathr
    }r
r
    # Download and retry up to 3 times in case of network transient errors.r
    Write-Host "Downloading" $filename "from" $urlr
    $retry_attempts = 2r
    for($i=0; $i -lt $retry_attempts; $i++){r
        try {r
            $webclient.DownloadFile($url, $filepath)r
            breakr
        }r
        Catch [Exception]{r
            Start-Sleep 1r
        }r
   }r
   if (Test-Path $filepath) {r
       Write-Host "File saved at" $filepathr
   } else {r
       # Retry once to get the error message if any at the last tryr
       $webclient.DownloadFile($url, $filepath)r
   }r
   return $filepathr
}r
r
r
function InstallMiniconda ($python_version, $architecture, $python_home) {r
    Write-Host "Installing Python" $python_version "for" $architecture "bit architecture to" $python_homer
    if (Test-Path $python_home) {r
        Write-Host $python_home "already exists, skipping."r
        return $falser
    }r
    if ($architecture -eq "32") {r
        $platform_suffix = "x86"r
    } else {r
        $platform_suffix = "x86_64"r
    }r
    $filepath = DownloadMiniconda $python_version $platform_suffixr
    Write-Host "Installing" $filepath "to" $python_homer
    $install_log = $python_home + ".log"r
    $args = "/S /D=$python_home"r
    Write-Host $filepath $argsr
    Start-Process -FilePath $filepath -ArgumentList $args -Wait -Passthrur
    if (Test-Path $python_home) {r
        Write-Host "Python $python_version ($architecture) installation complete"r
    } else {r
        Write-Host "Failed to install Python in $python_home"r
        Get-Content -Path $install_logr
        Exit 1r
    }r
}r
r
r
function InstallMinicondaPip ($python_home) {r
    $pip_path = $python_home + "\Scripts\pip.exe"r
    $conda_path = $python_home + "\Scripts\conda.exe"r
    if (-not(Test-Path $pip_path)) {r
        Write-Host "Installing pip..."r
        $args = "install --yes pip"r
        Write-Host $conda_path $argsr
        Start-Process -FilePath "$conda_path" -ArgumentList $args -Wait -Passthrur
    } else {r
        Write-Host "pip already installed."r
    }r
}r
r
function main () {r
    InstallPython $env:PYTHON_VERSION $env:PYTHON_ARCH $env:PYTHONr
    InstallPip $env:PYTHONr
}r
r
mainr
