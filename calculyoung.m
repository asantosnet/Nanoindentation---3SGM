function [ Emat] = calculyoung( Smat,A,poissonmat,poissonid,youngid)

% Cette fonction vas calculer le module de Young du echantillon a partir de
% la droite corrigé de Smat en fonction de a ( le rayon ) 
% Il faut fournir au moin poissnomat. Si poissonidenteur et
% youngidenteur ne sont pas fournis, on vas utilser les valeurs suivantes :
% 0.3,  400000000000
% Smat est une matrice avec les valeurs de la raideur et A du rayon de
% contact pour la matrice associé au materiau dont on veut calculer le
% Module de Young . poissonmat le poisson de ce materiau
% poissonid et youngid sont correspondants au identeur

%%%%% Le valeur retrouve ici n'est pas vraie ( une chose negative). Il est
%%%%% presque sure qu'il y a un probléme dans la selection des donées ( ou
%%%%% peut être dans le traitement des ces donées) qui sont utilisées pour
%%%%% calculer la pente, donc, les valeurs utilisées par la fonction
%%%%% Polyfit. Voir plus dans le Rapport.

switch nargin
    case 5
        poissonidenteur=poissonid;
        youngidenteur=youngid;
    case 3
        poissonidenteur=0.3;
        youngidenteur=400000000000;
        msgbox('on utilise ici la Saphir comme identeur');
    otherwise
        msgbox('manque dinformation','Error','error')
end


[Smat,A]=remove0(Smat,A);

% on vas utiliser polyfit pour retrouver la pente
[x,~]=size(Smat);

[y,~]=size(A);

% on vas verifier si la taille des deus matrices sont la meme
if x==y
    % on va calculer la pente de la fonction

    c=polyfit(A(:,1),Smat(:,1),1);
    % on a que Smat=2*a*Eff 
    %y = c(1).*A(:,1) + c(2);

    Effmat = c(1)/2;
    
    % Effmat=((max(y ) - min(y))/(max(A(:,1)) - min(A(:,1))))/2;
    
    % on va calculer
    % E=(1-poissonmat^2)*Eid*Eeff/(Eid-Eeff(1-poissonid^2)
    Emat=((1-(poissonmat.^2))*(youngidenteur*Effmat))/(youngidenteur-(Effmat*(1-(poissonidenteur.^2))));

else
    msgbox('il y a un erreur dans la classSmat, classA','Error','error');

end

%%%%%%%% j'avait fait de faiçon qu'elle marche si on envoi une cellule,
%%%%%%%% mais comme je veulais l'utiliser pour une seule matrice, j'ai decidé
%%%%%%%% de la modifier
% % % % avant, on vas enlever les valeurs que sont égales a zero
% % % [celSmat,celA]=remove0(cellSmat,classA);
% % % 
% % % % on vas utiliser polyfit pour retrouver la pente
% % % [x,~]=size(celSmat);
% % % [y,~]=size(celA);
% % % % on vas verifier si la taille des deux cell sont la meme
% % % if x==y
% % %     Emat=zeros(x,1);
% % %     Effmat=zeros(x,1);
% % %     for t=1:x
% % %         [z,~]=size(celSmat{t});
% % %         [w,~]=size(celA{t});
% % %         % on vas verifier que la taille de la matrice est la meme
% % %         if z==w
% % %             % on va calculer la pente de la fonction
% % %             c=polyfit(celSmat{t}(:,1),celA{t}(:,1),1);
% % %             % on a que Smat=2*a*Eff 
% % %             Effmat(t,1)=(c(1)/2);
% % %         else
% % %          msgbox('il y a un erreur dans la matrice '+t+' de classSmat ou classA', classA','Error','error');   
% % %         end
% % %         % on va calculer
% % %         % E=(1-poissonmat^2)*Eid*Eeff/(Eid-Eeff(1-poissonid^2)
% % %         Emat(t,1)=((1-poissonmat^2)*youngidenteur*Effmat(t,1))/(youngidenteur-(Effmat(t,1)*(1-poissonidenteur^2)));
% % %     end
% % %     % on fait la moyenne de tous ces valeurs
% % %     E=nanmean(Emat);
% % % else
% % %     msgbox('il y a un erreur dans la classSmat, classA','Error','error');
% % % 
% % % end


end

function [Smat,A]=remove0(Smat,A)
% cette function vas enlever les 0 des chaque matrice associé a chaque
% classe. le matrices doivent être n lgines et 1 colonne pour que sa
% simplifie l'algorithime.

poszero=find(Smat==0);
b=0;
for j=1:size(poszero)
    % on va enlever les 0
    Smat(poszero(j)-b,:)=[];
    A(poszero(j)-b,:)=[];
    b=b+1;
    
end

poszeroA=find(A==0);
b=0;
for j=1:size(poszeroA)
        A(poszeroA(j)-b,:)=[];
        Smat(poszeroA(j)-b,:)=[];
        b=b+1;
end

% % % % % [x,~]=size(cellSmat);
% % % % % for k=1:x
% % % % %     % on va retrouver les 0
% % % % %     poszero=find(cellSmat{k}==0);
% % % % %     b=0;
% % % % %     for j=1:size(poszero)
% % % % %         % on va enlever les 0
% % % % %         cellSmat{k}(poszero(j)-b,:)=[];
% % % % %         b=b+1;
% % % % %     end
% % % % % end
% % % % % 
% % % % % [y,~]=size(cellA);
% % % % % for f=1:y
% % % % %     poszero=find(cellA{f}==0);
% % % % %     b=0;
% % % % %     for j=1:size(poszero)
% % % % %             cellA{f}(poszero(j)-b,:)=[];
% % % % %             b=b+1;
% % % % %     end
% % % % % end


end
