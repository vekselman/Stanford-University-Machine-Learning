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
% $Id: load_data.m,v 1.2 2014/05/03 09:38:22 mechanoid Exp $


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
function [X Y]=load_data(),

   points={} ; cl={} ;

%     points(1)=load("data/800_2b/points_1.txt") ;
%     points(2)=load("data/800_2b/points_2.txt") ;
%     cl(1)=[ points{1} ] ;
%     cl(2)=[ points{2} ] ;

    points(1)=load("data/399_4/points_r.txt") ;
    points(2)=load("data/399_4/points_g.txt") ;
    points(3)=load("data/399_4/points_b.txt") ;
    points(4)=load("data/399_4/points_y.txt") ;
    cl(1)=[ points{1} ; points{2} ; points{3} ] ;
    cl(2)=[ points{4} ] ;
   
   % - - - - - - - - - - - - - - - 


   X=[] ;  Y=[] ;
   % количество классов
   sz=size(cl,2);
   % строим ответы Y для X
   for i=1:sz, 
      % точки класса i
      xi=cl{i};
	  X=[ X ; xi ] ; 
      % количество точек класса i
      szi=size(xi,1);
	  z=zeros(szi,sz) ;
	  z(:,i)=1;
	  Y=[Y;z];
   endfor

endfunction

