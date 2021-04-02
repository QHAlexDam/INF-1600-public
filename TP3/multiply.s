.globl matrix_multiply_asm

matrix_multiply_asm:
                push %ebp      /* save old base pointer */
                mov %esp, %ebp /* set ebp to current esp */
                                #inmatdata1   8(%ebp)
			        #inmatdata2   12(%ebp)
			        #outmatdata   16(%ebp)
                                #matorder     20(%ebp)
        
        /* Write your solution here */

                #soit c, l'indice des colonnes et r, l'indice des lignes des matrices
		#soit matorder, l'ordre des matrices a comparer
        
		mov $0, %ecx				#0, mis dans %ecx
                push %ecx                               #on met r=0 dans le stack (-4(%ebp))
                push %ecx                               #on met c=0 dans le stack (-8(%ebp))
                push %ecx                               #on met i=0 dans le stack (-12(%ebp))

#boucle 1, tant que r < matorder
boucle1: 	
		movl -4(%ebp), %eax                     #on met r dans eax
                movl 20(%ebp), %ebx	                #on met matorder dans ebx
                cmp %ebx, %eax		                #condition r < matorder
		jge finBoucle1				#si la condition est fausse, on quitte la boucle

                movl $0, -8(%ebp)    			#on met c=0 
		jmp boucle2				#si la condition est vrai, on entre dans la prochaine boucle

#boucle 2, tant que c < matorder
boucle2:
		movl -8(%ebp), %eax                     #on met c dans eax
                movl 20(%ebp), %ebx	                #on met matorder dans ebx
                cmp %ebx, %eax			        #condition c < matorder
		jge incrementationR			#si la condition est fausse, on quitte la boucle2, on incremente r 
		
		#si la condition est vrai, on va a la boucle3
                movl $0, -12(%ebp)                      #on met i =0 
                movl $0, %edx                           #on met elem = 0 dans edx
                jmp boucle3

boucle3:
                movl -12(%ebp), %eax                    #on met i dans eax
                movl 20(%ebp), %ebx	                #on met matorder dans ebx
                cmp %ebx, %eax			        #condition i < matorder
		jge incrementationC			#si la condition est fausse, on quitte la boucle3, on incremente c 
                
                movl -4(%ebp), %eax			# la valeur de r est mise dans eax pour faire les operations
		imul 20(%ebp), %eax			# r * matorder, resultat stocke dans eax
		addl -12(%ebp), %eax			# i + (r * matorder), resultat stocke dans eax
        
                movl 8(%ebp), %esi			#inmatdata1 est mis dans esi
		movl (%esi,%eax,4),%esi		        #inmatdata1[i + (r * matorder)]  est mis dans %esi

                movl -12(%ebp), %eax			# la valeur de i est mise dans eax pour faire les operations
		imul 20(%ebp), %eax			# i * matorder, resultat stocke dans eax
		addl -8(%ebp), %eax			# c + (i * matorder), resultat stocke dans eax

                movl 12(%ebp), %edi			#inmatdata2 est mis dans edi
                movl (%edi,%eax,4), %edi                #inmatdata2[c + (i * matorder)]  est mis dans %edi

                imul %esi, %edi                         #mutiplication, resultat dans edi

                addl %edi, %edx                         #elem += le resultat de la multiplication

                jmp incrementationI


incrementationR:
                incl -4(%ebp)				#incremente r de 1
		jmp boucle1				#on retourne dans la boucle1

incrementationC:

                movl -4(%ebp), %eax			# la valeur de r est mise dans eax pour faire les operations
		imul 20(%ebp), %eax			# r * matorder, resultat stocke dans eax
		addl -8(%ebp), %eax			# c + (r * matorder), resultat stocke dans eax

                movl 16(%ebp), %ecx			#outmatdata est mis dans ecx
                movl %edx, (%ecx,%eax,4)                #elem est mis dans outmatdata[c + (r * matorder)]

                incl -8(%ebp)				#incremente c de 1
		jmp boucle2				#on retourne dans la boucle2

incrementationI:
                incl -12(%ebp)				#incremente i de 1
		jmp boucle3				#on retourne dans la boucle2
		
finBoucle1:	
                pop %eax                                #on pop pour r, c et i qu'on a push au debut
                pop %eax
                pop %eax
                leave          			        /* Restore ebp and esp */
                ret            			        /* Return to the caller */

