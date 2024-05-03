# RUN: llvm-mc -triple x86_64 -show-encoding %s | FileCheck %s


# CHECK: {evex}	rclb	%al
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd0,0xd0]
         {evex}	rclb	$1, %al
# CHECK: {evex}	rclw	%ax
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0xd1,0xd0]
         {evex}	rclw	$1, %ax
# CHECK: {evex}	rcll	%eax
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd1,0xd0]
         {evex}	rcll	$1, %eax
# CHECK: {evex}	rclq	%rax
# CHECK: encoding: [0x62,0xf4,0xfc,0x08,0xd1,0xd0]
         {evex}	rclq	$1, %rax
# CHECK: rclb	%al, %bl
# CHECK: encoding: [0x62,0xf4,0x64,0x18,0xd0,0xd0]
         rclb	$1, %al, %bl
# CHECK: rclw	%ax, %bx
# CHECK: encoding: [0x62,0xf4,0x65,0x18,0xd1,0xd0]
         rclw	$1, %ax, %bx
# CHECK: rcll	%eax, %ebx
# CHECK: encoding: [0x62,0xf4,0x64,0x18,0xd1,0xd0]
         rcll	$1, %eax, %ebx
# CHECK: rclq	%rax, %rbx
# CHECK: encoding: [0x62,0xf4,0xe4,0x18,0xd1,0xd0]
         rclq	$1, %rax, %rbx
# CHECK: {evex}	rclb	123(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd0,0x54,0x80,0x7b]
         {evex}	rclb	$1, 123(%r8,%rax,4)
# CHECK: {evex}	rclw	123(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0xd1,0x54,0x80,0x7b]
         {evex}	rclw	$1, 123(%r8,%rax,4)
# CHECK: {evex}	rcll	123(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd1,0x54,0x80,0x7b]
         {evex}	rcll	$1, 123(%r8,%rax,4)
# CHECK: {evex}	rclq	123(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xd1,0x54,0x80,0x7b]
         {evex}	rclq	$1, 123(%r8,%rax,4)
# CHECK: rclb	123(%r8,%rax,4), %bl
# CHECK: encoding: [0x62,0xd4,0x64,0x18,0xd0,0x54,0x80,0x7b]
         rclb	$1, 123(%r8,%rax,4), %bl
# CHECK: rclw	123(%r8,%rax,4), %bx
# CHECK: encoding: [0x62,0xd4,0x65,0x18,0xd1,0x54,0x80,0x7b]
         rclw	$1, 123(%r8,%rax,4), %bx
# CHECK: rcll	123(%r8,%rax,4), %ebx
# CHECK: encoding: [0x62,0xd4,0x64,0x18,0xd1,0x54,0x80,0x7b]
         rcll	$1, 123(%r8,%rax,4), %ebx
# CHECK: rclq	123(%r8,%rax,4), %rbx
# CHECK: encoding: [0x62,0xd4,0xe4,0x18,0xd1,0x54,0x80,0x7b]
         rclq	$1, 123(%r8,%rax,4), %rbx