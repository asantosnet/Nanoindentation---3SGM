function [ nouvelle , ancienne] = CorrectionSmachine( fichierdonee,feuilledonee ,varargin)


% Cette fonction va corriger la valeur expérimentale de la valeur
% Smachine retrouvée (il faut aussi fournir la matrice des rayons A).

% Ancienne est la matrice de S sans la correction et Nouvelle est la
% matrice de S avec la correction.
% CMachine est la constante de correction.
% fichierdonee/feuilledonee sont des string avec le fichier Excel
% et la feuille dans laquelle le fichier a été mis.

% Si on connaît déjà Smachine, il suffit de le mettre (dans l'ordre énoncé)
% comme attribut de la function 

% Si on doit calculer Smachine, fournir le fichier, la feuille de la
% calibration et opt (dans cet ordre, opt doit être le dernier argument).


% Si on veut calculer SMachine on peut donner la valeur de eta, val1, val2 
% soit hc=ht-eta.(p/s) et R = val1.(hc^val2)).

switch nargin
    % Si on a seulement défini Smachine
    case 3
        % Pour vérifier qu'on a bien une valeur double
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
            msgbox('Veuillez redéfinir Smachine. Il se peut qu''il manque des données','Error','error')
        end
    case 4
        % Pour vérifier que le troisième valeur est la matrice
        if isa(varargin{3},'cell')
            % Vérifier si les fichiers existent
            if exist(fichierdonee,'file')
                % Pour savoir quelle position correspond à celle du
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
                msgbox('Le fichier de données n''existe pas.','Error','error')
            end
        else
            msgbox('Veuillez rappeler la fonction avec la matrice en troisième paramètre.','Error','error')
        end
% % % %     % C'est la même chose que pour case 5, la seule chose qui change est qu'ici les valeurs utilisées pour eta, val1 et val12 ne sont pas celles par defaut    
% % % %     case 7
% % % %         %Pour vérifier que la troisième valeur est bien la matrice
% % % %         if isa(varargin{3},'cell')
% % % %             % Vérifier que les fichiers existent
% % % %             if exist(fichierdonee,'file')
% % % %                 % Pour savoir quelle position correspond à celle du
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
% % % %                 msbox('Le fichier de données n''existe pas.','Error','error')
% % % %             end
% % % %         else
% % % %             msgbox('Veuillez rappeler la fonction avec la matrice comme troisième paramètre.','Error','error')
% % % %         end
    otherwise
        msgbox('Manque de données ou trop d''informations.','Error','error')
end 

end
