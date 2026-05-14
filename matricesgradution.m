%% ========================================================
%% PROJECT: ADVANCED MATHEMATICAL ENGINE (COMPREHENSIVE VERSION)
%% DEVELOPER: ALAA 
%% DESCRIPTION: Matrix Ops, Linear Systems, and Spectral Analysis
%% ========================================================
function matricesgradution()
    % تحميل حزمة الرموز الرياضية
    if isunix || ismac || ispc
        try
            pkg load symbolic;
        catch
        end
    end
    
    format short g; 
    clear; clc;

    % --- تعريف الألوان ---
    c_red = '\033[1;31m';
    c_green = '\033[1;32m';
    c_blue = '\033[1;34m';
    c_cyan = '\033[1;36m';
    c_yellow = '\033[1;33m';
    c_reset = '\033[0m';
    % -----------------------------------------

    sessionReport = {'--- PRO MATH ENGINE SESSION REPORT ---'; ...
                    ['Date: ', datestr(now)]; ...
                    '---------------------------------------'}; 
    keepRunning = true;

    while keepRunning
        clc; 
        
        fprintf('%s', c_cyan);
        fprintf('  __  __       _   _      ______             _            \n');
        fprintf(' |  \\/  |     | | | |    |  ____|           (_)           \n');
        fprintf(' | \\  / | __ _| |_| |__  | |__   _ __   __ _ _ _ __   ___ \n');
        fprintf(' | |\\/| |/ _` | __| ''_ \\ |  __| | ''_ \\ / _` | | ''_ \\ / _ \\\n');
        fprintf(' | |  | | (_| | |_| | | || |____| | | | (_| | | | | |  __/\n');
        fprintf(' |_|  |_|\\__,_|\\__|_| |_||______|_| |_|\\__, |_|_| |_|\\___|\n');
        fprintf('                                        __/ |             \n');
        fprintf('                                       |___/              \n');
        fprintf('%s', c_reset);
        fprintf('%s==========================================================%s\n', c_blue, c_reset);
        fprintf('%s          ADVANCED MATHEMATICAL ENGINE - PRO CLI          %s\n', c_yellow, c_reset);
        fprintf('%s==========================================================%s\n', c_blue, c_reset);

        fprintf('\n%s[MAIN MENU]%s\n', c_green, c_reset);
        fprintf('1. Matrix Operations (Arithmetic, Rank, Characteristic Analysis, etc.)\n');
        fprintf('2. Solve System AX = B (Detailed Steps)\n');
        fprintf('3. Theory of Equations (Roots Solving & Graphing)\n');
        fprintf('4. EXIT & PRINT FULL REPORT\n');
        
        choiceInput = input(sprintf('\n%s>> Select Category (1-4): %s', c_cyan, c_reset), 's');
        mainChoice = str2double(choiceInput);
        
        if isnan(mainChoice)
            fprintf('%s!! Invalid Input: Please enter a NUMBER (1-4).%s\n', c_red, c_reset);
            pauseReturn();
            continue;
        end
        
        switch mainChoice
            case 1 
                fprintf('\n%s--- Matrix Operations ---%s\n', c_blue, c_reset);
                A = input(sprintf('%s>> Enter Matrix A (e.g., [1 2; 3 4]): %s', c_yellow, c_reset));
                fprintf('\n%s[Matrix Sub-Menu]%s\n', c_green, c_reset);
                fprintf('1. Addition (A+B)    2. Subtraction (A-B)    3. Multiplication (A*B)\n');
                fprintf('4. Inverse (A^-1)   5. Rank                  6. Gaussian Steps\n');
                fprintf('7. Full Characteristic Analysis (Matrix, Eq, & Eigenvalues)\n');
                op = input(sprintf('%s>> Choice: %s', c_cyan, c_reset));
                
                if ismember(op, [1, 2, 3])
                    B = input(sprintf('%s>> Enter Matrix B: %s', c_yellow, c_reset));
                    [res, steps] = performBasicOps(A, B, op);
                else
                    [res, steps] = performMatrixOp(A, op);
                end
                
                fprintf('\n%s--- Solution Steps ---%s\n%s\n', c_blue, c_reset, steps);
                if ~isempty(res)
                    fprintf('%sResulting Matrix/Value:%s\n', c_green, c_reset); disp(res); 
                end
                sessionReport = [sessionReport; {'Matrix Operation Path'}; {steps}; {'----------------'}]; %#ok<AGROW>
                pauseReturn();

            case 2 
                fprintf('\n%s--- Solving System AX = B ---%s\n', c_blue, c_reset);
                A = input(sprintf('%s>> Enter Coefficient Matrix A: %s', c_yellow, c_reset));
                B = input(sprintf('%s>> Enter Constants Vector B: %s', c_yellow, c_reset));
                [X, steps] = solveSystemWithDetails(A, B);
                
                fprintf('\n%s--- Solution Steps ---%s\n%s\n', c_blue, c_reset, steps);
                if ~isempty(X)
                    fprintf('%sSolution Vector X:%s\n', c_green, c_reset); disp(X); 
                end
                sessionReport = [sessionReport; {'Solving Linear System AX=B'}; {steps}; {'----------------'}]; %#ok<AGROW>
                pauseReturn();

            case 3 
                fprintf('\n%s--- Theory of Equations ---%s\n', c_blue, c_reset);
                eqStr = input(sprintf('%s>> Enter Equation (e.g., x^2 - 5*x + 6): %s', c_yellow, c_reset), 's');
                [sol, steps] = solveSymbolicEq(eqStr);
                
                fprintf('\n%s--- Theory Steps ---%s\n%s\n', c_blue, c_reset, steps);
                if ~isempty(sol)
                    fprintf('%sRoots:%s\n', c_green, c_reset); disp(sol); 
                    plotAscii(eqStr); % رسم المعادلة
                end
                sessionReport = [sessionReport; {['Equation Solving: ', eqStr]}; {steps}; {'----------------'}]; %#ok<AGROW>
                pauseReturn();

            case 4 
                keepRunning = false;
                clc;
                fprintf('\n%s================================================%s\n', c_green, c_reset);
                fprintf('%s               FINAL SESSION REPORT               %s\n', c_yellow, c_reset);
                fprintf('%s================================================%s\n\n', c_green, c_reset);
                
                for i = 1:length(sessionReport)
                    fprintf('%s\n', char(sessionReport{i}));
                end
                
                fprintf('\n%s================================================%s\n', c_green, c_reset);
                fprintf('%sNOTE: Please SELECT and COPY the text above to save your report.%s\n', c_cyan, c_reset);
                fprintf('%sSession ended. Thank you!%s\n', c_yellow, c_reset);
                
            otherwise
                fprintf('%sInvalid selection. Please try again.%s\n', c_red, c_reset);
                pauseReturn();
        end
    end
