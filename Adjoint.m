function [Y]=Adjoint(X)
%function returns the adjoint of input operator. We just need to reverse
%all the as,ao,bs,bo,cs,co strings.

Y.status=X.status;
Y.as='';
Y.ao='';
Y.bs='';
Y.bo='';
Y.cs='';
Y.co='';


for i=1:length(X.as)
    Y.as(i)=X.as(length(X.as)+1-i);
    Y.ao(i)=X.ao(length(X.ao)+1-i);
end

for i=1:length(X.bs)
    Y.bs(i)=X.bs(length(X.bs)+1-i);
    Y.bo(i)=X.bo(length(X.bo)+1-i);
end

for i=1:length(X.cs)
    Y.cs(i)=X.cs(length(X.cs)+1-i);
    Y.co(i)=X.co(length(X.co)+1-i);
end