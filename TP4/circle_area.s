.globl _ZNK7CCircle7AreaAsmEv

_ZNK7CCircle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
		#l'objet actuel (Cercle) est dans l'adresse 8(%ebp)
		#l'attribut unique de Cercle, radius, est a l'adresse 4(8(%ebp))
	
		movl 8(%ebp), %eax				#on met l'objet cercle dans eax
		fld 4(%eax)						#on met l'attribut radius de cercle sur la pile flotante dans st[0]
		fld 4(%eax)						#on met l'attribut radius de cercle sur la pile flotante, radius est maintenant dans st[0] et st[1]
		fmulp							#radius * radius, la valeur est dans st[0] et st[1]
		fldpi							#on met la valeur de PI sur la pile flotante dans st[0] et le produit est dans st[1]
		fmulp							# PI * radius * radius, le resultat est dans st[0] et st[1]
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
