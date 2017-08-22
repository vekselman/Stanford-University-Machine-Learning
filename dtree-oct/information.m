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
% $Id: information.m,v 1.1 2014/05/01 12:38:10 mechanoid Exp $


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% информативность
function retval=information(P,pp),
   % исключаем из обработки признаки не выделяющие ни одного объекта
   spp=sum(pp) ; zi=find(spp==0) ; pp(:,zi)=1 ;
   I=information_entrop(P,pp) ;
   % обнуляем информативность признаков не выделяющих ни одного объекта
   I(:,zi)=0 ;

   retval=I ;
endfunction


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
% энтропийная информативность для одного класса
%
% P - число объектов в классах (1 x k)
% pp - число выделенных объектов в классах для каждого признака (k x n)
%
function retval=information_entrop(P,pp),
   P=P' ;
   N=sum(P)-P ;
   % исходная энтропия
   p1=h(P,N) ;
   % энтропия после выделения объектов бинарными признаками
   p2=h1(P,pp) ;
	
   retval=(p1-p2) ;
endfunction


% энтропия на выборках из P-позитивных (условно) и N-негативных элементов
function retval=h(P,N),
   % всего элементов
   S=P+N ;
   % нормированные позитивные наборы
   q0=P./S ;
   % нормированные негативные (дополняющие P) наборы
   q1=N./S ;
   
   i=find(q0) ;
   q0(i)=-q0(i).*log2(q0(i)) ;
   
   i=find(q1) ;
   q1(i)=-q1(i).*log2(q1(i)) ;
   
   retval=(q0+q1) ; 
endfunction


% энтропия на выборках из P-позитивных (условно) и N-негативных элементов
% после получения дополнительной информации
function retval=h1(P,pp),
   % всего элементов
   sP=sum(P) ;
   % выделенные элементы для каждого признака
   spp=sum(pp) ;
   
   N=sP-P ; 
   % количество элементов, выделенных признаком, не принадлежащих данному классу, для каждого класса
   nn=spp-pp ;

   p1=spp./sP .* h(pp,nn) ;
   p2=(sP-spp)./sP .* h(P-pp,N-nn) ;

   retval=(p1+p2) ;

endfunction





