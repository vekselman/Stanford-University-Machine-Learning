%!octave 
%
%      
%       OS : GNU/Linux 3.9.3-1-ARCH 
% COMPILER : GNU Octave, version 3.8.0
%
%   AUTHOR : Evgeny S. Borisov
%
%  Glushkov Institute of Cybernetics
%  National Academy of Sciences of Ukraine
% 
%    http://www.mechanoid.kiev.ua
%  e-mail : nn@mechanoid.kiev.ua
% 
% $Id: build_tree.m,v 1.3 2014/05/07 11:44:29 mechanoid Exp mechanoid $

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
function  retval=build_tree(X,Y,n),
   % найти наилучшую разделяющую гиперплоскость по признаку f
   [f b]=serch_opt_div(X,Y);

   %разделяем данные на две части относительно найденной гиперплоскости
   S=separate_data(X,Y,f,b) ;

   %повторяем процедуру рекурсивно для обоих подмножеств
   l=build_subtree(S{1},n+1);
   r=build_subtree(S{2},n+1+size(l,1));

   % номер признака, порог, номера узлов - поддеревьев
   nodes=[ f b n+2 n+2+size(l,1) ] ;

   retval=[nodes; l; r ] ;
   
endfunction  

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
function retval=build_subtree(S,n),
   X=S{1}; Y=S{2};

   if isempty(X), retval=[-1 -1 0 0 ]; return; endif

   sum_y=sum(Y,1);

   if min(sum_y) < 1, 
	  % подмножество содержит объекты только одного класса
	  c=find(Y(1,:));
	  % создаём лист 
	  retval=[ 0 c 0 0 ] ; 
	  return;
   endif

   % рекурсивно делим подмножество на две части
   retval=build_tree(X,Y,n) ;

endfunction  

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
% найти оптимальную разделяющую гиперплоскость по признаку f
function  retval=serch_opt_div_feature(X,Y,f,st),
   mnf=min(X(:,f));
   mxf=max(X(:,f));
   % количество объектов разных классов 
   sy=sum(Y) ;

   R=[];
   % двигаем гиперплоскость по признаку f с шагом st
   for b=linspace(mnf,mxf,st),
	  % на каждом шаге оцениваем КАЧЕСТВО РАЗДЕЛЕНИЯ 
	  % номера всех объектов по признаку f превышающих порог b  
	  xf=X(:,f)-b; xf=xf+abs(xf) ; ii=find(xf) ;
	  % количество объектов разных классов в полученном подмножестве
	  sc=sum(Y(ii,:)) ;

	  ii=information(sy,sc)(1,1) ;
      R=[ R ; b ii ] ;
   endfor

   [v i]=max(R(:,2)) ;
   retval=R(i,:);
endfunction  

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
% найти разделяющую гиперплоскость 
function  [f b]=serch_opt_div(X,Y),
   % количество свойств объекта
   szf=size(X,2) ;

   % количество шагов сдвига гиперплоскости
   st=10;

   D=[];
   for f=1:szf,
	  % найти наилучшую разделяющую гиперплоскость по признаку f
	  r=serch_opt_div_feature(X,Y,f,st);
	  D=[D ; r] ;
   endfor

   % выбираем наилучший признак 
   [v f]=max(D(:,end));
   % порог для признака f
   b=D(f,1) ;
endfunction  

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
function retval=separate_data(X,Y,f,b),
   %разделяем данные на две части
   %относительно найденной гиперплоскости
   xf=X(:,f)-b ;
   xf=xf+abs(xf) ;
   ix1=find(xf) ;
   ix2=setdiff( (1:size(X,1)) , ix1) ;

   % первое подмножество
   X1=X(ix1,:);
   Y1=Y(ix1,:);

   % второе подмножество
   X2=X(ix2,:);
   Y2=Y(ix2,:);

   retval={ {X1,Y1}, {X2,Y2} };
endfunction  


