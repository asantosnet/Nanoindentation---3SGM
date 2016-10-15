function [frases  ] = langueselectionersamt2( langue )

if langue == 1
    % cette cellule va contenir le string, la taille doit être la même que
    % la qtt de string
    
    frases=cell(12,1);
    frases{1} = ' Veuillez vérifier si la valeur de Smachine est correcte';
    frases{2} = 'Veuillez patienter';
    frases{3} = 'Annuler';
    frases{8} = 'Rayon de Contact (m)';
    frases{7} = 'Raideur (N/m)';
    frases{10} = 'Raideur en fonction du rayon de contact';
    frases{11} = 'Aide';
    frases{12} = 'Oui';
    

else if langue == 2
    % cette cellule va contenir le string, la taille doit être la même que
    % la qtt de string
    frases=cell(12,1);
    frases{1} = 'Please verify if the value of Smachine is Correct';
    frases{2}= 'Please wait...';
    frases{3} = 'Cancel';
    frases{8}= 'Contact Radius (m)';
    frases{7}= ' Stifness (N/m)';
    frases{10}= 'Stifness as a function of the contact radius';
    frases{11}  ='Help';
    frases{12} = 'Yes';
    
    end
end

end

