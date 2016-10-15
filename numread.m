function [NUM2] = numread ( filename, feuillename)

%Cette fonction sert � traiter les donn�es venant du fichier excel pour
%pouvoir les utiliser plus tard. Elle renvoie une matrice NUM � 4 colonnes
%dont les valeurs aberrantes ont �t� retir�es.

switch nargin
    case 2
        if exist(filename,'file')
            [~, feuilles] = xlsfinfo(filename);
            
            if  ismember(feuillename,feuilles) == 1;
                [NUM1,~,~]=xlsread(filename,feuillename);
            else
                message = strcat( feuillename,' not found / pas trouv�');
                warndlg(message);
                NUM1  = zeros(1,4);
            end
        end
    otherwise
        message = strcat( filename,' not found / pas trouv�');
        warndlg(message);
end
%On veut seulement les quatre premi�res colonnes num�riques

[x,~]=size(NUM1);
NUM2=ones(x,4);

%On remplit la matrice NUM2

for k=1:4
    for j=1:x
        NUM2(j,k)=NUM1(j,k);
    end
end

for k=1:4
    for j=1:x
        if(NUM2(j,k)==NUM1(j,k))
        else
            msgbox('af')
        end
        
    end
end

%Maintenant on aimerait bien supprimer les valeurs aberrantes : dans le
%document, on trouve des valeurs n�gatives dont on ne veut pas ainsi que
%des valeurs extr�mement �lev�es dont ne veut pas non plus.

% on va sauvegarder tous les valeurs nulles qui sont dans le fichier

posnull1= find(NUM2==0);

%Chasse aux valeurs n�gatives et aux trop grandes valeurs.

NUM2(NUM2<0)=0;

% Les valeurs n�gatives prennent la valeur 0

NUM2(NUM2>10e+10)=0;

% Les valeurs trop �lev�es  prennent la valeur 0

% pour supprimer enti�rement les donn�es li�es aux valeurs >10e+10 ou
% n�gatives

% on va retrouver les indices des valeurs qui sont 0
poszero=find(NUM2==0);

% on va s'int�resser seulement aux valeurs 0 qui sont li�es aux valeurs 
% negatives ou >10e+10 

d=size(poszero)-size(posnull1);

for j=1:d
    for z=1:size(posnull1)
        if(posnull1(z)==poszero(j))
            poszero(j)=[];
        end
    end
end

% quand on enl�ve une ligne, 90 par ex, la ligne 91 devient 90 donc il faut
% enlever le nombre maximal de lignes pour une valeur
b=0;

for j=1:size(poszero)
        if( poszero(j)-x < 0)
            NUM2(poszero(j)-b,:)=[];
            b=b+1;
        else if ( poszero(j)-4*x < 0 && poszero(j)-3*x > 0)
            NUM2((poszero(j)-3*x)-b,:)=[];
            b=b+1;
            end
        end
end
    
end

