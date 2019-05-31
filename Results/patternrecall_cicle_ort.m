clear all 
close all

NCELL =235     % number of cells (neurons)
NPCELL = 100; % number of PC (output) cells
SPATT = 20;   % number of active cells per pattern
%init=50     %for serial version
init=100

MOLT_TH=100;  
MOLT_TH1=100;   % =10 for pure recall, =100 for storage 
%MOLT_TH=2;   % for serial version
%MOLT_TH1=2;   % for serial version
RTIME = init+(250*MOLT_TH1);    % run time (msecs)
% ----- parallel version
%for storage phase
STIME = init+82*250; % init+250 to see the all interval
ETIME =STIME+1100;  %RTIME  to see the all interval
%for pure recall
%STIME = init+250; 
%ETIME = RTIME;
%--------------------
% ----- serial version
%STIME = init+250; 
%ETIME = STIME+1*125;
%---------------------
STDPP= 0.60;
STDPD=0.80;
SETPATT=1;

stdpp=num2str(STDPP, '%.2f');
stdpd=num2str(STDPD,'%.2f');
setp=num2str(SETPATT,'%d');
spat=num2str(SPATT,'%d');
molt_theta=num2str(MOLT_TH);
molt_theta1=num2str(MOLT_TH1); 
creb='_CREB';  % write '_CREB' for CREB case
suffix='';  % write '_RECALL' for pure recall
lensuf=length(suffix);
fold='Results/bpattrun2/';   % directory for storage phase
%fold='Results/bpattrun/';      % directory for pure recall

NSTORE=5;
npatt=num2str(NSTORE);
nstore=num2str(NSTORE);

coeff=struct('metr',[]);

 for j=2:2
     inp=num2str(j); %INPR variable
 for NORT=1:1
     SETPATT=NORT;
     norto=num2str(NORT);
     setp=num2str(SETPATT,'%d');   
     dir=strcat('../Weights/setpatt',setp,'/');
     cd(dir)
   % namefold=strcat(fold,'MT_',molt_theta,'_NS_',npatt,'_SET_',setp,'_NORT_',norto,'_INPR_',inp,suffix,creb) % for serial version
   namefold=strcat(fold,'MT_',molt_theta,'_NS_',npatt,'_SPATT_',spat,'_STDPP_',stdpp,'_STDPD_',stdpd,'_SET_',setp,'_NORT_',norto,'_INPR_',inp,suffix,creb);
   dir2=strcat('../../',namefold)
   
     FPA = 'pattsN100S'; 
    FPATT=strcat(FPA,spat,'P',npatt,'o',norto,'.dat')
    patts = load(FPATT);   % load stored patterns
    cd(dir2)
     
 r=0;
      
