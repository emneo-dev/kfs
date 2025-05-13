volatile unsigned char * uart = (unsigned char *)0x10000000; 

static void putchar(char c) {
	*uart = c;
}
 
static void print(const char * str) {
	while(*str != '\0') {
		putchar(*str);
		str++;
	}
}

void kmain(void) {
	print("Hello world!\r\n");
	while(1) {
		// Read input from the UART
		putchar(*uart);
	}
}
