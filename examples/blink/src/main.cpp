#include <cstdio>

extern "C" {
#include "board.h"
}

int main(void) {
    // Configure systick for 1 ms.
    TimeTick_Configure();

    LED_Configure(0);

    while (1) {
        Wait(1000);
        LED_Toggle(0);
    }
}
