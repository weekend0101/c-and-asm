#define F_CPU 16000000UL
#include <avr/io.h>
#include <util/delay.h>

// LCD Connections
#define LCD_DATA PORTC
#define ctrl PORTD
#define en PD2
#define rs PD0

void lcd_cmd(unsigned char cmd) {
    LCD_DATA = cmd;
    ctrl = (0 << rs) | (1 << en);
    _delay_ms(1);
    ctrl = 0;
    _delay_ms(2);
}

void lcd_data(unsigned char data) {
    LCD_DATA = data;
    ctrl = (1 << rs) | (1 << en);
    _delay_ms(1);
    ctrl = 0;
    _delay_ms(2);
}

void lcd_init() {
    DDRC = 0xFF;   // LCD data port
    DDRD = 0xFF;   // LCD control lines
    _delay_ms(20);
    lcd_cmd(0x38); // 8-bit mode, 2 lines
    lcd_cmd(0x0C); // Display ON, Cursor OFF
    lcd_cmd(0x06); // Entry mode
    lcd_cmd(0x01); // Clear display
}

void lcd_print(char *str) {
    while (*str) {
        lcd_data(*str++);
    }
}

void lcd_print_speed(uint8_t speed_percent) {
    lcd_cmd(0x01); // Clear screen
    lcd_cmd(0x80);
    lcd_print("Speed: ");
    
    // Convert number to ASCII
    if (speed_percent == 100) {
        lcd_print("100");
    } else {
        lcd_data((speed_percent / 10) + '0');
        lcd_data('0');
    }

    lcd_data('%');
}

void motor_init_pwm() {
    DDRB |= (1 << PB3);  // OC0 output (PWM)
    DDRB |= (1 << PB4);  // Direction pin (optional)

    // Fast PWM, non-inverting, Prescaler = 64
    TCCR0 = (1 << WGM00) | (1 << WGM01) | (1 << COM01) |
            (1 << CS01) | (1 << CS00);
}

int main(void) {
    lcd_init();
    motor_init_pwm();

    while (1) {
        // Gradual acceleration (0% to 100%)
        for (uint8_t duty = 0; duty <= 100; duty += 10) {
            OCR0 = (duty * 255) / 100; // Convert % to PWM
            lcd_print_speed(duty);
            _delay_ms(500);
        }

        _delay_ms(1000); // Pause at full speed

        // Gradual deceleration (100% to 0%)
        for (int duty = 100; duty >= 0; duty -= 10) {
            OCR0 = (duty * 255) / 100;
            lcd_print_speed(duty);
            _delay_ms(500);
        }

        _delay_ms(1000); // Pause at stop
    }
}

