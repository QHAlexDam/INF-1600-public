.globl _ZNK9CTriangle12PerimeterAsmEv

_ZNK9CTriangle12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */

        movl 8(%ebp), %eax              # on met l'objet triangle dans eax

        fld 4(%eax)                     # on met mSides[0] sur la pile flottante dans st[0]
        fld 8(%eax)                     # on met mSides[1] sur la pile flottante dans st[0], mSides[0] est poussé dans st[1]
        faddp                           # on ajoute mSides[1] (st[0]) à mSides[0] (st[1]), le résultat est stocké dans st[1] et st[0] est sorti
        fld 12(%eax)                    # on met mSides[2] sur la pile flottante dans st[0], le resultat est poussé dans st[1]
        faddp                           # on ajoute mSides[2] (st[0]) au resultat (st[1]), le nouveau résultat est stocké dans st[1] et st[0] est sorti
        

        leave          /* restore ebp and esp */
        ret            /* return to the caller */
