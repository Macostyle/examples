function [ initConditionForXMatrix ] = back_generateInitConditionForXMatrix( n )
    tmpMatrix = eye(n, n);
    initConditionForXMatrix = reshape(tmpMatrix, [n*n, 1]);
end

