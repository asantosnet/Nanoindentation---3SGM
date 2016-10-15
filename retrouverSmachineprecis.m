function [ Smachine] = retrouverSmachineprecis( A,Smachineestime,Effective,Stotale,precision,n,erreurusuaire)
% Cette fonction va rechercher avec une plus grande précision le Smachine
% On utilisera ce SMachine pour tracer les plot pour les autre graphes pour
% verifier qu'on a une bonne aproximation
% A est une matrice avec les rayons de contact
% Smachineestime le valeur que l'utilisateur à donné pour Smachine
% Effective
% Stotale les valeurs pour S qui q éte fourni pour la calibration
% la presicision est la presicion qu'on veut avoir
% le n le numero des fois qu'on vas faire la boucle for
% erreurusuaire est l'erreur due au choix de Smachine en utilisant les
% curbes.

% on va essayer d'utiliser une polyfit pour s'approximer le plus d'une
% droite de pente 2*Effective


% On definit ici certains variables qui seront utilisées aprés

%%%%%% Le resultat obtenu avec cette function m'a semble bizzare,
%%%%%% j'ai n'a pas eu le temps de la corriger.

erreurusuaireavant = 0;

verbasouhaut = 0;

smachineintermediairepos = Smachineestime;


[a,~]=size(Stotale);

% retrouver le premier valeur non nulle
pospremierval = find(A,1,'first');



% pour calculer la matrice Smat avec la correction 
Smat=(Stotale(pospremierval:a,1).*smachineintermediairepos)./(smachineintermediairepos-Stotale(pospremierval:a,1));

% le polynome de premier degrées associé à la Smat en fonction de a
polynome =  polyfit(A(pospremierval:a,1),Smat(:,1),1);

% on va comparer ici la pente du polynome, donc polynome(1) avec le valeur
% de Effective et diviser par Effective pour retrouver la percentage
% d'erreur
erreurintermidiaire = (polynome(1)/2 - Effective)/Effective;

