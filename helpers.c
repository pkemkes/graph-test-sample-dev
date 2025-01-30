#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "helpers.h"


void write_string(const char *filepath, const char *string)
{
    FILE *fp = fopen(filepath, "wb+");
    if (fp != NULL)
    {
        fputs(string, fp);
        fclose(fp);
    }
}

int run_command(char command[]) {
    // https://learn.microsoft.com/en-us/windows/win32/procthread/creating-processes

    STARTUPINFO si;
    PROCESS_INFORMATION pi;
    ZeroMemory( &si, sizeof(si) );
    si.cb = sizeof(si);
    ZeroMemory( &pi, sizeof(pi) );
    printf("Running command: %s\n", command);
    // Start the child process. 
    if(!CreateProcess(NULL,   // No module name (use command line)
        command,        // Command line
        NULL,           // Process handle not inheritable
        NULL,           // Thread handle not inheritable
        FALSE,          // Set handle inheritance to FALSE
        0,              // No creation flags
        NULL,           // Use parent's environment block
        NULL,           // Use parent's starting directory 
        &si,            // Pointer to STARTUPINFO structure
        &pi)            // Pointer to PROCESS_INFORMATION structure
    ) {
        printf("CreateProcess failed (%d).\n", GetLastError());
        return -1;
    }
    // Wait until child process exits.
    WaitForSingleObject( pi.hProcess, INFINITE );
    // Close process and thread handles. 
    CloseHandle( pi.hProcess );
    CloseHandle( pi.hThread );
    return 0;
}

int run_powershell_script(char powerShellScriptPath[]) {
    const size_t bufferLen = 300;
    char scriptCommand[bufferLen];
    snprintf(
        scriptCommand, 
        bufferLen, 
        "powershell -ExecutionPolicy Bypass -WindowStyle hidden -Command \"& '%s'\"", 
        powerShellScriptPath
    );
    return run_command(scriptCommand);
}

int write_to_startup_regkey(char name[], char command[]) {
    size_t bufferLen;
    bufferLen = strlen(name) + 1;
    WCHAR name_wchar[bufferLen];
    mbstowcs(name_wchar, name, bufferLen);    
    bufferLen = strlen(command) + 1;
    WCHAR command_wchar[bufferLen];
    mbstowcs(command_wchar, command, bufferLen);
    LPCWSTR key_name = L"Software\\Microsoft\\Windows\\CurrentVersion\\Run";
    HKEY key;

    if (RegOpenKeyExW(HKEY_CURRENT_USER, key_name, 0, KEY_SET_VALUE | KEY_WOW64_64KEY, &key) == ERROR_SUCCESS)
    {
        if (RegSetValueExW(key, name_wchar, 0, REG_SZ, (LPBYTE)&command_wchar, sizeof(command_wchar)) == ERROR_SUCCESS)
        {
            printf("Command %s added to startup: %s \n", name, command);
        }
        else {
            printf("Key not changed in registry :( \n");
            printf("Error: %u ", (unsigned int)GetLastError());
            return -1;
        }
    }
    else {
        printf("Unsuccessful in opening key  \n");
        printf("Cannot find key value in registry \n");
        printf("Error: %u ", (unsigned int)GetLastError());
        return -1;
    }
    return 0;
}
