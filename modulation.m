% length no modulation
%ls=s(time>2.4864&time<2.6795);
%A=zeros(1,100);
%dd=0;
%for l=2:length(ls)
%  if ((ls(l-1)==1)&&(ls(l)==0))||((ls(l-1)==0)&&(ls(l)==0))
%    dd++;
%  elseif ((ls(l-1)==0)&&(ls(l)==1))
%    A(1,dd)++;
%    dd=0;
%  endif
%endfor
%plot(A)  

% length modulation
%ls=s(time>2.4860&time<2.6802);
%A=zeros(1,100);
%dd=0;
%for l=2:length(ls)
%  if ((ls(l-1)==0)&&(ls(l)==1))||((ls(l-1)==1)&&(ls(l)==1))
%    dd++;
%  elseif ((ls(l-1)==1)&&(ls(l)==0))
%    A(1,dd)++;
%    dd=0;
%  endif
%endfor
%plot(A)  

% sampling
dt=time(2:end)-time(1:end-1);
hist(dt,10000)
min(dt)
max(dt)