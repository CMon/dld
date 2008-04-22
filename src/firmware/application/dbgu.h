#ifndef dbgu_h
#define dbgu_h

#define AT91C_DBGU_BAUD 115200

extern void AT91F_DBGU_Init(void);
extern void AT91F_DBGU_Frame(char *buffer, int len);

#endif /* dbgu_h */
