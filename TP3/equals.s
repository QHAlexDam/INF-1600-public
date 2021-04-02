.globl matrix_equals_asm

matrix_equals_asm:
		push %ebp      /* Save old base pointer */
						#inmatdata1    8(%ebp)
						#inmatdata2   12(%ebp)
						#matorder     16(%ebp)				

		mov %esp, %ebp /* Set ebp to current esp */

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
		
		#si la condition est vrai, on effectue la comparaison entre les 2 matrices
		
		mov %ecx, %eax				# la valeur de r qui est dans ecx est mise dans eax pour faire les operations
		imul %ebx, %eax				# r * matorder, resultat stocke dans eax
		add %edx, %eax				# c + (r * matorder), resultat stocke dans eax
		mov 8(%ebp), %esi			#inmatdata1	est mis dans esi
		mov 12(%ebp), %edi			#inmatdata2 est mis dans edi

		mov (%esi,%eax,4),%esi		#inmatdata1[c + (r * matorder)]  est mis dans %esi
		mov (%edi,%eax,4),%edi		#inmatdata2[c + (r * matorder)]  est mis dans %edi

		

		cmp %esi, %edi				#on compare les 2 matrices
		je incrementationC			#on incremente

		mov $0, %eax				#si ce n'est pas egal, on veut retourner 0 a travers le registre eax
        leave          				/* Restore ebp and esp */
        ret           				 /* Return to the caller */
		

incrementationR:
		incl %ecx					#incremente r de 1
		jmp boucle1					#on retourne dans la boucle1

incrementationC:
		incl %edx					#incremente c de 1
		jmp boucle2					#on retourne dans la boucle2
		
finBoucle1:
		mov $1, %eax				#si on a passe a travers la boucle 1 au complet sans avoir d'inegalites, ca veut dire que les 2 matrices sont egales
        leave          				/* Restore ebp and esp */
        ret           				 /* Return to the caller */

        


        
