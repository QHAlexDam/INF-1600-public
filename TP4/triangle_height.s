.data
        factor: .float 2.0 /* use this to multiply by two */

.text

.globl	_ZNK9CTriangle9HeightAsmEv

_ZNK9CTriangle9HeightAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */

        sub $4, %esp                    # espace pour la variable locale A
        movl 8(%ebp), %eax              # on met l'objet triangle dans eax

        mov 0(%eax), %ecx               # ecx contient la table virtuelle
        push %eax                       # on met l'objet triangle sur la pile
        call *20(%ecx)                  # on appel la fonction Triangle7AreaAsmEv et l'aire est mise dans st[0]
        add $4, %esp                    # on efface les parametres de Triangle7AreaAsmEv


        fld factor                      # on met factor dans st[0] et l'aire est poussee dans st[1]
        fmulp                           # on multiplie l'aire (st[1]) par factor (st[0]) et le tout est place dans st[0]

        fld 12(%eax)                    # on met mSides[2] dans st[0] et le resultat est pousse dans st[1]
        fdivrp                          # on divise le resultat (st[1]) par mSides[2] (st[0]) et le tout est place dans st[0]


        leave          /* restore ebp and esp */
        ret            /* return to the caller */
