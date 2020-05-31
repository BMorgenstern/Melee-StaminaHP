	.file	"staminaHP.c"
	.section	".text"
	.align 2
	.globl buttonDown
	.type	buttonDown, @function
buttonDown:
	li 9,1
	slw 3,9,3
	lis 9,buttons@ha
	lwz 9,buttons@l(9)
	lhz 9,0(9)
	and 3,3,9
	addic 9,3,-1
	subfe 3,9,3
	blr
	.size	buttonDown, .-buttonDown
	.align 2
	.globl staminaHP
	.type	staminaHP, @function
staminaHP:
	mflr 0
	stwu 1,-8(1)
	li 3,5
	stw 0,12(1)
	bl buttonDown
	cmpwi 7,3,0
	li 9,150
	beq- 7,.L3
	li 3,0
	bl buttonDown
	li 9,300
	cmpwi 7,3,0
	bne- 7,.L3
	li 3,2
	bl buttonDown
	li 9,500
	cmpwi 7,3,0
	bne- 7,.L3
	li 3,1
	bl buttonDown
	li 9,-849
	addic 3,3,-1
	subfe 3,3,3
	and 9,3,9
	addi 9,9,999
.L3:
	lwz 0,12(1)
	mr 3,9
	addi 1,1,8
	mtlr 0
	blr
	.size	staminaHP, .-staminaHP
	.globl buttons
	.section	.sdata,"aw",@progbits
	.align 2
	.type	buttons, @object
	.size	buttons, 4
buttons:
	.long	-2142858944
	.ident	"GCC: (GNU) 4.9.0"
