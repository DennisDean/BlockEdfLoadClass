function testBlockEdfLoadClassDistribution
%testBlockEdfLoadClass Test BlockEdfLoadClass
%   Test  BlockEdfLoadClass.
%
%
% Version: 0.1.25
%
% ---------------------------------------------
% Dennis A. Dean, II, Ph.D
%
% Program for Sleep and Cardiovascular Medicine
% Brigam and Women's Hospital
% Harvard Medical School
% 221 Longwood Ave
% Boston, MA  02149
%
% File created: October 23, 2012
% Last update:  April 24, 2014 
%    
% Copyright © [2014] The Brigham and Women's Hospital, Inc.
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
% "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED 
% TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A 
% PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER 
% OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
% EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
% PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
% PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
% LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
% NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%

% Test Files
edfFn1 = 'test_generator_hiRes.edf';    % Generated data file
edfFn2 = 'edfCheckHeader1.edf';         % Inserted EDF Header Errors
edfFn3 = 'edfCheckSignalHeader1.edf';   % Inserted EDF Signal Header Errors
    
% Test flags
RUN_TEST_1 =  1;    % Test load/plot functionality
RUN_TEST_2 =  1;    % Evaluate Memory saving features
RUN_TEST_3 =  1;    % Use static function to identify EDF files
RUN_TEST_4 =  1;    % Control the number of components loaded (Signals Not Loaded)
RUN_TEST_5 =  1;    % Get edf file names from folder
RUN_TEST_6 =  1;    % Dependent variables provide direct access to signal labels and
                    %   sampling rate
RUN_TEST_7 =  1;    % EDF Checker  
RUN_TEST_8 =  1;    % Check flag to invert swapped signals


% ------------------------------------------------------------------ Test 1
% Test 1: Test functional form ()
if RUN_TEST_1 == 1
    % Write test results to console
    testID = 1;
    testStr = 'Test load/plot functionality';
    fprintf('----------------------------------------------------------\n');  
    fprintf('Test %.0f. %s\n\n', testID, testStr);
    
    % Open generated test file
    edfFn1 = edfFn1;
    belClass = BlockEdfLoadClass(edfFn1);
    
    % Check default load
    belClass = belClass.blockEdfLoad;
    edf = belClass.edf;
    header = belClass.edf.header;
    belClass.PrintEdfHeader;

    % Check class returns
    belClass = BlockEdfLoadClass(edfFn1);
    numArgOut = 2;
    belClass = belClass.blockEdfLoad(numArgOut);
    edf = belClass.edf;
 
    
    % Check original functional returns
    outArgClass = 0;
    numArgOut = 1; 
        header  = belClass.blockEdfLoad(numArgOut, outArgClass);
    numArgOut = 2; 
        [header signalHeader] = ...
            belClass.blockEdfLoad(numArgOut, outArgClass);
    numArgOut = 3; 
        [header signalHeader signalCell] = ...
            belClass.blockEdfLoad(numArgOut, outArgClass);
        
    % Check class output functions
    belClass = BlockEdfLoadClass(edfFn1);
    belClass = belClass.blockEdfLoad;
    belClass.PrintEdfHeader;
    belClass.PrintEdfSignalHeader;
    belClass = belClass.PlotEdfSignalStart;
    fid = belClass.fid;
end
% ------------------------------------------------------------------ Test 2
% Test 2: Load and plot generated file
if RUN_TEST_2 == 1
    % Write test results to console
    testID = 2;
    testStr = 'Evaluate Memory saving features';
    fprintf('----------------------------------------------------------\n');  
    fprintf('Test %.0f. %s\n\n', testID, testStr);
    
    % Open generated test file
    edfFn1 = edfFn1;
    signalLabels = {'yC4', 'yP3'};
    epochs = [1 4];

    % Object Overhead
    tic
        belClass0 = BlockEdfLoadClass(edfFn1);
    t0 = toc;
    
    % Check default load
    tic
        belClass1 = BlockEdfLoadClass(edfFn1);
        belClass1 = belClass1.blockEdfLoad;
    t1 = toc;
    
    % Check default load
    tic 
        belClass2 = BlockEdfLoadClass(edfFn1, signalLabels);
        belClass2 = belClass2.blockEdfLoad;
    t2 = toc;
    % Check default load
    tic
        belClass3 = BlockEdfLoadClass(edfFn1,signalLabels, epochs);
        belClass3 = belClass3.blockEdfLoad;
    t3 = toc;    

    % Determine Memory Requirement
    w0 = whos('belClass0');
    w1 = whos('belClass1');
    w2 = whos('belClass2');
    w3 = whos('belClass3');
    
    % Check class returns
    fprintf('                 Constructor Return: T0 = %.2f seconds, M0 = %.0f mB\n',t0, w0.bytes/1024/1024);
    fprintf('                        Load Return: T1 = %.2f seconds, M1 = %.0f mB\n',t1, w1.bytes/1024/1024);
    fprintf('               Load 2 signal return: T2 = %.2f seconds, M2 = %.2f mB\n',t2, w2.bytes/1024/1024);
    fprintf(' Load 2 signals and specific epochs: T3 = %.2f seconds, M3 = %.2f %%\n\n',t3, w3.bytes/1024/1024);    
    fprintf('            Signal Memory Reduction: M2 = %.2f %%\n', 100*(1-w2.bytes/w1.bytes));
    fprintf('             Epoch Memory Reduction: M3 = %.2f %%\n', 100*(1-w3.bytes/w1.bytes));
