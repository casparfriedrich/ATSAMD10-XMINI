# ----- Files ------------------------------------------------------------------

EXECUTABLE = $(OUTPUT_DIR)/$(PROJECT_NAME).elf
MAPFILE    = $(OUTPUT_DIR)/$(PROJECT_NAME).map

# ----- Flags ------------------------------------------------------------------

CPPFLAGS += $(addprefix -D, $(SYMBOLS))
CPPFLAGS += $(addprefix -I, $(realpath $(INCLUDE_DIRS)))

LDFLAGS += $(addprefix -L, $(realpath $(LIB_DIRS)))
LDFLAGS += -Wl,-Map=$(MAPFILE)

LIBFLAGS = $(addprefix -l, $(LIBS))
# LIBFLAGS = -Wl,--start-group $(addprefix -l, $(LIBS)) -Wl,--end-group

# ----- Objects ----------------------------------------------------------------

SORTED_SOURCE_FILES = $(sort $(realpath $(SOURCE_FILES)))
SORTED_OBJECT_FILES = $(addprefix $(OBJECT_DIR),$(addsuffix .o,$(basename $(SORTED_SOURCE_FILES))))

# ----- Rules ------------------------------------------------------------------

.PHONY: all clean download

all: $(EXECUTABLE)
	@echo # New line for better reading
	@$(SIZE) $<
	@echo # Another new line for even better reading

clean:
	@echo [ RMD ] $(OBJECT_DIR) & $(RMDIR) $(OBJECT_DIR)
	@echo [ RMD ] $(OUTPUT_DIR) & $(RMDIR) $(OUTPUT_DIR)

download: $(EXECUTABLE)
	@$(GDB) -q -x download.gdb $<

$(EXECUTABLE): $(SORTED_OBJECT_FILES)
	@$(MKDIR) $(dir $@)
	@echo [ LNK ] $(notdir $@) & $(CC) $(GCCFLAGS) $(LDFLAGS) $^ $(LIBFLAGS) -o $@

$(OBJECT_DIR)/%.o: /%.c
	@$(MKDIR) $(dir $@)
	@echo [ CMP ] $(notdir $@) & $(CC) $(GCCFLAGS) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<

$(OBJECT_DIR)/%.o: /%.cpp
	@$(MKDIR) $(dir $@)
	@echo [ CMP ] $(notdir $@) & $(CC) $(GCCFLAGS) $(CXXFLAGS) $(CPPFLAGS) -c -o $@ $<
