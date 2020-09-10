# escape=`

FROM mcr.microsoft.com/windows/servercore:2004
ADD run.bat C:/run.bat
COPY src c:/src
WORKDIR C:/src
EXPOSE 8181
# https://docs.microsoft.com/en-us/visualstudio/install/build-tools-container?view=vs-2019
SHELL ["cmd", "/S", "/C"]

ADD https://aka.ms/vs/16/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe

RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache `
    --installPath C:\BuildTools `
    --add Microsoft.VisualStudio.Workload.AzureBuildTools `
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 `
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 `
    --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 `
    --remove Microsoft.VisualStudio.Component.Windows81SDK `
 || IF "%ERRORLEVEL%"=="3010" EXIT 0

RUN powershell "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));`
    mkdir PCFCLI;`
    Register-PackageSource -ProviderName Nuget -Name Nuget -Location https://www.nuget.org/api/v2 -Confirm:$false -Verbose -Force;`
    Install-Package -Name Microsoft.PowerApps.CLI -ProviderName NuGet -Destination ../PCFCLI -Confirm:$false -Verbose -Force;`
    choco install nodejs --force --confirm;`
    choco install netfx-4.6.2-devpack --force --confirm"
RUN powershell "$path = $env:path + ';' + $(Resolve-Path 'C:\PCFCLI\Microsoft.PowerApps.CLI*\tools' | Select -ExpandProperty Path); `
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\' -Name Path -Value $path"
ENTRYPOINT ["C:\\run.bat", "&&", "cmd"]
#ENTRYPOINT ["C:\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&", "cmd"]
#CMD "pac pcf init -ns %namespace% -n %name% -t %template%"