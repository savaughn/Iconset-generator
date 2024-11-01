CC = gcc
CFLAGS = `pkg-config --cflags gtk4`
LIBS = `pkg-config --libs gtk4`
SRC = src/main.c
TARGET = build/main
VERSION = 0.1.0

all: $(TARGET)

$(TARGET): $(SRC)
	@mkdir -p $(dir $(TARGET))
	@$(CC) -o $(TARGET) $(SRC) $(CFLAGS) $(LIBS)

run: $(TARGET)
	@./$(TARGET)

bundle: $(TARGET)
	@./bundle_macos_app.sh
	@echo "Bundle created in build/"

dmg:
	@create-dmg --volname "Iconset Generator Installer" --window-pos 200 120 --window-size 800 400 --app-drop-link 600 185 "build/IconsetGenerator-v$(VERSION).dmg" "build/"
	@echo "DMG created in build/"

clean:
	@rm -rf build/*

.PHONY: all clean run