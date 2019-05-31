% Generate random patterns


NCELL = 100;  % number of cells (neurons)
NPATT =10 ;   % number of patterns
SPATT = 20;   % numbeer of active cells per pattern
%PC = 0.5;    % percent connectivity (not normally used)

var=num2str(NPATT);
FPATT = strcat('pattsN100S20P',var,'.dat');   % patterns file

%rand('state',0);
rand('state',sum(100*clock));


    p = zeros(NCELL, NPATT);
    for j=1:NPATT
  % generate pattern
     pr = randperm(NCELL);
     pi = pr(1:SPATT);       
     p(pi,j) = 1;
    end
    st=num2str(i);
    dlmwrite(FPATT, p, ' ');

