	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"motion-estimation-optimized-bs.c"
	.text
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Invalid parameters\000"
	.align	2
.LC1:
	.ascii	"rb\000"
	.align	2
.LC2:
	.ascii	"1.6.34\000"
	.align	2
.LC3:
	.ascii	"Error reading pngs\012\000"
	.align	2
.LC4:
	.ascii	"Provide an image with height and width dimensions >"
	.ascii	"= 16\012\000"
	.text
	.align	2
	.global	main
	.arch armv7-a
	.syntax unified
	.arm
	.fpu neon
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #76
	push	{lr}
	bl	__gnu_mcount_nc
	str	r0, [fp, #-72]
	str	r1, [fp, #-76]
	ldr	r3, [fp, #-72]
	cmp	r3, #1
	ble	.L2
	ldr	r3, [fp, #-76]
	add	r3, r3, #4
	ldr	r2, [r3]
	ldr	r3, [fp, #-76]
	add	r3, r3, #8
	ldr	r3, [r3]
	mov	r1, r3
	mov	r0, r2
	bl	valid_parameters
	mov	r3, r0
	cmp	r3, #0
	bne	.L3
.L2:
	movw	r0, #:lower16:.LC0
	movt	r0, #:upper16:.LC0
	bl	perror
	mov	r3, #1
	b	.L14
.L3:
	ldr	r3, [fp, #-76]
	add	r3, r3, #4
	ldr	r3, [r3]
	movw	r1, #:lower16:.LC1
	movt	r1, #:upper16:.LC1
	mov	r0, r3
	bl	fopen
	str	r0, [fp, #-24]
	ldr	r3, [fp, #-76]
	add	r3, r3, #8
	ldr	r3, [r3]
	movw	r1, #:lower16:.LC1
	movt	r1, #:upper16:.LC1
	mov	r0, r3
	bl	fopen
	str	r0, [fp, #-28]
	mov	r3, #0
	mov	r2, #0
	mov	r1, #0
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	bl	png_create_read_struct
	mov	r3, r0
	str	r3, [fp, #-56]
	mov	r3, #0
	mov	r2, #0
	mov	r1, #0
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	bl	png_create_read_struct
	mov	r3, r0
	str	r3, [fp, #-60]
	ldr	r3, [fp, #-56]
	cmp	r3, #0
	beq	.L5
	ldr	r3, [fp, #-60]
	cmp	r3, #0
	bne	.L6
.L5:
	movw	r0, #:lower16:.LC3
	movt	r0, #:upper16:.LC3
	bl	perror
	mov	r3, #1
	b	.L14
.L6:
	ldr	r3, [fp, #-56]
	mov	r0, r3
	bl	png_create_info_struct
	mov	r3, r0
	str	r3, [fp, #-64]
	ldr	r3, [fp, #-56]
	ldr	r1, [fp, #-24]
	mov	r0, r3
	bl	png_init_io
	ldr	r3, [fp, #-56]
	ldr	r2, [fp, #-64]
	mov	r1, r2
	mov	r0, r3
	bl	png_read_info
	ldr	r3, [fp, #-60]
	mov	r0, r3
	bl	png_create_info_struct
	mov	r3, r0
	str	r3, [fp, #-68]
	ldr	r3, [fp, #-60]
	ldr	r1, [fp, #-28]
	mov	r0, r3
	bl	png_init_io
	ldr	r3, [fp, #-60]
	ldr	r2, [fp, #-68]
	mov	r1, r2
	mov	r0, r3
	bl	png_read_info
	ldr	r3, [fp, #-56]
	ldr	r2, [fp, #-64]
	mov	r1, r2
	mov	r0, r3
	bl	png_get_image_width
	mov	r3, r0
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-56]
	ldr	r2, [fp, #-64]
	mov	r1, r2
	mov	r0, r3
	bl	png_get_image_height
	mov	r3, r0
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-60]
	ldr	r2, [fp, #-68]
	mov	r1, r2
	mov	r0, r3
	bl	png_get_image_height
	mov	r3, r0
	str	r3, [fp, #-40]
	ldr	r3, [fp, #-60]
	ldr	r2, [fp, #-68]
	mov	r1, r2
	mov	r0, r3
	bl	png_get_image_width
	mov	r3, r0
	str	r3, [fp, #-44]
	ldr	r3, [fp, #-36]
	lsl	r3, r3, #2
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-40]
	lsl	r3, r3, #2
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-52]
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L7
.L8:
	ldr	r3, [fp, #-56]
	ldr	r2, [fp, #-64]
	mov	r1, r2
	mov	r0, r3
	bl	png_get_rowbytes
	mov	r1, r0
	ldr	r3, [fp, #-16]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-48]
	add	r4, r2, r3
	mov	r0, r1
	bl	malloc
	mov	r3, r0
	str	r3, [r4]
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L7:
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-36]
	cmp	r2, r3
	blt	.L8
	mov	r3, #0
	str	r3, [fp, #-20]
	b	.L9
.L10:
	ldr	r3, [fp, #-60]
	ldr	r2, [fp, #-68]
	mov	r1, r2
	mov	r0, r3
	bl	png_get_rowbytes
	mov	r1, r0
	ldr	r3, [fp, #-20]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-52]
	add	r4, r2, r3
	mov	r0, r1
	bl	malloc
	mov	r3, r0
	str	r3, [r4]
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L9:
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-40]
	cmp	r2, r3
	blt	.L10
	ldr	r3, [fp, #-56]
	ldr	r1, [fp, #-48]
	mov	r0, r3
	bl	png_read_image
	ldr	r3, [fp, #-60]
	ldr	r1, [fp, #-52]
	mov	r0, r3
	bl	png_read_image
	ldr	r3, [fp, #-36]
	cmp	r3, #15
	ble	.L11
	ldr	r3, [fp, #-32]
	cmp	r3, #15
	bgt	.L12
.L11:
	movw	r0, #:lower16:.LC4
	movt	r0, #:upper16:.LC4
	bl	perror
	b	.L13
.L12:
	ldr	r3, [fp, #-44]
	str	r3, [sp, #4]
	ldr	r3, [fp, #-32]
	str	r3, [sp]
	ldr	r3, [fp, #-40]
	ldr	r2, [fp, #-36]
	ldr	r1, [fp, #-52]
	ldr	r0, [fp, #-48]
	bl	encode
.L13:
	ldr	r0, [fp, #-24]
	bl	fclose
	ldr	r0, [fp, #-28]
	bl	fclose
	sub	r1, fp, #64
	sub	r3, fp, #56
	mov	r2, #0
	mov	r0, r3
	bl	png_destroy_read_struct
	sub	r1, fp, #68
	sub	r3, fp, #60
	mov	r2, #0
	mov	r0, r3
	bl	png_destroy_read_struct
	mov	r3, #0
.L14:
	mov	r0, r3
	sub	sp, fp, #8
	@ sp needed
	pop	{r4, fp, pc}
	.size	main, .-main
	.align	2
	.global	valid_parameters
	.syntax unified
	.arm
	.fpu neon
	.type	valid_parameters, %function
valid_parameters:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	push	{lr}
	bl	__gnu_mcount_nc
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	mov	r1, #0
	ldr	r0, [fp, #-16]
	bl	open
	mov	r3, r0
	cmn	r3, #1
	moveq	r3, #1
	movne	r3, #0
	uxtb	r3, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L16
	mov	r3, #0
	b	.L17
.L16:
	mov	r1, #0
	ldr	r0, [fp, #-20]
	bl	open
	str	r0, [fp, #-12]
	ldr	r3, [fp, #-12]
	cmn	r3, #1
	bne	.L18
	ldr	r0, [fp, #-8]
	bl	close
	mov	r3, #0
	b	.L17
.L18:
	ldr	r0, [fp, #-12]
	bl	close
	mov	r3, #1
.L17:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	valid_parameters, .-valid_parameters
	.section	.rodata
	.align	2
.LC5:
	.ascii	"%d\012\000"
	.text
	.align	2
	.global	encode
	.syntax unified
	.arm
	.fpu neon
	.type	encode, %function
encode:
	@ args = 8, pretend = 0, frame = 96
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	sub	sp, sp, #96
	push	{lr}
	bl	__gnu_mcount_nc
	str	r0, [fp, #-104]
	str	r1, [fp, #-108]
	str	r2, [fp, #-112]
	str	r3, [fp, #-116]
	mov	r3, sp
	mov	r7, r3
	ldr	r3, [fp, #-112]
	lsl	r3, r3, #16
	add	r2, r3, #15
	cmp	r3, #0
	movlt	r3, r2
	movge	r3, r3
	asr	r3, r3, #4
	asr	r3, r3, #16
	str	r3, [fp, #-52]
	ldr	r3, [fp, #4]
	lsl	r3, r3, #16
	add	r2, r3, #15
	cmp	r3, #0
	movlt	r3, r2
	movge	r3, r3
	asr	r3, r3, #4
	asr	r3, r3, #16
	str	r3, [fp, #-56]
	ldr	r3, [fp, #-52]
	lsl	r3, r3, #4
	str	r3, [fp, #-60]
	ldr	r3, [fp, #-56]
	lsl	r3, r3, #4
	str	r3, [fp, #-64]
	ldr	ip, [fp, #-56]
	ldr	lr, [fp, #-52]
	sub	r3, ip, #1
	str	r3, [fp, #-68]
	mov	r3, ip
	lsl	r4, r3, #1
	sub	r3, lr, #1
	str	r3, [fp, #-72]
	mov	r3, ip
	mov	r0, r3
	mov	r1, #0
	mov	r3, lr
	mov	r2, r3
	mov	r3, #0
	mul	r6, r2, r1
	mul	r5, r0, r3
	add	r5, r6, r5
	umull	r2, r3, r0, r2
	add	r1, r5, r3
	mov	r3, r1
	mov	r3, ip
	mov	r0, r3
	mov	r1, #0
	mov	r3, lr
	mov	r2, r3
	mov	r3, #0
	mul	r6, r2, r1
	mul	r5, r0, r3
	add	r5, r6, r5
	umull	r2, r3, r0, r2
	add	r1, r5, r3
	mov	r3, r1
	mov	r3, ip
	mov	r2, lr
	mul	r3, r2, r3
	lsl	r3, r3, #1
	add	r3, r3, #7
	lsr	r3, r3, #3
	lsl	r3, r3, #3
	sub	sp, sp, r3
	mov	r3, sp
	add	r3, r3, #1
	lsr	r3, r3, #1
	lsl	r3, r3, #1
	str	r3, [fp, #-76]
	ldr	r0, [fp, #-76]
	ldr	r3, [fp, #-52]
	ldr	r2, [fp, #-56]
	mul	r3, r2, r3
	lsl	r3, r3, #1
	mov	r2, r3
	mov	r1, #0
	bl	memset
	mov	r3, #0
	str	r3, [fp, #-80]
	mov	r3, #0
	str	r3, [fp, #-48]
	mov	r3, #0
	str	r3, [fp, #-40]
	b	.L20
.L23:
	mov	r3, #0
	str	r3, [fp, #-44]
	mov	r3, #0
	str	r3, [fp, #-36]
	b	.L21
.L22:
	SAD r4, r0, r1
	SAD r4, r2, r3
	
	ldr	r0, [fp, #-1]
	ldr	r1, [fp, #-2]
	ldr	r2, [fp, #-3]
	ldr	r3, [fp, #-4]

	SAD r4, r0, r1
	SAD r4, r2, r3

	ldr	r0, [fp, #-5]
	ldr	r1, [fp, #-6]
	ldr	r2, [fp, #-7]
	ldr	r3, [fp, #-8]

	SAD r4, r0, r1
	SAD r4, r2, r3

	ldr	r0, [fp, #-9]
	ldr	r1, [fp, #-10]
	ldr	r2, [fp, #-11]
	ldr	r3, [fp, #-12]

	SAD r4, r0, r1
	SAD r4, r2, r3

	ldr	r0, [fp, #-13]
	ldr	r1, [fp, #-14]
	ldr	r2, [fp, #-15]
	ldr	r3, [fp, #-16]

	SAD r4, r0, r1
	SAD r4, r2, r3

	ldr	r0, [fp, #-17]
	ldr	r1, [fp, #-18]
	ldr	r2, [fp, #-19]
	ldr	r3, [fp, #-20]

	SAD r4, r0, r1
	SAD r4, r2, r3

	ldr	r0, [fp, #-21]
	ldr	r1, [fp, #-22]
	ldr	r2, [fp, #-23]
	ldr	r3, [fp, #-24]

	SAD r4, r0, r1
	SAD r4, r2, r3

	ldr	r0, [fp, #-25]
	ldr	r1, [fp, #-26]
	ldr	r2, [fp, #-27]
	ldr	r3, [fp, #-28]

	SAD r4, r0, r1
	SAD r4, r2, r3
	
.L21:
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-64]
	cmp	r2, r3
	blt	.L22
	ldr	r3, [fp, #-48]
	add	r3, r3, #1
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-40]
	add	r3, r3, #16
	str	r3, [fp, #-40]
.L20:
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-60]
	cmp	r2, r3
	blt	.L23
	mov	r3, #0
	str	r3, [fp, #-32]
	b	.L24
.L35:
	mov	r3, #0
	str	r3, [fp, #-28]
	b	.L25
.L34:
	lsr	r3, r4, #1
	ldr	r2, [fp, #-76]
	ldr	r1, [fp, #-32]
	mul	r1, r1, r3
	ldr	r3, [fp, #-28]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-92]
	mov	r3, #0
	str	r3, [fp, #-96]
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	ble	.L26
	ldr	r3, [fp, #-28]
	add	r3, r3, #1
	ldr	r2, [fp, #-56]
	cmp	r2, r3
	ble	.L27
	lsr	r1, r4, #1
	ldr	r3, [fp, #-28]
	add	r3, r3, #1
	ldr	r2, [fp, #-76]
	ldr	r0, [fp, #-32]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-24]
	cmp	r3, r2
	ble	.L28
	lsr	r1, r4, #1
	ldr	r3, [fp, #-28]
	add	r3, r3, #1
	ldr	r2, [fp, #-76]
	ldr	r0, [fp, #-32]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-24]
	mov	r3, #1
	str	r3, [fp, #-92]
	mov	r3, #0
	str	r3, [fp, #-96]
.L28:
	ldr	r3, [fp, #-28]
	add	r3, r3, #2
	ldr	r2, [fp, #-56]
	cmp	r2, r3
	ble	.L27
	lsr	r1, r4, #1
	ldr	r3, [fp, #-28]
	add	r3, r3, #2
	ldr	r2, [fp, #-76]
	ldr	r0, [fp, #-32]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-24]
	cmp	r3, r2
	ble	.L27
	lsr	r1, r4, #1
	ldr	r3, [fp, #-28]
	add	r3, r3, #2
	ldr	r2, [fp, #-76]
	ldr	r0, [fp, #-32]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-24]
	mov	r3, #2
	str	r3, [fp, #-92]
	mov	r3, #0
	str	r3, [fp, #-96]
.L27:
	ldr	r3, [fp, #-28]
	cmp	r3, #0
	ble	.L29
	lsr	r1, r4, #1
	ldr	r3, [fp, #-28]
	sub	r3, r3, #1
	ldr	r2, [fp, #-76]
	ldr	r0, [fp, #-32]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-24]
	cmp	r3, r2
	ble	.L30
	lsr	r1, r4, #1
	ldr	r3, [fp, #-28]
	sub	r3, r3, #1
	ldr	r2, [fp, #-76]
	ldr	r0, [fp, #-32]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-24]
	mvn	r3, #0
	str	r3, [fp, #-92]
	mov	r3, #0
	str	r3, [fp, #-96]
.L30:
	ldr	r3, [fp, #-28]
	cmp	r3, #1
	ble	.L29
	lsr	r1, r4, #1
	ldr	r3, [fp, #-28]
	sub	r3, r3, #2
	ldr	r2, [fp, #-76]
	ldr	r0, [fp, #-32]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-24]
	cmp	r3, r2
	ble	.L29
	lsr	r1, r4, #1
	ldr	r3, [fp, #-28]
	sub	r3, r3, #2
	ldr	r2, [fp, #-76]
	ldr	r0, [fp, #-32]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-24]
	mvn	r3, #1
	str	r3, [fp, #-92]
	mov	r3, #0
	str	r3, [fp, #-96]
.L29:
	ldr	r3, [fp, #-32]
	add	r3, r3, #1
	ldr	r2, [fp, #-52]
	cmp	r2, r3
	ble	.L31
	lsr	r3, r4, #1
	ldr	r2, [fp, #-32]
	add	r1, r2, #1
	ldr	r2, [fp, #-76]
	mul	r1, r1, r3
	ldr	r3, [fp, #-28]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-24]
	cmp	r3, r2
	ble	.L32
	lsr	r3, r4, #1
	ldr	r2, [fp, #-32]
	add	r1, r2, #1
	ldr	r2, [fp, #-76]
	mul	r1, r1, r3
	ldr	r3, [fp, #-28]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-92]
	mov	r3, #1
	str	r3, [fp, #-96]
.L32:
	ldr	r3, [fp, #-32]
	add	r3, r3, #2
	ldr	r2, [fp, #-52]
	cmp	r2, r3
	ble	.L31
	lsr	r3, r4, #1
	ldr	r2, [fp, #-32]
	add	r1, r2, #2
	ldr	r2, [fp, #-76]
	mul	r1, r1, r3
	ldr	r3, [fp, #-28]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-24]
	cmp	r3, r2
	ble	.L31
	lsr	r3, r4, #1
	ldr	r2, [fp, #-32]
	add	r1, r2, #2
	ldr	r2, [fp, #-76]
	mul	r1, r1, r3
	ldr	r3, [fp, #-28]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-92]
	mov	r3, #2
	str	r3, [fp, #-96]
.L31:
	ldr	r3, [fp, #-32]
	cmp	r3, #0
	ble	.L26
	lsr	r3, r4, #1
	ldr	r2, [fp, #-32]
	sub	r1, r2, #1
	ldr	r2, [fp, #-76]
	mul	r1, r1, r3
	ldr	r3, [fp, #-28]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-24]
	cmp	r3, r2
	ble	.L33
	lsr	r3, r4, #1
	ldr	r2, [fp, #-32]
	sub	r1, r2, #1
	ldr	r2, [fp, #-76]
	mul	r1, r1, r3
	ldr	r3, [fp, #-28]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-92]
	mvn	r3, #0
	str	r3, [fp, #-96]
.L33:
	ldr	r3, [fp, #-32]
	cmp	r3, #1
	ble	.L26
	lsr	r3, r4, #1
	ldr	r2, [fp, #-32]
	sub	r1, r2, #2
	ldr	r2, [fp, #-76]
	mul	r1, r1, r3
	ldr	r3, [fp, #-28]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-24]
	cmp	r3, r2
	ble	.L26
	lsr	r3, r4, #1
	ldr	r2, [fp, #-32]
	sub	r1, r2, #2
	ldr	r2, [fp, #-76]
	mul	r1, r1, r3
	ldr	r3, [fp, #-28]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-92]
	mvn	r3, #1
	str	r3, [fp, #-96]
.L26:
	ldr	r3, [fp, #-28]
	add	r3, r3, #1
	str	r3, [fp, #-28]
.L25:
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-56]
	cmp	r2, r3
	blt	.L34
	ldr	r3, [fp, #-32]
	add	r3, r3, #1
	str	r3, [fp, #-32]
.L24:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-52]
	cmp	r2, r3
	blt	.L35
	mov	sp, r7
	nop
	sub	sp, fp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, fp, pc}
	.size	encode, .-encode
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
