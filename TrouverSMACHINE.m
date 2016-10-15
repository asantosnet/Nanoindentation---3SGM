function [langue,SMachine] = TrouverSMACHINE( langue,fichier,feuille,opt1,eta,val1,val2,fichiernom)

% cette fonction vas retrouver le valeur CMachine 
%.On aurra dans fichier une cellule n linges 1 colonne, chaque
% position un lien(donc n liens). Pour feuille on a cell of cell. C'esta dir, pour la cell{1} on vas retrouver 
% une cell avec plusieurs liens(toujours une cell avec n lignes et 1 colonne) qui font reference aux fichier placé dans
% la pos 1 de la cell fichier.
% opt est  une matrice 2x2[ poissonmachine,poisonechantillon;younglachine,youngechantillon]. 
% si vous voulez utiliser le materiaux de la machine comme aluminum et du
% echantillon comme Slicium il n'est pas nesscesaire de definir une matrice
% opt
% eta vaut, par defaut 0.75, val1 370.91 et val2 0.15509
% fichiernom va nous donner seulement le nom du fichier pendant que fichier
% donne le lien+nom.


switch nargin
    % Si les deux variable sont definis
    case 8
       % on vas recuperer les donées
       B=Recupererdonees(fichier, feuille);
       % B=numread(fichier,feuille); 
       % materiauxsample est une cell avec les informations atrice 2x2[poissonmachine,poisonechantillon;younglachine,youngechantillon]
        materiauxsample=opt1;
    % Si'il ne nous fournissent pas les opt ni les valeurs d'eta, val1 et val2    
    case 4
        %B=numread(fichier,feuille);
        B=Recupererdonees(fichier, feuille);
        materiauxsample= [0.3,0.17;400000000000,74000000000];
        eta=0.75;
        val1= 370.91;
        val2=0.15509;
     % Si'il ne nous fournissent pas les valeurs d'eta, val1 et val2     
    case 5
        %B=numread(fichier,feuille);
        B=Recupererdonees(fichier, feuille);
        materiauxsample=opt1;
        eta=0.75;
        val1= 370.91;
        val2=0.15509;
        
    % s'il manque de variables    
    otherwise
      msgbox('You have not declared enough variables / Vous n''avez pas déclaré suffisamment de variables','Error','error');
        
end
    % Maintenet, on vas tout lire et deduir une matrice avec plusieurs
    % valeurs de CMachie, associée à chaque fichier.
    [x,~]=size(B);
    
    %indique dans quelle fenetre on est
    
    posfenetre = 0;
    
    % la cellule où on va mettre les rayons de contact
    A=cell(x,1);
    %CMachinematrice=zeros(x,1);
    Effective = zeros(4,1);
    for k=1:x 
        [y,~]=size(B{k});
        %CMachineint=zeros(y,1);
        Aint=cell(y,1);
        % on va calculer Effect
        Effective=(1/((1-materiauxsample(1,1)^2)/materiauxsample(2,1)+(1-materiauxsample(1,2)^2)/materiauxsample(2,2)));
        for j=1:y 
            Aint{j}=calculerayon(eta,val1,val2,B{k}{j});
            %CMachineint(j,1)=CalculSmachine(B{k}{j},materiauxsample{k},eta,val1,val2);
        end      
        %CMachinematrice(k,1)=nanmean(CMachineint);
        A{k}=Aint;
    end
    % on appele la fonction où l'utilisateur va selectioner Smachine
    while posfenetre == 0
    
    [langue,CMachine,~] =selectionersamt(langue,A,B,Effective,fichiernom,feuille);
    
    %%%%% on va calculer un valeur plus précis.
    %%%%% Le resultat que j'ai obtenu avec lui est bizzare, j'ai na pas eu le temps
    %%%%% de le corriger
    %%%%% retrouverSmachineprecis(A{1}{1},CMachine,Effective{1},B{1}{1},0.02,50,30)
    
    % On va demander la confirmation de l'usuaire, il faut qu'il verifie
    % qui si on fait une moyenne avec tous les Smachines fournis on obtient
    % une bonne approximation
    [langue,posfenetre]= selectionersamt2(langue,mean(CMachine),A,B,Effective);
    
    end
    
    SMachine = mean(CMachine);
    
    
    
end

function [B] = Recupererdonees(fichier,feuille)
% dans cette fonction on va recuperer les donnes aossicées a n fichier et x feuilles.    

