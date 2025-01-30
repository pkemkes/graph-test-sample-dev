#include "httprequests.h"


int main() {
    int ret_val;
    char *urls[] = {
        "www.google.com",
        "www.facebook.com",
        "www.x.com",
        "www.github.com"
    };
    for (int i = 0; i < 4; i++) {
        ret_val = send_https_get_request(urls[i]);
        if (ret_val != 0) {
            return ret_val;
        }
    }
    return 0;
}