% dans le cas où la precision n'etait pas atteint
if abs(erreurintermidiaire)>abs(precision)
a=0;

    for k=1:n
        
        if k==1
            h = waitbar(k/n,''); 
        else
            waitbar(k/n);
        end
        
        switch  verbasouhaut
            
            case 0
                
                % on va calculer pour , si eurreusuaire est 0.2 par ex, les
                 % pour un valeur ( Smachine +-0.3Smachine)
                smachineintermediairepos = Smachineestime + Smachineestime*(erreurusuaire + (0.1*a));
                smachineintermediaireneg = Smachineestime - Smachineestime*(erreurusuaire + (0.1*a));
                
                % on va recalculer Smat
                Smat=(Stotale(pospremierval:a,1).*smachineintermediairepos)./(smachineintermediairepos-Stotale(pospremierval:a,1));
                polynome = polyfit(A(pospremierval:a,1),Smat,1);
                
                % on fait le calcul de l'erreur
                erreurintermidiairepos = (polynome(1)/2 - Effective)/Effective;
                
                % on fait le calcul de Smat pour le negative
                Smat=(Stotale(pospremierval:a,1).*smachineintermediaireneg)./(smachineintermediaireneg-Stotale(pospremierval:a,1));
                polynome = polyfit(A(pospremierval:a,1),Smat,1);
                
                % on fait le calcul de l'erreu pour le negative
                erreurintermidiaireneg = (polynome(1)/2 - Effective)/Effective;
                
                if erreurintermidiairepos < precision
                   Smachine = smachineintermediairepos;
                   waitbar(n);
                   break 
                else
                    % on va voir si on a eu une variation de signe , si
                    % oui, dans ce cas il faut qu'on suive le chemin 0.2
                    if erreurintermidiairepos * erreurintermidiaire < 0
                        
                        % On definit un max, car la variation est entre 0.2
                        % et 0
                        erreurusuairemax = erreurusuaire + (0.1*a);
                        
                        verbasouhaut = 1;
                     % la meme chose qu'avant mais pour 0.2
                    elseif erreurintermidiaireneg * erreurintermidiaire < 0
                        erreurusuairemax = erreurusuaire + (0.1*a);

                        verbasouhaut = 2;
                    else
                        % dans le cas ou elle est plus grande que 0.2
                        a=a + 1;
                        % car si on n'est pas bon en 0.2 mais oui en 0.3 on
                        % sait qu'on est compris entre 0.2 et -1.7
                        erreurusuaireavant = erreurusuaire + (0.1*(a-1));
                        % pour savoir si on n'a pas depasé 100%
                        t=a*0.1 + erreurusuaire;
                        if t>1
                            waitbar(n);
                            warndlg('probleme dans retrouverSmachineprecis');
                            break 
                        end
                    end
                end
            case 1 
                
                % pour savoir qu'elle percentage il faut prendre en compte
                % ex : 0.2  bon, donc a = 0, donc erreuavant = 0  alors on
                % aurra 0.1, si celle si est pas bon on aurra aprés 0.15 ,
                % si non, on aurra 0.05 ...
                % 
                erreurusuaire2 =erreurusuaireavant + (-erreurusuaireavant + erreurusuairemax)/2;
                
                smachineintermediairepos = Smachineestime + Smachineestime*erreurusuaire2;
                
                Smat=(Stotale(pospremierval:a,1).*smachineintermediairepos)./(smachineintermediairepos-Stotale(pospremierval:a,1));
                polynome = polyfit(A(pospremierval:a,1),Smat,1);
                
                erreurintermidiaireneg = (polynome(1)/2 - Effective)/Effective;
                
                
                if erreurintermidiaireneg < precision
                   Smachine = smachineintermediairepos;
                   waitbar(n);
                   break % ça va comme ça?
                else
                    % car s'il est bon, il faut que on aye (0.2 - 0.1)/2 +
                    % 0.1
                    % Si on suppose que entre 0.15 et 0.2 il n'est pas bon,
                    % on doit essayer 0.125. alors ça marche car on va
                    % avoir - 0.1(voir else aprés) + ( 0.15-0.1)/2
                    if erreurintermidiaireneg * erreurintermidiaire < 0
                   
                        erreurusuaireavant = erreurusuaire2; 
                
                    else
                        % car s'il est pas bon il faut qu'on aye 0.1/2
                        erreurusuairemax = erreurusuaire2;
                        if erreurusuaire2 <0
                            verbasouhaut = 2;
                        end
                    end
                end
                
                % la même chose qu'avant, mais ça change rien, car on
                % serait en train d'enlever de valeur et pas augmanter.
                
            case 2
                erreurusuaire2 =erreurusuaireavant + (-erreurusuaireavant + erreurusuairemax)/2;
                
                smachineintermediairepos = Smachineestime - Smachineestime*erreurusuaire2;
                
                Smat=(Stotale(pospremierval:a,1).*smachineintermediairepos)./(smachineintermediairepos-Stotale(pospremierval:a,1));
                polynome = polyfit(A(pospremierval:a,1),Smat,1);
                
                erreurintermidiairepos = (polynome(1)/2 - Effective)/Effective;
                
                
                if erreurintermidiairepos < precision
                   Smachine = smachineintermediairepos;
                   waitbar(n);
                   break % ça va comme ça?
                else
                    if erreurintermidiairepos * erreurintermidiaire < 0
                   
                        erreurusuaireavant = erreurusuaire2; 
                
                    else
                        erreurusuairemax = erreurusuaire2;
                        if erreurusuaire2 <0
                            verbasouhaut = 2;
                        end
                    end
                end
                
        end
        
        if k==1
            h = waitbar(k/n,''); 
        else
            waitbar(k/n);
        end
    end
    close(h);
    
end
