%% ========================================================
%% PROJECT: ADVANCED MATHEMATICAL ENGINE (WEB/CLOUD CLI)
%% DEVELOPER: ALAA 
%% DESCRIPTION: Matrix Ops, Linear Systems, Spectral Analysis & Memory
%% ========================================================
function matricesgradution()
    % تحميل حزمة الرموز الرياضية
    if isunix || ismac || ispc
        try
            pkg load symbolic;
        catch
        end
    end
    
    warning('off', 'all'); 
    format short g; 
    clear; clc;

    % --- تعريف الألوان ---
    global c_red c_green c_blue c_cyan c_yellow c_reset;
    c_red = sprintf('\033[1;31m');
    c_green = sprintf('\033[1;32m');
    c_blue = sprintf('\033[1;34m');
    c_cyan = sprintf('\033[1;36m');
    c_yellow = sprintf('\033[1;33m');
    c_reset = sprintf('\033[0m');
    % -----------------------------------------

    sessionReport = {'--- PRO MATH ENGINE SESSION REPORT ---'; ...
                    ['Date: ', datestr(now)]; ...
                    '---------------------------------------'}; 
    mem = struct(); 
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
        fprintf('0. [HELP & TUTORIAL] - Read before using!\n');
        fprintf('1. Matrix Operations (Arithmetic, Rank, Characteristic Analysis)\n');
        fprintf('2. Solve System AX = B (Detailed Steps)\n');
        fprintf('3. Theory of Equations (Roots Solving & Graphing)\n');
        fprintf('4. View Workspace Memory (Saved Matrices)\n');
        fprintf('5. EXIT & PRINT FULL REPORT\n');
        
        choiceInput = promptUserInput(sprintf('\n%s>> Select Category (0-5): %s', c_cyan, c_reset));
        mainChoice = str2double(choiceInput);
        
        if isnan(mainChoice) || ~ismember(mainChoice, 0:5)
            fprintf('%s!! Invalid Input: Please enter a NUMBER (0-5).%s\n', c_red, c_reset);
            pauseReturn();
            continue;
        end
        
        switch mainChoice
            case 0 % --- Help & Tutorial ---
                clc;
                fprintf('\n%s==========================================================%s\n', c_blue, c_reset);
                fprintf('%s                  ENGINE HELP & TUTORIAL                  %s\n', c_yellow, c_reset);
                fprintf('%s==========================================================%s\n\n', c_blue, c_reset);
                
                fprintf('%s[1] How to enter Matrices:%s\n', c_green, c_reset);
                fprintf('  - Enclose in square brackets: [ ]\n');
                fprintf('  - Separate elements in a row with spaces: 1 2 3\n');
                fprintf('  - Separate rows with a semicolon: ;\n');
                fprintf('  - Example: [1 2; 3 4] creates a 2x2 matrix.\n\n');
                
                fprintf('%s[2] How to enter Equations:%s\n', c_green, c_reset);
                fprintf('  - Use ''x'' as the variable.\n');
                fprintf('  - MUST use ''*'' for multiplication! (e.g., 5*x NOT 5x)\n');
                fprintf('  - Use ''^'' for powers (e.g., x^2).\n');
                fprintf('  - Do NOT include ''=0''. Just type the expression.\n');
                fprintf('  - Example: x^2 - 5*x + 6\n\n');
                
                fprintf('%s[3] How to use Workspace Memory:%s\n', c_green, c_reset);
                fprintf('  - After any operation, you can save the result.\n');
                fprintf('  - Give it a valid name (letters/numbers, e.g., M1, ansA).\n');
                fprintf('  - Next time the engine asks for a matrix, just type M1!\n\n');
                
                pauseReturn();

            case 1 
                stayInCategory = true;
                while stayInCategory
                    clc;
                    fprintf('\n%s--- Matrix Operations ---%s\n', c_blue, c_reset);
                    promptA = sprintf('%s>> Enter Matrix A (e.g., [1 2; 3 4] or Saved Name): %s', c_yellow, c_reset);
                    A = getRobustMatrixInput(promptA, mem);
                    
                    fprintf('\n%s[Matrix Sub-Menu]%s\n', c_green, c_reset);
                    fprintf('1. Addition (A+B)    2. Subtraction (A-B)    3. Multiplication (A*B)\n');
                    fprintf('4. Inverse (A^-1)   5. Rank                  6. Gaussian Steps\n');
                    fprintf('7. Full Characteristic Analysis (Matrix, Eq, & Eigenvalues)\n');
                    
                    validOp = false;
                    while ~validOp
                        opStr = promptUserInput(sprintf('%s>> Choice (1-7): %s', c_cyan, c_reset));
                        op = str2double(opStr);
                        if ismember(op, 1:7)
                            validOp = true;
                        else
                            fprintf('%s!! Invalid Choice. Enter a number between 1 and 7.%s\n', c_red, c_reset); 
                        end
                    end
                    
                    if ismember(op, [1, 2, 3])
                        promptB = sprintf('%s>> Enter Matrix B (or Saved Name): %s', c_yellow, c_reset);
                        B = getRobustMatrixInput(promptB, mem);
                        [res, steps] = performBasicOps(A, B, op);
                    else
                        [res, steps] = performMatrixOp(A, op);
                    end
                    
                    if strncmp(steps, 'Error', 5)
                        fprintf('\n%s%s%s\n', c_red, steps, c_reset);
                    else
                        fprintf('\n%s--- Solution Steps ---%s\n%s\n', c_blue, c_reset, steps);
                        if ~isempty(res)
                            fprintf('%sResulting Matrix/Value:%s\n', c_green, c_reset); 
                            disp(res); 
                            mem = promptSaveToMemory(mem, res);
                        end
                        sessionReport = [sessionReport; {'Matrix Operation Path'}; {steps}; {'----------------'}];
                    end
                    stayInCategory = postOperationMenu();
                end

            case 2 
                stayInCategory = true;
                while stayInCategory
                    clc;
                    fprintf('\n%s--- Solving System AX = B ---%s\n', c_blue, c_reset);
                    promptA = sprintf('%s>> Enter Coefficient Matrix A (or Saved Name): %s', c_yellow, c_reset);
                    A = getRobustMatrixInput(promptA, mem);
                    
                    promptB = sprintf('%s>> Enter Constants Vector B (or Saved Name): %s', c_yellow, c_reset);
                    B = getRobustMatrixInput(promptB, mem);
                    
                    [X, steps] = solveSystemWithDetails(A, B);
                    
                    if strncmp(steps, 'Error', 5)
                        fprintf('\n%s%s%s\n', c_red, steps, c_reset);
                    else
                        fprintf('\n%s--- Solution Steps ---%s\n%s\n', c_blue, c_reset, steps);
                        if ~isempty(X)
                            fprintf('%sSolution Vector X:%s\n', c_green, c_reset); 
                            disp(X); 
                            mem = promptSaveToMemory(mem, X);
                        end
                        sessionReport = [sessionReport; {'Solving Linear System AX=B'}; {steps}; {'----------------'}];
                    end
                    stayInCategory = postOperationMenu();
                end

            case 3 
                stayInCategory = true;
                while stayInCategory
                    clc;
                    fprintf('\n%s--- Theory of Equations ---%s\n', c_blue, c_reset);
                    eqStr = promptUserInput(sprintf('%s>> Enter Equation (e.g., x^2 - 5*x + 6): %s', c_yellow, c_reset));
                    
                    [sol, steps] = solveSymbolicEq(eqStr);
                    
                    if strncmp(steps, 'Error', 5)
                        fprintf('\n%s%s%s\n', c_red, steps, c_reset);
                    else
                        fprintf('\n%s--- Theory Steps ---%s\n%s\n', c_blue, c_reset, steps);
                        if ~isempty(sol)
                            fprintf('%sRoots:%s\n', c_green, c_reset); 
                            disp(sol); 
                            plotAscii(eqStr); 
                        end
                        sessionReport = [sessionReport; {['Equation Solving: ', eqStr]}; {steps}; {'----------------'}];
                    end
                    stayInCategory = postOperationMenu();
                end

            case 4 
                clc;
                fprintf('\n%s--- Workspace Memory (Saved Matrices) ---%s\n', c_blue, c_reset);
                fields = fieldnames(mem);
                if isempty(fields)
                    fprintf('%sMemory is currently empty. Try saving a result first!%s\n', c_yellow, c_reset);
                else
                    for k = 1:numel(fields)
                        fprintf('%s>> Variable: [%s]%s\n', c_green, fields{k}, c_reset);
                        disp(mem.(fields{k}));
                    end
                end
                pauseReturn();

            case 5 
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
        end
    end
