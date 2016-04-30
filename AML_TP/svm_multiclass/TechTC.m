function [X, Y] = TechTC(data_num)
    file_list = cell(1, 10);

    file_list{1} = 'Exp_10341_10755';
    file_list{2} = 'Exp_10385_299104';
    file_list{3} = 'Exp_10567_46076';
    file_list{4} = 'Exp_14271_46076';
    file_list{5} = 'Exp_17360_20186';
    file_list{6} = 'Exp_194915_20186';
    file_list{7} = 'Exp_20673_46076';
    file_list{8} = 'Exp_316970_85489';
    file_list{9} = 'Exp_6920_8366';
    file_list{10} = 'Exp_10341_14271';

    
    [Y, X] = svmlread(char(strcat('techtc100_preprocessed/',file_list(data_num),'/vectors.dat')));
    X = full(X);
    Y = full(Y);