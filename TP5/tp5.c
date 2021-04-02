
#include <stdio.h>

unsigned int Decryption_fct(unsigned int le)
{
	unsigned int be;

	/*
	 * Remplacez le code suivant par de l'assembleur en ligne
	 * en utilisant le moins d'instructions possible
	 */
	 //be = (le & 0xff000000) | (le&0xff) << 16  | (le & 0xff00) | (le & 0xff0000) >> 16;
	 
	

	asm volatile (
		/*
		en inline assembly
		%0 represente la premiere variable passe en sortie/entree
		%1 represente la deuxieme

		Dans notre cas, %0 = be 
						%1 = le
		*/
		// instructions:
		"rol $8, %1;"		//on rotate left le de 8 bit, c'est le decryptage
							// eeaa bbff ---> aabb ffee
		"bswap %1;"			//on byteswap le, c'est une fonction qui peut convertir bigEndian <==> litteEndian
							// aabb ffee ---> eeff bbaa
		"movl %1, %0;"		//le est mis dans be pour la sortie

		: "=r"(be) // sorties (s'il y a lieu)
		: "r"(le) // entrées
		: // registres modifiés (s'il y a lieu, dans notre cas, aucun)
	);

	return be;
}

int main()
{
	unsigned int data = 0xeeaabbff;

	printf("Représentation crypte en little-endian:   %08x\n"
	       "Représentation decrypte en big-endian:    %08x\n",
	       data,
	       Decryption_fct(data));

	return 0;
}