end
% ------------------------------------------------------------------ Test 3
% Test 3: Identify EDF files with static function
if RUN_TEST_3 == 1
    % Write test results to console
    testID = 3;
    testStr = 'Identify EDF files with static function';
    fprintf('----------------------------------------------------------\n');  
    fprintf('Test %.0f. %s\n\n', testID, testStr);
    
    % Set target search folder
    folder = cd;
    
    % Test file list access options call options.
    fileListCellwLabels = BlockEdfLoadClass.GetEdfFileListInfo(folder);
    
    % Echo status to console
    fprintf('Returned file structure:\n');
    disp(fileListCellwLabels);
    
    % Write output to default file
    BlockEdfLoadClass.GetEdfFileListInfo(folder);
    fprintf('Edf file information written to excel file: edfFileList.xls\n');
    
    % User selected folder.
    fprintf('\n\nInteractive option for user selected folder: Select folder to search\n');
    fileListCellwLabels = BlockEdfLoadClass.GetEdfFileListInfo;
    fprintf('Returned file structure:\n');
    disp(fileListCellwLabels);
end
% ------------------------------------------------------------------ Test 4
% Test 4: Control the number of components loaded (Signals Not Loaded)
if RUN_TEST_4 == 1
    % Write test results to console
    testID = 4;
    testStr = 'Control the number of components loaded (Signals Not Loaded)';
    fprintf('----------------------------------------------------------\n');  
    fprintf('Test %.0f. %s\n\n', testID, testStr);
    
    % Record time to access files
    tic 
    
    fprintf('Display signal labels from: %s\n', edfFn1);
    edfObj = BlockEdfLoadClass(edfFn1);
    edfObj.numCompToLoad = 2;   % Don't return object
    edfObj = edfObj.blockEdfLoad;
    
    % Display signal labels (crude)
    signal_labels = edfObj.edf.signalHeader.signal_labels;
    labelStr = sprintf('{ %s,', edfObj.edf.signalHeader(1).signal_labels);
    for s = 2:length(labelStr)-1
        labelStr = sprintf('%s %s,', labelStr, ...
            edfObj.edf.signalHeader(2).signal_labels);
    end
    labelStr = sprintf('%s %s }', labelStr, edfObj.edf.signalHeader(end).signal_labels);
    fprintf('\tSignal Labels: %s\n', labelStr);
end
% ------------------------------------------------------------------ Test 5
% Test 5: Get edf file names from folder
% GetEdfFileListInfo
if RUN_TEST_5 == 1
    % Write test results to console
    testID = 5;
    testStr = 'Get edf file names from folder)';
    fprintf('----------------------------------------------------------\n');  
    fprintf('Test %.0f. %s\n\n', testID, testStr);
    
    % Echo to console  
    fprintf('Get file list for current folder\n');
    
    % Load file list from folder
    folder = cd;
    fileListCellwLabels = BlockEdfLoadClass.GetEdfFileList(folder);
    [fileListCellwLabels edfFn] = BlockEdfLoadClass.GetEdfFileList(folder);

    % Echo results to console
    fprintf('File in current folder:\n');
    for f = 1: length(edfFn);
        fprintf('\t%s\n', edfFn{f});    
    end
end
% ------------------------------------------------------------------ Test 6
% Test 6: Dependent variables provide direct access to signal labels and
%         sampling rate
if RUN_TEST_6 == 1
    % Write test results to console
    testID = 6;
    testStr = 'Dependent variables provide direct access to signal labels and sampling rate';
    fprintf('----------------------------------------------------------\n');  
    fprintf('Test %.0f. %s\n\n', testID, testStr);
    
    % Record time to access files
    fprintf('Display signal labels from:\n', edfFn1);
    edfObj = BlockEdfLoadClass(edfFn1);
    edfObj.numCompToLoad = 2;   % Don't return object
    edfObj = edfObj.blockEdfLoad;
    
    % Display signal labels (crude)
    signal_labels = edfObj.signal_labels;
    sampling_rate = edfObj.sample_rate;
    
    % Display results
    fprintf('signal_labels:\n');disp(signal_labels);
    fprintf('sampling_rate:\n');disp(sampling_rate);
    fprintf('See ''Dependent Property'' class section for my direct access variables\n');
