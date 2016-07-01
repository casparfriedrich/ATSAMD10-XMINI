#include "asf.h"
#include "stdio_serial.h"
#include "conf_uart_serial.h"

#define STRING_EOL "\r"
#define STRING_HEADER                                                 \
    "-- Getting Started Example --\r\n"                               \
    "-- " BOARD_NAME                                                  \
    " --\r\n"                                                         \
    "-- Compiled: "__DATE__                                           \
    " "__TIME__                                                       \
    " --\r\n"                                                         \
    "-- Pressing and release button SW0 should make LED0 on and off " \
    "--" STRING_EOL

#ifdef __cplusplus
extern "C" {
#endif

static struct usart_module cdc_uart_module;
static struct tc_module tc_instance;

#define TC_COUNT_VALUE 55535

static void configure_console(void) {
    struct usart_config usart_conf;

    usart_get_config_defaults(&usart_conf);
    usart_conf.mux_setting = CONF_STDIO_MUX_SETTING;
    usart_conf.pinmux_pad0 = CONF_STDIO_PINMUX_PAD0;
    usart_conf.pinmux_pad1 = CONF_STDIO_PINMUX_PAD1;
    usart_conf.pinmux_pad2 = CONF_STDIO_PINMUX_PAD2;
    usart_conf.pinmux_pad3 = CONF_STDIO_PINMUX_PAD3;
    usart_conf.baudrate = CONF_STDIO_BAUDRATE;

    stdio_serial_init(&cdc_uart_module, CONF_STDIO_USART_MODULE, &usart_conf);
    usart_enable(&cdc_uart_module);
}

static void update_led_state(void) {
    bool pin_state = port_pin_get_input_level(BUTTON_0_PIN);
    if (pin_state) {
        port_pin_set_output_level(LED_0_PIN, LED_0_INACTIVE);
    } else {
        port_pin_set_output_level(LED_0_PIN, LED_0_ACTIVE);
    }
}

static void extint_callback(void) {
    update_led_state();
}

static void configure_eic_callback(void) {
    extint_register_callback(extint_callback, BUTTON_0_EIC_LINE,
                             EXTINT_CALLBACK_TYPE_DETECT);
    extint_chan_enable_callback(BUTTON_0_EIC_LINE, EXTINT_CALLBACK_TYPE_DETECT);
}

static void configure_extint(void) {
    struct extint_chan_conf eint_chan_conf;
    extint_chan_get_config_defaults(&eint_chan_conf);

    eint_chan_conf.gpio_pin = BUTTON_0_EIC_PIN;
    eint_chan_conf.gpio_pin_mux = BUTTON_0_EIC_MUX;
    eint_chan_conf.detection_criteria = EXTINT_DETECT_BOTH;
    eint_chan_conf.filter_input_signal = true;
    extint_chan_set_config(BUTTON_0_EIC_LINE, &eint_chan_conf);
}

static void tc_callback_to_counter(struct tc_module *const module_inst) {
    static uint32_t count = 0;
    count++;
    if (count % 800 == 0) {
        printf("The output is triggered by TC counter\r\n");
    }

    tc_set_count_value(module_inst, TC_COUNT_VALUE);
}

static void configure_tc(void) {
    struct tc_config config_tc;

    tc_get_config_defaults(&config_tc);
    config_tc.counter_size = TC_COUNTER_SIZE_16BIT;
    config_tc.counter_16_bit.value = TC_COUNT_VALUE;

    tc_init(&tc_instance, CONF_TC_INSTANCE, &config_tc);
    tc_enable(&tc_instance);
}

static void configure_tc_callbacks(void) {
    tc_register_callback(&tc_instance, tc_callback_to_counter,
                         TC_CALLBACK_OVERFLOW);
    tc_enable_callback(&tc_instance, TC_CALLBACK_OVERFLOW);
}

int main(void) {
    struct port_config pin;

    system_init();

    /*Configure UART console.*/
    configure_console();

    /*Configures the External Interrupt*/
    configure_extint();

    /*Configures the External Interrupt callback*/
    configure_eic_callback();

    /*Configures  TC driver*/
    configure_tc();

    /*Configures TC callback*/
    configure_tc_callbacks();

    /*Initialize the delay driver*/
    delay_init();

    /* Output example information */
    puts(STRING_HEADER);

    /*Enable system interrupt*/
    system_interrupt_enable_global();

    /*Configures PORT for LED0*/
    port_get_config_defaults(&pin);
    pin.direction = PORT_PIN_DIR_OUTPUT;
    port_pin_set_config(LED0_PIN, &pin);

    port_pin_set_output_level(LED0_PIN, LED0_INACTIVE);

    for (int i = 0; i < 3; i++) {
        port_pin_toggle_output_level(LED0_PIN);
        delay_s(1);
    }

    for (int i = 0; i < 20; i++) {
        port_pin_toggle_output_level(LED0_PIN);
        delay_ms(100);
    }

    port_pin_set_output_level(LED0_PIN, LED0_INACTIVE);

    /*main loop*/
    while (1)
        ;
}

#ifdef __cplusplus
}
#endif
