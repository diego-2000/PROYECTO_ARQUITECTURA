
	.386
	.model flat, C
	.stack 2560
	.data
	auxiliar dword 0.299,0.587,0.114
	vector dword 0,0,0
	angulo dword 0.5;rad;28.6
	variable_Y REAL4 0.0
	variableY dword 0
	bytes_relleno dword 0
	.code
	;int suma(int a,int b)
	Imagen proc C, a:dword, b:dword, d:dword
	push esi
	push edi
	push ecx
	mov eax,0
	mov ebx,0
	mov esi,[a]
	mov edi,[b]
	mov ecx,8

	bucleA:;bucle de 8
	mov al,[esi]
	mov [edi],al
	inc esi
	inc edi
	loop bucleA;fin bucle de 8

	mov al,[esi]
	SUB al,2
	mov [edi],al
	inc esi
	inc edi

	mov ecx,3
	bucleB:;bucle de 3
	mov al,[esi]
	mov [edi],al
	inc esi
	inc edi
	loop bucleB;fin de bucle de 3

	mov edx,0
	mov eax,[d]
	sub eax,12
	mov ecx,3
	div ecx
	mov ecx,eax
	mov bytes_relleno,eax
	mov eax,0
	bucleC: ;bucle de N

	mov al,[esi]
	mov [vector],eax
	inc esi
	mov al,[esi]
	mov [vector+4],eax
	inc esi
	mov al,[esi]
	mov [vector+8],eax
	inc esi
	fIld dword ptr [vector]

	lea eax,vector
	push eax
	call magnitudd
	fdiv
	fstp [variable_Y]

	;mov eax,variable_Y
	;push eax
	;call arccos

	fld dword ptr [angulo]
	fcos 

	fcom dword ptr [variable_Y]
	fstsw ax 
    sahf
	FSTP ST(0)
	;fstp [variable_Y]
	jna else_if
	lea eax,auxiliar
	push eax
	lea eax,vector
	push eax
	call calcular_y
	;add esp,4
	fistp [variableY]
	mov eax,[variableY]
	mov [edi],al
	jmp end_if
	else_if:
	mov eax,[vector]
	mov [edi],al
	end_if:
	inc edi
	loop bucleC ;fin bucle

	mov edx,0
	mov ecx,4
	mov eax,bytes_relleno
	div ecx
	sub ecx,edx

	cmp ecx,4
	je elsef
	bitsRelleno:
	mov eax,01h
	mov [edi],al
	inc edi
	loop bitsRelleno
	elsef:
	mov eax,0
	mov [edi],al
	pop ecx
	pop edi
	pop esi
	ret 
	Imagen endp

	calcular_y proc C, v:dword, v2:dword
	push esi
	push edi
	push ecx
	mov esi,v
	mov edi,v2
	mov ecx,2
	fld dword ptr [edi]
	fIld dword ptr [esi]
	fmul 
	bucleCal:
	add esi,4
	add edi,4
 	fld dword ptr [edi]
	fIld dword ptr [esi]
	fmul
	fadd
	loop bucleCal
	pop ecx
	pop edi
	pop esi
	ret
	calcular_y endp

	magnitudd proc C, v:dword
	push esi
	push ecx
	mov esi,v
	fIld dword ptr [esi]
	fIld dword ptr [esi]
	fmul
	mov ecx,2
	bucle:
	add esi,4
	fIld dword ptr [esi]
	fIld dword ptr [esi]
	fmul
	FADD
	loop bucle
	fsqrt
	pop ecx
	pop esi
	ret
	magnitudd endp
end