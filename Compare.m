function [y]=Compare(X,Y)

%Compares two operators and returns 1 if they are equal

y=1;
if not(strcmp(X.status,Y.status))
    y=0;
    return
end
if not(strcmp(X.as,Y.as))
    y=0;
    return
end

if not(strcmp(X.ao,Y.ao))
    y=0;
    return
end
if not(strcmp(X.bs,Y.bs))
    y=0;
    return
end

if not(strcmp(X.bo,Y.bo))
    y=0;
    return
end
if not(strcmp(X.cs,Y.cs))
    y=0;
    return
end
if not(strcmp(X.co,Y.co))
    y=0;
    return
end


