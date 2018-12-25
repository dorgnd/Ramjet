% L_ramjet = 3.15; % Ramjet Length [m]
% L = 4.75; % Total Length [m]
% Data.AXIBOD.TNOSE    = 'OGIVE';
% 
% Data.AXIBOD.LNOSE     = 1.667*d;
% Data.AXIBOD.DNOSE     = d;
% Data.AXIBOD.LCENTR    = L_ramjet - Data.AXIBOD.LNOSE;
% Data.AXIBOD.DCENTR    = d;
% Data.AXIBOD.LAFT      = L-L_ramjet;
% Data.AXIBOD.DAFT      = 0.16;
% Data.AXIBOD.TAFT      = 'OGIVE';
% % For Booster 
% if flag.booster
%     % פונקציה של כפיר
%     L_skirt = 0.25;
%     Data.AXIBOD.DAFT      = 0.254;
%     Data = CreateBodyXR(Data,L_skirt);
% %     Data.AXIBOD.NX   = ;
% %     Data.AXIBOD.X    = ;
% %     Data.AXIBOD.R    = ;
% end
function [Data] = CreateBodyXR(Data,Ls)
% This function creates geomrty input as X,R vectors

Lr  = Data.AXIBOD.LCENTER+Data.AXIBOD.LNOSE;   %[m]
Lt  = Data.AXIBOD.LAFT+Lr;    %[m]
% Ls  = 0.250;  %[m]
Dr  = Data.AXIBOD.DNOSE; %[m]
Db  = Data.AXIBOD.DAFT;  %[m]
Ln  = Data.AXIBOD.LNOSE;
OgR_eq = @(L) (Dr^2/4+L.^2)/Dr;
Og_eq  = @(x,L) sqrt(OgR_eq(L).^2-(L-x).^2)+Dr/2-OgR_eq(L);

x_og  = linspace(0,Ln,30);
x_vec = [x_og Lr Lr+Ls Lt];
R_vec = [Og_eq(x_og,Ln) Dr/2 Db/2 Db/2];

Data.AXIBOD.NX = length(x_vec);
Data.AXIBOD.X  = x_vec;
Data.AXIBOD.R  = R_vec;

end