for NPATT =1:1:NSTORE  % number of 
    if (NPATT==0) NPATT=1; end
     npat=num2str(NPATT)
   
     nomefile=strcat('Correlation_',npat,suffix,'.dat')
     fid = fopen(nomefile,'w');
     fprintf(fid,'quality0\t ntheta0\t quality\n')
     
     r=r+1;
          
     
    for kk=1: NPATT
        cpat=num2str(kk);   % kk CPATT
    if (lensuf==0)
        FSTEM = strcat('HAM_P0R',cpat,'_spt');   % spikes file
    else
    FSTEM = strcat('HAM_P',npat,'R',cpat,'_spt',suffix);   % spikes file
    end
    FSPIKE = [FSTEM '.dat'];   % spikes file
    cue = patts(:,kk);   % extract cue pattern
    cue2=cue;

    
    sp = load(FSPIKE);  % load spike times
    st = sp(:,1);       % extract times
    cell = sp(:,2);     % extract corresponding cell indices
    % extract PC spiking
    stp = st(cell < NPCELL);
    cellp = cell(cell < NPCELL);

    % Analyse spiking over time and compare with cue
    DT = 1; % sliding time
    TW = 5;    % width of sliding time window
    %TW = 10;    % width of sliding time window
    
    jj=[];
    
   for j=1:MOLT_TH1-1
       k=2*j-2;
       ii=[(k*125):((k+1)*125)-1];
       jj=[jj,ii];
   end
    jj=jj+init+250;
    
    NW = length(jj);   % number of time windows
    mc = mean(cue); % mean cue activity
    nc = zeros(NW,1);
    metr = zeros(NW,1);
    an = zeros(NW,1);
    
    tti = 0:DT:RTIME-TW;
    Nti = length(tti);   
    metr1 = zeros(Nti,1);    
       
    for i=1:NW
        
        rp = cellp( stp>=jj(i) & stp<jj(i)+TW ); % active cells in sliding window
        nc(i) = length(rp);    % number of active cells in window
        p = zeros(NPCELL,1);
        p(rp+1,1) = 1;  % recalled pattern
        mp = mean(p);   % mean pattern activity
        if mp == 0
            metr(i) = 0;
         else
            
           metr(i) = dot(p,cue)/sqrt(sum(p)*sum(cue));
               
        end;  
        
  
    end
    
    % Generate figure
    figure;
    ms=8;
    lw=2;
    ti = 1:DT:NW+STIME;
    ti=ti';
   
    subplot(3,1,1);
    plot(sp(:,1), sp(:,2), 'k.', 'markersize', ms);   % raster plot of Sep, EC & CA3 spiking
    title('Input spikes');
    ylabel('Cell no');
    axis([STIME ETIME NPCELL+4 NPCELL+4+130]);

    subplot(3,1,2);
    hold on;
    plot(sp(:,1), sp(:,2), 'k.', 'markersize', ms);   % raster plot of PC spiking
    title('Pyramidal cell spikes');
    ylabel('Cell no.');
    axis([STIME ETIME 0 NPCELL-1]);
    
    theta0(kk)=0;
    for rr=1:MOLT_TH1-1
        xx=metr(((rr-1)*125+1):(rr*125));
        metr1((init+250+(rr-1)*250+1):(init+250+(rr-1)*250+125))=xx;
        if (mean(xx)==0)
            theta0(kk)=theta0(kk)+1;
            metr2(rr)=0;
        else
            xxx=xx(xx>0);
            metr2(rr)=mean(xxx);
        end
    end
    
        
    subplot(3,1,3);
    hold on;
    plot(tti', metr1, 'k-', 'LineWidth', lw); % recall quality
    title('Recall quality');
    ylabel('Quality');
    xlabel('Time (msecs)');
    axis([STIME ETIME 0 1.02]);


    name1=strcat(FSTEM,'1.jpg');
    saveas(gcf,name1)
    
    
    Mmetr2(kk)=mean(metr2);
    if( sum(metr2)==0) 
        Mco(kk)=0;
        Mmetr3(kk)=0; 
    else
    Mmetr3(kk)=mean(metr2(metr2>0)); 
    end
    
    fprintf(fid,'%.4f \t %d \t %.4f\n', Mmetr2(kk),theta0(kk),Mmetr3(kk))
    
    coeff(j,r,kk).metr=metr2;
    
    clear metr metr2    
    close all  
      
    end  % for kk
   
    MMmetr2=mean(Mmetr2);
    
    if( sum(Mmetr3)==0) 
        MMmetr3=0;
    else
      MMmetr3=mean(Mmetr3);
    end
   Mtheta0=mean(theta0);
    
    fprintf(fid,'\n %.4f \t %d \t %.4f\n',MMmetr2,Mtheta0,MMmetr3)
   
    fclose(fid)
    
    clear Mmetr Mmetr2 Mmetr3 Mtheta0 MMmetr2  MMmetr3 theta0
   
end
 end
 end
 
 name=strcat('Recall',creb,'.mat')
 save(name,'coeff'); 