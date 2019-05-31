This archive contains the NEURON files from the paper: 

Effects of CREB-dependent transcription factor over expression 
on the storage and recall processes in a hippocampal CA1 microcircuit,
by Daniela Bianchi, Pasquale De Michele, Cristina Marchetti,
Brunello Tirozzi, Salvatore Cuomo, Hélène Marie, Michele Migliore

http://onlinelibrary.wiley.com/doi/10.1002/hipo.22212/abstract

SERIAL VERSION (VERY SLOW!)
Usage: Auto-launch from ModelDB or download and extract this archive,
compile the mod files (mknrndll in mswin and mac OS X, nrnivmodl in
unix/linux) in the main folder and launch the Sto_phase_ser.hoc file
to run the Storage phase simulation for 2 theta cycles. 
If you want to test pure recall, launch (after the storage phase)
the PureRec_phase_ser.hoc simulation.


PARALLEL VERSION
Main file: Sto_phase.hoc  (storage phase)
           PureRec_phase.hoc (Pure Recall phase)

Sto_phase.hoc is configured to produce the results presented in Fig.4
of the article. In order to plot the figure, use the matlab 
'pattern_all_RECALL.m' and 'Vtraces_all' files.

PureRec_phase.hoc is configured to produce the results about the
recall of the previous stored pattern when the entorhinal cortex input
is disconnected from the CA1 pyramidal cells and so pattern recall is
cued exclusively by CA3 Schaffer collateral input.

The parameters, in both filess, are set to reproduce the control case.
In order to get the Creb case, change the variable 'CHWGT' as indicated
in the hoc files and set 'CREB'=1.

Note that in order to run under 64-bit Windows with MPI you may need 
to replace the instruction 'system(s_sys)' with 'WinExec(s_sys)'.

Matlab files required for plotting results are located in the 'Results'
directory.

Folders with example patterns, as well as Matlab files to create other
patterns (both orthogonal and random ones), are located in the 'Weights'
directory.

*********WARNING******************
// Bug report, M. Migliore, D. Bianchi, and P. De Michele, 16 Apr 2015
We have been informed of a bug in the IA mod file,
used for the OLM interneuron first introduced in ModelDB ac. 28316.
Critical simulations (including those for Fig.4) were thus rerun with the bug fixed.
We did not find any significant deviation from the published results.
**********************************

Questions on the NEURON simulation and MATLAB files should be addressed to
(replace -at- with the usual @ symbol):
danielabianchi12-at-gmail.com
pasquale.demichele-at-unina.it