end

%% --- Helper Function for UX Pause ---
function pauseReturn()
    input(sprintf('\n\033[1;33mPress [Enter] to return to the Main Menu...\033[0m'), 's');
end

%% --- ASCII Plotter ---
function plotAscii(eqStr)
    try
        fprintf('\n\033[1;36m--- ASCII Graph (x from -10 to 10) ---\033[0m\n');
        cleanEq = lower(strrep(eqStr, '=0', ''));
        vecEq = vectorize(cleanEq); 
        
        x = linspace(-10, 10, 50); 
        y = eval(vecEq); 
        
        if length(y) == 1
            y = y * ones(1, 50);
        end
        
        rows = 15; cols = 50;
        grid = repmat(' ', rows, cols);
        
        x_row = round(rows/2);
        y_col = round(cols/2);
        grid(x_row, :) = '-';
        grid(:, y_col) = '|';
        grid(x_row, y_col) = '+';
        
        min_y = min(y); max_y = max(y);
        if max_y == min_y, max_y = min_y + 1; min_y = min_y - 1; end
        
        for i = 1:cols
            r = round(1 + (rows - 1) * (max_y - y(i)) / (max_y - min_y));
            r = max(1, min(rows, r));
            grid(r, i) = '*';
        end
        
        for r = 1:rows
            fprintf('\033[1;32m%s\033[0m\n', grid(r,:));
        end
    catch
        fprintf('\033[1;31m[Graph unavailable for this equation]\033[0m\n');
    end
