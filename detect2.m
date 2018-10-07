clear all
close all
load C:/Users/Ingemar/SignalProcessing/logdata_one.txt
s=logdata_one(:,2);
time_s=logdata_one(:,1);
%plot(time_s,s,time_s,s,"+");
new_time=(0:20e-6:5)';
new_s=resampling(time_s,s,new_time);
s_iq=(new_s==0)*j+new_s;


%plot(new_time,real(s_iq),"g",new_time,imag(s_iq)+2,"r")
%plot(start(2:end,1)-start(1:end-1,1))
nolla_iq=[ones(1,48)*(j) zeros(1,2) ones(1,22) zeros(1,2) ones(1,48)*(j)]';
etta_iq=[ones(1,48)*(j) zeros(1,2) ones(1,69) zeros(1,2) ones(1,48)*(j)]';
avbrott_iq=[ones(1,1500)*j]';
%nollconv=real(conv(nolla_iq,s_iq))>105;
%ettconv=real(conv(etta_iq,s_iq))>160;
nollconv=real(conv(nolla_iq, s_iq))>100;
ettconv=real(conv(etta_iq, s_iq))>145;
avbrottconv=(real(conv(avbrott_iq, s_iq))>1498);

nollconv_re=(nollconv(1:end-1)==0)&(nollconv(2:end)==1);
ettconv_re=(ettconv(1:end-1)==0)&(ettconv(2:end)==1);
avbrottconv_re=(avbrottconv(1:end-1)==0)&(avbrottconv(2:end)==1);
nollconv_re=nollconv_re(67:end);
ettconv_re=ettconv_re(116:end);
avbrottconv_re=avbrottconv_re(1499:end);
le=min([length(new_time) length(nollconv_re) length(ettconv_re)  length(avbrottconv_re)])


%find first avbrottconv_re >250ms
avbrottconv_re=avbrottconv_re(1:le)&(time_s(1:le)>0.250);
index_max=min(find(avbrottconv_re))
index_min=max(find(new_time<(new_time(index_max)-0.250)))

ss0=nollconv_re(1:le)*1+ettconv_re(1:le)*2;
ss_re=nollconv_re(1:le)+ettconv_re(1:le);
%reduce data
new_time=new_time(index_min:index_max);
ss0=ss0(index_min:index_max);
ss_re=ss_re(index_min:index_max);
s=s(index_min:index_max);
plot(new_time, ss0, new_time,s, new_time,s,"+")
 
%remove early detections
time_detected=new_time(ss_re==1);
ss0=ss0(ss_re==1)-1;
remove_index=((time_detected(2:end)-time_detected(1:end-1))>0.003);
index_rem=max(find(remove_index))

if ((length(ss0))-index_rem+1)<88
  print "Error"
  stop
else
  %le=min([length(ss0) length(time)]);
  time_s=time_s(index_rem:end);
  ss0=ss0(index_rem:end);
  ss_re=ss_re(index_rem:end);
  s=s(index_rem:end);  
  plot(time_s, ss0, time_s,s, time_s,s,"+")
endif


t1=time_s>1.35&time_s<1.6;
t1=time_s>3&time_s<3.2;
t2=time_s>3.4&time_s<3.63;
sa1=ss0(t1);
sa2=ss0(t2);
figure 1;
plot(sa1)
figure 2;
plot(sa2)
k1=0;
clear se_red1;
for l=1:length(sa1)
  if sa1(l)~=0
    k1++;
    se_red1(k1)=sa1(l)-1;
  endif
 endfor
k1
plot(se_red1)

k2=0;
clear se_red2;
for l=1:length(sa2)
  if sa2(l)~=0
    k2++;
    se_red2(k2)=sa2(l)-1;
  endif
 endfor
k2
plot(se_red2)

B=reshape(se_red1(length(se_red1)-87:end),4,22)';
C=[8 4 2 1];
AB2=dec2hex(B*C')'

B=reshape(se_red2(length(se_red2)-87:end),4,22)';
AB1=dec2hex(B*C')'

% plot(time,(nollconv_re(1:length(time))),"r",time,(ettconv_re(1:length(time))),"b")
