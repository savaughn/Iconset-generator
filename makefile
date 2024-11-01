CC = gcc
CFLAGS = `pkg-config --cflags gtk4`
LIBS = `pkg-config --libs gtk4`
SRC = src/main.c
TARGET = build/image_resizer

all: $(TARGET)

$(TARGET): $(SRC)
	@mkdir -p $(dir $(TARGET))
	@$(CC) -o $(TARGET) $(SRC) $(CFLAGS) $(LIBS)

run: $(TARGET)
	@./$(TARGET)

clean:
	@rm -f $(TARGET)

.PHONY: all clean run