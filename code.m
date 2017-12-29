
clc;
b=1;
ctr=1;
l=0;

count=0;
thr=[0,0,0,0,0,0];
poly=[1,0,1,1];
   
    m=input('enter the total  of frame');
    n=input('enter the window sizes');
   % p=input('enter error probality');
  n1=14;
   t=7;
         p=[0.001,0.005,0.01,0.05,0.08,0.15];
    fprintf('\n');
    
for qw=1:1:6
        ctr=1;
        count=0;
        l=0;
    for i=1:1:m
        d=randi([0,1],1,t);
        
        msg=[d,zeros(1,t)];
        [q r]=deconv(msg,poly);
        r=abs(r);
    for j1=1:length(r)
    a=r(j1);
    if ( mod(a,2)== 0 )
        r(j1)=0;
    else
        r(j1)=1;
    end;
    end;
   j(i,1:n1) = bitor(msg,r);    
   
    end; 
    %disp(j)
    
    
    
    while(l<1000)
      if(l==1000)
          break;
      end;
        if(ctr>m)
            break;
        end;
        for i=1:1:n
            if ctr<=m
            a(i,1:n1)=j(ctr,1:n1);
           % fprintf('\nframe %d sent\n',ctr);
           count=count+1;
            ctr=ctr+1;
            l=l+1;
            else
                if(ctr<=200)
                  ctr=ctr-i;
                q=ctr;
               for i=q:1:m-1
                   
                   a1(i,1:n1)=j(ctr,1:n1);
                   ctr=ctr+1;
            %       fprintf('\nframe %d acknowledged ',ctr);
                  l=l+1;
               end;
               ctr=450;
              % fprintf('f=\n')
               %disp(f)
              thr(qw) =count/m;
               fprintf(' for p=%4.3f throughput=%4.3f\n',p(qw),thr(qw));
             end;
            end;  
               
          
        end;
       if ctr<=m+1
          data=bsc(a,p(qw));
  
       end;
     
       if(ctr>m+5)
           break;
       end;
     wl=n;
       f=zeros(1,n);
       
       i=1;
        while(i<=n)
           
            [q1,r1]=deconv(data(i,1:n1),poly);
            r1=abs(r1);
                for i1=1:length(r1)
                    b=r1(i1);
                    if ( mod(b,2)== 0 )
                        r1(i1)=0;
                    else
                        r1(i1)=1;
                    end;
                end;
            
            for i2=1:n1
                if(r1(i2)==1)
                   f(i)=1;
                end;
            end;
            if f(i)==1
                e=ctr-wl;
              %fprintf('\nError in transmission of frame %d\n',e);
              %fprintf('Retransmitting from frame %d onwards',e);
              
                %fprintf('f=\n');
               %disp(f);
             break; 
            else
            %fprintf('\n frame %d acknowledged',ctr-wl); 
            if(ctr-wl==m)
                if(thr(qw)==0.00)
                    thr(qw)=1.00;
                end;
               fprintf(' p=%4.3f throughput=%4.2f\n',p(qw),thr(qw));
            end;
            wl=wl-1;
            end;
    
          i=i+1;
          l=l+1;
        end;   
        ctr=ctr-wl;
        wl=n;
  
     l=l+1;
      end;
    end;
 


ctr1=1;
l1=0;
poly1=[1,0,1,1];
gpol=[1,0,0,0,0,0,0,1];
thr1=[0,0,0,0,0,0];
count1=0;
n11=14  ;
 t1=7;
  t11=4;
 parmat = cyclgen(n11,gpol);
 trt = syndtable(parmat);
   % m=input('enter the total  of frame');
   % n=input('enter the window sizes');
   %p=input('enter error probality');
 p1=[0.001,0.005,0.01,0.05,0.08,0.12];
    fprintf('\n');
    for qw1=1:1:6
        ctr1=1;
        count1=0;
        l1=0;
    for i=1:1:m
        d=randi([0,1],1,t11);
       % disp(d)
        msg=[d,zeros(1,t11-1)];
        [q r]=deconv(msg,poly1);
        r=abs(r);
    for j1=1:length(r)
    a=r(j1);
    if ( mod(a,2)== 0 )
        r(j1)=0;
    else
        r(j1)=1;
    end;
    end;
    d1=bitor(msg,r);
    
   % disp(d1)
   j11(i,1:n11) = encode(d1,n11,t1,'cyclic/binary',gpol);    
   
    end; 
  % disp(j)
    
   
    
    while(l1<1000)
      if(l1==1000)
          break;
      end;
        if(ctr1>m)
            break;
        end;
        for i=1:1:n
            if ctr1<=m
            a(i,1:n11)=j11(ctr1,1:n11);
        %   fprintf('\nframe %d sent\n',ctr1);
           count1=count1+1;
            ctr1=ctr1+1;
            l1=l1+1;
            else
                if(ctr1<=200)
                  ctr1=ctr1-i;
                q=ctr1;
               for i=q:1:m-1
                   
                   a1(i,1:n11)=j11(ctr1,1:n11);
                   ctr1=ctr1+1;
             %   fprintf('\nframe %d acknowledged ',ctr1);
                  l1=l1+1;
               end;
               ctr1=450;
              % fprintf('f=\n')
               %disp(f)
               thr1(qw1)=count1/m;
              fprintf(' \nfor p=%4.3f throughput=%4.3f\n',p1(qw1),count1/m);
             end;
            end;  
         end;
       if ctr1<=m+1
               data=bsc(a,p1(qw1));
             end;
     %        disp(data)
   %  data(1:end,10:n1)=a(1:end,10:n1);
    
            
     
       if(ctr1>m+5)
           break;
       end;
     wl=n;
       f=zeros(1,n);
       
       i=1;
        while(i<=n)
           decdata=decode(data(1,1:n11),n11,t1,'cyclic/binary',gpol,trt);
            [q1,r1]=deconv(decdata,poly1);
            
            r1=abs(r1);
                for i1=1:length(r1)
                    b=r1(i1);
                    if ( mod(b,2)== 0 )
                        r1(i1)=0;
                    else
                        r1(i1)=1;
                    end;
                end;
           % disp(r1);
            for i2=1:t1
                if(r1(i2)==1)
                   f(i)=1;
                end;
            end;
            if f(i)==1
                e=ctr1-wl;
            %  fprintf('\nError in transmission of frame %d\n',e);
             % fprintf('Retransmitting from frame %d onwards',e);
              
                %fprintf('f=\n');
               %disp(f);
             break; 
            else
          % fprintf('\n frame %d acknowledged',ctr1-wl); 
            if(ctr1-wl==m)
                thr1(qw1)=count1/m;
              fprintf('p=%f throughput=%4.2f\n',p1(qw1),thr1(qw1));
            end;
            wl=wl-1;
            end;
    
          i=i+1;
          l1=l1+1;
        end;   
        ctr1=ctr1-wl;
        wl=n;
  
     l1=l1+1;
      end;
    end;
    
 %{   
     figure (1)
 hFig = figure(1);
 set(gcf,'PaperPositionMode','auto')
 set(hFig, 'Position', [0 0 700 500])
 %}
    plot(p,thr,'-s',p1,thr1,'-^'),axis([0,0.12,0,20]); 
xlabel('BER');
ylabel('Throughput Performance');
legend('GBN','AFTGBN')
title('Graph of Throughput performance vs BER')


