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
    
    format short g; 
    clear; clc;

    % --- تعريف الألوان ---
    global c_red c_green c_blue c_cyan c_yellow c_reset;
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
    mem = struct(); % الذاكرة الخاصة بالمستخدم
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
        fprintf('1. Matrix Operations (Arithmetic, Rank, Characteristic Analysis)\n');
        fprintf('2. Solve System AX = B (Detailed Steps)\n');
        fprintf('3. Theory of Equations (Roots Solving & Graphing)\n');
        fprintf('4. View Workspace Memory (Saved Matrices)\n');
        fprintf('5. EXIT & PRINT FULL REPORT\n');
        
        % فصلنا الطباعة عن الإدخال لضمان عمل الألوان بشكل مثالي
        fprintf('\n%s>> Select Category (1-5): %s', c_cyan, c_reset);
        choiceInput = input('', 's');
        mainChoice = str2double(choiceInput);
        
        if isnan(mainChoice) || ~ismember(mainChoice, 1:5)
            fprintf('%s!! Invalid Input: Please enter a NUMBER (1-5).%s\n', c_red, c_reset);
            pauseReturn();
            continue;
        end
        
        switch mainChoice
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
                        fprintf('%s>> Choice (1-7): %s', c_cyan, c_reset);
                        opStr = input('', 's');
                        op = str2double(opStr);
                        if ismember(op, 1:7), validOp = true;
                        else, fprintf('%s!! Invalid Choice. Enter a number between 1 and 7.%s\n', c_red, c_reset); end
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
                            fprintf('%sResulting Matrix/Value:%s\n', c_green, c_reset); disp(res); 
                            mem = promptSaveToMemory(mem, res);
                        end
                        sessionReport = [sessionReport; {'Matrix Operation Path'}; {steps}; {'----------------'}]; %#ok<AGROW>
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
                            fprintf('%sSolution Vector X:%s\n', c_green, c_reset); disp(X); 
                            mem = promptSaveToMemory(mem, X);
                        end
                        sessionReport = [sessionReport; {'Solving Linear System AX=B'}; {steps}; {'----------------'}]; %#ok<AG
