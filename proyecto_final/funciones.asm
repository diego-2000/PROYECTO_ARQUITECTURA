
	.386
	.model flat, C
	.stack 2560
	.data
	auxiliar dword 0.299,0.587,0.114
	vector dword 0,0,0
	angulo dword 0.5;rad;28.6
	variable_Y REAL4 0.0
	variableY dword 0
	;borrar dword 0.912
	valores_acos qword -0.69813170079773212,0.87266462599716477,1.5707963267948966
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

	mov ecx,[d]
	sub ecx,12

	;lea eax,d
	;pop eax
	;call bitsExtras

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
	pop ecx
	pop edi
	pop esi
	ret 
	Imagen endp

	bitsExtras proc C, v:dword
	push eax
	push ebx

	mov eax,4
	mov ebx,[v]

	pop ebx
	pop eax
	ret
	bitsExtras endp

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

	;arccos proc C   ;,a:qword
	;fld qword ptr [variable_Y]
	;fmul qword ptr [variable_Y]
  	;fmul qword ptr [valores_acos]
	;fsub qword ptr [valores_acos+8]
	;fmul qword ptr [variable_Y]
	;fld qword ptr [valores_acos+16]
	;fadd
	;ret
	;arccos endp



end