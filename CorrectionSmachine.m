function [ nouvelle , ancienne] = CorrectionSmachine( fichierdonee,feuilledonee ,varargin)


% Cette fonction va corriger la valeur exp�rimentale de la valeur
% Smachine retrouv�e (il faut aussi fournir la matrice des rayons A).

% Ancienne est la matrice de S sans la correction et Nouvelle est la
% matrice de S avec la correction.
% CMachine est la constante de correction.
% fichierdonee/feuilledonee sont des string avec le fichier Excel
% et la feuille dans laquelle le fichier a �t� mis.

% Si on conna�t d�j� Smachine, il suffit de le mettre (dans l'ordre �nonc�)
% comme attribut de la function 

% Si on doit calculer Smachine, fournir le fichier, la feuille de la
% calibration et opt (dans cet ordre, opt doit �tre le dernier argument).


% Si on veut calculer SMachine on peut donner la valeur de eta, val1, val2 
% soit hc=ht-eta.(p/s) et R = val1.(hc^val2)).

switch nargin
    % Si on a seulement d�fini Smachine
    case 3
        % Pour v�rifier qu'on a bien une valeur double
        if isa(varargin{1},'double')
             ancienne = numread(fichierdonee,feuilledonee);
             nouvelle = ancienne;
             [x]= size(ancienne);
             CMachine=varargin{1};
             % Il faut qu'on utilise les valeurs du rayon.
             for k=1:x
                nouvelle(k,4)= ((CMachine)*ancienne(k,4))/(CMachine-ancienne(k,4));   
             end
        else
            msgbox('Veuillez red�finir Smachine. Il se peut qu''il manque des donn�es','Error','error')
        end
    case 4
        % Pour v�rifier que le troisi�me valeur est la matrice
        if isa(varargin{3},'cell')
            % V�rifier si les fichiers existent
            if exist(fichierdonee,'file')
                % Pour savoir quelle position correspond � celle du
                % fichier et celle de la feuille
                if exist(varargin{1}{1},'file')
                        ancienne = numread(fichierdonee,feuilledonee);
                        nouvelle = ancienne;
                        CMachine = TrouverSMACHINE(varargin{1},varargin{2},varargin{3});
                        [x]= size(ancienne);
                        for k=1:x
                                nouvelle(k,4)= ((CMachine)*ancienne(k,4))/(CMachine-ancienne(k,4)); 
                        end
                else if exist(varargin{2}{1},'file')
                        ancienne = numread(fichierdonee,feuilledonee);
                        nouvelle = ancienne;
                        CMachine = TrouverSMACHINE(varargin{2},varargin{1},varargin{3});
                        [x]= size(ancienne);
                         for k=1:x
                                nouvelle(k,4)= ((CMachine)*ancienne(k,4))/(CMachine-ancienne(k,4));
                        end
                    else
                        msgbox('Le fichier de calibration n''existe pas.','Error','error')
                    end  
                end
            else
                msgbox('Le fichier de donn�es n''existe pas.','Error','error')
            end
        else
            msgbox('Veuillez rappeler la fonction avec la matrice en troisi�me param�tre.','Error','error')
        end
% % % %     % C'est la m�me chose que pour case 5, la seule chose qui change est qu'ici les valeurs utilis�es pour eta, val1 et val12 ne sont pas celles par defaut    
% % % %     case 7
% % % %         %Pour v�rifier que la troisi�me valeur est bien la matrice
% % % %         if isa(varargin{3},'cell')
% % % %             % V�rifier que les fichiers existent
% % % %             if exist(fichierdonee,'file')
% % % %                 % Pour savoir quelle position correspond � celle du
% % % %                 % fichier et celle de la feuille
% % % %                 if exist(varargin{1}{1},'file')
% % % %                         ancienne = numread(fichierdonee,feuilledonee);
% % % %                         nouvelle = ancienne;
% % % %                         CMachine= TrouverSMACHINE(varargin{1},varargin{2},varargin{3},varargin{4},varargin{5},varargin{6}); 
% % % %                         [x]= size(ancienne);
% % % %                         for k=1:x
% % % %                                 nouvelle(k,4)= ((CMachine)*ancienne(k,4))/(CMachine-ancienne(k,4)); 
% % % %                         end
% % % %                 else if exist(varargin{2}{1},'file')
% % % %                         ancienne = numread(fichierdonee,feuilledonee);
% % % %                         nouvelle = ancienne;
% % % %                         CMachine= TrouverSMACHINE(varargin{1},varargin{2},varargin{3},varargin{4},varargin{5},varargin{6}); 
% % % %                         [x]= size(ancienne);
% % % %                          for k=1:x
% % % %                                 nouvelle(k,4)= ((CMachine)*ancienne(k,4))/(CMachine-ancienne(k,4)); 
% % % %                         end
% % % %                     else
% % % %                         msgobx('Le fichier de calibration n''existe pas.','Error','error')
% % % %                     end  
% % % %                 end
% % % %             else
% % % %                 msbox('Le fichier de donn�es n''existe pas.','Error','error')
% % % %             end
% % % %         else
% % % %             msgbox('Veuillez rappeler la fonction avec la matrice comme troisi�me param�tre.','Error','error')
% % % %         end
    otherwise
        msgbox('Manque de donn�es ou trop d''informations.','Error','error')
end 

end