end
% ------------------------------------------------------------------ Test 7
% Test 7: Load and plot generated file
if RUN_TEST_7 == 1
    % Write test results to console
    testID = 7;
    testStr = 'Dependent variables provide direct access to signal labels and sampling rate';
    fprintf('----------------------------------------------------------\n');  
    fprintf('Test %.0f. %s\n\n', testID, testStr);
    
    % Load EDF 1
    belClass = BlockEdfLoadClass(edfFn1);
    belClass = belClass.blockEdfLoad;  
    belClass = belClass.CheckEdf;
    fprintf('Checking: %s\n', edfFn1);
    if isempty(belClass.errMsg)
        fprintf('\tNo error Messages found\n');
    else
        for m = 1:length(belClass.errMsg)
            fprintf('\t%s\n',belClass.errMsg{m});
        end
    end

    % Load EDF 2
    belClass = BlockEdfLoadClass(edfFn2);
    belClass.numCompToLoad = 1;
    belClass = belClass.blockEdfLoad;  
    belClass = belClass.CheckEdf;
    fprintf('\n\nChecking: %s\n', edfFn2);
    if isempty(belClass.errMsg)
        fprintf('\tNo error Messages found\n');
    else
        for m = 1:length(belClass.errMsg)
            fprintf('\t%s\n',belClass.errMsg{m});
        end
    end

    % Load EDF 3
    belClass = BlockEdfLoadClass(edfFn3);
    belClass.numCompToLoad = 2;
    belClass = belClass.blockEdfLoad;  
    belClass = belClass.CheckEdf;
    fprintf('\n\nChecking: %s\n', edfFn3);
    if isempty(belClass.errMsg)
        fprintf('\tNo error Messages found\n');
    else
        for m = 1:length(belClass.errMsg)
            fprintf('\t%s\n',belClass.errMsg{m});
        end
    end

end
% ------------------------------------------------------------------ Test 8
% Test 8: Check flag to invert swapped signals
if RUN_TEST_8 == 1
    % Write test results to console
    fprintf('------------------------------- Test 8\n\n');
    fprintf('Check flag to invert swapped signals\n\n');
    
    
    %------------------------------------------------- Show swapped signals
    % Open generated test file
    edfFn1 = '201434_deidentified.EDF';
        
    % Load EDF
    belClass = BlockEdfLoadClass(edfFn1);
    belClass = belClass.blockEdfLoad;  
    belClass = belClass.CheckEdf; 
    belClass.DispCheck;
    
    %------------------------------------------------------------ No Invert
    % Open generated test file
    edfFn1 = '201434_deidentified.EDF';
    
    % Load EDF
    signalLabels = {'AIRFLOW', 'THOR RES', 'ABDO RES'};
    belClass = BlockEdfLoadClass(edfFn1, signalLabels);
    belClass.SWAP_MIN_MAX = 1;
    belClass.INVERT_SWAP_MIN_MAX = 0;  
    belClass = belClass.blockEdfLoad;  

    belClass = belClass.PlotEdfSignalStart;
    
    title('Swap Min-Max with no Signal Inversion');
    
    %--------------------------------------------------------- ----- Invert
    % Open generated test file
    edfFn1 = '201434_deidentified.EDF';
    
    % Load EDF
    signalLabels = {'AIRFLOW', 'THOR RES', 'ABDO RES'};
    belClass = BlockEdfLoadClass(edfFn1, signalLabels);
    belClass.SWAP_MIN_MAX = 1;
    belClass.INVERT_SWAP_MIN_MAX = 1;  
    belClass = belClass.blockEdfLoad;  
    belClass = belClass.PlotEdfSignalStart;    
    title('Swap Min-Max with Signal Inversion');
    
    % Check that summary variables are returned
    mostSeriousErrValue = belClass.mostSeriousErrValue;
    mostSeriousErrMsg = belClass.mostSeriousErrMsg;
    fprintf('\nCheck class error variables (No Min/Max Fix):\n');
    fprintf('\tMost serious error Id (%.0f)\n\tMost serious error messsage:  ''%s''\n\n\n',...
        mostSeriousErrValue, mostSeriousErrMsg);    
    
    %--------------------------------------------------- Detailed Reporting
    % Get more quantitative information regarding the errors
    totNumDeviations = belClass.totNumDeviations;
    deviationByType = belClass.deviationByType;
    errSummaryLabel = belClass.errSummaryLabel;
    errSummaryMessages = belClass.errSummaryMessages;
    
    % Echo Status to Console
    fprintf('%s, total number of errors = %.0f\n\n', ...
        edfFn1, totNumDeviations);
    fprintf('Deviations by type: %s = %.0f, %s = %.0f, %s = %.0f\n',...
        errSummaryLabel{1}, deviationByType(1), ...
        errSummaryLabel{2}, deviationByType(2),...
        errSummaryLabel{3}, deviationByType(3));
    fprintf('Deviations by type: %s = %.0f, %s = %.0f, %s = %.0f\n\n',...
        errSummaryLabel{4}, deviationByType(4), ...
        errSummaryLabel{5}, deviationByType(5),...
        errSummaryLabel{6}, deviationByType(6));   
    
    % Write some more information to the console
    belClass.PrintEdfHeader
    belClass.PrintEdfSignalHeader
    
    
end
end
