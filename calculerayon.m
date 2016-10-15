function [A] = calculerayon(eta,val1,val2,varargin)

% Cette fonction va calculer le rayon de contacte a a pour tous les valeurs de la matrice B fourni.
% Elle vas prendre en compte la
% correction du Rayon de la sphére.
% Il faut fournir les valeurs pour faire la correction de R = val1.(hc^val2)) et le valeur
% Il faut préciser le eta utilisé (0.72 si cone, 0.75 si sphére)
% Soit hc=ht-eta.(p/s)
% Dans varargin il faut metre soit la matrice avec les donées
% experimentales, soit l'adresse dans l'ordre suivant, fichier et feuille, pour la
% recuperer.

switch nargin
    case 4
        B=varargin{1};
    case 5
        if exist(varargin{1},'file')
            B=numread(varargin{1},varargin{2});
        else
            msgbox('ladresse fourni est faux','Error','error')
        end
    otherwise
        msgbox('manque dinformation','Error','error')
end

 
% On vas retrouver ici le valeur de hc pour tous les valeurs utilisées, on
% veut Hc en metres

Hc=((B(:,1)*(10^-9))-(eta.*((B(:,2)*(10^-3))./B(:,4))));

% on vas calculer ici le Re corrigé pour tous les valeurs utilisées, par
% contre, cette formule valable seulemnet si HC plus grande que 300 nm
[x,~]=size(Hc);

Re=zeros(x,1);
A=zeros(x,1);

% On vas pas calculer Re si Hc<300. Dans ce cas il va renvoier 0.La même
% chose pour A
for k=1:x
    if Hc(k,1)>(300*(10^-9))
        Re(k,1)=val1*(Hc(k,1)^val2)*(10^-6);
        
        A(k,1)=(Re(k,1)*Hc(k,1)*2)^(1/2);
        
        %A(k,1)=((2*Hc(k,1)*Re(k,1)-(Hc(k,1)^2))^(1/2)); une autre formule
    end
end

end
