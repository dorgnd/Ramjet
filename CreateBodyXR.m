function [Data] = CreateBodyXR(Data,Ls)
% This function creates geomrty input as X,R vectors
% new change in MASTER
Lr  = Data.AXIBOD.LCENTR + Data.AXIBOD.LNOSE;   %[m]
Lt  = Data.AXIBOD.LAFT+Lr;    %[m]
% Ls  = 0.250;  %[m]
DR  = Data.AXIBOD.DNOSE; %[m]
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