end

%% --- HELPER: COLOR PROMPT WITH FLUSH ---
function str = promptUserInput(promptText)
    fprintf('%s', promptText);
    fflush(stdout); 
    str = strtrim(input('', 's'));
end

%% --- ROBUST INPUT HELPER (WITH MEMORY) ---
function M = getRobustMatrixInput(promptText, mem)
    global c_red c_green c_reset;
    while true
        str = promptUserInput(promptText);
        if isempty(str)
            continue; 
        end
        
        if isfield(mem, str)
            M = mem.(str);
            fprintf('%s--> Loaded [%s] from memory successfully.%s\n', c_green, str, c_reset);
            break;
        end
        
        try
            M = eval(str);
            if isnumeric(M) || islogical(M)
                break;
            else
                fprintf('%s!! Error: Input must be a numerical matrix. Try again.%s\n', c_red, c_reset);
            end
        catch
            fprintf('%s!! Syntax Error or Unknown Variable. Try again.%s\n', c_red, c_reset);
        end
    end
end

%% --- MEMORY SAVE HELPER ---
function mem = promptSaveToMemory(mem, data)
    global c_cyan c_green c_red c_reset;
    saveName = promptUserInput(sprintf('\n%s>> Save this result to memory? (Enter name like M1, or press [Enter] to skip): %s', c_cyan, c_reset));
    if ~isempty(saveName)
        if isvarname(saveName)
            mem.(saveName) = data;
            fprintf('%s--> Result successfully saved as [%s] in memory.%s\n', c_green, saveName, c_reset);
        else
            fprintf('%s!! Invalid variable name. Not saved.%s\n', c_red, c_reset);
        end
    end
