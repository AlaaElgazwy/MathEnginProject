%% ========================================================
%% PROJECT: ADVANCED MATHEMATICAL ENGINE (COMPREHENSIVE VERSION)
%% DEVELOPER: ALAA 
%% DESCRIPTION: Matrix Ops, Linear Systems, and Spectral Analysis
%% ========================================================
function matricesgradution()
    % تحميل حزمة الرموز الرياضية لـ Octave
    if isunix || ismac || ispc
        try
            pkg load symbolic;
        catch
            % Already loaded or not needed in MATLAB
        end
    end
    
    clear; clc;

    % تقرير الجلسة
    sessionReport = {'--- PRO MATH ENGINE SESSION REPORT ---'; ...
                    ['Date: ', datestr(now)]; ...
                    '---------------------------------------'}; 
    keepRunning = true;

    fprintf('================================================\n');
    fprintf('        WELCOME TO THE ADVANCED MATH ENGINE      \n');
    fprintf('================================================\n');

    while keepRunning
        fprintf('\n[MAIN MENU]\n');
        fprintf('1. Matrix Operations (Arithmetic, Rank, Characteristic Analysis, etc.)\n');
        fprintf('2. Solve System AX = B (Detailed Steps)\n');
        fprintf('3. Theory of Equations (Roots Solving)\n');
        fprintf('4. EXIT & EXPORT FULL REPORT\n');
        
        choiceInput = input('>> Select Category (1-4): ', 's');
        mainChoice = str2double(choiceInput);
        
        if isnan(mainChoice)
            fprintf('!! Invalid Input: Please enter a NUMBER (1-4).\n');
            continue;
        end
        
        switch mainChoice
            case 1 % Matrix Operations
                A = input('>> Enter Matrix A: ');
                fprintf('\n--- Matrix Sub-Menu ---\n');
                fprintf('1. Addition (A+B)    2. Subtraction (A-B)    3. Multiplication (A*B)\n');
                fprintf('4. Inverse (A^-1)   5. Rank                  6. Gaussian Steps\n');
                fprintf('7. Full Characteristic Analysis (Matrix, Eq, & Eigenvalues)\n');
                op = input('>> Choice: ');
                
                if ismember(op, [1, 2, 3])
                    B = input('>> Enter Matrix B: ');
                    [res, steps] = performBasicOps(A, B, op);
                else
                    [res, steps] = performMatrixOp(A, op);
                end
                
                fprintf('\n--- Solution Steps ---\n%s\n', steps);
                if ~isempty(res)
                    fprintf('Resulting Matrix/Value:\n'); disp(res); 
                end
                sessionReport = [sessionReport; {'Matrix Operation Path'}; {steps}; {'----------------'}]; %#ok<AGROW>

            case 2 % Solve System AX = B
                fprintf('\n--- Solving System AX = B (Step-by-Step) ---\n');
                A = input('>> Enter Coefficient Matrix A: ');
                B = input('>> Enter Constants Vector B: ');
                [X, steps] = solveSystemWithDetails(A, B);
                fprintf('\n--- Solution Steps ---\n%s\n', steps);
                if ~isempty(X), fprintf('Solution Vector X:\n'); disp(X); end
                sessionReport = [sessionReport; {'Solving Linear System AX=B'}; {steps}; {'----------------'}]; %#ok<AGROW>

            case 3 % Theory of Equations
                fprintf('\n--- Theory of Equations ---\n');
                eqStr = input('>> Enter Equation (e.g., x^2 - 5*x + 6): ', 's');
                [sol, steps] = solveSymbolicEq(eqStr);
                fprintf('\n--- Theory Steps ---\n%s\n', steps);
                if ~isempty(sol), fprintf('Roots:\n'); disp(sol); end
                sessionReport = [sessionReport; {['Equation Solving: ', eqStr]}; {steps}; {'----------------'}]; %#ok<AGROW>

            case 4 % Exit and Export
                keepRunning = false;
                fileName = input('>> Enter Report Name (e.g., Alaa_Project.txt): ', 's');
                % Note: writing to txt/ascii in Octave to avoid Excel dependency issues in Docker
                try
                    save('-ascii', fileName, 'sessionReport');
                    fprintf('Success! Full session exported to %s.\n', fileName);
                catch
                    fprintf('Note: Export requires additional packages. Session ended.\n');
                end
                
            otherwise
                fprintf('Invalid selection. Please try again.\n');
        end
    end
