function Main_Routine

%% Fresh Start
close all
clear variables
clc

%asdsadasd
%% General Settings

global misdat_dirPath outputDirectory 

%for zucki
% misdat_dirPath = 'C:\Users\007ni\Dropbox\Magah\Missile DATCOM Workspace\';  

%for TAL
misdat_dirPath = 'C:\Users\goldb\Desktop\missile datcom workspace_dor\'; %'C:\Users\goldb\Dropbox\Magah\Missile DATCOM Workspace\'; 

%for Dor
% misdat_dirPath = 'C:\Users\Dor Gonda\Desktop\Studies\#LOCAL - Ramjet Research Project\missile datcom workspace\';

outputDirectory = [misdat_dirPath,'for042_folder\'];


% outputDirectory is the path to the folder that contains all the
% "for042_xxx.csv" files desired to be checked, where xxx is the
% description of the case.
% "xxx" should be named in chronologic numbers or letters in order to track
% the case later on, for example:

% for042_1.csv - Case with 2 fins
% for042_2.csv - Case with 3 fins
% for042_3.csv - Case with 4 fins

%% ---- Plot Flags ---- %%

% -- C_i vs. Alpha Graphs -- % -- C_i vs. Mach Graphs -- %
% --   Equal Mach Lines   -- % --  equal Alpha Lines  -- %
Plot_flag.CN_ALPHA    = 0;      Plot_flag.CN_MACH     = 0;
Plot_flag.CM_ALPHA    = 0;      Plot_flag.CM_MACH     = 0;
Plot_flag.CA_ALPHA    = 0;      Plot_flag.CA_MACH     = 0;
Plot_flag.CY_ALPHA    = 0;      Plot_flag.CY_MACH     = 0;
Plot_flag.CLN_ALPHA   = 0;      Plot_flag.CLN_MACH    = 0;
Plot_flag.CLL_ALPHA   = 0;      Plot_flag.CLL_MACH    = 0;
Plot_flag.CL_ALPHA    = 0;      Plot_flag.CL_MACH     = 0;
Plot_flag.CD_ALPHA    = 0;      Plot_flag.CD_MACH     = 1;
Plot_flag.CLoCD_ALPHA = 0;      Plot_flag.CLoCD_MACH  = 0;
Plot_flag.CNA_ALPHA   = 0;      Plot_flag.CNA_MACH    = 0;
Plot_flag.CMA_ALPHA   = 0;      Plot_flag.CMA_MACH    = 0;
Plot_flag.CYB_ALPHA   = 0;      Plot_flag.CYB_MACH    = 0;
Plot_flag.CLNB_ALPHA  = 0;      Plot_flag.CLNB_MACH   = 0;
Plot_flag.CLLB_ALPHA  = 0;      Plot_flag.CLLB_MACH   = 0;

Plot_flag.Stabilty    = 0;
flag.plotBODY = 1;
flag.booster  = 0;

%% ---- Data Input + Legend Data Creation ----  %%

L_nose = [1.667 2]; %sort([1.667 1.5:0.25:2.5]); % L_nose/d ratio
% d_vec = [0.2286];
% BoatTail = [1:8];
flag.FINSET1 = 1; % with no fins, no need for 'PRINT GEOM FIN1'

% For now, we will be using a fully defined data:
Data.START.CASEID    = 'Test Example: Base Model';
Data.START.DIM       = 'M';
Data.START.SOSE      = ' ';
Data.START.DERIV     = 'RAD';
Data.START.PLOT      = ' ';

Data.FLTCON.ALPHA    = [0 1]; %[deg]
Data.FLTCON.MACH     = [0.1 0.6 0.7 0.8:0.3:1.1 1.2 1.3 1.4 1.6 2.1 2.6 3.1];
Data.FLTCON.BETA     = 0; %[deg]
Data.FLTCON.ALT      = zeros(1,length(Data.FLTCON.MACH));

d = 0.2286; % Body Diameter [m]
Data.REFQ.XCG        = 1.541;
Data.REFQ.SREF       = 0.25*pi*(d)^2;
Data.REFQ.LREF       = d;
Data.REFQ.RHR        = 0;

L_ramjet = 3.15; % Ramjet Length [m]
L = 4.75; % Total Length [m]
Data.AXIBOD.TNOSE    = 'OGIVE';

Data.AXIBOD.LNOSE     = 1.667*d;
Data.AXIBOD.DNOSE     = d;
Data.AXIBOD.LCENTR    = L_ramjet - Data.AXIBOD.LNOSE;
Data.AXIBOD.DCENTR    = d;
Data.AXIBOD.LAFT      = L-L_ramjet;
Data.AXIBOD.DAFT      = 0.16;
Data.AXIBOD.TAFT      = 'OGIVE';
% For Booster 
if flag.booster
    L_ramjet = 3.15; % Ramjet Length [m]
    L = 4.75; % Total Length [m]
    Data.AXIBOD.TNOSE    = 'OGIVE';
    Data.AXIBOD.LNOSE     = 1.667*d;
    Data.AXIBOD.DNOSE     = d;
    Data.AXIBOD.LCENTR    = L_ramjet - Data.AXIBOD.LNOSE;
    Data.AXIBOD.DCENTR    = d;
    Data.AXIBOD.LAFT      = L-L_ramjet;
    Data.AXIBOD.DAFT      = 0.254;
    Data.AXIBOD.TAFT      = 'OGIVE';
    L_skirt = 0.25;
    Data = CreateBodyXR(Data,L_skirt);
%     Data.AXIBOD.NX   = ;
%     Data.AXIBOD.X    = ;
%     Data.AXIBOD.R    = ;
end
% For Base Drag
% Data.AXIBOD.DEXIT    = 0;


Data.FINSET1.SECTYP  = 'HEX';
Data.FINSET1.SSPAN   = [0.1 0.3];
Data.FINSET1.XLE     = [1.4 1.6];
Data.FINSET1.CHORD   = [0.3 0.1];
Data.FINSET1.NPANEL  = 4;
Data.FINSET1.PHIF    = 45:90:315;
% Data.FINSET1.GAM     = 0;
% Data.FINSET1.CFOC    = [1 1];
Data.END.PRINT     = [{'GEOM BODY'}];

if flag.FINSET1
    Data.END.PRINT(end+1,end) = {'GEOM FIN1'};
end

Data.FINSET2.SECTYP  = 'HEX';
Data.FINSET2.SSPAN   = [0.1 0.3];
Data.FINSET2.XLE     = [1.4 1.6];
Data.FINSET2.CHORD   = [0.3 0.1];
Data.FINSET2.NPANEL  = 4;
Data.FINSET2.PHIF    = 45:90:315;
% Data.FINSET2.GAM     = 0;
% Data.FINSET2.CFOC    = [1 1];
% Data.END.PRINT     = [{'GEOM BODY'};{'GEOM FIN2'}];

if flag.booster
    Data.END.PRINT(end+1,end) = {'GEOM FIN2'};
end

% Data.END.NEXT      = 'CASE';

case_number = 1;

caseName = cell(length(L_nose),1);

% for j = 1:length(d_vec)
%     d = d_vec(j);
%     Data.AXIBOD.DNOSE    = d;
%     Data.REFQ.SREF       = 0.25*pi*(d)^2;
%     Data.REFQ.LREF       = d;
%     Data.AXIBOD.DNOSE    = d;
%     Data.AXIBOD.DCENTR   = d;
for i = 1:length(L_nose)
    Data.AXIBOD.LNOSE = L_nose(i)*d;
    Data.AXIBOD.LCENTR   = L - Data.AXIBOD.LNOSE;
    Print_Input(Data,flag);
    runMISDAT
    if flag.plotBODY
        plotBODY('zucki_plotBODY.plotb')
    end
    outputName = ['for042_',num2str(case_number),'.csv'];
    inputName  = ['for005_',num2str(case_number),'.dat'];
    
    copyfile('for042.csv',[outputDirectory,outputName],'f');
    copyfile('for005.dat',[outputDirectory,inputName],'f');
    caseName{case_number} = ['L/d = ',num2str(L_nose(i)),' ; L = ',num2str(Data.AXIBOD.LNOSE),'[m]'];
    case_number = case_number + 1;
end
% end
%% ---- Files Arrangement, Preparing the Data in "Cases" structure for further use in comparison between cases functions ---- %%

FileLocation = outputDirectory;

cd(FileLocation)
csvFiles = dir('*.csv');
cd ..\

FileNames = cell(length(csvFiles),1);

for k=1:length(csvFiles)
    tmpFileName = csvFiles(k).name;
    tmpIndex    = regexp(tmpFileName,'\d*','Match');
    ind         = str2double(tmpIndex{end});
    
    FileNames{ind} = csvFiles(k).name;
end

Cases = struct;
for i = 1:length(FileNames)
    caseData = output_import(FileNames{i},FileLocation);
    Cases.(sprintf('a%d',i)) = caseData;
    Cases.(sprintf('a%d',i)).Name = caseName(i);
end

%% Stability Margin

Xcg_Xn = zeros(length(FileNames),length(Data.FLTCON.MACH));

for i = 1:length(FileNames)
    CM = Cases.(sprintf('a%d',i)).CM ;
    CL = Cases.(sprintf('a%d',i)).CL ;
    for j = 1:length(Data.FLTCON.MACH)
        Delta_CM = diff(CM((2*j-1):2*j));
        Delta_CL = diff(CL((2*j-1):2*j));
        Xcg_Xn(i,j) = (Delta_CM/Delta_CL).*d;
    end
end

LegendInfo = cell(size(Xcg_Xn,1));
if Plot_flag.Stabilty
    figure;
    hold all;
    for i = 1:size(Xcg_Xn,1)
        plot(Data.FLTCON.MACH,Xcg_Xn(i,:));
        LegendInfo{i} = ['L/D = ',num2str(L_nose(i))];
    end
    legend(LegendInfo)
    xlabel('Mach Number');
    ylabel('$|X_{cg} - X_{n}|$ [d]')
    if flag.FINSET1
        title('Stabilty Margin for Body + Wing')
    else
        title('Stabilty Margin for Body')
    end
end
%% Comparison Between Cases

plotGRAPH_between_cases(Cases,Plot_flag)

%% Delete Data for further runs

answer = questdlg('Delete all files from output folder?',...
    'Handle Files','Yes','No','No');

if strcmp(answer,'Yes')
    delete([outputDirectory,'\*']);
end

end