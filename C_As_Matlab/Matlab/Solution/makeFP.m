 function [ FP ] = back_makeFP( charFP, segBegin, segEnd )
    n = size(charFP, 1);
    FP = zeros(0);
    tmpFP = zeros(0);
    
    for i = 1:n %перевод условий в компьютерный формат пошагово
        strTmp = charFP(i, 1);
        for j = 1:n
            toReplace = ['x' num2str(n + 1 - j) '(' num2str(segBegin) ')'];
            replacement = ['xa' num2str(n + 1 - j)];
            strTmp = strrep(strTmp, toReplace, replacement); 
            
            toReplace = ['x' num2str(n + 1 - j) '(' num2str(segEnd) ')'];
            replacement = ['xb' num2str(n + 1 - j)];
            strTmp = strrep(strTmp, toReplace, replacement); 
            
            toReplace = ['x' num2str(n + 1 - j) '(a)'];
            replacement = ['xa' num2str(n + 1 - j)];
            strTmp = strrep(strTmp, toReplace, replacement); 
            
            toReplace = ['x' num2str(n + 1 - j) '(b)'];
            replacement = ['xb' num2str(n + 1 - j)];
            strTmp = strrep(strTmp, toReplace, replacement); 
        end
        tmpFP = [tmpFP; string(strTmp)];
    end
    
    symArray = sym('xa%d', [1 n]);
    syms(symArray);
    symArray = sym('xb%d', [1 n]);
    syms(symArray);
    
    [token, remain] = strtok(tmpFP, '=');
    token = char(token);
    remain = char(remain);
    remain = remain(:, 2:end);
    
    for i = 1:n
        FP = [FP; sym(token(i, :)) - sym(remain(i, :))];
    end
 end

