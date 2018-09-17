load C:/Users/Ingemar/SignalProcessing/start.txt
s=start(:,2);plot(s);
 nolla=[zeros(1,50) ones(1,25) zeros(1,50)]';
 etta=[zeros(1,50) ones(1,75) zeros(1,50)]';
 
 nollconv=(conv(s,nolla)>23);plot(nollconv)