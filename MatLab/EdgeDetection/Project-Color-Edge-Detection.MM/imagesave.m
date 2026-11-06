function imagesave(u,N1,N2)
% function imagesave(u,N1,N2)

if strcmp(N2,'')
    fname = strcat(N1,'.png');
elseif contains(N2,'.png')
    fname = strcat(N1,'-',N2);
else
    fname = strcat(N1,'-',N2,'.png');
end

imwrite(u,fname);
fprintf(2,'   imagesave:  <%s>\n',fname)
