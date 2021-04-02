.data
        factor: .float 2.0 /* use this to multiply by two */

.text
.globl _ZNK7CCircle12PerimeterAsmEv

_ZNK7CCircle12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */

		#l'objet actuel (Cercle) est dans l'adresse 8(%ebp)
		#l'attribut unique de Cercle, radius, est a l'adresse 4(8(%ebp))
		
		movl 8(%ebp), %eax					# on met l'objet cercle dans eax
		fldpi							# on met la valeur de PI sur la pile flotante dans st[0]
		fld 4(%eax)						# on met l'attribut radius de cercle sur la pile flotante dans st[0], PI est pousse dans st[1]
		fmulp							# PI * radius, la valeur est dans st[0] et st[1]
		fld factor						# on met la valeur de 2.0 sur la pile flotante, dans st[0], le produit dernier est dans st[1]
		fmulp							# PI * radius * 2.0, le resultat est dans st[0] et st[1]
		

        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
