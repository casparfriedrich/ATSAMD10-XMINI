# ----- Configuration ----------------------------------------------------------

include ../config.mk

PROJECT_NAME = blink

# ----- Sources ----------------------------------------------------------------

include sdk.mk

SOURCE_FILES += src/main.cpp

# ----- Libraries --------------------------------------------------------------

# LIBS +=

# LIB_DIRS +=

# ----- Flags ------------------------------------------------------------------

GCCFLAGS += -march=armv6-m
GCCFLAGS += -mtune=cortex-m0-plus
GCCFLAGS += -mthumb

# CPPFLAGS +=

COMMON_COMPILER_FLAGS = -O3 -g -fdata-sections -ffunction-sections

CFLAGS += $(COMMON_COMPILER_FLAGS)
CFLAGS += -std=c11

CXXFLAGS += $(COMMON_COMPILER_FLAGS)
CXXFLAGS += -std=c++17

LDFLAGS += --specs=nano.specs
LDFLAGS += --specs=nosys.specs
LDFLAGS += -Wl,--gc-sections

# ----- Rules ------------------------------------------------------------------

include ../rules.mk
