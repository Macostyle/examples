function solve = solve_eq(Start_tableData, conditionsTableData, segBegin, segEnd, stepsCount, accuracyExternal, accuracyInternal, SM_internal, stepSize, SM_external, timeOfT, Init_VtableData)
        ftx = Start_tableData;
        ftx = ftx(1:end-1, 2);
        n = size(ftx, 1);
        
        dftx = findDftx(ftx);
        XMatrix = genMx(size(ftx, 1));
        initC = genIC(size(ftx, 1))';
        initCond_internal = [Init_VtableData initC];
        
        charFP = conditionsTableData;
        FP = makeFP(charFP, segBegin, segEnd);
        p0 = Init_VtableData;
   
        symArray1 = sym('xa%d', [1 n]);
        symArray1 = [symArray1 sym('xb%d', [1 n])];
        syms(symArray1);
        symArray1 = num2cell(symArray1);
        
        symArray2 = sym('xa%d', [1 n]);
        syms(symArray2);
        
        symArray3 = sym('xb%d', [1 n]);
        syms(symArray3);
        
        Stepsize_internal = 0.01;
        global DRXA XAP DRXB XBP FP0;
        
        for i = 1:stepsCount
            steps = 1/stepSize;
            for j = 0:stepSize:(1-stepSize)
                switch SM_internal
                    case 1
                        if timeOfT == segBegin
                            [T, X] = ode45(@systemTemp, [segBegin:Stepsize_internal:segEnd], initCond_internal, odeset('RelTol', accuracyInternal));
                        elseif timeOfT == segEnd
                            [T, X] = ode45(@systemTemp, [segEnd:-Stepsize_internal:segBegin], initCond_internal, odeset('RelTol', accuracyInternal));
                            T = T(end:-1:1, :);
                            X = X(end:-1:1, :);
                        else 
                            [T1, X1] = ode45(@systemTemp, [timeOfT:-Stepsize_internal:segBegin], initCond_internal, odeset('RelTol', accuracyInternal));
                            [T2, X2] = ode45(@systemTemp, [timeOfT:Stepsize_internal:segEnd], initCond_internal, odeset('RelTol', accuracyInternal));
                            T = [T1(end:-1:2); T2];
                            X = [X1(end:-1:2, :); X2];
                        end
                    case 2
                        if timeOfT == segBegin
                            [T, X] = ode23(@systemTemp, [segBegin:Stepsize_internal:segEnd], initCond_internal, odeset('RelTol', accuracyInternal));
                        elseif timeOfT == segEnd
                            [T, X] = ode23(@systemTemp, [segEnd:-Stepsize_internal:segBegin], initCond_internal, odeset('RelTol', accuracyInternal));
                            T = T(end:-1:1, :);
                            X = X(end:-1:1, :);
                        else 
                            [T1, X1] = ode23(@systemTemp, [timeOfT:-Stepsize_internal:segBegin], initCond_internal, odeset('RelTol', accuracyInternal));
                            [T2, X2] = ode23(@systemTemp, [timeOfT:Stepsize_internal:segEnd], initCond_internal, odeset('RelTol', accuracyInternal));
                            T = [T1(end:-1:2); T2];
                            X = [X1(end:-1:2, :); X2];
                        end
                    case 3
                        if timeOfT == segBegin
                            [T, X] = ode113(@systemTemp, [segBegin:Stepsize_internal:segEnd], initCond_internal, odeset('RelTol', accuracyInternal));
                        elseif timeOfT == segEnd
                            [T, X] = ode113(@systemTemp, [segEnd:-Stepsize_internal:segBegin], initCond_internal, odeset('RelTol', accuracyInternal));
                            T = T(end:-1:1, :);
                            X = X(end:-1:1, :);
                        else 
                            [T1, X1] = ode113(@systemTemp, [timeOfT:-Stepsize_internal:segBegin], initCond_internal, odeset('RelTol', accuracyInternal));
                            [T2, X2] = ode113(@systemTemp, [timeOfT:Stepsize_internal:segEnd], initCond_internal, odeset('RelTol', accuracyInternal));
                            T = [T1(end:-1:2); T2];
                            X = [X1(end:-1:2, :); X2];
                        end
                    case 4
                        if timeOfT == segBegin
                            [T, X] = ode15s(@systemTemp, [segBegin:Stepsize_internal:segEnd], initCond_internal, odeset('RelTol', accuracyInternal));
                        elseif timeOfT == segEnd
                            [T, X] = ode15s(@systemTemp, [segEnd:-Stepsize_internal:segBegin], initCond_internal, odeset('RelTol', accuracyInternal));
                            T = T(end:-1:1, :);
                            X = X(end:-1:1, :);
                        else 
                            [T1, X1] = ode15s(@systemTemp, [timeOfT:-Stepsize_internal:segBegin], initCond_internal, odeset('RelTol', accuracyInternal));
                            [T2, X2] = ode15s(@systemTemp, [timeOfT:Stepsize_internal:segEnd], initCond_internal, odeset('RelTol', accuracyInternal));
                            T = [T1(end:-1:2); T2];
                            X = [X1(end:-1:2, :); X2];
                        end
                end
                n = size(FP, 1);
                XP0 = num2cell([X(1, 1:n) X(end, 1:n)]);
                XAP = X(1, n+1:end);
                XAP = reshape(XAP, [n n]);
                XBP = X(end, n+1:end);
                XBP = reshape(XBP, [n n]);
                FP0 = subs(FP(:, 1), symArray1, XP0);
                DRXA = jacobian(FP, symArray2);
                DRXB = jacobian(FP, symArray3);
                DRXA = subs(DRXA, symArray1, XP0);
                DRXB = subs(DRXB, symArray1, XP0);
                
                switch SM_external
                    case 1
                        [mu, p] = ode45(@back_findDFP, [j (j+stepSize)], p0, odeset('RelTol', accuracyExternal));
                    case 2
                        [mu, p] = ode23(@back_findDFP, [j (j+stepSize)], p0, odeset('RelTol', accuracyExternal));
                    case 3
                        [mu, p] = ode113(@back_findDFP, [j (j+stepSize)], p0, odeset('RelTol', accuracyExternal));
                    case 4
                        [mu, p] = ode15s(@back_findDFP, [j (j+stepSize)], p0, odeset('RelTol', accuracyExternal));
                    case 5
                        p = (back_findDFP*stepSize+p0')';
                end
                p(end, :);
                p0 = p(end, :);
                initCond_internal = [p0 initC];
                waitbar((j/stepsCount) + ((i-1)/stepsCount));
            end
        end
        solve = [T(:, :), X(:, 1:n)];
end