end

%% --- Basic Ops ---
function [res, steps] = performBasicOps(A, B, op)
    res = []; steps = '';
    szA = size(A); szB = size(B);
    switch op
        case 1 % Addition
            if isequal(szA, szB)
                res = A + B;
                steps = sprintf('Steps: 1. Validated dimensions (%dx%d). 2. Performed element-wise addition.', szA(1), szA(2));
            else
                steps = 'Error: Matrices must have identical dimensions for Addition.';
            end
        case 2 % Subtraction
            if isequal(szA, szB)
                res = A - B;
                steps = sprintf('Steps: 1. Validated dimensions (%dx%d). 2. Performed element-wise subtraction.', szA(1), szA(2));
            else
                steps = 'Error: Matrices must have identical dimensions for Subtraction.';
            end
        case 3 % Multiplication
            if szA(2) == szB(1)
                res = A * B;
                steps = sprintf('Steps: 1. Verified inner dimensions (%d = %d). 2. Computed matrix product.', szA(2), szB(1));
            else
                steps = 'Error: Columns of A must equal rows of B for Multiplication.';
            end
    end
end

%% --- Matrix Ops ---
function [res, steps] = performMatrixOp(A, op)
    [r, c] = size(A); steps = ''; res = [];
    syms L % lambda
    switch op
        case 4 % Inverse
            if r == c && det(A) ~= 0
                res = inv(A); 
                steps = sprintf('Steps: 1. Verified square matrix. 2. Calculated determinant (|A| = %.2f).\n', det(A));
                steps = [steps, '3. Matrix Inversion completed.'];
            else
                steps = 'Error: Matrix is singular (Det=0) or not square.';
            end
        case 5 % Rank
            res = rank(A);
            steps = sprintf('Steps: 1. Transformed to REF. 2. Counted independent rows. Rank = %d', res);
        case 6 % Gaussian Steps
            tempA = A; steps = 'Gaussian Elimination Progress:\n';
            for i = 1:min(r,c)
                pivot = tempA(i,i);
                steps = [steps, sprintf('- Pivot at (%d,%d)=%.2f\n', i, i, pivot)]; 
                for j = i+1:r
                    factor = tempA(j,i)/pivot;
                    tempA(j,:) = tempA(j,:) - factor * tempA(i,:);
                    steps = [steps, sprintf('  R%d = R%d - (%.2f)R%d\n', j, j, factor, i)]; 
                end
            end
            res = tempA;
        case 7 % Characteristic Analysis
            if r == c
                charMatrix = A - L*eye(r);
                charEq = det(charMatrix);
                eigenVals = solve(charEq == 0, L);
                res = charMatrix;
                steps = sprintf('--- Full Characteristic Analysis ---\n');
                steps = [steps, sprintf('Step 1: Formed Characteristic Matrix (A - L*I)\n')];
                steps = [steps, sprintf('Step 2: Derived Characteristic Equation |A - L*I| = 0\n')];
                steps = [steps, sprintf('Step 3: Calculated Eigenvalues (Roots of the equation)')];
            else
                steps = 'Error: Characteristic analysis is only applicable to square matrices.';
            end
    end
end

%% --- Solve AX=B ---
function [X, steps] = solveSystemWithDetails(A, B)
    [r, c] = size(A);
    steps = 'Method: Direct Solver\n';
    if r == c && det(A) ~= 0
        X = A\B;
        steps = [steps, sprintf('1. Matrix A is %dx%d.\n2. Determinant is %.2f.\n3. Found unique solution vector X.', r, c, det(A))];
    else
        X = []; steps = [steps, 'Error: System has no unique solution.'];
    end
end

%% --- Symbolic Solve ---
function [sol, steps] = solveSymbolicEq(eqStr)
    syms x
    try
        cleanEq = strrep(eqStr, '=0', '');
        eqn = str2sym(cleanEq); % استخدام str2sym بدلاً من eval لدواعي الأمان والتوافق مع Octave
        sol = solve(eqn == 0, x);
        steps = sprintf('Steps: 1. Defined sym x. 2. Set expression %s to zero. 3. Calculated roots.', char(eqn));
    catch
        sol = []; steps = 'Error: Invalid syntax.';
    end
end
