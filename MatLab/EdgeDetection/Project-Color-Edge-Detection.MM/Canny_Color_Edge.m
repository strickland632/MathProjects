close all; clear all

USER_PAR;

if exist('OCTAVE_VERSION','builtin'), pkg load image; end
%----------------------------------------------
TheImage = char(DATA(idata));
[Filepath,Name,Ext] = fileparts(TheImage);
v0 = im2double(imread(TheImage));
[m,n,d] = size(v0);
    if level>=1, figure, imshow(v0); end
%--- User Interface ---------------------------
    fprintf('%s: size=(%d,%d,%d)\n',TheImage,m,n,d)
    fprintf('id_smooth = %d (%s); id_grad = %d (%s)\n',...
        id_smooth,char(DENS(id_smooth)),id_grad,char(GRAD(id_grad)))
    if(id_smooth==1),fprintf('Smooth: delta=%g; beta=%g; Dt=%g; nmax=%d\n',...
             delta,beta,Dt,nmax);
    else,fprintf('Smooth: sigma=%g\n',sigma); end
    fprintf('%s: size=(%d,%d,%d)\n',TheImage,m,n,d)

%--- Use Matlab Built-in: "edge" --------------
vg = rgb2gray(v0);
E = edge(vg,'Canny');
    if level>=1, figure,imshow(E); end
    if level>=4, imagesave(vg,Name,'Gray'); end
    if level>=4, imagesave(E, Name,'Gray-Builtin-Edge'); end

%----------------------------------------------
%-- New Algorithm: Color Edge Detection -------
%----------------------------------------------
if d==3, ES = color_edge(v0,Name); end
    if level>=1, figure, imshow(ES); end
    if level>=2,
        Name = strcat(Name,'-S',int2str(id_smooth),'-G',int2str(id_grad));
        imagesave(ES,Name,'EDGE'); end

