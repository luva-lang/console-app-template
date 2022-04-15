SRC_DIR		:= src
OBJ_DIR		:= obj
BIN_DIR		:= bin

BIN_NAME	:= your_binary_name

TARGET		:= $(BIN_DIR)/$(BIN_NAME)

SOURCES		:= $(wildcard $(SRC_DIR)/*.lv $(SRC_DIR)/*/*.lv $(SRC_DIR)/*/*/*.lv)
OBJECTS		:= $(subst src/,obj/,$(SOURCES:.lv=.o))

CC			:= gcc
LVFLAGS		:= -c -nostdlib

# ------------------------------------

all: build

build: dirs $(TARGET)

rebuild: clean build

dirs:
	@mkdir -p $(OBJ_DIR)
	@mkdir -p $(BIN_DIR)

$(OBJECTS): obj/%.o : src/%.lv
	@mkdir -p $(@D)
	lvc $(LVFLAGS) $< -o $@

$(TARGET): $(OBJECTS)
	ld $^ -o $@

clean:
	rm -rf $(OBJECTS) $(TARGET)