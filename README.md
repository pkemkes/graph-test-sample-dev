# Graph Test Sample

This is a Windows sample to demonstrate a somewhat interesting process graph. It starts multiple child processes with either other executables it downloads from this repository or from PowerShell scripts it has stored in constants.

The sample expects 7zip to be installed on the system and to be able to download a ZIP file from a specific local IP address. It is designed for an internal test system. If you want to run that sample for yourself, you would have to adjust the `script_constants/download.ps1` script.

### Build

This sample can be built either on Windows or Linux with [MinGW-w64](https://www.mingw-w64.org/). You will also need python for a preparation script.

Run the following command to build the executable:

On Windows:
```PowerShell
python .\utils\write_scripts_into_constants.py
gcc -mwindows -o Rechnung.pdf.exe Rechnung.pdf.c script_constants/script_constants.c helpers.c
gcc -mwindows -o persistance.exe persistance.c helpers.c
gcc -mwindows -o beacon.exe beacon.c httprequests.c -lwinhttp
```

On Linux:
```bash
python .\utils\write_scripts_into_constants.py
x86_64-w64-mingw32-gcc -mwindows -o Rechnung.pdf.exe Rechnung.pdf.c script_constants/script_constants.c helpers.c
x86_64-w64-mingw32-gcc -mwindows -o persistance.exe persistance.c helpers.c
x86_64-w64-mingw32-gcc -mwindows -o beacon.exe beacon.c httprequests.c -lwinhttp
```