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
% $Id: plot_data.m,v 1.3 2014/05/03 09:38:22 mechanoid Exp $

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
function retval = plot_data(X,Y,tree,file),
% pix_size="-S1024,1024";
   pix_size="-S640,640";
   pix_font_size=10;
   pix_format="gif";

   xm=ceil(max(max(X))) ; ax=[ 0 xm 0 xm ] ;

   szX=size(X,1) ;

   clf; hold on; axis(ax); grid on; set(gca,'fontsize',pix_font_size); 
   
   vb=[ min(X(:,1)) min(X(:,2)) ; 
		max(X(:,1)) max(X(:,2)) ];
   plot_lines(tree,1,vb);

   plot_points(X,Y);

   nodes=size(tree,1)
   lf=find(tree(:,1)<1);
   leafs=size(lf,1)
   title(sprintf('nodes:%i, leafs:%i',nodes,leafs));

   file=sprintf("result/%s.%s",file,pix_format); fm=sprintf("-d%s",pix_format);
   print(file,fm,pix_size) ;

   retval = 0 ;
endfunction

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
function retval=plot_lines(tree,n,vb),
   f=tree(n,1);
   b=tree(n,2);

   if f<1, 
      pos=[ min(vb(:,1)) min(vb(:,2)) abs(vb(1,1)-vb(2,1)) abs(vb(1,2)-vb(2,2))  ] ;
	  if b>1, clr="yellow"; else clr="green"; endif
	  % clr=[ 0 0 0 ] ; clr(3-b)=0.7; 
	  rectangle("position", pos ,"facecolor", clr);
	  return; 
   endif

   l=tree(n,3);
   r=tree(n,4);

   if f==1, 
      plot([b b],vb(:,2),'-r') ; 
	  vbl=vb; vbl(1,1)=b ;
	  vbr=vb; vbr(2,1)=b ;
   else 
	  plot(vb(:,1),[b b],'-r') ; 
	  vbl=vb; vbl(1,2)=b ;
	  vbr=vb; vbr(2,2)=b ;
   endif



   plot_lines(tree,l,vbl);
   plot_lines(tree,r,vbr);

   retval = 0 ;
endfunction
 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
function retval=plot_points(X,Y),
   sz=size(Y,2) ;
   % clr=jet(sz) ;
   clr=[ 
	 0 0 1 ;
     1 0 0 ;
	 0 1 0 ;
	 1 0 1 ;       
	 1 1 0 ;
	 0 1 1 
   ] ;

   for c=1:sz,
      % класс с
	  ii=find(Y(:,c));
	  plot( X(ii,1), X(ii,2), '.', 'color', clr(c,:) ) ; 
   endfor;

   retval=0 ;

endfunction

