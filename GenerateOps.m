function [Ops]=GenerateOps(A,B,C,L)
%A,B,C are lists that give the number of outcomes for each measurement
%settings. A=[4,4,2] meanns that the 1st measurement setting of A has 4
%outcomes, second has 4 and third has 2.

%L stores the order to which operators will be generated.

%First we manually generate the order 1 array.

S=[];
S(1).status='I'; %'O' is zero, '1' is non empty, 'I' is identity
S(1).as='';
S(1).ao='';
S(1).bs='';
S(1).bo='';
S(1).cs='';
S(1).co='';

la=size(A,2);
lb=size(B,2);
lc=size(C,2);

K=[]; %stores order 1 operators
for i=1:la
    for j=1:(A(i)-1)
        P.status='1';
        P.as=int2str(i); %possible problems when settings exceed 10?
        P.ao=int2str(j);
        P.bs='';
        P.bo='';
        P.cs='';
        P.co='';
        K=[K,P];
    end
end
%Generated A operatios. Notice the A(i)-1 allows us to neglect the identity
%constaint.

for i=1:lb
    for j=1:(B(i)-1)
        P.status='1';
        P.as='';
        P.ao='';
        P.bs=int2str(i);
        P.bo=int2str(j);
        P.cs='';
        P.co='';
        K=[K,P];
    end
end
%Generated B operators.

for i=1:lc
    for j=1:(C(i)-1)
        P.status='1';
        P.as='';
        P.ao='';
        P.bs='';
        P.bo='';
        P.cs=int2str(i);
        P.co=int2str(j);
        K=[K,P];
    end
end
        
S=[S,K];

 k=length(K); %number of single length operators


for order=2:L
    LEN=length(S);
    index=length(S);
    for i=1:LEN   %For the operators within with smaller than order
        for j=1:k
            S(index+1)=ProductOps(S(i),K(j));
            index=index+1;
        end
    end
    order=order+1;
    S=Reduce(S);
    %REDUCE S
    %It would be ideal to reduce the S here itself.
end
%This is quite inneffecient as, in order to generate order L, we take a
%product of all operators with lower order with K, instead of just taking
%order L-1, with K.
%)
Ops=S;    
end
