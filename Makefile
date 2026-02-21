.SUFFIXES:

ifeq ($(strip $(DEVKITPRO)),)
$(error "Please set DEVKITPRO in your environment. export DEVKITPRO=<path to>/devkitPro")
endif
ifeq ($(strip $(DEVKITARM)),)
$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>/devkitARM")
endif

TARGET := 3ds_game_maker
SOURCES := source/main.cpp
OBJECTS := main.o

CC  := $(DEVKITARM)/bin/arm-none-eabi-gcc
CXX := $(DEVKITARM)/bin/arm-none-eabi-g++

ARCH := -march=armv6k -mtune=mpcore -mfloat-abi=hard -mtp=soft
INCLUDES := -I$(DEVKITPRO)/libctru/include -Iinclude

CFLAGS := -g -Wall -O2 -mword-relocations -ffunction-sections $(ARCH) $(INCLUDES)
CXXFLAGS := $(CFLAGS) -fno-rtti -fno-exceptions -std=gnu++17
LDFLAGS := -specs=3dsx.specs -g $(ARCH) -Wl,-Map,$(TARGET).map -L$(DEVKITPRO)/libctru/lib
LIBS := -lctru -lm

APP_TITLE := 3DS Game Maker
APP_DESC := 2D game maker + animation sandbox
APP_AUTHOR := soares10
APP_ICON := $(DEVKITPRO)/libctru/default_icon.png

.PHONY: all clean

all: $(TARGET).3dsx

main.o: $(SOURCES)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(TARGET).elf: $(OBJECTS)
	$(CXX) $(LDFLAGS) $(OBJECTS) $(LIBS) -o $@
	$(DEVKITARM)/bin/arm-none-eabi-nm -CSn $@ > $(TARGET).lst

$(TARGET).smdh: $(APP_ICON)
	smdhtool --create "$(APP_TITLE)" "$(APP_DESC)" "$(APP_AUTHOR)" $(APP_ICON) $@

$(TARGET).3dsx: $(TARGET).elf $(TARGET).smdh
	3dsxtool $(TARGET).elf $(TARGET).3dsx --smdh=$(TARGET).smdh

clean:
	rm -f $(OBJECTS) $(TARGET).elf $(TARGET).3dsx $(TARGET).smdh $(TARGET).map $(TARGET).lst $(TARGET).cia
