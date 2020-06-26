function [L]=Reduce(S)
%Removes redundant operators from the list, i.e removes repetitions,
% And identity and zero operators.

i=2;
while(i<=length(S))
    if or(strcmp(S(i).status,'I'),strcmp(S(i).status,'O'))
        S(i)=[];
        i=i-1;
        %Removes Identity and zero.
    else %CHeck if it has been encountered before.
        for j=2:i-1
            if isequal(S(i),S(j))
                S(i)=[];
                i=i-1;
                break;
            end
        end
    end
    i=i+1;
end

L=S;
    