% on va determiner combien de fichiers on a
[xi,~]=size(fichier);
% B sera un Cell de Cell, la pos 1 on aurra une cell avec les
% matrices liées aux feuilles du fichier qui etait dans la pos 1 du
% cell fichier.
B=cell(xi,1);
for k=1:xi     
    % on va recuperer chaque donné associé aux liens dans cette
    % ficheir
    % on va supprimer les 0 dans la matrice feuille
     feuille2 = feuille{k}(~cellfun('isempty',feuille{k}));
     % on va determiner combien de feuilles associées a ce fichier
     [xe,~]=size(feuille2);
     Binte=cell(xe,1);
    % on va recuperer chaque donné associé aux liens dans cette
    % ficheir 
    for j=1:xe
        Binte{j}=numread(fichier{k},feuille2{j});     
        if j==1
            h = waitbar(j/xe,'Loading files / Chargement de fichiers'); 
        end
        waitbar(j/xe);
    end
    close(h);
    % on vas mettre tous ces informations dans la cellule B et dans
    % la pos k
    B{k}=Binte;
end
end

% Cette fonction ne devait pas avoir marché, mais, en appliquent cette
% correction j'ai trouvé un linge en utilisant le fait que le Smat doit
% suivre la loi a.Eff( donc lineaire), je n'a pas pu vérifier si le valeur de
% la pente etait correct, je doit le faire encore. Le probléme est que je
% supposé que le Smachine est lineaire, ce qui n'est pas vraie car le systéme "responsable
% pour le Smachine est considére comme un ressort, donc le Smachine serait 
% comme le K d'un ressort, donc une constante, de plus, j'ai fait
% un erreur de singe, j'ai un moin à la place d'un plus, ou l'inverse, il
% faut que je regarde, de tout faiçon, je lesse ce code pour le moment pour
% verifier aprés l'histoire du plus et du  moins
% % % % function [Smachine] = CalculSmachine ( B, materiauxsample,eta,val1,val2)
% % % % On vas calculer ici le CHmachine, dans ce cas, le B est une matrice et
% % % % materiauxsample est aussi une matrice.
% % % % 
% % % % on fait le calcul de a pour chaque valeur de S et de force apliqué
% % % % 
% % % % A=calculerayon(eta,val1,val2,B);
% % % % 
% % % % le calcule du Smat qu'on doit avor, Smat= 2.a.Eeffective
% % % % Effective=(1/((1-materiauxsample(1,1)^2)/materiauxsample(2,1)+(1-materiauxsample(1,2)^2)/materiauxsample(2,2)));
% % % % Smat=2*(1/((1-materiauxsample(1,1)^2)/materiauxsample(2,1)+(1-materiauxsample(1,2)^2)/materiauxsample(2,2))).*A(:,1);
% % % % 
% % % % cette partie sert à selectioner un valeur de Smachine que peut
% % % % s'approximer à qu'est qu'on veut
% % % % 
% % % % 
% % % % 
% % % % 
% % % % on va utiliser polyfit, sur un intervalle selectioné, pour qu'on puisse
% % % % retrouver le bonne Smachine qui doit faire de sort que 1/Stot=1/Smach + 1
% % % % /Smat 
% % % % 
% % % % ça ne marche pas jusqu'à la ligne 133
% % % % on va calculer la correction C pour chaque point du graphiqueC
% % % % Smachine= a.CMachine soit a le deplacement 
% % % % [x,~]=size(A);
% % % % MatriceCmachine=zeros(x,1);
% % % % for k=1:x
% % % %    if A(k,1)~=0
% % % %        MatriceCmachine(k,1)=(Smat(k,1)*B(k,4)/(A(k,1)*(B(k,4)-Smat(k,1))));
% % % %    end
% % % % end
% % % % 
% % % % MatriceSmachine=(Smat.*B(:,4)./(A(:,1).*(B(:,4)+Smat)));
% % % % 
% % % % on veut enlever les valeurs nulles
% % % % 
% % % % poszero=find(MatriceCmachine==0);
% % % % b=0;
% % % % 
% % % % for j=1:size(poszero)
% % % %        MatriceCmachine(poszero(j)-b,:)=[];
% % % %        b=b+1;  
% % % % end
% % % % on va faire une moyenne avec les valeurs obtenus pour qu'on soit plus
% % % % précis
% % % % 
% % % % 
% % % % CMachine=mean(MatriceCmachine);
% % % % end
