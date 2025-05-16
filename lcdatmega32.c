#define F_CPU 8000000UL // Define CPU frequency as 8MHz
#include <avr/io.h> // Include AVR input/output header
#include <util/delay.h> // Include delay utility
#include <stdio.h>
#include <string.h>
// Define LCD control and data port directions
#define LCD_Data_Dir DDRC // LCD data direction register
#define LCD_Command_Dir DDRD // LCD command direction register
#define LCD_Data_Port PORTC // LCD data port
#define LCD_Command_Port PORTD // LCD command port
// Define LCD control pins
#define RS PD7 // Register Select pin
#define RW PD6 // Read/Write pin
#define EN PD5 // Enable pin
// Function to send command to LCD
void LCD_Command(unsigned char cmnd) {
LCD_Data_Port = cmnd; // Load command to data port
LCD_Command_Port &= ~(1 << RS); // RS = 0 (command mode)
LCD_Command_Port &= ~(1 << RW); // RW = 0 (write mode)
LCD_Command_Port |= (1 << EN); // EN = 1 (enable pulse)
_delay_us(1);
LCD_Command_Port &= ~(1 << EN); // EN = 0
_delay_ms(2); // Delay for LCD to process
}
// Function to send single character to LCD
void LCD_Char(unsigned char char_data) {

7) LM35 Temperature Sensor Interfacing with AVR
ATmega32 Microcontroller.
Algorithm
LCD_Data_Port = char_data; // Load data to data port
LCD_Command_Port |= (1 << RS); // RS = 1 (data mode)
LCD_Command_Port &= ~(1 << RW); // RW = 0 (write mode)
LCD_Command_Port |= (1 << EN); // EN = 1
_delay_us(1);
LCD_Command_Port &= ~(1 << EN); // EN = 0
_delay_ms(2); // Delay for LCD to process
}
// Function to initialize the LCD
void LCD_Init(void) {
LCD_Command_Dir = 0xFF; // Set command port as output
LCD_Data_Dir = 0xFF; // Set data port as output
_delay_ms(20); // Initial delay for LCD power on
LCD_Command(0x38); // 8-bit, 2 line, 5x7 dots
LCD_Command(0x0C); // Display on, cursor off
LCD_Command(0x06); // Auto increment cursor
LCD_Command(0x01); // Clear display
_delay_ms(2);
LCD_Command(0x80); // Cursor to first line, first
position
}
// Function to send string to LCD
void LCD_String(char *str) {
int i;
for (i = 0; str[i] != 0; i++) {
LCD_Char(str[i]);
}
}
// Main program
int main(void) {
LCD_Init(); // Initialize LCD
LCD_Command(0x80); // Cursor at line 1
LCD_String("Abhishek"); // Display name
LCD_Command(0xC0); // Cursor at line 2
LCD_String("C1_16"); // Display batch and roll info
}