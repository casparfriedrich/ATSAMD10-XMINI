PROJECT_NAME = getting-started

# ----- Configuration ----------------------------------------------------------

include ../config.mk

# ----- Sources ----------------------------------------------------------------

include sdk.mk

INCLUDE_DIRS += src/config

SOURCE_FILES += $(wildcard src/*.c)

# ----- Libraries --------------------------------------------------------------

# LIBS +=

# LIB_DIRS +=

# ----- Flags ------------------------------------------------------------------

# GCCFLAGS +=

# CPPFLAGS +=

COMMON_COMPILER_FLAGS = -O3 -g -fdata-sections -ffunction-sections -fno-exceptions -nostdlib

CFLAGS += $(COMMON_COMPILER_FLAGS)
CFLAGS += -std=c11

CXXFLAGS += $(COMMON_COMPILER_FLAGS)
CXXFLAGS += -std=c++17
CXXFLAGS += --fno-rtti

LDFLAGS += --specs=nano.specs
LDFLAGS += --specs=nosys.specs
LDFLAGS += -Wl,--gc-sections

# ----- Rules ------------------------------------------------------------------

include ../rules.mk
