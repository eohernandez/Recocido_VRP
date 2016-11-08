function [ output_args ] = imp_test(mejor, varargin)
%IMP_TEST Summary of this function goes here
%   Detailed explanation goes here

persistent file_name nc x y count
    
    if(length(varargin) == 4)
        file_name = varargin{1};
        nc = varargin{2};
        x = varargin{3};
        y = varargin{4};
        count = 0;
        fprintf('imp persistent\n');
        return
    end

    %{
    for i = 1:length(varargin)
        fprintf('%d:\n', i)
        varargin{i}
    end
    %}
    %
    if(~isempty(varargin))
        if(count > 300)
            fprintf('Intentos: %d c: %d\n', mejor.intentos, varargin{3});
            count = 0;
        else
            count = count + 1;
        end
    else
        grafica_VRP(mejor.x, file_name, nc, x, y);
    end
    %varargin{1}
    %

end

