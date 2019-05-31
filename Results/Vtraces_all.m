% Plot voltage traces from example PC and INs


clear all 
close all

NCELL =235     % number of cells (neurons)
NPCELL = 100; % number of PC (output) cells
SPATT = 20;   % number of active cells per pattern
%init=50     %for serial version
init=100

MOLT_TH=100;  
MOLT_TH1=100;   % =10 for pure recall; =100 for storage
%MOLT_TH=2;   % for serial version
%MOLT_TH1=2;   % for serial version
RTIME = init+(250*MOLT_TH1);    % run time (msecs)
% ----- parallel version
%for storage phase
STIME = init+82*250; % init+250 to see the all interval
ETIME =STIME+1100;  %RTIME  to see the all interval
%for pure recall
%STIME = init+125; 
%ETIME = RTIME;
%--------------------
% ----- serial version
%STIME = init+125; 
%ETIME = STIME+3*125;
%------------------
STDPP= 0.60;
STDPD=0.80;
SETPATT=1;

stdpp=num2str(STDPP, '%.2f');
stdpd=num2str(STDPD,'%.2f');
setp=num2str(SETPATT,'%d');
spat=num2str(SPATT,'%d');
molt_theta=num2str(MOLT_TH);
molt_theta1=num2str(MOLT_TH1); 
creb='';  % write '_CREB' for CREB case
suffix='';  % write '_RECALL' for pure recall
lensuf=length(suffix);
fold='Results/bpattrun2/';   % directory for storage phase
%fold='Results/bpattrun/';      % directory for pure recall

 
NSTORE=1;
npatt=num2str(NSTORE)

ntot=2;   % number of cell to be printed
inp=num2str(6);  % INPR variable

ms=8;
lw=1;
nr = 4;
VMIN = -90;
VMAX = 50;
dt = 0.025;
 
for NPATT =1:1:1 % number of patterns


 if (NPATT==0) NPATT=1; end

   npat=num2str(NPATT)
    %namefold=strcat(fold,'MT_',molt_theta,'_NS_',npat,'_SET_',setp,'_INPR_',inp,suffix,creb);  %for serial version
    namefold=strcat(fold,'MT_',molt_theta,'_NS_',npatt,'_SPATT_',spat,'_STDPP_',stdpp,'_STDPD_',stdpd,'_SET_',setp,'_INPR_',inp,suffix,creb);
   dir2=strcat('../',namefold);
     cd(dir2)

   
     
    for kk=1:NPATT
      
    npat2=num2str(kk)    
    if (lensuf==0)
          FST = 'HAM_P0R'; 
     else
          FST = strcat('HAM_P',npat2,'R');   % spikes file
     end
    
    FSTEM=strcat(FST,npat2,'_')

    subplot(nr,1,1);
    FV = [FSTEM 'AAC.dat'];   % voltage file
    v = load(FV);  % load spike times
    t = (0:length(v)-1)*dt;       % extract times
    hold on;
    plot(t, v, 'k-');   % voltage trace
    title('Axo-axonic cell');
    ylabel('V (mV)');
    axis([STIME ETIME VMIN VMAX]);

    subplot(nr,1,2);
    FV = [FSTEM 'BC.dat'];   % voltage file
    v = load(FV);  % load spike times
    t = (0:length(v)-1)*dt;       % extract times
    hold on;
    plot(t, v, 'k-');   % voltage trace
    title('Basket cell');
    ylabel('V (mV)');
    axis([STIME ETIME VMIN VMAX]);

    subplot(nr,1,3);
    FV = [FSTEM 'BSC.dat'];   % voltage file
    v = load(FV);  % load spike times
    t = (0:length(v)-1)*dt;       % extract times
    hold on;
    plot(t, v, 'k-');   % voltage trace
    title('Bistratified cell');
    ylabel('V (mV)');
    axis([STIME ETIME VMIN VMAX]);

    subplot(nr,1,4);
    FV = [FSTEM 'OLM.dat'];   % voltage file
    v = load(FV);  % load spike times
    t = (0:length(v)-1)*dt;       % extract times
    hold on;
    plot(t, v, 'k-');   % voltage trace
    title('OLM cell');
    ylabel('V (mV)');
    xlabel('Time (msecs)');
    axis([STIME ETIME VMIN VMAX]);

     name1=strcat(FSTEM,'Intern.jpg');
    saveas(gcf,name1)

         for jj=0:ntot-1

                figure;
                ncellp=num2str(jj)

                figure(2)

                subplot(3,1,1);
                FV = [FSTEM 'pvsoma_',ncellp,'.dat'];   % voltage file
                v = load(FV);  % load spike times
                t = (0:length(v)-1)*dt;       % extract times
                hold on;
                plot(t, v, 'k-');   % voltage trace
                title('Pattern pyramidal cell Soma');
                ylabel('V (mV)');
                axis([STIME ETIME VMIN+10 VMAX-30]);

                subplot(3,1,2);
                FV2 = [FSTEM 'pvsr_',ncellp,'.dat'];   % voltage file
                v = load(FV2);  % load spike times
                t = (0:length(v)-1)*dt;       % extract times
                hold on;
                plot(t, v, 'k-');   % voltage trace
                title('Pattern pyramidal cell RadTmed');
                ylabel('V (mV)');
                axis([STIME ETIME VMIN+10 VMAX-30]);

                subplot(3,1,3);
                FV3 = [FSTEM 'pvslm_',ncellp,'.dat'];   % voltage file
                v = load(FV3);  % load spike times
                t = (0:length(v)-1)*dt;       % extract times
                hold on;
                plot(t, v, 'k-');   % voltage trace
                title('Pattern pyramidal cell LM');
                ylabel('V (mV)');
                xlabel('Time (msecs)');
                axis([STIME ETIME VMIN+10 VMAX-30]);

              name=strcat(FSTEM,'Vtraces',ncellp ,'.jpg');
              saveas(gcf,name)
              close all

         end 


    end  % for kk

end

tt=t';
 fid2=fopen('time.txt','w+')
 for i=1:length(tt)
 fprintf(fid2,'%.4f\n', tt(i));
 end
 
    