end

%% --- POST-OPERATION MENU HELPER ---
function stay = postOperationMenu()
    global c_cyan c_yellow c_red c_reset;
    while true
        fprintf('\n%s[What would you like to do next?]%s\n', c_cyan, c_reset);
        fprintf('1. Return to MAIN MENU\n');
        fprintf('2. Go back ONE STEP (Retry or New Operation)\n');
        c = promptUserInput(sprintf('%s>> Choice (1-2): %s', c_yellow, c_reset));
        
        if strcmp(c, '1')
            stay = false; 
            break;
        elseif strcmp(c, '2')
            stay = true; 
            break;
        else
            fprintf('%s!! Invalid choice. Enter 1 or 2.%s\n', c_red, c_reset);
        end
    end
end

%% --- Helper Function for UX Pause ---
function pauseReturn()
    promptUserInput(sprintf('\n\033[1;33mPress [Enter] to return to the Main Menu...\033[0m'));
end

%% --- ASCII Plotter (FIXED MATH GRAPH) ---
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
        
        rows = 15; 
        cols = 50; 
        grid = repmat(' ', rows, cols);
        
        min_y = min(y); 
        max_y = max(y);
        
        if max_y == min_y
            max_y = min_y + 1; 
            min_y = min_y - 1; 
        end
        
        y_col = round(cols/2);
        grid(:, y_col) = '|'; % Y-axis
        
        zero_row = round(1 + (rows - 1) * (max_y - 0) / (max_y - min_y));
        if zero_row >= 1 && zero_row <= rows
            grid(zero_row, :) = '-';
            grid(zero_row, y_col) = '+'; % Origin
        end
        
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
    res = []; 
    steps = ''; 
    szA = size(A); 
    szB = size(B);
    
    switch op
        case 1
            if isequal(szA, szB)
                res = A + B; 
                steps = sprintf('Steps: 1. Validated dimensions (%dx%d). 2. Performed element-wise addition.', szA(1), szA(2));
            else
                steps = 'Error: Matrices must have identical dimensions for Addition.'; 
            end
        case 2
            if isequal(szA, szB)
                res = A - B; 
                steps = sprintf('Steps: 1. Validated dimensions (%dx%d). 2. Performed element-wise subtraction.', szA(1), szA(2));
            else
                steps = 'Error: Matrices must have identical dimensions for Subtraction.'; 
            end
        case 3
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
    [r, c] = size(A); 
    steps = ''; 
    res = []; 
    syms L
    
    switch op
        case 4
            if r == c && det(A) ~= 0
                res = inv(A); 
                res(abs(res) < 1e-10) = 0; 
                steps = sprintf('Steps: 1. Verified square matrix. 2. Calculated determinant (|A| = %.2f).\n3. Matrix Inversion completed.', det(A));
            else
                steps = 'Error: Matrix is singular (Det=0) or not square.'; 
            end
        case 5
            res = rank(A); 
            steps = sprintf('Steps: 1. Transformed to REF. 2. Counted independent rows. Rank = %d', res);
        case 6
            tempA = A; 
            steps = sprintf('Gaussian Elimination Progress:\n');
            for i = 1:min(r,c)
                pivot = tempA(i,i); 
                steps = [steps, sprintf('- Pivot at (%d,%d)=%.2f\n', i, i, pivot)]; 
                for j = i+1:r
                    factor = tempA(j,i)/pivot; 
                    tempA(j,:) = tempA(j,:) - factor * tempA(i,:); 
                    tempA(abs(tempA) < 1e-10) = 0; 
                    steps = [steps, sprintf('  R%d = R%d - (%.2f)R%d\n', j, j, factor, i)]; 
                end
            end
            res = tempA;
        case 7
            if r == c
                charMatrix = A - L*eye(r); 
                charEq = det(charMatrix); 
                eigenVals = solve(charEq == 0, L); 
                res = charMatrix;
                steps = sprintf('--- Full Characteristic Analysis ---\nStep 1: Formed Characteristic Matrix (A - L*I)\nStep 2: Derived Characteristic Equation |A - L*I| = 0\nStep 3: Calculated Eigenvalues (Roots)');
            else
                steps = 'Error: Characteristic analysis is only applicable to square matrices.'; 
            end
    end
end

%% --- Solve AX=B ---
function [X, steps] = solveSystemWithDetails(A, B)
    [r, c] = size(A); 
    steps = sprintf('Method: Direct Solver\n');
    
    if r == c && det(A) ~= 0
        X = A\B; 
        X(abs(X) < 1e-10) = 0; 
        steps = [steps, sprintf('1. Matrix A is %dx%d.\n2. Determinant is %.2f.\n3. Found unique solution vector X.', r, c, det(A))];
    else
        X = []; 
        steps = [steps, 'Error: System has no unique solution.']; 
    end
end

%% --- Symbolic Solve ---
function [sol, steps] = solveSymbolicEq(eqStr)
    syms x
    try
        cleanEq = lower(strrep(eqStr, '=0', '')); 
        eqn = eval(cleanEq); 
        sol = solve(eqn == 0, x);
        steps = sprintf('Steps: 1. Defined sym x. 2. Set expression %s to zero. 3. Calculated roots.', char(eqn));
    catch ME
        sol = []; 
        steps = sprintf('Error: %s\n', ME.message); 
    end
end
