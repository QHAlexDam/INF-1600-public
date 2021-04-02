.global matrix_diagonal_asm

matrix_diagonal_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */
                                #inmatdata    8(%ebp)
			                    #outmatdata   12(%ebp)
			                    #matorder     16(%ebp)	

		/* Write your solution here */


		#soit c, l'indice des colonnes et r, l'indice des lignes des matrices
		#soit matorder, l'ordre des matrices a comparer
        
		mov 16(%ebp), %ebx	#on met matorder dans ebx
		mov $0, %ecx				#r=0, mis dans %ecx

#boucle 1, tant que r < matorder
boucle1: 	
		cmp %ebx, %ecx				#condition r < matorder
		jge finBoucle1				#si la condition est fausse, on quitte la boucle

		mov $0, %edx    			#on met c=0 dans edx
		jmp boucle2					#si la condition est vrai, on entre dans la prochaine boucle

#boucle 2, tant que c < matorder
boucle2:
		cmp %ebx, %edx				#condition c < matorder
		jge incrementationR			#si la condition est fausse, on quitte la boucle2, on incremente r 
		
		#si la condition est vrai, on regarde si on est sur la diagonale
		cmp %edx, %ecx              # on regarde si r=c
        je diagonale

		mov %ecx, %eax				# la valeur de r qui est dans ecx est mise dans eax pour faire les operations
		imul %ebx, %eax				# r * matorder, resultat stocke dans eax
		add %edx, %eax				# c + (r * matorder), resultat stocke dans eax
        
        mov 12(%ebp), %edi			#outmatdata est mis dans edi
        movl $0, (%edi,%eax,4)      #si on n'est pas sur la diagonale, on veut que ca soit 0
		
		jmp incrementationC			#on incremente

		
diagonale:
        mov %ecx, %eax				# la valeur de r qui est dans ecx est mise dans eax pour faire les operations
		imul %ebx, %eax				# r * matorder, resultat stocke dans eax
		add %edx, %eax				# c + (r * matorder), resultat stocke dans eax

        mov 8(%ebp), %esi			#inmatdata est mis dans esi
		mov (%esi,%eax,4),%esi		#inmatdata[c + (r * matorder)]  est mis dans %esi
        
        mov 12(%ebp), %edi			#outmatdata est mis dans edi
        mov %esi, (%edi,%eax,4)     #inmatdata[c + (r * matorder)] est mis dans outmatdata[r + (c * matorder)]

        jmp incrementationC         #on incremente

incrementationR:
		incl %ecx					#incremente r de 1
		jmp boucle1					#on retourne dans la boucle1

incrementationC:
		incl %edx					#incremente c de 1
		jmp boucle2					#on retourne dans la boucle2
		
finBoucle1:	
        leave          			/* Restore ebp and esp */
        ret            			/* Return to the caller */

