.data
	
	i:
        .int 0      #incrementeur pour la boucle for

.global func_s


func_s:	
	    loop:
            mov d, %eax             #d est mis dans eax
            mov e, %ebx             #e est mis dans ebx
            add %ebx, %eax          #ebx+eax, donc d+e, le resultat est dans eax
            mov b, %ebx             #b est mis dans ebx
            sub %ebx, %eax          #eax-b, donc d+e-b, le resultat est dans eax
            mov %eax, a             #la valeur de eax est mis dans a
            jmp if                  #on se rend au if

            if: 
                mov b, %eax         #b est mis dans eax
                sub $1000, %eax     #eax-1000, donc b-1000, est mis dans eax
                mov c, %ebx         #c est mis dans ebx
                add $500, %ebx      #ebx+500, donc c+500, est mis dans ebx
                cmp %ebx, %eax      #eax-ebx, le resultat est mis dans flag
                jae else            #si eax-ebx >= 0, cela veut dire que b-1000 >= c+500, donc on va dans le cas else
                mov c, %eax         #c est mis dans eax
                sub $500, %eax      #eax-500
                mov %eax, c         #la valeur de eax est mis dans c
                jmp if_2            #on se rend dans le if
                
                if_2:
                    mov b, %eax     #b est mis dans eax
                    mov c, %ebx     #c est mis dans ebx
                    cmp %ebx, %eax  #eax-ebx est mis dans le flag
                    jna endif       #si eax-ebx <=0, cela veut dire que b <= c, donc on sort de if_2
                    sub $500, %eax  #eax-500
                    mov %eax, b     #la valeur de eax est mis dans b
                    jmp endif       #on termine le if statement
      
            else:
                mov b, %eax         #b est mis dans eax
                mov e, %ebx         #e est mis dans ebx
                sub %ebx, %eax      #eax-ebx
                mov %eax, b         #la valeur de eax est mis dans b
                mov d, %eax         #d est mis dans eax
                add $500, %eax      #eax+500
                mov %eax, d         #la valeur de eax est mis dans d
                jmp endif           #on termine le if statement

            endif:
                mov i, %esi         #i est mis dans esi
                add $1, %esi        #esi +1
                mov %esi, i         #la valeur de est est mis dans i
                mov $10, %ebx       #la constante 10 est mis dans ebx
                cmp %ebx, %esi      #esi-ebx est mis dans flag
                jnae loop           #si flag est <=0, alors on continue la boucle


	ret
