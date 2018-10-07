%t=[2.4 4.4 5.1 7.2 8.4 11];
%x=[0 1 1 0 1 0];
%tny=1:0.5:10;
%stairs(t,x)

function xny = resampling (t,x,tny)
indny=1;
ind=2;
while t(ind)<tny(indny)
  ind++;
endwhile

while ind<=length(t)
  while (t(ind)>tny(indny))&&(indny<length(tny))
    xny(indny)=x(ind-1);
    indny++;
  endwhile
  ind++;
endwhile

while indny<=length(tny)
  xny(indny)=x(ind-1);
  indny++;
endwhile
xny=xny';

%figure 1;
%plot(tny,xny,'-*')
%hold
%figure 1;
%stairs(t,x)