end

%% --- Basic Ops ---
function [res, steps] = performBasicOps(A, B, op)
    res = []; steps = '';
    szA = size(A); szB = size(B);
    switch op
        case 1
            if isequal(szA, szB), res = A + B; steps = sprintf('Steps: 1. Validated dimensions (%dx%d). 2. Performed element-wise addition.', szA(1), szA(2));
            else, steps = 'Error: Matrices must have identical dimensions for Addition.'; end
        case 2
            if isequal(szA, szB), res = A - B; steps = sprintf('Steps: 1. Validated dimensions (%dx%d). 2. Performed element-wise subtraction.', szA(1), szA(2));
            else, steps = 'Error: Matrices must have identical dimensions for Subtraction.'; end
        case 3
            if szA(2) == szB(1), res = A * B; steps = sprintf('Steps: 1. Verified inner dimensions (%d = %d). 2. Computed matrix product.', szA(2), szB(1));
            else, steps = 'Error: Columns of A must equal rows of B for Multiplication.'; end
    end
end

%% --- Matrix Ops ---
function [res, steps] = performMatrixOp(A, op)
    [r, c] = size(A); steps = ''; res = [];
    syms L
    switch op
        case 4
            if r == c && det(A) ~= 0
                res = inv(A); res(abs(res) < 1e-10) = 0; 
                steps = sprintf('Steps: 1. Verified square matrix. 2. Calculated determinant (|A| = %.2f).\n3. Matrix Inversion completed.', det(A));
            else, steps = 'Error: Matrix is singular (Det=0) or not square.'; end
        case 5
            res = rank(A); steps = sprintf('Steps: 1. Transformed to REF. 2. Counted independent rows. Rank = %d', res);
        case 6
            tempA = A; steps = 'Gaussian Elimination Progress:\n';
            for i = 1:min(r,c)
                pivot = tempA(i,i); steps = [steps, sprintf('- Pivot at (%d,%d)=%.2f\n', i, i, pivot)]; 
                for j = i+1:r
                    factor = tempA(j,i)/pivot; tempA(j,:) = tempA(j,:) - factor * tempA(i,:); tempA(abs(tempA) < 1e-10) = 0; 
                    steps = [steps, sprintf('  R%d = R%d - (%.2f)R%d\n', j, j, factor, i)]; 
                end
            end
            res = tempA;
        case 7
            if r == c
                charMatrix = A - L*eye(r); charEq = det(charMatrix); eigenVals = solve(charEq == 0, L); res = charMatrix;
                steps = sprintf('--- Full Characteristic Analysis ---\nStep 1: Formed Characteristic Matrix (A - L*I)\nStep 2: Derived Characteristic Equation |A - L*I| = 0\nStep 3: Calculated Eigenvalues (Roots)');
            else, steps = 'Error: Characteristic analysis is only applicable to square matrices.'; end
    end
end

%% --- Solve AX=B ---
function [X, steps] = solveSystemWithDetails(A, B)
    [r, c] = size(A); steps = 'Method: Direct Solver\n';
    if r == c && det(A) ~= 0
        X = A\B; X(abs(X) < 1e-10) = 0; 
        steps = [steps, sprintf('1. Matrix A is %dx%d.\n2. Determinant is %.2f.\n3. Found unique solution vector X.', r, c, det(A))];
    else, X = []; steps = [steps, 'Error: System has no unique solution.']; end
end

%% --- Symbolic Solve ---
function [sol, steps] = solveSymbolicEq(eqStr)
    syms x
    try
        cleanEq = lower(strrep(eqStr, '=0', '')); eqn = eval(cleanEq); sol = solve(eqn == 0, x);
        steps = sprintf('Steps: 1. Defined sym x. 2. Set expression %s to zero. 3. Calculated roots.', char(eqn));
    catch ME
        sol = []; steps = sprintf('Error: %s\n', ME.message); 
    end
end
