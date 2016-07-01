#include "asf.h"

#ifdef __cplusplus
extern "C" {
#endif

int main(void) {
    system_init();
    delay_init();

    while (1) {
        port_pin_toggle_output_level(LED0_PIN);
        delay_ms(100);

        port_pin_set_output_level(LED0_PIN, LED0_INACTIVE);
        delay_ms(100);
    }
}

#ifdef __cplusplus
}
#endif
