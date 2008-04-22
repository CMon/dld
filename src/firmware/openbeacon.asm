
openbeacon.elf:     file format elf32-littlearm

Disassembly of section startup:

00100000 <startup>:
  100000:	ea00000f 	b	100044 <start>
  100004:	e59ff014 	ldr	pc, [pc, #20]	; 100020 <_undf>
  100008:	e59ff014 	ldr	pc, [pc, #20]	; 100024 <_swi>
  10000c:	e59ff014 	ldr	pc, [pc, #20]	; 100028 <_pabt>
  100010:	e59ff014 	ldr	pc, [pc, #20]	; 10002c <_dabt>
  100014:	e1a00000 	nop			(mov r0,r0)
  100018:	e51fff20 	ldr	pc, [pc, #-3872]	; ff100 <IRQ_STACK_SIZE+0xfed00>
  10001c:	e59ff00c 	ldr	pc, [pc, #12]	; 100030 <_fiq>
  100020:	00100034 	andeqs	r0, r0, r4, lsr r0
  100024:	00103bc8 	andeqs	r3, r0, r8, asr #23
  100028:	00100038 	andeqs	r0, r0, r8, lsr r0
  10002c:	0010003c 	andeqs	r0, r0, ip, lsr r0
  100030:	00100040 	andeqs	r0, r0, r0, asr #32
  100034:	eafffffe 	b	100034 <__undf>
  100038:	eafffffe 	b	100038 <__pabt>
  10003c:	eafffffe 	b	10003c <__dabt>
  100040:	eafffffe 	b	100040 <__fiq>
Disassembly of section prog:

00100044 <start>:
  100044:	e59f00c0 	ldr	r0, [pc, #192]	; 10010c <prog+0xc8>
  100048:	e321f0db 	msr	CPSR_c, #219	; 0xdb
  10004c:	e1a0d000 	mov	sp, r0
  100050:	e2400004 	sub	r0, r0, #4	; 0x4
  100054:	e321f0d7 	msr	CPSR_c, #215	; 0xd7
  100058:	e1a0d000 	mov	sp, r0
  10005c:	e2400004 	sub	r0, r0, #4	; 0x4
  100060:	e321f0d1 	msr	CPSR_c, #209	; 0xd1
  100064:	e1a0d000 	mov	sp, r0
  100068:	e2400004 	sub	r0, r0, #4	; 0x4
  10006c:	e321f0d2 	msr	CPSR_c, #210	; 0xd2
  100070:	e1a0d000 	mov	sp, r0
  100074:	e2400b01 	sub	r0, r0, #1024	; 0x400
  100078:	e321f0d3 	msr	CPSR_c, #211	; 0xd3
  10007c:	e1a0d000 	mov	sp, r0
  100080:	e2400b01 	sub	r0, r0, #1024	; 0x400
  100084:	e321f0df 	msr	CPSR_c, #223	; 0xdf
  100088:	e1a0d000 	mov	sp, r0
  10008c:	e321f0d3 	msr	CPSR_c, #211	; 0xd3
  100090:	eb000735 	bl	101d6c <AT91F_LowLevelInit>
  100094:	e3a01000 	mov	r1, #0	; 0x0
  100098:	e1a0b001 	mov	fp, r1
  10009c:	e1a07001 	mov	r7, r1
  1000a0:	e59f1050 	ldr	r1, [pc, #80]	; 1000f8 <prog+0xb4>
  1000a4:	e59f3050 	ldr	r3, [pc, #80]	; 1000fc <prog+0xb8>
  1000a8:	e0533001 	subs	r3, r3, r1
  1000ac:	0a000003 	beq	1000c0 <.end_clear_loop>
  1000b0:	e3a02000 	mov	r2, #0	; 0x0

001000b4 <.clear_loop>:
  1000b4:	e4c12001 	strb	r2, [r1], #1
  1000b8:	e2533001 	subs	r3, r3, #1	; 0x1
  1000bc:	cafffffc 	bgt	1000b4 <.clear_loop>

001000c0 <.end_clear_loop>:
  1000c0:	e59f1038 	ldr	r1, [pc, #56]	; 100100 <prog+0xbc>
  1000c4:	e59f2038 	ldr	r2, [pc, #56]	; 100104 <prog+0xc0>
  1000c8:	e59f3038 	ldr	r3, [pc, #56]	; 100108 <prog+0xc4>
  1000cc:	e0533001 	subs	r3, r3, r1
  1000d0:	0a000003 	beq	1000e4 <.end_set_loop>

001000d4 <.set_loop>:
  1000d4:	e4d24001 	ldrb	r4, [r2], #1
  1000d8:	e4c14001 	strb	r4, [r1], #1
  1000dc:	e2533001 	subs	r3, r3, #1	; 0x1
  1000e0:	cafffffb 	bgt	1000d4 <.set_loop>

001000e4 <.end_set_loop>:
  1000e4:	e3a00000 	mov	r0, #0	; 0x0
  1000e8:	e3a01000 	mov	r1, #0	; 0x0
  1000ec:	e59fe01c 	ldr	lr, [pc, #28]	; 100110 <prog+0xcc>
  1000f0:	e12fff1e 	bx	lr

001000f4 <endless_loop>:
  1000f4:	eafffffe 	b	1000f4 <endless_loop>
  1000f8:	00200cf0 	streqd	r0, [r0], -r0
  1000fc:	00206740 	eoreq	r6, r0, r0, asr #14
  100100:	00200000 	eoreq	r0, r0, r0
  100104:	0010536c 	andeqs	r5, r0, ip, ror #6
  100108:	00200cf0 	streqd	r0, [r0], -r0
  10010c:	00207ffc 	streqd	r7, [r0], -ip
  100110:	001004e0 	andeqs	r0, r0, r0, ror #9

00100114 <__udivsi3>:
  100114:	e2512001 	subs	r2, r1, #1	; 0x1
  100118:	012fff1e 	bxeq	lr
  10011c:	3a000036 	bcc	1001fc <__udivsi3+0xe8>
  100120:	e1500001 	cmp	r0, r1
  100124:	9a000022 	bls	1001b4 <__udivsi3+0xa0>
  100128:	e1110002 	tst	r1, r2
  10012c:	0a000023 	beq	1001c0 <__udivsi3+0xac>
  100130:	e311020e 	tst	r1, #-536870912	; 0xe0000000
  100134:	01a01181 	moveq	r1, r1, lsl #3
  100138:	03a03008 	moveq	r3, #8	; 0x8
  10013c:	13a03001 	movne	r3, #1	; 0x1
  100140:	e3510201 	cmp	r1, #268435456	; 0x10000000
  100144:	31510000 	cmpcc	r1, r0
  100148:	31a01201 	movcc	r1, r1, lsl #4
  10014c:	31a03203 	movcc	r3, r3, lsl #4
  100150:	3afffffa 	bcc	100140 <__udivsi3+0x2c>
  100154:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
  100158:	31510000 	cmpcc	r1, r0
  10015c:	31a01081 	movcc	r1, r1, lsl #1
  100160:	31a03083 	movcc	r3, r3, lsl #1
  100164:	3afffffa 	bcc	100154 <__udivsi3+0x40>
  100168:	e3a02000 	mov	r2, #0	; 0x0
  10016c:	e1500001 	cmp	r0, r1
  100170:	20400001 	subcs	r0, r0, r1
  100174:	21822003 	orrcs	r2, r2, r3
  100178:	e15000a1 	cmp	r0, r1, lsr #1
  10017c:	204000a1 	subcs	r0, r0, r1, lsr #1
  100180:	218220a3 	orrcs	r2, r2, r3, lsr #1
  100184:	e1500121 	cmp	r0, r1, lsr #2
  100188:	20400121 	subcs	r0, r0, r1, lsr #2
  10018c:	21822123 	orrcs	r2, r2, r3, lsr #2
  100190:	e15001a1 	cmp	r0, r1, lsr #3
  100194:	204001a1 	subcs	r0, r0, r1, lsr #3
  100198:	218221a3 	orrcs	r2, r2, r3, lsr #3
  10019c:	e3500000 	cmp	r0, #0	; 0x0
  1001a0:	11b03223 	movnes	r3, r3, lsr #4
  1001a4:	11a01221 	movne	r1, r1, lsr #4
  1001a8:	1affffef 	bne	10016c <__udivsi3+0x58>
  1001ac:	e1a00002 	mov	r0, r2
  1001b0:	e12fff1e 	bx	lr
  1001b4:	03a00001 	moveq	r0, #1	; 0x1
  1001b8:	13a00000 	movne	r0, #0	; 0x0
  1001bc:	e12fff1e 	bx	lr
  1001c0:	e3510801 	cmp	r1, #65536	; 0x10000
  1001c4:	21a01821 	movcs	r1, r1, lsr #16
  1001c8:	23a02010 	movcs	r2, #16	; 0x10
  1001cc:	33a02000 	movcc	r2, #0	; 0x0
  1001d0:	e3510c01 	cmp	r1, #256	; 0x100
  1001d4:	21a01421 	movcs	r1, r1, lsr #8
  1001d8:	22822008 	addcs	r2, r2, #8	; 0x8
  1001dc:	e3510010 	cmp	r1, #16	; 0x10
  1001e0:	21a01221 	movcs	r1, r1, lsr #4
  1001e4:	22822004 	addcs	r2, r2, #4	; 0x4
  1001e8:	e3510004 	cmp	r1, #4	; 0x4
  1001ec:	82822003 	addhi	r2, r2, #3	; 0x3
  1001f0:	908220a1 	addls	r2, r2, r1, lsr #1
  1001f4:	e1a00230 	mov	r0, r0, lsr r2
  1001f8:	e12fff1e 	bx	lr
  1001fc:	e52de004 	str	lr, [sp, #-4]!
  100200:	eb000007 	bl	100224 <__aeabi_idiv0>
  100204:	e3a00000 	mov	r0, #0	; 0x0
  100208:	e49df004 	ldr	pc, [sp], #4

0010020c <__aeabi_uidivmod>:
  10020c:	e92d4003 	stmdb	sp!, {r0, r1, lr}
  100210:	ebffffbf 	bl	100114 <__udivsi3>
  100214:	e8bd4006 	ldmia	sp!, {r1, r2, lr}
  100218:	e0030092 	mul	r3, r2, r0
  10021c:	e0411003 	sub	r1, r1, r3
  100220:	e12fff1e 	bx	lr

00100224 <__aeabi_idiv0>:
  100224:	e12fff1e 	bx	lr

00100228 <memcpy>:
  100228:	e352000f 	cmp	r2, #15	; 0xf
  10022c:	e92d4010 	stmdb	sp!, {r4, lr}
  100230:	e1a0c000 	mov	ip, r0
  100234:	e1a04000 	mov	r4, r0
  100238:	e1a0e002 	mov	lr, r2
  10023c:	e1a00002 	mov	r0, r2
  100240:	9a000002 	bls	100250 <memcpy+0x28>
  100244:	e1813004 	orr	r3, r1, r4
  100248:	e3130003 	tst	r3, #3	; 0x3
  10024c:	0a000009 	beq	100278 <memcpy+0x50>
  100250:	e3500000 	cmp	r0, #0	; 0x0
  100254:	0a000005 	beq	100270 <memcpy+0x48>
  100258:	e3a02000 	mov	r2, #0	; 0x0
  10025c:	e4d13001 	ldrb	r3, [r1], #1
  100260:	e7c2300c 	strb	r3, [r2, ip]
  100264:	e2822001 	add	r2, r2, #1	; 0x1
  100268:	e1500002 	cmp	r0, r2
  10026c:	1afffffa 	bne	10025c <memcpy+0x34>
  100270:	e1a00004 	mov	r0, r4
  100274:	e8bd8010 	ldmia	sp!, {r4, pc}
  100278:	e5913000 	ldr	r3, [r1]
  10027c:	e58c3000 	str	r3, [ip]
  100280:	e5912004 	ldr	r2, [r1, #4]
  100284:	e58c2004 	str	r2, [ip, #4]
  100288:	e5913008 	ldr	r3, [r1, #8]
  10028c:	e58c3008 	str	r3, [ip, #8]
  100290:	e24ee010 	sub	lr, lr, #16	; 0x10
  100294:	e591300c 	ldr	r3, [r1, #12]
  100298:	e35e000f 	cmp	lr, #15	; 0xf
  10029c:	e58c300c 	str	r3, [ip, #12]
  1002a0:	e2811010 	add	r1, r1, #16	; 0x10
  1002a4:	e28cc010 	add	ip, ip, #16	; 0x10
  1002a8:	8afffff2 	bhi	100278 <memcpy+0x50>
  1002ac:	e35e0003 	cmp	lr, #3	; 0x3
  1002b0:	e1a0000e 	mov	r0, lr
  1002b4:	9affffe5 	bls	100250 <memcpy+0x28>
  1002b8:	e24ee004 	sub	lr, lr, #4	; 0x4
  1002bc:	e4913004 	ldr	r3, [r1], #4
  1002c0:	e35e0003 	cmp	lr, #3	; 0x3
  1002c4:	e48c3004 	str	r3, [ip], #4
  1002c8:	8afffffa 	bhi	1002b8 <memcpy+0x90>
  1002cc:	e1a0000e 	mov	r0, lr
  1002d0:	eaffffde 	b	100250 <memcpy+0x28>

001002d4 <memset>:
  1002d4:	e3520003 	cmp	r2, #3	; 0x3
  1002d8:	e20110ff 	and	r1, r1, #255	; 0xff
  1002dc:	e1a0c000 	mov	ip, r0
  1002e0:	9a000001 	bls	1002ec <memset+0x18>
  1002e4:	e3100003 	tst	r0, #3	; 0x3
  1002e8:	0a000008 	beq	100310 <memset+0x3c>
  1002ec:	e3520000 	cmp	r2, #0	; 0x0
  1002f0:	012fff1e 	bxeq	lr
  1002f4:	e20110ff 	and	r1, r1, #255	; 0xff
  1002f8:	e3a03000 	mov	r3, #0	; 0x0
  1002fc:	e7c3100c 	strb	r1, [r3, ip]
  100300:	e2833001 	add	r3, r3, #1	; 0x1
  100304:	e1530002 	cmp	r3, r2
  100308:	1afffffb 	bne	1002fc <memset+0x28>
  10030c:	e12fff1e 	bx	lr
  100310:	e1813401 	orr	r3, r1, r1, lsl #8
  100314:	e352000f 	cmp	r2, #15	; 0xf
  100318:	e183c803 	orr	ip, r3, r3, lsl #16
  10031c:	e1a03000 	mov	r3, r0
  100320:	8a000007 	bhi	100344 <memset+0x70>
  100324:	e2422004 	sub	r2, r2, #4	; 0x4
  100328:	e3520003 	cmp	r2, #3	; 0x3
  10032c:	e483c004 	str	ip, [r3], #4
  100330:	8afffffb 	bhi	100324 <memset+0x50>
  100334:	e1a0c003 	mov	ip, r3
  100338:	e3520000 	cmp	r2, #0	; 0x0
  10033c:	1affffec 	bne	1002f4 <memset+0x20>
  100340:	e12fff1e 	bx	lr
  100344:	e2422010 	sub	r2, r2, #16	; 0x10
  100348:	e352000f 	cmp	r2, #15	; 0xf
  10034c:	e583c000 	str	ip, [r3]
  100350:	e583c004 	str	ip, [r3, #4]
  100354:	e583c008 	str	ip, [r3, #8]
  100358:	e583c00c 	str	ip, [r3, #12]
  10035c:	e2833010 	add	r3, r3, #16	; 0x10
  100360:	8afffff7 	bhi	100344 <memset+0x70>
  100364:	e3520003 	cmp	r2, #3	; 0x3
  100368:	8affffed 	bhi	100324 <memset+0x50>
  10036c:	e1a0c003 	mov	ip, r3
  100370:	eafffff0 	b	100338 <memset+0x64>

00100374 <strncpy>:
  100374:	e1a0c001 	mov	ip, r1
  100378:	e1811000 	orr	r1, r1, r0
  10037c:	e3110003 	tst	r1, #3	; 0x3
  100380:	13a03000 	movne	r3, #0	; 0x0
  100384:	03a03001 	moveq	r3, #1	; 0x1
  100388:	e3520003 	cmp	r2, #3	; 0x3
  10038c:	93a03000 	movls	r3, #0	; 0x0
  100390:	82033001 	andhi	r3, r3, #1	; 0x1
  100394:	e3530000 	cmp	r3, #0	; 0x0
  100398:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  10039c:	01a0100c 	moveq	r1, ip
  1003a0:	e1a05000 	mov	r5, r0
  1003a4:	e1a0e002 	mov	lr, r2
  1003a8:	01a0c000 	moveq	ip, r0
  1003ac:	0a000024 	beq	100444 <strncpy+0xd0>
  1003b0:	e3520003 	cmp	r2, #3	; 0x3
  1003b4:	e1a04000 	mov	r4, r0
  1003b8:	e1a0000c 	mov	r0, ip
  1003bc:	9a00001e 	bls	10043c <strncpy+0xc8>
  1003c0:	e59c1000 	ldr	r1, [ip]
  1003c4:	e28134ff 	add	r3, r1, #-16777216	; 0xff000000
  1003c8:	e2433801 	sub	r3, r3, #65536	; 0x10000
  1003cc:	e2433c01 	sub	r3, r3, #256	; 0x100
  1003d0:	e2433001 	sub	r3, r3, #1	; 0x1
  1003d4:	e1e02001 	mvn	r2, r1
  1003d8:	e0033002 	and	r3, r3, r2
  1003dc:	e3c3347f 	bic	r3, r3, #2130706432	; 0x7f000000
  1003e0:	e3c3387f 	bic	r3, r3, #8323072	; 0x7f0000
  1003e4:	e3c33c7f 	bic	r3, r3, #32512	; 0x7f00
  1003e8:	e3c3307f 	bic	r3, r3, #127	; 0x7f
  1003ec:	e3530000 	cmp	r3, #0	; 0x0
  1003f0:	1a000011 	bne	10043c <strncpy+0xc8>
  1003f4:	e24ee004 	sub	lr, lr, #4	; 0x4
  1003f8:	e35e0003 	cmp	lr, #3	; 0x3
  1003fc:	e4841004 	str	r1, [r4], #4
  100400:	e2800004 	add	r0, r0, #4	; 0x4
  100404:	9a00000c 	bls	10043c <strncpy+0xc8>
  100408:	e5901000 	ldr	r1, [r0]
  10040c:	e28124ff 	add	r2, r1, #-16777216	; 0xff000000
  100410:	e2422801 	sub	r2, r2, #65536	; 0x10000
  100414:	e2422c01 	sub	r2, r2, #256	; 0x100
  100418:	e2422001 	sub	r2, r2, #1	; 0x1
  10041c:	e1e03001 	mvn	r3, r1
  100420:	e0033002 	and	r3, r3, r2
  100424:	e3c3347f 	bic	r3, r3, #2130706432	; 0x7f000000
  100428:	e3c3387f 	bic	r3, r3, #8323072	; 0x7f0000
  10042c:	e3c33c7f 	bic	r3, r3, #32512	; 0x7f00
  100430:	e3c3307f 	bic	r3, r3, #127	; 0x7f
  100434:	e3530000 	cmp	r3, #0	; 0x0
  100438:	0affffed 	beq	1003f4 <strncpy+0x80>
  10043c:	e1a0c004 	mov	ip, r4
  100440:	e1a01000 	mov	r1, r0
  100444:	e35e0000 	cmp	lr, #0	; 0x0
  100448:	0a000011 	beq	100494 <strncpy+0x120>
  10044c:	e4d13001 	ldrb	r3, [r1], #1
  100450:	e4cc3001 	strb	r3, [ip], #1
  100454:	e3530000 	cmp	r3, #0	; 0x0
  100458:	e24e0001 	sub	r0, lr, #1	; 0x1
  10045c:	e1a04001 	mov	r4, r1
  100460:	01a0e000 	moveq	lr, r0
  100464:	11a0e000 	movne	lr, r0
  100468:	11a0100c 	movne	r1, ip
  10046c:	13a02000 	movne	r2, #0	; 0x0
  100470:	1a000009 	bne	10049c <strncpy+0x128>
  100474:	e35e0000 	cmp	lr, #0	; 0x0
  100478:	0a000005 	beq	100494 <strncpy+0x120>
  10047c:	e3a03000 	mov	r3, #0	; 0x0
  100480:	e1a02003 	mov	r2, r3
  100484:	e7cc2003 	strb	r2, [ip, r3]
  100488:	e2833001 	add	r3, r3, #1	; 0x1
  10048c:	e15e0003 	cmp	lr, r3
  100490:	1afffffb 	bne	100484 <strncpy+0x110>
  100494:	e1a00005 	mov	r0, r5
  100498:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
  10049c:	e1520000 	cmp	r2, r0
  1004a0:	0a000006 	beq	1004c0 <strncpy+0x14c>
  1004a4:	e7d23004 	ldrb	r3, [r2, r4]
  1004a8:	e3530000 	cmp	r3, #0	; 0x0
  1004ac:	e7c2300c 	strb	r3, [r2, ip]
  1004b0:	e24ee001 	sub	lr, lr, #1	; 0x1
  1004b4:	e2811001 	add	r1, r1, #1	; 0x1
  1004b8:	e2822001 	add	r2, r2, #1	; 0x1
  1004bc:	1afffff6 	bne	10049c <strncpy+0x128>
  1004c0:	e1a0c001 	mov	ip, r1
  1004c4:	eaffffea 	b	100474 <strncpy+0x100>

001004c8 <vApplicationIdleHook>:
  1004c8:	e3a024a5 	mov	r2, #-1526726656	; 0xa5000000
  1004cc:	e3a0332a 	mov	r3, #-1476395008	; 0xa8000000
  1004d0:	e2822001 	add	r2, r2, #1	; 0x1
  1004d4:	e1a03ac3 	mov	r3, r3, asr #21
  1004d8:	e5832000 	str	r2, [r3]
  1004dc:	e12fff1e 	bx	lr

001004e0 <main>:
  1004e0:	e92d4010 	stmdb	sp!, {r4, lr}
  1004e4:	e3a02102 	mov	r2, #-2147483648	; 0x80000000
  1004e8:	e1a01ac2 	mov	r1, r2, asr #21
  1004ec:	e3a04000 	mov	r4, #0	; 0x0
  1004f0:	e1a029c2 	mov	r2, r2, asr #19
  1004f4:	e5824130 	str	r4, [r2, #304]
  1004f8:	e3a03004 	mov	r3, #4	; 0x4
  1004fc:	e3a02008 	mov	r2, #8	; 0x8
  100500:	e5813010 	str	r3, [r1, #16]
  100504:	e24dd008 	sub	sp, sp, #8	; 0x8
  100508:	e5812010 	str	r2, [r1, #16]
  10050c:	eb0003be 	bl	10140c <AT91F_DBGU_Init>
  100510:	eb0003b8 	bl	1013f8 <env_init>
  100514:	eb00039a 	bl	101384 <env_load>
  100518:	e1500004 	cmp	r0, r4
  10051c:	e59f205c 	ldr	r2, [pc, #92]	; 100580 <prog+0x53c>
  100520:	1a000005 	bne	10053c <main+0x5c>
  100524:	e3a030ff 	mov	r3, #255	; 0xff
  100528:	e5823014 	str	r3, [r2, #20]
  10052c:	e582400c 	str	r4, [r2, #12]
  100530:	e59f304c 	ldr	r3, [pc, #76]	; 100584 <prog+0x540>
  100534:	e1a0e00f 	mov	lr, pc
  100538:	e12fff13 	bx	r3
  10053c:	eb000013 	bl	100590 <vLedInit>
  100540:	e3a0c002 	mov	ip, #2	; 0x2
  100544:	e59f103c 	ldr	r1, [pc, #60]	; 100588 <prog+0x544>
  100548:	e3a02c02 	mov	r2, #512	; 0x200
  10054c:	e1a03004 	mov	r3, r4
  100550:	e59f0034 	ldr	r0, [pc, #52]	; 10058c <prog+0x548>
  100554:	e58dc000 	str	ip, [sp]
  100558:	e58d4004 	str	r4, [sp, #4]
  10055c:	eb000a11 	bl	102da8 <xTaskCreate>
  100560:	eb000340 	bl	101268 <vCmdInit>
  100564:	eb000157 	bl	100ac8 <vInitProtocolLayer>
  100568:	e1a00004 	mov	r0, r4
  10056c:	eb000018 	bl	1005d4 <vLedSetGreen>
  100570:	eb000aa4 	bl	103008 <vTaskStartScheduler>
  100574:	e1a00004 	mov	r0, r4
  100578:	e28dd008 	add	sp, sp, #8	; 0x8
  10057c:	e8bd8010 	ldmia	sp!, {r4, pc}
  100580:	0020661c 	eoreq	r6, r0, ip, lsl r6
  100584:	00200388 	eoreq	r0, r0, r8, lsl #7
  100588:	00104d24 	andeqs	r4, r0, r4, lsr #26
  10058c:	00104244 	andeqs	r4, r0, r4, asr #4

00100590 <vLedInit>:
  100590:	e3a0220a 	mov	r2, #-1610612736	; 0xa0000000
  100594:	e1a029c2 	mov	r2, r2, asr #19
  100598:	e3a03609 	mov	r3, #9437184	; 0x900000
  10059c:	e5823000 	str	r3, [r2]
  1005a0:	e5823010 	str	r3, [r2, #16]
  1005a4:	e5823030 	str	r3, [r2, #48]
  1005a8:	e12fff1e 	bx	lr

001005ac <vLedSetRed>:
  1005ac:	e31000ff 	tst	r0, #255	; 0xff
  1005b0:	e3a0120a 	mov	r1, #-1610612736	; 0xa0000000
  1005b4:	e3a0220a 	mov	r2, #-1610612736	; 0xa0000000
  1005b8:	e1a019c1 	mov	r1, r1, asr #19
  1005bc:	e1a029c2 	mov	r2, r2, asr #19
  1005c0:	13a03601 	movne	r3, #1048576	; 0x100000
  1005c4:	03a03601 	moveq	r3, #1048576	; 0x100000
  1005c8:	15823034 	strne	r3, [r2, #52]
  1005cc:	05813030 	streq	r3, [r1, #48]
  1005d0:	e12fff1e 	bx	lr

001005d4 <vLedSetGreen>:
  1005d4:	e31000ff 	tst	r0, #255	; 0xff
  1005d8:	e3a0120a 	mov	r1, #-1610612736	; 0xa0000000
  1005dc:	e3a0220a 	mov	r2, #-1610612736	; 0xa0000000
  1005e0:	e1a019c1 	mov	r1, r1, asr #19
  1005e4:	e1a029c2 	mov	r2, r2, asr #19
  1005e8:	13a03502 	movne	r3, #8388608	; 0x800000
  1005ec:	03a03502 	moveq	r3, #8388608	; 0x800000
  1005f0:	15823034 	strne	r3, [r2, #52]
  1005f4:	05813030 	streq	r3, [r1, #48]
  1005f8:	e12fff1e 	bx	lr

001005fc <vLedHaltBlinking>:
  1005fc:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
  100600:	e3a03000 	mov	r3, #0	; 0x0
  100604:	e24dd004 	sub	sp, sp, #4	; 0x4
  100608:	e3a07949 	mov	r7, #1196032	; 0x124000
  10060c:	e2877e7f 	add	r7, r7, #2032	; 0x7f0
  100610:	e3a0620a 	mov	r6, #-1610612736	; 0xa0000000
  100614:	e58d3000 	str	r3, [sp]
  100618:	e1a04000 	mov	r4, r0
  10061c:	e1a069c6 	mov	r6, r6, asr #19
  100620:	e1a05003 	mov	r5, r3
  100624:	e287700f 	add	r7, r7, #15	; 0xf
  100628:	e3a03609 	mov	r3, #9437184	; 0x900000
  10062c:	e5863034 	str	r3, [r6, #52]
  100630:	e58d5000 	str	r5, [sp]
  100634:	e59d3000 	ldr	r3, [sp]
  100638:	e1530007 	cmp	r3, r7
  10063c:	8a000008 	bhi	100664 <vLedHaltBlinking+0x68>
  100640:	e3a01949 	mov	r1, #1196032	; 0x124000
  100644:	e2811e7f 	add	r1, r1, #2032	; 0x7f0
  100648:	e281100f 	add	r1, r1, #15	; 0xf
  10064c:	e59d3000 	ldr	r3, [sp]
  100650:	e2833001 	add	r3, r3, #1	; 0x1
  100654:	e58d3000 	str	r3, [sp]
  100658:	e59d2000 	ldr	r2, [sp]
  10065c:	e1520001 	cmp	r2, r1
  100660:	9afffff9 	bls	10064c <vLedHaltBlinking+0x50>
  100664:	e3540002 	cmp	r4, #2	; 0x2
  100668:	0a000025 	beq	100704 <vLedHaltBlinking+0x108>
  10066c:	e3540003 	cmp	r4, #3	; 0x3
  100670:	0a000028 	beq	100718 <vLedHaltBlinking+0x11c>
  100674:	e3540001 	cmp	r4, #1	; 0x1
  100678:	0a00002b 	beq	10072c <vLedHaltBlinking+0x130>
  10067c:	e3a00000 	mov	r0, #0	; 0x0
  100680:	ebffffd3 	bl	1005d4 <vLedSetGreen>
  100684:	e3a00000 	mov	r0, #0	; 0x0
  100688:	ebffffc7 	bl	1005ac <vLedSetRed>
  10068c:	e58d5000 	str	r5, [sp]
  100690:	e3a02992 	mov	r2, #2392064	; 0x248000
  100694:	e2822eff 	add	r2, r2, #4080	; 0xff0
  100698:	e59d3000 	ldr	r3, [sp]
  10069c:	e282200f 	add	r2, r2, #15	; 0xf
  1006a0:	e1530002 	cmp	r3, r2
  1006a4:	8a000006 	bhi	1006c4 <vLedHaltBlinking+0xc8>
  1006a8:	e1a01002 	mov	r1, r2
  1006ac:	e59d3000 	ldr	r3, [sp]
  1006b0:	e2833001 	add	r3, r3, #1	; 0x1
  1006b4:	e58d3000 	str	r3, [sp]
  1006b8:	e59d2000 	ldr	r2, [sp]
  1006bc:	e1520001 	cmp	r2, r1
  1006c0:	9afffff9 	bls	1006ac <vLedHaltBlinking+0xb0>
  1006c4:	e3a03609 	mov	r3, #9437184	; 0x900000
  1006c8:	e5863030 	str	r3, [r6, #48]
  1006cc:	e58d5000 	str	r5, [sp]
  1006d0:	e59d3000 	ldr	r3, [sp]
  1006d4:	e1530007 	cmp	r3, r7
  1006d8:	8affffd2 	bhi	100628 <vLedHaltBlinking+0x2c>
  1006dc:	e3a01949 	mov	r1, #1196032	; 0x124000
  1006e0:	e2811e7f 	add	r1, r1, #2032	; 0x7f0
  1006e4:	e281100f 	add	r1, r1, #15	; 0xf
  1006e8:	e59d3000 	ldr	r3, [sp]
  1006ec:	e2833001 	add	r3, r3, #1	; 0x1
  1006f0:	e58d3000 	str	r3, [sp]
  1006f4:	e59d2000 	ldr	r2, [sp]
  1006f8:	e1520001 	cmp	r2, r1
  1006fc:	9afffff9 	bls	1006e8 <vLedHaltBlinking+0xec>
  100700:	eaffffc8 	b	100628 <vLedHaltBlinking+0x2c>
  100704:	e3a00000 	mov	r0, #0	; 0x0
  100708:	ebffffb1 	bl	1005d4 <vLedSetGreen>
  10070c:	e3a00001 	mov	r0, #1	; 0x1
  100710:	ebffffa5 	bl	1005ac <vLedSetRed>
  100714:	eaffffdc 	b	10068c <vLedHaltBlinking+0x90>
  100718:	e3a00001 	mov	r0, #1	; 0x1
  10071c:	ebffffac 	bl	1005d4 <vLedSetGreen>
  100720:	e3a00001 	mov	r0, #1	; 0x1
  100724:	ebffffa0 	bl	1005ac <vLedSetRed>
  100728:	eaffffd7 	b	10068c <vLedHaltBlinking+0x90>
  10072c:	e1a00004 	mov	r0, r4
  100730:	ebffffa7 	bl	1005d4 <vLedSetGreen>
  100734:	e3a00000 	mov	r0, #0	; 0x0
  100738:	ebffff9b 	bl	1005ac <vLedSetRed>
  10073c:	eaffffd2 	b	10068c <vLedHaltBlinking+0x90>

00100740 <PtSetFifoLifetimeSeconds>:
  100740:	e0603280 	rsb	r3, r0, r0, lsl #5
  100744:	e2402001 	sub	r2, r0, #1	; 0x1
  100748:	e0803103 	add	r3, r0, r3, lsl #2
  10074c:	e352001d 	cmp	r2, #29	; 0x1d
  100750:	e1a01183 	mov	r1, r3, lsl #3
  100754:	959f3008 	ldrls	r3, [pc, #8]	; 100764 <prog+0x720>
  100758:	83e00000 	mvnhi	r0, #0	; 0x0
  10075c:	95831000 	strls	r1, [r3]
  100760:	e12fff1e 	bx	lr
  100764:	00204fd0 	ldreqd	r4, [r0], -r0

00100768 <PtGetFifoLifetimeSeconds>:
  100768:	e59f3010 	ldr	r3, [pc, #16]	; 100780 <prog+0x73c>
  10076c:	e59f2010 	ldr	r2, [pc, #16]	; 100784 <prog+0x740>
  100770:	e5931000 	ldr	r1, [r3]
  100774:	e0803192 	umull	r3, r0, r2, r1
  100778:	e1a00320 	mov	r0, r0, lsr #6
  10077c:	e12fff1e 	bx	lr
  100780:	00204fd0 	ldreqd	r4, [r0], -r0
  100784:	10624dd3 	ldrned	r4, [r2], #-211

00100788 <vnRFCopyRating>:
  100788:	e3500000 	cmp	r0, #0	; 0x0
  10078c:	13510000 	cmpne	r1, #0	; 0x0
  100790:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
  100794:	c3a06000 	movgt	r6, #0	; 0x0
  100798:	d3a06001 	movle	r6, #1	; 0x1
  10079c:	e1a04001 	mov	r4, r1
  1007a0:	e59f7060 	ldr	r7, [pc, #96]	; 100808 <prog+0x7c4>
  1007a4:	e3a02ffa 	mov	r2, #1000	; 0x3e8
  1007a8:	e1a05000 	mov	r5, r0
  1007ac:	e1a01006 	mov	r1, r6
  1007b0:	ca000002 	bgt	1007c0 <vnRFCopyRating+0x38>
  1007b4:	e3a04000 	mov	r4, #0	; 0x0
  1007b8:	e1a00004 	mov	r0, r4
  1007bc:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
  1007c0:	e5970000 	ldr	r0, [r7]
  1007c4:	eb000689 	bl	1021f0 <xQueueReceive>
  1007c8:	e3500001 	cmp	r0, #1	; 0x1
  1007cc:	e59f1038 	ldr	r1, [pc, #56]	; 10080c <prog+0x7c8>
  1007d0:	e1a00005 	mov	r0, r5
  1007d4:	1afffff6 	bne	1007b4 <vnRFCopyRating+0x2c>
  1007d8:	e59f3030 	ldr	r3, [pc, #48]	; 100810 <prog+0x7cc>
  1007dc:	e5932000 	ldr	r2, [r3]
  1007e0:	e1540002 	cmp	r4, r2
  1007e4:	a1a04002 	movge	r4, r2
  1007e8:	e1a02104 	mov	r2, r4, lsl #2
  1007ec:	ebfffe8d 	bl	100228 <memcpy>
  1007f0:	e1a01006 	mov	r1, r6
  1007f4:	e5970000 	ldr	r0, [r7]
  1007f8:	e1a02006 	mov	r2, r6
  1007fc:	eb0006e0 	bl	102384 <xQueueSend>
  100800:	e1a00004 	mov	r0, r4
  100804:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
  100808:	00205808 	eoreq	r5, r0, r8, lsl #16
  10080c:	00204fe4 	eoreq	r4, r0, r4, ror #31
  100810:	00204fcc 	eoreq	r4, r0, ip, asr #31

00100814 <vnRFtaskRxTx>:
  100814:	e92d4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
  100818:	e3a00051 	mov	r0, #81	; 0x51
  10081c:	e59f11d8 	ldr	r1, [pc, #472]	; 1009fc <prog+0x9b8>
  100820:	e3a02005 	mov	r2, #5	; 0x5
  100824:	e3a03000 	mov	r3, #0	; 0x0
  100828:	eb000409 	bl	101854 <nRFAPI_Init>
  10082c:	e3500000 	cmp	r0, #0	; 0x0
  100830:	08bd8ff0 	ldmeqia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
  100834:	e3a01010 	mov	r1, #16	; 0x10
  100838:	e3a00000 	mov	r0, #0	; 0x0
  10083c:	eb00032e 	bl	1014fc <nRFAPI_SetPipeSizeRX>
  100840:	e3a00003 	mov	r0, #3	; 0x3
  100844:	eb00033d 	bl	101540 <nRFAPI_SetTxPower>
  100848:	e3a00001 	mov	r0, #1	; 0x1
  10084c:	eb00031f 	bl	1014d0 <nRFAPI_SetRxMode>
  100850:	e3a00001 	mov	r0, #1	; 0x1
  100854:	eb0004cf 	bl	101b98 <nRFCMD_CE>
  100858:	eb000882 	bl	102a68 <xTaskGetTickCount>
  10085c:	e59f719c 	ldr	r7, [pc, #412]	; 100a00 <prog+0x9bc>
  100860:	e59f919c 	ldr	r9, [pc, #412]	; 100a04 <prog+0x9c0>
  100864:	e59fa19c 	ldr	sl, [pc, #412]	; 100a08 <prog+0x9c4>
  100868:	e1a08000 	mov	r8, r0
  10086c:	e3a0000a 	mov	r0, #10	; 0xa
  100870:	eb00045f 	bl	1019f4 <nRFCMD_WaitRx>
  100874:	e3500000 	cmp	r0, #0	; 0x0
  100878:	1a00000c 	bne	1008b0 <vnRFtaskRxTx+0x9c>
  10087c:	e3a00070 	mov	r0, #112	; 0x70
  100880:	eb000371 	bl	10164c <nRFAPI_ClearIRQ>
  100884:	eb000877 	bl	102a68 <xTaskGetTickCount>
  100888:	e0683000 	rsb	r3, r8, r0
  10088c:	e35300fa 	cmp	r3, #250	; 0xfa
  100890:	e1a04000 	mov	r4, r0
  100894:	9afffff4 	bls	10086c <vnRFtaskRxTx+0x58>
  100898:	eb03fe05 	bl	2000b4 <vnRFUpdateRating>
  10089c:	e3a0000a 	mov	r0, #10	; 0xa
  1008a0:	eb000453 	bl	1019f4 <nRFCMD_WaitRx>
  1008a4:	e3500000 	cmp	r0, #0	; 0x0
  1008a8:	e1a08004 	mov	r8, r4
  1008ac:	0afffff2 	beq	10087c <vnRFtaskRxTx+0x68>
  1008b0:	e3a00001 	mov	r0, #1	; 0x1
  1008b4:	ebffff3c 	bl	1005ac <vLedSetRed>
  1008b8:	ea000003 	b	1008cc <vnRFtaskRxTx+0xb8>
  1008bc:	eb0003c7 	bl	1017e0 <nRFAPI_GetFifoStatus>
  1008c0:	e2200001 	eor	r0, r0, #1	; 0x1
  1008c4:	e2100001 	ands	r0, r0, #1	; 0x1
  1008c8:	0a000049 	beq	1009f4 <vnRFtaskRxTx+0x1e0>
  1008cc:	e3a02010 	mov	r2, #16	; 0x10
  1008d0:	e59f1128 	ldr	r1, [pc, #296]	; 100a00 <prog+0x9bc>
  1008d4:	e3a00061 	mov	r0, #97	; 0x61
  1008d8:	eb0004db 	bl	101c4c <nRFCMD_RegReadBuf>
  1008dc:	eb03fdc8 	bl	200004 <shuffle_tx_byteorder>
  1008e0:	e1a0e00f 	mov	lr, pc
  1008e4:	e12fff19 	bx	r9
  1008e8:	eb03fdc5 	bl	200004 <shuffle_tx_byteorder>
  1008ec:	e3a0100e 	mov	r1, #14	; 0xe
  1008f0:	e59f0108 	ldr	r0, [pc, #264]	; 100a00 <prog+0x9bc>
  1008f4:	e1a0e00f 	mov	lr, pc
  1008f8:	e12fff1a 	bx	sl
  1008fc:	e5d7300e 	ldrb	r3, [r7, #14]
  100900:	e5d7100f 	ldrb	r1, [r7, #15]
  100904:	e1833401 	orr	r3, r3, r1, lsl #8
  100908:	e1a02403 	mov	r2, r3, lsl #8
  10090c:	e1822423 	orr	r2, r2, r3, lsr #8
  100910:	e1a02802 	mov	r2, r2, lsl #16
  100914:	e1500822 	cmp	r0, r2, lsr #16
  100918:	1affffe7 	bne	1008bc <vnRFtaskRxTx+0xa8>
  10091c:	e5d71009 	ldrb	r1, [r7, #9]
  100920:	e5d73008 	ldrb	r3, [r7, #8]
  100924:	e5d7000a 	ldrb	r0, [r7, #10]
  100928:	e1833401 	orr	r3, r3, r1, lsl #8
  10092c:	e5d7200b 	ldrb	r2, [r7, #11]
  100930:	e1833800 	orr	r3, r3, r0, lsl #16
  100934:	e1833c02 	orr	r3, r3, r2, lsl #24
  100938:	e1a01c03 	mov	r1, r3, lsl #24
  10093c:	e1a02423 	mov	r2, r3, lsr #8
  100940:	e1811c23 	orr	r1, r1, r3, lsr #24
  100944:	e2022cff 	and	r2, r2, #65280	; 0xff00
  100948:	e1a03403 	mov	r3, r3, lsl #8
  10094c:	e1811002 	orr	r1, r1, r2
  100950:	e20338ff 	and	r3, r3, #16711680	; 0xff0000
  100954:	e1816003 	orr	r6, r1, r3
  100958:	e3560801 	cmp	r6, #65536	; 0x10000
  10095c:	e3a0b000 	mov	fp, #0	; 0x0
  100960:	2affffd5 	bcs	1008bc <vnRFtaskRxTx+0xa8>
  100964:	e59f20a0 	ldr	r2, [pc, #160]	; 100a0c <prog+0x9c8>
  100968:	e5924000 	ldr	r4, [r2]
  10096c:	e59f309c 	ldr	r3, [pc, #156]	; 100a10 <prog+0x9cc>
  100970:	e0844104 	add	r4, r4, r4, lsl #2
  100974:	e1a04084 	mov	r4, r4, lsl #1
  100978:	e7c4b003 	strb	fp, [r4, r3]
  10097c:	eb000839 	bl	102a68 <xTaskGetTickCount>
  100980:	e59f2084 	ldr	r2, [pc, #132]	; 100a0c <prog+0x9c8>
  100984:	e5923000 	ldr	r3, [r2]
  100988:	e2833001 	add	r3, r3, #1	; 0x1
  10098c:	e5823000 	str	r3, [r2]
  100990:	e5922000 	ldr	r2, [r2]
  100994:	e35200ff 	cmp	r2, #255	; 0xff
  100998:	e59f2070 	ldr	r2, [pc, #112]	; 100a10 <prog+0x9cc>
  10099c:	e5d7c003 	ldrb	ip, [r7, #3]
  1009a0:	e0843002 	add	r3, r4, r2
  1009a4:	e1a0ec20 	mov	lr, r0, lsr #24
  1009a8:	e1a02420 	mov	r2, r0, lsr #8
  1009ac:	e1a01820 	mov	r1, r0, lsr #16
  1009b0:	e1a05426 	mov	r5, r6, lsr #8
  1009b4:	e5c32007 	strb	r2, [r3, #7]
  1009b8:	e5c31008 	strb	r1, [r3, #8]
  1009bc:	e5c3e009 	strb	lr, [r3, #9]
  1009c0:	e5c35005 	strb	r5, [r3, #5]
  1009c4:	e5c30006 	strb	r0, [r3, #6]
  1009c8:	e5c36004 	strb	r6, [r3, #4]
  1009cc:	e5c3c001 	strb	ip, [r3, #1]
  1009d0:	e59f3038 	ldr	r3, [pc, #56]	; 100a10 <prog+0x9cc>
  1009d4:	e3a02001 	mov	r2, #1	; 0x1
  1009d8:	e7c42003 	strb	r2, [r4, r3]
  1009dc:	859f2028 	ldrhi	r2, [pc, #40]	; 100a0c <prog+0x9c8>
  1009e0:	8582b000 	strhi	fp, [r2]
  1009e4:	eb00037d 	bl	1017e0 <nRFAPI_GetFifoStatus>
  1009e8:	e2200001 	eor	r0, r0, #1	; 0x1
  1009ec:	e2100001 	ands	r0, r0, #1	; 0x1
  1009f0:	1affffb5 	bne	1008cc <vnRFtaskRxTx+0xb8>
  1009f4:	ebfffeec 	bl	1005ac <vLedSetRed>
  1009f8:	eaffff9f 	b	10087c <vnRFtaskRxTx+0x68>
  1009fc:	00104d28 	andeqs	r4, r0, r8, lsr #26
  100a00:	00204fd4 	ldreqd	r4, [r0], -r4
  100a04:	00200598 	mlaeq	r0, r8, r5, r0
  100a08:	00200310 	eoreq	r0, r0, r0, lsl r3
  100a0c:	00205804 	eoreq	r5, r0, r4, lsl #16
  100a10:	0020580c 	eoreq	r5, r0, ip, lsl #16

00100a14 <vnRFtaskRating>:
  100a14:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
  100a18:	e59f7094 	ldr	r7, [pc, #148]	; 100ab4 <prog+0xa70>
  100a1c:	e3a00001 	mov	r0, #1	; 0x1
  100a20:	ebfffeeb 	bl	1005d4 <vLedSetGreen>
  100a24:	e59f008c 	ldr	r0, [pc, #140]	; 100ab8 <prog+0xa74>
  100a28:	eb000084 	bl	100c40 <DumpStringToUSB>
  100a2c:	e59f0080 	ldr	r0, [pc, #128]	; 100ab4 <prog+0xa70>
  100a30:	e3a01008 	mov	r1, #8	; 0x8
  100a34:	ebffff53 	bl	100788 <vnRFCopyRating>
  100a38:	e2506000 	subs	r6, r0, #0	; 0x0
  100a3c:	da000014 	ble	100a94 <vnRFtaskRating+0x80>
  100a40:	e59f506c 	ldr	r5, [pc, #108]	; 100ab4 <prog+0xa70>
  100a44:	e3a04000 	mov	r4, #0	; 0x0
  100a48:	e59f006c 	ldr	r0, [pc, #108]	; 100abc <prog+0xa78>
  100a4c:	eb00007b 	bl	100c40 <DumpStringToUSB>
  100a50:	e5d50002 	ldrb	r0, [r5, #2]
  100a54:	eb00005f 	bl	100bd8 <DumpUIntToUSB>
  100a58:	e59f0060 	ldr	r0, [pc, #96]	; 100ac0 <prog+0xa7c>
  100a5c:	eb000077 	bl	100c40 <DumpStringToUSB>
  100a60:	e0873104 	add	r3, r7, r4, lsl #2
  100a64:	e5d32001 	ldrb	r2, [r3, #1]
  100a68:	e7d70104 	ldrb	r0, [r7, r4, lsl #2]
  100a6c:	e1800402 	orr	r0, r0, r2, lsl #8
  100a70:	eb000058 	bl	100bd8 <DumpUIntToUSB>
  100a74:	e59f0044 	ldr	r0, [pc, #68]	; 100ac0 <prog+0xa7c>
  100a78:	eb000070 	bl	100c40 <DumpStringToUSB>
  100a7c:	e2844001 	add	r4, r4, #1	; 0x1
  100a80:	e5d50003 	ldrb	r0, [r5, #3]
  100a84:	eb000053 	bl	100bd8 <DumpUIntToUSB>
  100a88:	e1560004 	cmp	r6, r4
  100a8c:	e2855004 	add	r5, r5, #4	; 0x4
  100a90:	1affffec 	bne	100a48 <vnRFtaskRating+0x34>
  100a94:	e59f0028 	ldr	r0, [pc, #40]	; 100ac4 <prog+0xa80>
  100a98:	eb000068 	bl	100c40 <DumpStringToUSB>
  100a9c:	e3a00000 	mov	r0, #0	; 0x0
  100aa0:	ebfffecb 	bl	1005d4 <vLedSetGreen>
  100aa4:	e3a00fed 	mov	r0, #948	; 0x3b4
  100aa8:	e2800002 	add	r0, r0, #2	; 0x2
  100aac:	eb000a47 	bl	1033d0 <vTaskDelay>
  100ab0:	eaffffd9 	b	100a1c <vnRFtaskRating+0x8>
  100ab4:	002053e4 	eoreq	r5, r0, r4, ror #7
  100ab8:	00104d30 	andeqs	r4, r0, r0, lsr sp
  100abc:	001051f8 	ldreqsh	r5, [r0], -r8
  100ac0:	00104d34 	andeqs	r4, r0, r4, lsr sp
  100ac4:	001051d0 	ldreqsb	r5, [r0], -r0

00100ac8 <vInitProtocolLayer>:
  100ac8:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
  100acc:	e3a0000a 	mov	r0, #10	; 0xa
  100ad0:	e24dd008 	sub	sp, sp, #8	; 0x8
  100ad4:	ebffff19 	bl	100740 <PtSetFifoLifetimeSeconds>
  100ad8:	e59f3080 	ldr	r3, [pc, #128]	; 100b60 <prog+0xb1c>
  100adc:	e3a05000 	mov	r5, #0	; 0x0
  100ae0:	e3a02010 	mov	r2, #16	; 0x10
  100ae4:	e1a01005 	mov	r1, r5
  100ae8:	e59f4074 	ldr	r4, [pc, #116]	; 100b64 <prog+0xb20>
  100aec:	e5835000 	str	r5, [r3]
  100af0:	e59f0070 	ldr	r0, [pc, #112]	; 100b68 <prog+0xb24>
  100af4:	ebfffdf6 	bl	1002d4 <memset>
  100af8:	e1a01005 	mov	r1, r5
  100afc:	e3a00001 	mov	r0, #1	; 0x1
  100b00:	e5845000 	str	r5, [r4]
  100b04:	eb00050a 	bl	101f34 <xQueueCreate>
  100b08:	e1500005 	cmp	r0, r5
  100b0c:	e3a06003 	mov	r6, #3	; 0x3
  100b10:	e1a01005 	mov	r1, r5
  100b14:	e1a02005 	mov	r2, r5
  100b18:	e5840000 	str	r0, [r4]
  100b1c:	1b000618 	blne	102384 <xQueueSend>
  100b20:	e1a03005 	mov	r3, r5
  100b24:	e59f1040 	ldr	r1, [pc, #64]	; 100b6c <prog+0xb28>
  100b28:	e3a02c02 	mov	r2, #512	; 0x200
  100b2c:	e59f003c 	ldr	r0, [pc, #60]	; 100b70 <prog+0xb2c>
  100b30:	e58d6000 	str	r6, [sp]
  100b34:	e58d5004 	str	r5, [sp, #4]
  100b38:	eb00089a 	bl	102da8 <xTaskCreate>
  100b3c:	e1a03005 	mov	r3, r5
  100b40:	e59f102c 	ldr	r1, [pc, #44]	; 100b74 <prog+0xb30>
  100b44:	e3a02080 	mov	r2, #128	; 0x80
  100b48:	e59f0028 	ldr	r0, [pc, #40]	; 100b78 <prog+0xb34>
  100b4c:	e58d6000 	str	r6, [sp]
  100b50:	e58d5004 	str	r5, [sp, #4]
  100b54:	eb000893 	bl	102da8 <xTaskCreate>
  100b58:	e28dd008 	add	sp, sp, #8	; 0x8
  100b5c:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  100b60:	00205804 	eoreq	r5, r0, r4, lsl #16
  100b64:	00205808 	eoreq	r5, r0, r8, lsl #16
  100b68:	00204fd4 	ldreqd	r4, [r0], -r4
  100b6c:	00104d38 	andeqs	r4, r0, r8, lsr sp
  100b70:	00100814 	andeqs	r0, r0, r4, lsl r8
  100b74:	00104d44 	andeqs	r4, r0, r4, asr #26
  100b78:	00100a14 	andeqs	r0, r0, r4, lsl sl

00100b7c <vSendByte>:
  100b7c:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  100b80:	e59f5048 	ldr	r5, [pc, #72]	; 100bd0 <prog+0xb8c>
  100b84:	e5952000 	ldr	r2, [r5]
  100b88:	e1a03000 	mov	r3, r0
  100b8c:	e59f0040 	ldr	r0, [pc, #64]	; 100bd4 <prog+0xb90>
  100b90:	e3520b01 	cmp	r2, #1024	; 0x400
  100b94:	e20340ff 	and	r4, r3, #255	; 0xff
  100b98:	e2821001 	add	r1, r2, #1	; 0x1
  100b9c:	31a03000 	movcc	r3, r0
  100ba0:	35851000 	strcc	r1, [r5]
  100ba4:	37c34002 	strccb	r4, [r3, r2]
  100ba8:	e354000d 	cmp	r4, #13	; 0xd
  100bac:	0a000002 	beq	100bbc <vSendByte+0x40>
  100bb0:	e1a00004 	mov	r0, r4
  100bb4:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  100bb8:	ea000ce2 	b	103f48 <vUSBSendByte>
  100bbc:	e5951000 	ldr	r1, [r5]
  100bc0:	eb00022a 	bl	101470 <AT91F_DBGU_Frame>
  100bc4:	e3a03000 	mov	r3, #0	; 0x0
  100bc8:	e5853000 	str	r3, [r5]
  100bcc:	eafffff7 	b	100bb0 <vSendByte+0x34>
  100bd0:	00206210 	eoreq	r6, r0, r0, lsl r2
  100bd4:	00206218 	eoreq	r6, r0, r8, lsl r2

00100bd8 <DumpUIntToUSB>:
  100bd8:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
  100bdc:	e59f1058 	ldr	r1, [pc, #88]	; 100c3c <prog+0xbf8>
  100be0:	e24dd00c 	sub	sp, sp, #12	; 0xc
  100be4:	e28d500c 	add	r5, sp, #12	; 0xc
  100be8:	e0823091 	umull	r3, r2, r1, r0
  100bec:	e1a021a2 	mov	r2, r2, lsr #3
  100bf0:	e0823102 	add	r3, r2, r2, lsl #2
  100bf4:	e0403083 	sub	r3, r0, r3, lsl #1
  100bf8:	e2833030 	add	r3, r3, #48	; 0x30
  100bfc:	e3520000 	cmp	r2, #0	; 0x0
  100c00:	e5653001 	strb	r3, [r5, #-1]!
  100c04:	e1a00002 	mov	r0, r2
  100c08:	1afffff6 	bne	100be8 <DumpUIntToUSB+0x10>
  100c0c:	e28d100c 	add	r1, sp, #12	; 0xc
  100c10:	e0513005 	subs	r3, r1, r5
  100c14:	11a04002 	movne	r4, r2
  100c18:	11a06003 	movne	r6, r3
  100c1c:	0a000004 	beq	100c34 <DumpUIntToUSB+0x5c>
  100c20:	e7d40005 	ldrb	r0, [r4, r5]
  100c24:	e2844001 	add	r4, r4, #1	; 0x1
  100c28:	ebffffd3 	bl	100b7c <vSendByte>
  100c2c:	e1540006 	cmp	r4, r6
  100c30:	1afffffa 	bne	100c20 <DumpUIntToUSB+0x48>
  100c34:	e28dd00c 	add	sp, sp, #12	; 0xc
  100c38:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  100c3c:	cccccccd 	stcgtl	12, cr12, [ip], {205}

00100c40 <DumpStringToUSB>:
  100c40:	e2503000 	subs	r3, r0, #0	; 0x0
  100c44:	e92d4010 	stmdb	sp!, {r4, lr}
  100c48:	08bd8010 	ldmeqia	sp!, {r4, pc}
  100c4c:	e4d30001 	ldrb	r0, [r3], #1
  100c50:	e3500000 	cmp	r0, #0	; 0x0
  100c54:	e1a04003 	mov	r4, r3
  100c58:	08bd8010 	ldmeqia	sp!, {r4, pc}
  100c5c:	ebffffc6 	bl	100b7c <vSendByte>
  100c60:	e4d40001 	ldrb	r0, [r4], #1
  100c64:	e3500000 	cmp	r0, #0	; 0x0
  100c68:	08bd8010 	ldmeqia	sp!, {r4, pc}
  100c6c:	ebffffc2 	bl	100b7c <vSendByte>
  100c70:	e4d40001 	ldrb	r0, [r4], #1
  100c74:	e3500000 	cmp	r0, #0	; 0x0
  100c78:	1afffff7 	bne	100c5c <DumpStringToUSB+0x1c>
  100c7c:	e8bd8010 	ldmia	sp!, {r4, pc}

00100c80 <atoiEx>:
  100c80:	e5d03000 	ldrb	r3, [r0]
  100c84:	e3530020 	cmp	r3, #32	; 0x20
  100c88:	13a02000 	movne	r2, #0	; 0x0
  100c8c:	0a00001a 	beq	100cfc <atoiEx+0x7c>
  100c90:	e3530000 	cmp	r3, #0	; 0x0
  100c94:	0a000016 	beq	100cf4 <atoiEx+0x74>
  100c98:	e353002d 	cmp	r3, #45	; 0x2d
  100c9c:	02822001 	addeq	r2, r2, #1	; 0x1
  100ca0:	03e0c000 	mvneq	ip, #0	; 0x0
  100ca4:	0a000002 	beq	100cb4 <atoiEx+0x34>
  100ca8:	e353002b 	cmp	r3, #43	; 0x2b
  100cac:	02822001 	addeq	r2, r2, #1	; 0x1
  100cb0:	e3a0c001 	mov	ip, #1	; 0x1
  100cb4:	e7d01002 	ldrb	r1, [r0, r2]
  100cb8:	e2413030 	sub	r3, r1, #48	; 0x30
  100cbc:	e3530009 	cmp	r3, #9	; 0x9
  100cc0:	8a00000b 	bhi	100cf4 <atoiEx+0x74>
  100cc4:	e0800002 	add	r0, r0, r2
  100cc8:	e3a02000 	mov	r2, #0	; 0x0
  100ccc:	e0822102 	add	r2, r2, r2, lsl #2
  100cd0:	e0812082 	add	r2, r1, r2, lsl #1
  100cd4:	e5d01001 	ldrb	r1, [r0, #1]
  100cd8:	e2413030 	sub	r3, r1, #48	; 0x30
  100cdc:	e3530009 	cmp	r3, #9	; 0x9
  100ce0:	e2422030 	sub	r2, r2, #48	; 0x30
  100ce4:	e2800001 	add	r0, r0, #1	; 0x1
  100ce8:	9afffff7 	bls	100ccc <atoiEx+0x4c>
  100cec:	e000029c 	mul	r0, ip, r2
  100cf0:	e12fff1e 	bx	lr
  100cf4:	e3a00000 	mov	r0, #0	; 0x0
  100cf8:	e12fff1e 	bx	lr
  100cfc:	e3a02000 	mov	r2, #0	; 0x0
  100d00:	e2822001 	add	r2, r2, #1	; 0x1
  100d04:	e7d23000 	ldrb	r3, [r2, r0]
  100d08:	e3530020 	cmp	r3, #32	; 0x20
  100d0c:	0afffffb 	beq	100d00 <atoiEx+0x80>
  100d10:	eaffffde 	b	100c90 <atoiEx+0x10>

00100d14 <prvExecCommand>:
  100d14:	e3500044 	cmp	r0, #68	; 0x44
  100d18:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  100d1c:	0a00001b 	beq	100d90 <prvExecCommand+0x7c>
  100d20:	9a00000f 	bls	100d64 <prvExecCommand+0x50>
  100d24:	e350004d 	cmp	r0, #77	; 0x4d
  100d28:	0a00002e 	beq	100de8 <prvExecCommand+0xd4>
  100d2c:	9a000026 	bls	100dcc <prvExecCommand+0xb8>
  100d30:	e3500055 	cmp	r0, #85	; 0x55
  100d34:	0a000090 	beq	100f7c <prvExecCommand+0x268>
  100d38:	e59f32bc 	ldr	r3, [pc, #700]	; 100ffc <prog+0xfb8>
  100d3c:	e1500003 	cmp	r0, r3
  100d40:	0a00009e 	beq	100fc0 <prvExecCommand+0x2ac>
  100d44:	e3500053 	cmp	r0, #83	; 0x53
  100d48:	18bd8030 	ldmneia	sp!, {r4, r5, pc}
  100d4c:	e59f32ac 	ldr	r3, [pc, #684]	; 101000 <prog+0xfbc>
  100d50:	e1a0e00f 	mov	lr, pc
  100d54:	e12fff13 	bx	r3
  100d58:	e59f02a4 	ldr	r0, [pc, #676]	; 101004 <prog+0xfc0>
  100d5c:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  100d60:	eaffffb6 	b	100c40 <DumpStringToUSB>
  100d64:	e3500034 	cmp	r0, #52	; 0x34
  100d68:	9a000010 	bls	100db0 <prvExecCommand+0x9c>
  100d6c:	e3500041 	cmp	r0, #65	; 0x41
  100d70:	0a00002e 	beq	100e30 <prvExecCommand+0x11c>
  100d74:	e3500043 	cmp	r0, #67	; 0x43
  100d78:	0a000040 	beq	100e80 <prvExecCommand+0x16c>
  100d7c:	e350003f 	cmp	r0, #63	; 0x3f
  100d80:	18bd8030 	ldmneia	sp!, {r4, r5, pc}
  100d84:	e59f027c 	ldr	r0, [pc, #636]	; 101008 <prog+0xfc4>
  100d88:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  100d8c:	eaffffab 	b	100c40 <DumpStringToUSB>
  100d90:	e59f0274 	ldr	r0, [pc, #628]	; 10100c <prog+0xfc8>
  100d94:	ebffffa9 	bl	100c40 <DumpStringToUSB>
  100d98:	e59f3270 	ldr	r3, [pc, #624]	; 101010 <prog+0xfcc>
  100d9c:	e5930014 	ldr	r0, [r3, #20]
  100da0:	ebffff8c 	bl	100bd8 <DumpUIntToUSB>
  100da4:	e59f0268 	ldr	r0, [pc, #616]	; 101014 <prog+0xfd0>
  100da8:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  100dac:	eaffffa3 	b	100c40 <DumpStringToUSB>
  100db0:	e3500031 	cmp	r0, #49	; 0x31
  100db4:	2a000013 	bcs	100e08 <prvExecCommand+0xf4>
  100db8:	e3500030 	cmp	r0, #48	; 0x30
  100dbc:	18bd8030 	ldmneia	sp!, {r4, r5, pc}
  100dc0:	e59f0250 	ldr	r0, [pc, #592]	; 101018 <prog+0xfd4>
  100dc4:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  100dc8:	eaffff9c 	b	100c40 <DumpStringToUSB>
  100dcc:	e3500049 	cmp	r0, #73	; 0x49
  100dd0:	0a00001d 	beq	100e4c <prvExecCommand+0x138>
  100dd4:	e350004c 	cmp	r0, #76	; 0x4c
  100dd8:	0a000071 	beq	100fa4 <prvExecCommand+0x290>
  100ddc:	e3500048 	cmp	r0, #72	; 0x48
  100de0:	18bd8030 	ldmneia	sp!, {r4, r5, pc}
  100de4:	eaffffe6 	b	100d84 <prvExecCommand+0x70>
  100de8:	e59f022c 	ldr	r0, [pc, #556]	; 10101c <prog+0xfd8>
  100dec:	ebffff93 	bl	100c40 <DumpStringToUSB>
  100df0:	e59f3218 	ldr	r3, [pc, #536]	; 101010 <prog+0xfcc>
  100df4:	e593000c 	ldr	r0, [r3, #12]
  100df8:	ebffff76 	bl	100bd8 <DumpUIntToUSB>
  100dfc:	e59f0210 	ldr	r0, [pc, #528]	; 101014 <prog+0xfd0>
  100e00:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  100e04:	eaffff8d 	b	100c40 <DumpStringToUSB>
  100e08:	e59f4200 	ldr	r4, [pc, #512]	; 101010 <prog+0xfcc>
  100e0c:	e2403030 	sub	r3, r0, #48	; 0x30
  100e10:	e584300c 	str	r3, [r4, #12]
  100e14:	e59f0204 	ldr	r0, [pc, #516]	; 101020 <prog+0xfdc>
  100e18:	ebffff88 	bl	100c40 <DumpStringToUSB>
  100e1c:	e594000c 	ldr	r0, [r4, #12]
  100e20:	ebffff6c 	bl	100bd8 <DumpUIntToUSB>
  100e24:	e59f01e8 	ldr	r0, [pc, #488]	; 101014 <prog+0xfd0>
  100e28:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  100e2c:	eaffff83 	b	100c40 <DumpStringToUSB>
  100e30:	e59f01ec 	ldr	r0, [pc, #492]	; 101024 <prog+0xfe0>
  100e34:	ebffff81 	bl	100c40 <DumpStringToUSB>
  100e38:	eb0001fe 	bl	101638 <nRFAPI_GetChannel>
  100e3c:	ebffff65 	bl	100bd8 <DumpUIntToUSB>
  100e40:	e59f01cc 	ldr	r0, [pc, #460]	; 101014 <prog+0xfd0>
  100e44:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  100e48:	eaffff7c 	b	100c40 <DumpStringToUSB>
  100e4c:	e1a00001 	mov	r0, r1
  100e50:	ebffff8a 	bl	100c80 <atoiEx>
  100e54:	e2503000 	subs	r3, r0, #0	; 0x0
  100e58:	08bd8030 	ldmeqia	sp!, {r4, r5, pc}
  100e5c:	e59f41ac 	ldr	r4, [pc, #428]	; 101010 <prog+0xfcc>
  100e60:	e59f01c0 	ldr	r0, [pc, #448]	; 101028 <prog+0xfe4>
  100e64:	e5843014 	str	r3, [r4, #20]
  100e68:	ebffff74 	bl	100c40 <DumpStringToUSB>
  100e6c:	e5940014 	ldr	r0, [r4, #20]
  100e70:	ebffff58 	bl	100bd8 <DumpUIntToUSB>
  100e74:	e59f0198 	ldr	r0, [pc, #408]	; 101014 <prog+0xfd0>
  100e78:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  100e7c:	eaffff6f 	b	100c40 <DumpStringToUSB>
  100e80:	e59f01a4 	ldr	r0, [pc, #420]	; 10102c <prog+0xfe8>
  100e84:	ebffff6d 	bl	100c40 <DumpStringToUSB>
  100e88:	e59f01a0 	ldr	r0, [pc, #416]	; 101030 <prog+0xfec>
  100e8c:	ebffff6b 	bl	100c40 <DumpStringToUSB>
  100e90:	eb0006f4 	bl	102a68 <xTaskGetTickCount>
  100e94:	e59f3198 	ldr	r3, [pc, #408]	; 101034 <prog+0xff0>
  100e98:	e0812093 	umull	r2, r1, r3, r0
  100e9c:	e59f2194 	ldr	r2, [pc, #404]	; 101038 <prog+0xff4>
  100ea0:	e1a01321 	mov	r1, r1, lsr #6
  100ea4:	e0c30192 	smull	r0, r3, r2, r1
  100ea8:	e0833001 	add	r3, r3, r1
  100eac:	e1a055c3 	mov	r5, r3, asr #11
  100eb0:	e0653205 	rsb	r3, r5, r5, lsl #4
  100eb4:	e0633203 	rsb	r3, r3, r3, lsl #4
  100eb8:	e1a00005 	mov	r0, r5
  100ebc:	e0415203 	sub	r5, r1, r3, lsl #4
  100ec0:	ebffff44 	bl	100bd8 <DumpUIntToUSB>
  100ec4:	e59f0170 	ldr	r0, [pc, #368]	; 10103c <prog+0xff8>
  100ec8:	ebffff5c 	bl	100c40 <DumpStringToUSB>
  100ecc:	e59f216c 	ldr	r2, [pc, #364]	; 101040 <prog+0xffc>
  100ed0:	e0c31592 	smull	r1, r3, r2, r5
  100ed4:	e1a04fc5 	mov	r4, r5, asr #31
  100ed8:	e0833005 	add	r3, r3, r5
  100edc:	e06442c3 	rsb	r4, r4, r3, asr #5
  100ee0:	e1a00004 	mov	r0, r4
  100ee4:	ebffff3b 	bl	100bd8 <DumpUIntToUSB>
  100ee8:	e0644204 	rsb	r4, r4, r4, lsl #4
  100eec:	e59f0150 	ldr	r0, [pc, #336]	; 101044 <prog+0x1000>
  100ef0:	ebffff52 	bl	100c40 <DumpStringToUSB>
  100ef4:	e0450104 	sub	r0, r5, r4, lsl #2
  100ef8:	ebffff36 	bl	100bd8 <DumpUIntToUSB>
  100efc:	e59f0144 	ldr	r0, [pc, #324]	; 101048 <prog+0x1004>
  100f00:	ebffff4e 	bl	100c40 <DumpStringToUSB>
  100f04:	e59f4104 	ldr	r4, [pc, #260]	; 101010 <prog+0xfcc>
  100f08:	e59f0104 	ldr	r0, [pc, #260]	; 101014 <prog+0xfd0>
  100f0c:	ebffff4b 	bl	100c40 <DumpStringToUSB>
  100f10:	e59f0134 	ldr	r0, [pc, #308]	; 10104c <prog+0x1008>
  100f14:	ebffff49 	bl	100c40 <DumpStringToUSB>
  100f18:	e5940014 	ldr	r0, [r4, #20]
  100f1c:	ebffff2d 	bl	100bd8 <DumpUIntToUSB>
  100f20:	e59f00ec 	ldr	r0, [pc, #236]	; 101014 <prog+0xfd0>
  100f24:	ebffff45 	bl	100c40 <DumpStringToUSB>
  100f28:	e59f0120 	ldr	r0, [pc, #288]	; 101050 <prog+0x100c>
  100f2c:	ebffff43 	bl	100c40 <DumpStringToUSB>
  100f30:	e594000c 	ldr	r0, [r4, #12]
  100f34:	ebffff27 	bl	100bd8 <DumpUIntToUSB>
  100f38:	e59f00d4 	ldr	r0, [pc, #212]	; 101014 <prog+0xfd0>
  100f3c:	ebffff3f 	bl	100c40 <DumpStringToUSB>
  100f40:	e59f010c 	ldr	r0, [pc, #268]	; 101054 <prog+0x1010>
  100f44:	ebffff3d 	bl	100c40 <DumpStringToUSB>
  100f48:	eb0001ba 	bl	101638 <nRFAPI_GetChannel>
  100f4c:	ebffff21 	bl	100bd8 <DumpUIntToUSB>
  100f50:	e59f00bc 	ldr	r0, [pc, #188]	; 101014 <prog+0xfd0>
  100f54:	ebffff39 	bl	100c40 <DumpStringToUSB>
  100f58:	e59f00f8 	ldr	r0, [pc, #248]	; 101058 <prog+0x1014>
  100f5c:	ebffff37 	bl	100c40 <DumpStringToUSB>
  100f60:	ebfffe00 	bl	100768 <PtGetFifoLifetimeSeconds>
  100f64:	ebffff1b 	bl	100bd8 <DumpUIntToUSB>
  100f68:	e59f00ec 	ldr	r0, [pc, #236]	; 10105c <prog+0x1018>
  100f6c:	ebffff33 	bl	100c40 <DumpStringToUSB>
  100f70:	e59f00e8 	ldr	r0, [pc, #232]	; 101060 <prog+0x101c>
  100f74:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  100f78:	eaffff30 	b	100c40 <DumpStringToUSB>
  100f7c:	e59f00e0 	ldr	r0, [pc, #224]	; 101064 <prog+0x1020>
  100f80:	ebffff2e 	bl	100c40 <DumpStringToUSB>
  100f84:	eb0006b7 	bl	102a68 <xTaskGetTickCount>
  100f88:	e59f30a4 	ldr	r3, [pc, #164]	; 101034 <prog+0xff0>
  100f8c:	e0802093 	umull	r2, r0, r3, r0
  100f90:	e1a00320 	mov	r0, r0, lsr #6
  100f94:	ebffff0f 	bl	100bd8 <DumpUIntToUSB>
  100f98:	e59f0074 	ldr	r0, [pc, #116]	; 101014 <prog+0xfd0>
  100f9c:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  100fa0:	eaffff26 	b	100c40 <DumpStringToUSB>
  100fa4:	e59f00bc 	ldr	r0, [pc, #188]	; 101068 <prog+0x1024>
  100fa8:	ebffff24 	bl	100c40 <DumpStringToUSB>
  100fac:	ebfffded 	bl	100768 <PtGetFifoLifetimeSeconds>
  100fb0:	ebffff08 	bl	100bd8 <DumpUIntToUSB>
  100fb4:	e59f0058 	ldr	r0, [pc, #88]	; 101014 <prog+0xfd0>
  100fb8:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  100fbc:	eaffff1f 	b	100c40 <DumpStringToUSB>
  100fc0:	e1a00001 	mov	r0, r1
  100fc4:	ebffff2d 	bl	100c80 <atoiEx>
  100fc8:	ebfffddc 	bl	100740 <PtSetFifoLifetimeSeconds>
  100fcc:	e2504000 	subs	r4, r0, #0	; 0x0
  100fd0:	ba000006 	blt	100ff0 <prvExecCommand+0x2dc>
  100fd4:	e59f0090 	ldr	r0, [pc, #144]	; 10106c <prog+0x1028>
  100fd8:	ebffff18 	bl	100c40 <DumpStringToUSB>
  100fdc:	e1a00004 	mov	r0, r4
  100fe0:	ebfffefc 	bl	100bd8 <DumpUIntToUSB>
  100fe4:	e59f0028 	ldr	r0, [pc, #40]	; 101014 <prog+0xfd0>
  100fe8:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  100fec:	eaffff13 	b	100c40 <DumpStringToUSB>
  100ff0:	e59f0078 	ldr	r0, [pc, #120]	; 101070 <prog+0x102c>
  100ff4:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  100ff8:	eaffff10 	b	100c40 <DumpStringToUSB>
  100ffc:	4649464f 	strmib	r4, [r9], -pc, asr #12
  101000:	00200388 	eoreq	r0, r0, r8, lsl #7
  101004:	00104d9c 	muleqs	r0, ip, sp
  101008:	00104f84 	andeqs	r4, r0, r4, lsl #31
  10100c:	001051d4 	ldreqsb	r5, [r0], -r4
  101010:	0020661c 	eoreq	r6, r0, ip, lsl r6
  101014:	001051d0 	ldreqsb	r5, [r0], -r0
  101018:	00104d80 	andeqs	r4, r0, r0, lsl #27
  10101c:	001051dc 	ldreqsb	r5, [r0], -ip
  101020:	00104d50 	andeqs	r4, r0, r0, asr sp
  101024:	001051f0 	ldreqsh	r5, [r0], -r0
  101028:	00104e04 	andeqs	r4, r0, r4, lsl #28
  10102c:	00104e18 	andeqs	r4, r0, r8, lsl lr
  101030:	00104ec8 	andeqs	r4, r0, r8, asr #29
  101034:	10624dd3 	ldrned	r4, [r2], #-211
  101038:	91a2b3c5 	movls	fp, r5, asr #7
  10103c:	00104ed8 	ldreqsb	r4, [r0], -r8
  101040:	88888889 	stmhiia	r8, {r0, r3, r7, fp, pc}
  101044:	00104edc 	ldreqsb	r4, [r0], -ip
  101048:	00104ee0 	andeqs	r4, r0, r0, ror #29
  10104c:	00104ee4 	andeqs	r4, r0, r4, ror #29
  101050:	00104efc 	ldreqsh	r4, [r0], -ip
  101054:	00104f0c 	andeqs	r4, r0, ip, lsl #30
  101058:	00104f20 	andeqs	r4, r0, r0, lsr #30
  10105c:	00104f40 	andeqs	r4, r0, r0, asr #30
  101060:	00104f44 	andeqs	r4, r0, r4, asr #30
  101064:	001051e4 	andeqs	r5, r0, r4, ror #3
  101068:	001051fc 	ldreqsh	r5, [r0], -ip
  10106c:	00104dec 	andeqs	r4, r0, ip, ror #27
  101070:	00104dc0 	andeqs	r4, r0, r0, asr #27

00101074 <vCmdCode>:
  101074:	e92d41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
  101078:	e59f70f0 	ldr	r7, [pc, #240]	; 101170 <prog+0x112c>
  10107c:	e24dd024 	sub	sp, sp, #36	; 0x24
  101080:	e1a0600d 	mov	r6, sp
  101084:	e28d8004 	add	r8, sp, #4	; 0x4
  101088:	e5970000 	ldr	r0, [r7]
  10108c:	e1a0100d 	mov	r1, sp
  101090:	e3a02064 	mov	r2, #100	; 0x64
  101094:	eb000455 	bl	1021f0 <xQueueReceive>
  101098:	e3500000 	cmp	r0, #0	; 0x0
  10109c:	0afffff9 	beq	101088 <vCmdCode+0x14>
  1010a0:	e59f00cc 	ldr	r0, [pc, #204]	; 101174 <prog+0x1130>
  1010a4:	ebfffee5 	bl	100c40 <DumpStringToUSB>
  1010a8:	e1a00008 	mov	r0, r8
  1010ac:	ebfffee3 	bl	100c40 <DumpStringToUSB>
  1010b0:	e59f00c0 	ldr	r0, [pc, #192]	; 101178 <prog+0x1134>
  1010b4:	ebfffee1 	bl	100c40 <DumpStringToUSB>
  1010b8:	e5dd3004 	ldrb	r3, [sp, #4]
  1010bc:	e3530020 	cmp	r3, #32	; 0x20
  1010c0:	13a05000 	movne	r5, #0	; 0x0
  1010c4:	0a000022 	beq	101154 <vCmdCode+0xe0>
  1010c8:	e3a04000 	mov	r4, #0	; 0x0
  1010cc:	e1a01004 	mov	r1, r4
  1010d0:	e2850004 	add	r0, r5, #4	; 0x4
  1010d4:	e0863001 	add	r3, r6, r1
  1010d8:	e7d33000 	ldrb	r3, [r3, r0]
  1010dc:	e3530020 	cmp	r3, #32	; 0x20
  1010e0:	13530000 	cmpne	r3, #0	; 0x0
  1010e4:	e243e020 	sub	lr, r3, #32	; 0x20
  1010e8:	e2432061 	sub	r2, r3, #97	; 0x61
  1010ec:	e085c001 	add	ip, r5, r1
  1010f0:	0a000006 	beq	101110 <vCmdCode+0x9c>
  1010f4:	e3520019 	cmp	r2, #25	; 0x19
  1010f8:	e2811001 	add	r1, r1, #1	; 0x1
  1010fc:	918e4404 	orrls	r4, lr, r4, lsl #8
  101100:	81834404 	orrhi	r4, r3, r4, lsl #8
  101104:	e3510004 	cmp	r1, #4	; 0x4
  101108:	1afffff1 	bne	1010d4 <vCmdCode+0x60>
  10110c:	e1a0c000 	mov	ip, r0
  101110:	e28d2024 	add	r2, sp, #36	; 0x24
  101114:	e082300c 	add	r3, r2, ip
  101118:	e5532020 	ldrb	r2, [r3, #-32]
  10111c:	e3520020 	cmp	r2, #32	; 0x20
  101120:	1a000006 	bne	101140 <vCmdCode+0xcc>
  101124:	e0813005 	add	r3, r1, r5
  101128:	e2833004 	add	r3, r3, #4	; 0x4
  10112c:	e0862003 	add	r2, r6, r3
  101130:	e5f23001 	ldrb	r3, [r2, #1]!
  101134:	e3530020 	cmp	r3, #32	; 0x20
  101138:	e2811001 	add	r1, r1, #1	; 0x1
  10113c:	0afffffb 	beq	101130 <vCmdCode+0xbc>
  101140:	e0881001 	add	r1, r8, r1
  101144:	e0811005 	add	r1, r1, r5
  101148:	e1a00004 	mov	r0, r4
  10114c:	ebfffef0 	bl	100d14 <prvExecCommand>
  101150:	eaffffcc 	b	101088 <vCmdCode+0x14>
  101154:	e1a02006 	mov	r2, r6
  101158:	e5d23005 	ldrb	r3, [r2, #5]
  10115c:	e3530020 	cmp	r3, #32	; 0x20
  101160:	e2822001 	add	r2, r2, #1	; 0x1
  101164:	0afffffb 	beq	101158 <vCmdCode+0xe4>
  101168:	e0665002 	rsb	r5, r6, r2
  10116c:	eaffffd5 	b	1010c8 <vCmdCode+0x54>
  101170:	00206214 	eoreq	r6, r0, r4, lsl r2
  101174:	0010520c 	andeqs	r5, r0, ip, lsl #4
  101178:	001051d0 	ldreqsb	r5, [r0], -r0

0010117c <vCmdRecvUsbCode>:
  10117c:	e92d47f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
  101180:	e59fc0d0 	ldr	ip, [pc, #208]	; 101258 <prog+0x1214>
  101184:	e1a0e00c 	mov	lr, ip
  101188:	e24dd024 	sub	sp, sp, #36	; 0x24
  10118c:	e8be000f 	ldmia	lr!, {r0, r1, r2, r3}
  101190:	e1a0c00d 	mov	ip, sp
  101194:	e8ac000f 	stmia	ip!, {r0, r1, r2, r3}
  101198:	e8be000f 	ldmia	lr!, {r0, r1, r2, r3}
  10119c:	e8ac000f 	stmia	ip!, {r0, r1, r2, r3}
  1011a0:	e59e3000 	ldr	r3, [lr]
  1011a4:	e59f90b0 	ldr	r9, [pc, #176]	; 10125c <prog+0x1218>
  1011a8:	e58c3000 	str	r3, [ip]
  1011ac:	e3a07000 	mov	r7, #0	; 0x0
  1011b0:	e28d8004 	add	r8, sp, #4	; 0x4
  1011b4:	e0884007 	add	r4, r8, r7
  1011b8:	e3a02064 	mov	r2, #100	; 0x64
  1011bc:	e3a01001 	mov	r1, #1	; 0x1
  1011c0:	e1a00004 	mov	r0, r4
  1011c4:	eb000b6a 	bl	103f74 <vUSBRecvByte>
  1011c8:	e3a06000 	mov	r6, #0	; 0x0
  1011cc:	e2875001 	add	r5, r7, #1	; 0x1
  1011d0:	e28d2024 	add	r2, sp, #36	; 0x24
  1011d4:	e1500006 	cmp	r0, r6
  1011d8:	e0823005 	add	r3, r2, r5
  1011dc:	e1a00004 	mov	r0, r4
  1011e0:	0afffff3 	beq	1011b4 <vCmdRecvUsbCode+0x38>
  1011e4:	e5436020 	strb	r6, [r3, #-32]
  1011e8:	ebfffe94 	bl	100c40 <DumpStringToUSB>
  1011ec:	e28d3024 	add	r3, sp, #36	; 0x24
  1011f0:	e0830007 	add	r0, r3, r7
  1011f4:	e5503020 	ldrb	r3, [r0, #-32]
  1011f8:	e353000d 	cmp	r3, #13	; 0xd
  1011fc:	1353000a 	cmpne	r3, #10	; 0xa
  101200:	11a07005 	movne	r7, r5
  101204:	1a00000d 	bne	101240 <vCmdRecvUsbCode+0xc4>
  101208:	e1570006 	cmp	r7, r6
  10120c:	e1a0100d 	mov	r1, sp
  101210:	e1a02006 	mov	r2, r6
  101214:	e5406020 	strb	r6, [r0, #-32]
  101218:	da000008 	ble	101240 <vCmdRecvUsbCode+0xc4>
  10121c:	e5990000 	ldr	r0, [r9]
  101220:	eb000457 	bl	102384 <xQueueSend>
  101224:	e3500001 	cmp	r0, #1	; 0x1
  101228:	e1a07006 	mov	r7, r6
  10122c:	e59f002c 	ldr	r0, [pc, #44]	; 101260 <prog+0x121c>
  101230:	01a07006 	moveq	r7, r6
  101234:	0affffde 	beq	1011b4 <vCmdRecvUsbCode+0x38>
  101238:	ebfffe80 	bl	100c40 <DumpStringToUSB>
  10123c:	eaffffdc 	b	1011b4 <vCmdRecvUsbCode+0x38>
  101240:	e357001e 	cmp	r7, #30	; 0x1e
  101244:	e59f0018 	ldr	r0, [pc, #24]	; 101264 <prog+0x1220>
  101248:	daffffd9 	ble	1011b4 <vCmdRecvUsbCode+0x38>
  10124c:	ebfffe7b 	bl	100c40 <DumpStringToUSB>
  101250:	e3a07000 	mov	r7, #0	; 0x0
  101254:	eaffffd6 	b	1011b4 <vCmdRecvUsbCode+0x38>
  101258:	0010527c 	andeqs	r5, r0, ip, ror r2
  10125c:	00206214 	eoreq	r6, r0, r4, lsl r2
  101260:	00105220 	andeqs	r5, r0, r0, lsr #4
  101264:	0010524c 	andeqs	r5, r0, ip, asr #4

00101268 <vCmdInit>:
  101268:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  10126c:	e59f3090 	ldr	r3, [pc, #144]	; 101304 <prog+0x12c0>
  101270:	e3a05000 	mov	r5, #0	; 0x0
  101274:	e3a01024 	mov	r1, #36	; 0x24
  101278:	e5835000 	str	r5, [r3]
  10127c:	e24dd008 	sub	sp, sp, #8	; 0x8
  101280:	e3a0000a 	mov	r0, #10	; 0xa
  101284:	eb00032a 	bl	101f34 <xQueueCreate>
  101288:	e59fc078 	ldr	ip, [pc, #120]	; 101308 <prog+0x12c4>
  10128c:	e1a04000 	mov	r4, r0
  101290:	e1540005 	cmp	r4, r5
  101294:	e1a03005 	mov	r3, r5
  101298:	e59f106c 	ldr	r1, [pc, #108]	; 10130c <prog+0x12c8>
  10129c:	e3a02c02 	mov	r2, #512	; 0x200
  1012a0:	e59f0068 	ldr	r0, [pc, #104]	; 101310 <prog+0x12cc>
  1012a4:	e58c4000 	str	r4, [ip]
  1012a8:	0a00000b 	beq	1012dc <vCmdInit+0x74>
  1012ac:	e59f4060 	ldr	r4, [pc, #96]	; 101314 <prog+0x12d0>
  1012b0:	e3a0c001 	mov	ip, #1	; 0x1
  1012b4:	e58dc000 	str	ip, [sp]
  1012b8:	e58d4004 	str	r4, [sp, #4]
  1012bc:	eb0006b9 	bl	102da8 <xTaskCreate>
  1012c0:	e1a0c000 	mov	ip, r0
  1012c4:	e35c0001 	cmp	ip, #1	; 0x1
  1012c8:	e1a03005 	mov	r3, r5
  1012cc:	e59f1044 	ldr	r1, [pc, #68]	; 101318 <prog+0x12d4>
  1012d0:	e3a02c02 	mov	r2, #512	; 0x200
  1012d4:	e59f0040 	ldr	r0, [pc, #64]	; 10131c <prog+0x12d8>
  1012d8:	0a000002 	beq	1012e8 <vCmdInit+0x80>
  1012dc:	e3a00000 	mov	r0, #0	; 0x0
  1012e0:	e28dd008 	add	sp, sp, #8	; 0x8
  1012e4:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
  1012e8:	e58dc000 	str	ip, [sp]
  1012ec:	e59fc02c 	ldr	ip, [pc, #44]	; 101320 <prog+0x12dc>
  1012f0:	e58dc004 	str	ip, [sp, #4]
  1012f4:	eb0006ab 	bl	102da8 <xTaskCreate>
  1012f8:	e3500001 	cmp	r0, #1	; 0x1
  1012fc:	1afffff6 	bne	1012dc <vCmdInit+0x74>
  101300:	eafffff6 	b	1012e0 <vCmdInit+0x78>
  101304:	00206210 	eoreq	r6, r0, r0, lsl r2
  101308:	00206214 	eoreq	r6, r0, r4, lsl r2
  10130c:	00105270 	andeqs	r5, r0, r0, ror r2
  101310:	00101074 	andeqs	r1, r0, r4, ror r0
  101314:	00206618 	eoreq	r6, r0, r8, lsl r6
  101318:	00105274 	andeqs	r5, r0, r4, ror r2
  10131c:	0010117c 	andeqs	r1, r0, ip, ror r1
  101320:	0020620c 	eoreq	r6, r0, ip, lsl #4

00101324 <DumpBufferToUSB>:
  101324:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
  101328:	e2516000 	subs	r6, r1, #0	; 0x0
  10132c:	d8bd8070 	ldmleia	sp!, {r4, r5, r6, pc}
  101330:	e2804001 	add	r4, r0, #1	; 0x1
  101334:	e3a05000 	mov	r5, #0	; 0x0
  101338:	e5540001 	ldrb	r0, [r4, #-1]
  10133c:	e1a00220 	mov	r0, r0, lsr #4
  101340:	e3500009 	cmp	r0, #9	; 0x9
  101344:	83a03037 	movhi	r3, #55	; 0x37
  101348:	93a03030 	movls	r3, #48	; 0x30
  10134c:	e0830000 	add	r0, r3, r0
  101350:	ebfffe09 	bl	100b7c <vSendByte>
  101354:	e5540001 	ldrb	r0, [r4, #-1]
  101358:	e200000f 	and	r0, r0, #15	; 0xf
  10135c:	e3500009 	cmp	r0, #9	; 0x9
  101360:	83a03037 	movhi	r3, #55	; 0x37
  101364:	93a03030 	movls	r3, #48	; 0x30
  101368:	e0830000 	add	r0, r3, r0
  10136c:	e2855001 	add	r5, r5, #1	; 0x1
  101370:	ebfffe01 	bl	100b7c <vSendByte>
  101374:	e1560005 	cmp	r6, r5
  101378:	e2844001 	add	r4, r4, #1	; 0x1
  10137c:	1affffed 	bne	101338 <DumpBufferToUSB+0x14>
  101380:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}

00101384 <env_load>:
  101384:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  101388:	e59f5064 	ldr	r5, [pc, #100]	; 1013f4 <prog+0x13b0>
  10138c:	e3a0195f 	mov	r1, #1556480	; 0x17c000
  101390:	e3a02c01 	mov	r2, #256	; 0x100
  101394:	e2811a03 	add	r1, r1, #12288	; 0x3000
  101398:	e1a00005 	mov	r0, r5
  10139c:	ebfffba1 	bl	100228 <memcpy>
  1013a0:	e3a03533 	mov	r3, #213909504	; 0xcc00000
  1013a4:	e2833ac2 	add	r3, r3, #794624	; 0xc2000
  1013a8:	e5952000 	ldr	r2, [r5]
  1013ac:	e2833007 	add	r3, r3, #7	; 0x7
  1013b0:	e1520003 	cmp	r2, r3
  1013b4:	0a000001 	beq	1013c0 <env_load+0x3c>
  1013b8:	e3a00000 	mov	r0, #0	; 0x0
  1013bc:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
  1013c0:	e5953004 	ldr	r3, [r5, #4]
  1013c4:	e3530c01 	cmp	r3, #256	; 0x100
  1013c8:	e1a00005 	mov	r0, r5
  1013cc:	e1a01003 	mov	r1, r3
  1013d0:	1afffff8 	bne	1013b8 <env_load+0x34>
  1013d4:	e2433c01 	sub	r3, r3, #256	; 0x100
  1013d8:	e5954008 	ldr	r4, [r5, #8]
  1013dc:	e5853008 	str	r3, [r5, #8]
  1013e0:	eb03fbca 	bl	200310 <env_crc16>
  1013e4:	e1540000 	cmp	r4, r0
  1013e8:	13a00000 	movne	r0, #0	; 0x0
  1013ec:	03a00001 	moveq	r0, #1	; 0x1
  1013f0:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
  1013f4:	0020661c 	eoreq	r6, r0, ip, lsl r6

001013f8 <env_init>:
  1013f8:	e3a03831 	mov	r3, #3211264	; 0x310000
  1013fc:	e2833c03 	add	r3, r3, #768	; 0x300
  101400:	e3e020ff 	mvn	r2, #255	; 0xff
  101404:	e5823060 	str	r3, [r2, #96]
  101408:	e12fff1e 	bx	lr

0010140c <AT91F_DBGU_Init>:
  10140c:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
  101410:	e3a04209 	mov	r4, #-1879048192	; 0x90000000
  101414:	e3a0e20a 	mov	lr, #-1610612736	; 0xa0000000
  101418:	e1a0e9ce 	mov	lr, lr, asr #19
  10141c:	e1a049c4 	mov	r4, r4, asr #19
  101420:	e3a05c06 	mov	r5, #1536	; 0x600
  101424:	e3a06000 	mov	r6, #0	; 0x0
  101428:	e3a0c00c 	mov	ip, #12	; 0xc
  10142c:	e3a017b6 	mov	r1, #47710208	; 0x2d80000
  101430:	e3a03907 	mov	r3, #114688	; 0x1c000
  101434:	e58e5070 	str	r5, [lr, #112]
  101438:	e24dd004 	sub	sp, sp, #4	; 0x4
  10143c:	e58e6074 	str	r6, [lr, #116]
  101440:	e2833c02 	add	r3, r3, #512	; 0x200
  101444:	e58e5004 	str	r5, [lr, #4]
  101448:	e281190d 	add	r1, r1, #212992	; 0x34000
  10144c:	e584c000 	str	ip, [r4]
  101450:	e1a00004 	mov	r0, r4
  101454:	e3a02d23 	mov	r2, #2240	; 0x8c0
  101458:	e58d6000 	str	r6, [sp]
  10145c:	eb000942 	bl	10396c <AT91F_US_Configure>
  101460:	e3a03050 	mov	r3, #80	; 0x50
  101464:	e5843000 	str	r3, [r4]
  101468:	e28dd004 	add	sp, sp, #4	; 0x4
  10146c:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}

00101470 <AT91F_DBGU_Frame>:
  101470:	e52de004 	str	lr, [sp, #-4]!
  101474:	e3a0c000 	mov	ip, #0	; 0x0
  101478:	e2512000 	subs	r2, r1, #0	; 0x0
  10147c:	e1a01000 	mov	r1, r0
  101480:	e3a00326 	mov	r0, #-1744830464	; 0x98000000
  101484:	e24dd004 	sub	sp, sp, #4	; 0x4
  101488:	e1a0300c 	mov	r3, ip
  10148c:	e1a009c0 	mov	r0, r0, asr #19
  101490:	c58dc000 	strgt	ip, [sp]
  101494:	cb0008aa 	blgt	103744 <AT91F_PDC_SendFrame>
  101498:	e28dd004 	add	sp, sp, #4	; 0x4
  10149c:	e8bd8000 	ldmia	sp!, {pc}

001014a0 <nRFAPI_SetSizeMac>:
  1014a0:	e20000ff 	and	r0, r0, #255	; 0xff
  1014a4:	e2403003 	sub	r3, r0, #3	; 0x3
  1014a8:	e3530002 	cmp	r3, #2	; 0x2
  1014ac:	e2400002 	sub	r0, r0, #2	; 0x2
  1014b0:	e92d4010 	stmdb	sp!, {r4, lr}
  1014b4:	e3a04000 	mov	r4, #0	; 0x0
  1014b8:	920040ff 	andls	r4, r0, #255	; 0xff
  1014bc:	e1a01004 	mov	r1, r4
  1014c0:	e3a00023 	mov	r0, #35	; 0x23
  1014c4:	eb000203 	bl	101cd8 <nRFCMD_RegWriteStatusRead>
  1014c8:	e1a00004 	mov	r0, r4
  1014cc:	e8bd8010 	ldmia	sp!, {r4, pc}

001014d0 <nRFAPI_SetRxMode>:
  1014d0:	e31000ff 	tst	r0, #255	; 0xff
  1014d4:	03a0103a 	moveq	r1, #58	; 0x3a
  1014d8:	13a0103b 	movne	r1, #59	; 0x3b
  1014dc:	e3a00020 	mov	r0, #32	; 0x20
  1014e0:	ea0001fc 	b	101cd8 <nRFCMD_RegWriteStatusRead>

001014e4 <nRFAPI_PipesEnable>:
  1014e4:	e200103f 	and	r1, r0, #63	; 0x3f
  1014e8:	e3a00022 	mov	r0, #34	; 0x22
  1014ec:	ea0001f9 	b	101cd8 <nRFCMD_RegWriteStatusRead>

001014f0 <nRFAPI_PipesAck>:
  1014f0:	e200103f 	and	r1, r0, #63	; 0x3f
  1014f4:	e3a00021 	mov	r0, #33	; 0x21
  1014f8:	ea0001f6 	b	101cd8 <nRFCMD_RegWriteStatusRead>

001014fc <nRFAPI_SetPipeSizeRX>:
  1014fc:	e20030ff 	and	r3, r0, #255	; 0xff
  101500:	e2830011 	add	r0, r3, #17	; 0x11
  101504:	e3800020 	orr	r0, r0, #32	; 0x20
  101508:	e3530005 	cmp	r3, #5	; 0x5
  10150c:	e20000ff 	and	r0, r0, #255	; 0xff
  101510:	e20110ff 	and	r1, r1, #255	; 0xff
  101514:	812fff1e 	bxhi	lr
  101518:	ea0001ee 	b	101cd8 <nRFCMD_RegWriteStatusRead>

0010151c <nRFAPI_TxRetries>:
  10151c:	e20000ff 	and	r0, r0, #255	; 0xff
  101520:	e350000f 	cmp	r0, #15	; 0xf
  101524:	e3a0101f 	mov	r1, #31	; 0x1f
  101528:	93801010 	orrls	r1, r0, #16	; 0x10
  10152c:	e3a00024 	mov	r0, #36	; 0x24
  101530:	ea0001e8 	b	101cd8 <nRFCMD_RegWriteStatusRead>

00101534 <nRFAPI_SetChannel>:
  101534:	e200107f 	and	r1, r0, #127	; 0x7f
  101538:	e3a00025 	mov	r0, #37	; 0x25
  10153c:	ea0001e5 	b	101cd8 <nRFCMD_RegWriteStatusRead>

00101540 <nRFAPI_SetTxPower>:
  101540:	e20010ff 	and	r1, r0, #255	; 0xff
  101544:	e3510004 	cmp	r1, #4	; 0x4
  101548:	23a01003 	movcs	r1, #3	; 0x3
  10154c:	e1a01081 	mov	r1, r1, lsl #1
  101550:	e20110fe 	and	r1, r1, #254	; 0xfe
  101554:	e3811009 	orr	r1, r1, #9	; 0x9
  101558:	e3a00026 	mov	r0, #38	; 0x26
  10155c:	ea0001dd 	b	101cd8 <nRFCMD_RegWriteStatusRead>

00101560 <nRFAPI_GetSizeMac>:
  101560:	e52de004 	str	lr, [sp, #-4]!
  101564:	e3a00003 	mov	r0, #3	; 0x3
  101568:	eb0001e6 	bl	101d08 <nRFCMD_RegRead>
  10156c:	e2100003 	ands	r0, r0, #3	; 0x3
  101570:	e1a03000 	mov	r3, r0
  101574:	12803002 	addne	r3, r0, #2	; 0x2
  101578:	e1a00003 	mov	r0, r3
  10157c:	e49df004 	ldr	pc, [sp], #4

00101580 <nRFAPI_GetTxMAC>:
  101580:	e20110ff 	and	r1, r1, #255	; 0xff
  101584:	e1a02001 	mov	r2, r1
  101588:	e2411003 	sub	r1, r1, #3	; 0x3
  10158c:	e3510002 	cmp	r1, #2	; 0x2
  101590:	e1a01000 	mov	r1, r0
  101594:	e3a00010 	mov	r0, #16	; 0x10
  101598:	812fff1e 	bxhi	lr
  10159c:	ea0001aa 	b	101c4c <nRFCMD_RegReadBuf>

001015a0 <nRFAPI_SetRxMAC>:
  1015a0:	e1a03002 	mov	r3, r2
  1015a4:	e92d4010 	stmdb	sp!, {r4, lr}
  1015a8:	e201e0ff 	and	lr, r1, #255	; 0xff
  1015ac:	e20340ff 	and	r4, r3, #255	; 0xff
  1015b0:	e3540001 	cmp	r4, #1	; 0x1
  1015b4:	83a03000 	movhi	r3, #0	; 0x0
  1015b8:	93a03001 	movls	r3, #1	; 0x1
  1015bc:	e284c00a 	add	ip, r4, #10	; 0xa
  1015c0:	e35e0002 	cmp	lr, #2	; 0x2
  1015c4:	e38cc020 	orr	ip, ip, #32	; 0x20
  1015c8:	93a03000 	movls	r3, #0	; 0x0
  1015cc:	e20cc0ff 	and	ip, ip, #255	; 0xff
  1015d0:	e3530000 	cmp	r3, #0	; 0x0
  1015d4:	e1a01000 	mov	r1, r0
  1015d8:	e1a0200e 	mov	r2, lr
  1015dc:	e1a0000c 	mov	r0, ip
  1015e0:	0a000001 	beq	1015ec <nRFAPI_SetRxMAC+0x4c>
  1015e4:	e35e0005 	cmp	lr, #5	; 0x5
  1015e8:	9a000008 	bls	101610 <nRFAPI_SetRxMAC+0x70>
  1015ec:	e35e0001 	cmp	lr, #1	; 0x1
  1015f0:	13a03000 	movne	r3, #0	; 0x0
  1015f4:	03a03001 	moveq	r3, #1	; 0x1
  1015f8:	e3540001 	cmp	r4, #1	; 0x1
  1015fc:	93a03000 	movls	r3, #0	; 0x0
  101600:	e3530000 	cmp	r3, #0	; 0x0
  101604:	08bd8010 	ldmeqia	sp!, {r4, pc}
  101608:	e3540005 	cmp	r4, #5	; 0x5
  10160c:	88bd8010 	ldmhiia	sp!, {r4, pc}
  101610:	e8bd4010 	ldmia	sp!, {r4, lr}
  101614:	ea00019e 	b	101c94 <nRFCMD_RegWriteBuf>

00101618 <nRFAPI_SetTxMAC>:
  101618:	e20110ff 	and	r1, r1, #255	; 0xff
  10161c:	e1a02001 	mov	r2, r1
  101620:	e2411003 	sub	r1, r1, #3	; 0x3
  101624:	e3510002 	cmp	r1, #2	; 0x2
  101628:	e1a01000 	mov	r1, r0
  10162c:	e3a00030 	mov	r0, #48	; 0x30
  101630:	812fff1e 	bxhi	lr
  101634:	ea000196 	b	101c94 <nRFCMD_RegWriteBuf>

00101638 <nRFAPI_GetChannel>:
  101638:	e52de004 	str	lr, [sp, #-4]!
  10163c:	e3a00005 	mov	r0, #5	; 0x5
  101640:	eb0001b0 	bl	101d08 <nRFCMD_RegRead>
  101644:	e200007f 	and	r0, r0, #127	; 0x7f
  101648:	e49df004 	ldr	pc, [sp], #4

0010164c <nRFAPI_ClearIRQ>:
  10164c:	e2001070 	and	r1, r0, #112	; 0x70
  101650:	e52de004 	str	lr, [sp, #-4]!
  101654:	e3a00027 	mov	r0, #39	; 0x27
  101658:	eb00019e 	bl	101cd8 <nRFCMD_RegWriteStatusRead>
  10165c:	e49df004 	ldr	pc, [sp], #4

00101660 <nRFAPI_TX>:
  101660:	e1a02001 	mov	r2, r1
  101664:	e20220ff 	and	r2, r2, #255	; 0xff
  101668:	e1a01000 	mov	r1, r0
  10166c:	e3a000a0 	mov	r0, #160	; 0xa0
  101670:	ea000187 	b	101c94 <nRFCMD_RegWriteBuf>

00101674 <nRFAPI_FlushTX>:
  101674:	e3a000e1 	mov	r0, #225	; 0xe1
  101678:	ea0001b0 	b	101d40 <nRFCMD_CmdExec>

0010167c <nRFAPI_FlushRX>:
  10167c:	e3a000e2 	mov	r0, #226	; 0xe2
  101680:	ea0001ae 	b	101d40 <nRFCMD_CmdExec>

00101684 <nRFAPI_GetStatus>:
  101684:	e52de004 	str	lr, [sp, #-4]!
  101688:	e3a000ff 	mov	r0, #255	; 0xff
  10168c:	eb0001ab 	bl	101d40 <nRFCMD_CmdExec>
  101690:	e49df004 	ldr	pc, [sp], #4

00101694 <nRFAPI_DetectChip>:
  101694:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
  101698:	e24dd008 	sub	sp, sp, #8	; 0x8
  10169c:	ebfffff8 	bl	101684 <nRFAPI_GetStatus>
  1016a0:	e3a00003 	mov	r0, #3	; 0x3
  1016a4:	ebffff7d 	bl	1014a0 <nRFAPI_SetSizeMac>
  1016a8:	ebffffac 	bl	101560 <nRFAPI_GetSizeMac>
  1016ac:	e3500003 	cmp	r0, #3	; 0x3
  1016b0:	0a000002 	beq	1016c0 <nRFAPI_DetectChip+0x2c>
  1016b4:	e3a00000 	mov	r0, #0	; 0x0
  1016b8:	e28dd008 	add	sp, sp, #8	; 0x8
  1016bc:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  1016c0:	e2800002 	add	r0, r0, #2	; 0x2
  1016c4:	ebffff75 	bl	1014a0 <nRFAPI_SetSizeMac>
  1016c8:	ebffffa4 	bl	101560 <nRFAPI_GetSizeMac>
  1016cc:	e3500005 	cmp	r0, #5	; 0x5
  1016d0:	e1a04000 	mov	r4, r0
  1016d4:	1afffff6 	bne	1016b4 <nRFAPI_DetectChip+0x20>
  1016d8:	e59f6054 	ldr	r6, [pc, #84]	; 101734 <prog+0x16f0>
  1016dc:	e1a01000 	mov	r1, r0
  1016e0:	e28d5003 	add	r5, sp, #3	; 0x3
  1016e4:	e1a00006 	mov	r0, r6
  1016e8:	ebffffca 	bl	101618 <nRFAPI_SetTxMAC>
  1016ec:	e1a01004 	mov	r1, r4
  1016f0:	e1a00005 	mov	r0, r5
  1016f4:	e2444005 	sub	r4, r4, #5	; 0x5
  1016f8:	e5cd4003 	strb	r4, [sp, #3]
  1016fc:	e5cd4004 	strb	r4, [sp, #4]
  101700:	e5cd4005 	strb	r4, [sp, #5]
  101704:	e5cd4006 	strb	r4, [sp, #6]
  101708:	e5cd4007 	strb	r4, [sp, #7]
  10170c:	ebffff9b 	bl	101580 <nRFAPI_GetTxMAC>
  101710:	e7d42005 	ldrb	r2, [r4, r5]
  101714:	e7d43006 	ldrb	r3, [r4, r6]
  101718:	e1520003 	cmp	r2, r3
  10171c:	e2844001 	add	r4, r4, #1	; 0x1
  101720:	1affffe3 	bne	1016b4 <nRFAPI_DetectChip+0x20>
  101724:	e3540005 	cmp	r4, #5	; 0x5
  101728:	1afffff8 	bne	101710 <nRFAPI_DetectChip+0x7c>
  10172c:	e3a00001 	mov	r0, #1	; 0x1
  101730:	eaffffe0 	b	1016b8 <nRFAPI_DetectChip+0x24>
  101734:	001052b0 	ldreqh	r5, [r0], -r0

00101738 <nRFAPI_GetPipeSizeRX>:
  101738:	e20000ff 	and	r0, r0, #255	; 0xff
  10173c:	e2803011 	add	r3, r0, #17	; 0x11
  101740:	e3500005 	cmp	r0, #5	; 0x5
  101744:	e52de004 	str	lr, [sp, #-4]!
  101748:	e20300ff 	and	r0, r3, #255	; 0xff
  10174c:	e3a03000 	mov	r3, #0	; 0x0
  101750:	8a000001 	bhi	10175c <nRFAPI_GetPipeSizeRX+0x24>
  101754:	eb00016b 	bl	101d08 <nRFCMD_RegRead>
  101758:	e1a03000 	mov	r3, r0
  10175c:	e1a00003 	mov	r0, r3
  101760:	e49df004 	ldr	pc, [sp], #4

00101764 <nRFAPI_GetPipeCurrent>:
  101764:	e52de004 	str	lr, [sp, #-4]!
  101768:	ebffffc5 	bl	101684 <nRFAPI_GetStatus>
  10176c:	e1a000a0 	mov	r0, r0, lsr #1
  101770:	e2000007 	and	r0, r0, #7	; 0x7
  101774:	e49df004 	ldr	pc, [sp], #4

00101778 <nRFAPI_RX>:
  101778:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
  10177c:	e1a05000 	mov	r5, r0
  101780:	e20160ff 	and	r6, r1, #255	; 0xff
  101784:	ebfffff6 	bl	101764 <nRFAPI_GetPipeCurrent>
  101788:	e3500006 	cmp	r0, #6	; 0x6
  10178c:	e3a04000 	mov	r4, #0	; 0x0
  101790:	9a000001 	bls	10179c <nRFAPI_RX+0x24>
  101794:	e1a00004 	mov	r0, r4
  101798:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  10179c:	ebffffe5 	bl	101738 <nRFAPI_GetPipeSizeRX>
  1017a0:	e1a03000 	mov	r3, r0
  1017a4:	e1530006 	cmp	r3, r6
  1017a8:	e1a04000 	mov	r4, r0
  1017ac:	e1a02000 	mov	r2, r0
  1017b0:	e1a01005 	mov	r1, r5
  1017b4:	e3a00061 	mov	r0, #97	; 0x61
  1017b8:	8a000002 	bhi	1017c8 <nRFAPI_RX+0x50>
  1017bc:	eb000122 	bl	101c4c <nRFCMD_RegReadBuf>
  1017c0:	e1a00004 	mov	r0, r4
  1017c4:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  1017c8:	ebffffab 	bl	10167c <nRFAPI_FlushRX>
  1017cc:	e3a04000 	mov	r4, #0	; 0x0
  1017d0:	e1a00004 	mov	r0, r4
  1017d4:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}

001017d8 <nRFAPI_ReuseTX>:
  1017d8:	e3a000e3 	mov	r0, #227	; 0xe3
  1017dc:	ea000157 	b	101d40 <nRFCMD_CmdExec>

001017e0 <nRFAPI_GetFifoStatus>:
  1017e0:	e52de004 	str	lr, [sp, #-4]!
  1017e4:	e3a00017 	mov	r0, #23	; 0x17
  1017e8:	eb000146 	bl	101d08 <nRFCMD_RegRead>
  1017ec:	e49df004 	ldr	pc, [sp], #4

001017f0 <nRFAPI_CarrierDetect>:
  1017f0:	e52de004 	str	lr, [sp, #-4]!
  1017f4:	e3a00009 	mov	r0, #9	; 0x9
  1017f8:	eb000142 	bl	101d08 <nRFCMD_RegRead>
  1017fc:	e49df004 	ldr	pc, [sp], #4

00101800 <nRFAPI_SetFeatures>:
  101800:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
  101804:	e24dd004 	sub	sp, sp, #4	; 0x4
  101808:	e28d4002 	add	r4, sp, #2	; 0x2
  10180c:	e3a06002 	mov	r6, #2	; 0x2
  101810:	e1a02006 	mov	r2, r6
  101814:	e1a05000 	mov	r5, r0
  101818:	e59f102c 	ldr	r1, [pc, #44]	; 10184c <prog+0x1808>
  10181c:	e1a00004 	mov	r0, r4
  101820:	ebfffa80 	bl	100228 <memcpy>
  101824:	e20550ff 	and	r5, r5, #255	; 0xff
  101828:	e1a01004 	mov	r1, r4
  10182c:	e1a02006 	mov	r2, r6
  101830:	e59f0018 	ldr	r0, [pc, #24]	; 101850 <prog+0x180c>
  101834:	eb0000e1 	bl	101bc0 <nRFCMD_ReadWriteBuffer>
  101838:	e1a01005 	mov	r1, r5
  10183c:	e3a0001d 	mov	r0, #29	; 0x1d
  101840:	eb000124 	bl	101cd8 <nRFCMD_RegWriteStatusRead>
  101844:	e28dd004 	add	sp, sp, #4	; 0x4
  101848:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  10184c:	001052b7 	ldreqh	r5, [r0], -r7
  101850:	001052b5 	ldreqh	r5, [r0], -r5

00101854 <nRFAPI_Init>:
  101854:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
  101858:	e20240ff 	and	r4, r2, #255	; 0xff
  10185c:	e20370ff 	and	r7, r3, #255	; 0xff
  101860:	e1a05001 	mov	r5, r1
  101864:	e20060ff 	and	r6, r0, #255	; 0xff
  101868:	eb00006a 	bl	101a18 <nRFCMD_Init>
  10186c:	e2443003 	sub	r3, r4, #3	; 0x3
  101870:	e3530002 	cmp	r3, #2	; 0x2
  101874:	9a000001 	bls	101880 <nRFAPI_Init+0x2c>
  101878:	e3a00000 	mov	r0, #0	; 0x0
  10187c:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
  101880:	ebffff83 	bl	101694 <nRFAPI_DetectChip>
  101884:	e3500000 	cmp	r0, #0	; 0x0
  101888:	0afffffa 	beq	101878 <nRFAPI_Init+0x24>
  10188c:	e1a00004 	mov	r0, r4
  101890:	ebffff02 	bl	1014a0 <nRFAPI_SetSizeMac>
  101894:	e1a01004 	mov	r1, r4
  101898:	e1a00005 	mov	r0, r5
  10189c:	ebffff5d 	bl	101618 <nRFAPI_SetTxMAC>
  1018a0:	e1a01004 	mov	r1, r4
  1018a4:	e3a02000 	mov	r2, #0	; 0x0
  1018a8:	e1a00005 	mov	r0, r5
  1018ac:	ebffff3b 	bl	1015a0 <nRFAPI_SetRxMAC>
  1018b0:	e3a00001 	mov	r0, #1	; 0x1
  1018b4:	ebffff0a 	bl	1014e4 <nRFAPI_PipesEnable>
  1018b8:	e3a00000 	mov	r0, #0	; 0x0
  1018bc:	ebffff0b 	bl	1014f0 <nRFAPI_PipesAck>
  1018c0:	e3a04000 	mov	r4, #0	; 0x0
  1018c4:	e1a00004 	mov	r0, r4
  1018c8:	e3a01002 	mov	r1, #2	; 0x2
  1018cc:	e2844001 	add	r4, r4, #1	; 0x1
  1018d0:	ebffff09 	bl	1014fc <nRFAPI_SetPipeSizeRX>
  1018d4:	e3540006 	cmp	r4, #6	; 0x6
  1018d8:	1afffff9 	bne	1018c4 <nRFAPI_Init+0x70>
  1018dc:	e3a00000 	mov	r0, #0	; 0x0
  1018e0:	ebffff0d 	bl	10151c <nRFAPI_TxRetries>
  1018e4:	e1a00006 	mov	r0, r6
  1018e8:	ebffff11 	bl	101534 <nRFAPI_SetChannel>
  1018ec:	e3a00003 	mov	r0, #3	; 0x3
  1018f0:	ebffff12 	bl	101540 <nRFAPI_SetTxPower>
  1018f4:	ebffff60 	bl	10167c <nRFAPI_FlushRX>
  1018f8:	ebffff5d 	bl	101674 <nRFAPI_FlushTX>
  1018fc:	e3a00000 	mov	r0, #0	; 0x0
  101900:	ebfffef2 	bl	1014d0 <nRFAPI_SetRxMode>
  101904:	e3570000 	cmp	r7, #0	; 0x0
  101908:	1a000001 	bne	101914 <nRFAPI_Init+0xc0>
  10190c:	e3a00001 	mov	r0, #1	; 0x1
  101910:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
  101914:	e1a00007 	mov	r0, r7
  101918:	ebffffb8 	bl	101800 <nRFAPI_SetFeatures>
  10191c:	e3a00001 	mov	r0, #1	; 0x1
  101920:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}

00101924 <nRFCMD_HaltBlinking>:
  101924:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  101928:	e1a05000 	mov	r5, r0
  10192c:	e3550000 	cmp	r5, #0	; 0x0
  101930:	13a04000 	movne	r4, #0	; 0x0
  101934:	0a00000a 	beq	101964 <nRFCMD_HaltBlinking+0x40>
  101938:	e3a00001 	mov	r0, #1	; 0x1
  10193c:	ebfffb1a 	bl	1005ac <vLedSetRed>
  101940:	e3a000fa 	mov	r0, #250	; 0xfa
  101944:	eb0006a1 	bl	1033d0 <vTaskDelay>
  101948:	e3a00000 	mov	r0, #0	; 0x0
  10194c:	ebfffb16 	bl	1005ac <vLedSetRed>
  101950:	e2844001 	add	r4, r4, #1	; 0x1
  101954:	e3a000fa 	mov	r0, #250	; 0xfa
  101958:	eb00069c 	bl	1033d0 <vTaskDelay>
  10195c:	e1550004 	cmp	r5, r4
  101960:	1afffff4 	bne	101938 <nRFCMD_HaltBlinking+0x14>
  101964:	e3a00e7d 	mov	r0, #2000	; 0x7d0
  101968:	eb000698 	bl	1033d0 <vTaskDelay>
  10196c:	eaffffee 	b	10192c <nRFCMD_HaltBlinking+0x8>

00101970 <nRFCMD_GetRegSize>:
  101970:	e20000ff 	and	r0, r0, #255	; 0xff
  101974:	e3500017 	cmp	r0, #23	; 0x17
  101978:	e3a03000 	mov	r3, #0	; 0x0
  10197c:	8a000004 	bhi	101994 <nRFCMD_GetRegSize+0x24>
  101980:	e1a03c00 	mov	r3, r0, lsl #24
  101984:	e3500010 	cmp	r0, #16	; 0x10
  101988:	e1a02c43 	mov	r2, r3, asr #24
  10198c:	9a000002 	bls	10199c <nRFCMD_GetRegSize+0x2c>
  101990:	e3a03001 	mov	r3, #1	; 0x1
  101994:	e1a00003 	mov	r0, r3
  101998:	e12fff1e 	bx	lr
  10199c:	e3a03001 	mov	r3, #1	; 0x1
  1019a0:	e1a03213 	mov	r3, r3, lsl r2
  1019a4:	e3130b43 	tst	r3, #68608	; 0x10c00
  1019a8:	e3a03005 	mov	r3, #5	; 0x5
  1019ac:	0afffff7 	beq	101990 <nRFCMD_GetRegSize+0x20>
  1019b0:	e1a00003 	mov	r0, r3
  1019b4:	e12fff1e 	bx	lr

001019b8 <nRFCMD_ExecMacro>:
  1019b8:	e59f3028 	ldr	r3, [pc, #40]	; 1019e8 <prog+0x19a4>
  1019bc:	e59f2028 	ldr	r2, [pc, #40]	; 1019ec <prog+0x19a8>
  1019c0:	e52de004 	str	lr, [sp, #-4]!
  1019c4:	e5821000 	str	r1, [r2]
  1019c8:	e5830000 	str	r0, [r3]
  1019cc:	eb03fc28 	bl	200a74 <nRFCMD_ProcessNextMacro>
  1019d0:	e59f3018 	ldr	r3, [pc, #24]	; 1019f0 <prog+0x19ac>
  1019d4:	e5930000 	ldr	r0, [r3]
  1019d8:	e3a01000 	mov	r1, #0	; 0x0
  1019dc:	e3e02000 	mvn	r2, #0	; 0x0
  1019e0:	e49de004 	ldr	lr, [sp], #4
  1019e4:	ea000201 	b	1021f0 <xQueueReceive>
  1019e8:	00206734 	eoreq	r6, r0, r4, lsr r7
  1019ec:	00206738 	eoreq	r6, r0, r8, lsr r7
  1019f0:	00200cf4 	streqd	r0, [r0], -r4

001019f4 <nRFCMD_WaitRx>:
  1019f4:	e52de004 	str	lr, [sp, #-4]!
  1019f8:	e59f3014 	ldr	r3, [pc, #20]	; 101a14 <prog+0x19d0>
  1019fc:	e1a02000 	mov	r2, r0
  101a00:	e3a01000 	mov	r1, #0	; 0x0
  101a04:	e5930000 	ldr	r0, [r3]
  101a08:	eb0001f8 	bl	1021f0 <xQueueReceive>
  101a0c:	e20000ff 	and	r0, r0, #255	; 0xff
  101a10:	e49df004 	ldr	pc, [sp], #4
  101a14:	00200cf0 	streqd	r0, [r0], -r0

00101a18 <nRFCMD_Init>:
  101a18:	e92d47f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
  101a1c:	e59f215c 	ldr	r2, [pc, #348]	; 101b80 <prog+0x1b3c>
  101a20:	e59f315c 	ldr	r3, [pc, #348]	; 101b84 <prog+0x1b40>
  101a24:	e3a04000 	mov	r4, #0	; 0x0
  101a28:	e1a01004 	mov	r1, r4
  101a2c:	e5824000 	str	r4, [r2]
  101a30:	e24dd004 	sub	sp, sp, #4	; 0x4
  101a34:	e3a00001 	mov	r0, #1	; 0x1
  101a38:	e5834000 	str	r4, [r3]
  101a3c:	eb00013c 	bl	101f34 <xQueueCreate>
  101a40:	e59f6140 	ldr	r6, [pc, #320]	; 101b88 <prog+0x1b44>
  101a44:	e3a0520a 	mov	r5, #-1610612736	; 0xa0000000
  101a48:	e3a08102 	mov	r8, #-2147483648	; 0x80000000
  101a4c:	e1500004 	cmp	r0, r4
  101a50:	e1a059c5 	mov	r5, r5, asr #19
  101a54:	e3a0a020 	mov	sl, #32	; 0x20
  101a58:	e3a09702 	mov	r9, #524288	; 0x80000
  101a5c:	e1a08748 	mov	r8, r8, asr #14
  101a60:	e59f7124 	ldr	r7, [pc, #292]	; 101b8c <prog+0x1b48>
  101a64:	e1a02004 	mov	r2, r4
  101a68:	e1a01004 	mov	r1, r4
  101a6c:	e5860000 	str	r0, [r6]
  101a70:	1b000243 	blne	102384 <xQueueSend>
  101a74:	e1a01004 	mov	r1, r4
  101a78:	e3a00001 	mov	r0, #1	; 0x1
  101a7c:	eb00012c 	bl	101f34 <xQueueCreate>
  101a80:	e3500000 	cmp	r0, #0	; 0x0
  101a84:	e1a01004 	mov	r1, r4
  101a88:	e1a02004 	mov	r2, r4
  101a8c:	e5870000 	str	r0, [r7]
  101a90:	1b00023b 	blne	102384 <xQueueSend>
  101a94:	e5963000 	ldr	r3, [r6]
  101a98:	e3530000 	cmp	r3, #0	; 0x0
  101a9c:	e3a00001 	mov	r0, #1	; 0x1
  101aa0:	0a000034 	beq	101b78 <nRFCMD_Init+0x160>
  101aa4:	e5973000 	ldr	r3, [r7]
  101aa8:	e3530000 	cmp	r3, #0	; 0x0
  101aac:	0a000031 	beq	101b78 <nRFCMD_Init+0x160>
  101ab0:	e3a01000 	mov	r1, #0	; 0x0
  101ab4:	e1a02001 	mov	r2, r1
  101ab8:	e5960000 	ldr	r0, [r6]
  101abc:	eb0001cb 	bl	1021f0 <xQueueReceive>
  101ac0:	e3a01000 	mov	r1, #0	; 0x0
  101ac4:	e1a02001 	mov	r2, r1
  101ac8:	e5970000 	ldr	r0, [r7]
  101acc:	eb0001c7 	bl	1021f0 <xQueueReceive>
  101ad0:	e3a03102 	mov	r3, #-2147483648	; 0x80000000
  101ad4:	e1a03ac3 	mov	r3, r3, asr #21
  101ad8:	e583a010 	str	sl, [r3, #16]
  101adc:	e3a02301 	mov	r2, #67108864	; 0x4000000
  101ae0:	e3a01b1e 	mov	r1, #30720	; 0x7800
  101ae4:	e3a03000 	mov	r3, #0	; 0x0
  101ae8:	e5851070 	str	r1, [r5, #112]
  101aec:	e5853074 	str	r3, [r5, #116]
  101af0:	e5851004 	str	r1, [r5, #4]
  101af4:	e5859014 	str	r9, [r5, #20]
  101af8:	e5859000 	str	r9, [r5]
  101afc:	e5852034 	str	r2, [r5, #52]
  101b00:	e5852000 	str	r2, [r5]
  101b04:	e5852010 	str	r2, [r5, #16]
  101b08:	eb000896 	bl	103d68 <vPortEnterCritical>
  101b0c:	e3a03c06 	mov	r3, #1536	; 0x600
  101b10:	e3a02001 	mov	r2, #1	; 0x1
  101b14:	e2833002 	add	r3, r3, #2	; 0x2
  101b18:	e5882004 	str	r2, [r8, #4]
  101b1c:	e3a01004 	mov	r1, #4	; 0x4
  101b20:	e5883030 	str	r3, [r8, #48]
  101b24:	e3a00005 	mov	r0, #5	; 0x5
  101b28:	e5882000 	str	r2, [r8]
  101b2c:	e59f305c 	ldr	r3, [pc, #92]	; 101b90 <prog+0x1b4c>
  101b30:	e1a0200a 	mov	r2, sl
  101b34:	eb00068b 	bl	103568 <AT91F_AIC_ConfigureIt>
  101b38:	e588a014 	str	sl, [r8, #20]
  101b3c:	e3a01003 	mov	r1, #3	; 0x3
  101b40:	e3a02040 	mov	r2, #64	; 0x40
  101b44:	e59f3048 	ldr	r3, [pc, #72]	; 101b94 <prog+0x1b50>
  101b48:	e3a00002 	mov	r0, #2	; 0x2
  101b4c:	eb000685 	bl	103568 <AT91F_AIC_ConfigureIt>
  101b50:	e595304c 	ldr	r3, [r5, #76]
  101b54:	e3a02102 	mov	r2, #-2147483648	; 0x80000000
  101b58:	e58d3000 	str	r3, [sp]
  101b5c:	e1a029c2 	mov	r2, r2, asr #19
  101b60:	e3a03024 	mov	r3, #36	; 0x24
  101b64:	e5859040 	str	r9, [r5, #64]
  101b68:	e5823120 	str	r3, [r2, #288]
  101b6c:	e28dd004 	add	sp, sp, #4	; 0x4
  101b70:	e8bd47f0 	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
  101b74:	ea000886 	b	103d94 <vPortExitCritical>
  101b78:	ebfffa9f 	bl	1005fc <vLedHaltBlinking>
  101b7c:	eaffffcb 	b	101ab0 <nRFCMD_Init+0x98>
  101b80:	00206734 	eoreq	r6, r0, r4, lsr r7
  101b84:	00206738 	eoreq	r6, r0, r8, lsr r7
  101b88:	00200cf4 	streqd	r0, [r0], -r4
  101b8c:	00200cf0 	streqd	r0, [r0], -r0
  101b90:	00200afc 	streqd	r0, [r0], -ip
  101b94:	00200bf4 	streqd	r0, [r0], -r4

00101b98 <nRFCMD_CE>:
  101b98:	e31000ff 	tst	r0, #255	; 0xff
  101b9c:	e3a0120a 	mov	r1, #-1610612736	; 0xa0000000
  101ba0:	e3a0220a 	mov	r2, #-1610612736	; 0xa0000000
  101ba4:	e1a019c1 	mov	r1, r1, asr #19
  101ba8:	e1a029c2 	mov	r2, r2, asr #19
  101bac:	13a03301 	movne	r3, #67108864	; 0x4000000
  101bb0:	03a03301 	moveq	r3, #67108864	; 0x4000000
  101bb4:	15823030 	strne	r3, [r2, #48]
  101bb8:	05813034 	streq	r3, [r1, #52]
  101bbc:	e12fff1e 	bx	lr

00101bc0 <nRFCMD_ReadWriteBuffer>:
  101bc0:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
  101bc4:	e3a044ff 	mov	r4, #-16777216	; 0xff000000
  101bc8:	e28448fe 	add	r4, r4, #16646144	; 0xfe0000
  101bcc:	e3a05000 	mov	r5, #0	; 0x0
  101bd0:	e2844c01 	add	r4, r4, #256	; 0x100
  101bd4:	e24dd004 	sub	sp, sp, #4	; 0x4
  101bd8:	e1a06000 	mov	r6, r0
  101bdc:	e1a07002 	mov	r7, r2
  101be0:	e1a03005 	mov	r3, r5
  101be4:	e1a00004 	mov	r0, r4
  101be8:	e58d5000 	str	r5, [sp]
  101bec:	eb0006e6 	bl	10378c <AT91F_PDC_ReceiveFrame>
  101bf0:	e1a01006 	mov	r1, r6
  101bf4:	e1a02007 	mov	r2, r7
  101bf8:	e1a03005 	mov	r3, r5
  101bfc:	e1a00004 	mov	r0, r4
  101c00:	e58d5000 	str	r5, [sp]
  101c04:	eb0006ce 	bl	103744 <AT91F_PDC_SendFrame>
  101c08:	e3a03c01 	mov	r3, #256	; 0x100
  101c0c:	e2833001 	add	r3, r3, #1	; 0x1
  101c10:	e5843020 	str	r3, [r4, #32]
  101c14:	e59f302c 	ldr	r3, [pc, #44]	; 101c48 <prog+0x1c04>
  101c18:	e1a01005 	mov	r1, r5
  101c1c:	e5930000 	ldr	r0, [r3]
  101c20:	e3a02064 	mov	r2, #100	; 0x64
  101c24:	eb000171 	bl	1021f0 <xQueueReceive>
  101c28:	e3500001 	cmp	r0, #1	; 0x1
  101c2c:	e3a00002 	mov	r0, #2	; 0x2
  101c30:	0a000002 	beq	101c40 <nRFCMD_ReadWriteBuffer+0x80>
  101c34:	e28dd004 	add	sp, sp, #4	; 0x4
  101c38:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
  101c3c:	eaffff38 	b	101924 <nRFCMD_HaltBlinking>
  101c40:	e28dd004 	add	sp, sp, #4	; 0x4
  101c44:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
  101c48:	00200cf4 	streqd	r0, [r0], -r4

00101c4c <nRFCMD_RegReadBuf>:
  101c4c:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
  101c50:	e59f3034 	ldr	r3, [pc, #52]	; 101c8c <prog+0x1c48>
  101c54:	e59f5034 	ldr	r5, [pc, #52]	; 101c90 <prog+0x1c4c>
  101c58:	e20240ff 	and	r4, r2, #255	; 0xff
  101c5c:	e5c30000 	strb	r0, [r3]
  101c60:	e1a06001 	mov	r6, r1
  101c64:	e1a00003 	mov	r0, r3
  101c68:	e1a01005 	mov	r1, r5
  101c6c:	e2842002 	add	r2, r4, #2	; 0x2
  101c70:	ebffffd2 	bl	101bc0 <nRFCMD_ReadWriteBuffer>
  101c74:	e1a00006 	mov	r0, r6
  101c78:	e1a02004 	mov	r2, r4
  101c7c:	e2851001 	add	r1, r5, #1	; 0x1
  101c80:	ebfff968 	bl	100228 <memcpy>
  101c84:	e5d50000 	ldrb	r0, [r5]
  101c88:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  101c8c:	00200d19 	eoreq	r0, r0, r9, lsl sp
  101c90:	00200cf8 	streqd	r0, [r0], -r8

00101c94 <nRFCMD_RegWriteBuf>:
  101c94:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
  101c98:	e59f6030 	ldr	r6, [pc, #48]	; 101cd0 <prog+0x1c8c>
  101c9c:	e1a03006 	mov	r3, r6
  101ca0:	e4c30001 	strb	r0, [r3], #1
  101ca4:	e20240ff 	and	r4, r2, #255	; 0xff
  101ca8:	e59f5024 	ldr	r5, [pc, #36]	; 101cd4 <prog+0x1c90>
  101cac:	e1a00003 	mov	r0, r3
  101cb0:	e1a02004 	mov	r2, r4
  101cb4:	ebfff95b 	bl	100228 <memcpy>
  101cb8:	e1a00006 	mov	r0, r6
  101cbc:	e2842001 	add	r2, r4, #1	; 0x1
  101cc0:	e1a01005 	mov	r1, r5
  101cc4:	ebffffbd 	bl	101bc0 <nRFCMD_ReadWriteBuffer>
  101cc8:	e5d50000 	ldrb	r0, [r5]
  101ccc:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  101cd0:	00200d19 	eoreq	r0, r0, r9, lsl sp
  101cd4:	00200cf8 	streqd	r0, [r0], -r8

00101cd8 <nRFCMD_RegWriteStatusRead>:
  101cd8:	e92d4010 	stmdb	sp!, {r4, lr}
  101cdc:	e59f401c 	ldr	r4, [pc, #28]	; 101d00 <prog+0x1cbc>
  101ce0:	e3a02002 	mov	r2, #2	; 0x2
  101ce4:	e5c40000 	strb	r0, [r4]
  101ce8:	e5c41001 	strb	r1, [r4, #1]
  101cec:	e1a00004 	mov	r0, r4
  101cf0:	e59f100c 	ldr	r1, [pc, #12]	; 101d04 <prog+0x1cc0>
  101cf4:	ebffffb1 	bl	101bc0 <nRFCMD_ReadWriteBuffer>
  101cf8:	e5d40000 	ldrb	r0, [r4]
  101cfc:	e8bd8010 	ldmia	sp!, {r4, pc}
  101d00:	00200d19 	eoreq	r0, r0, r9, lsl sp
  101d04:	00200cf8 	streqd	r0, [r0], -r8

00101d08 <nRFCMD_RegRead>:
  101d08:	e92d4010 	stmdb	sp!, {r4, lr}
  101d0c:	e59f3024 	ldr	r3, [pc, #36]	; 101d38 <prog+0x1cf4>
  101d10:	e59f4024 	ldr	r4, [pc, #36]	; 101d3c <prog+0x1cf8>
  101d14:	e3a0c000 	mov	ip, #0	; 0x0
  101d18:	e5c30000 	strb	r0, [r3]
  101d1c:	e1a01004 	mov	r1, r4
  101d20:	e1a00003 	mov	r0, r3
  101d24:	e3a02002 	mov	r2, #2	; 0x2
  101d28:	e5c3c001 	strb	ip, [r3, #1]
  101d2c:	ebffffa3 	bl	101bc0 <nRFCMD_ReadWriteBuffer>
  101d30:	e5d40001 	ldrb	r0, [r4, #1]
  101d34:	e8bd8010 	ldmia	sp!, {r4, pc}
  101d38:	00200d19 	eoreq	r0, r0, r9, lsl sp
  101d3c:	00200cf8 	streqd	r0, [r0], -r8

00101d40 <nRFCMD_CmdExec>:
  101d40:	e52de004 	str	lr, [sp, #-4]!
  101d44:	e24dd004 	sub	sp, sp, #4	; 0x4
  101d48:	e28d3004 	add	r3, sp, #4	; 0x4
  101d4c:	e5630001 	strb	r0, [r3, #-1]!
  101d50:	e28d1002 	add	r1, sp, #2	; 0x2
  101d54:	e1a00003 	mov	r0, r3
  101d58:	e3a02001 	mov	r2, #1	; 0x1
  101d5c:	ebffff97 	bl	101bc0 <nRFCMD_ReadWriteBuffer>
  101d60:	e5dd0002 	ldrb	r0, [sp, #2]
  101d64:	e28dd004 	add	sp, sp, #4	; 0x4
  101d68:	e8bd8000 	ldmia	sp!, {pc}

00101d6c <AT91F_LowLevelInit>:
  101d6c:	e52de004 	str	lr, [sp, #-4]!
  101d70:	e3a0c84b 	mov	ip, #4915200	; 0x4b0000
  101d74:	e3a0e32a 	mov	lr, #-1476395008	; 0xa8000000
  101d78:	e3a00502 	mov	r0, #8388608	; 0x800000
  101d7c:	e3a02102 	mov	r2, #-2147483648	; 0x80000000
  101d80:	e3a01c06 	mov	r1, #1536	; 0x600
  101d84:	e1a02ac2 	mov	r2, r2, asr #21
  101d88:	e28ccc01 	add	ip, ip, #256	; 0x100
  101d8c:	e1a0eace 	mov	lr, lr, asr #21
  101d90:	e2800d82 	add	r0, r0, #8320	; 0x2080
  101d94:	e2811001 	add	r1, r1, #1	; 0x1
  101d98:	e3e030ff 	mvn	r3, #255	; 0xff
  101d9c:	e583c060 	str	ip, [r3, #96]
  101da0:	e58e0004 	str	r0, [lr, #4]
  101da4:	e5821020 	str	r1, [r2, #32]
  101da8:	e5923068 	ldr	r3, [r2, #104]
  101dac:	e3130001 	tst	r3, #1	; 0x1
  101db0:	0afffffc 	beq	101da8 <AT91F_LowLevelInit+0x3c>
  101db4:	e3a03819 	mov	r3, #1638400	; 0x190000
  101db8:	e2833b07 	add	r3, r3, #7168	; 0x1c00
  101dbc:	e2833005 	add	r3, r3, #5	; 0x5
  101dc0:	e582302c 	str	r3, [r2, #44]
  101dc4:	e3a02102 	mov	r2, #-2147483648	; 0x80000000
  101dc8:	e1a02ac2 	mov	r2, r2, asr #21
  101dcc:	e5923068 	ldr	r3, [r2, #104]
  101dd0:	e3130004 	tst	r3, #4	; 0x4
  101dd4:	0afffffc 	beq	101dcc <AT91F_LowLevelInit+0x60>
  101dd8:	e3a03004 	mov	r3, #4	; 0x4
  101ddc:	e5823030 	str	r3, [r2, #48]
  101de0:	e3a02102 	mov	r2, #-2147483648	; 0x80000000
  101de4:	e1a02ac2 	mov	r2, r2, asr #21
  101de8:	e5923068 	ldr	r3, [r2, #104]
  101dec:	e3130008 	tst	r3, #8	; 0x8
  101df0:	0afffffc 	beq	101de8 <AT91F_LowLevelInit+0x7c>
  101df4:	e5923030 	ldr	r3, [r2, #48]
  101df8:	e3833003 	orr	r3, r3, #3	; 0x3
  101dfc:	e5823030 	str	r3, [r2, #48]
  101e00:	e3a02102 	mov	r2, #-2147483648	; 0x80000000
  101e04:	e1a02ac2 	mov	r2, r2, asr #21
  101e08:	e5923068 	ldr	r3, [r2, #104]
  101e0c:	e3130008 	tst	r3, #8	; 0x8
  101e10:	0afffffc 	beq	101e08 <AT91F_LowLevelInit+0x9c>
  101e14:	e49df004 	ldr	pc, [sp], #4

00101e18 <vListInitialise>:
  101e18:	e3e03000 	mvn	r3, #0	; 0x0
  101e1c:	e5803008 	str	r3, [r0, #8]
  101e20:	e2802008 	add	r2, r0, #8	; 0x8
  101e24:	e2833001 	add	r3, r3, #1	; 0x1
  101e28:	e580200c 	str	r2, [r0, #12]
  101e2c:	e5802010 	str	r2, [r0, #16]
  101e30:	e5802004 	str	r2, [r0, #4]
  101e34:	e5803000 	str	r3, [r0]
  101e38:	e12fff1e 	bx	lr

00101e3c <vListInitialiseItem>:
  101e3c:	e3a03000 	mov	r3, #0	; 0x0
  101e40:	e5803010 	str	r3, [r0, #16]
  101e44:	e12fff1e 	bx	lr

00101e48 <vListInsertEnd>:
  101e48:	e5902004 	ldr	r2, [r0, #4]
  101e4c:	e5923004 	ldr	r3, [r2, #4]
  101e50:	e5813004 	str	r3, [r1, #4]
  101e54:	e592c004 	ldr	ip, [r2, #4]
  101e58:	e5812008 	str	r2, [r1, #8]
  101e5c:	e58c1008 	str	r1, [ip, #8]
  101e60:	e5821004 	str	r1, [r2, #4]
  101e64:	e5903000 	ldr	r3, [r0]
  101e68:	e2833001 	add	r3, r3, #1	; 0x1
  101e6c:	e5803000 	str	r3, [r0]
  101e70:	e5810010 	str	r0, [r1, #16]
  101e74:	e5801004 	str	r1, [r0, #4]
  101e78:	e12fff1e 	bx	lr

00101e7c <vListInsert>:
  101e7c:	e52de004 	str	lr, [sp, #-4]!
  101e80:	e591e000 	ldr	lr, [r1]
  101e84:	e37e0001 	cmn	lr, #1	; 0x1
  101e88:	0590c010 	ldreq	ip, [r0, #16]
  101e8c:	0a000004 	beq	101ea4 <vListInsert+0x28>
  101e90:	e280c008 	add	ip, r0, #8	; 0x8
  101e94:	e59c3004 	ldr	r3, [ip, #4]
  101e98:	e5932000 	ldr	r2, [r3]
  101e9c:	e15e0002 	cmp	lr, r2
  101ea0:	2a000009 	bcs	101ecc <vListInsert+0x50>
  101ea4:	e59c3004 	ldr	r3, [ip, #4]
  101ea8:	e5831008 	str	r1, [r3, #8]
  101eac:	e5813004 	str	r3, [r1, #4]
  101eb0:	e58c1004 	str	r1, [ip, #4]
  101eb4:	e5903000 	ldr	r3, [r0]
  101eb8:	e2833001 	add	r3, r3, #1	; 0x1
  101ebc:	e5803000 	str	r3, [r0]
  101ec0:	e5810010 	str	r0, [r1, #16]
  101ec4:	e581c008 	str	ip, [r1, #8]
  101ec8:	e49df004 	ldr	pc, [sp], #4
  101ecc:	e59cc004 	ldr	ip, [ip, #4]
  101ed0:	e59c3004 	ldr	r3, [ip, #4]
  101ed4:	e5932000 	ldr	r2, [r3]
  101ed8:	e15e0002 	cmp	lr, r2
  101edc:	3afffff0 	bcc	101ea4 <vListInsert+0x28>
  101ee0:	e59cc004 	ldr	ip, [ip, #4]
  101ee4:	e59c3004 	ldr	r3, [ip, #4]
  101ee8:	e5932000 	ldr	r2, [r3]
  101eec:	e15e0002 	cmp	lr, r2
  101ef0:	2afffff5 	bcs	101ecc <vListInsert+0x50>
  101ef4:	eaffffea 	b	101ea4 <vListInsert+0x28>

00101ef8 <vListRemove>:
  101ef8:	e5903004 	ldr	r3, [r0, #4]
  101efc:	e5902008 	ldr	r2, [r0, #8]
  101f00:	e5832008 	str	r2, [r3, #8]
  101f04:	e5902008 	ldr	r2, [r0, #8]
  101f08:	e5901010 	ldr	r1, [r0, #16]
  101f0c:	e5823004 	str	r3, [r2, #4]
  101f10:	e5913004 	ldr	r3, [r1, #4]
  101f14:	e1530000 	cmp	r3, r0
  101f18:	e5913000 	ldr	r3, [r1]
  101f1c:	05812004 	streq	r2, [r1, #4]
  101f20:	e2433001 	sub	r3, r3, #1	; 0x1
  101f24:	e3a02000 	mov	r2, #0	; 0x0
  101f28:	e5802010 	str	r2, [r0, #16]
  101f2c:	e5813000 	str	r3, [r1]
  101f30:	e12fff1e 	bx	lr

00101f34 <xQueueCreate>:
  101f34:	e92d41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
  101f38:	e2507000 	subs	r7, r0, #0	; 0x0
  101f3c:	e1a06001 	mov	r6, r1
  101f40:	e3a0004c 	mov	r0, #76	; 0x4c
  101f44:	1a000002 	bne	101f54 <xQueueCreate+0x20>
  101f48:	e3a05000 	mov	r5, #0	; 0x0
  101f4c:	e1a00005 	mov	r0, r5
  101f50:	e8bd81f0 	ldmia	sp!, {r4, r5, r6, r7, r8, pc}
  101f54:	eb00079f 	bl	103dd8 <pvPortMalloc>
  101f58:	e2505000 	subs	r5, r0, #0	; 0x0
  101f5c:	0afffff9 	beq	101f48 <xQueueCreate+0x14>
  101f60:	e0040796 	mul	r4, r6, r7
  101f64:	e2840001 	add	r0, r4, #1	; 0x1
  101f68:	eb00079a 	bl	103dd8 <pvPortMalloc>
  101f6c:	e1a08000 	mov	r8, r0
  101f70:	e3580000 	cmp	r8, #0	; 0x0
  101f74:	e0803004 	add	r3, r0, r4
  101f78:	e2472001 	sub	r2, r7, #1	; 0x1
  101f7c:	e3e01000 	mvn	r1, #0	; 0x0
  101f80:	e2850010 	add	r0, r5, #16	; 0x10
  101f84:	e5858000 	str	r8, [r5]
  101f88:	0a00000d 	beq	101fc4 <xQueueCreate+0x90>
  101f8c:	e0228296 	mla	r2, r6, r2, r8
  101f90:	e5853004 	str	r3, [r5, #4]
  101f94:	e3a03000 	mov	r3, #0	; 0x0
  101f98:	e5853038 	str	r3, [r5, #56]
  101f9c:	e585200c 	str	r2, [r5, #12]
  101fa0:	e585703c 	str	r7, [r5, #60]
  101fa4:	e5856040 	str	r6, [r5, #64]
  101fa8:	e5851048 	str	r1, [r5, #72]
  101fac:	e5858008 	str	r8, [r5, #8]
  101fb0:	e5851044 	str	r1, [r5, #68]
  101fb4:	ebffff97 	bl	101e18 <vListInitialise>
  101fb8:	e2850024 	add	r0, r5, #36	; 0x24
  101fbc:	ebffff95 	bl	101e18 <vListInitialise>
  101fc0:	eaffffe1 	b	101f4c <xQueueCreate+0x18>
  101fc4:	e1a00005 	mov	r0, r5
  101fc8:	eb0007cc 	bl	103f00 <vPortFree>
  101fcc:	e1a05008 	mov	r5, r8
  101fd0:	eaffffdd 	b	101f4c <xQueueCreate+0x18>

00101fd4 <xQueueSendFromISR>:
  101fd4:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  101fd8:	e1a04000 	mov	r4, r0
  101fdc:	e594303c 	ldr	r3, [r4, #60]
  101fe0:	e5900038 	ldr	r0, [r0, #56]
  101fe4:	e1500003 	cmp	r0, r3
  101fe8:	e1a05002 	mov	r5, r2
  101fec:	3a000001 	bcc	101ff8 <xQueueSendFromISR+0x24>
  101ff0:	e1a00005 	mov	r0, r5
  101ff4:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
  101ff8:	e5942040 	ldr	r2, [r4, #64]
  101ffc:	e5940008 	ldr	r0, [r4, #8]
  102000:	ebfff888 	bl	100228 <memcpy>
  102004:	e5942008 	ldr	r2, [r4, #8]
  102008:	e5940040 	ldr	r0, [r4, #64]
  10200c:	e5943038 	ldr	r3, [r4, #56]
  102010:	e5941004 	ldr	r1, [r4, #4]
  102014:	e0822000 	add	r2, r2, r0
  102018:	e2833001 	add	r3, r3, #1	; 0x1
  10201c:	e1520001 	cmp	r2, r1
  102020:	e5843038 	str	r3, [r4, #56]
  102024:	25943000 	ldrcs	r3, [r4]
  102028:	e5842008 	str	r2, [r4, #8]
  10202c:	25843008 	strcs	r3, [r4, #8]
  102030:	e5943048 	ldr	r3, [r4, #72]
  102034:	e3730001 	cmn	r3, #1	; 0x1
  102038:	12833001 	addne	r3, r3, #1	; 0x1
  10203c:	15843048 	strne	r3, [r4, #72]
  102040:	1affffea 	bne	101ff0 <xQueueSendFromISR+0x1c>
  102044:	e3550000 	cmp	r5, #0	; 0x0
  102048:	1affffe8 	bne	101ff0 <xQueueSendFromISR+0x1c>
  10204c:	e5943024 	ldr	r3, [r4, #36]
  102050:	e3530000 	cmp	r3, #0	; 0x0
  102054:	1a000001 	bne	102060 <xQueueSendFromISR+0x8c>
  102058:	e3a05000 	mov	r5, #0	; 0x0
  10205c:	eaffffe3 	b	101ff0 <xQueueSendFromISR+0x1c>
  102060:	e2840024 	add	r0, r4, #36	; 0x24
  102064:	eb0002f5 	bl	102c40 <xTaskRemoveFromEventList>
  102068:	e3500000 	cmp	r0, #0	; 0x0
  10206c:	12855001 	addne	r5, r5, #1	; 0x1
  102070:	1affffde 	bne	101ff0 <xQueueSendFromISR+0x1c>
  102074:	eafffff7 	b	102058 <xQueueSendFromISR+0x84>

00102078 <xQueueReceiveFromISR>:
  102078:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  10207c:	e1a04000 	mov	r4, r0
  102080:	e5900038 	ldr	r0, [r0, #56]
  102084:	e3500000 	cmp	r0, #0	; 0x0
  102088:	e1a0c001 	mov	ip, r1
  10208c:	e1a05002 	mov	r5, r2
  102090:	08bd8030 	ldmeqia	sp!, {r4, r5, pc}
  102094:	e594100c 	ldr	r1, [r4, #12]
  102098:	e5942040 	ldr	r2, [r4, #64]
  10209c:	e5943004 	ldr	r3, [r4, #4]
  1020a0:	e0811002 	add	r1, r1, r2
  1020a4:	e1510003 	cmp	r1, r3
  1020a8:	e584100c 	str	r1, [r4, #12]
  1020ac:	25941000 	ldrcs	r1, [r4]
  1020b0:	e2403001 	sub	r3, r0, #1	; 0x1
  1020b4:	2584100c 	strcs	r1, [r4, #12]
  1020b8:	e5843038 	str	r3, [r4, #56]
  1020bc:	e1a0000c 	mov	r0, ip
  1020c0:	ebfff858 	bl	100228 <memcpy>
  1020c4:	e5943044 	ldr	r3, [r4, #68]
  1020c8:	e3730001 	cmn	r3, #1	; 0x1
  1020cc:	12833001 	addne	r3, r3, #1	; 0x1
  1020d0:	13a00001 	movne	r0, #1	; 0x1
  1020d4:	15843044 	strne	r3, [r4, #68]
  1020d8:	18bd8030 	ldmneia	sp!, {r4, r5, pc}
  1020dc:	e5953000 	ldr	r3, [r5]
  1020e0:	e3530000 	cmp	r3, #0	; 0x0
  1020e4:	1a000002 	bne	1020f4 <xQueueReceiveFromISR+0x7c>
  1020e8:	e5943010 	ldr	r3, [r4, #16]
  1020ec:	e3530000 	cmp	r3, #0	; 0x0
  1020f0:	1a000001 	bne	1020fc <xQueueReceiveFromISR+0x84>
  1020f4:	e3a00001 	mov	r0, #1	; 0x1
  1020f8:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
  1020fc:	e2840010 	add	r0, r4, #16	; 0x10
  102100:	eb0002ce 	bl	102c40 <xTaskRemoveFromEventList>
  102104:	e3500000 	cmp	r0, #0	; 0x0
  102108:	13a03001 	movne	r3, #1	; 0x1
  10210c:	11a00003 	movne	r0, r3
  102110:	15853000 	strne	r3, [r5]
  102114:	18bd8030 	ldmneia	sp!, {r4, r5, pc}
  102118:	eafffff5 	b	1020f4 <xQueueReceiveFromISR+0x7c>

0010211c <uxQueueMessagesWaiting>:
  10211c:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  102120:	e1a04000 	mov	r4, r0
  102124:	eb00070f 	bl	103d68 <vPortEnterCritical>
  102128:	e5945038 	ldr	r5, [r4, #56]
  10212c:	eb000718 	bl	103d94 <vPortExitCritical>
  102130:	e1a00005 	mov	r0, r5
  102134:	e8bd8030 	ldmia	sp!, {r4, r5, pc}

00102138 <vQueueDelete>:
  102138:	e92d4010 	stmdb	sp!, {r4, lr}
  10213c:	e1a04000 	mov	r4, r0
  102140:	e5900000 	ldr	r0, [r0]
  102144:	eb00076d 	bl	103f00 <vPortFree>
  102148:	e1a00004 	mov	r0, r4
  10214c:	e8bd4010 	ldmia	sp!, {r4, lr}
  102150:	ea00076a 	b	103f00 <vPortFree>

00102154 <prvUnlockQueue>:
  102154:	e92d4010 	stmdb	sp!, {r4, lr}
  102158:	e1a04000 	mov	r4, r0
  10215c:	eb000701 	bl	103d68 <vPortEnterCritical>
  102160:	e5943048 	ldr	r3, [r4, #72]
  102164:	e2433001 	sub	r3, r3, #1	; 0x1
  102168:	e3730001 	cmn	r3, #1	; 0x1
  10216c:	e5843048 	str	r3, [r4, #72]
  102170:	da000005 	ble	10218c <prvUnlockQueue+0x38>
  102174:	e5942024 	ldr	r2, [r4, #36]
  102178:	e3e03000 	mvn	r3, #0	; 0x0
  10217c:	e3520000 	cmp	r2, #0	; 0x0
  102180:	e2840024 	add	r0, r4, #36	; 0x24
  102184:	e5843048 	str	r3, [r4, #72]
  102188:	1a000013 	bne	1021dc <prvUnlockQueue+0x88>
  10218c:	eb000700 	bl	103d94 <vPortExitCritical>
  102190:	eb0006f4 	bl	103d68 <vPortEnterCritical>
  102194:	e5943044 	ldr	r3, [r4, #68]
  102198:	e2433001 	sub	r3, r3, #1	; 0x1
  10219c:	e3730001 	cmn	r3, #1	; 0x1
  1021a0:	e5843044 	str	r3, [r4, #68]
  1021a4:	da000005 	ble	1021c0 <prvUnlockQueue+0x6c>
  1021a8:	e5942010 	ldr	r2, [r4, #16]
  1021ac:	e3e03000 	mvn	r3, #0	; 0x0
  1021b0:	e3520000 	cmp	r2, #0	; 0x0
  1021b4:	e2840010 	add	r0, r4, #16	; 0x10
  1021b8:	e5843044 	str	r3, [r4, #68]
  1021bc:	1a000001 	bne	1021c8 <prvUnlockQueue+0x74>
  1021c0:	e8bd4010 	ldmia	sp!, {r4, lr}
  1021c4:	ea0006f2 	b	103d94 <vPortExitCritical>
  1021c8:	eb00029c 	bl	102c40 <xTaskRemoveFromEventList>
  1021cc:	e3500000 	cmp	r0, #0	; 0x0
  1021d0:	0afffffa 	beq	1021c0 <prvUnlockQueue+0x6c>
  1021d4:	eb0002ee 	bl	102d94 <vTaskMissedYield>
  1021d8:	eafffff8 	b	1021c0 <prvUnlockQueue+0x6c>
  1021dc:	eb000297 	bl	102c40 <xTaskRemoveFromEventList>
  1021e0:	e3500000 	cmp	r0, #0	; 0x0
  1021e4:	0affffe8 	beq	10218c <prvUnlockQueue+0x38>
  1021e8:	eb0002e9 	bl	102d94 <vTaskMissedYield>
  1021ec:	eaffffe6 	b	10218c <prvUnlockQueue+0x38>

001021f0 <xQueueReceive>:
  1021f0:	e92d41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
  1021f4:	e24dd00c 	sub	sp, sp, #12	; 0xc
  1021f8:	e28d7004 	add	r7, sp, #4	; 0x4
  1021fc:	e1a05000 	mov	r5, r0
  102200:	e58d2000 	str	r2, [sp]
  102204:	e1a08001 	mov	r8, r1
  102208:	eb0000f1 	bl	1025d4 <vTaskSuspendAll>
  10220c:	e1a00007 	mov	r0, r7
  102210:	eb0002b3 	bl	102ce4 <vTaskSetTimeOutState>
  102214:	eb0006d3 	bl	103d68 <vPortEnterCritical>
  102218:	e5953044 	ldr	r3, [r5, #68]
  10221c:	e5952048 	ldr	r2, [r5, #72]
  102220:	e2833001 	add	r3, r3, #1	; 0x1
  102224:	e2822001 	add	r2, r2, #1	; 0x1
  102228:	e5853044 	str	r3, [r5, #68]
  10222c:	e5852048 	str	r2, [r5, #72]
  102230:	eb0006d7 	bl	103d94 <vPortExitCritical>
  102234:	e3a06001 	mov	r6, #1	; 0x1
  102238:	eb0006ca 	bl	103d68 <vPortEnterCritical>
  10223c:	e5954038 	ldr	r4, [r5, #56]
  102240:	eb0006d3 	bl	103d94 <vPortExitCritical>
  102244:	e3540000 	cmp	r4, #0	; 0x0
  102248:	1a000002 	bne	102258 <xQueueReceive+0x68>
  10224c:	e59d1000 	ldr	r1, [sp]
  102250:	e3510000 	cmp	r1, #0	; 0x0
  102254:	1a000031 	bne	102320 <xQueueReceive+0x130>
  102258:	e3560000 	cmp	r6, #0	; 0x0
  10225c:	1a00000f 	bne	1022a0 <xQueueReceive+0xb0>
  102260:	e59d3000 	ldr	r3, [sp]
  102264:	e3530000 	cmp	r3, #0	; 0x0
  102268:	0a000043 	beq	10237c <xQueueReceive+0x18c>
  10226c:	e1a00007 	mov	r0, r7
  102270:	e1a0100d 	mov	r1, sp
  102274:	eb0002a2 	bl	102d04 <xTaskCheckForTimeOut>
  102278:	e3500000 	cmp	r0, #0	; 0x0
  10227c:	1a00003e 	bne	10237c <xQueueReceive+0x18c>
  102280:	eb0006b8 	bl	103d68 <vPortEnterCritical>
  102284:	e5954038 	ldr	r4, [r5, #56]
  102288:	eb0006c1 	bl	103d94 <vPortExitCritical>
  10228c:	e3540000 	cmp	r4, #0	; 0x0
  102290:	e3e06000 	mvn	r6, #0	; 0x0
  102294:	0affffec 	beq	10224c <xQueueReceive+0x5c>
  102298:	e3560000 	cmp	r6, #0	; 0x0
  10229c:	0affffef 	beq	102260 <xQueueReceive+0x70>
  1022a0:	eb0006b0 	bl	103d68 <vPortEnterCritical>
  1022a4:	e5950038 	ldr	r0, [r5, #56]
  1022a8:	e3500000 	cmp	r0, #0	; 0x0
  1022ac:	01a06000 	moveq	r6, r0
  1022b0:	0a00000f 	beq	1022f4 <xQueueReceive+0x104>
  1022b4:	e595100c 	ldr	r1, [r5, #12]
  1022b8:	e5952040 	ldr	r2, [r5, #64]
  1022bc:	e5953004 	ldr	r3, [r5, #4]
  1022c0:	e0811002 	add	r1, r1, r2
  1022c4:	e1510003 	cmp	r1, r3
  1022c8:	e585100c 	str	r1, [r5, #12]
  1022cc:	25951000 	ldrcs	r1, [r5]
  1022d0:	e2403001 	sub	r3, r0, #1	; 0x1
  1022d4:	e5853038 	str	r3, [r5, #56]
  1022d8:	2585100c 	strcs	r1, [r5, #12]
  1022dc:	e1a00008 	mov	r0, r8
  1022e0:	ebfff7d0 	bl	100228 <memcpy>
  1022e4:	e5953044 	ldr	r3, [r5, #68]
  1022e8:	e2833001 	add	r3, r3, #1	; 0x1
  1022ec:	e5853044 	str	r3, [r5, #68]
  1022f0:	e3a06001 	mov	r6, #1	; 0x1
  1022f4:	eb0006a6 	bl	103d94 <vPortExitCritical>
  1022f8:	e3560000 	cmp	r6, #0	; 0x0
  1022fc:	0affffd7 	beq	102260 <xQueueReceive+0x70>
  102300:	e3760001 	cmn	r6, #1	; 0x1
  102304:	0affffcb 	beq	102238 <xQueueReceive+0x48>
  102308:	e1a00005 	mov	r0, r5
  10230c:	ebffff90 	bl	102154 <prvUnlockQueue>
  102310:	eb000362 	bl	1030a0 <xTaskResumeAll>
  102314:	e1a00006 	mov	r0, r6
  102318:	e28dd00c 	add	sp, sp, #12	; 0xc
  10231c:	e8bd81f0 	ldmia	sp!, {r4, r5, r6, r7, r8, pc}
  102320:	e2850024 	add	r0, r5, #36	; 0x24
  102324:	eb000222 	bl	102bb4 <vTaskPlaceOnEventList>
  102328:	eb00068e 	bl	103d68 <vPortEnterCritical>
  10232c:	e1a00005 	mov	r0, r5
  102330:	ebffff87 	bl	102154 <prvUnlockQueue>
  102334:	eb000359 	bl	1030a0 <xTaskResumeAll>
  102338:	e3500000 	cmp	r0, #0	; 0x0
  10233c:	1a000000 	bne	102344 <xQueueReceive+0x154>
  102340:	ef000000 	swi	0x00000000
  102344:	e5953038 	ldr	r3, [r5, #56]
  102348:	e3530000 	cmp	r3, #0	; 0x0
  10234c:	03a06000 	moveq	r6, #0	; 0x0
  102350:	eb00009f 	bl	1025d4 <vTaskSuspendAll>
  102354:	eb000683 	bl	103d68 <vPortEnterCritical>
  102358:	e5953044 	ldr	r3, [r5, #68]
  10235c:	e5952048 	ldr	r2, [r5, #72]
  102360:	e2833001 	add	r3, r3, #1	; 0x1
  102364:	e2822001 	add	r2, r2, #1	; 0x1
  102368:	e5853044 	str	r3, [r5, #68]
  10236c:	e5852048 	str	r2, [r5, #72]
  102370:	eb000687 	bl	103d94 <vPortExitCritical>
  102374:	eb000686 	bl	103d94 <vPortExitCritical>
  102378:	eaffffb6 	b	102258 <xQueueReceive+0x68>
  10237c:	e3a06000 	mov	r6, #0	; 0x0
  102380:	eaffffe0 	b	102308 <xQueueReceive+0x118>

00102384 <xQueueSend>:
  102384:	e92d45f0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, lr}
  102388:	e24dd00c 	sub	sp, sp, #12	; 0xc
  10238c:	e28d8004 	add	r8, sp, #4	; 0x4
  102390:	e1a06000 	mov	r6, r0
  102394:	e58d2000 	str	r2, [sp]
  102398:	e1a0a001 	mov	sl, r1
  10239c:	eb00008c 	bl	1025d4 <vTaskSuspendAll>
  1023a0:	e1a00008 	mov	r0, r8
  1023a4:	eb00024e 	bl	102ce4 <vTaskSetTimeOutState>
  1023a8:	eb00066e 	bl	103d68 <vPortEnterCritical>
  1023ac:	e5963044 	ldr	r3, [r6, #68]
  1023b0:	e5962048 	ldr	r2, [r6, #72]
  1023b4:	e2833001 	add	r3, r3, #1	; 0x1
  1023b8:	e2822001 	add	r2, r2, #1	; 0x1
  1023bc:	e5863044 	str	r3, [r6, #68]
  1023c0:	e5862048 	str	r2, [r6, #72]
  1023c4:	eb000672 	bl	103d94 <vPortExitCritical>
  1023c8:	e3a07001 	mov	r7, #1	; 0x1
  1023cc:	eb000665 	bl	103d68 <vPortEnterCritical>
  1023d0:	e5965038 	ldr	r5, [r6, #56]
  1023d4:	e596403c 	ldr	r4, [r6, #60]
  1023d8:	eb00066d 	bl	103d94 <vPortExitCritical>
  1023dc:	e1550004 	cmp	r5, r4
  1023e0:	0a000010 	beq	102428 <xQueueSend+0xa4>
  1023e4:	e3570000 	cmp	r7, #0	; 0x0
  1023e8:	1a00002a 	bne	102498 <xQueueSend+0x114>
  1023ec:	e59d3000 	ldr	r3, [sp]
  1023f0:	e3530000 	cmp	r3, #0	; 0x0
  1023f4:	0a00004c 	beq	10252c <xQueueSend+0x1a8>
  1023f8:	e1a00008 	mov	r0, r8
  1023fc:	e1a0100d 	mov	r1, sp
  102400:	eb00023f 	bl	102d04 <xTaskCheckForTimeOut>
  102404:	e3500000 	cmp	r0, #0	; 0x0
  102408:	1a000047 	bne	10252c <xQueueSend+0x1a8>
  10240c:	eb000655 	bl	103d68 <vPortEnterCritical>
  102410:	e5965038 	ldr	r5, [r6, #56]
  102414:	e596403c 	ldr	r4, [r6, #60]
  102418:	eb00065d 	bl	103d94 <vPortExitCritical>
  10241c:	e1550004 	cmp	r5, r4
  102420:	e3e07000 	mvn	r7, #0	; 0x0
  102424:	1affffee 	bne	1023e4 <xQueueSend+0x60>
  102428:	e59d1000 	ldr	r1, [sp]
  10242c:	e3510000 	cmp	r1, #0	; 0x0
  102430:	0affffeb 	beq	1023e4 <xQueueSend+0x60>
  102434:	e2860010 	add	r0, r6, #16	; 0x10
  102438:	eb0001dd 	bl	102bb4 <vTaskPlaceOnEventList>
  10243c:	eb000649 	bl	103d68 <vPortEnterCritical>
  102440:	e1a00006 	mov	r0, r6
  102444:	ebffff42 	bl	102154 <prvUnlockQueue>
  102448:	eb000314 	bl	1030a0 <xTaskResumeAll>
  10244c:	e3500000 	cmp	r0, #0	; 0x0
  102450:	1a000000 	bne	102458 <xQueueSend+0xd4>
  102454:	ef000000 	swi	0x00000000
  102458:	e2862038 	add	r2, r6, #56	; 0x38
  10245c:	e892000c 	ldmia	r2, {r2, r3}
  102460:	e1520003 	cmp	r2, r3
  102464:	03a07000 	moveq	r7, #0	; 0x0
  102468:	eb000059 	bl	1025d4 <vTaskSuspendAll>
  10246c:	eb00063d 	bl	103d68 <vPortEnterCritical>
  102470:	e5963044 	ldr	r3, [r6, #68]
  102474:	e5962048 	ldr	r2, [r6, #72]
  102478:	e2833001 	add	r3, r3, #1	; 0x1
  10247c:	e2822001 	add	r2, r2, #1	; 0x1
  102480:	e5863044 	str	r3, [r6, #68]
  102484:	e5862048 	str	r2, [r6, #72]
  102488:	eb000641 	bl	103d94 <vPortExitCritical>
  10248c:	eb000640 	bl	103d94 <vPortExitCritical>
  102490:	e3570000 	cmp	r7, #0	; 0x0
  102494:	0affffd4 	beq	1023ec <xQueueSend+0x68>
  102498:	eb000632 	bl	103d68 <vPortEnterCritical>
  10249c:	e2862038 	add	r2, r6, #56	; 0x38
  1024a0:	e892000c 	ldmia	r2, {r2, r3}
  1024a4:	e1520003 	cmp	r2, r3
  1024a8:	23a07000 	movcs	r7, #0	; 0x0
  1024ac:	3a00000a 	bcc	1024dc <xQueueSend+0x158>
  1024b0:	eb000637 	bl	103d94 <vPortExitCritical>
  1024b4:	e3570000 	cmp	r7, #0	; 0x0
  1024b8:	0affffcb 	beq	1023ec <xQueueSend+0x68>
  1024bc:	e3770001 	cmn	r7, #1	; 0x1
  1024c0:	0affffc1 	beq	1023cc <xQueueSend+0x48>
  1024c4:	e1a00006 	mov	r0, r6
  1024c8:	ebffff21 	bl	102154 <prvUnlockQueue>
  1024cc:	eb0002f3 	bl	1030a0 <xTaskResumeAll>
  1024d0:	e1a00007 	mov	r0, r7
  1024d4:	e28dd00c 	add	sp, sp, #12	; 0xc
  1024d8:	e8bd85f0 	ldmia	sp!, {r4, r5, r6, r7, r8, sl, pc}
  1024dc:	e1a0100a 	mov	r1, sl
  1024e0:	e5962040 	ldr	r2, [r6, #64]
  1024e4:	e5960008 	ldr	r0, [r6, #8]
  1024e8:	ebfff74e 	bl	100228 <memcpy>
  1024ec:	e5962008 	ldr	r2, [r6, #8]
  1024f0:	e5960040 	ldr	r0, [r6, #64]
  1024f4:	e5963038 	ldr	r3, [r6, #56]
  1024f8:	e5961004 	ldr	r1, [r6, #4]
  1024fc:	e0822000 	add	r2, r2, r0
  102500:	e2833001 	add	r3, r3, #1	; 0x1
  102504:	e1520001 	cmp	r2, r1
  102508:	e5863038 	str	r3, [r6, #56]
  10250c:	25963000 	ldrcs	r3, [r6]
  102510:	e5862008 	str	r2, [r6, #8]
  102514:	25863008 	strcs	r3, [r6, #8]
  102518:	e5963048 	ldr	r3, [r6, #72]
  10251c:	e3a07001 	mov	r7, #1	; 0x1
  102520:	e2833001 	add	r3, r3, #1	; 0x1
  102524:	e5863048 	str	r3, [r6, #72]
  102528:	eaffffe0 	b	1024b0 <xQueueSend+0x12c>
  10252c:	e3a07000 	mov	r7, #0	; 0x0
  102530:	eaffffe3 	b	1024c4 <xQueueSend+0x140>

00102534 <vTaskDelete>:
  102534:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
  102538:	e1a06000 	mov	r6, r0
  10253c:	eb000609 	bl	103d68 <vPortEnterCritical>
  102540:	e59f007c 	ldr	r0, [pc, #124]	; 1025c4 <prog+0x2580>
  102544:	e5903000 	ldr	r3, [r0]
  102548:	e1530006 	cmp	r3, r6
  10254c:	03a06000 	moveq	r6, #0	; 0x0
  102550:	0a000019 	beq	1025bc <vTaskDelete+0x88>
  102554:	e3560000 	cmp	r6, #0	; 0x0
  102558:	11a04006 	movne	r4, r6
  10255c:	0a000016 	beq	1025bc <vTaskDelete+0x88>
  102560:	e2845004 	add	r5, r4, #4	; 0x4
  102564:	e1a00005 	mov	r0, r5
  102568:	ebfffe62 	bl	101ef8 <vListRemove>
  10256c:	e5943028 	ldr	r3, [r4, #40]
  102570:	e3530000 	cmp	r3, #0	; 0x0
  102574:	12840018 	addne	r0, r4, #24	; 0x18
  102578:	1bfffe5e 	blne	101ef8 <vListRemove>
  10257c:	e1a01005 	mov	r1, r5
  102580:	e59f0040 	ldr	r0, [pc, #64]	; 1025c8 <prog+0x2584>
  102584:	ebfffe2f 	bl	101e48 <vListInsertEnd>
  102588:	e59f203c 	ldr	r2, [pc, #60]	; 1025cc <prog+0x2588>
  10258c:	e5923000 	ldr	r3, [r2]
  102590:	e2833001 	add	r3, r3, #1	; 0x1
  102594:	e5823000 	str	r3, [r2]
  102598:	eb0005fd 	bl	103d94 <vPortExitCritical>
  10259c:	e59f302c 	ldr	r3, [pc, #44]	; 1025d0 <prog+0x258c>
  1025a0:	e5932000 	ldr	r2, [r3]
  1025a4:	e3520000 	cmp	r2, #0	; 0x0
  1025a8:	08bd8070 	ldmeqia	sp!, {r4, r5, r6, pc}
  1025ac:	e3560000 	cmp	r6, #0	; 0x0
  1025b0:	18bd8070 	ldmneia	sp!, {r4, r5, r6, pc}
  1025b4:	ef000000 	swi	0x00000000
  1025b8:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  1025bc:	e5904000 	ldr	r4, [r0]
  1025c0:	eaffffe6 	b	102560 <vTaskDelete+0x2c>
  1025c4:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  1025c8:	00200d80 	eoreq	r0, r0, r0, lsl #27
  1025cc:	00200d60 	eoreq	r0, r0, r0, ror #26
  1025d0:	00200d5c 	eoreq	r0, r0, ip, asr sp

001025d4 <vTaskSuspendAll>:
  1025d4:	e52de004 	str	lr, [sp, #-4]!
  1025d8:	eb0005e2 	bl	103d68 <vPortEnterCritical>
  1025dc:	e59f2010 	ldr	r2, [pc, #16]	; 1025f4 <prog+0x25b0>
  1025e0:	e5923000 	ldr	r3, [r2]
  1025e4:	e2833001 	add	r3, r3, #1	; 0x1
  1025e8:	e5823000 	str	r3, [r2]
  1025ec:	e49de004 	ldr	lr, [sp], #4
  1025f0:	ea0005e7 	b	103d94 <vPortExitCritical>
  1025f4:	00200d50 	eoreq	r0, r0, r0, asr sp

001025f8 <uxTaskPriorityGet>:
  1025f8:	e92d4010 	stmdb	sp!, {r4, lr}
  1025fc:	e1a04000 	mov	r4, r0
  102600:	eb0005d8 	bl	103d68 <vPortEnterCritical>
  102604:	e3540000 	cmp	r4, #0	; 0x0
  102608:	059f3014 	ldreq	r3, [pc, #20]	; 102624 <prog+0x25e0>
  10260c:	05930000 	ldreq	r0, [r3]
  102610:	11a00004 	movne	r0, r4
  102614:	e590402c 	ldr	r4, [r0, #44]
  102618:	eb0005dd 	bl	103d94 <vPortExitCritical>
  10261c:	e1a00004 	mov	r0, r4
  102620:	e8bd8010 	ldmia	sp!, {r4, pc}
  102624:	00200d3c 	eoreq	r0, r0, ip, lsr sp

00102628 <vTaskPrioritySet>:
  102628:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
  10262c:	e3510005 	cmp	r1, #5	; 0x5
  102630:	e1a04001 	mov	r4, r1
  102634:	e1a06000 	mov	r6, r0
  102638:	23a04004 	movcs	r4, #4	; 0x4
  10263c:	eb0005c9 	bl	103d68 <vPortEnterCritical>
  102640:	e3560000 	cmp	r6, #0	; 0x0
  102644:	059f30ac 	ldreq	r3, [pc, #172]	; 1026f8 <prog+0x26b4>
  102648:	05935000 	ldreq	r5, [r3]
  10264c:	11a05006 	movne	r5, r6
  102650:	e595002c 	ldr	r0, [r5, #44]
  102654:	e1540000 	cmp	r4, r0
  102658:	0a000013 	beq	1026ac <vTaskPrioritySet+0x84>
  10265c:	e59f3094 	ldr	r3, [pc, #148]	; 1026f8 <prog+0x26b4>
  102660:	e5932000 	ldr	r2, [r3]
  102664:	e592102c 	ldr	r1, [r2, #44]
  102668:	e1540001 	cmp	r4, r1
  10266c:	8a000010 	bhi	1026b4 <vTaskPrioritySet+0x8c>
  102670:	e3560000 	cmp	r6, #0	; 0x0
  102674:	0a000010 	beq	1026bc <vTaskPrioritySet+0x94>
  102678:	e3a07000 	mov	r7, #0	; 0x0
  10267c:	e59f6078 	ldr	r6, [pc, #120]	; 1026fc <prog+0x26b8>
  102680:	e0803100 	add	r3, r0, r0, lsl #2
  102684:	e5951014 	ldr	r1, [r5, #20]
  102688:	e0863103 	add	r3, r6, r3, lsl #2
  10268c:	e2642005 	rsb	r2, r4, #5	; 0x5
  102690:	e1510003 	cmp	r1, r3
  102694:	e5852018 	str	r2, [r5, #24]
  102698:	e585402c 	str	r4, [r5, #44]
  10269c:	0a000008 	beq	1026c4 <vTaskPrioritySet+0x9c>
  1026a0:	e3570001 	cmp	r7, #1	; 0x1
  1026a4:	1a000000 	bne	1026ac <vTaskPrioritySet+0x84>
  1026a8:	ef000000 	swi	0x00000000
  1026ac:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
  1026b0:	ea0005b7 	b	103d94 <vPortExitCritical>
  1026b4:	e3560000 	cmp	r6, #0	; 0x0
  1026b8:	0affffee 	beq	102678 <vTaskPrioritySet+0x50>
  1026bc:	e3a07001 	mov	r7, #1	; 0x1
  1026c0:	eaffffed 	b	10267c <vTaskPrioritySet+0x54>
  1026c4:	e2854004 	add	r4, r5, #4	; 0x4
  1026c8:	e1a00004 	mov	r0, r4
  1026cc:	ebfffe09 	bl	101ef8 <vListRemove>
  1026d0:	e59f1028 	ldr	r1, [pc, #40]	; 102700 <prog+0x26bc>
  1026d4:	e595202c 	ldr	r2, [r5, #44]
  1026d8:	e5913000 	ldr	r3, [r1]
  1026dc:	e0820102 	add	r0, r2, r2, lsl #2
  1026e0:	e1520003 	cmp	r2, r3
  1026e4:	85812000 	strhi	r2, [r1]
  1026e8:	e0860100 	add	r0, r6, r0, lsl #2
  1026ec:	e1a01004 	mov	r1, r4
  1026f0:	ebfffdd4 	bl	101e48 <vListInsertEnd>
  1026f4:	eaffffe9 	b	1026a0 <vTaskPrioritySet+0x78>
  1026f8:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  1026fc:	00200dd8 	ldreqd	r0, [r0], -r8
  102700:	00200d4c 	eoreq	r0, r0, ip, asr #26

00102704 <vTaskSuspend>:
  102704:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
  102708:	e1a05000 	mov	r5, r0
  10270c:	eb000595 	bl	103d68 <vPortEnterCritical>
  102710:	e59f005c 	ldr	r0, [pc, #92]	; 102774 <prog+0x2730>
  102714:	e5903000 	ldr	r3, [r0]
  102718:	e1530005 	cmp	r3, r5
  10271c:	03a05000 	moveq	r5, #0	; 0x0
  102720:	0a000011 	beq	10276c <vTaskSuspend+0x68>
  102724:	e3550000 	cmp	r5, #0	; 0x0
  102728:	11a04005 	movne	r4, r5
  10272c:	0a00000e 	beq	10276c <vTaskSuspend+0x68>
  102730:	e2846004 	add	r6, r4, #4	; 0x4
  102734:	e1a00006 	mov	r0, r6
  102738:	ebfffdee 	bl	101ef8 <vListRemove>
  10273c:	e5943028 	ldr	r3, [r4, #40]
  102740:	e3530000 	cmp	r3, #0	; 0x0
  102744:	e2840018 	add	r0, r4, #24	; 0x18
  102748:	1bfffdea 	blne	101ef8 <vListRemove>
  10274c:	e1a01006 	mov	r1, r6
  102750:	e59f0020 	ldr	r0, [pc, #32]	; 102778 <prog+0x2734>
  102754:	ebfffdbb 	bl	101e48 <vListInsertEnd>
  102758:	eb00058d 	bl	103d94 <vPortExitCritical>
  10275c:	e3550000 	cmp	r5, #0	; 0x0
  102760:	18bd8070 	ldmneia	sp!, {r4, r5, r6, pc}
  102764:	ef000000 	swi	0x00000000
  102768:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  10276c:	e5904000 	ldr	r4, [r0]
  102770:	eaffffee 	b	102730 <vTaskSuspend+0x2c>
  102774:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  102778:	00200d6c 	eoreq	r0, r0, ip, ror #26

0010277c <vTaskResume>:
  10277c:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  102780:	e2504000 	subs	r4, r0, #0	; 0x0
  102784:	08bd8030 	ldmeqia	sp!, {r4, r5, pc}
  102788:	eb000576 	bl	103d68 <vPortEnterCritical>
  10278c:	e5942014 	ldr	r2, [r4, #20]
  102790:	e59f3070 	ldr	r3, [pc, #112]	; 102808 <prog+0x27c4>
  102794:	e1520003 	cmp	r2, r3
  102798:	0a000001 	beq	1027a4 <vTaskResume+0x28>
  10279c:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  1027a0:	ea00057b 	b	103d94 <vPortExitCritical>
  1027a4:	e5942028 	ldr	r2, [r4, #40]
  1027a8:	e59f305c 	ldr	r3, [pc, #92]	; 10280c <prog+0x27c8>
  1027ac:	e2845004 	add	r5, r4, #4	; 0x4
  1027b0:	e1520003 	cmp	r2, r3
  1027b4:	e1a00005 	mov	r0, r5
  1027b8:	0afffff7 	beq	10279c <vTaskResume+0x20>
  1027bc:	ebfffdcd 	bl	101ef8 <vListRemove>
  1027c0:	e59fe048 	ldr	lr, [pc, #72]	; 102810 <prog+0x27cc>
  1027c4:	e594c02c 	ldr	ip, [r4, #44]
  1027c8:	e59e2000 	ldr	r2, [lr]
  1027cc:	e59f0040 	ldr	r0, [pc, #64]	; 102814 <prog+0x27d0>
  1027d0:	e15c0002 	cmp	ip, r2
  1027d4:	e08c310c 	add	r3, ip, ip, lsl #2
  1027d8:	e1a01005 	mov	r1, r5
  1027dc:	e0800103 	add	r0, r0, r3, lsl #2
  1027e0:	858ec000 	strhi	ip, [lr]
  1027e4:	ebfffd97 	bl	101e48 <vListInsertEnd>
  1027e8:	e59f3028 	ldr	r3, [pc, #40]	; 102818 <prog+0x27d4>
  1027ec:	e5932000 	ldr	r2, [r3]
  1027f0:	e594102c 	ldr	r1, [r4, #44]
  1027f4:	e592302c 	ldr	r3, [r2, #44]
  1027f8:	e1510003 	cmp	r1, r3
  1027fc:	3affffe6 	bcc	10279c <vTaskResume+0x20>
  102800:	ef000000 	swi	0x00000000
  102804:	eaffffe4 	b	10279c <vTaskResume+0x20>
  102808:	00200d6c 	eoreq	r0, r0, ip, ror #26
  10280c:	00200d94 	mlaeq	r0, r4, sp, r0
  102810:	00200d4c 	eoreq	r0, r0, ip, asr #26
  102814:	00200dd8 	ldreqd	r0, [r0], -r8
  102818:	00200d3c 	eoreq	r0, r0, ip, lsr sp

0010281c <xTaskResumeFromISR>:
  10281c:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
  102820:	e59f30a0 	ldr	r3, [pc, #160]	; 1028c8 <prog+0x2884>
  102824:	e5902014 	ldr	r2, [r0, #20]
  102828:	e1520003 	cmp	r2, r3
  10282c:	e1a04000 	mov	r4, r0
  102830:	e59f0094 	ldr	r0, [pc, #148]	; 1028cc <prog+0x2888>
  102834:	0a000002 	beq	102844 <xTaskResumeFromISR+0x28>
  102838:	e3a05000 	mov	r5, #0	; 0x0
  10283c:	e1a00005 	mov	r0, r5
  102840:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  102844:	e5943028 	ldr	r3, [r4, #40]
  102848:	e1530000 	cmp	r3, r0
  10284c:	0afffff9 	beq	102838 <xTaskResumeFromISR+0x1c>
  102850:	e59f3078 	ldr	r3, [pc, #120]	; 1028d0 <prog+0x288c>
  102854:	e5932000 	ldr	r2, [r3]
  102858:	e3520000 	cmp	r2, #0	; 0x0
  10285c:	e2841018 	add	r1, r4, #24	; 0x18
  102860:	e2846004 	add	r6, r4, #4	; 0x4
  102864:	e3a05000 	mov	r5, #0	; 0x0
  102868:	0a000002 	beq	102878 <xTaskResumeFromISR+0x5c>
  10286c:	ebfffd75 	bl	101e48 <vListInsertEnd>
  102870:	e1a00005 	mov	r0, r5
  102874:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  102878:	e59f3054 	ldr	r3, [pc, #84]	; 1028d4 <prog+0x2890>
  10287c:	e5932000 	ldr	r2, [r3]
  102880:	e594102c 	ldr	r1, [r4, #44]
  102884:	e592302c 	ldr	r3, [r2, #44]
  102888:	e1a00006 	mov	r0, r6
  10288c:	e1510003 	cmp	r1, r3
  102890:	33a05000 	movcc	r5, #0	; 0x0
  102894:	23a05001 	movcs	r5, #1	; 0x1
  102898:	ebfffd96 	bl	101ef8 <vListRemove>
  10289c:	e59fe034 	ldr	lr, [pc, #52]	; 1028d8 <prog+0x2894>
  1028a0:	e594c02c 	ldr	ip, [r4, #44]
  1028a4:	e59e3000 	ldr	r3, [lr]
  1028a8:	e59f002c 	ldr	r0, [pc, #44]	; 1028dc <prog+0x2898>
  1028ac:	e08c210c 	add	r2, ip, ip, lsl #2
  1028b0:	e15c0003 	cmp	ip, r3
  1028b4:	e1a01006 	mov	r1, r6
  1028b8:	e0800102 	add	r0, r0, r2, lsl #2
  1028bc:	858ec000 	strhi	ip, [lr]
  1028c0:	ebfffd60 	bl	101e48 <vListInsertEnd>
  1028c4:	eaffffe9 	b	102870 <xTaskResumeFromISR+0x54>
  1028c8:	00200d6c 	eoreq	r0, r0, ip, ror #26
  1028cc:	00200d94 	mlaeq	r0, r4, sp, r0
  1028d0:	00200d50 	eoreq	r0, r0, r0, asr sp
  1028d4:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  1028d8:	00200d4c 	eoreq	r0, r0, ip, asr #26
  1028dc:	00200dd8 	ldreqd	r0, [r0], -r8

001028e0 <vTaskEndScheduler>:
  1028e0:	e92d0001 	stmdb	sp!, {r0}
  1028e4:	e10f0000 	mrs	r0, CPSR
  1028e8:	e38000c0 	orr	r0, r0, #192	; 0xc0
  1028ec:	e129f000 	msr	CPSR_fc, r0
  1028f0:	e8bd0001 	ldmia	sp!, {r0}
  1028f4:	e59f3008 	ldr	r3, [pc, #8]	; 102904 <prog+0x28c0>
  1028f8:	e3a02000 	mov	r2, #0	; 0x0
  1028fc:	e5832000 	str	r2, [r3]
  102900:	ea000486 	b	103b20 <vPortEndScheduler>
  102904:	00200d5c 	eoreq	r0, r0, ip, asr sp

00102908 <vTaskIncrementTick>:
  102908:	e92d45f0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, lr}
  10290c:	e59f3134 	ldr	r3, [pc, #308]	; 102a48 <prog+0x2a04>
  102910:	e5932000 	ldr	r2, [r3]
  102914:	e3520000 	cmp	r2, #0	; 0x0
  102918:	1a000036 	bne	1029f8 <vTaskIncrementTick+0xf0>
  10291c:	e59fc128 	ldr	ip, [pc, #296]	; 102a4c <prog+0x2a08>
  102920:	e59c3000 	ldr	r3, [ip]
  102924:	e2833001 	add	r3, r3, #1	; 0x1
  102928:	e58c3000 	str	r3, [ip]
  10292c:	e59c2000 	ldr	r2, [ip]
  102930:	e3520000 	cmp	r2, #0	; 0x0
  102934:	e1a0a00c 	mov	sl, ip
  102938:	159f6110 	ldrne	r6, [pc, #272]	; 102a50 <prog+0x2a0c>
  10293c:	0a000032 	beq	102a0c <vTaskIncrementTick+0x104>
  102940:	e5963000 	ldr	r3, [r6]
  102944:	e5932000 	ldr	r2, [r3]
  102948:	e3520000 	cmp	r2, #0	; 0x0
  10294c:	08bd85f0 	ldmeqia	sp!, {r4, r5, r6, r7, r8, sl, pc}
  102950:	e59f30f8 	ldr	r3, [pc, #248]	; 102a50 <prog+0x2a0c>
  102954:	e5932000 	ldr	r2, [r3]
  102958:	e592100c 	ldr	r1, [r2, #12]
  10295c:	e591400c 	ldr	r4, [r1, #12]
  102960:	e3540000 	cmp	r4, #0	; 0x0
  102964:	08bd85f0 	ldmeqia	sp!, {r4, r5, r6, r7, r8, sl, pc}
  102968:	e59c2000 	ldr	r2, [ip]
  10296c:	e5943004 	ldr	r3, [r4, #4]
  102970:	e1530002 	cmp	r3, r2
  102974:	88bd85f0 	ldmhiia	sp!, {r4, r5, r6, r7, r8, sl, pc}
  102978:	e59f70d4 	ldr	r7, [pc, #212]	; 102a54 <prog+0x2a10>
  10297c:	e59f80d4 	ldr	r8, [pc, #212]	; 102a58 <prog+0x2a14>
  102980:	ea000003 	b	102994 <vTaskIncrementTick+0x8c>
  102984:	e59a2000 	ldr	r2, [sl]
  102988:	e5943004 	ldr	r3, [r4, #4]
  10298c:	e1530002 	cmp	r3, r2
  102990:	88bd85f0 	ldmhiia	sp!, {r4, r5, r6, r7, r8, sl, pc}
  102994:	e2845004 	add	r5, r4, #4	; 0x4
  102998:	e1a00005 	mov	r0, r5
  10299c:	ebfffd55 	bl	101ef8 <vListRemove>
  1029a0:	e5943028 	ldr	r3, [r4, #40]
  1029a4:	e3530000 	cmp	r3, #0	; 0x0
  1029a8:	e2840018 	add	r0, r4, #24	; 0x18
  1029ac:	1bfffd51 	blne	101ef8 <vListRemove>
  1029b0:	e594202c 	ldr	r2, [r4, #44]
  1029b4:	e5973000 	ldr	r3, [r7]
  1029b8:	e0820102 	add	r0, r2, r2, lsl #2
  1029bc:	e1520003 	cmp	r2, r3
  1029c0:	e1a01005 	mov	r1, r5
  1029c4:	e0880100 	add	r0, r8, r0, lsl #2
  1029c8:	85872000 	strhi	r2, [r7]
  1029cc:	ebfffd1d 	bl	101e48 <vListInsertEnd>
  1029d0:	e5963000 	ldr	r3, [r6]
  1029d4:	e5932000 	ldr	r2, [r3]
  1029d8:	e3520000 	cmp	r2, #0	; 0x0
  1029dc:	08bd85f0 	ldmeqia	sp!, {r4, r5, r6, r7, r8, sl, pc}
  1029e0:	e5963000 	ldr	r3, [r6]
  1029e4:	e593200c 	ldr	r2, [r3, #12]
  1029e8:	e592400c 	ldr	r4, [r2, #12]
  1029ec:	e3540000 	cmp	r4, #0	; 0x0
  1029f0:	1affffe3 	bne	102984 <vTaskIncrementTick+0x7c>
  1029f4:	e8bd85f0 	ldmia	sp!, {r4, r5, r6, r7, r8, sl, pc}
  1029f8:	e59f205c 	ldr	r2, [pc, #92]	; 102a5c <prog+0x2a18>
  1029fc:	e5923000 	ldr	r3, [r2]
  102a00:	e2833001 	add	r3, r3, #1	; 0x1
  102a04:	e5823000 	str	r3, [r2]
  102a08:	e8bd85f0 	ldmia	sp!, {r4, r5, r6, r7, r8, sl, pc}
  102a0c:	e59f603c 	ldr	r6, [pc, #60]	; 102a50 <prog+0x2a0c>
  102a10:	e59f1048 	ldr	r1, [pc, #72]	; 102a60 <prog+0x2a1c>
  102a14:	e5960000 	ldr	r0, [r6]
  102a18:	e5913000 	ldr	r3, [r1]
  102a1c:	e59f2040 	ldr	r2, [pc, #64]	; 102a64 <prog+0x2a20>
  102a20:	e5863000 	str	r3, [r6]
  102a24:	e5810000 	str	r0, [r1]
  102a28:	e5923000 	ldr	r3, [r2]
  102a2c:	e2833001 	add	r3, r3, #1	; 0x1
  102a30:	e5823000 	str	r3, [r2]
  102a34:	e5963000 	ldr	r3, [r6]
  102a38:	e5932000 	ldr	r2, [r3]
  102a3c:	e3520000 	cmp	r2, #0	; 0x0
  102a40:	1affffc2 	bne	102950 <vTaskIncrementTick+0x48>
  102a44:	e8bd85f0 	ldmia	sp!, {r4, r5, r6, r7, r8, sl, pc}
  102a48:	00200d50 	eoreq	r0, r0, r0, asr sp
  102a4c:	00200d44 	eoreq	r0, r0, r4, asr #26
  102a50:	00200dac 	eoreq	r0, r0, ip, lsr #27
  102a54:	00200d4c 	eoreq	r0, r0, ip, asr #26
  102a58:	00200dd8 	ldreqd	r0, [r0], -r8
  102a5c:	00200d54 	eoreq	r0, r0, r4, asr sp
  102a60:	00200da8 	eoreq	r0, r0, r8, lsr #27
  102a64:	00200d48 	eoreq	r0, r0, r8, asr #26

00102a68 <xTaskGetTickCount>:
  102a68:	e92d4010 	stmdb	sp!, {r4, lr}
  102a6c:	eb0004bd 	bl	103d68 <vPortEnterCritical>
  102a70:	e59f300c 	ldr	r3, [pc, #12]	; 102a84 <prog+0x2a40>
  102a74:	e5934000 	ldr	r4, [r3]
  102a78:	eb0004c5 	bl	103d94 <vPortExitCritical>
  102a7c:	e1a00004 	mov	r0, r4
  102a80:	e8bd8010 	ldmia	sp!, {r4, pc}
  102a84:	00200d44 	eoreq	r0, r0, r4, asr #26

00102a88 <uxTaskGetNumberOfTasks>:
  102a88:	e92d4010 	stmdb	sp!, {r4, lr}
  102a8c:	eb0004b5 	bl	103d68 <vPortEnterCritical>
  102a90:	e59f300c 	ldr	r3, [pc, #12]	; 102aa4 <prog+0x2a60>
  102a94:	e5934000 	ldr	r4, [r3]
  102a98:	eb0004bd 	bl	103d94 <vPortExitCritical>
  102a9c:	e1a00004 	mov	r0, r4
  102aa0:	e8bd8010 	ldmia	sp!, {r4, pc}
  102aa4:	00200d58 	eoreq	r0, r0, r8, asr sp

00102aa8 <vTaskSwitchContext>:
  102aa8:	e92d4010 	stmdb	sp!, {r4, lr}
  102aac:	e59f30ec 	ldr	r3, [pc, #236]	; 102ba0 <prog+0x2b5c>
  102ab0:	e5932000 	ldr	r2, [r3]
  102ab4:	e3520000 	cmp	r2, #0	; 0x0
  102ab8:	159f30e4 	ldrne	r3, [pc, #228]	; 102ba4 <prog+0x2b60>
  102abc:	13a02001 	movne	r2, #1	; 0x1
  102ac0:	15832000 	strne	r2, [r3]
  102ac4:	18bd8010 	ldmneia	sp!, {r4, pc}
  102ac8:	e59fe0d8 	ldr	lr, [pc, #216]	; 102ba8 <prog+0x2b64>
  102acc:	e59e3000 	ldr	r3, [lr]
  102ad0:	e59f40d4 	ldr	r4, [pc, #212]	; 102bac <prog+0x2b68>
  102ad4:	e0833103 	add	r3, r3, r3, lsl #2
  102ad8:	e7942103 	ldr	r2, [r4, r3, lsl #2]
  102adc:	e3520000 	cmp	r2, #0	; 0x0
  102ae0:	1a000007 	bne	102b04 <vTaskSwitchContext+0x5c>
  102ae4:	e59e3000 	ldr	r3, [lr]
  102ae8:	e2433001 	sub	r3, r3, #1	; 0x1
  102aec:	e58e3000 	str	r3, [lr]
  102af0:	e59e2000 	ldr	r2, [lr]
  102af4:	e0822102 	add	r2, r2, r2, lsl #2
  102af8:	e7943102 	ldr	r3, [r4, r2, lsl #2]
  102afc:	e3530000 	cmp	r3, #0	; 0x0
  102b00:	0afffff7 	beq	102ae4 <vTaskSwitchContext+0x3c>
  102b04:	e59e1000 	ldr	r1, [lr]
  102b08:	e59e3000 	ldr	r3, [lr]
  102b0c:	e0833103 	add	r3, r3, r3, lsl #2
  102b10:	e0843103 	add	r3, r4, r3, lsl #2
  102b14:	e5930004 	ldr	r0, [r3, #4]
  102b18:	e0811101 	add	r1, r1, r1, lsl #2
  102b1c:	e590c004 	ldr	ip, [r0, #4]
  102b20:	e59e2000 	ldr	r2, [lr]
  102b24:	e0841101 	add	r1, r4, r1, lsl #2
  102b28:	e59e3000 	ldr	r3, [lr]
  102b2c:	e581c004 	str	ip, [r1, #4]
  102b30:	e0822102 	add	r2, r2, r2, lsl #2
  102b34:	e0833103 	add	r3, r3, r3, lsl #2
  102b38:	e0842102 	add	r2, r4, r2, lsl #2
  102b3c:	e0843103 	add	r3, r4, r3, lsl #2
  102b40:	e5921004 	ldr	r1, [r2, #4]
  102b44:	e2833008 	add	r3, r3, #8	; 0x8
  102b48:	e1510003 	cmp	r1, r3
  102b4c:	0a000009 	beq	102b78 <vTaskSwitchContext+0xd0>
  102b50:	e59f3050 	ldr	r3, [pc, #80]	; 102ba8 <prog+0x2b64>
  102b54:	e5932000 	ldr	r2, [r3]
  102b58:	e59f304c 	ldr	r3, [pc, #76]	; 102bac <prog+0x2b68>
  102b5c:	e0822102 	add	r2, r2, r2, lsl #2
  102b60:	e0833102 	add	r3, r3, r2, lsl #2
  102b64:	e5931004 	ldr	r1, [r3, #4]
  102b68:	e59f3040 	ldr	r3, [pc, #64]	; 102bb0 <prog+0x2b6c>
  102b6c:	e591200c 	ldr	r2, [r1, #12]
  102b70:	e5832000 	str	r2, [r3]
  102b74:	e8bd8010 	ldmia	sp!, {r4, pc}
  102b78:	e59e2000 	ldr	r2, [lr]
  102b7c:	e59e3000 	ldr	r3, [lr]
  102b80:	e0833103 	add	r3, r3, r3, lsl #2
  102b84:	e0843103 	add	r3, r4, r3, lsl #2
  102b88:	e5931004 	ldr	r1, [r3, #4]
  102b8c:	e0822102 	add	r2, r2, r2, lsl #2
  102b90:	e5913004 	ldr	r3, [r1, #4]
  102b94:	e0842102 	add	r2, r4, r2, lsl #2
  102b98:	e5823004 	str	r3, [r2, #4]
  102b9c:	eaffffeb 	b	102b50 <vTaskSwitchContext+0xa8>
  102ba0:	00200d50 	eoreq	r0, r0, r0, asr sp
  102ba4:	00200d40 	eoreq	r0, r0, r0, asr #26
  102ba8:	00200d4c 	eoreq	r0, r0, ip, asr #26
  102bac:	00200dd8 	ldreqd	r0, [r0], -r8
  102bb0:	00200d3c 	eoreq	r0, r0, ip, lsr sp

00102bb4 <vTaskPlaceOnEventList>:
  102bb4:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  102bb8:	e59f406c 	ldr	r4, [pc, #108]	; 102c2c <prog+0x2be8>
  102bbc:	e5943000 	ldr	r3, [r4]
  102bc0:	e1a05001 	mov	r5, r1
  102bc4:	e2831018 	add	r1, r3, #24	; 0x18
  102bc8:	ebfffcab 	bl	101e7c <vListInsert>
  102bcc:	e5940000 	ldr	r0, [r4]
  102bd0:	e2800004 	add	r0, r0, #4	; 0x4
  102bd4:	ebfffcc7 	bl	101ef8 <vListRemove>
  102bd8:	e3750001 	cmn	r5, #1	; 0x1
  102bdc:	e59f004c 	ldr	r0, [pc, #76]	; 102c30 <prog+0x2bec>
  102be0:	e59f204c 	ldr	r2, [pc, #76]	; 102c34 <prog+0x2bf0>
  102be4:	0a00000c 	beq	102c1c <vTaskPlaceOnEventList+0x68>
  102be8:	e5923000 	ldr	r3, [r2]
  102bec:	e5941000 	ldr	r1, [r4]
  102bf0:	e5922000 	ldr	r2, [r2]
  102bf4:	e0853003 	add	r3, r5, r3
  102bf8:	e1530002 	cmp	r3, r2
  102bfc:	e5813004 	str	r3, [r1, #4]
  102c00:	359f3030 	ldrcc	r3, [pc, #48]	; 102c38 <prog+0x2bf4>
  102c04:	259f3030 	ldrcs	r3, [pc, #48]	; 102c3c <prog+0x2bf8>
  102c08:	e5930000 	ldr	r0, [r3]
  102c0c:	e5941000 	ldr	r1, [r4]
  102c10:	e2811004 	add	r1, r1, #4	; 0x4
  102c14:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  102c18:	eafffc97 	b	101e7c <vListInsert>
  102c1c:	e5941000 	ldr	r1, [r4]
  102c20:	e2811004 	add	r1, r1, #4	; 0x4
  102c24:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  102c28:	eafffc86 	b	101e48 <vListInsertEnd>
  102c2c:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  102c30:	00200d6c 	eoreq	r0, r0, ip, ror #26
  102c34:	00200d44 	eoreq	r0, r0, r4, asr #26
  102c38:	00200da8 	eoreq	r0, r0, r8, lsr #27
  102c3c:	00200dac 	eoreq	r0, r0, ip, lsr #27

00102c40 <xTaskRemoveFromEventList>:
  102c40:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
  102c44:	e5903000 	ldr	r3, [r0]
  102c48:	e3530000 	cmp	r3, #0	; 0x0
  102c4c:	e1a06003 	mov	r6, r3
  102c50:	1590300c 	ldrne	r3, [r0, #12]
  102c54:	1593600c 	ldrne	r6, [r3, #12]
  102c58:	e2864018 	add	r4, r6, #24	; 0x18
  102c5c:	e1a00004 	mov	r0, r4
  102c60:	ebfffca4 	bl	101ef8 <vListRemove>
  102c64:	e59f3064 	ldr	r3, [pc, #100]	; 102cd0 <prog+0x2c8c>
  102c68:	e5932000 	ldr	r2, [r3]
  102c6c:	e2865004 	add	r5, r6, #4	; 0x4
  102c70:	e3520000 	cmp	r2, #0	; 0x0
  102c74:	e1a00005 	mov	r0, r5
  102c78:	e1a01004 	mov	r1, r4
  102c7c:	159f0050 	ldrne	r0, [pc, #80]	; 102cd4 <prog+0x2c90>
  102c80:	1a000009 	bne	102cac <xTaskRemoveFromEventList+0x6c>
  102c84:	ebfffc9b 	bl	101ef8 <vListRemove>
  102c88:	e59fe048 	ldr	lr, [pc, #72]	; 102cd8 <prog+0x2c94>
  102c8c:	e596c02c 	ldr	ip, [r6, #44]
  102c90:	e59e2000 	ldr	r2, [lr]
  102c94:	e59f0040 	ldr	r0, [pc, #64]	; 102cdc <prog+0x2c98>
  102c98:	e15c0002 	cmp	ip, r2
  102c9c:	e08c310c 	add	r3, ip, ip, lsl #2
  102ca0:	858ec000 	strhi	ip, [lr]
  102ca4:	e1a01005 	mov	r1, r5
  102ca8:	e0800103 	add	r0, r0, r3, lsl #2
  102cac:	ebfffc65 	bl	101e48 <vListInsertEnd>
  102cb0:	e59f3028 	ldr	r3, [pc, #40]	; 102ce0 <prog+0x2c9c>
  102cb4:	e5932000 	ldr	r2, [r3]
  102cb8:	e596102c 	ldr	r1, [r6, #44]
  102cbc:	e592002c 	ldr	r0, [r2, #44]
  102cc0:	e1510000 	cmp	r1, r0
  102cc4:	33a00000 	movcc	r0, #0	; 0x0
  102cc8:	23a00001 	movcs	r0, #1	; 0x1
  102ccc:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  102cd0:	00200d50 	eoreq	r0, r0, r0, asr sp
  102cd4:	00200d94 	mlaeq	r0, r4, sp, r0
  102cd8:	00200d4c 	eoreq	r0, r0, ip, asr #26
  102cdc:	00200dd8 	ldreqd	r0, [r0], -r8
  102ce0:	00200d3c 	eoreq	r0, r0, ip, lsr sp

00102ce4 <vTaskSetTimeOutState>:
  102ce4:	e59f3010 	ldr	r3, [pc, #16]	; 102cfc <prog+0x2cb8>
  102ce8:	e59f2010 	ldr	r2, [pc, #16]	; 102d00 <prog+0x2cbc>
  102cec:	e5931000 	ldr	r1, [r3]
  102cf0:	e5923000 	ldr	r3, [r2]
  102cf4:	e880000a 	stmia	r0, {r1, r3}
  102cf8:	e12fff1e 	bx	lr
  102cfc:	00200d48 	eoreq	r0, r0, r8, asr #26
  102d00:	00200d44 	eoreq	r0, r0, r4, asr #26

00102d04 <xTaskCheckForTimeOut>:
  102d04:	e92d4010 	stmdb	sp!, {r4, lr}
  102d08:	e59f307c 	ldr	r3, [pc, #124]	; 102d8c <prog+0x2d48>
  102d0c:	e5902000 	ldr	r2, [r0]
  102d10:	e593c000 	ldr	ip, [r3]
  102d14:	e152000c 	cmp	r2, ip
  102d18:	e59f4070 	ldr	r4, [pc, #112]	; 102d90 <prog+0x2d4c>
  102d1c:	e1a0e000 	mov	lr, r0
  102d20:	0a000011 	beq	102d6c <xTaskCheckForTimeOut+0x68>
  102d24:	e5902004 	ldr	r2, [r0, #4]
  102d28:	e5943000 	ldr	r3, [r4]
  102d2c:	e1520003 	cmp	r2, r3
  102d30:	9a000004 	bls	102d48 <xTaskCheckForTimeOut+0x44>
  102d34:	e5943000 	ldr	r3, [r4]
  102d38:	e591c000 	ldr	ip, [r1]
  102d3c:	e0623003 	rsb	r3, r2, r3
  102d40:	e153000c 	cmp	r3, ip
  102d44:	3a000001 	bcc	102d50 <xTaskCheckForTimeOut+0x4c>
  102d48:	e3a00001 	mov	r0, #1	; 0x1
  102d4c:	e8bd8010 	ldmia	sp!, {r4, pc}
  102d50:	e5943000 	ldr	r3, [r4]
  102d54:	e0623003 	rsb	r3, r2, r3
  102d58:	e063300c 	rsb	r3, r3, ip
  102d5c:	e5813000 	str	r3, [r1]
  102d60:	ebffffdf 	bl	102ce4 <vTaskSetTimeOutState>
  102d64:	e3a00000 	mov	r0, #0	; 0x0
  102d68:	e8bd8010 	ldmia	sp!, {r4, pc}
  102d6c:	e59f401c 	ldr	r4, [pc, #28]	; 102d90 <prog+0x2d4c>
  102d70:	e5902004 	ldr	r2, [r0, #4]
  102d74:	e5943000 	ldr	r3, [r4]
  102d78:	e591c000 	ldr	ip, [r1]
  102d7c:	e0623003 	rsb	r3, r2, r3
  102d80:	e153000c 	cmp	r3, ip
  102d84:	2affffef 	bcs	102d48 <xTaskCheckForTimeOut+0x44>
  102d88:	eafffff0 	b	102d50 <xTaskCheckForTimeOut+0x4c>
  102d8c:	00200d48 	eoreq	r0, r0, r8, asr #26
  102d90:	00200d44 	eoreq	r0, r0, r4, asr #26

00102d94 <vTaskMissedYield>:
  102d94:	e59f3008 	ldr	r3, [pc, #8]	; 102da4 <prog+0x2d60>
  102d98:	e3a02001 	mov	r2, #1	; 0x1
  102d9c:	e5832000 	str	r2, [r3]
  102da0:	e12fff1e 	bx	lr
  102da4:	00200d40 	eoreq	r0, r0, r0, asr #26

00102da8 <xTaskCreate>:
  102da8:	e92d4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
  102dac:	e1a02802 	mov	r2, r2, lsl #16
  102db0:	e1a0a000 	mov	sl, r0
  102db4:	e3a0004c 	mov	r0, #76	; 0x4c
  102db8:	e1a07001 	mov	r7, r1
  102dbc:	e1a08003 	mov	r8, r3
  102dc0:	e1a05822 	mov	r5, r2, lsr #16
  102dc4:	e28d9024 	add	r9, sp, #36	; 0x24
  102dc8:	e8990a00 	ldmia	r9, {r9, fp}
  102dcc:	eb000401 	bl	103dd8 <pvPortMalloc>
  102dd0:	e2506000 	subs	r6, r0, #0	; 0x0
  102dd4:	02400001 	subeq	r0, r0, #1	; 0x1
  102dd8:	08bd8ff0 	ldmeqia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
  102ddc:	e1a04105 	mov	r4, r5, lsl #2
  102de0:	e1a00004 	mov	r0, r4
  102de4:	eb0003fb 	bl	103dd8 <pvPortMalloc>
  102de8:	e3500000 	cmp	r0, #0	; 0x0
  102dec:	e5860030 	str	r0, [r6, #48]
  102df0:	0a000072 	beq	102fc0 <xTaskCreate+0x218>
  102df4:	e1a02004 	mov	r2, r4
  102df8:	e3a010a5 	mov	r1, #165	; 0xa5
  102dfc:	ebfff534 	bl	1002d4 <memset>
  102e00:	e1a01007 	mov	r1, r7
  102e04:	e3a02010 	mov	r2, #16	; 0x10
  102e08:	e1c654b8 	strh	r5, [r6, #72]
  102e0c:	e2860038 	add	r0, r6, #56	; 0x38
  102e10:	ebfff557 	bl	100374 <strncpy>
  102e14:	e3590004 	cmp	r9, #4	; 0x4
  102e18:	e3a03000 	mov	r3, #0	; 0x0
  102e1c:	e5c63047 	strb	r3, [r6, #71]
  102e20:	e2867004 	add	r7, r6, #4	; 0x4
  102e24:	82833004 	addhi	r3, r3, #4	; 0x4
  102e28:	91a03009 	movls	r3, r9
  102e2c:	e586302c 	str	r3, [r6, #44]
  102e30:	e1a00007 	mov	r0, r7
  102e34:	83a04001 	movhi	r4, #1	; 0x1
  102e38:	92694005 	rsbls	r4, r9, #5	; 0x5
  102e3c:	ebfffbfe 	bl	101e3c <vListInitialiseItem>
  102e40:	e2860018 	add	r0, r6, #24	; 0x18
  102e44:	ebfffbfc 	bl	101e3c <vListInitialiseItem>
  102e48:	e1d634b8 	ldrh	r3, [r6, #72]
  102e4c:	e5960030 	ldr	r0, [r6, #48]
  102e50:	e0800103 	add	r0, r0, r3, lsl #2
  102e54:	e1a0100a 	mov	r1, sl
  102e58:	e1a02008 	mov	r2, r8
  102e5c:	e5864018 	str	r4, [r6, #24]
  102e60:	e5866010 	str	r6, [r6, #16]
  102e64:	e5866024 	str	r6, [r6, #36]
  102e68:	e2400004 	sub	r0, r0, #4	; 0x4
  102e6c:	eb0002ec 	bl	103a24 <pxPortInitialiseStack>
  102e70:	e5860000 	str	r0, [r6]
  102e74:	eb0003bb 	bl	103d68 <vPortEnterCritical>
  102e78:	e59f2150 	ldr	r2, [pc, #336]	; 102fd0 <prog+0x2f8c>
  102e7c:	e5923000 	ldr	r3, [r2]
  102e80:	e2833001 	add	r3, r3, #1	; 0x1
  102e84:	e5823000 	str	r3, [r2]
  102e88:	e5921000 	ldr	r1, [r2]
  102e8c:	e3510001 	cmp	r1, #1	; 0x1
  102e90:	0a00002e 	beq	102f50 <xTaskCreate+0x1a8>
  102e94:	e59f8138 	ldr	r8, [pc, #312]	; 102fd4 <prog+0x2f90>
  102e98:	e5983000 	ldr	r3, [r8]
  102e9c:	e3530000 	cmp	r3, #0	; 0x0
  102ea0:	0a000022 	beq	102f30 <xTaskCreate+0x188>
  102ea4:	e59fa12c 	ldr	sl, [pc, #300]	; 102fd8 <prog+0x2f94>
  102ea8:	e59f212c 	ldr	r2, [pc, #300]	; 102fdc <prog+0x2f98>
  102eac:	e59f012c 	ldr	r0, [pc, #300]	; 102fe0 <prog+0x2f9c>
  102eb0:	e596c02c 	ldr	ip, [r6, #44]
  102eb4:	e5923000 	ldr	r3, [r2]
  102eb8:	e59f4124 	ldr	r4, [pc, #292]	; 102fe4 <prog+0x2fa0>
  102ebc:	e5901000 	ldr	r1, [r0]
  102ec0:	e15c0003 	cmp	ip, r3
  102ec4:	e5943000 	ldr	r3, [r4]
  102ec8:	8582c000 	strhi	ip, [r2]
  102ecc:	e2812001 	add	r2, r1, #1	; 0x1
  102ed0:	e15c0003 	cmp	ip, r3
  102ed4:	e5861034 	str	r1, [r6, #52]
  102ed8:	e5802000 	str	r2, [r0]
  102edc:	e08c010c 	add	r0, ip, ip, lsl #2
  102ee0:	8584c000 	strhi	ip, [r4]
  102ee4:	e08a0100 	add	r0, sl, r0, lsl #2
  102ee8:	e1a01007 	mov	r1, r7
  102eec:	ebfffbd5 	bl	101e48 <vListInsertEnd>
  102ef0:	eb0003a7 	bl	103d94 <vPortExitCritical>
  102ef4:	e5983000 	ldr	r3, [r8]
  102ef8:	e35b0000 	cmp	fp, #0	; 0x0
  102efc:	158b6000 	strne	r6, [fp]
  102f00:	e3530000 	cmp	r3, #0	; 0x0
  102f04:	0a000007 	beq	102f28 <xTaskCreate+0x180>
  102f08:	e59f30d8 	ldr	r3, [pc, #216]	; 102fe8 <prog+0x2fa4>
  102f0c:	e5932000 	ldr	r2, [r3]
  102f10:	e592102c 	ldr	r1, [r2, #44]
  102f14:	e1510009 	cmp	r1, r9
  102f18:	2a000002 	bcs	102f28 <xTaskCreate+0x180>
  102f1c:	ef000000 	swi	0x00000000
  102f20:	e3a00001 	mov	r0, #1	; 0x1
  102f24:	e8bd8ff0 	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
  102f28:	e3a00001 	mov	r0, #1	; 0x1
  102f2c:	e8bd8ff0 	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
  102f30:	e59f10b0 	ldr	r1, [pc, #176]	; 102fe8 <prog+0x2fa4>
  102f34:	e5913000 	ldr	r3, [r1]
  102f38:	e593202c 	ldr	r2, [r3, #44]
  102f3c:	e1590002 	cmp	r9, r2
  102f40:	259fa090 	ldrcs	sl, [pc, #144]	; 102fd8 <prog+0x2f94>
  102f44:	25816000 	strcs	r6, [r1]
  102f48:	2affffd6 	bcs	102ea8 <xTaskCreate+0x100>
  102f4c:	eaffffd4 	b	102ea4 <xTaskCreate+0xfc>
  102f50:	e59f3090 	ldr	r3, [pc, #144]	; 102fe8 <prog+0x2fa4>
  102f54:	e59fa07c 	ldr	sl, [pc, #124]	; 102fd8 <prog+0x2f94>
  102f58:	e5836000 	str	r6, [r3]
  102f5c:	e1a0400a 	mov	r4, sl
  102f60:	e28a5064 	add	r5, sl, #100	; 0x64
  102f64:	e1a00004 	mov	r0, r4
  102f68:	e2844014 	add	r4, r4, #20	; 0x14
  102f6c:	ebfffba9 	bl	101e18 <vListInitialise>
  102f70:	e1550004 	cmp	r5, r4
  102f74:	1afffffa 	bne	102f64 <xTaskCreate+0x1bc>
  102f78:	e59f406c 	ldr	r4, [pc, #108]	; 102fec <prog+0x2fa8>
  102f7c:	e59f506c 	ldr	r5, [pc, #108]	; 102ff0 <prog+0x2fac>
  102f80:	e1a00004 	mov	r0, r4
  102f84:	ebfffba3 	bl	101e18 <vListInitialise>
  102f88:	e1a00005 	mov	r0, r5
  102f8c:	ebfffba1 	bl	101e18 <vListInitialise>
  102f90:	e59f005c 	ldr	r0, [pc, #92]	; 102ff4 <prog+0x2fb0>
  102f94:	ebfffb9f 	bl	101e18 <vListInitialise>
  102f98:	e59f0058 	ldr	r0, [pc, #88]	; 102ff8 <prog+0x2fb4>
  102f9c:	ebfffb9d 	bl	101e18 <vListInitialise>
  102fa0:	e59f0054 	ldr	r0, [pc, #84]	; 102ffc <prog+0x2fb8>
  102fa4:	ebfffb9b 	bl	101e18 <vListInitialise>
  102fa8:	e59f8024 	ldr	r8, [pc, #36]	; 102fd4 <prog+0x2f90>
  102fac:	e59f304c 	ldr	r3, [pc, #76]	; 103000 <prog+0x2fbc>
  102fb0:	e59f204c 	ldr	r2, [pc, #76]	; 103004 <prog+0x2fc0>
  102fb4:	e5834000 	str	r4, [r3]
  102fb8:	e5825000 	str	r5, [r2]
  102fbc:	eaffffb9 	b	102ea8 <xTaskCreate+0x100>
  102fc0:	e1a00006 	mov	r0, r6
  102fc4:	eb0003cd 	bl	103f00 <vPortFree>
  102fc8:	e3e00000 	mvn	r0, #0	; 0x0
  102fcc:	e8bd8ff0 	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
  102fd0:	00200d58 	eoreq	r0, r0, r8, asr sp
  102fd4:	00200d5c 	eoreq	r0, r0, ip, asr sp
  102fd8:	00200dd8 	ldreqd	r0, [r0], -r8
  102fdc:	00200d64 	eoreq	r0, r0, r4, ror #26
  102fe0:	00200d68 	eoreq	r0, r0, r8, ror #26
  102fe4:	00200d4c 	eoreq	r0, r0, ip, asr #26
  102fe8:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  102fec:	00200dc4 	eoreq	r0, r0, r4, asr #27
  102ff0:	00200db0 	streqh	r0, [r0], -r0
  102ff4:	00200d94 	mlaeq	r0, r4, sp, r0
  102ff8:	00200d80 	eoreq	r0, r0, r0, lsl #27
  102ffc:	00200d6c 	eoreq	r0, r0, ip, ror #26
  103000:	00200dac 	eoreq	r0, r0, ip, lsr #27
  103004:	00200da8 	eoreq	r0, r0, r8, lsr #27

00103008 <vTaskStartScheduler>:
  103008:	e92d4010 	stmdb	sp!, {r4, lr}
  10300c:	e3a04000 	mov	r4, #0	; 0x0
  103010:	e24dd008 	sub	sp, sp, #8	; 0x8
  103014:	e59f1054 	ldr	r1, [pc, #84]	; 103070 <prog+0x302c>
  103018:	e3a0206e 	mov	r2, #110	; 0x6e
  10301c:	e1a03004 	mov	r3, r4
  103020:	e59f004c 	ldr	r0, [pc, #76]	; 103074 <prog+0x3030>
  103024:	e58d4000 	str	r4, [sp]
  103028:	e58d4004 	str	r4, [sp, #4]
  10302c:	ebffff5d 	bl	102da8 <xTaskCreate>
  103030:	e3500001 	cmp	r0, #1	; 0x1
  103034:	0a000001 	beq	103040 <vTaskStartScheduler+0x38>
  103038:	e28dd008 	add	sp, sp, #8	; 0x8
  10303c:	e8bd8010 	ldmia	sp!, {r4, pc}
  103040:	e92d0001 	stmdb	sp!, {r0}
  103044:	e10f0000 	mrs	r0, CPSR
  103048:	e38000c0 	orr	r0, r0, #192	; 0xc0
  10304c:	e129f000 	msr	CPSR_fc, r0
  103050:	e8bd0001 	ldmia	sp!, {r0}
  103054:	e59f301c 	ldr	r3, [pc, #28]	; 103078 <prog+0x3034>
  103058:	e59f201c 	ldr	r2, [pc, #28]	; 10307c <prog+0x3038>
  10305c:	e5830000 	str	r0, [r3]
  103060:	e5824000 	str	r4, [r2]
  103064:	e28dd008 	add	sp, sp, #8	; 0x8
  103068:	e8bd4010 	ldmia	sp!, {r4, lr}
  10306c:	ea0002ac 	b	103b24 <xPortStartScheduler>
  103070:	001052bc 	ldreqh	r5, [r0], -ip
  103074:	00103318 	andeqs	r3, r0, r8, lsl r3
  103078:	00200d5c 	eoreq	r0, r0, ip, asr sp
  10307c:	00200d44 	eoreq	r0, r0, r4, asr #26

00103080 <xTaskGetCurrentTaskHandle>:
  103080:	e92d4010 	stmdb	sp!, {r4, lr}
  103084:	eb000337 	bl	103d68 <vPortEnterCritical>
  103088:	e59f300c 	ldr	r3, [pc, #12]	; 10309c <prog+0x3058>
  10308c:	e5934000 	ldr	r4, [r3]
  103090:	eb00033f 	bl	103d94 <vPortExitCritical>
  103094:	e1a00004 	mov	r0, r4
  103098:	e8bd8010 	ldmia	sp!, {r4, pc}
  10309c:	00200d3c 	eoreq	r0, r0, ip, lsr sp

001030a0 <xTaskResumeAll>:
  1030a0:	e92d4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
  1030a4:	e59f923c 	ldr	r9, [pc, #572]	; 1032e8 <prog+0x32a4>
  1030a8:	eb00032e 	bl	103d68 <vPortEnterCritical>
  1030ac:	e5993000 	ldr	r3, [r9]
  1030b0:	e2433001 	sub	r3, r3, #1	; 0x1
  1030b4:	e5893000 	str	r3, [r9]
  1030b8:	e5991000 	ldr	r1, [r9]
  1030bc:	e3510000 	cmp	r1, #0	; 0x0
  1030c0:	1a000005 	bne	1030dc <xTaskResumeAll+0x3c>
  1030c4:	e59f3220 	ldr	r3, [pc, #544]	; 1032ec <prog+0x32a8>
  1030c8:	e5932000 	ldr	r2, [r3]
  1030cc:	e3520000 	cmp	r2, #0	; 0x0
  1030d0:	159f7218 	ldrne	r7, [pc, #536]	; 1032f0 <prog+0x32ac>
  1030d4:	11a06001 	movne	r6, r1
  1030d8:	1a00001a 	bne	103148 <xTaskResumeAll+0xa8>
  1030dc:	eb00032c 	bl	103d94 <vPortExitCritical>
  1030e0:	e3a04000 	mov	r4, #0	; 0x0
  1030e4:	e1a00004 	mov	r0, r4
  1030e8:	e8bd8ff0 	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
  1030ec:	e597300c 	ldr	r3, [r7, #12]
  1030f0:	e593400c 	ldr	r4, [r3, #12]
  1030f4:	e3540000 	cmp	r4, #0	; 0x0
  1030f8:	e2840018 	add	r0, r4, #24	; 0x18
  1030fc:	e2845004 	add	r5, r4, #4	; 0x4
  103100:	0a000015 	beq	10315c <xTaskResumeAll+0xbc>
  103104:	ebfffb7b 	bl	101ef8 <vListRemove>
  103108:	e1a00005 	mov	r0, r5
  10310c:	ebfffb79 	bl	101ef8 <vListRemove>
  103110:	e594202c 	ldr	r2, [r4, #44]
  103114:	e5983000 	ldr	r3, [r8]
  103118:	e0820102 	add	r0, r2, r2, lsl #2
  10311c:	e1520003 	cmp	r2, r3
  103120:	e1a01005 	mov	r1, r5
  103124:	e08a0100 	add	r0, sl, r0, lsl #2
  103128:	85882000 	strhi	r2, [r8]
  10312c:	ebfffb45 	bl	101e48 <vListInsertEnd>
  103130:	e59f31bc 	ldr	r3, [pc, #444]	; 1032f4 <prog+0x32b0>
  103134:	e5932000 	ldr	r2, [r3]
  103138:	e594102c 	ldr	r1, [r4, #44]
  10313c:	e592302c 	ldr	r3, [r2, #44]
  103140:	e1510003 	cmp	r1, r3
  103144:	23a06001 	movcs	r6, #1	; 0x1
  103148:	e5973000 	ldr	r3, [r7]
  10314c:	e3530000 	cmp	r3, #0	; 0x0
  103150:	e59fa1a0 	ldr	sl, [pc, #416]	; 1032f8 <prog+0x32b4>
  103154:	e59f81a0 	ldr	r8, [pc, #416]	; 1032fc <prog+0x32b8>
  103158:	1affffe3 	bne	1030ec <xTaskResumeAll+0x4c>
  10315c:	e59f219c 	ldr	r2, [pc, #412]	; 103300 <prog+0x32bc>
  103160:	e5923000 	ldr	r3, [r2]
  103164:	e3530000 	cmp	r3, #0	; 0x0
  103168:	e1a07002 	mov	r7, r2
  10316c:	0a000056 	beq	1032cc <xTaskResumeAll+0x22c>
  103170:	e5923000 	ldr	r3, [r2]
  103174:	e3530000 	cmp	r3, #0	; 0x0
  103178:	0a00002e 	beq	103238 <xTaskResumeAll+0x198>
  10317c:	e5993000 	ldr	r3, [r9]
  103180:	e3530000 	cmp	r3, #0	; 0x0
  103184:	15973000 	ldrne	r3, [r7]
  103188:	12833001 	addne	r3, r3, #1	; 0x1
  10318c:	15873000 	strne	r3, [r7]
  103190:	1a000022 	bne	103220 <xTaskResumeAll+0x180>
  103194:	e59fc168 	ldr	ip, [pc, #360]	; 103304 <prog+0x32c0>
  103198:	e59c3000 	ldr	r3, [ip]
  10319c:	e2833001 	add	r3, r3, #1	; 0x1
  1031a0:	e58c3000 	str	r3, [ip]
  1031a4:	e59c2000 	ldr	r2, [ip]
  1031a8:	e3520000 	cmp	r2, #0	; 0x0
  1031ac:	e1a0b00c 	mov	fp, ip
  1031b0:	159f6150 	ldrne	r6, [pc, #336]	; 103308 <prog+0x32c4>
  1031b4:	1a000009 	bne	1031e0 <xTaskResumeAll+0x140>
  1031b8:	e59f6148 	ldr	r6, [pc, #328]	; 103308 <prog+0x32c4>
  1031bc:	e59f1148 	ldr	r1, [pc, #328]	; 10330c <prog+0x32c8>
  1031c0:	e5960000 	ldr	r0, [r6]
  1031c4:	e5913000 	ldr	r3, [r1]
  1031c8:	e59f2140 	ldr	r2, [pc, #320]	; 103310 <prog+0x32cc>
  1031cc:	e5863000 	str	r3, [r6]
  1031d0:	e5810000 	str	r0, [r1]
  1031d4:	e5923000 	ldr	r3, [r2]
  1031d8:	e2833001 	add	r3, r3, #1	; 0x1
  1031dc:	e5823000 	str	r3, [r2]
  1031e0:	e5963000 	ldr	r3, [r6]
  1031e4:	e5932000 	ldr	r2, [r3]
  1031e8:	e3520000 	cmp	r2, #0	; 0x0
  1031ec:	0a00000b 	beq	103220 <xTaskResumeAll+0x180>
  1031f0:	e59f3110 	ldr	r3, [pc, #272]	; 103308 <prog+0x32c4>
  1031f4:	e5932000 	ldr	r2, [r3]
  1031f8:	e592100c 	ldr	r1, [r2, #12]
  1031fc:	e591400c 	ldr	r4, [r1, #12]
  103200:	e3540000 	cmp	r4, #0	; 0x0
  103204:	0a000005 	beq	103220 <xTaskResumeAll+0x180>
  103208:	e59c2000 	ldr	r2, [ip]
  10320c:	e5943004 	ldr	r3, [r4, #4]
  103210:	e1530002 	cmp	r3, r2
  103214:	959f80e0 	ldrls	r8, [pc, #224]	; 1032fc <prog+0x32b8>
  103218:	959fa0d8 	ldrls	sl, [pc, #216]	; 1032f8 <prog+0x32b4>
  10321c:	9a00000d 	bls	103258 <xTaskResumeAll+0x1b8>
  103220:	e5973000 	ldr	r3, [r7]
  103224:	e2433001 	sub	r3, r3, #1	; 0x1
  103228:	e5873000 	str	r3, [r7]
  10322c:	e5972000 	ldr	r2, [r7]
  103230:	e3520000 	cmp	r2, #0	; 0x0
  103234:	1affffd0 	bne	10317c <xTaskResumeAll+0xdc>
  103238:	e59f20d4 	ldr	r2, [pc, #212]	; 103314 <prog+0x32d0>
  10323c:	e3a03000 	mov	r3, #0	; 0x0
  103240:	e5823000 	str	r3, [r2]
  103244:	ef000000 	swi	0x00000000
  103248:	eb0002d1 	bl	103d94 <vPortExitCritical>
  10324c:	e3a04001 	mov	r4, #1	; 0x1
  103250:	e1a00004 	mov	r0, r4
  103254:	e8bd8ff0 	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
  103258:	e2845004 	add	r5, r4, #4	; 0x4
  10325c:	e1a00005 	mov	r0, r5
  103260:	ebfffb24 	bl	101ef8 <vListRemove>
  103264:	e5943028 	ldr	r3, [r4, #40]
  103268:	e3530000 	cmp	r3, #0	; 0x0
  10326c:	e2840018 	add	r0, r4, #24	; 0x18
  103270:	1bfffb20 	blne	101ef8 <vListRemove>
  103274:	e594202c 	ldr	r2, [r4, #44]
  103278:	e5983000 	ldr	r3, [r8]
  10327c:	e0820102 	add	r0, r2, r2, lsl #2
  103280:	e1520003 	cmp	r2, r3
  103284:	e1a01005 	mov	r1, r5
  103288:	e08a0100 	add	r0, sl, r0, lsl #2
  10328c:	85882000 	strhi	r2, [r8]
  103290:	ebfffaec 	bl	101e48 <vListInsertEnd>
  103294:	e5963000 	ldr	r3, [r6]
  103298:	e5932000 	ldr	r2, [r3]
  10329c:	e3520000 	cmp	r2, #0	; 0x0
  1032a0:	0affffde 	beq	103220 <xTaskResumeAll+0x180>
  1032a4:	e5963000 	ldr	r3, [r6]
  1032a8:	e593200c 	ldr	r2, [r3, #12]
  1032ac:	e592400c 	ldr	r4, [r2, #12]
  1032b0:	e3540000 	cmp	r4, #0	; 0x0
  1032b4:	0affffd9 	beq	103220 <xTaskResumeAll+0x180>
  1032b8:	e59b2000 	ldr	r2, [fp]
  1032bc:	e5943004 	ldr	r3, [r4, #4]
  1032c0:	e1530002 	cmp	r3, r2
  1032c4:	9affffe3 	bls	103258 <xTaskResumeAll+0x1b8>
  1032c8:	eaffffd4 	b	103220 <xTaskResumeAll+0x180>
  1032cc:	e3560001 	cmp	r6, #1	; 0x1
  1032d0:	0affffd8 	beq	103238 <xTaskResumeAll+0x198>
  1032d4:	e59f2038 	ldr	r2, [pc, #56]	; 103314 <prog+0x32d0>
  1032d8:	e5923000 	ldr	r3, [r2]
  1032dc:	e3530001 	cmp	r3, #1	; 0x1
  1032e0:	1affff7d 	bne	1030dc <xTaskResumeAll+0x3c>
  1032e4:	eaffffd4 	b	10323c <xTaskResumeAll+0x19c>
  1032e8:	00200d50 	eoreq	r0, r0, r0, asr sp
  1032ec:	00200d58 	eoreq	r0, r0, r8, asr sp
  1032f0:	00200d94 	mlaeq	r0, r4, sp, r0
  1032f4:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  1032f8:	00200dd8 	ldreqd	r0, [r0], -r8
  1032fc:	00200d4c 	eoreq	r0, r0, ip, asr #26
  103300:	00200d54 	eoreq	r0, r0, r4, asr sp
  103304:	00200d44 	eoreq	r0, r0, r4, asr #26
  103308:	00200dac 	eoreq	r0, r0, ip, lsr #27
  10330c:	00200da8 	eoreq	r0, r0, r8, lsr #27
  103310:	00200d48 	eoreq	r0, r0, r8, asr #26
  103314:	00200d40 	eoreq	r0, r0, r0, asr #26

00103318 <prvIdleTask>:
  103318:	e92d41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
  10331c:	e59f509c 	ldr	r5, [pc, #156]	; 1033c0 <prog+0x337c>
  103320:	e5953000 	ldr	r3, [r5]
  103324:	e3530000 	cmp	r3, #0	; 0x0
  103328:	e59f7094 	ldr	r7, [pc, #148]	; 1033c4 <prog+0x3380>
  10332c:	e59f8094 	ldr	r8, [pc, #148]	; 1033c8 <prog+0x3384>
  103330:	e59f6094 	ldr	r6, [pc, #148]	; 1033cc <prog+0x3388>
  103334:	1a000007 	bne	103358 <prvIdleTask+0x40>
  103338:	e5963000 	ldr	r3, [r6]
  10333c:	e3530001 	cmp	r3, #1	; 0x1
  103340:	9a000000 	bls	103348 <prvIdleTask+0x30>
  103344:	ef000000 	swi	0x00000000
  103348:	ebfff45e 	bl	1004c8 <vApplicationIdleHook>
  10334c:	e5953000 	ldr	r3, [r5]
  103350:	e3530000 	cmp	r3, #0	; 0x0
  103354:	0afffff7 	beq	103338 <prvIdleTask+0x20>
  103358:	ebfffc9d 	bl	1025d4 <vTaskSuspendAll>
  10335c:	e5974000 	ldr	r4, [r7]
  103360:	ebffff4e 	bl	1030a0 <xTaskResumeAll>
  103364:	e3540000 	cmp	r4, #0	; 0x0
  103368:	0afffff2 	beq	103338 <prvIdleTask+0x20>
  10336c:	eb00027d 	bl	103d68 <vPortEnterCritical>
  103370:	e5973000 	ldr	r3, [r7]
  103374:	e3530000 	cmp	r3, #0	; 0x0
  103378:	e1a04003 	mov	r4, r3
  10337c:	159f3040 	ldrne	r3, [pc, #64]	; 1033c4 <prog+0x3380>
  103380:	1593200c 	ldrne	r2, [r3, #12]
  103384:	1592400c 	ldrne	r4, [r2, #12]
  103388:	e2840004 	add	r0, r4, #4	; 0x4
  10338c:	ebfffad9 	bl	101ef8 <vListRemove>
  103390:	e5983000 	ldr	r3, [r8]
  103394:	e2433001 	sub	r3, r3, #1	; 0x1
  103398:	e5883000 	str	r3, [r8]
  10339c:	e5952000 	ldr	r2, [r5]
  1033a0:	e2422001 	sub	r2, r2, #1	; 0x1
  1033a4:	e5852000 	str	r2, [r5]
  1033a8:	eb000279 	bl	103d94 <vPortExitCritical>
  1033ac:	e5940030 	ldr	r0, [r4, #48]
  1033b0:	eb0002d2 	bl	103f00 <vPortFree>
  1033b4:	e1a00004 	mov	r0, r4
  1033b8:	eb0002d0 	bl	103f00 <vPortFree>
  1033bc:	eaffffdd 	b	103338 <prvIdleTask+0x20>
  1033c0:	00200d60 	eoreq	r0, r0, r0, ror #26
  1033c4:	00200d80 	eoreq	r0, r0, r0, lsl #27
  1033c8:	00200d58 	eoreq	r0, r0, r8, asr sp
  1033cc:	00200dd8 	ldreqd	r0, [r0], -r8

001033d0 <vTaskDelay>:
  1033d0:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
  1033d4:	e2505000 	subs	r5, r0, #0	; 0x0
  1033d8:	e59f6084 	ldr	r6, [pc, #132]	; 103464 <prog+0x3420>
  1033dc:	e59f7084 	ldr	r7, [pc, #132]	; 103468 <prog+0x3424>
  1033e0:	1a000001 	bne	1033ec <vTaskDelay+0x1c>
  1033e4:	ef000000 	swi	0x00000000
  1033e8:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
  1033ec:	ebfffc78 	bl	1025d4 <vTaskSuspendAll>
  1033f0:	e5974000 	ldr	r4, [r7]
  1033f4:	e5960000 	ldr	r0, [r6]
  1033f8:	e2800004 	add	r0, r0, #4	; 0x4
  1033fc:	ebfffabd 	bl	101ef8 <vListRemove>
  103400:	e5962000 	ldr	r2, [r6]
  103404:	e5973000 	ldr	r3, [r7]
  103408:	e0854004 	add	r4, r5, r4
  10340c:	e1540003 	cmp	r4, r3
  103410:	e5824004 	str	r4, [r2, #4]
  103414:	2a000009 	bcs	103440 <vTaskDelay+0x70>
  103418:	e59f304c 	ldr	r3, [pc, #76]	; 10346c <prog+0x3428>
  10341c:	e5930000 	ldr	r0, [r3]
  103420:	e5961000 	ldr	r1, [r6]
  103424:	e2811004 	add	r1, r1, #4	; 0x4
  103428:	ebfffa93 	bl	101e7c <vListInsert>
  10342c:	ebffff1b 	bl	1030a0 <xTaskResumeAll>
  103430:	e3500000 	cmp	r0, #0	; 0x0
  103434:	18bd80f0 	ldmneia	sp!, {r4, r5, r6, r7, pc}
  103438:	ef000000 	swi	0x00000000
  10343c:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
  103440:	e59f3028 	ldr	r3, [pc, #40]	; 103470 <prog+0x342c>
  103444:	e5930000 	ldr	r0, [r3]
  103448:	e5961000 	ldr	r1, [r6]
  10344c:	e2811004 	add	r1, r1, #4	; 0x4
  103450:	ebfffa89 	bl	101e7c <vListInsert>
  103454:	ebffff11 	bl	1030a0 <xTaskResumeAll>
  103458:	e3500000 	cmp	r0, #0	; 0x0
  10345c:	0afffff5 	beq	103438 <vTaskDelay+0x68>
  103460:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
  103464:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  103468:	00200d44 	eoreq	r0, r0, r4, asr #26
  10346c:	00200da8 	eoreq	r0, r0, r8, lsr #27
  103470:	00200dac 	eoreq	r0, r0, ip, lsr #27

00103474 <vTaskDelayUntil>:
  103474:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
  103478:	e59f60d8 	ldr	r6, [pc, #216]	; 103558 <prog+0x3514>
  10347c:	e1a05000 	mov	r5, r0
  103480:	e1a04001 	mov	r4, r1
  103484:	ebfffc52 	bl	1025d4 <vTaskSuspendAll>
  103488:	e5952000 	ldr	r2, [r5]
  10348c:	e5963000 	ldr	r3, [r6]
  103490:	e1520003 	cmp	r2, r3
  103494:	e0824004 	add	r4, r2, r4
  103498:	9a000017 	bls	1034fc <vTaskDelayUntil+0x88>
  10349c:	e1520004 	cmp	r2, r4
  1034a0:	8a000017 	bhi	103504 <vTaskDelayUntil+0x90>
  1034a4:	e3a03000 	mov	r3, #0	; 0x0
  1034a8:	e3530000 	cmp	r3, #0	; 0x0
  1034ac:	e5854000 	str	r4, [r5]
  1034b0:	0a00001a 	beq	103520 <vTaskDelayUntil+0xac>
  1034b4:	e59f50a0 	ldr	r5, [pc, #160]	; 10355c <prog+0x3518>
  1034b8:	e5950000 	ldr	r0, [r5]
  1034bc:	e2800004 	add	r0, r0, #4	; 0x4
  1034c0:	ebfffa8c 	bl	101ef8 <vListRemove>
  1034c4:	e5952000 	ldr	r2, [r5]
  1034c8:	e5963000 	ldr	r3, [r6]
  1034cc:	e1540003 	cmp	r4, r3
  1034d0:	e5824004 	str	r4, [r2, #4]
  1034d4:	3a000016 	bcc	103534 <vTaskDelayUntil+0xc0>
  1034d8:	e59f3080 	ldr	r3, [pc, #128]	; 103560 <prog+0x351c>
  1034dc:	e5930000 	ldr	r0, [r3]
  1034e0:	e5951000 	ldr	r1, [r5]
  1034e4:	e2811004 	add	r1, r1, #4	; 0x4
  1034e8:	ebfffa63 	bl	101e7c <vListInsert>
  1034ec:	ebfffeeb 	bl	1030a0 <xTaskResumeAll>
  1034f0:	e3500000 	cmp	r0, #0	; 0x0
  1034f4:	0a00000c 	beq	10352c <vTaskDelayUntil+0xb8>
  1034f8:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  1034fc:	e1520004 	cmp	r2, r4
  103500:	8a000002 	bhi	103510 <vTaskDelayUntil+0x9c>
  103504:	e5963000 	ldr	r3, [r6]
  103508:	e1540003 	cmp	r4, r3
  10350c:	9affffe4 	bls	1034a4 <vTaskDelayUntil+0x30>
  103510:	e3a03001 	mov	r3, #1	; 0x1
  103514:	e3530000 	cmp	r3, #0	; 0x0
  103518:	e5854000 	str	r4, [r5]
  10351c:	1affffe4 	bne	1034b4 <vTaskDelayUntil+0x40>
  103520:	ebfffede 	bl	1030a0 <xTaskResumeAll>
  103524:	e3500000 	cmp	r0, #0	; 0x0
  103528:	18bd8070 	ldmneia	sp!, {r4, r5, r6, pc}
  10352c:	ef000000 	swi	0x00000000
  103530:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  103534:	e59f3028 	ldr	r3, [pc, #40]	; 103564 <prog+0x3520>
  103538:	e5930000 	ldr	r0, [r3]
  10353c:	e5951000 	ldr	r1, [r5]
  103540:	e2811004 	add	r1, r1, #4	; 0x4
  103544:	ebfffa4c 	bl	101e7c <vListInsert>
  103548:	ebfffed4 	bl	1030a0 <xTaskResumeAll>
  10354c:	e3500000 	cmp	r0, #0	; 0x0
  103550:	0afffff5 	beq	10352c <vTaskDelayUntil+0xb8>
  103554:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  103558:	00200d44 	eoreq	r0, r0, r4, asr #26
  10355c:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  103560:	00200dac 	eoreq	r0, r0, ip, lsr #27
  103564:	00200da8 	eoreq	r0, r0, r8, lsr #27

00103568 <AT91F_AIC_ConfigureIt>:
  103568:	e3a0c001 	mov	ip, #1	; 0x1
  10356c:	e1a0c01c 	mov	ip, ip, lsl r0
  103570:	e92d4010 	stmdb	sp!, {r4, lr}
  103574:	e1822001 	orr	r2, r2, r1
  103578:	e1a0e100 	mov	lr, r0, lsl #2
  10357c:	e3a01102 	mov	r1, #-2147483648	; 0x80000000
  103580:	e1a019c1 	mov	r1, r1, asr #19
  103584:	e1a04000 	mov	r4, r0
  103588:	e51e0f80 	ldr	r0, [lr, #-3968]
  10358c:	e1a00003 	mov	r0, r3
  103590:	e581c124 	str	ip, [r1, #292]
  103594:	e50e3f80 	str	r3, [lr, #-3968]
  103598:	e7812104 	str	r2, [r1, r4, lsl #2]
  10359c:	e581c128 	str	ip, [r1, #296]
  1035a0:	e8bd8010 	ldmia	sp!, {r4, pc}

001035a4 <AT91F_AIC_SetExceptionVector>:
  1035a4:	e3e0356b 	mvn	r3, #448790528	; 0x1ac00000
  1035a8:	e2433602 	sub	r3, r3, #2097152	; 0x200000
  1035ac:	e24330df 	sub	r3, r3, #223	; 0xdf
  1035b0:	e1510003 	cmp	r1, r3
  1035b4:	e0603001 	rsb	r3, r0, r1
  1035b8:	e2433008 	sub	r3, r3, #8	; 0x8
  1035bc:	e1a03123 	mov	r3, r3, lsr #2
  1035c0:	e5902000 	ldr	r2, [r0]
  1035c4:	e3c334ff 	bic	r3, r3, #-16777216	; 0xff000000
  1035c8:	e38334ea 	orr	r3, r3, #-369098752	; 0xea000000
  1035cc:	05801000 	streq	r1, [r0]
  1035d0:	15803000 	strne	r3, [r0]
  1035d4:	e1a00002 	mov	r0, r2
  1035d8:	e12fff1e 	bx	lr

001035dc <AT91F_AIC_Open>:
  1035dc:	e92d47f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
  1035e0:	e3a05102 	mov	r5, #-2147483648	; 0x80000000
  1035e4:	e1a08000 	mov	r8, r0
  1035e8:	e1a0a001 	mov	sl, r1
  1035ec:	e1a06002 	mov	r6, r2
  1035f0:	e1a09003 	mov	r9, r3
  1035f4:	e1a059c5 	mov	r5, r5, asr #19
  1035f8:	e3a04000 	mov	r4, #0	; 0x0
  1035fc:	e3a07001 	mov	r7, #1	; 0x1
  103600:	e1a03417 	mov	r3, r7, lsl r4
  103604:	e1a00004 	mov	r0, r4
  103608:	e5853124 	str	r3, [r5, #292]
  10360c:	e2844001 	add	r4, r4, #1	; 0x1
  103610:	e5853128 	str	r3, [r5, #296]
  103614:	e3a01000 	mov	r1, #0	; 0x0
  103618:	e3a02040 	mov	r2, #64	; 0x40
  10361c:	e1a03006 	mov	r3, r6
  103620:	ebffffd0 	bl	103568 <AT91F_AIC_ConfigureIt>
  103624:	e3540020 	cmp	r4, #32	; 0x20
  103628:	1afffff4 	bne	103600 <AT91F_AIC_Open+0x24>
  10362c:	e1a01008 	mov	r1, r8
  103630:	e3a00018 	mov	r0, #24	; 0x18
  103634:	ebffffda 	bl	1035a4 <AT91F_AIC_SetExceptionVector>
  103638:	e1a0100a 	mov	r1, sl
  10363c:	e3a0001c 	mov	r0, #28	; 0x1c
  103640:	ebffffd7 	bl	1035a4 <AT91F_AIC_SetExceptionVector>
  103644:	e5859134 	str	r9, [r5, #308]
  103648:	e59d3020 	ldr	r3, [sp, #32]
  10364c:	e5853138 	str	r3, [r5, #312]
  103650:	e8bd87f0 	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}

00103654 <AT91F_RTTReadValue>:
  103654:	e24dd008 	sub	sp, sp, #8	; 0x8
  103658:	e5903008 	ldr	r3, [r0, #8]
  10365c:	e58d3004 	str	r3, [sp, #4]
  103660:	e5902008 	ldr	r2, [r0, #8]
  103664:	e58d2000 	str	r2, [sp]
  103668:	e59d1004 	ldr	r1, [sp, #4]
  10366c:	e59d3000 	ldr	r3, [sp]
  103670:	e1510003 	cmp	r1, r3
  103674:	1afffff7 	bne	103658 <AT91F_RTTReadValue+0x4>
  103678:	e59d0004 	ldr	r0, [sp, #4]
  10367c:	e28dd008 	add	sp, sp, #8	; 0x8
  103680:	e12fff1e 	bx	lr

00103684 <AT91F_ADC_CfgTimings>:
  103684:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
  103688:	e1a06000 	mov	r6, r0
  10368c:	e1a00001 	mov	r0, r1
  103690:	e1a01082 	mov	r1, r2, lsl #1
  103694:	e1a04002 	mov	r4, r2
  103698:	e1a05003 	mov	r5, r3
  10369c:	ebfff29c 	bl	100114 <__udivsi3>
  1036a0:	e59d2010 	ldr	r2, [sp, #16]
  1036a4:	e00c0492 	mul	ip, r2, r4
  1036a8:	e59f1040 	ldr	r1, [pc, #64]	; 1036f0 <prog+0x36ac>
  1036ac:	e0030495 	mul	r3, r5, r4
  1036b0:	e082ec91 	umull	lr, r2, r1, ip
  1036b4:	e1a031a3 	mov	r3, r3, lsr #3
  1036b8:	e2400001 	sub	r0, r0, #1	; 0x1
  1036bc:	e2433001 	sub	r3, r3, #1	; 0x1
  1036c0:	e1a02322 	mov	r2, r2, lsr #6
  1036c4:	e1a00400 	mov	r0, r0, lsl #8
  1036c8:	e1a03803 	mov	r3, r3, lsl #16
  1036cc:	e2422001 	sub	r2, r2, #1	; 0x1
  1036d0:	e2000c3f 	and	r0, r0, #16128	; 0x3f00
  1036d4:	e203381f 	and	r3, r3, #2031616	; 0x1f0000
  1036d8:	e1a02c02 	mov	r2, r2, lsl #24
  1036dc:	e1800003 	orr	r0, r0, r3
  1036e0:	e202240f 	and	r2, r2, #251658240	; 0xf000000
  1036e4:	e1800002 	orr	r0, r0, r2
  1036e8:	e5860004 	str	r0, [r6, #4]
  1036ec:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
  1036f0:	10624dd3 	ldrned	r4, [r2], #-211

001036f4 <AT91F_SSC_SetBaudrate>:
  1036f4:	e3520000 	cmp	r2, #0	; 0x0
  1036f8:	e0811101 	add	r1, r1, r1, lsl #2
  1036fc:	e92d4010 	stmdb	sp!, {r4, lr}
  103700:	e1a03002 	mov	r3, r2
  103704:	e1a04000 	mov	r4, r0
  103708:	e1a00081 	mov	r0, r1, lsl #1
  10370c:	e1a01082 	mov	r1, r2, lsl #1
  103710:	0a000008 	beq	103738 <AT91F_SSC_SetBaudrate+0x44>
  103714:	ebfff27e 	bl	100114 <__udivsi3>
  103718:	e59f3020 	ldr	r3, [pc, #32]	; 103740 <prog+0x36fc>
  10371c:	e0821093 	umull	r1, r2, r3, r0
  103720:	e1a021a2 	mov	r2, r2, lsr #3
  103724:	e0823102 	add	r3, r2, r2, lsl #2
  103728:	e0400083 	sub	r0, r0, r3, lsl #1
  10372c:	e3500004 	cmp	r0, #4	; 0x4
  103730:	e2823001 	add	r3, r2, #1	; 0x1
  103734:	91a03002 	movls	r3, r2
  103738:	e5843004 	str	r3, [r4, #4]
  10373c:	e8bd8010 	ldmia	sp!, {r4, pc}
  103740:	cccccccd 	stcgtl	12, cr12, [ip], {205}

00103744 <AT91F_PDC_SendFrame>:
  103744:	e1a0c000 	mov	ip, r0
  103748:	e590000c 	ldr	r0, [r0, #12]
  10374c:	e3500000 	cmp	r0, #0	; 0x0
  103750:	e3a00002 	mov	r0, #2	; 0x2
  103754:	1a000005 	bne	103770 <AT91F_PDC_SendFrame+0x2c>
  103758:	e58c1008 	str	r1, [ip, #8]
  10375c:	e58c200c 	str	r2, [ip, #12]
  103760:	e58c3018 	str	r3, [ip, #24]
  103764:	e59d3000 	ldr	r3, [sp]
  103768:	e58c301c 	str	r3, [ip, #28]
  10376c:	e12fff1e 	bx	lr
  103770:	e59c301c 	ldr	r3, [ip, #28]
  103774:	e3530000 	cmp	r3, #0	; 0x0
  103778:	e3a00000 	mov	r0, #0	; 0x0
  10377c:	03a00001 	moveq	r0, #1	; 0x1
  103780:	058c1018 	streq	r1, [ip, #24]
  103784:	058c201c 	streq	r2, [ip, #28]
  103788:	e12fff1e 	bx	lr

0010378c <AT91F_PDC_ReceiveFrame>:
  10378c:	e1a0c000 	mov	ip, r0
  103790:	e5900004 	ldr	r0, [r0, #4]
  103794:	e3500000 	cmp	r0, #0	; 0x0
  103798:	e3a00002 	mov	r0, #2	; 0x2
  10379c:	1a000005 	bne	1037b8 <AT91F_PDC_ReceiveFrame+0x2c>
  1037a0:	e58c1000 	str	r1, [ip]
  1037a4:	e58c2004 	str	r2, [ip, #4]
  1037a8:	e58c3010 	str	r3, [ip, #16]
  1037ac:	e59d3000 	ldr	r3, [sp]
  1037b0:	e58c3014 	str	r3, [ip, #20]
  1037b4:	e12fff1e 	bx	lr
  1037b8:	e59c3014 	ldr	r3, [ip, #20]
  1037bc:	e3530000 	cmp	r3, #0	; 0x0
  1037c0:	e3a00000 	mov	r0, #0	; 0x0
  1037c4:	03a00001 	moveq	r0, #1	; 0x1
  1037c8:	058c1010 	streq	r1, [ip, #16]
  1037cc:	058c2014 	streq	r2, [ip, #20]
  1037d0:	e12fff1e 	bx	lr

001037d4 <AT91F_PDC_Close>:
  1037d4:	e3a03000 	mov	r3, #0	; 0x0
  1037d8:	e3a02002 	mov	r2, #2	; 0x2
  1037dc:	e3a01c02 	mov	r1, #512	; 0x200
  1037e0:	e5802020 	str	r2, [r0, #32]
  1037e4:	e5801020 	str	r1, [r0, #32]
  1037e8:	e5803018 	str	r3, [r0, #24]
  1037ec:	e580301c 	str	r3, [r0, #28]
  1037f0:	e5803010 	str	r3, [r0, #16]
  1037f4:	e5803014 	str	r3, [r0, #20]
  1037f8:	e5803008 	str	r3, [r0, #8]
  1037fc:	e580300c 	str	r3, [r0, #12]
  103800:	e5803000 	str	r3, [r0]
  103804:	e5803004 	str	r3, [r0, #4]
  103808:	e12fff1e 	bx	lr

0010380c <AT91F_US_Close>:
  10380c:	e3a03000 	mov	r3, #0	; 0x0
  103810:	e3e02000 	mvn	r2, #0	; 0x0
  103814:	e92d4010 	stmdb	sp!, {r4, lr}
  103818:	e5803020 	str	r3, [r0, #32]
  10381c:	e1a04000 	mov	r4, r0
  103820:	e5803004 	str	r3, [r0, #4]
  103824:	e5803028 	str	r3, [r0, #40]
  103828:	e580200c 	str	r2, [r0, #12]
  10382c:	e2800c01 	add	r0, r0, #256	; 0x100
  103830:	ebffffe7 	bl	1037d4 <AT91F_PDC_Close>
  103834:	e3a030ac 	mov	r3, #172	; 0xac
  103838:	e5843000 	str	r3, [r4]
  10383c:	e8bd8010 	ldmia	sp!, {r4, pc}

00103840 <AT91F_SPI_Close>:
  103840:	e3a03000 	mov	r3, #0	; 0x0
  103844:	e3e02000 	mvn	r2, #0	; 0x0
  103848:	e92d4010 	stmdb	sp!, {r4, lr}
  10384c:	e5803030 	str	r3, [r0, #48]
  103850:	e1a04000 	mov	r4, r0
  103854:	e5803034 	str	r3, [r0, #52]
  103858:	e5803038 	str	r3, [r0, #56]
  10385c:	e580303c 	str	r3, [r0, #60]
  103860:	e5803004 	str	r3, [r0, #4]
  103864:	e5802018 	str	r2, [r0, #24]
  103868:	e2800c01 	add	r0, r0, #256	; 0x100
  10386c:	ebffffd8 	bl	1037d4 <AT91F_PDC_Close>
  103870:	e3a03002 	mov	r3, #2	; 0x2
  103874:	e5843000 	str	r3, [r4]
  103878:	e8bd8010 	ldmia	sp!, {r4, pc}

0010387c <AT91F_PMC_GetMasterClock>:
  10387c:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  103880:	e5903030 	ldr	r3, [r0, #48]
  103884:	e203c003 	and	ip, r3, #3	; 0x3
  103888:	e203301c 	and	r3, r3, #28	; 0x1c
  10388c:	e1a03123 	mov	r3, r3, lsr #2
  103890:	e3a00001 	mov	r0, #1	; 0x1
  103894:	e1a05310 	mov	r5, r0, lsl r3
  103898:	e35c0001 	cmp	ip, #1	; 0x1
  10389c:	e1a03001 	mov	r3, r1
  1038a0:	e1a01005 	mov	r1, r5
  1038a4:	0a000017 	beq	103908 <AT91F_PMC_GetMasterClock+0x8c>
  1038a8:	e1a00002 	mov	r0, r2
  1038ac:	2a000001 	bcs	1038b8 <AT91F_PMC_GetMasterClock+0x3c>
  1038b0:	ebfff217 	bl	100114 <__udivsi3>
  1038b4:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
  1038b8:	e35c0003 	cmp	ip, #3	; 0x3
  1038bc:	e3a00000 	mov	r0, #0	; 0x0
  1038c0:	18bd8030 	ldmneia	sp!, {r4, r5, pc}
  1038c4:	e593100c 	ldr	r1, [r3, #12]
  1038c8:	e5933004 	ldr	r3, [r3, #4]
  1038cc:	e1a03803 	mov	r3, r3, lsl #16
  1038d0:	e1a03823 	mov	r3, r3, lsr #16
  1038d4:	e0000293 	mul	r0, r3, r2
  1038d8:	e3c1433e 	bic	r4, r1, #-134217728	; 0xf8000000
  1038dc:	e1a00220 	mov	r0, r0, lsr #4
  1038e0:	e20110ff 	and	r1, r1, #255	; 0xff
  1038e4:	ebfff20a 	bl	100114 <__udivsi3>
  1038e8:	e1a04824 	mov	r4, r4, lsr #16
  1038ec:	e1a04804 	mov	r4, r4, lsl #16
  1038f0:	e1a04824 	mov	r4, r4, lsr #16
  1038f4:	e2844001 	add	r4, r4, #1	; 0x1
  1038f8:	e0000094 	mul	r0, r4, r0
  1038fc:	e1a01005 	mov	r1, r5
  103900:	ebfff203 	bl	100114 <__udivsi3>
  103904:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
  103908:	e5933004 	ldr	r3, [r3, #4]
  10390c:	e1a03803 	mov	r3, r3, lsl #16
  103910:	e1a03823 	mov	r3, r3, lsr #16
  103914:	e0000293 	mul	r0, r3, r2
  103918:	e1a00220 	mov	r0, r0, lsr #4
  10391c:	ebfff1fc 	bl	100114 <__udivsi3>
  103920:	e8bd8030 	ldmia	sp!, {r4, r5, pc}

00103924 <AT91F_PDC_Open>:
  103924:	e3a03000 	mov	r3, #0	; 0x0
  103928:	e3a02002 	mov	r2, #2	; 0x2
  10392c:	e3a01c02 	mov	r1, #512	; 0x200
  103930:	e5802020 	str	r2, [r0, #32]
  103934:	e5801020 	str	r1, [r0, #32]
  103938:	e2422001 	sub	r2, r2, #1	; 0x1
  10393c:	e5803018 	str	r3, [r0, #24]
  103940:	e580301c 	str	r3, [r0, #28]
  103944:	e5803010 	str	r3, [r0, #16]
  103948:	e5803014 	str	r3, [r0, #20]
  10394c:	e5803008 	str	r3, [r0, #8]
  103950:	e580300c 	str	r3, [r0, #12]
  103954:	e5803000 	str	r3, [r0]
  103958:	e5803004 	str	r3, [r0, #4]
  10395c:	e2833c01 	add	r3, r3, #256	; 0x100
  103960:	e5802020 	str	r2, [r0, #32]
  103964:	e5803020 	str	r3, [r0, #32]
  103968:	e12fff1e 	bx	lr

0010396c <AT91F_US_Configure>:
  10396c:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  103970:	e3a0c0ac 	mov	ip, #172	; 0xac
  103974:	e1a04000 	mov	r4, r0
  103978:	e0810101 	add	r0, r1, r1, lsl #2
  10397c:	e3e01000 	mvn	r1, #0	; 0x0
  103980:	e584100c 	str	r1, [r4, #12]
  103984:	e1a00080 	mov	r0, r0, lsl #1
  103988:	e1a01203 	mov	r1, r3, lsl #4
  10398c:	e584c000 	str	ip, [r4]
  103990:	e1a05002 	mov	r5, r2
  103994:	ebfff1de 	bl	100114 <__udivsi3>
  103998:	e59f3034 	ldr	r3, [pc, #52]	; 1039d4 <prog+0x3990>
  10399c:	e0821093 	umull	r1, r2, r3, r0
  1039a0:	e1a021a2 	mov	r2, r2, lsr #3
  1039a4:	e0823102 	add	r3, r2, r2, lsl #2
  1039a8:	e0400083 	sub	r0, r0, r3, lsl #1
  1039ac:	e3500004 	cmp	r0, #4	; 0x4
  1039b0:	e2823001 	add	r3, r2, #1	; 0x1
  1039b4:	91a03002 	movls	r3, r2
  1039b8:	e5843020 	str	r3, [r4, #32]
  1039bc:	e59d300c 	ldr	r3, [sp, #12]
  1039c0:	e2840c01 	add	r0, r4, #256	; 0x100
  1039c4:	e5843028 	str	r3, [r4, #40]
  1039c8:	ebffffd5 	bl	103924 <AT91F_PDC_Open>
  1039cc:	e5845004 	str	r5, [r4, #4]
  1039d0:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
  1039d4:	cccccccd 	stcgtl	12, cr12, [ip], {205}

001039d8 <AT91F_SSC_Configure>:
  1039d8:	e3a0cc82 	mov	ip, #33280	; 0x8200
  1039dc:	e92d41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
  1039e0:	e28cc002 	add	ip, ip, #2	; 0x2
  1039e4:	e3e0e000 	mvn	lr, #0	; 0x0
  1039e8:	e59d8018 	ldr	r8, [sp, #24]
  1039ec:	e28d601c 	add	r6, sp, #28	; 0x1c
  1039f0:	e89600c0 	ldmia	r6, {r6, r7}
  1039f4:	e580e048 	str	lr, [r0, #72]
  1039f8:	e580c000 	str	ip, [r0]
  1039fc:	e1a04000 	mov	r4, r0
  103a00:	e1a05003 	mov	r5, r3
  103a04:	ebffff3a 	bl	1036f4 <AT91F_SSC_SetBaudrate>
  103a08:	e2840c01 	add	r0, r4, #256	; 0x100
  103a0c:	e5845010 	str	r5, [r4, #16]
  103a10:	e5846018 	str	r6, [r4, #24]
  103a14:	e5848014 	str	r8, [r4, #20]
  103a18:	e584701c 	str	r7, [r4, #28]
  103a1c:	e8bd41f0 	ldmia	sp!, {r4, r5, r6, r7, r8, lr}
  103a20:	eaffffbf 	b	103924 <AT91F_PDC_Open>

00103a24 <pxPortInitialiseStack>:
  103a24:	e2811004 	add	r1, r1, #4	; 0x4
  103a28:	e92d4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
  103a2c:	e5801000 	str	r1, [r0]
  103a30:	e3a01c12 	mov	r1, #4608	; 0x1200
  103a34:	e3a03caa 	mov	r3, #43520	; 0xaa00
  103a38:	e2811012 	add	r1, r1, #18	; 0x12
  103a3c:	e283b0aa 	add	fp, r3, #170	; 0xaa
  103a40:	e1811801 	orr	r1, r1, r1, lsl #16
  103a44:	e2433ca9 	sub	r3, r3, #43264	; 0xa900
  103a48:	e500100c 	str	r1, [r0, #-12]
  103a4c:	e3a09a01 	mov	r9, #4096	; 0x1000
  103a50:	e3a0ac09 	mov	sl, #2304	; 0x900
  103a54:	e3a08b02 	mov	r8, #2048	; 0x800
  103a58:	e3a07c07 	mov	r7, #1792	; 0x700
  103a5c:	e3a06c06 	mov	r6, #1536	; 0x600
  103a60:	e3a05c05 	mov	r5, #1280	; 0x500
  103a64:	e3a04b01 	mov	r4, #1024	; 0x400
  103a68:	e3a0ec03 	mov	lr, #768	; 0x300
  103a6c:	e3a0cc02 	mov	ip, #512	; 0x200
  103a70:	e2833001 	add	r3, r3, #1	; 0x1
  103a74:	e3a01c11 	mov	r1, #4352	; 0x1100
  103a78:	e1833803 	orr	r3, r3, r3, lsl #16
  103a7c:	e2899010 	add	r9, r9, #16	; 0x10
  103a80:	e28aa009 	add	sl, sl, #9	; 0x9
  103a84:	e2888008 	add	r8, r8, #8	; 0x8
  103a88:	e2877007 	add	r7, r7, #7	; 0x7
  103a8c:	e2866006 	add	r6, r6, #6	; 0x6
  103a90:	e2855005 	add	r5, r5, #5	; 0x5
  103a94:	e2844004 	add	r4, r4, #4	; 0x4
  103a98:	e28ee003 	add	lr, lr, #3	; 0x3
  103a9c:	e28cc002 	add	ip, ip, #2	; 0x2
  103aa0:	e2811011 	add	r1, r1, #17	; 0x11
  103aa4:	e5003038 	str	r3, [r0, #-56]
  103aa8:	e500203c 	str	r2, [r0, #-60]
  103aac:	e18bb80b 	orr	fp, fp, fp, lsl #16
  103ab0:	e1899809 	orr	r9, r9, r9, lsl #16
  103ab4:	e18aa80a 	orr	sl, sl, sl, lsl #16
  103ab8:	e1888808 	orr	r8, r8, r8, lsl #16
  103abc:	e1877807 	orr	r7, r7, r7, lsl #16
  103ac0:	e1866806 	orr	r6, r6, r6, lsl #16
  103ac4:	e1855805 	orr	r5, r5, r5, lsl #16
  103ac8:	e1844804 	orr	r4, r4, r4, lsl #16
  103acc:	e18ee80e 	orr	lr, lr, lr, lsl #16
  103ad0:	e18cc80c 	orr	ip, ip, ip, lsl #16
  103ad4:	e1811801 	orr	r1, r1, r1, lsl #16
  103ad8:	e3a0301f 	mov	r3, #31	; 0x1f
  103adc:	e3a02000 	mov	r2, #0	; 0x0
  103ae0:	e500b004 	str	fp, [r0, #-4]
  103ae4:	e5001010 	str	r1, [r0, #-16]
  103ae8:	e5009014 	str	r9, [r0, #-20]
  103aec:	e500a018 	str	sl, [r0, #-24]
  103af0:	e500801c 	str	r8, [r0, #-28]
  103af4:	e5007020 	str	r7, [r0, #-32]
  103af8:	e5006024 	str	r6, [r0, #-36]
  103afc:	e5005028 	str	r5, [r0, #-40]
  103b00:	e500402c 	str	r4, [r0, #-44]
  103b04:	e500e030 	str	lr, [r0, #-48]
  103b08:	e500c034 	str	ip, [r0, #-52]
  103b0c:	e5003040 	str	r3, [r0, #-64]
  103b10:	e5002044 	str	r2, [r0, #-68]
  103b14:	e5000008 	str	r0, [r0, #-8]
  103b18:	e2400044 	sub	r0, r0, #68	; 0x44
  103b1c:	e8bd8ff0 	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}

00103b20 <vPortEndScheduler>:
  103b20:	e12fff1e 	bx	lr

00103b24 <xPortStartScheduler>:
  103b24:	e52de004 	str	lr, [sp, #-4]!
  103b28:	e3a01007 	mov	r1, #7	; 0x7
  103b2c:	e3a02000 	mov	r2, #0	; 0x0
  103b30:	e59f3038 	ldr	r3, [pc, #56]	; 103b70 <prog+0x3b2c>
  103b34:	e3a00001 	mov	r0, #1	; 0x1
  103b38:	ebfffe8a 	bl	103568 <AT91F_AIC_ConfigureIt>
  103b3c:	e3a02403 	mov	r2, #50331648	; 0x3000000
  103b40:	e2822ebb 	add	r2, r2, #2992	; 0xbb0
  103b44:	e3a034a6 	mov	r3, #-1509949440	; 0xa6000000
  103b48:	e2822003 	add	r2, r2, #3	; 0x3
  103b4c:	e1a03ac3 	mov	r3, r3, asr #21
  103b50:	e5832000 	str	r2, [r3]
  103b54:	e3a03102 	mov	r3, #-2147483648	; 0x80000000
  103b58:	e3a01002 	mov	r1, #2	; 0x2
  103b5c:	e1a039c3 	mov	r3, r3, asr #19
  103b60:	e5831120 	str	r1, [r3, #288]
  103b64:	eb000002 	bl	103b74 <vPortISRStartFirstTask>
  103b68:	e3a00000 	mov	r0, #0	; 0x0
  103b6c:	e49df004 	ldr	pc, [sp], #4
  103b70:	00103c74 	andeqs	r3, r0, r4, ror ip

00103b74 <vPortISRStartFirstTask>:
  103b74:	e59f0044 	ldr	r0, [pc, #68]	; 103bc0 <prog+0x3b7c>
  103b78:	e5900000 	ldr	r0, [r0]
  103b7c:	e590e000 	ldr	lr, [r0]
  103b80:	e59f003c 	ldr	r0, [pc, #60]	; 103bc4 <prog+0x3b80>
  103b84:	e8be0002 	ldmia	lr!, {r1}
  103b88:	e5801000 	str	r1, [r0]
  103b8c:	e8be0001 	ldmia	lr!, {r0}
  103b90:	e169f000 	msr	SPSR_fc, r0
  103b94:	e8de7fff 	ldmia	lr, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, sp, lr}^
  103b98:	e1a00000 	nop			(mov r0,r0)
  103b9c:	e59ee03c 	ldr	lr, [lr, #60]
  103ba0:	e25ef004 	subs	pc, lr, #4	; 0x4
  103ba4:	e59f300c 	ldr	r3, [pc, #12]	; 103bb8 <prog+0x3b74>
  103ba8:	e59f200c 	ldr	r2, [pc, #12]	; 103bbc <prog+0x3b78>
  103bac:	e5931000 	ldr	r1, [r3]
  103bb0:	e5923000 	ldr	r3, [r2]
  103bb4:	e12fff1e 	bx	lr
  103bb8:	00200000 	eoreq	r0, r0, r0
  103bbc:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  103bc0:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  103bc4:	00200000 	eoreq	r0, r0, r0

00103bc8 <swi_handler>:
  103bc8:	e28ee004 	add	lr, lr, #4	; 0x4
  103bcc:	e92d0001 	stmdb	sp!, {r0}
  103bd0:	e94d2000 	stmdb	sp, {sp}^
  103bd4:	e1a00000 	nop			(mov r0,r0)
  103bd8:	e24dd004 	sub	sp, sp, #4	; 0x4
  103bdc:	e8bd0001 	ldmia	sp!, {r0}
  103be0:	e9204000 	stmdb	r0!, {lr}
  103be4:	e1a0e000 	mov	lr, r0
  103be8:	e8bd0001 	ldmia	sp!, {r0}
  103bec:	e94e7fff 	stmdb	lr, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, sp, lr}^
  103bf0:	e1a00000 	nop			(mov r0,r0)
  103bf4:	e24ee03c 	sub	lr, lr, #60	; 0x3c
  103bf8:	e14f0000 	mrs	r0, SPSR
  103bfc:	e92e0001 	stmdb	lr!, {r0}
  103c00:	e59f0064 	ldr	r0, [pc, #100]	; 103c6c <prog+0x3c28>
  103c04:	e5900000 	ldr	r0, [r0]
  103c08:	e92e0001 	stmdb	lr!, {r0}
  103c0c:	e59f005c 	ldr	r0, [pc, #92]	; 103c70 <prog+0x3c2c>
  103c10:	e5900000 	ldr	r0, [r0]
  103c14:	e580e000 	str	lr, [r0]
  103c18:	e59f4044 	ldr	r4, [pc, #68]	; 103c64 <prog+0x3c20>
  103c1c:	e59f5044 	ldr	r5, [pc, #68]	; 103c68 <prog+0x3c24>
  103c20:	e5943000 	ldr	r3, [r4]
  103c24:	e5952000 	ldr	r2, [r5]
  103c28:	ebfffb9e 	bl	102aa8 <vTaskSwitchContext>
  103c2c:	e59f003c 	ldr	r0, [pc, #60]	; 103c70 <prog+0x3c2c>
  103c30:	e5900000 	ldr	r0, [r0]
  103c34:	e590e000 	ldr	lr, [r0]
  103c38:	e59f002c 	ldr	r0, [pc, #44]	; 103c6c <prog+0x3c28>
  103c3c:	e8be0002 	ldmia	lr!, {r1}
  103c40:	e5801000 	str	r1, [r0]
  103c44:	e8be0001 	ldmia	lr!, {r0}
  103c48:	e169f000 	msr	SPSR_fc, r0
  103c4c:	e8de7fff 	ldmia	lr, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, sp, lr}^
  103c50:	e1a00000 	nop			(mov r0,r0)
  103c54:	e59ee03c 	ldr	lr, [lr, #60]
  103c58:	e25ef004 	subs	pc, lr, #4	; 0x4
  103c5c:	e5943000 	ldr	r3, [r4]
  103c60:	e5952000 	ldr	r2, [r5]
  103c64:	00200000 	eoreq	r0, r0, r0
  103c68:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  103c6c:	00200000 	eoreq	r0, r0, r0
  103c70:	00200d3c 	eoreq	r0, r0, ip, lsr sp

00103c74 <vPreemptiveTick>:
  103c74:	e92d0001 	stmdb	sp!, {r0}
  103c78:	e94d2000 	stmdb	sp, {sp}^
  103c7c:	e1a00000 	nop			(mov r0,r0)
  103c80:	e24dd004 	sub	sp, sp, #4	; 0x4
  103c84:	e8bd0001 	ldmia	sp!, {r0}
  103c88:	e9204000 	stmdb	r0!, {lr}
  103c8c:	e1a0e000 	mov	lr, r0
  103c90:	e8bd0001 	ldmia	sp!, {r0}
  103c94:	e94e7fff 	stmdb	lr, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, sp, lr}^
  103c98:	e1a00000 	nop			(mov r0,r0)
  103c9c:	e24ee03c 	sub	lr, lr, #60	; 0x3c
  103ca0:	e14f0000 	mrs	r0, SPSR
  103ca4:	e92e0001 	stmdb	lr!, {r0}
  103ca8:	e59f0080 	ldr	r0, [pc, #128]	; 103d30 <prog+0x3cec>
  103cac:	e5900000 	ldr	r0, [r0]
  103cb0:	e92e0001 	stmdb	lr!, {r0}
  103cb4:	e59f0078 	ldr	r0, [pc, #120]	; 103d34 <prog+0x3cf0>
  103cb8:	e5900000 	ldr	r0, [r0]
  103cbc:	e580e000 	str	lr, [r0]
  103cc0:	e59f4060 	ldr	r4, [pc, #96]	; 103d28 <prog+0x3ce4>
  103cc4:	e59f5060 	ldr	r5, [pc, #96]	; 103d2c <prog+0x3ce8>
  103cc8:	e5943000 	ldr	r3, [r4]
  103ccc:	e5952000 	ldr	r2, [r5]
  103cd0:	ebfffb0c 	bl	102908 <vTaskIncrementTick>
  103cd4:	ebfffb73 	bl	102aa8 <vTaskSwitchContext>
  103cd8:	e3a034a6 	mov	r3, #-1509949440	; 0xa6000000
  103cdc:	e1a03ac3 	mov	r3, r3, asr #21
  103ce0:	e5931008 	ldr	r1, [r3, #8]
  103ce4:	e3a02102 	mov	r2, #-2147483648	; 0x80000000
  103ce8:	e1a029c2 	mov	r2, r2, asr #19
  103cec:	e5821130 	str	r1, [r2, #304]
  103cf0:	e59f003c 	ldr	r0, [pc, #60]	; 103d34 <prog+0x3cf0>
  103cf4:	e5900000 	ldr	r0, [r0]
  103cf8:	e590e000 	ldr	lr, [r0]
  103cfc:	e59f002c 	ldr	r0, [pc, #44]	; 103d30 <prog+0x3cec>
  103d00:	e8be0002 	ldmia	lr!, {r1}
  103d04:	e5801000 	str	r1, [r0]
  103d08:	e8be0001 	ldmia	lr!, {r0}
  103d0c:	e169f000 	msr	SPSR_fc, r0
  103d10:	e8de7fff 	ldmia	lr, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, sp, lr}^
  103d14:	e1a00000 	nop			(mov r0,r0)
  103d18:	e59ee03c 	ldr	lr, [lr, #60]
  103d1c:	e25ef004 	subs	pc, lr, #4	; 0x4
  103d20:	e5943000 	ldr	r3, [r4]
  103d24:	e5952000 	ldr	r2, [r5]
  103d28:	00200000 	eoreq	r0, r0, r0
  103d2c:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  103d30:	00200000 	eoreq	r0, r0, r0
  103d34:	00200d3c 	eoreq	r0, r0, ip, lsr sp

00103d38 <vPortDisableInterruptsFromThumb>:
  103d38:	e92d0001 	stmdb	sp!, {r0}
  103d3c:	e10f0000 	mrs	r0, CPSR
  103d40:	e38000c0 	orr	r0, r0, #192	; 0xc0
  103d44:	e129f000 	msr	CPSR_fc, r0
  103d48:	e8bd0001 	ldmia	sp!, {r0}
  103d4c:	e12fff1e 	bx	lr

00103d50 <vPortEnableInterruptsFromThumb>:
  103d50:	e92d0001 	stmdb	sp!, {r0}
  103d54:	e10f0000 	mrs	r0, CPSR
  103d58:	e3c000c0 	bic	r0, r0, #192	; 0xc0
  103d5c:	e129f000 	msr	CPSR_fc, r0
  103d60:	e8bd0001 	ldmia	sp!, {r0}
  103d64:	e12fff1e 	bx	lr

00103d68 <vPortEnterCritical>:
  103d68:	e92d0001 	stmdb	sp!, {r0}
  103d6c:	e10f0000 	mrs	r0, CPSR
  103d70:	e38000c0 	orr	r0, r0, #192	; 0xc0
  103d74:	e129f000 	msr	CPSR_fc, r0
  103d78:	e8bd0001 	ldmia	sp!, {r0}
  103d7c:	e59f200c 	ldr	r2, [pc, #12]	; 103d90 <prog+0x3d4c>
  103d80:	e5923000 	ldr	r3, [r2]
  103d84:	e2833001 	add	r3, r3, #1	; 0x1
  103d88:	e5823000 	str	r3, [r2]
  103d8c:	e12fff1e 	bx	lr
  103d90:	00200000 	eoreq	r0, r0, r0

00103d94 <vPortExitCritical>:
  103d94:	e59f2038 	ldr	r2, [pc, #56]	; 103dd4 <prog+0x3d90>
  103d98:	e5923000 	ldr	r3, [r2]
  103d9c:	e3530000 	cmp	r3, #0	; 0x0
  103da0:	012fff1e 	bxeq	lr
  103da4:	e5923000 	ldr	r3, [r2]
  103da8:	e2433001 	sub	r3, r3, #1	; 0x1
  103dac:	e5823000 	str	r3, [r2]
  103db0:	e5922000 	ldr	r2, [r2]
  103db4:	e3520000 	cmp	r2, #0	; 0x0
  103db8:	112fff1e 	bxne	lr
  103dbc:	e92d0001 	stmdb	sp!, {r0}
  103dc0:	e10f0000 	mrs	r0, CPSR
  103dc4:	e3c000c0 	bic	r0, r0, #192	; 0xc0
  103dc8:	e129f000 	msr	CPSR_fc, r0
  103dcc:	e8bd0001 	ldmia	sp!, {r0}
  103dd0:	e12fff1e 	bx	lr
  103dd4:	00200000 	eoreq	r0, r0, r0

00103dd8 <pvPortMalloc>:
  103dd8:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  103ddc:	e59f510c 	ldr	r5, [pc, #268]	; 103ef0 <prog+0x3eac>
  103de0:	e1a04000 	mov	r4, r0
  103de4:	ebfff9fa 	bl	1025d4 <vTaskSuspendAll>
  103de8:	e595e000 	ldr	lr, [r5]
  103dec:	e35e0000 	cmp	lr, #0	; 0x0
  103df0:	1a00000b 	bne	103e24 <pvPortMalloc+0x4c>
  103df4:	e59f20f8 	ldr	r2, [pc, #248]	; 103ef4 <prog+0x3eb0>
  103df8:	e59f10f8 	ldr	r1, [pc, #248]	; 103ef8 <prog+0x3eb4>
  103dfc:	e59f00f8 	ldr	r0, [pc, #248]	; 103efc <prog+0x3eb8>
  103e00:	e3a0c901 	mov	ip, #16384	; 0x4000
  103e04:	e3a03001 	mov	r3, #1	; 0x1
  103e08:	e5821000 	str	r1, [r2]
  103e0c:	e5853000 	str	r3, [r5]
  103e10:	e580e004 	str	lr, [r0, #4]
  103e14:	e581e000 	str	lr, [r1]
  103e18:	e582c004 	str	ip, [r2, #4]
  103e1c:	e5802000 	str	r2, [r0]
  103e20:	e581c004 	str	ip, [r1, #4]
  103e24:	e3540000 	cmp	r4, #0	; 0x0
  103e28:	0a000003 	beq	103e3c <pvPortMalloc+0x64>
  103e2c:	e2844008 	add	r4, r4, #8	; 0x8
  103e30:	e3140003 	tst	r4, #3	; 0x3
  103e34:	13c43003 	bicne	r3, r4, #3	; 0x3
  103e38:	12834004 	addne	r4, r3, #4	; 0x4
  103e3c:	e3a03dff 	mov	r3, #16320	; 0x3fc0
  103e40:	e283303e 	add	r3, r3, #62	; 0x3e
  103e44:	e2442001 	sub	r2, r4, #1	; 0x1
  103e48:	e1520003 	cmp	r2, r3
  103e4c:	9a000003 	bls	103e60 <pvPortMalloc+0x88>
  103e50:	e3a05000 	mov	r5, #0	; 0x0
  103e54:	ebfffc91 	bl	1030a0 <xTaskResumeAll>
  103e58:	e1a00005 	mov	r0, r5
  103e5c:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
  103e60:	e59f3094 	ldr	r3, [pc, #148]	; 103efc <prog+0x3eb8>
  103e64:	e5931000 	ldr	r1, [r3]
  103e68:	e1a0c003 	mov	ip, r3
  103e6c:	ea000001 	b	103e78 <pvPortMalloc+0xa0>
  103e70:	e1a0c001 	mov	ip, r1
  103e74:	e1a01003 	mov	r1, r3
  103e78:	e5912004 	ldr	r2, [r1, #4]
  103e7c:	e1540002 	cmp	r4, r2
  103e80:	9a000002 	bls	103e90 <pvPortMalloc+0xb8>
  103e84:	e5913000 	ldr	r3, [r1]
  103e88:	e3530000 	cmp	r3, #0	; 0x0
  103e8c:	1afffff7 	bne	103e70 <pvPortMalloc+0x98>
  103e90:	e59f3060 	ldr	r3, [pc, #96]	; 103ef8 <prog+0x3eb4>
  103e94:	e1510003 	cmp	r1, r3
  103e98:	0affffec 	beq	103e50 <pvPortMalloc+0x78>
  103e9c:	e0640002 	rsb	r0, r4, r2
  103ea0:	e5913000 	ldr	r3, [r1]
  103ea4:	e59c2000 	ldr	r2, [ip]
  103ea8:	e3500010 	cmp	r0, #16	; 0x10
  103eac:	e58c3000 	str	r3, [ip]
  103eb0:	e2825008 	add	r5, r2, #8	; 0x8
  103eb4:	9affffe6 	bls	103e54 <pvPortMalloc+0x7c>
  103eb8:	e081c004 	add	ip, r1, r4
  103ebc:	e58c0004 	str	r0, [ip, #4]
  103ec0:	e5814004 	str	r4, [r1, #4]
  103ec4:	e59f1030 	ldr	r1, [pc, #48]	; 103efc <prog+0x3eb8>
  103ec8:	e59c0004 	ldr	r0, [ip, #4]
  103ecc:	ea000000 	b	103ed4 <pvPortMalloc+0xfc>
  103ed0:	e1a01002 	mov	r1, r2
  103ed4:	e5912000 	ldr	r2, [r1]
  103ed8:	e5923004 	ldr	r3, [r2, #4]
  103edc:	e1500003 	cmp	r0, r3
  103ee0:	8afffffa 	bhi	103ed0 <pvPortMalloc+0xf8>
  103ee4:	e58c2000 	str	r2, [ip]
  103ee8:	e581c000 	str	ip, [r1]
  103eec:	eaffffd8 	b	103e54 <pvPortMalloc+0x7c>
  103ef0:	00200e3c 	eoreq	r0, r0, ip, lsr lr
  103ef4:	00200e54 	eoreq	r0, r0, r4, asr lr
  103ef8:	00200e40 	eoreq	r0, r0, r0, asr #28
  103efc:	00200e48 	eoreq	r0, r0, r8, asr #28

00103f00 <vPortFree>:
  103f00:	e3500000 	cmp	r0, #0	; 0x0
  103f04:	e92d4010 	stmdb	sp!, {r4, lr}
  103f08:	08bd8010 	ldmeqia	sp!, {r4, pc}
  103f0c:	e2404008 	sub	r4, r0, #8	; 0x8
  103f10:	ebfff9af 	bl	1025d4 <vTaskSuspendAll>
  103f14:	e5940004 	ldr	r0, [r4, #4]
  103f18:	e59f1024 	ldr	r1, [pc, #36]	; 103f44 <prog+0x3f00>
  103f1c:	ea000000 	b	103f24 <vPortFree+0x24>
  103f20:	e1a01002 	mov	r1, r2
  103f24:	e5912000 	ldr	r2, [r1]
  103f28:	e5923004 	ldr	r3, [r2, #4]
  103f2c:	e1500003 	cmp	r0, r3
  103f30:	8afffffa 	bhi	103f20 <vPortFree+0x20>
  103f34:	e5842000 	str	r2, [r4]
  103f38:	e5814000 	str	r4, [r1]
  103f3c:	e8bd4010 	ldmia	sp!, {r4, lr}
  103f40:	eafffc56 	b	1030a0 <xTaskResumeAll>
  103f44:	00200e48 	eoreq	r0, r0, r8, asr #28

00103f48 <vUSBSendByte>:
  103f48:	e52de004 	str	lr, [sp, #-4]!
  103f4c:	e59f301c 	ldr	r3, [pc, #28]	; 103f70 <prog+0x3f2c>
  103f50:	e24dd004 	sub	sp, sp, #4	; 0x4
  103f54:	e5cd0000 	strb	r0, [sp]
  103f58:	e1a0100d 	mov	r1, sp
  103f5c:	e5930000 	ldr	r0, [r3]
  103f60:	e3a02000 	mov	r2, #0	; 0x0
  103f64:	ebfff906 	bl	102384 <xQueueSend>
  103f68:	e28dd004 	add	sp, sp, #4	; 0x4
  103f6c:	e8bd8000 	ldmia	sp!, {pc}
  103f70:	00204e70 	eoreq	r4, r0, r0, ror lr

00103f74 <vUSBRecvByte>:
  103f74:	e3500000 	cmp	r0, #0	; 0x0
  103f78:	13510000 	cmpne	r1, #0	; 0x0
  103f7c:	e92d41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
  103f80:	e1a04000 	mov	r4, r0
  103f84:	e1a07002 	mov	r7, r2
  103f88:	c3a00000 	movgt	r0, #0	; 0x0
  103f8c:	d3a00001 	movle	r0, #1	; 0x1
  103f90:	da000013 	ble	103fe4 <vUSBRecvByte+0x70>
  103f94:	e59f8054 	ldr	r8, [pc, #84]	; 103ff0 <prog+0x3fac>
  103f98:	e5983000 	ldr	r3, [r8]
  103f9c:	e3530000 	cmp	r3, #0	; 0x0
  103fa0:	0a00000f 	beq	103fe4 <vUSBRecvByte+0x70>
  103fa4:	e2516001 	subs	r6, r1, #1	; 0x1
  103fa8:	21a05000 	movcs	r5, r0
  103fac:	3a00000c 	bcc	103fe4 <vUSBRecvByte+0x70>
  103fb0:	e1a01004 	mov	r1, r4
  103fb4:	e5980000 	ldr	r0, [r8]
  103fb8:	e1a02007 	mov	r2, r7
  103fbc:	ebfff88b 	bl	1021f0 <xQueueReceive>
  103fc0:	e3500000 	cmp	r0, #0	; 0x0
  103fc4:	e2844001 	add	r4, r4, #1	; 0x1
  103fc8:	e2863001 	add	r3, r6, #1	; 0x1
  103fcc:	0a000005 	beq	103fe8 <vUSBRecvByte+0x74>
  103fd0:	e2855001 	add	r5, r5, #1	; 0x1
  103fd4:	e1530005 	cmp	r3, r5
  103fd8:	1afffff4 	bne	103fb0 <vUSBRecvByte+0x3c>
  103fdc:	e1a00005 	mov	r0, r5
  103fe0:	e8bd81f0 	ldmia	sp!, {r4, r5, r6, r7, r8, pc}
  103fe4:	e3a05000 	mov	r5, #0	; 0x0
  103fe8:	e1a00005 	mov	r0, r5
  103fec:	e8bd81f0 	ldmia	sp!, {r4, r5, r6, r7, r8, pc}
  103ff0:	00204e74 	eoreq	r4, r0, r4, ror lr

00103ff4 <prvSendZLP>:
  103ff4:	e92d4010 	stmdb	sp!, {r4, lr}
  103ff8:	e3a0220b 	mov	r2, #-1342177280	; 0xb0000000
  103ffc:	e1a02642 	mov	r2, r2, asr #12
  104000:	e5923030 	ldr	r3, [r2, #48]
  104004:	e3130010 	tst	r3, #16	; 0x10
  104008:	1a00000b 	bne	10403c <prvSendZLP+0x48>
  10400c:	ebffff55 	bl	103d68 <vPortEnterCritical>
  104010:	e3a0220b 	mov	r2, #-1342177280	; 0xb0000000
  104014:	e1a02642 	mov	r2, r2, asr #12
  104018:	e5923030 	ldr	r3, [r2, #48]
  10401c:	e59f0034 	ldr	r0, [pc, #52]	; 104058 <prog+0x4014>
  104020:	e3c33030 	bic	r3, r3, #48	; 0x30
  104024:	e5901080 	ldr	r1, [r0, #128]
  104028:	e383305f 	orr	r3, r3, #95	; 0x5f
  10402c:	e5823030 	str	r3, [r2, #48]
  104030:	e5801084 	str	r1, [r0, #132]
  104034:	e8bd4010 	ldmia	sp!, {r4, lr}
  104038:	eaffff55 	b	103d94 <vPortExitCritical>
  10403c:	e1a04002 	mov	r4, r2
  104040:	e3a00001 	mov	r0, #1	; 0x1
  104044:	ebfffce1 	bl	1033d0 <vTaskDelay>
  104048:	e5943030 	ldr	r3, [r4, #48]
  10404c:	e3130010 	tst	r3, #16	; 0x10
  104050:	1afffffa 	bne	104040 <prvSendZLP+0x4c>
  104054:	eaffffec 	b	10400c <prvSendZLP+0x18>
  104058:	00204f00 	eoreq	r4, r0, r0, lsl #30

0010405c <prvSendStall>:
  10405c:	e52de004 	str	lr, [sp, #-4]!
  104060:	ebffff40 	bl	103d68 <vPortEnterCritical>
  104064:	e3a0220b 	mov	r2, #-1342177280	; 0xb0000000
  104068:	e1a02642 	mov	r2, r2, asr #12
  10406c:	e5923030 	ldr	r3, [r2, #48]
  104070:	e3c33030 	bic	r3, r3, #48	; 0x30
  104074:	e383306f 	orr	r3, r3, #111	; 0x6f
  104078:	e5823030 	str	r3, [r2, #48]
  10407c:	e49de004 	ldr	lr, [sp], #4
  104080:	eaffff43 	b	103d94 <vPortExitCritical>

00104084 <prvSendNextSegment>:
  104084:	e92d4010 	stmdb	sp!, {r4, lr}
  104088:	e59f4134 	ldr	r4, [pc, #308]	; 1041c4 <prog+0x4180>
  10408c:	e5942084 	ldr	r2, [r4, #132]
  104090:	e5943080 	ldr	r3, [r4, #128]
  104094:	e1520003 	cmp	r2, r3
  104098:	e24dd00c 	sub	sp, sp, #12	; 0xc
  10409c:	9a00003e 	bls	10419c <prvSendNextSegment+0x118>
  1040a0:	e0633002 	rsb	r3, r3, r2
  1040a4:	e58d3000 	str	r3, [sp]
  1040a8:	e59d2000 	ldr	r2, [sp]
  1040ac:	e3520008 	cmp	r2, #8	; 0x8
  1040b0:	959d3000 	ldrls	r3, [sp]
  1040b4:	83a03008 	movhi	r3, #8	; 0x8
  1040b8:	958d3008 	strls	r3, [sp, #8]
  1040bc:	858d3008 	strhi	r3, [sp, #8]
  1040c0:	e3a0320b 	mov	r3, #-1342177280	; 0xb0000000
  1040c4:	e1a03643 	mov	r3, r3, asr #12
  1040c8:	e5932030 	ldr	r2, [r3, #48]
  1040cc:	e3120010 	tst	r2, #16	; 0x10
  1040d0:	1a000022 	bne	104160 <prvSendNextSegment+0xdc>
  1040d4:	e59d3008 	ldr	r3, [sp, #8]
  1040d8:	e3530000 	cmp	r3, #0	; 0x0
  1040dc:	0a00000c 	beq	104114 <prvSendNextSegment+0x90>
  1040e0:	e3a0020b 	mov	r0, #-1342177280	; 0xb0000000
  1040e4:	e5941080 	ldr	r1, [r4, #128]
  1040e8:	e1a00640 	mov	r0, r0, asr #12
  1040ec:	e7d43001 	ldrb	r3, [r4, r1]
  1040f0:	e5803050 	str	r3, [r0, #80]
  1040f4:	e59d2008 	ldr	r2, [sp, #8]
  1040f8:	e2422001 	sub	r2, r2, #1	; 0x1
  1040fc:	e58d2008 	str	r2, [sp, #8]
  104100:	e59d3008 	ldr	r3, [sp, #8]
  104104:	e3530000 	cmp	r3, #0	; 0x0
  104108:	e2811001 	add	r1, r1, #1	; 0x1
  10410c:	1afffff6 	bne	1040ec <prvSendNextSegment+0x68>
  104110:	e5841080 	str	r1, [r4, #128]
  104114:	ebffff13 	bl	103d68 <vPortEnterCritical>
  104118:	e3a0120b 	mov	r1, #-1342177280	; 0xb0000000
  10411c:	e1a01641 	mov	r1, r1, asr #12
  104120:	e5912030 	ldr	r2, [r1, #48]
  104124:	e58d2004 	str	r2, [sp, #4]
  104128:	e59d3004 	ldr	r3, [sp, #4]
  10412c:	e383304f 	orr	r3, r3, #79	; 0x4f
  104130:	e58d3004 	str	r3, [sp, #4]
  104134:	e59d2004 	ldr	r2, [sp, #4]
  104138:	e3c22030 	bic	r2, r2, #48	; 0x30
  10413c:	e58d2004 	str	r2, [sp, #4]
  104140:	e59d3004 	ldr	r3, [sp, #4]
  104144:	e3833010 	orr	r3, r3, #16	; 0x10
  104148:	e58d3004 	str	r3, [sp, #4]
  10414c:	e59d2004 	ldr	r2, [sp, #4]
  104150:	e5812030 	str	r2, [r1, #48]
  104154:	e28dd00c 	add	sp, sp, #12	; 0xc
  104158:	e8bd4010 	ldmia	sp!, {r4, lr}
  10415c:	eaffff0c 	b	103d94 <vPortExitCritical>
  104160:	e3a00001 	mov	r0, #1	; 0x1
  104164:	ebfffc99 	bl	1033d0 <vTaskDelay>
  104168:	e3a0320b 	mov	r3, #-1342177280	; 0xb0000000
  10416c:	e1a03643 	mov	r3, r3, asr #12
  104170:	e5932030 	ldr	r2, [r3, #48]
  104174:	e3120010 	tst	r2, #16	; 0x10
  104178:	0affffd5 	beq	1040d4 <prvSendNextSegment+0x50>
  10417c:	e3a00001 	mov	r0, #1	; 0x1
  104180:	ebfffc92 	bl	1033d0 <vTaskDelay>
  104184:	e3a0320b 	mov	r3, #-1342177280	; 0xb0000000
  104188:	e1a03643 	mov	r3, r3, asr #12
  10418c:	e5932030 	ldr	r2, [r3, #48]
  104190:	e3120010 	tst	r2, #16	; 0x10
  104194:	1afffff1 	bne	104160 <prvSendNextSegment+0xdc>
  104198:	eaffffcd 	b	1040d4 <prvSendNextSegment+0x50>
  10419c:	e59f4024 	ldr	r4, [pc, #36]	; 1041c8 <prog+0x4184>
  1041a0:	e5943000 	ldr	r3, [r4]
  1041a4:	e3530004 	cmp	r3, #4	; 0x4
  1041a8:	0a000001 	beq	1041b4 <prvSendNextSegment+0x130>
  1041ac:	e28dd00c 	add	sp, sp, #12	; 0xc
  1041b0:	e8bd8010 	ldmia	sp!, {r4, pc}
  1041b4:	ebffff8e 	bl	103ff4 <prvSendZLP>
  1041b8:	e3a03000 	mov	r3, #0	; 0x0
  1041bc:	e5843000 	str	r3, [r4]
  1041c0:	eafffff9 	b	1041ac <prvSendNextSegment+0x128>
  1041c4:	00204f00 	eoreq	r4, r0, r0, lsl #30
  1041c8:	00204e54 	eoreq	r4, r0, r4, asr lr

001041cc <prvSendControlData>:
  1041cc:	e1a01801 	mov	r1, r1, lsl #16
  1041d0:	e1a01821 	mov	r1, r1, lsr #16
  1041d4:	e1510002 	cmp	r1, r2
  1041d8:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  1041dc:	e1a05002 	mov	r5, r2
  1041e0:	93a02000 	movls	r2, #0	; 0x0
  1041e4:	83a02001 	movhi	r2, #1	; 0x1
  1041e8:	31a05001 	movcc	r5, r1
  1041ec:	3a000008 	bcc	104214 <prvSendControlData+0x48>
  1041f0:	e3530000 	cmp	r3, #0	; 0x0
  1041f4:	03a03000 	moveq	r3, #0	; 0x0
  1041f8:	12023001 	andne	r3, r2, #1	; 0x1
  1041fc:	e3530000 	cmp	r3, #0	; 0x0
  104200:	0a000003 	beq	104214 <prvSendControlData+0x48>
  104204:	e3150007 	tst	r5, #7	; 0x7
  104208:	059f302c 	ldreq	r3, [pc, #44]	; 10423c <prog+0x41f8>
  10420c:	03a02004 	moveq	r2, #4	; 0x4
  104210:	05832000 	streq	r2, [r3]
  104214:	e59f4024 	ldr	r4, [pc, #36]	; 104240 <prog+0x41fc>
  104218:	e1a01000 	mov	r1, r0
  10421c:	e1a02005 	mov	r2, r5
  104220:	e1a00004 	mov	r0, r4
  104224:	ebffefff 	bl	100228 <memcpy>
  104228:	e3a03000 	mov	r3, #0	; 0x0
  10422c:	e5843080 	str	r3, [r4, #128]
  104230:	e5845084 	str	r5, [r4, #132]
  104234:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  104238:	eaffff91 	b	104084 <prvSendNextSegment>
  10423c:	00204e54 	eoreq	r4, r0, r4, asr lr
  104240:	00204f00 	eoreq	r4, r0, r0, lsl #30

00104244 <vUSBCDCTask>:
  104244:	e92d4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
  104248:	e3a0820a 	mov	r8, #-1610612736	; 0xa0000000
  10424c:	e24dd008 	sub	sp, sp, #8	; 0x8
  104250:	e1a089c8 	mov	r8, r8, asr #19
  104254:	e3a0a801 	mov	sl, #65536	; 0x10000
  104258:	ebfffec2 	bl	103d68 <vPortEnterCritical>
  10425c:	e588a000 	str	sl, [r8]
  104260:	e588a010 	str	sl, [r8, #16]
  104264:	e588a030 	str	sl, [r8, #48]
  104268:	ebfffec9 	bl	103d94 <vPortExitCritical>
  10426c:	e3a0003c 	mov	r0, #60	; 0x3c
  104270:	ebfffc56 	bl	1033d0 <vTaskDelay>
  104274:	ebfffebb 	bl	103d68 <vPortEnterCritical>
  104278:	e3a00004 	mov	r0, #4	; 0x4
  10427c:	e1a01000 	mov	r1, r0
  104280:	ebfff72b 	bl	101f34 <xQueueCreate>
  104284:	e59fb808 	ldr	fp, [pc, #2056]	; 104a94 <prog+0x4a50>
  104288:	e3a01001 	mov	r1, #1	; 0x1
  10428c:	e58b0000 	str	r0, [fp]
  104290:	e3a00b01 	mov	r0, #1024	; 0x400
  104294:	ebfff726 	bl	101f34 <xQueueCreate>
  104298:	e59f77f8 	ldr	r7, [pc, #2040]	; 104a98 <prog+0x4a54>
  10429c:	e5870000 	str	r0, [r7]
  1042a0:	e3a00b01 	mov	r0, #1024	; 0x400
  1042a4:	e3a01001 	mov	r1, #1	; 0x1
  1042a8:	e2800001 	add	r0, r0, #1	; 0x1
  1042ac:	ebfff720 	bl	101f34 <xQueueCreate>
  1042b0:	e59b3000 	ldr	r3, [fp]
  1042b4:	e59f17e0 	ldr	r1, [pc, #2016]	; 104a9c <prog+0x4a58>
  1042b8:	e3530000 	cmp	r3, #0	; 0x0
  1042bc:	e5810000 	str	r0, [r1]
  1042c0:	0a000039 	beq	1043ac <vUSBCDCTask+0x168>
  1042c4:	e5973000 	ldr	r3, [r7]
  1042c8:	e3530000 	cmp	r3, #0	; 0x0
  1042cc:	0a000036 	beq	1043ac <vUSBCDCTask+0x168>
  1042d0:	e3500000 	cmp	r0, #0	; 0x0
  1042d4:	0a000034 	beq	1043ac <vUSBCDCTask+0x168>
  1042d8:	e59f27c0 	ldr	r2, [pc, #1984]	; 104aa0 <prog+0x4a5c>
  1042dc:	e3a03002 	mov	r3, #2	; 0x2
  1042e0:	e5823000 	str	r3, [r2]
  1042e4:	e59fe7b8 	ldr	lr, [pc, #1976]	; 104aa4 <prog+0x4a60>
  1042e8:	e59f37b8 	ldr	r3, [pc, #1976]	; 104aa8 <prog+0x4a64>
  1042ec:	e3a0c000 	mov	ip, #0	; 0x0
  1042f0:	e5c3c000 	strb	ip, [r3]
  1042f4:	e5cec000 	strb	ip, [lr]
  1042f8:	e3a02321 	mov	r2, #-2080374784	; 0x84000000
  1042fc:	e1a02ac2 	mov	r2, r2, asr #21
  104300:	e592000c 	ldr	r0, [r2, #12]
  104304:	e3a0e102 	mov	lr, #-2147483648	; 0x80000000
  104308:	e1a0eace 	mov	lr, lr, asr #21
  10430c:	e3800201 	orr	r0, r0, #268435456	; 0x10000000
  104310:	e3a06b02 	mov	r6, #2048	; 0x800
  104314:	e3a03080 	mov	r3, #128	; 0x80
  104318:	e582000c 	str	r0, [r2, #12]
  10431c:	e3a0120b 	mov	r1, #-1342177280	; 0xb0000000
  104320:	e58e3000 	str	r3, [lr]
  104324:	e59f2780 	ldr	r2, [pc, #1920]	; 104aac <prog+0x4a68>
  104328:	e58e6010 	str	r6, [lr, #16]
  10432c:	e59f377c 	ldr	r3, [pc, #1916]	; 104ab0 <prog+0x4a6c>
  104330:	e59fe77c 	ldr	lr, [pc, #1916]	; 104ab4 <prog+0x4a70>
  104334:	e3e04a4f 	mvn	r4, #323584	; 0x4f000
  104338:	e1a01641 	mov	r1, r1, asr #12
  10433c:	e3e05000 	mvn	r5, #0	; 0x0
  104340:	e2444d3e 	sub	r4, r4, #3968	; 0xf80
  104344:	e588a000 	str	sl, [r8]
  104348:	e582c080 	str	ip, [r2, #128]
  10434c:	e588a010 	str	sl, [r8, #16]
  104350:	e583c080 	str	ip, [r3, #128]
  104354:	e588a030 	str	sl, [r8, #48]
  104358:	e504c00b 	str	ip, [r4, #-11]
  10435c:	e5815014 	str	r5, [r1, #20]
  104360:	e1a0200c 	mov	r2, ip
  104364:	e5815020 	str	r5, [r1, #32]
  104368:	e59f3748 	ldr	r3, [pc, #1864]	; 104ab8 <prog+0x4a74>
  10436c:	e581c030 	str	ip, [r1, #48]
  104370:	e58ec000 	str	ip, [lr]
  104374:	e581c034 	str	ip, [r1, #52]
  104378:	e3a0000b 	mov	r0, #11	; 0xb
  10437c:	e581c038 	str	ip, [r1, #56]
  104380:	e581c03c 	str	ip, [r1, #60]
  104384:	e581c004 	str	ip, [r1, #4]
  104388:	e581c008 	str	ip, [r1, #8]
  10438c:	e3a01003 	mov	r1, #3	; 0x3
  104390:	ebfffc74 	bl	103568 <AT91F_AIC_ConfigureIt>
  104394:	e3a03102 	mov	r3, #-2147483648	; 0x80000000
  104398:	e1a039c3 	mov	r3, r3, asr #19
  10439c:	e5836120 	str	r6, [r3, #288]
  1043a0:	e3a00ffa 	mov	r0, #1000	; 0x3e8
  1043a4:	ebfffc09 	bl	1033d0 <vTaskDelay>
  1043a8:	e588a034 	str	sl, [r8, #52]
  1043ac:	ebfffe78 	bl	103d94 <vPortExitCritical>
  1043b0:	e59f9704 	ldr	r9, [pc, #1796]	; 104abc <prog+0x4a78>
  1043b4:	e28da007 	add	sl, sp, #7	; 0x7
  1043b8:	e59b0000 	ldr	r0, [fp]
  1043bc:	e1a0100d 	mov	r1, sp
  1043c0:	e3a02001 	mov	r2, #1	; 0x1
  1043c4:	ebfff789 	bl	1021f0 <xQueueReceive>
  1043c8:	e3500000 	cmp	r0, #0	; 0x0
  1043cc:	0a000033 	beq	1044a0 <vUSBCDCTask+0x25c>
  1043d0:	e59d5000 	ldr	r5, [sp]
  1043d4:	e5953000 	ldr	r3, [r5]
  1043d8:	e3130001 	tst	r3, #1	; 0x1
  1043dc:	0a00002c 	beq	104494 <vUSBCDCTask+0x250>
  1043e0:	e5950004 	ldr	r0, [r5, #4]
  1043e4:	e1a03820 	mov	r3, r0, lsr #16
  1043e8:	e1a08a83 	mov	r8, r3, lsl #21
  1043ec:	e3100001 	tst	r0, #1	; 0x1
  1043f0:	e1a08aa8 	mov	r8, r8, lsr #21
  1043f4:	0a000016 	beq	104454 <vUSBCDCTask+0x210>
  1043f8:	e59f16b4 	ldr	r1, [pc, #1716]	; 104ab4 <prog+0x4a70>
  1043fc:	e5916000 	ldr	r6, [r1]
  104400:	e3560002 	cmp	r6, #2	; 0x2
  104404:	0a00015b 	beq	104978 <prog+0x4934>
  104408:	e3560003 	cmp	r6, #3	; 0x3
  10440c:	1a00013e 	bne	10490c <prog+0x48c8>
  104410:	e59f36a8 	ldr	r3, [pc, #1704]	; 104ac0 <prog+0x4a7c>
  104414:	e5931000 	ldr	r1, [r3]
  104418:	e3510000 	cmp	r1, #0	; 0x0
  10441c:	13a0320b 	movne	r3, #-1342177280	; 0xb0000000
  104420:	03a0320b 	moveq	r3, #-1342177280	; 0xb0000000
  104424:	11a03643 	movne	r3, r3, asr #12
  104428:	13a02001 	movne	r2, #1	; 0x1
  10442c:	01a03643 	moveq	r3, r3, asr #12
  104430:	15832004 	strne	r2, [r3, #4]
  104434:	05831004 	streq	r1, [r3, #4]
  104438:	e59fe674 	ldr	lr, [pc, #1652]	; 104ab4 <prog+0x4a70>
  10443c:	e3a0320b 	mov	r3, #-1342177280	; 0xb0000000
  104440:	e3811c01 	orr	r1, r1, #256	; 0x100
  104444:	e1a03643 	mov	r3, r3, asr #12
  104448:	e3a02000 	mov	r2, #0	; 0x0
  10444c:	e5831008 	str	r1, [r3, #8]
  104450:	e58e2000 	str	r2, [lr]
  104454:	e3100002 	tst	r0, #2	; 0x2
  104458:	0a000056 	beq	1045b8 <vUSBCDCTask+0x374>
  10445c:	e59f164c 	ldr	r1, [pc, #1612]	; 104ab0 <prog+0x4a6c>
  104460:	e2811084 	add	r1, r1, #132	; 0x84
  104464:	e811000a 	ldmda	r1, {r1, r3}
  104468:	e0433001 	sub	r3, r3, r1
  10446c:	e20340ff 	and	r4, r3, #255	; 0xff
  104470:	e59f3634 	ldr	r3, [pc, #1588]	; 104aac <prog+0x4a68>
  104474:	e1580004 	cmp	r8, r4
  104478:	e5932084 	ldr	r2, [r3, #132]
  10447c:	320840ff 	andcc	r4, r8, #255	; 0xff
  104480:	e3540000 	cmp	r4, #0	; 0x0
  104484:	e5832080 	str	r2, [r3, #128]
  104488:	e59f6620 	ldr	r6, [pc, #1568]	; 104ab0 <prog+0x4a6c>
  10448c:	1a000041 	bne	104598 <vUSBCDCTask+0x354>
  104490:	e59d5000 	ldr	r5, [sp]
  104494:	e5953000 	ldr	r3, [r5]
  104498:	e3130a01 	tst	r3, #4096	; 0x1000
  10449c:	1a00008b 	bne	1046d0 <prog+0x468c>
  1044a0:	e59f260c 	ldr	r2, [pc, #1548]	; 104ab4 <prog+0x4a70>
  1044a4:	e5923000 	ldr	r3, [r2]
  1044a8:	e3530005 	cmp	r3, #5	; 0x5
  1044ac:	1affffc1 	bne	1043b8 <vUSBCDCTask+0x174>
  1044b0:	e59fe5ec 	ldr	lr, [pc, #1516]	; 104aa4 <prog+0x4a60>
  1044b4:	e5de3000 	ldrb	r3, [lr]
  1044b8:	e3530000 	cmp	r3, #0	; 0x0
  1044bc:	0affffbd 	beq	1043b8 <vUSBCDCTask+0x174>
  1044c0:	e3a0520b 	mov	r5, #-1342177280	; 0xb0000000
  1044c4:	e1a05645 	mov	r5, r5, asr #12
  1044c8:	e5953038 	ldr	r3, [r5, #56]
  1044cc:	e2134010 	ands	r4, r3, #16	; 0x10
  1044d0:	0a000110 	beq	104918 <prog+0x48d4>
  1044d4:	e3a0420b 	mov	r4, #-1342177280	; 0xb0000000
  1044d8:	e1a04644 	mov	r4, r4, asr #12
  1044dc:	e5943034 	ldr	r3, [r4, #52]
  1044e0:	e3130042 	tst	r3, #66	; 0x42
  1044e4:	0affffb3 	beq	1043b8 <vUSBCDCTask+0x174>
  1044e8:	e5943034 	ldr	r3, [r4, #52]
  1044ec:	e5970000 	ldr	r0, [r7]
  1044f0:	e1a03823 	mov	r3, r3, lsr #16
  1044f4:	e1a05a83 	mov	r5, r3, lsl #21
  1044f8:	ebfff707 	bl	10211c <uxQueueMessagesWaiting>
  1044fc:	e1a05aa5 	mov	r5, r5, lsr #21
  104500:	e2600b01 	rsb	r0, r0, #1024	; 0x400
  104504:	e1550000 	cmp	r5, r0
  104508:	2affffaa 	bcs	1043b8 <vUSBCDCTask+0x174>
  10450c:	e3550000 	cmp	r5, #0	; 0x0
  104510:	11a06004 	movne	r6, r4
  104514:	13a04000 	movne	r4, #0	; 0x0
  104518:	0a000008 	beq	104540 <vUSBCDCTask+0x2fc>
  10451c:	e5963054 	ldr	r3, [r6, #84]
  104520:	e2844001 	add	r4, r4, #1	; 0x1
  104524:	e5970000 	ldr	r0, [r7]
  104528:	e1a0100a 	mov	r1, sl
  10452c:	e3a02000 	mov	r2, #0	; 0x0
  104530:	e5cd3007 	strb	r3, [sp, #7]
  104534:	ebfff792 	bl	102384 <xQueueSend>
  104538:	e1550004 	cmp	r5, r4
  10453c:	1afffff6 	bne	10451c <vUSBCDCTask+0x2d8>
  104540:	e3a0420b 	mov	r4, #-1342177280	; 0xb0000000
  104544:	ebfffe07 	bl	103d68 <vPortEnterCritical>
  104548:	e1a04644 	mov	r4, r4, asr #12
  10454c:	e59fe54c 	ldr	lr, [pc, #1356]	; 104aa0 <prog+0x4a5c>
  104550:	e5943034 	ldr	r3, [r4, #52]
  104554:	e59e2000 	ldr	r2, [lr]
  104558:	e383304f 	orr	r3, r3, #79	; 0x4f
  10455c:	e1e02002 	mvn	r2, r2
  104560:	e3c33030 	bic	r3, r3, #48	; 0x30
  104564:	e0033002 	and	r3, r3, r2
  104568:	e5843034 	str	r3, [r4, #52]
  10456c:	ebfffe08 	bl	103d94 <vPortExitCritical>
  104570:	e3a02002 	mov	r2, #2	; 0x2
  104574:	e5842010 	str	r2, [r4, #16]
  104578:	e59f1520 	ldr	r1, [pc, #1312]	; 104aa0 <prog+0x4a5c>
  10457c:	e5913000 	ldr	r3, [r1]
  104580:	e1530002 	cmp	r3, r2
  104584:	159f3514 	ldrne	r3, [pc, #1300]	; 104aa0 <prog+0x4a5c>
  104588:	03a03040 	moveq	r3, #64	; 0x40
  10458c:	05813000 	streq	r3, [r1]
  104590:	15832000 	strne	r2, [r3]
  104594:	eaffffce 	b	1044d4 <vUSBCDCTask+0x290>
  104598:	e1a00006 	mov	r0, r6
  10459c:	e2851008 	add	r1, r5, #8	; 0x8
  1045a0:	e1a02004 	mov	r2, r4
  1045a4:	ebffef1f 	bl	100228 <memcpy>
  1045a8:	e5963080 	ldr	r3, [r6, #128]
  1045ac:	e0843003 	add	r3, r4, r3
  1045b0:	e5863080 	str	r3, [r6, #128]
  1045b4:	e5950004 	ldr	r0, [r5, #4]
  1045b8:	e3100004 	tst	r0, #4	; 0x4
  1045bc:	0a000021 	beq	104648 <vUSBCDCTask+0x404>
  1045c0:	e3580007 	cmp	r8, #7	; 0x7
  1045c4:	9a00001f 	bls	104648 <vUSBCDCTask+0x404>
  1045c8:	e5d53008 	ldrb	r3, [r5, #8]
  1045cc:	e5c93000 	strb	r3, [r9]
  1045d0:	e5d52009 	ldrb	r2, [r5, #9]
  1045d4:	e5c92001 	strb	r2, [r9, #1]
  1045d8:	e5d5300b 	ldrb	r3, [r5, #11]
  1045dc:	e1a03403 	mov	r3, r3, lsl #8
  1045e0:	e1c930b2 	strh	r3, [r9, #2]
  1045e4:	e5d5200a 	ldrb	r2, [r5, #10]
  1045e8:	e1833002 	orr	r3, r3, r2
  1045ec:	e1c930b2 	strh	r3, [r9, #2]
  1045f0:	e5d5200d 	ldrb	r2, [r5, #13]
  1045f4:	e1a02402 	mov	r2, r2, lsl #8
  1045f8:	e1c920b4 	strh	r2, [r9, #4]
  1045fc:	e5d5300c 	ldrb	r3, [r5, #12]
  104600:	e1822003 	orr	r2, r2, r3
  104604:	e1c920b4 	strh	r2, [r9, #4]
  104608:	e5d5300f 	ldrb	r3, [r5, #15]
  10460c:	e1a03403 	mov	r3, r3, lsl #8
  104610:	e1c930b6 	strh	r3, [r9, #6]
  104614:	e5d92000 	ldrb	r2, [r9]
  104618:	e5d5100e 	ldrb	r1, [r5, #14]
  10461c:	e59fe48c 	ldr	lr, [pc, #1164]	; 104ab0 <prog+0x4a6c>
  104620:	e3120080 	tst	r2, #128	; 0x80
  104624:	e1833001 	orr	r3, r3, r1
  104628:	e3a02000 	mov	r2, #0	; 0x0
  10462c:	e1c930b6 	strh	r3, [r9, #6]
  104630:	e58e2080 	str	r2, [lr, #128]
  104634:	1a0000eb 	bne	1049e8 <prog+0x49a4>
  104638:	e3530080 	cmp	r3, #128	; 0x80
  10463c:	958e3084 	strls	r3, [lr, #132]
  104640:	95950004 	ldrls	r0, [r5, #4]
  104644:	8a00001c 	bhi	1046bc <prog+0x4678>
  104648:	e3100006 	tst	r0, #6	; 0x6
  10464c:	0affff8f 	beq	104490 <vUSBCDCTask+0x24c>
  104650:	e59f1458 	ldr	r1, [pc, #1112]	; 104ab0 <prog+0x4a6c>
  104654:	e2812080 	add	r2, r1, #128	; 0x80
  104658:	e892000c 	ldmia	r2, {r2, r3}
  10465c:	e1520003 	cmp	r2, r3
  104660:	3affff8a 	bcc	104490 <vUSBCDCTask+0x24c>
  104664:	e5d93000 	ldrb	r3, [r9]
  104668:	e2032060 	and	r2, r3, #96	; 0x60
  10466c:	e2033003 	and	r3, r3, #3	; 0x3
  104670:	e18331a2 	orr	r3, r3, r2, lsr #3
  104674:	e3530005 	cmp	r3, #5	; 0x5
  104678:	979ff103 	ldrls	pc, [pc, r3, lsl #2]
  10467c:	ea00000e 	b	1046bc <prog+0x4678>
  104680:	00104760 	andeqs	r4, r0, r0, ror #14
  104684:	00104734 	andeqs	r4, r0, r4, lsr r7
  104688:	001046bc 	ldreqh	r4, [r0], -ip
  10468c:	001046bc 	ldreqh	r4, [r0], -ip
  104690:	001046bc 	ldreqh	r4, [r0], -ip
  104694:	001047a0 	andeqs	r4, r0, r0, lsr #15
  104698:	e1d920b2 	ldrh	r2, [r9, #2]
  10469c:	e1a03422 	mov	r3, r2, lsr #8
  1046a0:	e3530002 	cmp	r3, #2	; 0x2
  1046a4:	e59f1410 	ldr	r1, [pc, #1040]	; 104abc <prog+0x4a78>
  1046a8:	0a0000e5 	beq	104a44 <prog+0x4a00>
  1046ac:	e3530003 	cmp	r3, #3	; 0x3
  1046b0:	0a0000d5 	beq	104a0c <prog+0x49c8>
  1046b4:	e3530001 	cmp	r3, #1	; 0x1
  1046b8:	0a0000cd 	beq	1049f4 <prog+0x49b0>
  1046bc:	ebfffe66 	bl	10405c <prvSendStall>
  1046c0:	e59d5000 	ldr	r5, [sp]
  1046c4:	e5953000 	ldr	r3, [r5]
  1046c8:	e3130a01 	tst	r3, #4096	; 0x1000
  1046cc:	0affff73 	beq	1044a0 <vUSBCDCTask+0x25c>
  1046d0:	e59f33cc 	ldr	r3, [pc, #972]	; 104aa4 <prog+0x4a60>
  1046d4:	e3a02000 	mov	r2, #0	; 0x0
  1046d8:	e3a0420b 	mov	r4, #-1342177280	; 0xb0000000
  1046dc:	e1a04644 	mov	r4, r4, asr #12
  1046e0:	e5c32000 	strb	r2, [r3]
  1046e4:	e59fe3c8 	ldr	lr, [pc, #968]	; 104ab4 <prog+0x4a70>
  1046e8:	e3a0300f 	mov	r3, #15	; 0xf
  1046ec:	e5843028 	str	r3, [r4, #40]
  1046f0:	e3a05001 	mov	r5, #1	; 0x1
  1046f4:	e28330f1 	add	r3, r3, #241	; 0xf1
  1046f8:	e5842028 	str	r2, [r4, #40]
  1046fc:	e58e5000 	str	r5, [lr]
  104700:	e5843008 	str	r3, [r4, #8]
  104704:	ebfffd97 	bl	103d68 <vPortEnterCritical>
  104708:	e5943030 	ldr	r3, [r4, #48]
  10470c:	e383304f 	orr	r3, r3, #79	; 0x4f
  104710:	e3c33030 	bic	r3, r3, #48	; 0x30
  104714:	e3833902 	orr	r3, r3, #32768	; 0x8000
  104718:	e5843030 	str	r3, [r4, #48]
  10471c:	e5845010 	str	r5, [r4, #16]
  104720:	ebfffd9b 	bl	103d94 <vPortExitCritical>
  104724:	e59f1374 	ldr	r1, [pc, #884]	; 104aa0 <prog+0x4a5c>
  104728:	e3a03002 	mov	r3, #2	; 0x2
  10472c:	e5813000 	str	r3, [r1]
  104730:	eaffff5a 	b	1044a0 <vUSBCDCTask+0x25c>
  104734:	e5d93001 	ldrb	r3, [r9, #1]
  104738:	e3a0e000 	mov	lr, #0	; 0x0
  10473c:	e3530000 	cmp	r3, #0	; 0x0
  104740:	e1cde0b4 	strh	lr, [sp, #4]
  104744:	1affffdc 	bne	1046bc <prog+0x4678>
  104748:	e3a01002 	mov	r1, #2	; 0x2
  10474c:	e28d0004 	add	r0, sp, #4	; 0x4
  104750:	e1a02001 	mov	r2, r1
  104754:	ebfffe9c 	bl	1041cc <prvSendControlData>
  104758:	e59d5000 	ldr	r5, [sp]
  10475c:	eaffff4c 	b	104494 <vUSBCDCTask+0x250>
  104760:	e5d93001 	ldrb	r3, [r9, #1]
  104764:	e3a02000 	mov	r2, #0	; 0x0
  104768:	e1cd20b4 	strh	r2, [sp, #4]
  10476c:	e3530009 	cmp	r3, #9	; 0x9
  104770:	979ff103 	ldrls	pc, [pc, r3, lsl #2]
  104774:	eaffffd0 	b	1046bc <prog+0x4678>
  104778:	00104860 	andeqs	r4, r0, r0, ror #16
  10477c:	001046bc 	ldreqh	r4, [r0], -ip
  104780:	001046bc 	ldreqh	r4, [r0], -ip
  104784:	00104854 	andeqs	r4, r0, r4, asr r8
  104788:	001046bc 	ldreqh	r4, [r0], -ip
  10478c:	001048cc 	andeqs	r4, r0, ip, asr #17
  104790:	00104698 	muleqs	r0, r8, r6
  104794:	001046bc 	ldreqh	r4, [r0], -ip
  104798:	001048f0 	ldreqsh	r4, [r0], -r0
  10479c:	0010483c 	andeqs	r4, r0, ip, lsr r8
  1047a0:	e5d93001 	ldrb	r3, [r9, #1]
  1047a4:	e3530022 	cmp	r3, #34	; 0x22
  1047a8:	979ff103 	ldrls	pc, [pc, r3, lsl #2]
  1047ac:	eaffffc2 	b	1046bc <prog+0x4678>
  1047b0:	001046bc 	ldreqh	r4, [r0], -ip
  1047b4:	001046bc 	ldreqh	r4, [r0], -ip
  1047b8:	001046bc 	ldreqh	r4, [r0], -ip
  1047bc:	001046bc 	ldreqh	r4, [r0], -ip
  1047c0:	001046bc 	ldreqh	r4, [r0], -ip
  1047c4:	001046bc 	ldreqh	r4, [r0], -ip
  1047c8:	001046bc 	ldreqh	r4, [r0], -ip
  1047cc:	001046bc 	ldreqh	r4, [r0], -ip
  1047d0:	001046bc 	ldreqh	r4, [r0], -ip
  1047d4:	001046bc 	ldreqh	r4, [r0], -ip
  1047d8:	001046bc 	ldreqh	r4, [r0], -ip
  1047dc:	001046bc 	ldreqh	r4, [r0], -ip
  1047e0:	001046bc 	ldreqh	r4, [r0], -ip
  1047e4:	001046bc 	ldreqh	r4, [r0], -ip
  1047e8:	001046bc 	ldreqh	r4, [r0], -ip
  1047ec:	001046bc 	ldreqh	r4, [r0], -ip
  1047f0:	001046bc 	ldreqh	r4, [r0], -ip
  1047f4:	001046bc 	ldreqh	r4, [r0], -ip
  1047f8:	001046bc 	ldreqh	r4, [r0], -ip
  1047fc:	001046bc 	ldreqh	r4, [r0], -ip
  104800:	001046bc 	ldreqh	r4, [r0], -ip
  104804:	001046bc 	ldreqh	r4, [r0], -ip
  104808:	001046bc 	ldreqh	r4, [r0], -ip
  10480c:	001046bc 	ldreqh	r4, [r0], -ip
  104810:	001046bc 	ldreqh	r4, [r0], -ip
  104814:	001046bc 	ldreqh	r4, [r0], -ip
  104818:	001046bc 	ldreqh	r4, [r0], -ip
  10481c:	001046bc 	ldreqh	r4, [r0], -ip
  104820:	001046bc 	ldreqh	r4, [r0], -ip
  104824:	001046bc 	ldreqh	r4, [r0], -ip
  104828:	001046bc 	ldreqh	r4, [r0], -ip
  10482c:	001046bc 	ldreqh	r4, [r0], -ip
  104830:	0010487c 	andeqs	r4, r0, ip, ror r8
  104834:	00104898 	muleqs	r0, r8, r8
  104838:	001048b4 	ldreqh	r4, [r0], -r4
  10483c:	e1d930b2 	ldrh	r3, [r9, #2]
  104840:	e59f2260 	ldr	r2, [pc, #608]	; 104aa8 <prog+0x4a64>
  104844:	e5c23000 	strb	r3, [r2]
  104848:	e59f3264 	ldr	r3, [pc, #612]	; 104ab4 <prog+0x4a70>
  10484c:	e3a02002 	mov	r2, #2	; 0x2
  104850:	e5832000 	str	r2, [r3]
  104854:	ebfffde6 	bl	103ff4 <prvSendZLP>
  104858:	e59d5000 	ldr	r5, [sp]
  10485c:	eaffff0c 	b	104494 <vUSBCDCTask+0x250>
  104860:	e3a01002 	mov	r1, #2	; 0x2
  104864:	e28d0004 	add	r0, sp, #4	; 0x4
  104868:	e1a02001 	mov	r2, r1
  10486c:	e3a03000 	mov	r3, #0	; 0x0
  104870:	ebfffe55 	bl	1041cc <prvSendControlData>
  104874:	e59d5000 	ldr	r5, [sp]
  104878:	eaffff05 	b	104494 <vUSBCDCTask+0x250>
  10487c:	ebfffddc 	bl	103ff4 <prvSendZLP>
  104880:	e59f023c 	ldr	r0, [pc, #572]	; 104ac4 <prog+0x4a80>
  104884:	e59f1224 	ldr	r1, [pc, #548]	; 104ab0 <prog+0x4a6c>
  104888:	e3a02007 	mov	r2, #7	; 0x7
  10488c:	ebffee65 	bl	100228 <memcpy>
  104890:	e59d5000 	ldr	r5, [sp]
  104894:	eafffefe 	b	104494 <vUSBCDCTask+0x250>
  104898:	e59f0224 	ldr	r0, [pc, #548]	; 104ac4 <prog+0x4a80>
  10489c:	e1d910b6 	ldrh	r1, [r9, #6]
  1048a0:	e3a02007 	mov	r2, #7	; 0x7
  1048a4:	e3a03000 	mov	r3, #0	; 0x0
  1048a8:	ebfffe47 	bl	1041cc <prvSendControlData>
  1048ac:	e59d5000 	ldr	r5, [sp]
  1048b0:	eafffef7 	b	104494 <vUSBCDCTask+0x250>
  1048b4:	ebfffdce 	bl	103ff4 <prvSendZLP>
  1048b8:	e1d930b2 	ldrh	r3, [r9, #2]
  1048bc:	e59f11e0 	ldr	r1, [pc, #480]	; 104aa4 <prog+0x4a60>
  1048c0:	e59d5000 	ldr	r5, [sp]
  1048c4:	e5c13000 	strb	r3, [r1]
  1048c8:	eafffef1 	b	104494 <vUSBCDCTask+0x250>
  1048cc:	ebfffdc8 	bl	103ff4 <prvSendZLP>
  1048d0:	e1d920b2 	ldrh	r2, [r9, #2]
  1048d4:	e59fe1d8 	ldr	lr, [pc, #472]	; 104ab4 <prog+0x4a70>
  1048d8:	e59f11e0 	ldr	r1, [pc, #480]	; 104ac0 <prog+0x4a7c>
  1048dc:	e59d5000 	ldr	r5, [sp]
  1048e0:	e3a03003 	mov	r3, #3	; 0x3
  1048e4:	e58e3000 	str	r3, [lr]
  1048e8:	e5812000 	str	r2, [r1]
  1048ec:	eafffee8 	b	104494 <vUSBCDCTask+0x250>
  1048f0:	e3a01001 	mov	r1, #1	; 0x1
  1048f4:	e59f01ac 	ldr	r0, [pc, #428]	; 104aa8 <prog+0x4a64>
  1048f8:	e1a02001 	mov	r2, r1
  1048fc:	e3a03000 	mov	r3, #0	; 0x0
  104900:	ebfffe31 	bl	1041cc <prvSendControlData>
  104904:	e59d5000 	ldr	r5, [sp]
  104908:	eafffee1 	b	104494 <vUSBCDCTask+0x250>
  10490c:	ebfffddc 	bl	104084 <prvSendNextSegment>
  104910:	e5950004 	ldr	r0, [r5, #4]
  104914:	eafffece 	b	104454 <vUSBCDCTask+0x210>
  104918:	e59f117c 	ldr	r1, [pc, #380]	; 104a9c <prog+0x4a58>
  10491c:	e5910000 	ldr	r0, [r1]
  104920:	ebfff5fd 	bl	10211c <uxQueueMessagesWaiting>
  104924:	e3500000 	cmp	r0, #0	; 0x0
  104928:	0afffee9 	beq	1044d4 <vUSBCDCTask+0x290>
  10492c:	ea000003 	b	104940 <prog+0x48fc>
  104930:	e5dd3007 	ldrb	r3, [sp, #7]
  104934:	e3540040 	cmp	r4, #64	; 0x40
  104938:	e5853058 	str	r3, [r5, #88]
  10493c:	0a000007 	beq	104960 <prog+0x491c>
  104940:	e59f2154 	ldr	r2, [pc, #340]	; 104a9c <prog+0x4a58>
  104944:	e1a0100a 	mov	r1, sl
  104948:	e5920000 	ldr	r0, [r2]
  10494c:	e3a02000 	mov	r2, #0	; 0x0
  104950:	ebfff626 	bl	1021f0 <xQueueReceive>
  104954:	e3500000 	cmp	r0, #0	; 0x0
  104958:	e2844001 	add	r4, r4, #1	; 0x1
  10495c:	1afffff3 	bne	104930 <prog+0x48ec>
  104960:	e3a0220b 	mov	r2, #-1342177280	; 0xb0000000
  104964:	e1a02642 	mov	r2, r2, asr #12
  104968:	e5923038 	ldr	r3, [r2, #56]
  10496c:	e3833010 	orr	r3, r3, #16	; 0x10
  104970:	e5823038 	str	r3, [r2, #56]
  104974:	eafffed6 	b	1044d4 <vUSBCDCTask+0x290>
  104978:	e3a0420b 	mov	r4, #-1342177280	; 0xb0000000
  10497c:	e1a04644 	mov	r4, r4, asr #12
  104980:	e5846004 	str	r6, [r4, #4]
  104984:	ebfffcf7 	bl	103d68 <vPortEnterCritical>
  104988:	e5943034 	ldr	r3, [r4, #52]
  10498c:	e383304f 	orr	r3, r3, #79	; 0x4f
  104990:	e3c33030 	bic	r3, r3, #48	; 0x30
  104994:	e3833c82 	orr	r3, r3, #33280	; 0x8200
  104998:	e5843034 	str	r3, [r4, #52]
  10499c:	e5846010 	str	r6, [r4, #16]
  1049a0:	e5943038 	ldr	r3, [r4, #56]
  1049a4:	e383304f 	orr	r3, r3, #79	; 0x4f
  1049a8:	e3c33030 	bic	r3, r3, #48	; 0x30
  1049ac:	e3a02004 	mov	r2, #4	; 0x4
  1049b0:	e3833c86 	orr	r3, r3, #34304	; 0x8600
  1049b4:	e5843038 	str	r3, [r4, #56]
  1049b8:	e5842010 	str	r2, [r4, #16]
  1049bc:	e594303c 	ldr	r3, [r4, #60]
  1049c0:	e383304f 	orr	r3, r3, #79	; 0x4f
  1049c4:	e3c33030 	bic	r3, r3, #48	; 0x30
  1049c8:	e3833c87 	orr	r3, r3, #34560	; 0x8700
  1049cc:	e584303c 	str	r3, [r4, #60]
  1049d0:	ebfffcef 	bl	103d94 <vPortExitCritical>
  1049d4:	e59f20d8 	ldr	r2, [pc, #216]	; 104ab4 <prog+0x4a70>
  1049d8:	e5950004 	ldr	r0, [r5, #4]
  1049dc:	e3a03005 	mov	r3, #5	; 0x5
  1049e0:	e5823000 	str	r3, [r2]
  1049e4:	eafffe9a 	b	104454 <vUSBCDCTask+0x210>
  1049e8:	e58e2084 	str	r2, [lr, #132]
  1049ec:	e5950004 	ldr	r0, [r5, #4]
  1049f0:	eaffff14 	b	104648 <vUSBCDCTask+0x404>
  1049f4:	e59f00cc 	ldr	r0, [pc, #204]	; 104ac8 <prog+0x4a84>
  1049f8:	e1d910b6 	ldrh	r1, [r9, #6]
  1049fc:	e3a02012 	mov	r2, #18	; 0x12
  104a00:	ebfffdf1 	bl	1041cc <prvSendControlData>
  104a04:	e59d5000 	ldr	r5, [sp]
  104a08:	eafffea1 	b	104494 <vUSBCDCTask+0x250>
  104a0c:	e20230ff 	and	r3, r2, #255	; 0xff
  104a10:	e3530001 	cmp	r3, #1	; 0x1
  104a14:	0a000018 	beq	104a7c <prog+0x4a38>
  104a18:	e3530002 	cmp	r3, #2	; 0x2
  104a1c:	0a00000f 	beq	104a60 <prog+0x4a1c>
  104a20:	e3530000 	cmp	r3, #0	; 0x0
  104a24:	1affff24 	bne	1046bc <prog+0x4678>
  104a28:	e1d110b6 	ldrh	r1, [r1, #6]
  104a2c:	e59f0098 	ldr	r0, [pc, #152]	; 104acc <prog+0x4a88>
  104a30:	e3a02004 	mov	r2, #4	; 0x4
  104a34:	e2833001 	add	r3, r3, #1	; 0x1
  104a38:	ebfffde3 	bl	1041cc <prvSendControlData>
  104a3c:	e59d5000 	ldr	r5, [sp]
  104a40:	eafffe93 	b	104494 <vUSBCDCTask+0x250>
  104a44:	e1d110b6 	ldrh	r1, [r1, #6]
  104a48:	e59f0080 	ldr	r0, [pc, #128]	; 104ad0 <prog+0x4a8c>
  104a4c:	e3a02043 	mov	r2, #67	; 0x43
  104a50:	e3a03001 	mov	r3, #1	; 0x1
  104a54:	ebfffddc 	bl	1041cc <prvSendControlData>
  104a58:	e59d5000 	ldr	r5, [sp]
  104a5c:	eafffe8c 	b	104494 <vUSBCDCTask+0x250>
  104a60:	e1d110b6 	ldrh	r1, [r1, #6]
  104a64:	e59f0068 	ldr	r0, [pc, #104]	; 104ad4 <prog+0x4a90>
  104a68:	e3a0202c 	mov	r2, #44	; 0x2c
  104a6c:	e3a03001 	mov	r3, #1	; 0x1
  104a70:	ebfffdd5 	bl	1041cc <prvSendControlData>
  104a74:	e59d5000 	ldr	r5, [sp]
  104a78:	eafffe85 	b	104494 <vUSBCDCTask+0x250>
  104a7c:	e1d110b6 	ldrh	r1, [r1, #6]
  104a80:	e59f0050 	ldr	r0, [pc, #80]	; 104ad8 <prog+0x4a94>
  104a84:	e3a0201c 	mov	r2, #28	; 0x1c
  104a88:	ebfffdcf 	bl	1041cc <prvSendControlData>
  104a8c:	e59d5000 	ldr	r5, [sp]
  104a90:	eafffe7f 	b	104494 <vUSBCDCTask+0x250>
  104a94:	0020673c 	eoreq	r6, r0, ip, lsr r7
  104a98:	00204e74 	eoreq	r4, r0, r4, ror lr
  104a9c:	00204e70 	eoreq	r4, r0, r0, ror lr
  104aa0:	00204e68 	eoreq	r4, r0, r8, ror #28
  104aa4:	00204e6c 	eoreq	r4, r0, ip, ror #28
  104aa8:	00204e58 	eoreq	r4, r0, r8, asr lr
  104aac:	00204f00 	eoreq	r4, r0, r0, lsl #30
  104ab0:	00204e78 	eoreq	r4, r0, r8, ror lr
  104ab4:	00204e54 	eoreq	r4, r0, r4, asr lr
  104ab8:	00104adc 	ldreqsb	r4, [r0], -ip
  104abc:	00204e60 	eoreq	r4, r0, r0, ror #28
  104ac0:	00204e5c 	eoreq	r4, r0, ip, asr lr
  104ac4:	00105362 	andeqs	r5, r0, r2, ror #6
  104ac8:	00105304 	andeqs	r5, r0, r4, lsl #6
  104acc:	0010535e 	andeqs	r5, r0, lr, asr r3
  104ad0:	001052c1 	andeqs	r5, r0, r1, asr #5
  104ad4:	00105316 	andeqs	r5, r0, r6, lsl r3
  104ad8:	00105342 	andeqs	r5, r0, r2, asr #6

00104adc <vUSB_ISR>:
  104adc:	e92d0001 	stmdb	sp!, {r0}
  104ae0:	e94d2000 	stmdb	sp, {sp}^
  104ae4:	e1a00000 	nop			(mov r0,r0)
  104ae8:	e24dd004 	sub	sp, sp, #4	; 0x4
  104aec:	e8bd0001 	ldmia	sp!, {r0}
  104af0:	e9204000 	stmdb	r0!, {lr}
  104af4:	e1a0e000 	mov	lr, r0
  104af8:	e8bd0001 	ldmia	sp!, {r0}
  104afc:	e94e7fff 	stmdb	lr, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, sp, lr}^
  104b00:	e1a00000 	nop			(mov r0,r0)
  104b04:	e24ee03c 	sub	lr, lr, #60	; 0x3c
  104b08:	e14f0000 	mrs	r0, SPSR
  104b0c:	e92e0001 	stmdb	lr!, {r0}
  104b10:	e59f0204 	ldr	r0, [pc, #516]	; 104d1c <prog+0x4cd8>
  104b14:	e5900000 	ldr	r0, [r0]
  104b18:	e92e0001 	stmdb	lr!, {r0}
  104b1c:	e59f01fc 	ldr	r0, [pc, #508]	; 104d20 <prog+0x4cdc>
  104b20:	e5900000 	ldr	r0, [r0]
  104b24:	e580e000 	str	lr, [r0]
  104b28:	e59f71d8 	ldr	r7, [pc, #472]	; 104d08 <prog+0x4cc4>
  104b2c:	e59f61d8 	ldr	r6, [pc, #472]	; 104d0c <prog+0x4cc8>
  104b30:	e5973000 	ldr	r3, [r7]
  104b34:	e5962000 	ldr	r2, [r6]
  104b38:	e24eb004 	sub	fp, lr, #4	; 0x4
  104b3c:	e59f21cc 	ldr	r2, [pc, #460]	; 104d10 <prog+0x4ccc>
  104b40:	e5920000 	ldr	r0, [r2]
  104b44:	e5923000 	ldr	r3, [r2]
  104b48:	e2833001 	add	r3, r3, #1	; 0x1
  104b4c:	e5823000 	str	r3, [r2]
  104b50:	e3a0120b 	mov	r1, #-1342177280	; 0xb0000000
  104b54:	e1a01641 	mov	r1, r1, asr #12
  104b58:	e591501c 	ldr	r5, [r1, #28]
  104b5c:	e591c030 	ldr	ip, [r1, #48]
  104b60:	e59f41ac 	ldr	r4, [pc, #428]	; 104d14 <prog+0x4cd0>
  104b64:	e5913018 	ldr	r3, [r1, #24]
  104b68:	e2000003 	and	r0, r0, #3	; 0x3
  104b6c:	e1a00200 	mov	r0, r0, lsl #4
  104b70:	e1a0e82c 	mov	lr, ip, lsr #16
  104b74:	e0802004 	add	r2, r0, r4
  104b78:	e3833a01 	orr	r3, r3, #4096	; 0x1000
  104b7c:	e1a0ea8e 	mov	lr, lr, lsl #21
  104b80:	e31c0006 	tst	ip, #6	; 0x6
  104b84:	e7805004 	str	r5, [r0, r4]
  104b88:	e5813020 	str	r3, [r1, #32]
  104b8c:	e582c004 	str	ip, [r2, #4]
  104b90:	e58d2000 	str	r2, [sp]
  104b94:	e1a0eaae 	mov	lr, lr, lsr #21
  104b98:	0a000018 	beq	104c00 <vUSB_ISR+0x124>
  104b9c:	e35e0000 	cmp	lr, #0	; 0x0
  104ba0:	13a0c20b 	movne	ip, #-1342177280	; 0xb0000000
  104ba4:	11a0c64c 	movne	ip, ip, asr #12
  104ba8:	13a00000 	movne	r0, #0	; 0x0
  104bac:	0a000007 	beq	104bd0 <vUSB_ISR+0xf4>
  104bb0:	e59d2000 	ldr	r2, [sp]
  104bb4:	e2803001 	add	r3, r0, #1	; 0x1
  104bb8:	e0802002 	add	r2, r0, r2
  104bbc:	e59c1050 	ldr	r1, [ip, #80]
  104bc0:	e20300ff 	and	r0, r3, #255	; 0xff
  104bc4:	e15e0000 	cmp	lr, r0
  104bc8:	e5c21008 	strb	r1, [r2, #8]
  104bcc:	8afffff7 	bhi	104bb0 <vUSB_ISR+0xd4>
  104bd0:	e3a0120b 	mov	r1, #-1342177280	; 0xb0000000
  104bd4:	e1a01641 	mov	r1, r1, asr #12
  104bd8:	e5913030 	ldr	r3, [r1, #48]
  104bdc:	e3130004 	tst	r3, #4	; 0x4
  104be0:	1a000031 	bne	104cac <vUSB_ISR+0x1d0>
  104be4:	e5913030 	ldr	r3, [r1, #48]
  104be8:	e3c33002 	bic	r3, r3, #2	; 0x2
  104bec:	e5813030 	str	r3, [r1, #48]
  104bf0:	e1a02001 	mov	r2, r1
  104bf4:	e5923030 	ldr	r3, [r2, #48]
  104bf8:	e3130002 	tst	r3, #2	; 0x2
  104bfc:	1afffffc 	bne	104bf4 <vUSB_ISR+0x118>
  104c00:	e3a0120b 	mov	r1, #-1342177280	; 0xb0000000
  104c04:	e1a01641 	mov	r1, r1, asr #12
  104c08:	e5913034 	ldr	r3, [r1, #52]
  104c0c:	e3130042 	tst	r3, #66	; 0x42
  104c10:	13a03002 	movne	r3, #2	; 0x2
  104c14:	15813014 	strne	r3, [r1, #20]
  104c18:	e5913030 	ldr	r3, [r1, #48]
  104c1c:	e3c33009 	bic	r3, r3, #9	; 0x9
  104c20:	e5813030 	str	r3, [r1, #48]
  104c24:	e5912034 	ldr	r2, [r1, #52]
  104c28:	e3c2200d 	bic	r2, r2, #13	; 0xd
  104c2c:	e5812034 	str	r2, [r1, #52]
  104c30:	e5913038 	ldr	r3, [r1, #56]
  104c34:	e3c3304f 	bic	r3, r3, #79	; 0x4f
  104c38:	e5813038 	str	r3, [r1, #56]
  104c3c:	e591203c 	ldr	r2, [r1, #60]
  104c40:	e59f30d0 	ldr	r3, [pc, #208]	; 104d18 <prog+0x4cd4>
  104c44:	e3c2204f 	bic	r2, r2, #79	; 0x4f
  104c48:	e581203c 	str	r2, [r1, #60]
  104c4c:	e5930000 	ldr	r0, [r3]
  104c50:	e3a02000 	mov	r2, #0	; 0x0
  104c54:	e1a0100d 	mov	r1, sp
  104c58:	ebfff4dd 	bl	101fd4 <xQueueSendFromISR>
  104c5c:	e3a03102 	mov	r3, #-2147483648	; 0x80000000
  104c60:	e1a039c3 	mov	r3, r3, asr #19
  104c64:	e3a02000 	mov	r2, #0	; 0x0
  104c68:	e31000ff 	tst	r0, #255	; 0xff
  104c6c:	e5832130 	str	r2, [r3, #304]
  104c70:	1bfff78c 	blne	102aa8 <vTaskSwitchContext>
  104c74:	e59f00a4 	ldr	r0, [pc, #164]	; 104d20 <prog+0x4cdc>
  104c78:	e5900000 	ldr	r0, [r0]
  104c7c:	e590e000 	ldr	lr, [r0]
  104c80:	e59f0094 	ldr	r0, [pc, #148]	; 104d1c <prog+0x4cd8>
  104c84:	e8be0002 	ldmia	lr!, {r1}
  104c88:	e5801000 	str	r1, [r0]
  104c8c:	e8be0001 	ldmia	lr!, {r0}
  104c90:	e169f000 	msr	SPSR_fc, r0
  104c94:	e8de7fff 	ldmia	lr, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, sp, lr}^
  104c98:	e1a00000 	nop			(mov r0,r0)
  104c9c:	e59ee03c 	ldr	lr, [lr, #60]
  104ca0:	e25ef004 	subs	pc, lr, #4	; 0x4
  104ca4:	e5973000 	ldr	r3, [r7]
  104ca8:	e5962000 	ldr	r2, [r6]
  104cac:	e35e0000 	cmp	lr, #0	; 0x0
  104cb0:	1a000008 	bne	104cd8 <vUSB_ISR+0x1fc>
  104cb4:	e3a0220b 	mov	r2, #-1342177280	; 0xb0000000
  104cb8:	e1a02642 	mov	r2, r2, asr #12
  104cbc:	e5923030 	ldr	r3, [r2, #48]
  104cc0:	e3c33004 	bic	r3, r3, #4	; 0x4
  104cc4:	e5823030 	str	r3, [r2, #48]
  104cc8:	e5923030 	ldr	r3, [r2, #48]
  104ccc:	e3130004 	tst	r3, #4	; 0x4
  104cd0:	1afffffc 	bne	104cc8 <vUSB_ISR+0x1ec>
  104cd4:	eaffffc9 	b	104c00 <vUSB_ISR+0x124>
  104cd8:	e59d3000 	ldr	r3, [sp]
  104cdc:	e5d32008 	ldrb	r2, [r3, #8]
  104ce0:	e3120080 	tst	r2, #128	; 0x80
  104ce4:	0afffff2 	beq	104cb4 <vUSB_ISR+0x1d8>
  104ce8:	e5913030 	ldr	r3, [r1, #48]
  104cec:	e3833080 	orr	r3, r3, #128	; 0x80
  104cf0:	e5813030 	str	r3, [r1, #48]
  104cf4:	e1a02001 	mov	r2, r1
  104cf8:	e5923030 	ldr	r3, [r2, #48]
  104cfc:	e3130080 	tst	r3, #128	; 0x80
  104d00:	0afffffc 	beq	104cf8 <vUSB_ISR+0x21c>
  104d04:	eaffffea 	b	104cb4 <vUSB_ISR+0x1d8>
  104d08:	00200000 	eoreq	r0, r0, r0
  104d0c:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  104d10:	00204f88 	eoreq	r4, r0, r8, lsl #31
  104d14:	00204f8c 	eoreq	r4, r0, ip, lsl #31
  104d18:	0020673c 	eoreq	r6, r0, ip, lsr r7
  104d1c:	00200000 	eoreq	r0, r0, r0
  104d20:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  104d24:	00425355 	subeq	r5, r2, r5, asr r3

00104d28 <broadcast_mac>:
  104d28:	02030201 00000001 003a5852 0000002c     ........RX:.,...
  104d38:	5f46526e 78547852 00000000 5f46526e     nRF_RxTx....nRF_
  104d48:	69746152 0000676e 53202a20 63746977     Rating.. * Switc
  104d58:	20646568 74206f74 736e6172 2074696d     hed to transmit 
  104d68:	65646f6d 20746120 65776f70 656c2072     mode at power le
  104d78:	206c6576 00000000 73202a20 63746977     vel .... * switc
  104d88:	20646568 52206f74 6f6d2058 0d0a6564     hed to RX mode..
  104d98:	00000000 53202a20 65726f74 6e652064     .... * Stored en
  104da8:	6f726976 6e656d6e 61762074 62616972     vironment variab
  104db8:	0a73656c 0000000d 49202a20 6c61766e     les..... * Inval
  104dc8:	46206469 204f4649 68636163 696c2065     id FIFO cache li
  104dd8:	69746566 7020656d 6d617261 72657465     fetime parameter
  104de8:	00000d0a 4f464946 66696c20 6d697465     ....FIFO lifetim
  104df8:	65732065 6f742074 00000020 64616552     e set to ...Read
  104e08:	49207265 65732044 6f742074 00000020     er ID set to ...
  104e18:	2a2a2a20 2a2a2a2a 2a2a2a2a 2a2a2a2a      ***************
  104e28:	2a2a2a2a 2a2a2a2a 2a2a2a2a 2a2a2a2a     ****************
  104e38:	2a2a2a2a 2a2a2a2a 2a2a2a2a 2a2a2a2a     ****************
  104e48:	2a2a2a2a 0d0a2a2a 43202a20 65727275     ******.. * Curre
  104e58:	6320746e 69666e6f 61727567 6e6f6974     nt configuration
  104e68:	2020203a 20202020 20202020 20202020     :               
  104e78:	20202020 20202020 20202020 0d0a2a20                  *..
  104e88:	2a2a2a20 2a2a2a2a 2a2a2a2a 2a2a2a2a      ***************
  104e98:	2a2a2a2a 2a2a2a2a 2a2a2a2a 2a2a2a2a     ****************
  104ea8:	2a2a2a2a 2a2a2a2a 2a2a2a2a 2a2a2a2a     ****************
  104eb8:	2a2a2a2a 0d0a2a2a 0d0a2a20 00000000     ******.. *......
  104ec8:	55202a20 6d697470 73692065 00000020      * Uptime is ...
  104ed8:	00003a68 00003a6d 00000073 54202a20     h:..m:..s... * T
  104ee8:	72206568 65646165 64692072 20736920     he reader id is 
  104ef8:	00000000 54202a20 6d206568 2065646f     .... * The mode 
  104f08:	00207369 54202a20 63206568 6e6e6168     is . * The chann
  104f18:	69206c65 00002073 54202a20 46206568     el is .. * The F
  104f28:	204f4649 68636163 696c2065 69746566     IFO cache lifeti
  104f38:	6920656d 00002073 000d0a73 0d0a2a20     me is ..s... *..
  104f48:	2a2a2a20 2a2a2a2a 2a2a2a2a 2a2a2a2a      ***************
  104f58:	2a2a2a2a 2a2a2a2a 2a2a2a2a 2a2a2a2a     ****************
  104f68:	2a2a2a2a 2a2a2a2a 2a2a2a2a 2a2a2a2a     ****************
  104f78:	2a2a2a2a 0d0a2a2a 00000000 2a2a2a20     ******...... ***
  104f88:	2a2a2a2a 2a2a2a2a 2a2a2a2a 2a2a2a2a     ****************
  104f98:	2a2a2a2a 2a2a2a2a 2a2a2a2a 2a2a2a2a     ****************
  104fa8:	2a2a2a2a 2a2a2a2a 2a2a2a2a 2a2a2a2a     ****************
  104fb8:	0d0a2a2a 4f202a20 426e6570 6f636165     **.. * OpenBeaco
  104fc8:	5355206e 65742042 6e696d72 20206c61     n USB terminal  
  104fd8:	20202020 20202020 20202020 20202020                     
  104fe8:	20202020 20202020 0d0a2a20 28202a20              *.. * (
  104ff8:	32202943 20373030 6f6c694d 20686373     C) 2007 Milosch 
  105008:	6972654d 3c206361 6972656d 6f406361     Meriac <meriac@o
  105018:	626e6570 6f636165 65642e6e 2020203e     penbeacon.de>   
  105028:	0d0a2a20 2a2a2a20 2a2a2a2a 2a2a2a2a      *.. ***********
  105038:	2a2a2a2a 2a2a2a2a 2a2a2a2a 2a2a2a2a     ****************
  105048:	2a2a2a2a 2a2a2a2a 2a2a2a2a 2a2a2a2a     ****************
  105058:	2a2a2a2a 2a2a2a2a 0d0a2a2a 0d0a2a20     **********.. *..
  105068:	53202a20 20202020 20202020 202d2020      * S          - 
  105078:	726f7473 72742065 6d736e61 65747469     store transmitte
  105088:	65732072 6e697474 0d0a7367 43202a20     r settings.. * C
  105098:	20202020 20202020 202d2020 6e697270               - prin
  1050a8:	6f632074 6769666e 74617275 0a6e6f69     t configuration.
  1050b8:	202a200d 695b2049 20205d64 2d202020     . * I [id]     -
  1050c8:	74657320 61657220 20726564 0d0a6469      set reader id..
  1050d8:	46202a20 204f4649 6365735b 202d205d      * FIFO [sec] - 
  1050e8:	20746573 4f464946 63616320 6c206568     set FIFO cache l
  1050f8:	74656669 20656d69 73206e69 6e6f6365     ifetime in secon
  105108:	0d0a7364 30202a20 20202020 20202020     ds.. * 0        
  105118:	202d2020 65636572 20657669 796c6e6f       - receive only
  105128:	646f6d20 200d0a65 2e31202a 2020342e      mode.. * 1..4  
  105138:	20202020 61202d20 6d6f7475 63697461          - automatic
  105148:	61727420 696d736e 74612074 6c657320      transmit at sel
  105158:	65746365 6f702064 20726577 6576656c     ected power leve
  105168:	0d0a736c 3f202a20 2020482c 20202020     ls.. * ?,H      
  105178:	202d2020 70736964 2079616c 73696874       - display this
  105188:	6c656820 63732070 6e656572 2a200d0a      help screen.. *
  105198:	2a200d0a 2a2a2a2a 2a2a2a2a 2a2a2a2a     .. *************
  1051a8:	2a2a2a2a 2a2a2a2a 2a2a2a2a 2a2a2a2a     ****************
  1051b8:	2a2a2a2a 2a2a2a2a 2a2a2a2a 2a2a2a2a     ****************
  1051c8:	2a2a2a2a 2a2a2a2a 00000d0a 203a6449     ********....Id: 
  1051d8:	00000000 65646f4d 0000203a 69747055     ....Mode: ..Upti
  1051e8:	203a656d 00000000 6e616843 3a6c656e     me: ....Channel:
  1051f8:	00000020 4f464946 6566694c 656d6974      ...FIFOLifetime
  105208:	0000203a 6d6d6f43 20646e61 65636572     : ..Command rece
  105218:	64657669 0000003a 75657551 75662065     ived:...Queue fu
  105228:	202c6c6c 6d6d6f63 20646e61 276e6163     ll, command can'
  105238:	65622074 6f727020 73736563 0a2e6465     t be processed..
  105248:	00000000 4f525245 43203a52 616d6d6f     ....ERROR: Comma
  105258:	7420646e 6c206f6f 2e676e6f 6e674920     nd too long. Ign
  105268:	6465726f 0000002e 00444d43 55444d43     ored....CMD.CMDU
  105278:	00004253                                SB..

0010527c <C.41.3545>:
	...

001052a0 <tea_key>:
  1052a0:	8e7d6649 7e82fa5b ddd4541e e23742cb     If}.[..~.T...B7.

001052b0 <rfbroadcast_mac>:
  1052b0:	43415354 00735042                                TSACB

001052b5 <ACTIVATE_SEQUENCE.1695>:
  1052b5:	00007350                                         Ps

001052b7 <C.7.1697>:
  1052b7:	00000000 4c444900 02090045                       .....IDLE.

001052c1 <pxConfigDescriptor>:
  1052c1:	00430209 80000102 00040932 02020100     ..C.....2.......
  1052d1:	24050401 04011000 05000224 01000624     ...$....$...$...
  1052e1:	00012405 83050701 ff000803 00010409     .$..............
  1052f1:	00000a02 01050700 00004002 02820507     .........@......
  105301:	12000040                                         @..

00105304 <pxDeviceDescriptor>:
  105304:	01100112 08000002 08ac16c0 02010110     ................
  105314:	032c0100                                         ..

00105316 <pxProductStringDescriptor>:
  105316:	004f032c 00650070 0042006e 00610065     ,.O.p.e.n.B.e.a.
  105326:	006f0063 0020006e 00530055 00200042     c.o.n. .U.S.B. .
  105336:	002e0032 00470034 007a0048              2...4.G.H.z.

00105342 <pxManufacturerStringDescriptor>:
  105342:	0062031c 00740069 0061006d 0075006e     ..b.i.t.m.a.n.u.
  105352:	00610066 0074006b 00720075              f.a.k.t.u.r.

0010535e <pxLanguageStringDescriptor>:
  10535e:	04090304                                ....

00105362 <pxLineCoding>:
  105362:	0001c200 00080000 00000000                       ..........
Disassembly of section .data:

00200000 <__data_beg__>:
  200000:	0000270f 	andeq	r2, r0, pc, lsl #14

00200004 <shuffle_tx_byteorder>:
  200004:	e92d4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
  200008:	e59f30a0 	ldr	r3, [pc, #160]	; 2000b0 <.data+0xb0>
  20000c:	e5d32005 	ldrb	r2, [r3, #5]
  200010:	e24dd00c 	sub	sp, sp, #12	; 0xc
  200014:	e58d2000 	str	r2, [sp]
  200018:	e5d32008 	ldrb	r2, [r3, #8]
  20001c:	e58d2004 	str	r2, [sp, #4]
  200020:	e5d32009 	ldrb	r2, [r3, #9]
  200024:	e58d2008 	str	r2, [sp, #8]
  200028:	e5d3200d 	ldrb	r2, [r3, #13]
  20002c:	e5d3700e 	ldrb	r7, [r3, #14]
  200030:	e5c3200e 	strb	r2, [r3, #14]
  200034:	e59d2000 	ldr	r2, [sp]
  200038:	e5d38000 	ldrb	r8, [r3]
  20003c:	e5d31003 	ldrb	r1, [r3, #3]
  200040:	e5d3a001 	ldrb	sl, [r3, #1]
  200044:	e5d30002 	ldrb	r0, [r3, #2]
  200048:	e5d39004 	ldrb	r9, [r3, #4]
  20004c:	e5d3c007 	ldrb	ip, [r3, #7]
  200050:	e5d3e006 	ldrb	lr, [r3, #6]
  200054:	e5d3400b 	ldrb	r4, [r3, #11]
  200058:	e5c32006 	strb	r2, [r3, #6]
  20005c:	e5d3500a 	ldrb	r5, [r3, #10]
  200060:	e59d2004 	ldr	r2, [sp, #4]
  200064:	e5d3b00c 	ldrb	fp, [r3, #12]
  200068:	e5d3600f 	ldrb	r6, [r3, #15]
  20006c:	e5c3200b 	strb	r2, [r3, #11]
  200070:	e5c31000 	strb	r1, [r3]
  200074:	e5c38003 	strb	r8, [r3, #3]
  200078:	e5c30001 	strb	r0, [r3, #1]
  20007c:	e5c3a002 	strb	sl, [r3, #2]
  200080:	e5c3c004 	strb	ip, [r3, #4]
  200084:	e5c39007 	strb	r9, [r3, #7]
  200088:	e5c3e005 	strb	lr, [r3, #5]
  20008c:	e5c34008 	strb	r4, [r3, #8]
  200090:	e5c35009 	strb	r5, [r3, #9]
  200094:	e59d2008 	ldr	r2, [sp, #8]
  200098:	e5c3600c 	strb	r6, [r3, #12]
  20009c:	e5c3200a 	strb	r2, [r3, #10]
  2000a0:	e5c3b00f 	strb	fp, [r3, #15]
  2000a4:	e5c3700d 	strb	r7, [r3, #13]
  2000a8:	e28dd00c 	add	sp, sp, #12	; 0xc
  2000ac:	e8bd8ff0 	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
  2000b0:	00204fd4 	ldreqd	r4, [r0], -r4

002000b4 <vnRFUpdateRating>:
  2000b4:	e92d45f0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, lr}
  2000b8:	ebfc0a6a 	bl	102a68 <xTaskGetTickCount>
  2000bc:	e59f3228 	ldr	r3, [pc, #552]	; 2002ec <.data+0x2ec>
  2000c0:	e59f8228 	ldr	r8, [pc, #552]	; 2002f0 <.data+0x2f0>
  2000c4:	e59fc228 	ldr	ip, [pc, #552]	; 2002f4 <.data+0x2f4>
  2000c8:	e5934000 	ldr	r4, [r3]
  2000cc:	e1a05000 	mov	r5, r0
  2000d0:	e1a06008 	mov	r6, r8
  2000d4:	e3a07000 	mov	r7, #0	; 0x0
  2000d8:	e28cec0a 	add	lr, ip, #2560	; 0xa00
  2000dc:	e5dc3000 	ldrb	r3, [ip]
  2000e0:	e3130001 	tst	r3, #1	; 0x1
  2000e4:	0a000011 	beq	200130 <vnRFUpdateRating+0x7c>
  2000e8:	e5dc2007 	ldrb	r2, [ip, #7]
  2000ec:	e5dc3006 	ldrb	r3, [ip, #6]
  2000f0:	e5dc0008 	ldrb	r0, [ip, #8]
  2000f4:	e5dc1009 	ldrb	r1, [ip, #9]
  2000f8:	e1833402 	orr	r3, r3, r2, lsl #8
  2000fc:	e1833800 	orr	r3, r3, r0, lsl #16
  200100:	e1833c01 	orr	r3, r3, r1, lsl #24
  200104:	e0633005 	rsb	r3, r3, r5
  200108:	e1530004 	cmp	r3, r4
  20010c:	35dc3004 	ldrccb	r3, [ip, #4]
  200110:	35dc2005 	ldrccb	r2, [ip, #5]
  200114:	35dc1001 	ldrccb	r1, [ip, #1]
  200118:	31833402 	orrcc	r3, r3, r2, lsl #8
  20011c:	23a03000 	movcs	r3, #0	; 0x0
  200120:	31833c01 	orrcc	r3, r3, r1, lsl #24
  200124:	25cc3000 	strcsb	r3, [ip]
  200128:	34863004 	strcc	r3, [r6], #4
  20012c:	32877001 	addcc	r7, r7, #1	; 0x1
  200130:	e28cc00a 	add	ip, ip, #10	; 0xa
  200134:	e15e000c 	cmp	lr, ip
  200138:	1affffe7 	bne	2000dc <vnRFUpdateRating+0x28>
  20013c:	e3570001 	cmp	r7, #1	; 0x1
  200140:	da000042 	ble	200250 <vnRFUpdateRating+0x19c>
  200144:	e59f01a4 	ldr	r0, [pc, #420]	; 2002f0 <.data+0x2f0>
  200148:	e1a01007 	mov	r1, r7
  20014c:	e59fa1a4 	ldr	sl, [pc, #420]	; 2002f8 <.data+0x2f8>
  200150:	e1a0e00f 	mov	lr, pc
  200154:	e12fff1a 	bx	sl
  200158:	e59fc19c 	ldr	ip, [pc, #412]	; 2002fc <.data+0x2fc>
  20015c:	e3a00000 	mov	r0, #0	; 0x0
  200160:	e5983000 	ldr	r3, [r8]
  200164:	e24c5008 	sub	r5, ip, #8	; 0x8
  200168:	e3a04001 	mov	r4, #1	; 0x1
  20016c:	e1a0e000 	mov	lr, r0
  200170:	e2476001 	sub	r6, r7, #1	; 0x1
  200174:	ea00000b 	b	2001a8 <vnRFUpdateRating+0xf4>
  200178:	e35400ff 	cmp	r4, #255	; 0xff
  20017c:	e3a02000 	mov	r2, #0	; 0x0
  200180:	e2800001 	add	r0, r0, #1	; 0x1
  200184:	d26420ff 	rsble	r2, r4, #255	; 0xff
  200188:	e1833802 	orr	r3, r3, r2, lsl #16
  20018c:	e1500007 	cmp	r0, r7
  200190:	e4853004 	str	r3, [r5], #4
  200194:	e28ee001 	add	lr, lr, #1	; 0x1
  200198:	e3a04001 	mov	r4, #1	; 0x1
  20019c:	e28cc004 	add	ip, ip, #4	; 0x4
  2001a0:	e1a03001 	mov	r3, r1
  2001a4:	0a00000a 	beq	2001d4 <vnRFUpdateRating+0x120>
  2001a8:	e51c1004 	ldr	r1, [ip, #-4]
  2001ac:	e1510003 	cmp	r1, r3
  2001b0:	1afffff0 	bne	200178 <vnRFUpdateRating+0xc4>
  2001b4:	e1560000 	cmp	r6, r0
  2001b8:	12844001 	addne	r4, r4, #1	; 0x1
  2001bc:	0affffed 	beq	200178 <vnRFUpdateRating+0xc4>
  2001c0:	e2800001 	add	r0, r0, #1	; 0x1
  2001c4:	e1500007 	cmp	r0, r7
  2001c8:	e28cc004 	add	ip, ip, #4	; 0x4
  2001cc:	e1a03001 	mov	r3, r1
  2001d0:	1afffff4 	bne	2001a8 <vnRFUpdateRating+0xf4>
  2001d4:	e1a0700e 	mov	r7, lr
  2001d8:	e59f0110 	ldr	r0, [pc, #272]	; 2002f0 <.data+0x2f0>
  2001dc:	e1a0100e 	mov	r1, lr
  2001e0:	e2476001 	sub	r6, r7, #1	; 0x1
  2001e4:	e1a0e00f 	mov	lr, pc
  2001e8:	e12fff1a 	bx	sl
  2001ec:	e3560000 	cmp	r6, #0	; 0x0
  2001f0:	e1a00007 	mov	r0, r7
  2001f4:	da000015 	ble	200250 <vnRFUpdateRating+0x19c>
  2001f8:	e59fe100 	ldr	lr, [pc, #256]	; 200300 <.data+0x300>
  2001fc:	e3a04000 	mov	r4, #0	; 0x0
  200200:	e15ec0b4 	ldrh	ip, [lr, #-4]
  200204:	e35c0000 	cmp	ip, #0	; 0x0
  200208:	e1a0200e 	mov	r2, lr
  20020c:	0a00000a 	beq	20023c <vnRFUpdateRating+0x188>
  200210:	e3500000 	cmp	r0, #0	; 0x0
  200214:	da000008 	ble	20023c <vnRFUpdateRating+0x188>
  200218:	e3a01000 	mov	r1, #0	; 0x0
  20021c:	e1a05001 	mov	r5, r1
  200220:	e1d230b0 	ldrh	r3, [r2]
  200224:	e2811001 	add	r1, r1, #1	; 0x1
  200228:	e15c0003 	cmp	ip, r3
  20022c:	05825000 	streq	r5, [r2]
  200230:	e1510000 	cmp	r1, r0
  200234:	e2822004 	add	r2, r2, #4	; 0x4
  200238:	1afffff8 	bne	200220 <vnRFUpdateRating+0x16c>
  20023c:	e2844001 	add	r4, r4, #1	; 0x1
  200240:	e1560004 	cmp	r6, r4
  200244:	e28ee004 	add	lr, lr, #4	; 0x4
  200248:	e2400001 	sub	r0, r0, #1	; 0x1
  20024c:	1affffeb 	bne	200200 <vnRFUpdateRating+0x14c>
  200250:	e59f80ac 	ldr	r8, [pc, #172]	; 200304 <.data+0x304>
  200254:	e3a01000 	mov	r1, #0	; 0x0
  200258:	e5980000 	ldr	r0, [r8]
  20025c:	e3a02ffa 	mov	r2, #1000	; 0x3e8
  200260:	ebfc07e2 	bl	1021f0 <xQueueReceive>
  200264:	e3500001 	cmp	r0, #1	; 0x1
  200268:	18bd85f0 	ldmneia	sp!, {r4, r5, r6, r7, r8, sl, pc}
  20026c:	e59f6094 	ldr	r6, [pc, #148]	; 200308 <.data+0x308>
  200270:	e3a03000 	mov	r3, #0	; 0x0
  200274:	e3570000 	cmp	r7, #0	; 0x0
  200278:	e5863000 	str	r3, [r6]
  20027c:	da000015 	ble	2002d8 <vnRFUpdateRating+0x224>
  200280:	e59f4078 	ldr	r4, [pc, #120]	; 200300 <.data+0x300>
  200284:	e59fc080 	ldr	ip, [pc, #128]	; 20030c <.data+0x30c>
  200288:	e1a0e003 	mov	lr, r3
  20028c:	e1a05003 	mov	r5, r3
  200290:	e5142004 	ldr	r2, [r4, #-4]
  200294:	e1a03822 	mov	r3, r2, lsr #16
  200298:	e3520000 	cmp	r2, #0	; 0x0
  20029c:	e28ee001 	add	lr, lr, #1	; 0x1
  2002a0:	e2844004 	add	r4, r4, #4	; 0x4
  2002a4:	e1e03003 	mvn	r3, r3
  2002a8:	e1a00422 	mov	r0, r2, lsr #8
  2002ac:	e1a01c22 	mov	r1, r2, lsr #24
  2002b0:	0a000005 	beq	2002cc <vnRFUpdateRating+0x218>
  2002b4:	e5cc1002 	strb	r1, [ip, #2]
  2002b8:	e5cc3003 	strb	r3, [ip, #3]
  2002bc:	e5cc0001 	strb	r0, [ip, #1]
  2002c0:	e5cc2000 	strb	r2, [ip]
  2002c4:	e2855001 	add	r5, r5, #1	; 0x1
  2002c8:	e28cc004 	add	ip, ip, #4	; 0x4
  2002cc:	e157000e 	cmp	r7, lr
  2002d0:	1affffee 	bne	200290 <vnRFUpdateRating+0x1dc>
  2002d4:	e5865000 	str	r5, [r6]
  2002d8:	e3a01000 	mov	r1, #0	; 0x0
  2002dc:	e5980000 	ldr	r0, [r8]
  2002e0:	e1a02001 	mov	r2, r1
  2002e4:	e8bd45f0 	ldmia	sp!, {r4, r5, r6, r7, r8, sl, lr}
  2002e8:	eafc0825 	b	102384 <xQueueSend>
  2002ec:	00204fd0 	ldreqd	r4, [r0], -r0
  2002f0:	00205404 	eoreq	r5, r0, r4, lsl #8
  2002f4:	0020580c 	eoreq	r5, r0, ip, lsl #16
  2002f8:	00200450 	eoreq	r0, r0, r0, asr r4
  2002fc:	0020540c 	eoreq	r5, r0, ip, lsl #8
  200300:	00205408 	eoreq	r5, r0, r8, lsl #8
  200304:	00205808 	eoreq	r5, r0, r8, lsl #16
  200308:	00204fcc 	eoreq	r4, r0, ip, asr #31
  20030c:	00204fe4 	eoreq	r4, r0, r4, ror #31

00200310 <env_crc16>:
  200310:	e3500000 	cmp	r0, #0	; 0x0
  200314:	13510000 	cmpne	r1, #0	; 0x0
  200318:	e52de004 	str	lr, [sp, #-4]!
  20031c:	e1a0e000 	mov	lr, r0
  200320:	0a000015 	beq	20037c <env_crc16+0x6c>
  200324:	e3510000 	cmp	r1, #0	; 0x0
  200328:	13a00cff 	movne	r0, #65280	; 0xff00
  20032c:	128000ff 	addne	r0, r0, #255	; 0xff
  200330:	13a0c000 	movne	ip, #0	; 0x0
  200334:	0a000010 	beq	20037c <env_crc16+0x6c>
  200338:	e7de200c 	ldrb	r2, [lr, ip]
  20033c:	e1a03400 	mov	r3, r0, lsl #8
  200340:	e1833420 	orr	r3, r3, r0, lsr #8
  200344:	e0233002 	eor	r3, r3, r2
  200348:	e1a03803 	mov	r3, r3, lsl #16
  20034c:	e1a03823 	mov	r3, r3, lsr #16
  200350:	e20320ff 	and	r2, r3, #255	; 0xff
  200354:	e0233222 	eor	r3, r3, r2, lsr #4
  200358:	e0233603 	eor	r3, r3, r3, lsl #12
  20035c:	e1a03803 	mov	r3, r3, lsl #16
  200360:	e1a03823 	mov	r3, r3, lsr #16
  200364:	e28cc001 	add	ip, ip, #1	; 0x1
  200368:	e20320ff 	and	r2, r3, #255	; 0xff
  20036c:	e15c0001 	cmp	ip, r1
  200370:	e0230282 	eor	r0, r3, r2, lsl #5
  200374:	1affffef 	bne	200338 <env_crc16+0x28>
  200378:	e49df004 	ldr	pc, [sp], #4
  20037c:	e3a00cff 	mov	r0, #65280	; 0xff00
  200380:	e28000ff 	add	r0, r0, #255	; 0xff
  200384:	e49df004 	ldr	pc, [sp], #4

00200388 <env_store>:
  200388:	e92d4010 	stmdb	sp!, {r4, lr}
  20038c:	ebfc0890 	bl	1025d4 <vTaskSuspendAll>
  200390:	ebfc0e74 	bl	103d68 <vPortEnterCritical>
  200394:	e3a03533 	mov	r3, #213909504	; 0xcc00000
  200398:	e59f40ac 	ldr	r4, [pc, #172]	; 20044c <.data+0x44c>
  20039c:	e2833ac2 	add	r3, r3, #794624	; 0xc2000
  2003a0:	e3a0cc01 	mov	ip, #256	; 0x100
  2003a4:	e3a02000 	mov	r2, #0	; 0x0
  2003a8:	e2833007 	add	r3, r3, #7	; 0x7
  2003ac:	e5842008 	str	r2, [r4, #8]
  2003b0:	e1a0100c 	mov	r1, ip
  2003b4:	e1a00004 	mov	r0, r4
  2003b8:	e8841008 	stmia	r4, {r3, ip}
  2003bc:	ebffffd3 	bl	200310 <env_crc16>
  2003c0:	e3a0295f 	mov	r2, #1556480	; 0x17c000
  2003c4:	e1a01002 	mov	r1, r2
  2003c8:	e5840008 	str	r0, [r4, #8]
  2003cc:	e2822a03 	add	r2, r2, #12288	; 0x3000
  2003d0:	e2844004 	add	r4, r4, #4	; 0x4
  2003d4:	e2811c31 	add	r1, r1, #12544	; 0x3100
  2003d8:	e5143004 	ldr	r3, [r4, #-4]
  2003dc:	e4823004 	str	r3, [r2], #4
  2003e0:	e1520001 	cmp	r2, r1
  2003e4:	e2844004 	add	r4, r4, #4	; 0x4
  2003e8:	1afffffa 	bne	2003d8 <env_store+0x50>
  2003ec:	e3e020ff 	mvn	r2, #255	; 0xff
  2003f0:	e5923068 	ldr	r3, [r2, #104]
  2003f4:	e313080f 	tst	r3, #983040	; 0xf0000
  2003f8:	0a000007 	beq	20041c <env_store+0x94>
  2003fc:	e3a0345a 	mov	r3, #1509949440	; 0x5a000000
  200400:	e2833a3f 	add	r3, r3, #258048	; 0x3f000
  200404:	e2833004 	add	r3, r3, #4	; 0x4
  200408:	e5823064 	str	r3, [r2, #100]
  20040c:	e2822068 	add	r2, r2, #104	; 0x68
  200410:	e5923000 	ldr	r3, [r2]
  200414:	e3130001 	tst	r3, #1	; 0x1
  200418:	0afffffc 	beq	200410 <env_store+0x88>
  20041c:	e3a0345a 	mov	r3, #1509949440	; 0x5a000000
  200420:	e2833a3f 	add	r3, r3, #258048	; 0x3f000
  200424:	e3e020ff 	mvn	r2, #255	; 0xff
  200428:	e2833001 	add	r3, r3, #1	; 0x1
  20042c:	e5823064 	str	r3, [r2, #100]
  200430:	e2822068 	add	r2, r2, #104	; 0x68
  200434:	e5923000 	ldr	r3, [r2]
  200438:	e3130001 	tst	r3, #1	; 0x1
  20043c:	0afffffc 	beq	200434 <env_store+0xac>
  200440:	ebfc0e53 	bl	103d94 <vPortExitCritical>
  200444:	e8bd4010 	ldmia	sp!, {r4, lr}
  200448:	eafc0b14 	b	1030a0 <xTaskResumeAll>
  20044c:	0020661c 	eoreq	r6, r0, ip, lsl r6

00200450 <sort>:
  200450:	e1a02101 	mov	r2, r1, lsl #2
  200454:	e3510002 	cmp	r1, #2	; 0x2
  200458:	e0823000 	add	r3, r2, r0
  20045c:	e92d4030 	stmdb	sp!, {r4, r5, lr}
  200460:	e2434004 	sub	r4, r3, #4	; 0x4
  200464:	859f50ac 	ldrhi	r5, [pc, #172]	; 200518 <.data+0x518>
  200468:	9a00001b 	bls	2004dc <sort+0x8c>
  20046c:	e0823001 	add	r3, r2, r1
  200470:	e1a03083 	mov	r3, r3, lsl #1
  200474:	e0821395 	umull	r1, r2, r5, r3
  200478:	e1a01122 	mov	r1, r2, lsr #2
  20047c:	e2413009 	sub	r3, r1, #9	; 0x9
  200480:	e3530001 	cmp	r3, #1	; 0x1
  200484:	93a0302c 	movls	r3, #44	; 0x2c
  200488:	81a03101 	movhi	r3, r1, lsl #2
  20048c:	e0633004 	rsb	r3, r3, r4
  200490:	93a0100b 	movls	r1, #11	; 0xb
  200494:	e1500003 	cmp	r0, r3
  200498:	8a000009 	bhi	2004c4 <sort+0x74>
  20049c:	e1a0e004 	mov	lr, r4
  2004a0:	e59e2000 	ldr	r2, [lr]
  2004a4:	e593c000 	ldr	ip, [r3]
  2004a8:	e152000c 	cmp	r2, ip
  2004ac:	358ec000 	strcc	ip, [lr]
  2004b0:	35832000 	strcc	r2, [r3]
  2004b4:	e2433004 	sub	r3, r3, #4	; 0x4
  2004b8:	e1500003 	cmp	r0, r3
  2004bc:	e24ee004 	sub	lr, lr, #4	; 0x4
  2004c0:	9afffff6 	bls	2004a0 <sort+0x50>
  2004c4:	e3510002 	cmp	r1, #2	; 0x2
  2004c8:	9a000003 	bls	2004dc <sort+0x8c>
  2004cc:	e1a02101 	mov	r2, r1, lsl #2
  2004d0:	eaffffe5 	b	20046c <sort+0x1c>
  2004d4:	e35e0000 	cmp	lr, #0	; 0x0
  2004d8:	0a00000d 	beq	200514 <sort+0xc4>
  2004dc:	e1a03004 	mov	r3, r4
  2004e0:	e3a0e000 	mov	lr, #0	; 0x0
  2004e4:	ea000006 	b	200504 <sort+0xb4>
  2004e8:	e4121004 	ldr	r1, [r2], #-4
  2004ec:	e513c004 	ldr	ip, [r3, #-4]
  2004f0:	e151000c 	cmp	r1, ip
  2004f4:	35031004 	strcc	r1, [r3, #-4]
  2004f8:	3583c000 	strcc	ip, [r3]
  2004fc:	33a0e001 	movcc	lr, #1	; 0x1
  200500:	e1a03002 	mov	r3, r2
  200504:	e1500003 	cmp	r0, r3
  200508:	e1a02003 	mov	r2, r3
  20050c:	3afffff5 	bcc	2004e8 <sort+0x98>
  200510:	eaffffef 	b	2004d4 <sort+0x84>
  200514:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
  200518:	4ec4ec4f 	cdpmi	12, 12, cr14, cr4, cr15, {2}

0020051c <mx_update>:
  20051c:	e92d4010 	stmdb	sp!, {r4, lr}
  200520:	e59f3058 	ldr	r3, [pc, #88]	; 200580 <.data+0x580>
  200524:	e5d32000 	ldrb	r2, [r3]
  200528:	e2000003 	and	r0, r0, #3	; 0x3
  20052c:	e0200002 	eor	r0, r0, r2
  200530:	e59f304c 	ldr	r3, [pc, #76]	; 200584 <.data+0x584>
  200534:	e59f204c 	ldr	r2, [pc, #76]	; 200588 <.data+0x588>
  200538:	e5934000 	ldr	r4, [r3]
  20053c:	e592c000 	ldr	ip, [r2]
  200540:	e59f3044 	ldr	r3, [pc, #68]	; 20058c <.data+0x58c>
  200544:	e59f2044 	ldr	r2, [pc, #68]	; 200590 <.data+0x590>
  200548:	e793e100 	ldr	lr, [r3, r0, lsl #2]
  20054c:	e5921000 	ldr	r1, [r2]
  200550:	e1a0310c 	mov	r3, ip, lsl #2
  200554:	e1a02204 	mov	r2, r4, lsl #4
  200558:	e02221ac 	eor	r2, r2, ip, lsr #3
  20055c:	e02c1001 	eor	r1, ip, r1
  200560:	e024e00e 	eor	lr, r4, lr
  200564:	e02332a4 	eor	r3, r3, r4, lsr #5
  200568:	e0833002 	add	r3, r3, r2
  20056c:	e081100e 	add	r1, r1, lr
  200570:	e59f201c 	ldr	r2, [pc, #28]	; 200594 <.data+0x594>
  200574:	e0233001 	eor	r3, r3, r1
  200578:	e5823000 	str	r3, [r2]
  20057c:	e8bd8010 	ldmia	sp!, {r4, pc}
  200580:	0020672c 	eoreq	r6, r0, ip, lsr #14
  200584:	00206724 	eoreq	r6, r0, r4, lsr #14
  200588:	00206728 	eoreq	r6, r0, r8, lsr #14
  20058c:	001052a0 	andeqs	r5, r0, r0, lsr #5
  200590:	00206720 	eoreq	r6, r0, r0, lsr #14
  200594:	00206730 	eoreq	r6, r0, r0, lsr r7

00200598 <xxtea_decode>:
  200598:	e92d4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
  20059c:	e59f6240 	ldr	r6, [pc, #576]	; 2007e4 <.data+0x7e4>
  2005a0:	e5d62001 	ldrb	r2, [r6, #1]
  2005a4:	e5d63000 	ldrb	r3, [r6]
  2005a8:	e5d61002 	ldrb	r1, [r6, #2]
  2005ac:	e1833402 	orr	r3, r3, r2, lsl #8
  2005b0:	e5d60003 	ldrb	r0, [r6, #3]
  2005b4:	e59f222c 	ldr	r2, [pc, #556]	; 2007e8 <.data+0x7e8>
  2005b8:	e1833801 	orr	r3, r3, r1, lsl #16
  2005bc:	e59f9228 	ldr	r9, [pc, #552]	; 2007ec <.data+0x7ec>
  2005c0:	e59fb228 	ldr	fp, [pc, #552]	; 2007f0 <.data+0x7f0>
  2005c4:	e1833c00 	orr	r3, r3, r0, lsl #24
  2005c8:	e5893000 	str	r3, [r9]
  2005cc:	e58b2000 	str	r2, [fp]
  2005d0:	e59fa21c 	ldr	sl, [pc, #540]	; 2007f4 <.data+0x7f4>
  2005d4:	e59f721c 	ldr	r7, [pc, #540]	; 2007f8 <.data+0x7f8>
  2005d8:	e59f821c 	ldr	r8, [pc, #540]	; 2007fc <.data+0x7fc>
  2005dc:	e1a05002 	mov	r5, r2
  2005e0:	e5d6300d 	ldrb	r3, [r6, #13]
  2005e4:	e5d6200c 	ldrb	r2, [r6, #12]
  2005e8:	e5d6400e 	ldrb	r4, [r6, #14]
  2005ec:	e5d60009 	ldrb	r0, [r6, #9]
  2005f0:	e5d6c00f 	ldrb	ip, [r6, #15]
  2005f4:	e5d61008 	ldrb	r1, [r6, #8]
  2005f8:	e1822403 	orr	r2, r2, r3, lsl #8
  2005fc:	e5d6e00a 	ldrb	lr, [r6, #10]
  200600:	e1822804 	orr	r2, r2, r4, lsl #16
  200604:	e1822c0c 	orr	r2, r2, ip, lsl #24
  200608:	e1811400 	orr	r1, r1, r0, lsl #8
  20060c:	e59fc1ec 	ldr	ip, [pc, #492]	; 200800 <.data+0x800>
  200610:	e5d6000b 	ldrb	r0, [r6, #11]
  200614:	e1a03125 	mov	r3, r5, lsr #2
  200618:	e181180e 	orr	r1, r1, lr, lsl #16
  20061c:	e2033003 	and	r3, r3, #3	; 0x3
  200620:	e1811c00 	orr	r1, r1, r0, lsl #24
  200624:	e5cc3000 	strb	r3, [ip]
  200628:	e3a00003 	mov	r0, #3	; 0x3
  20062c:	e58a1000 	str	r1, [sl]
  200630:	e5872000 	str	r2, [r7]
  200634:	ebffffb8 	bl	20051c <mx_update>
  200638:	e5d60005 	ldrb	r0, [r6, #5]
  20063c:	e5d6c009 	ldrb	ip, [r6, #9]
  200640:	e5d61004 	ldrb	r1, [r6, #4]
  200644:	e5d63008 	ldrb	r3, [r6, #8]
  200648:	e5972000 	ldr	r2, [r7]
  20064c:	e598e000 	ldr	lr, [r8]
  200650:	e5d64006 	ldrb	r4, [r6, #6]
  200654:	e5d6500a 	ldrb	r5, [r6, #10]
  200658:	e1811400 	orr	r1, r1, r0, lsl #8
  20065c:	e183340c 	orr	r3, r3, ip, lsl #8
  200660:	e5d60007 	ldrb	r0, [r6, #7]
  200664:	e5d6c00b 	ldrb	ip, [r6, #11]
  200668:	e06e2002 	rsb	r2, lr, r2
  20066c:	e1811804 	orr	r1, r1, r4, lsl #16
  200670:	e1833805 	orr	r3, r3, r5, lsl #16
  200674:	e1811c00 	orr	r1, r1, r0, lsl #24
  200678:	e1833c0c 	orr	r3, r3, ip, lsl #24
  20067c:	e1a04c22 	mov	r4, r2, lsr #24
  200680:	e1a0c422 	mov	ip, r2, lsr #8
  200684:	e1a0e822 	mov	lr, r2, lsr #16
  200688:	e3a00002 	mov	r0, #2	; 0x2
  20068c:	e5c6c00d 	strb	ip, [r6, #13]
  200690:	e5c6e00e 	strb	lr, [r6, #14]
  200694:	e5c6400f 	strb	r4, [r6, #15]
  200698:	e58a1000 	str	r1, [sl]
  20069c:	e5873000 	str	r3, [r7]
  2006a0:	e5892000 	str	r2, [r9]
  2006a4:	e5c6200c 	strb	r2, [r6, #12]
  2006a8:	ebffff9b 	bl	20051c <mx_update>
  2006ac:	e5d60001 	ldrb	r0, [r6, #1]
  2006b0:	e5d6c005 	ldrb	ip, [r6, #5]
  2006b4:	e5d61000 	ldrb	r1, [r6]
  2006b8:	e5d63004 	ldrb	r3, [r6, #4]
  2006bc:	e5972000 	ldr	r2, [r7]
  2006c0:	e598e000 	ldr	lr, [r8]
  2006c4:	e5d64002 	ldrb	r4, [r6, #2]
  2006c8:	e5d65006 	ldrb	r5, [r6, #6]
  2006cc:	e1811400 	orr	r1, r1, r0, lsl #8
  2006d0:	e183340c 	orr	r3, r3, ip, lsl #8
  2006d4:	e5d60003 	ldrb	r0, [r6, #3]
  2006d8:	e5d6c007 	ldrb	ip, [r6, #7]
  2006dc:	e06e2002 	rsb	r2, lr, r2
  2006e0:	e1811804 	orr	r1, r1, r4, lsl #16
  2006e4:	e1833805 	orr	r3, r3, r5, lsl #16
  2006e8:	e1811c00 	orr	r1, r1, r0, lsl #24
  2006ec:	e1833c0c 	orr	r3, r3, ip, lsl #24
  2006f0:	e1a04c22 	mov	r4, r2, lsr #24
  2006f4:	e1a0c422 	mov	ip, r2, lsr #8
  2006f8:	e1a0e822 	mov	lr, r2, lsr #16
  2006fc:	e3a00001 	mov	r0, #1	; 0x1
  200700:	e5c6c009 	strb	ip, [r6, #9]
  200704:	e5c6e00a 	strb	lr, [r6, #10]
  200708:	e5c6400b 	strb	r4, [r6, #11]
  20070c:	e58a1000 	str	r1, [sl]
  200710:	e5873000 	str	r3, [r7]
  200714:	e5892000 	str	r2, [r9]
  200718:	e5c62008 	strb	r2, [r6, #8]
  20071c:	ebffff7e 	bl	20051c <mx_update>
  200720:	e5d6000d 	ldrb	r0, [r6, #13]
  200724:	e5d6c001 	ldrb	ip, [r6, #1]
  200728:	e5d6100c 	ldrb	r1, [r6, #12]
  20072c:	e5d63000 	ldrb	r3, [r6]
  200730:	e5972000 	ldr	r2, [r7]
  200734:	e598e000 	ldr	lr, [r8]
  200738:	e5d6400e 	ldrb	r4, [r6, #14]
  20073c:	e5d65002 	ldrb	r5, [r6, #2]
  200740:	e1811400 	orr	r1, r1, r0, lsl #8
  200744:	e183340c 	orr	r3, r3, ip, lsl #8
  200748:	e5d6000f 	ldrb	r0, [r6, #15]
  20074c:	e5d6c003 	ldrb	ip, [r6, #3]
  200750:	e06e2002 	rsb	r2, lr, r2
  200754:	e1811804 	orr	r1, r1, r4, lsl #16
  200758:	e1833805 	orr	r3, r3, r5, lsl #16
  20075c:	e1811c00 	orr	r1, r1, r0, lsl #24
  200760:	e1833c0c 	orr	r3, r3, ip, lsl #24
  200764:	e1a04c22 	mov	r4, r2, lsr #24
  200768:	e1a0c422 	mov	ip, r2, lsr #8
  20076c:	e1a0e822 	mov	lr, r2, lsr #16
  200770:	e3a00000 	mov	r0, #0	; 0x0
  200774:	e58a1000 	str	r1, [sl]
  200778:	e5873000 	str	r3, [r7]
  20077c:	e5892000 	str	r2, [r9]
  200780:	e5c62004 	strb	r2, [r6, #4]
  200784:	e5c6c005 	strb	ip, [r6, #5]
  200788:	e5c6e006 	strb	lr, [r6, #6]
  20078c:	e5c64007 	strb	r4, [r6, #7]
  200790:	ebffff61 	bl	20051c <mx_update>
  200794:	e59b3000 	ldr	r3, [fp]
  200798:	e2835461 	add	r5, r3, #1627389952	; 0x61000000
  20079c:	e5982000 	ldr	r2, [r8]
  2007a0:	e2855732 	add	r5, r5, #13107200	; 0xc80000
  2007a4:	e5973000 	ldr	r3, [r7]
  2007a8:	e2855c86 	add	r5, r5, #34304	; 0x8600
  2007ac:	e0623003 	rsb	r3, r2, r3
  2007b0:	e2855047 	add	r5, r5, #71	; 0x47
  2007b4:	e1a00c23 	mov	r0, r3, lsr #24
  2007b8:	e1a02423 	mov	r2, r3, lsr #8
  2007bc:	e1a01823 	mov	r1, r3, lsr #16
  2007c0:	e3550000 	cmp	r5, #0	; 0x0
  2007c4:	e5c62001 	strb	r2, [r6, #1]
  2007c8:	e5c61002 	strb	r1, [r6, #2]
  2007cc:	e5c60003 	strb	r0, [r6, #3]
  2007d0:	e5c63000 	strb	r3, [r6]
  2007d4:	e5893000 	str	r3, [r9]
  2007d8:	e58b5000 	str	r5, [fp]
  2007dc:	1affff7f 	bne	2005e0 <xxtea_decode+0x48>
  2007e0:	e8bd8ff0 	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
  2007e4:	00204fd4 	ldreqd	r4, [r0], -r4
  2007e8:	be1e08bb 	mrclt	8, 0, r0, cr14, cr11, {5}
  2007ec:	00206728 	eoreq	r6, r0, r8, lsr #14
  2007f0:	00206720 	eoreq	r6, r0, r0, lsr #14
  2007f4:	00206724 	eoreq	r6, r0, r4, lsr #14
  2007f8:	0020671c 	eoreq	r6, r0, ip, lsl r7
  2007fc:	00206730 	eoreq	r6, r0, r0, lsr r7
  200800:	0020672c 	eoreq	r6, r0, ip, lsr #14

00200804 <xxtea_encode>:
  200804:	e92d4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
  200808:	e59f6248 	ldr	r6, [pc, #584]	; 200a58 <.data+0xa58>
  20080c:	e5d6200d 	ldrb	r2, [r6, #13]
  200810:	e5d6300c 	ldrb	r3, [r6, #12]
  200814:	e5d6100e 	ldrb	r1, [r6, #14]
  200818:	e1833402 	orr	r3, r3, r2, lsl #8
  20081c:	e5d6000f 	ldrb	r0, [r6, #15]
  200820:	e1833801 	orr	r3, r3, r1, lsl #16
  200824:	e59f9230 	ldr	r9, [pc, #560]	; 200a5c <.data+0xa5c>
  200828:	e1833c00 	orr	r3, r3, r0, lsl #24
  20082c:	e5893000 	str	r3, [r9]
  200830:	e59f3228 	ldr	r3, [pc, #552]	; 200a60 <.data+0xa60>
  200834:	e3a02000 	mov	r2, #0	; 0x0
  200838:	e5832000 	str	r2, [r3]
  20083c:	e59fa220 	ldr	sl, [pc, #544]	; 200a64 <.data+0xa64>
  200840:	e59f7220 	ldr	r7, [pc, #544]	; 200a68 <.data+0xa68>
  200844:	e59f8220 	ldr	r8, [pc, #544]	; 200a6c <.data+0xa6c>
  200848:	e3a0b013 	mov	fp, #19	; 0x13
  20084c:	e59fe20c 	ldr	lr, [pc, #524]	; 200a60 <.data+0xa60>
  200850:	e59e2000 	ldr	r2, [lr]
  200854:	e5d63001 	ldrb	r3, [r6, #1]
  200858:	e5d61000 	ldrb	r1, [r6]
  20085c:	e282249f 	add	r2, r2, #-1627389952	; 0x9f000000
  200860:	e5d65002 	ldrb	r5, [r6, #2]
  200864:	e2422732 	sub	r2, r2, #13107200	; 0xc80000
  200868:	e5d6e003 	ldrb	lr, [r6, #3]
  20086c:	e1811403 	orr	r1, r1, r3, lsl #8
  200870:	e2422c86 	sub	r2, r2, #34304	; 0x8600
  200874:	e2422047 	sub	r2, r2, #71	; 0x47
  200878:	e1811805 	orr	r1, r1, r5, lsl #16
  20087c:	e5d60005 	ldrb	r0, [r6, #5]
  200880:	e5d6c004 	ldrb	ip, [r6, #4]
  200884:	e1811c0e 	orr	r1, r1, lr, lsl #24
  200888:	e1a03122 	mov	r3, r2, lsr #2
  20088c:	e59fe1dc 	ldr	lr, [pc, #476]	; 200a70 <.data+0xa70>
  200890:	e5d64006 	ldrb	r4, [r6, #6]
  200894:	e2033003 	and	r3, r3, #3	; 0x3
  200898:	e18cc400 	orr	ip, ip, r0, lsl #8
  20089c:	e5d60007 	ldrb	r0, [r6, #7]
  2008a0:	e5ce3000 	strb	r3, [lr]
  2008a4:	e59f31b4 	ldr	r3, [pc, #436]	; 200a60 <.data+0xa60>
  2008a8:	e18cc804 	orr	ip, ip, r4, lsl #16
  2008ac:	e18ccc00 	orr	ip, ip, r0, lsl #24
  2008b0:	e5832000 	str	r2, [r3]
  2008b4:	e3a00000 	mov	r0, #0	; 0x0
  2008b8:	e58ac000 	str	ip, [sl]
  2008bc:	e5871000 	str	r1, [r7]
  2008c0:	ebffff15 	bl	20051c <mx_update>
  2008c4:	e5d60009 	ldrb	r0, [r6, #9]
  2008c8:	e5d6c005 	ldrb	ip, [r6, #5]
  2008cc:	e5d61008 	ldrb	r1, [r6, #8]
  2008d0:	e5d63004 	ldrb	r3, [r6, #4]
  2008d4:	e5972000 	ldr	r2, [r7]
  2008d8:	e598e000 	ldr	lr, [r8]
  2008dc:	e5d6400a 	ldrb	r4, [r6, #10]
  2008e0:	e5d65006 	ldrb	r5, [r6, #6]
  2008e4:	e1811400 	orr	r1, r1, r0, lsl #8
  2008e8:	e183340c 	orr	r3, r3, ip, lsl #8
  2008ec:	e5d6000b 	ldrb	r0, [r6, #11]
  2008f0:	e5d6c007 	ldrb	ip, [r6, #7]
  2008f4:	e082200e 	add	r2, r2, lr
  2008f8:	e1811804 	orr	r1, r1, r4, lsl #16
  2008fc:	e1833805 	orr	r3, r3, r5, lsl #16
  200900:	e1811c00 	orr	r1, r1, r0, lsl #24
  200904:	e1833c0c 	orr	r3, r3, ip, lsl #24
  200908:	e1a04c22 	mov	r4, r2, lsr #24
  20090c:	e1a0c422 	mov	ip, r2, lsr #8
  200910:	e1a0e822 	mov	lr, r2, lsr #16
  200914:	e3a00001 	mov	r0, #1	; 0x1
  200918:	e5c6c001 	strb	ip, [r6, #1]
  20091c:	e5c6e002 	strb	lr, [r6, #2]
  200920:	e5c64003 	strb	r4, [r6, #3]
  200924:	e58a1000 	str	r1, [sl]
  200928:	e5873000 	str	r3, [r7]
  20092c:	e5892000 	str	r2, [r9]
  200930:	e5c62000 	strb	r2, [r6]
  200934:	ebfffef8 	bl	20051c <mx_update>
  200938:	e5d6000d 	ldrb	r0, [r6, #13]
  20093c:	e5d6c009 	ldrb	ip, [r6, #9]
  200940:	e5d6100c 	ldrb	r1, [r6, #12]
  200944:	e5d63008 	ldrb	r3, [r6, #8]
  200948:	e5972000 	ldr	r2, [r7]
  20094c:	e598e000 	ldr	lr, [r8]
  200950:	e5d6400e 	ldrb	r4, [r6, #14]
  200954:	e5d6500a 	ldrb	r5, [r6, #10]
  200958:	e1811400 	orr	r1, r1, r0, lsl #8
  20095c:	e183340c 	orr	r3, r3, ip, lsl #8
  200960:	e5d6000f 	ldrb	r0, [r6, #15]
  200964:	e5d6c00b 	ldrb	ip, [r6, #11]
  200968:	e082200e 	add	r2, r2, lr
  20096c:	e1811804 	orr	r1, r1, r4, lsl #16
  200970:	e1833805 	orr	r3, r3, r5, lsl #16
  200974:	e1811c00 	orr	r1, r1, r0, lsl #24
  200978:	e1833c0c 	orr	r3, r3, ip, lsl #24
  20097c:	e1a04c22 	mov	r4, r2, lsr #24
  200980:	e1a0c422 	mov	ip, r2, lsr #8
  200984:	e1a0e822 	mov	lr, r2, lsr #16
  200988:	e3a00002 	mov	r0, #2	; 0x2
  20098c:	e5c6c005 	strb	ip, [r6, #5]
  200990:	e5c6e006 	strb	lr, [r6, #6]
  200994:	e5c64007 	strb	r4, [r6, #7]
  200998:	e58a1000 	str	r1, [sl]
  20099c:	e5873000 	str	r3, [r7]
  2009a0:	e5892000 	str	r2, [r9]
  2009a4:	e5c62004 	strb	r2, [r6, #4]
  2009a8:	ebfffedb 	bl	20051c <mx_update>
  2009ac:	e5d60001 	ldrb	r0, [r6, #1]
  2009b0:	e5d6c00d 	ldrb	ip, [r6, #13]
  2009b4:	e5d61000 	ldrb	r1, [r6]
  2009b8:	e5d6300c 	ldrb	r3, [r6, #12]
  2009bc:	e5972000 	ldr	r2, [r7]
  2009c0:	e598e000 	ldr	lr, [r8]
  2009c4:	e5d64002 	ldrb	r4, [r6, #2]
  2009c8:	e5d6500e 	ldrb	r5, [r6, #14]
  2009cc:	e1811400 	orr	r1, r1, r0, lsl #8
  2009d0:	e183340c 	orr	r3, r3, ip, lsl #8
  2009d4:	e5d60003 	ldrb	r0, [r6, #3]
  2009d8:	e5d6c00f 	ldrb	ip, [r6, #15]
  2009dc:	e082200e 	add	r2, r2, lr
  2009e0:	e1811804 	orr	r1, r1, r4, lsl #16
  2009e4:	e1833805 	orr	r3, r3, r5, lsl #16
  2009e8:	e1811c00 	orr	r1, r1, r0, lsl #24
  2009ec:	e1833c0c 	orr	r3, r3, ip, lsl #24
  2009f0:	e1a04c22 	mov	r4, r2, lsr #24
  2009f4:	e1a0c422 	mov	ip, r2, lsr #8
  2009f8:	e1a0e822 	mov	lr, r2, lsr #16
  2009fc:	e3a00003 	mov	r0, #3	; 0x3
  200a00:	e58a1000 	str	r1, [sl]
  200a04:	e5873000 	str	r3, [r7]
  200a08:	e5892000 	str	r2, [r9]
  200a0c:	e5c62008 	strb	r2, [r6, #8]
  200a10:	e5c6c009 	strb	ip, [r6, #9]
  200a14:	e5c6e00a 	strb	lr, [r6, #10]
  200a18:	e5c6400b 	strb	r4, [r6, #11]
  200a1c:	ebfffebe 	bl	20051c <mx_update>
  200a20:	e5982000 	ldr	r2, [r8]
  200a24:	e5973000 	ldr	r3, [r7]
  200a28:	e0833002 	add	r3, r3, r2
  200a2c:	e1a00c23 	mov	r0, r3, lsr #24
  200a30:	e1a02423 	mov	r2, r3, lsr #8
  200a34:	e1a01823 	mov	r1, r3, lsr #16
  200a38:	e25bb001 	subs	fp, fp, #1	; 0x1
  200a3c:	e5c6200d 	strb	r2, [r6, #13]
  200a40:	e5c6100e 	strb	r1, [r6, #14]
  200a44:	e5c6000f 	strb	r0, [r6, #15]
  200a48:	e5893000 	str	r3, [r9]
  200a4c:	e5c6300c 	strb	r3, [r6, #12]
  200a50:	1affff7d 	bne	20084c <xxtea_encode+0x48>
  200a54:	e8bd8ff0 	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
  200a58:	00204fd4 	ldreqd	r4, [r0], -r4
  200a5c:	00206724 	eoreq	r6, r0, r4, lsr #14
  200a60:	00206720 	eoreq	r6, r0, r0, lsr #14
  200a64:	00206728 	eoreq	r6, r0, r8, lsr #14
  200a68:	0020671c 	eoreq	r6, r0, ip, lsl r7
  200a6c:	00206730 	eoreq	r6, r0, r0, lsr r7
  200a70:	0020672c 	eoreq	r6, r0, ip, lsr #14

00200a74 <nRFCMD_ProcessNextMacro>:
  200a74:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
  200a78:	e59f7078 	ldr	r7, [pc, #120]	; 200af8 <.data+0xaf8>
  200a7c:	e5972000 	ldr	r2, [r7]
  200a80:	e3520000 	cmp	r2, #0	; 0x0
  200a84:	e24dd004 	sub	sp, sp, #4	; 0x4
  200a88:	e3a0c001 	mov	ip, #1	; 0x1
  200a8c:	0a00000c 	beq	200ac4 <nRFCMD_ProcessNextMacro+0x50>
  200a90:	e5d24000 	ldrb	r4, [r2]
  200a94:	e3a054ff 	mov	r5, #-16777216	; 0xff000000
  200a98:	e3a06000 	mov	r6, #0	; 0x0
  200a9c:	e28558fe 	add	r5, r5, #16646144	; 0xfe0000
  200aa0:	e2855c01 	add	r5, r5, #256	; 0x100
  200aa4:	e1540006 	cmp	r4, r6
  200aa8:	e2821001 	add	r1, r2, #1	; 0x1
  200aac:	e1a00005 	mov	r0, r5
  200ab0:	e1a03006 	mov	r3, r6
  200ab4:	e1a02004 	mov	r2, r4
  200ab8:	e3a0c001 	mov	ip, #1	; 0x1
  200abc:	05874000 	streq	r4, [r7]
  200ac0:	1a000002 	bne	200ad0 <nRFCMD_ProcessNextMacro+0x5c>
  200ac4:	e1a0000c 	mov	r0, ip
  200ac8:	e28dd004 	add	sp, sp, #4	; 0x4
  200acc:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
  200ad0:	e58d6000 	str	r6, [sp]
  200ad4:	ebfc0b1a 	bl	103744 <AT91F_PDC_SendFrame>
  200ad8:	e5973000 	ldr	r3, [r7]
  200adc:	e0843003 	add	r3, r4, r3
  200ae0:	e2833001 	add	r3, r3, #1	; 0x1
  200ae4:	e3a02c01 	mov	r2, #256	; 0x100
  200ae8:	e1a0c006 	mov	ip, r6
  200aec:	e5873000 	str	r3, [r7]
  200af0:	e5852020 	str	r2, [r5, #32]
  200af4:	eafffff2 	b	200ac4 <nRFCMD_ProcessNextMacro+0x50>
  200af8:	00206734 	eoreq	r6, r0, r4, lsr r7

00200afc <nRFCMD_ISR_DMA>:
  200afc:	e92d0001 	stmdb	sp!, {r0}
  200b00:	e94d2000 	stmdb	sp, {sp}^
  200b04:	e1a00000 	nop			(mov r0,r0)
  200b08:	e24dd004 	sub	sp, sp, #4	; 0x4
  200b0c:	e8bd0001 	ldmia	sp!, {r0}
  200b10:	e9204000 	stmdb	r0!, {lr}
  200b14:	e1a0e000 	mov	lr, r0
  200b18:	e8bd0001 	ldmia	sp!, {r0}
  200b1c:	e94e7fff 	stmdb	lr, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, sp, lr}^
  200b20:	e1a00000 	nop			(mov r0,r0)
  200b24:	e24ee03c 	sub	lr, lr, #60	; 0x3c
  200b28:	e14f0000 	mrs	r0, SPSR
  200b2c:	e92e0001 	stmdb	lr!, {r0}
  200b30:	e59f01b0 	ldr	r0, [pc, #432]	; 200ce8 <.data+0xce8>
  200b34:	e5900000 	ldr	r0, [r0]
  200b38:	e92e0001 	stmdb	lr!, {r0}
  200b3c:	e59f01a8 	ldr	r0, [pc, #424]	; 200cec <.data+0xcec>
  200b40:	e5900000 	ldr	r0, [r0]
  200b44:	e580e000 	str	lr, [r0]
  200b48:	e59f4098 	ldr	r4, [pc, #152]	; 200be8 <.data+0xbe8>
  200b4c:	e59f5098 	ldr	r5, [pc, #152]	; 200bec <.data+0xbec>
  200b50:	e5943000 	ldr	r3, [r4]
  200b54:	e5952000 	ldr	r2, [r5]
  200b58:	e24eb004 	sub	fp, lr, #4	; 0x4
  200b5c:	e3a03102 	mov	r3, #-2147483648	; 0x80000000
  200b60:	e1a03743 	mov	r3, r3, asr #14
  200b64:	e5932010 	ldr	r2, [r3, #16]
  200b68:	e3120020 	tst	r2, #32	; 0x20
  200b6c:	1a000014 	bne	200bc4 <nRFCMD_ISR_DMA+0xc8>
  200b70:	e3a00000 	mov	r0, #0	; 0x0
  200b74:	e3a03102 	mov	r3, #-2147483648	; 0x80000000
  200b78:	e1a039c3 	mov	r3, r3, asr #19
  200b7c:	e3a02000 	mov	r2, #0	; 0x0
  200b80:	e3500000 	cmp	r0, #0	; 0x0
  200b84:	e5832130 	str	r2, [r3, #304]
  200b88:	1bfc07c6 	blne	102aa8 <vTaskSwitchContext>
  200b8c:	e59f0158 	ldr	r0, [pc, #344]	; 200cec <.data+0xcec>
  200b90:	e5900000 	ldr	r0, [r0]
  200b94:	e590e000 	ldr	lr, [r0]
  200b98:	e59f0148 	ldr	r0, [pc, #328]	; 200ce8 <.data+0xce8>
  200b9c:	e8be0002 	ldmia	lr!, {r1}
  200ba0:	e5801000 	str	r1, [r0]
  200ba4:	e8be0001 	ldmia	lr!, {r0}
  200ba8:	e169f000 	msr	SPSR_fc, r0
  200bac:	e8de7fff 	ldmia	lr, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, sp, lr}^
  200bb0:	e1a00000 	nop			(mov r0,r0)
  200bb4:	e59ee03c 	ldr	lr, [lr, #60]
  200bb8:	e25ef004 	subs	pc, lr, #4	; 0x4
  200bbc:	e5943000 	ldr	r3, [r4]
  200bc0:	e5952000 	ldr	r2, [r5]
  200bc4:	ebffffaa 	bl	200a74 <nRFCMD_ProcessNextMacro>
  200bc8:	e3a01000 	mov	r1, #0	; 0x0
  200bcc:	e1500001 	cmp	r0, r1
  200bd0:	e1a02001 	mov	r2, r1
  200bd4:	0affffe5 	beq	200b70 <nRFCMD_ISR_DMA+0x74>
  200bd8:	e59f3010 	ldr	r3, [pc, #16]	; 200bf0 <.data+0xbf0>
  200bdc:	e5930000 	ldr	r0, [r3]
  200be0:	ebfc04fb 	bl	101fd4 <xQueueSendFromISR>
  200be4:	eaffffe2 	b	200b74 <nRFCMD_ISR_DMA+0x78>
  200be8:	00200000 	eoreq	r0, r0, r0
  200bec:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  200bf0:	00200cf4 	streqd	r0, [r0], -r4

00200bf4 <nRFCMD_ISR_ACK>:
  200bf4:	e92d0001 	stmdb	sp!, {r0}
  200bf8:	e94d2000 	stmdb	sp, {sp}^
  200bfc:	e1a00000 	nop			(mov r0,r0)
  200c00:	e24dd004 	sub	sp, sp, #4	; 0x4
  200c04:	e8bd0001 	ldmia	sp!, {r0}
  200c08:	e9204000 	stmdb	r0!, {lr}
  200c0c:	e1a0e000 	mov	lr, r0
  200c10:	e8bd0001 	ldmia	sp!, {r0}
  200c14:	e94e7fff 	stmdb	lr, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, sp, lr}^
  200c18:	e1a00000 	nop			(mov r0,r0)
  200c1c:	e24ee03c 	sub	lr, lr, #60	; 0x3c
  200c20:	e14f0000 	mrs	r0, SPSR
  200c24:	e92e0001 	stmdb	lr!, {r0}
  200c28:	e59f00b8 	ldr	r0, [pc, #184]	; 200ce8 <.data+0xce8>
  200c2c:	e5900000 	ldr	r0, [r0]
  200c30:	e92e0001 	stmdb	lr!, {r0}
  200c34:	e59f00b0 	ldr	r0, [pc, #176]	; 200cec <.data+0xcec>
  200c38:	e5900000 	ldr	r0, [r0]
  200c3c:	e580e000 	str	lr, [r0]
  200c40:	e59f4094 	ldr	r4, [pc, #148]	; 200cdc <.data+0xcdc>
  200c44:	e59f5094 	ldr	r5, [pc, #148]	; 200ce0 <.data+0xce0>
  200c48:	e5943000 	ldr	r3, [r4]
  200c4c:	e5952000 	ldr	r2, [r5]
  200c50:	e24eb004 	sub	fp, lr, #4	; 0x4
  200c54:	e3a0220a 	mov	r2, #-1610612736	; 0xa0000000
  200c58:	e1a029c2 	mov	r2, r2, asr #19
  200c5c:	e592304c 	ldr	r3, [r2, #76]
  200c60:	e3130702 	tst	r3, #524288	; 0x80000
  200c64:	0a000003 	beq	200c78 <nRFCMD_ISR_ACK+0x84>
  200c68:	e592103c 	ldr	r1, [r2, #60]
  200c6c:	e2111702 	ands	r1, r1, #524288	; 0x80000
  200c70:	e1a02001 	mov	r2, r1
  200c74:	0a000014 	beq	200ccc <nRFCMD_ISR_ACK+0xd8>
  200c78:	e3a00000 	mov	r0, #0	; 0x0
  200c7c:	e3a03102 	mov	r3, #-2147483648	; 0x80000000
  200c80:	e1a039c3 	mov	r3, r3, asr #19
  200c84:	e3a02000 	mov	r2, #0	; 0x0
  200c88:	e3500000 	cmp	r0, #0	; 0x0
  200c8c:	e5832130 	str	r2, [r3, #304]
  200c90:	1bfc0784 	blne	102aa8 <vTaskSwitchContext>
  200c94:	e59f0050 	ldr	r0, [pc, #80]	; 200cec <.data+0xcec>
  200c98:	e5900000 	ldr	r0, [r0]
  200c9c:	e590e000 	ldr	lr, [r0]
  200ca0:	e59f0040 	ldr	r0, [pc, #64]	; 200ce8 <.data+0xce8>
  200ca4:	e8be0002 	ldmia	lr!, {r1}
  200ca8:	e5801000 	str	r1, [r0]
  200cac:	e8be0001 	ldmia	lr!, {r0}
  200cb0:	e169f000 	msr	SPSR_fc, r0
  200cb4:	e8de7fff 	ldmia	lr, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, sp, lr}^
  200cb8:	e1a00000 	nop			(mov r0,r0)
  200cbc:	e59ee03c 	ldr	lr, [lr, #60]
  200cc0:	e25ef004 	subs	pc, lr, #4	; 0x4
  200cc4:	e5943000 	ldr	r3, [r4]
  200cc8:	e5952000 	ldr	r2, [r5]
  200ccc:	e59f3010 	ldr	r3, [pc, #16]	; 200ce4 <.data+0xce4>
  200cd0:	e5930000 	ldr	r0, [r3]
  200cd4:	ebfc04be 	bl	101fd4 <xQueueSendFromISR>
  200cd8:	eaffffe7 	b	200c7c <nRFCMD_ISR_ACK+0x88>
  200cdc:	00200000 	eoreq	r0, r0, r0
  200ce0:	00200d3c 	eoreq	r0, r0, ip, lsr sp
  200ce4:	00200cf0 	streqd	r0, [r0], -r0
  200ce8:	00200000 	eoreq	r0, r0, r0
  200cec:	00200d3c 	eoreq	r0, r0, ip, lsr sp
