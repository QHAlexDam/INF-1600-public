.data
        factor: .float 2.0 /* use this to multiply by two */

.text

.globl _ZNK9CTriangle7AreaAsmEv

_ZNK9CTriangle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */

        sub $8, %esp                    # espace pour la variable locale p et une variable temporaire
        movl 8(%ebp), %eax              # on met l'objet triangle dans eax


	mov 0(%eax), %ecx               # ecx contient la table virtuelle
	push %eax                       # on met l'objet triangle sur la pile
	call *12(%ecx)                  # on appel la fonction Triangle12PerimeterAsmEv et le perimetre est mis dans st[0]
	add $4, %esp                    # on efface les parametres de Triangle12PerimeterAsmEv           

	

	fld factor                      # on met factor dans st[0] et le perimetre est pousse dans st[1]
	fdivrp                          # on divise le perimetre (st[1]) par factor (st[0]) et le tout est place dans st[0]
	fstp -4(%ebp)                   # on met p dans la mémoire
	

	fld -4(%ebp)                    # on met p dans st[0]
	fld 4(%eax)                     # on met mSides[0] dans st[0] et p est pousse dans st[1]
	fsubrp	                        # on soustrait mSides[0] (st[0]) de p (st[1]) et le resultat est place dans st[0]
        fstp -8(%ebp)                   # on met le resultat a la place de la variable temporaire


	fld -4(%ebp)                    # on met p dans st[0]
	fld 8(%eax)                     # on met mSides[1] dans st[0] et p est pousse dans st[1]
	fsubrp                          # on soustrait mSides[1] (st[0]) de p (st[1]) et le resultat est place dans st[0]
        fld -8(%ebp)                    # on met la variable temporaire dans st[0] et le resultat est pousse dans st[1]
        fmulp                           # on multiplie la variabe temporaire (p - mSides[0])
                                        # avec le resultat trouve precedemment (p - mSides[1]) et le resultat est place dans st[0]
        fstp -8(%ebp)                   # on met le resultat a la place de la variable temporaire


	fld -4(%ebp)                    # on met p dans st[0]
	fld 12(%eax)                    # on met mSides[2] dans st[0] et p est pousse dans st[1]
	fsubrp	                        # on soustrait mSides[2] (st[0]) de p (st[1]) et le resultat est place dans st[0]
        fld -8(%ebp)                    # on met la variable temporaire dans st[0] et le resultat est pousse dans st[1]
        fmulp                           # on multiplie la variabe temporaire ((p - mSides[0])*(p - mSides[1]))
                                        # avec le resultat trouve precedemment (p - mSides[2]) et le resultat est place dans st[0]
        

        fld -4(%ebp)                    # on met p dans st[0] et le resultat precedent est pousse dans st[1]
	fmulp                           # on multiplie p (st[0]) avec le resultat precedent (st[1]) et le nouveau resultat est place dans st[0]

	fsqrt                           # on fait la racine carree le resultat (p*(p - mSides[0])* (p - mSides[1]) * (p - mSides[2])) et la reponse est placee dans st[0]


        leave          /* restore ebp and esp */
        ret            /* return to the caller */
       



