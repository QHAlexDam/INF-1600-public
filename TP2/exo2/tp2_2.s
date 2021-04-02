.global func_s

func_s:
    # on veut effectuer lequation suivante en assembleur: a = ((g-e)/f)*(((b*d)-c)/(f-g))+e)
    #soit:
    #resultat1 = (g-e)/f
    #resultat2 = (b*d)-c
    #resultat3 = ((b*d)-c)/(f-g))+e



	#(g-e)/f

	flds e      #e est mis dans st[0]
    flds g      #g est mis dans st[0] et e est pousse dans st[1]
    fsubp       #st[0]-st[1] donc g-e, est mis dans st[0]
    flds f      #f est mis dans st[0] et le resultat de la soustraction est pousse dans st[1]
    fdivrp      #st[1]/st[0] donc (g-e)/f, definissons cette valeur comme resultat1, est dans st[0]
    
    #(b*d)-c
    
    flds b      #b est mis dans st[0] et resultat1 est pousse dans s[1]
    flds d      #d est mis dans st[0], b est pousse dans st[1] et resultat1 est pousse dans s[2]
    fmulp       #st[0]*st[1], soit b*d, est mis dans st[0], et resultat1 revient dans st[1]
    flds c      #c est mis dans st[0], le produit est dans st[1] et resultat1 est pousse dans st[2]
    fsubrp      #st[1]-st[0], donc (b*d)-c, est mis dans st[0], resultat1 revient dans st[1]

    #((b*d)-c)/(f-g))+e
    flds f      #f est mis dans st[0], resultat2 est pousse dans st[1] et resultat1 est pousse dans st[2]
    flds g      #g est mis dans st[0], f est pousse dans st[1], resultat2 est pousse dans st[2] et resultat1 est pousse dans st[3]
    fsubrp      #st[1]-st[0], donc f-g, est place dans st[0], resultat2 revient dans st[1] et resultat1 revient dans st[2]
    fdivrp      #st[1]/st[0], donc (b*d)-c)/(f-g), est mis dans st[0] et resultat1 revient dans st[1]
    flds e      #e est mis dans st[0], le quotient dernier est pousse dans st[1] et resultat1 est pousse dans st[2]
    faddp       #st[0]+st[1], donc e est additionne au quotient, soit resultat3 est mis dans st[0] et resultat1 revient dans st[1]

    #((g-e)/f)*(((b*d)-c)/(f-g))+e)
    fmulp       #st[0]*st[1], soit resultat1*resultat3, est mis dans st[0]

    #Finalisation, retour de la reponse dans a
    fstps a     # retourne s[0] a l'adrresse a
    

	ret         #retour
