function  Main
% Cette fonction coordonne les fen�tre et fonctions qui effectuent le calcul.

% Obs : je n'ai pas utilis�e des variables Global pour �viter d'avoir le
% risque d'apperler une autre variable avec le m�me nom.

posfigure = 1 ; % Pour commencer avec la figure initiale

langue  = 1; % Fran�ais par d�faut

while posfigure == 2 || posfigure == 1|| posfigure == 3
    % posfigure = 2 indique l'affichage de l'�chantillon corrig�
    % posfigure = 1 indique l'affichage des choix des fichiers excel et des diff�rents param�tres
    % posfigure = 3 Indique la situation dans la derni�re fen�tre et donc
    % l'affichage de la courbe de la duret� H en fonction du ratio R/a
    switch posfigure
        case  1
            % Fournit les valeurs de fichier, feuille, mat�riaux, etc ...
            % Obs:Avec la position du mat indenteur et la position du
            % materiaux calibration on peut recuperer les informations dans
            % la matrice materiaux.
            % FichierEcahntillon seuelement le nom du fichier et
            % FichierEchantilloncomplet, le nom plus lien, je pourra avoir
            % renvoy� seulement FichierEchantilloncomplet, mais, en
            % renvoyent le deux je ne suis pas oblig� � traiter la string
            % pour obtenier le nom tout seule.
            [langue,eta,val1,val2,posfigure,fichierCalibration,fichierCalibrationcomplet,...
                    feuillesCalibration,fichierEchantillon,fichierEchantilloncomplet,...*
                    feuillesEchantillon,posmatidenteur,posmatcalibration,materiaux,Smachine] = Objet_Graphique(langue);

            if Smachine == 0
                % Matrice avec les donn�es du mat�riau 
                % [poissonmachine,poissonechantillon;younglachine,youngechantillon]
                opt1 = [materiaux{posmatidenteur}{3},materiaux{posmatcalibration}{3};materiaux{posmatidenteur}{2},materiaux{posmatcalibration}{2}];

                % On va retrouver Smachine , l'interface aidant
                % � la selection du Smachine est aussi ici.
                [langue,Smachine] = TrouverSMACHINE( langue,fichierCalibrationcomplet,feuillesCalibration,opt1,eta,val1,val2,fichierCalibration);

                % Dans le cas o� l'utilisateur a decid� de changer la langue
                [titre] = langueMain( langue );

                % On va appliquer la correction dans le Biolox

                [taillefich,~] = size(fichierEchantilloncomplet);

                % nouvelle est la matrice avec les valeurs de S corrig�e,
                % ancienne est la matrice originale
                nouvelle = cell(taillefich,1);
                ancienne = cell(taillefich,1);

                for k=1:taillefich
                    [taillefeuill,~] = size(feuillesEchantillon{k});
                    nouvelleinter = cell(taillefeuill,1);
                    ancienneinter = cell(taillefeuill,1);
                    for j = 1:taillefeuill
                        % Affiche une barre de chargement
                        if j==1
                            h = waitbar(j/taillefeuill,titre{1}); 
                        else
                            waitbar(j/taillefeuill);
                        end
                        % Pour appliquer la correction
                        [nouvelleinter{j} , ancienneinter{j}] = CorrectionSmachine( fichierEchantilloncomplet{k},feuillesEchantillon{k}{j} ,Smachine);
                    end
                    nouvelle{k} = nouvelleinter;
                    ancienne{k} = ancienneinter;
                    close(h);
                end
                % On va montrer � l'utilisateur le resultat obtenu

            else
                [titre] = langueMain( langue );
                % On va appliquer la correction dans le Biolox, il n'est
                % plus n�cessaire de recalculer Smachine

                [taillefich,~] = size(fichierEchantilloncomplet);

                % nouvelle est la matrice avec les valeurs de S corrig�e,
                % ancienne est celle originale
                nouvelle = cell(taillefich,1);
                ancienne = cell(taillefich,1);

                for k=1:taillefich
                    [taillefeuill,~] = size(feuillesEchantillon{k});
                    nouvelleinter = cell(taillefeuill,1);
                    ancienneinter = cell(taillefeuill,1);
                    for j = 1:taillefeuill
                        % Affiche une barre de chargement
                        if j==1
                            d = waitbar(j/taillefeuill,titre{1}); 
                        else
                            waitbar(j/taillefeuill);
                        end
                        % pour appliquer la correction
                        [nouvelleinter{j} , ancienneinter{j}] = CorrectionSmachine( fichierEchantilloncomplet{k},feuillesEchantillon{k}{j} ,Smachine);
                    end
                    nouvelle{k} = nouvelleinter;
                    ancienne{k} = ancienneinter;
                    close(d);
                end
            end

            % on va calculer A pour le biolox
            
            % la cellule o� on va mettre les rayons de contact

            A=cell(taillefich,1);
            for k=1:taillefich
                [y,~]=size(nouvelle{k});
                Aint=cell(y,1);
                for j=1:y 
                    % on va calculer le A
                    Aint{j}=calculerayon(eta,val1,val2,nouvelle{k}{j});
                end      
                A{k}=Aint;
            end

        case 2
            
            %%%%%% J'ai n'a pas eu le temps de le faire
            %%%%%% Je veulais mettre ici une question box avec deux option,
            %%%%%% la premier oui, pour calculer rayon petit, le
            %%%%%% deuxi�me non. Si oui on va faire apparaitre une autre
            %%%%%% box o� il doit remplir le valuer itnervalle entre chaque
            %%%%%% droite ou la quantit� de droites. E apr�s on va aficher
            %%%%%% un graphique avec le valeur corrig� pour un feuille.
            %%%%%% S'il est d'accord avec qu'est qu'on a fait, on peut
            %%%%%% faire pour tous les autres feuilles, fichiers. Il sert a
            %%%%%% rien de faire tout ce calcul si le utilisateur va dire
            %%%%%% que le resultat ne lui plait pas.
            %%%%%% On peut aussi faire de sort qu'il puisse enregistrer les
            %%%%%% differents pentes et constantes pour qu'il puisse avoir
            %%%%%% acees � ces courbes sans avoir la besoin d'utiliser ce
            %%%%%% logicielle.
            
            
            
            % Cette interface permet � l'utilisateur de faire le calcul de
            % Young et de v�rifier la courbe obtenue pour l'�chantillon
            
            [langue,posfigure,moduleYoung,Bdecalee,Asanszeros,Bnouvauxsanszeros] =interfsmachineech(A,nouvelle,ancienne,fichierEchantillon,feuillesEchantillon,langue,materiaux{posmatidenteur}{3},materiaux{posmatidenteur}{2});

        case 3 
            
            % calcul de la moyenne des valeurs d'young
            [tailleMY,~] = size(moduleYoung);
            MYmoyenne = cell(tailleMY,1);
            
            for k=1:tailleMY
                
                % Transforme ce qui nous interesse dans une
                % matrice avec les valeurs de young, on garde dans
                % moduleYoung la valeur sous forme de String
                [tailleMYK,~] = size(moduleYoung{k});
                matriceYoung = zeros(tailleMYK,1);
                
                for j=1:tailleMYK
                    
                    % Cette valeur �tant un string on la transforme en double
                    matriceYoung(j,1) = str2num(moduleYoung{k}{j}); %#ok<ST2NM>
                    
                end
                % On r�alise la moyenne (1 pour que �a soit la colonne)
                
                Young = mean(matriceYoung,1);
                MYmoyenne{k} = num2str(Young);
                
            end
             % Cette interface va montrer la courbe H=f(a/r) et la moyenne des valeurs d'Young  
             [langue,posfigure,~,~]  = derinterface (Asanszeros,Bnouvauxsanszeros,ancienne,fichierEchantillon,feuillesEchantillon,langue,val1,val2,eta,MYmoyenne,Bdecalee);
        otherwise
    end
    

end
end


