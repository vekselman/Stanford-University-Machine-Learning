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
% $Id: main.m,v 1.3 2014/05/02 20:29:39 mechanoid Exp $


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%  загрузить данные
[X Y]=load_data() ;

T=build_tree(X,Y,0)
save("-ascii","tree.txt", "T" ) ;


%plot_data(X,Y,T,"res") ;

