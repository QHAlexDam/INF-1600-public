.global matrix_row_aver_asm

matrix_row_aver_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */
                                #inmatdata    8(%ebp)
			                    #outmatdata   12(%ebp)
			                    #matorder     16(%ebp)

		/* Write your solution here */

        #soit c, l'indice des colonnes et r, l'indice des lignes des matrices
		#soit matorder, l'ordre des matrices a comparer
    
		mov $0, %ecx				
        push %ecx                   #r=0 est mis dans le stack (-4(%ebp))
        push %ecx                   #c=0 est mis dans le stack (-8(%ebp))

#boucle 1, tant que r < matorder
boucle1: 	
		movl -4(%ebp), %eax         #r est mis dans eax
        cmp 16(%ebp), %eax			#condition r < matorder
		jge finBoucle1				#si la condition est fausse, on quitte la boucle

		movl $0, -8(%ebp)    	    #on met c=0 
        movl $0, %ebx               #on met elem=0 dans ebx
		jmp boucle2					#si la condition est vrai, on entre dans la prochaine boucle

#boucle 2, tant que c < matorder
boucle2:
		movl -8(%ebp), %eax         #c est mis dans eax
        cmp 16(%ebp), %eax			#condition c < matorder
		jge incrementationR			#si la condition est fausse, on quitte la boucle2, on incremente r 
		
		#si la condition est vrai on fait la somme
		movl -4(%ebp), %eax			# la valeur de r est mis dans eax pour faire les operations
		imull 16(%ebp), %eax		# r * matorder, resultat stocke dans eax
		addl -8(%ebp), %eax		    # c + (r * matorder), resultat stocke dans eax
        
        movl 8(%ebp), %esi			#inmatdata est mis dans esi
        addl (%esi,%eax,4), %ebx    #on additionne inmatdata[c + (r * matorder)] a elem 
		
		jmp incrementationC			#on incremente

incrementationR:
		movl $0, %edx               #on met edx a 0, car idiv utilise ce registre
        movl %ebx, %eax             #on bouge elem dans eax, car idiv prend automatiquement la dividende dans eax
        movl 16(%ebp), %ebx
        idivl %ebx                  #elem / matorder, le resultat est dans eax, et le reste est dans edx
        movl 12(%ebp), %edx			#outmatdata est mis dans edx
        movl -4(%ebp), %ecx         # r dans ecx
        movl %eax, (%edx,%ecx,4)    #outmatdata[r] = le quotient precedent
        
        incl -4(%ebp)				#incremente r de 1
		jmp boucle1					#on retourne dans la boucle1

incrementationC:
		incl -8(%ebp)				#incremente c de 1
		jmp boucle2					#on retourne dans la boucle2
		
finBoucle1:	
        pop %ecx
        pop %ecx
        leave                       /* Restore ebp and esp */
        ret                         /* Return to the caller */
		
