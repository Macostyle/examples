function [ dftx ] = back_findDftx( ftx )
    dftx = zeros(0);
    symArray = sym('x%d', [1 size(ftx, 1)]);
    syms(symArray);
    dftx = jacobian(ftx, symArray);
end
