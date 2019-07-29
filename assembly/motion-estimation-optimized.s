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
	.file	"motion-estimation-optimized.c"
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
	.align	2
	.global	encode
	.syntax unified
	.arm
	.fpu neon
	.type	encode, %function
encode:
	@ args = 8, pretend = 0, frame = 1504
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	sub	sp, sp, #1504
	push	{lr}
	bl	__gnu_mcount_nc
	str	r0, [fp, #-1512]
	str	r1, [fp, #-1516]
	str	r2, [fp, #-1520]
	str	r3, [fp, #-1524]
	mov	r3, sp
	mov	r7, r3
	ldr	r3, [fp, #-1520]
	lsl	r3, r3, #16
	add	r2, r3, #15
	cmp	r3, #0
	movlt	r3, r2
	movge	r3, r3
	asr	r3, r3, #4
	asr	r3, r3, #16
	str	r3, [fp, #-60]
	ldr	r3, [fp, #4]
	lsl	r3, r3, #16
	add	r2, r3, #15
	cmp	r3, #0
	movlt	r3, r2
	movge	r3, r3
	asr	r3, r3, #4
	asr	r3, r3, #16
	str	r3, [fp, #-64]
	ldr	r3, [fp, #-60]
	lsl	r3, r3, #4
	str	r3, [fp, #-68]
	ldr	r3, [fp, #-64]
	lsl	r3, r3, #4
	str	r3, [fp, #-72]
	ldr	ip, [fp, #-64]
	ldr	lr, [fp, #-60]
	sub	r3, ip, #1
	str	r3, [fp, #-76]
	mov	r3, ip
	lsl	r4, r3, #1
	sub	r3, lr, #1
	str	r3, [fp, #-80]
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
	str	r3, [fp, #-84]
	ldr	r0, [fp, #-84]
	ldr	r3, [fp, #-60]
	ldr	r2, [fp, #-64]
	mul	r3, r2, r3
	lsl	r3, r3, #1
	mov	r2, r3
	mov	r1, #0
	bl	memset
	mov	r3, #0
	str	r3, [fp, #-88]
	mov	r3, #0
	str	r3, [fp, #-52]
	mov	r3, #0
	str	r3, [fp, #-44]
	b	.L20
.L73:
	mov	r3, #0
	str	r3, [fp, #-48]
	mov	r3, #0
	str	r3, [fp, #-40]
	b	.L21
.L22:
	ldr	r3, [fp, #-44]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1252]
	ldr	r3, [fp, #-1252]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-108]
	vstr	d17, [fp, #-100]
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1248]
	ldr	r3, [fp, #-1248]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-124]
	vstr	d17, [fp, #-116]
	ldr	r3, [fp, #-44]
	add	r3, r3, #2
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1244]
	ldr	r3, [fp, #-1244]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-140]
	vstr	d17, [fp, #-132]
	ldr	r3, [fp, #-44]
	add	r3, r3, #3
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1240]
	ldr	r3, [fp, #-1240]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-156]
	vstr	d17, [fp, #-148]
	ldr	r3, [fp, #-44]
	add	r3, r3, #4
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1236]
	ldr	r3, [fp, #-1236]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-172]
	vstr	d17, [fp, #-164]
	ldr	r3, [fp, #-44]
	add	r3, r3, #5
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1232]
	ldr	r3, [fp, #-1232]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-188]
	vstr	d17, [fp, #-180]
	ldr	r3, [fp, #-44]
	add	r3, r3, #6
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1228]
	ldr	r3, [fp, #-1228]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-204]
	vstr	d17, [fp, #-196]
	ldr	r3, [fp, #-44]
	add	r3, r3, #7
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1224]
	ldr	r3, [fp, #-1224]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-220]
	vstr	d17, [fp, #-212]
	ldr	r3, [fp, #-44]
	add	r3, r3, #8
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1220]
	ldr	r3, [fp, #-1220]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-236]
	vstr	d17, [fp, #-228]
	ldr	r3, [fp, #-44]
	add	r3, r3, #9
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1216]
	ldr	r3, [fp, #-1216]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-252]
	vstr	d17, [fp, #-244]
	ldr	r3, [fp, #-44]
	add	r3, r3, #10
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1212]
	ldr	r3, [fp, #-1212]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-268]
	vstr	d17, [fp, #-260]
	ldr	r3, [fp, #-44]
	add	r3, r3, #11
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1208]
	ldr	r3, [fp, #-1208]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-284]
	vstr	d17, [fp, #-276]
	ldr	r3, [fp, #-44]
	add	r3, r3, #12
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1204]
	ldr	r3, [fp, #-1204]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-300]
	vstr	d17, [fp, #-292]
	ldr	r3, [fp, #-44]
	add	r3, r3, #13
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1200]
	ldr	r3, [fp, #-1200]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-316]
	vstr	d17, [fp, #-308]
	ldr	r3, [fp, #-44]
	add	r3, r3, #14
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1196]
	ldr	r3, [fp, #-1196]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-332]
	vstr	d17, [fp, #-324]
	ldr	r3, [fp, #-44]
	add	r3, r3, #15
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1516]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1192]
	ldr	r3, [fp, #-1192]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-348]
	vstr	d17, [fp, #-340]
	ldr	r3, [fp, #-44]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1188]
	ldr	r3, [fp, #-1188]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-364]
	vstr	d17, [fp, #-356]
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1184]
	ldr	r3, [fp, #-1184]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-380]
	vstr	d17, [fp, #-372]
	ldr	r3, [fp, #-44]
	add	r3, r3, #2
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1180]
	ldr	r3, [fp, #-1180]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-396]
	vstr	d17, [fp, #-388]
	ldr	r3, [fp, #-44]
	add	r3, r3, #3
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1176]
	ldr	r3, [fp, #-1176]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-412]
	vstr	d17, [fp, #-404]
	ldr	r3, [fp, #-44]
	add	r3, r3, #4
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1172]
	ldr	r3, [fp, #-1172]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-428]
	vstr	d17, [fp, #-420]
	ldr	r3, [fp, #-44]
	add	r3, r3, #5
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1168]
	ldr	r3, [fp, #-1168]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-444]
	vstr	d17, [fp, #-436]
	ldr	r3, [fp, #-44]
	add	r3, r3, #6
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1164]
	ldr	r3, [fp, #-1164]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-460]
	vstr	d17, [fp, #-452]
	ldr	r3, [fp, #-44]
	add	r3, r3, #7
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1160]
	ldr	r3, [fp, #-1160]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-476]
	vstr	d17, [fp, #-468]
	ldr	r3, [fp, #-44]
	add	r3, r3, #8
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1156]
	ldr	r3, [fp, #-1156]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-492]
	vstr	d17, [fp, #-484]
	ldr	r3, [fp, #-44]
	add	r3, r3, #9
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1152]
	ldr	r3, [fp, #-1152]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-508]
	vstr	d17, [fp, #-500]
	ldr	r3, [fp, #-44]
	add	r3, r3, #10
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1148]
	ldr	r3, [fp, #-1148]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-524]
	vstr	d17, [fp, #-516]
	ldr	r3, [fp, #-44]
	add	r3, r3, #11
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1144]
	ldr	r3, [fp, #-1144]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-540]
	vstr	d17, [fp, #-532]
	ldr	r3, [fp, #-44]
	add	r3, r3, #12
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1140]
	ldr	r3, [fp, #-1140]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-556]
	vstr	d17, [fp, #-548]
	ldr	r3, [fp, #-44]
	add	r3, r3, #13
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1136]
	ldr	r3, [fp, #-1136]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-572]
	vstr	d17, [fp, #-564]
	ldr	r3, [fp, #-44]
	add	r3, r3, #14
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1132]
	ldr	r3, [fp, #-1132]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-588]
	vstr	d17, [fp, #-580]
	ldr	r3, [fp, #-44]
	add	r3, r3, #15
	lsl	r3, r3, #2
	ldr	r2, [fp, #-1512]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-1128]
	ldr	r3, [fp, #-1128]
	vld1.8	{d16-d17}, [r3]
	vstr	d16, [fp, #-604]
	vstr	d17, [fp, #-596]
	sub	r3, fp, #20
	sub	r3, r3, #1088
	vldr	d16, [fp, #-364]
	vldr	d17, [fp, #-356]
	vst1.64	{d16-d17}, [r3:64]
	sub	r3, fp, #20
	sub	r3, r3, #1104
	vldr	d16, [fp, #-108]
	vldr	d17, [fp, #-100]
	vst1.64	{d16-d17}, [r3:64]
	sub	r3, fp, #20
	sub	r3, r3, #1088
	vld1.64	{d16-d17}, [r3:64]
	sub	r3, fp, #20
	sub	r3, r3, #1104
	vld1.64	{d18-d19}, [r3:64]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1248
	vst1.64	{d16-d17}, [r3:64]
	sub	r3, fp, #20
	sub	r3, r3, #1056
	vldr	d16, [fp, #-380]
	vldr	d17, [fp, #-372]
	vst1.64	{d16-d17}, [r3:64]
	sub	r3, fp, #20
	sub	r3, r3, #1072
	vldr	d16, [fp, #-124]
	vldr	d17, [fp, #-116]
	vst1.64	{d16-d17}, [r3:64]
	sub	r3, fp, #20
	sub	r3, r3, #1056
	vld1.64	{d16-d17}, [r3:64]
	sub	r3, fp, #20
	sub	r3, r3, #1072
	vld1.64	{d18-d19}, [r3:64]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1264
	vst1.64	{d16-d17}, [r3:64]
	sub	r3, fp, #20
	sub	r3, r3, #1024
	vldr	d16, [fp, #-396]
	vldr	d17, [fp, #-388]
	vst1.64	{d16-d17}, [r3:64]
	sub	r3, fp, #20
	sub	r3, r3, #1040
	vldr	d16, [fp, #-140]
	vldr	d17, [fp, #-132]
	vst1.64	{d16-d17}, [r3:64]
	sub	r3, fp, #20
	sub	r3, r3, #1024
	vld1.64	{d16-d17}, [r3:64]
	sub	r3, fp, #20
	sub	r3, r3, #1040
	vld1.64	{d18-d19}, [r3:64]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1280
	vst1.64	{d16-d17}, [r3:64]
	vldr	d16, [fp, #-412]
	vldr	d17, [fp, #-404]
	vstr	d16, [fp, #-1012]
	vstr	d17, [fp, #-1004]
	vldr	d16, [fp, #-156]
	vldr	d17, [fp, #-148]
	sub	r3, fp, #1024
	sub	r3, r3, #4
	vst1.64	{d16-d17}, [r3:64]
	vldr	d16, [fp, #-1012]
	vldr	d17, [fp, #-1004]
	sub	r3, fp, #1024
	sub	r3, r3, #4
	vld1.64	{d18-d19}, [r3:64]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1296
	vst1.64	{d16-d17}, [r3:64]
	vldr	d16, [fp, #-428]
	vldr	d17, [fp, #-420]
	vstr	d16, [fp, #-980]
	vstr	d17, [fp, #-972]
	vldr	d16, [fp, #-172]
	vldr	d17, [fp, #-164]
	vstr	d16, [fp, #-996]
	vstr	d17, [fp, #-988]
	vldr	d16, [fp, #-980]
	vldr	d17, [fp, #-972]
	vldr	d18, [fp, #-996]
	vldr	d19, [fp, #-988]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1312
	vst1.64	{d16-d17}, [r3:64]
	vldr	d16, [fp, #-444]
	vldr	d17, [fp, #-436]
	vstr	d16, [fp, #-948]
	vstr	d17, [fp, #-940]
	vldr	d16, [fp, #-188]
	vldr	d17, [fp, #-180]
	vstr	d16, [fp, #-964]
	vstr	d17, [fp, #-956]
	vldr	d16, [fp, #-948]
	vldr	d17, [fp, #-940]
	vldr	d18, [fp, #-964]
	vldr	d19, [fp, #-956]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1328
	vst1.64	{d16-d17}, [r3:64]
	vldr	d16, [fp, #-460]
	vldr	d17, [fp, #-452]
	vstr	d16, [fp, #-916]
	vstr	d17, [fp, #-908]
	vldr	d16, [fp, #-204]
	vldr	d17, [fp, #-196]
	vstr	d16, [fp, #-932]
	vstr	d17, [fp, #-924]
	vldr	d16, [fp, #-916]
	vldr	d17, [fp, #-908]
	vldr	d18, [fp, #-932]
	vldr	d19, [fp, #-924]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1344
	vst1.64	{d16-d17}, [r3:64]
	vldr	d16, [fp, #-476]
	vldr	d17, [fp, #-468]
	vstr	d16, [fp, #-884]
	vstr	d17, [fp, #-876]
	vldr	d16, [fp, #-220]
	vldr	d17, [fp, #-212]
	vstr	d16, [fp, #-900]
	vstr	d17, [fp, #-892]
	vldr	d16, [fp, #-884]
	vldr	d17, [fp, #-876]
	vldr	d18, [fp, #-900]
	vldr	d19, [fp, #-892]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1360
	vst1.64	{d16-d17}, [r3:64]
	vldr	d16, [fp, #-492]
	vldr	d17, [fp, #-484]
	vstr	d16, [fp, #-852]
	vstr	d17, [fp, #-844]
	vldr	d16, [fp, #-236]
	vldr	d17, [fp, #-228]
	vstr	d16, [fp, #-868]
	vstr	d17, [fp, #-860]
	vldr	d16, [fp, #-852]
	vldr	d17, [fp, #-844]
	vldr	d18, [fp, #-868]
	vldr	d19, [fp, #-860]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1376
	vst1.64	{d16-d17}, [r3:64]
	vldr	d16, [fp, #-508]
	vldr	d17, [fp, #-500]
	vstr	d16, [fp, #-820]
	vstr	d17, [fp, #-812]
	vldr	d16, [fp, #-252]
	vldr	d17, [fp, #-244]
	vstr	d16, [fp, #-836]
	vstr	d17, [fp, #-828]
	vldr	d16, [fp, #-820]
	vldr	d17, [fp, #-812]
	vldr	d18, [fp, #-836]
	vldr	d19, [fp, #-828]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1392
	vst1.64	{d16-d17}, [r3:64]
	vldr	d16, [fp, #-524]
	vldr	d17, [fp, #-516]
	vstr	d16, [fp, #-788]
	vstr	d17, [fp, #-780]
	vldr	d16, [fp, #-268]
	vldr	d17, [fp, #-260]
	vstr	d16, [fp, #-804]
	vstr	d17, [fp, #-796]
	vldr	d16, [fp, #-788]
	vldr	d17, [fp, #-780]
	vldr	d18, [fp, #-804]
	vldr	d19, [fp, #-796]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1408
	vst1.64	{d16-d17}, [r3:64]
	vldr	d16, [fp, #-540]
	vldr	d17, [fp, #-532]
	vstr	d16, [fp, #-756]
	vstr	d17, [fp, #-748]
	vldr	d16, [fp, #-284]
	vldr	d17, [fp, #-276]
	vstr	d16, [fp, #-772]
	vstr	d17, [fp, #-764]
	vldr	d16, [fp, #-756]
	vldr	d17, [fp, #-748]
	vldr	d18, [fp, #-772]
	vldr	d19, [fp, #-764]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1424
	vst1.64	{d16-d17}, [r3:64]
	vldr	d16, [fp, #-556]
	vldr	d17, [fp, #-548]
	vstr	d16, [fp, #-724]
	vstr	d17, [fp, #-716]
	vldr	d16, [fp, #-300]
	vldr	d17, [fp, #-292]
	vstr	d16, [fp, #-740]
	vstr	d17, [fp, #-732]
	vldr	d16, [fp, #-724]
	vldr	d17, [fp, #-716]
	vldr	d18, [fp, #-740]
	vldr	d19, [fp, #-732]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1440
	vst1.64	{d16-d17}, [r3:64]
	vldr	d16, [fp, #-572]
	vldr	d17, [fp, #-564]
	vstr	d16, [fp, #-692]
	vstr	d17, [fp, #-684]
	vldr	d16, [fp, #-316]
	vldr	d17, [fp, #-308]
	vstr	d16, [fp, #-708]
	vstr	d17, [fp, #-700]
	vldr	d16, [fp, #-692]
	vldr	d17, [fp, #-684]
	vldr	d18, [fp, #-708]
	vldr	d19, [fp, #-700]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1456
	vst1.64	{d16-d17}, [r3:64]
	vldr	d16, [fp, #-588]
	vldr	d17, [fp, #-580]
	vstr	d16, [fp, #-660]
	vstr	d17, [fp, #-652]
	vldr	d16, [fp, #-332]
	vldr	d17, [fp, #-324]
	vstr	d16, [fp, #-676]
	vstr	d17, [fp, #-668]
	vldr	d16, [fp, #-660]
	vldr	d17, [fp, #-652]
	vldr	d18, [fp, #-676]
	vldr	d19, [fp, #-668]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1472
	vst1.64	{d16-d17}, [r3:64]
	vldr	d16, [fp, #-604]
	vldr	d17, [fp, #-596]
	vstr	d16, [fp, #-628]
	vstr	d17, [fp, #-620]
	vldr	d16, [fp, #-348]
	vldr	d17, [fp, #-340]
	vstr	d16, [fp, #-644]
	vstr	d17, [fp, #-636]
	vldr	d16, [fp, #-628]
	vldr	d17, [fp, #-620]
	vldr	d18, [fp, #-644]
	vldr	d19, [fp, #-636]
	vabd.u8	q8, q8, q9
	sub	r3, fp, #20
	sub	r3, r3, #1488
	vst1.64	{d16-d17}, [r3:64]
	mov	r3, #0
	strh	r3, [fp, #-34]	@ movhi
	mov	r3, #0
	str	r3, [fp, #-32]
	b	.L70
.L71:
	sub	r3, fp, #20
	sub	r2, r3, #1248
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	sub	r3, fp, #20
	sub	r2, r3, #1264
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	sub	r3, fp, #20
	sub	r2, r3, #1280
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	sub	r3, fp, #20
	sub	r2, r3, #1296
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	sub	r3, fp, #20
	sub	r2, r3, #1312
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	sub	r3, fp, #20
	sub	r2, r3, #1328
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	sub	r3, fp, #20
	sub	r2, r3, #1344
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	sub	r3, fp, #20
	sub	r2, r3, #1360
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	sub	r3, fp, #20
	sub	r2, r3, #1376
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	sub	r3, fp, #20
	sub	r2, r3, #1392
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	sub	r3, fp, #20
	sub	r2, r3, #1408
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	sub	r3, fp, #20
	sub	r2, r3, #1424
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	sub	r3, fp, #20
	sub	r2, r3, #1440
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	sub	r3, fp, #20
	sub	r2, r3, #1456
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	sub	r3, fp, #20
	sub	r2, r3, #1472
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	sub	r3, fp, #20
	sub	r2, r3, #1488
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldrh	r3, [fp, #-34]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	ldr	r3, [fp, #-32]
	add	r3, r3, #1
	str	r3, [fp, #-32]
.L70:
	ldr	r3, [fp, #-32]
	cmp	r3, #15
	ble	.L71
	lsr	r3, r4, #1
	ldr	r2, [fp, #-84]
	ldr	r1, [fp, #-52]
	mul	r1, r1, r3
	ldr	r3, [fp, #-48]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r2, [fp, #-34]	@ movhi
	strh	r2, [r3]	@ movhi
	ldr	r3, [fp, #-48]
	add	r3, r3, #1
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-40]
	add	r3, r3, #16
	str	r3, [fp, #-40]
.L21:
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-72]
	cmp	r2, r3
	blt	.L72
	ldr	r3, [fp, #-52]
	add	r3, r3, #1
	str	r3, [fp, #-52]
	ldr	r3, [fp, #-44]
	add	r3, r3, #16
	str	r3, [fp, #-44]
.L20:
	ldr	r2, [fp, #-44]
	ldr	r3, [fp, #-68]
	cmp	r2, r3
	blt	.L73
	mov	r3, #0
	str	r3, [fp, #-28]
	b	.L74
.L85:
	mov	r3, #0
	str	r3, [fp, #-24]
	b	.L75
.L84:
	lsr	r3, r4, #1
	ldr	r2, [fp, #-84]
	ldr	r1, [fp, #-28]
	mul	r1, r1, r3
	ldr	r3, [fp, #-24]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-56]
	mov	r3, #0
	str	r3, [fp, #-608]
	mov	r3, #0
	str	r3, [fp, #-612]
	ldr	r3, [fp, #-56]
	cmp	r3, #0
	ble	.L76
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	ldr	r2, [fp, #-64]
	cmp	r2, r3
	ble	.L77
	lsr	r1, r4, #1
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	ldr	r2, [fp, #-84]
	ldr	r0, [fp, #-28]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-56]
	cmp	r3, r2
	ble	.L78
	lsr	r1, r4, #1
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	ldr	r2, [fp, #-84]
	ldr	r0, [fp, #-28]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-56]
	mov	r3, #1
	str	r3, [fp, #-608]
	mov	r3, #0
	str	r3, [fp, #-612]
.L78:
	ldr	r3, [fp, #-24]
	add	r3, r3, #2
	ldr	r2, [fp, #-64]
	cmp	r2, r3
	ble	.L77
	lsr	r1, r4, #1
	ldr	r3, [fp, #-24]
	add	r3, r3, #2
	ldr	r2, [fp, #-84]
	ldr	r0, [fp, #-28]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-56]
	cmp	r3, r2
	ble	.L77
	lsr	r1, r4, #1
	ldr	r3, [fp, #-24]
	add	r3, r3, #2
	ldr	r2, [fp, #-84]
	ldr	r0, [fp, #-28]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-56]
	mov	r3, #2
	str	r3, [fp, #-608]
	mov	r3, #0
	str	r3, [fp, #-612]
.L77:
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	ble	.L79
	lsr	r1, r4, #1
	ldr	r3, [fp, #-24]
	sub	r3, r3, #1
	ldr	r2, [fp, #-84]
	ldr	r0, [fp, #-28]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-56]
	cmp	r3, r2
	ble	.L80
	lsr	r1, r4, #1
	ldr	r3, [fp, #-24]
	sub	r3, r3, #1
	ldr	r2, [fp, #-84]
	ldr	r0, [fp, #-28]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-56]
	mvn	r3, #0
	str	r3, [fp, #-608]
	mov	r3, #0
	str	r3, [fp, #-612]
.L80:
	ldr	r3, [fp, #-24]
	cmp	r3, #1
	ble	.L79
	lsr	r1, r4, #1
	ldr	r3, [fp, #-24]
	sub	r3, r3, #2
	ldr	r2, [fp, #-84]
	ldr	r0, [fp, #-28]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-56]
	cmp	r3, r2
	ble	.L79
	lsr	r1, r4, #1
	ldr	r3, [fp, #-24]
	sub	r3, r3, #2
	ldr	r2, [fp, #-84]
	ldr	r0, [fp, #-28]
	mul	r1, r0, r1
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-56]
	mvn	r3, #1
	str	r3, [fp, #-608]
	mov	r3, #0
	str	r3, [fp, #-612]
.L79:
	ldr	r3, [fp, #-28]
	add	r3, r3, #1
	ldr	r2, [fp, #-60]
	cmp	r2, r3
	ble	.L81
	lsr	r3, r4, #1
	ldr	r2, [fp, #-28]
	add	r1, r2, #1
	ldr	r2, [fp, #-84]
	mul	r1, r1, r3
	ldr	r3, [fp, #-24]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-56]
	cmp	r3, r2
	ble	.L82
	lsr	r3, r4, #1
	ldr	r2, [fp, #-28]
	add	r1, r2, #1
	ldr	r2, [fp, #-84]
	mul	r1, r1, r3
	ldr	r3, [fp, #-24]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-56]
	mov	r3, #0
	str	r3, [fp, #-608]
	mov	r3, #1
	str	r3, [fp, #-612]
.L82:
	ldr	r3, [fp, #-28]
	add	r3, r3, #2
	ldr	r2, [fp, #-60]
	cmp	r2, r3
	ble	.L81
	lsr	r3, r4, #1
	ldr	r2, [fp, #-28]
	add	r1, r2, #2
	ldr	r2, [fp, #-84]
	mul	r1, r1, r3
	ldr	r3, [fp, #-24]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-56]
	cmp	r3, r2
	ble	.L81
	lsr	r3, r4, #1
	ldr	r2, [fp, #-28]
	add	r1, r2, #2
	ldr	r2, [fp, #-84]
	mul	r1, r1, r3
	ldr	r3, [fp, #-24]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-56]
	mov	r3, #0
	str	r3, [fp, #-608]
	mov	r3, #2
	str	r3, [fp, #-612]
.L81:
	ldr	r3, [fp, #-28]
	cmp	r3, #0
	ble	.L76
	lsr	r3, r4, #1
	ldr	r2, [fp, #-28]
	sub	r1, r2, #1
	ldr	r2, [fp, #-84]
	mul	r1, r1, r3
	ldr	r3, [fp, #-24]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-56]
	cmp	r3, r2
	ble	.L83
	lsr	r3, r4, #1
	ldr	r2, [fp, #-28]
	sub	r1, r2, #1
	ldr	r2, [fp, #-84]
	mul	r1, r1, r3
	ldr	r3, [fp, #-24]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-56]
	mov	r3, #0
	str	r3, [fp, #-608]
	mvn	r3, #0
	str	r3, [fp, #-612]
.L83:
	ldr	r3, [fp, #-28]
	cmp	r3, #1
	ble	.L76
	lsr	r3, r4, #1
	ldr	r2, [fp, #-28]
	sub	r1, r2, #2
	ldr	r2, [fp, #-84]
	mul	r1, r1, r3
	ldr	r3, [fp, #-24]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r2, r3
	ldr	r3, [fp, #-56]
	cmp	r3, r2
	ble	.L76
	lsr	r3, r4, #1
	ldr	r2, [fp, #-28]
	sub	r1, r2, #2
	ldr	r2, [fp, #-84]
	mul	r1, r1, r3
	ldr	r3, [fp, #-24]
	add	r3, r1, r3
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	str	r3, [fp, #-56]
	mov	r3, #0
	str	r3, [fp, #-608]
	mvn	r3, #1
	str	r3, [fp, #-612]
.L76:
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L75:
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-64]
	cmp	r2, r3
	blt	.L84
	ldr	r3, [fp, #-28]
	add	r3, r3, #1
	str	r3, [fp, #-28]
.L74:
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-60]
	cmp	r2, r3
	blt	.L85
	mov	sp, r7
	nop
	sub	sp, fp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, fp, pc}
	.size	encode, .-encode
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
