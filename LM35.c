#define F_CPU 8000000UL // Define CPU frequency as 8 MHz (required for
delay functions)
#include <avr/io.h> // Include AVR I/O definitions
#include <util/delay.h> // Include delay functions
#include <stdio.h> // Include standard I/O
#include <string.h> // Include string manipulation
// LCD pin and port configurations
#define LCD_Data_Dir DDRC // LCD data direction register
#define LCD_Command_Dir DDRD // LCD command direction register
#define LCD_Data_Port PORTC // LCD data port
#define LCD_Command_Port PORTD // LCD command port
#define RS PD7 // Register Select pin
#define RW PD6 // Read/Write pin
#define EN PD5 // Enable pin
#define degree_sysmbol 0xdf // Degree symbol for display
// Function to send command to LCD
void LCD_Command(unsigned char cmnd){
LCD_Data_Port = cmnd; // Send command to data port
LCD_Command_Port &= ~(1<<RS); // RS = 0 for command mode
LCD_Command_Port &= ~(1<<RW); // RW = 0 for write mode
LCD_Command_Port |= (1<<EN); // Generate enable pulse
_delay_us(1);
LCD_Command_Port &= ~(1<<EN); // EN = 0
_delay_ms(2); // Delay to allow command to
execute
}

// Function to send character data to LCD
void LCD_Char(unsigned char char_data){
LCD_Data_Port = char_data; // Load data to be displayed
LCD_Command_Port |= (1<<RS); // RS = 1 for data mode
LCD_Command_Port &= ~(1<<RW); // RW = 0 for write
LCD_Command_Port |= (1<<EN); // EN = 1 for pulse
_delay_us(1);
LCD_Command_Port &= ~(1<<EN); // EN = 0 to latch data
_delay_ms(2); // Small delay
}
// Function to initialize the LCD
void LCD_Init(void){
LCD_Command_Dir = 0xFF; // Set LCD command port as output
LCD_Data_Dir = 0xFF; // Set LCD data port as output
_delay_ms(20); // Wait for LCD to power up
LCD_Command(0x38); // LCD 2 lines, 5x7 matrix
LCD_Command(0x0C); // Display ON, Cursor OFF
LCD_Command(0x06); // Increment cursor
LCD_Command(0x01); // Clear display
_delay_ms(2);
LCD_Command(0x80); // Move cursor to beginning
}
// Function to initialize ADC
void ADC_Init(){
DDRA = 0x00; // Set PORTA as input (ADC input)
ADCSRA = 0x87; // Enable ADC, set prescaler to
128
ADMUX = 0x40; // Select channel 0, AVCC as
reference
}
// Function to display a string on LCD
void LCD_String(char *str){
int i;
for(i = 0; str[i] != 0; i++){
LCD_Char(str[i]); // Display each character
}
}
// Function to read ADC value from selected channel
int ADC_Read(char channel){
ADMUX = 0x40 | (channel & 0x07); // Select ADC channel (0-7)
ADCSRA |= (1<<ADSC); // Start conversion
while (!(ADCSRA & (1<<ADIF))); // Wait for conversion to complete
ADCSRA |= (1<<ADIF); // Clear conversion flag
_delay_ms(1); // Small delay

8) DC Motor Interfacing with ATmega32 using FAST
PWM Mode (TIMER0)
Algorithm
return ADCW; // Return ADC result
}
// Main function
int main(void){
char Temperature[10]; // Buffer to store temperature
string
float celsius; // Variable to store calculated
temperature
LCD_Init(); // Initialize LCD
ADC_Init(); // Initialize ADC
while(1){
LCD_Command(0x80); // Move cursor to first line
LCD_String("Temperature"); // Display label
LCD_Command(0xC0); // Move cursor to second line
celsius = (ADC_Read(0) * 4.88); // Convert ADC value to

millivolts

celsius = (celsius / 10.00); // LM35 gives 10mV per °C
celsius = ((celsius - 32) / 9) * 5; // Optional: Convert °F to °C

(though not needed for LM35)
// Convert float temperature to string and append degree symbol
sprintf(Temperature, "%d%cC", (int)celsius, degree_sysmbol);
LCD_String(Temperature); // Display temperature
_delay_ms(1000); // Delay for 1 second
}
}
