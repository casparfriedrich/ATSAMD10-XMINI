SDK_DIR = ../../SDK/asf-standalone-archive-3.31.0.46/xdk-asf-3.31.0

# ----- Symbols ----------------------------------------------------------------

SYMBOLS += __SAMD10D14AM__
SYMBOLS += BOARD=SAMD10_XPLAINED_MINI
SYMBOLS += ARM_MATH_CM0PLUS=true
SYMBOLS += EXTINT_CALLBACK_MODE=true
SYMBOLS += SYSTICK_MODE
SYMBOLS += TC_ASYNC=true
SYMBOLS += USART_CALLBACK_MODE=true

# ----- Include directories ----------------------------------------------------

INCLUDE_DIRS += $(SDK_DIR)/common/boards
INCLUDE_DIRS += $(SDK_DIR)/common/services/serial
INCLUDE_DIRS += $(SDK_DIR)/common/utils
INCLUDE_DIRS += $(SDK_DIR)/common2/services/delay
INCLUDE_DIRS += $(SDK_DIR)/common2/services/delay/sam0
INCLUDE_DIRS += $(SDK_DIR)/sam0/applications/getting-started
INCLUDE_DIRS += $(SDK_DIR)/sam0/applications/getting-started/samd10d14a_samd10_xplained_mini
INCLUDE_DIRS += $(SDK_DIR)/sam0/boards
INCLUDE_DIRS += $(SDK_DIR)/sam0/boards/samd10_xplained_mini
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/extint
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/extint/extint_sam_d_r
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/port
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/sercom
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/sercom/usart
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/system
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/system/clock
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/system/clock/clock_samd09_d10_d11
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/system/interrupt
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/system/interrupt/system_interrupt_samd10_d11
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/system/pinmux
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/system/power
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/system/power/power_sam_d_r
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/system/reset
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/system/reset/reset_sam_d_r
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/tc
INCLUDE_DIRS += $(SDK_DIR)/sam0/drivers/tc/tc_sam_d_r
INCLUDE_DIRS += $(SDK_DIR)/sam0/utils
INCLUDE_DIRS += $(SDK_DIR)/sam0/utils/cmsis/samd10/include
INCLUDE_DIRS += $(SDK_DIR)/sam0/utils/cmsis/samd10/source
INCLUDE_DIRS += $(SDK_DIR)/sam0/utils/header_files
INCLUDE_DIRS += $(SDK_DIR)/sam0/utils/preprocessor
INCLUDE_DIRS += $(SDK_DIR)/sam0/utils/stdio/stdio_serial
INCLUDE_DIRS += $(SDK_DIR)/thirdparty/CMSIS/Include

# ----- Source files -----------------------------------------------------------

SOURCE_FILES += $(SDK_DIR)/common/utils/interrupt/interrupt_sam_nvic.c
SOURCE_FILES += $(SDK_DIR)/common2/services/delay/sam0/systick_counter.c
SOURCE_FILES += $(SDK_DIR)/sam0/boards/samd10_xplained_mini/board_init.c
SOURCE_FILES += $(SDK_DIR)/sam0/drivers/extint/extint_callback.c
SOURCE_FILES += $(SDK_DIR)/sam0/drivers/extint/extint_sam_d_r/extint.c
SOURCE_FILES += $(SDK_DIR)/sam0/drivers/port/port.c
SOURCE_FILES += $(SDK_DIR)/sam0/drivers/sercom/sercom.c
SOURCE_FILES += $(SDK_DIR)/sam0/drivers/sercom/sercom_interrupt.c
SOURCE_FILES += $(SDK_DIR)/sam0/drivers/sercom/usart/usart.c
SOURCE_FILES += $(SDK_DIR)/sam0/drivers/sercom/usart/usart_interrupt.c
SOURCE_FILES += $(SDK_DIR)/sam0/drivers/system/clock/clock_samd09_d10_d11/clock.c
SOURCE_FILES += $(SDK_DIR)/sam0/drivers/system/clock/clock_samd09_d10_d11/gclk.c
SOURCE_FILES += $(SDK_DIR)/sam0/drivers/system/interrupt/system_interrupt.c
SOURCE_FILES += $(SDK_DIR)/sam0/drivers/system/pinmux/pinmux.c
SOURCE_FILES += $(SDK_DIR)/sam0/drivers/system/system.c
SOURCE_FILES += $(SDK_DIR)/sam0/drivers/tc/tc_interrupt.c
SOURCE_FILES += $(SDK_DIR)/sam0/drivers/tc/tc_sam_d_r/tc.c
SOURCE_FILES += $(SDK_DIR)/sam0/utils/cmsis/samd10/source/gcc/startup_samd10.c
SOURCE_FILES += $(SDK_DIR)/sam0/utils/cmsis/samd10/source/system_samd10.c
SOURCE_FILES += $(SDK_DIR)/sam0/utils/stdio/read.c
SOURCE_FILES += $(SDK_DIR)/sam0/utils/stdio/write.c
SOURCE_FILES += $(SDK_DIR)/sam0/utils/syscalls/gcc/syscalls.c

# ----- Libraries --------------------------------------------------------------

LIBS += arm_cortexM0l_math

# ----- Library search paths ---------------------------------------------------

LIB_DIRS += $(SDK_DIR)/thirdparty/CMSIS/Lib/GCC

# ----- Flags ------------------------------------------------------------------

GCCFLAGS += -march=armv6-m
GCCFLAGS += -mtune=cortex-m0plus
GCCFLAGS += -mthumb

LINKER_SCRIPT_FLASH = $(SDK_DIR)/sam0/utils/linker_scripts/samd10/gcc/samd10d14am_flash.ld
LINKER_SCRIPT_SRAM  = $(SDK_DIR)/sam0/utils/linker_scripts/samd10/gcc/samd10d14am_sram.ld

LDFLAGS += -Wl,--script=$(LINKER_SCRIPT_FLASH)
