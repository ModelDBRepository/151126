% Generate sets offive orthogonal patterns


NCELL = 100;  % number of cells (neurons)
NPATT =5 ;   % number of patterns
SPATT = 20 ;   % number of active cells per pattern
sets=2
%PC = 0.5;    % percent connectivity (not normally used)
var=num2str(NPATT);
spat=num2str(SPATT);

for j=1:sets
    varort=num2str(j);
    FPATT = strcat('pattsN100S',spat,'P',var,'o',varort,'.dat');   % patterns file

    %rand('state',0);
    rand('state',sum(100*clock));

    %rw = rand(NCELL);
    %w = ones(NCELL).*PC >= rw

    p = zeros(NCELL, NPATT);
    pos=struct('p',[]);
    pr = randperm(NCELL);

    for i=1:NPATT

      pi = pr((i-1)*SPATT+1:i*SPATT);
      p(pi,i) = 1;


    end

    dlmwrite(FPATT, p, ' ');
    
end
