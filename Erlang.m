%channel number 1~20 %
erlang =zeros();
i=1;
j=1;
for br=[0.01,0.03,0.05,0.1]             %blocking rate
    for ch_num=1:20                     %number of channel
        erlang(i,j)=erlangB(ch_num,br);
        i=i+1;
    end
    j=j+1;
    i=1;
end

%save as ,xls
xlsoutput="traficload_1to20";
data= {'m', '1.0%', '3.0%', '5.0%', '10%' };
xlswrite(xlsoutput,erlang);

%plot 
%figure(1-1)
figure(1);
hold on
plot(1:20, erlang(:, 1), 'k:O')
plot(1:20, erlang(:, 2), 'r:d')
plot(1:20, erlang(:, 3), 'g:X')
plot(1:20, erlang(:, 4), '*')
xlabel('Channel Number')
ylabel('Traffic Load')
legend('1%', '3%', '5%', '10%')
hold off;

%channel number 200~220 %
erlang1=zeros();
i=1;
j=1;
for br=[0.01,0.03,0.05,0.1]             %blocking rate
     for  ch_num=200:220                %number of channel
         erlang1(i,j)=erlangB(ch_num,br);
       i=i+1;        
     end
  j=j+1;
  i=1;
end

%save as .xls
xlsoutput="trafficload_200to220.xls";
data = {'m', '1.0%', '3.0%', '5.0%', '10%' };
xlswrite(xlsoutput,erlang1);

%plot
%figure(1-2)
figure(2);
hold on
plot(200:220, erlang1(:, 1), 'k:O')
plot(200:220, erlang1(:, 2), 'r:d')
plot(200:220, erlang1(:, 3), 'g:X')
plot(200:220, erlang1(:, 4), '*')
xlabel('Channel Number')
ylabel('Traffic Load')
legend('1%', '3%', '5%', '10%')
hold off;

%Blocking Probability%
bp=zeros();
i=1;
j=1;
for m=[1,5,10,20]
    for gc=0:0.1:1.5
        bp(i,j)=blockrate(gc*m,m);
        i=i+1;
    end
    j = j+1;
    i = 1;
end

%save as .xls
xlsFile = 'problem2_blockrate.xls';
xlswrite(xlsFile, bp);

figure(3);
hold on
plot(0:0.1:1.5, bp(:, 1), 'r:O')
plot(0:0.1:1.5, bp(:, 2), 'k:d')
plot(0:0.1:1.5, bp(:, 3), 'b:X')
plot(0:0.1:1.5, bp(:, 4), '*')
set(gca,'Yscale','log');
xlabel('Offered Traffic Per Channel gc (Erlangs)')
ylabel('Blocking Probability')
legend('m = 1', 'm = 5', 'm = 10', 'm = 20')
hold off;


erlang3=zeros();
i=1;
j=1;
for br=[0.01,0.03,0.05,0.1]             %blocking rate
     for  ch_num=[40,60,120]            %number of channel
         erlang3(i,j)=erlangB(ch_num,br);
       i=i+1;        
     end
  j=j+1;
  i=1;
end

%save as.xls
xlsoutput="problem_3_traffic_load.xls";
data = {'m', '1.0%', '3.0%', '5.0%', '10%' };
xlswrite(xlsoutput,erlang3);

%plot
%figure
figure();
hold on
plot([40,60,120], erlang3(:, 1), 'k:O')
plot([40,60,120], erlang3(:, 2), 'r:d')
plot([40,60,120], erlang3(:, 3), 'g:X')
plot([40,60,120], erlang3(:, 4), '*')
xlabel('Channel Number')
ylabel('Traffic Load')
legend('1%', '3%', '5%', '10%')
hold off;


load_p3_2 = zeros(3, 4);
load_p3_2(1, :) = 3*erlang3(1, :);
load_p3_2(2, :) = 2*erlang3(2, :);
load_p3_2(3, :) = 1*erlang3(3, :);

xlsFile = 'trafficload_p3_2.xls';
xlswrite(xlsFile, load_p3_2);

%%% erlangB function%%%
function load_totoal=erlangB(m,br)
    p_up=500;
    p_l=0.0;
    p_mid=(p_up+p_l)/2;        
    temp=blockrate(p_mid,m);
    
    while(p_up-p_l>0.0001)     
      
            if(temp>br)
                p_up=p_mid;
            else
                p_l=p_mid;
            end
             p_mid=(p_up+p_l)/2;
             temp=blockrate(p_mid,m);

    end
   load_totoal=p_mid;           
end

%%%brakerate function%%%
% blocking rate
function B=blockrate(p,m)       
    B=1;                       
    for k=1:m
       B=((p*B)/k)/(1+p*B/k); 
    end
end