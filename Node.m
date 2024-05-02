classdef Node
    properties
        index
        weight
        reliability
    end

    methods
        function obj = Node(i, w, r)
            obj.index = i;
            obj.weight = w;
            obj.reliability=r;
        end

        function displayProperties(obj)
            disp(['Index: ', num2str(obj.index)]);
            disp(['Weight: ', num2str(obj.weight)]);
            disp(['Reliability: ', num2str(obj.reliability)]);
        end

        function tf = isequal(obj1, obj2)
            tf = isequal(obj1.index, obj2.index);
        end
    end

    methods(Static)
        function [S, n, k] = import_system(path)
            dataTable = readtable(path);

            disp(dataTable)
            
            n = dataTable.n(1);
            k = dataTable.k(1);
            
            S = Node.empty(height(dataTable), 0);
            
            for i = 1:height(dataTable)
                index = dataTable.index(i);
                weight = dataTable.weight(i);
                reliability = dataTable.reliability(i);
                
                S{i} = Node(index, weight, reliability);
            end
        end

        % selection sort
        function S = sortByWeight(S)
            for i = 1:length(S)
                min = i;
                for j = i:length(S)
                    if S{min}.weight < S{j}.weight
                        min = j;
                    end
                end
                tmp = S{i};
                S{i} = S{min};
                S{min} = tmp;
            end
        end

        function [S] = union(a,b)
            S = {};
            for i = 1:length(a)
                ismember = false;
                for j = 1:length(S)
                    if a{i}.index == S{j}.index
                        ismember = true;
                    end
                end
                if ismember == false
                    S{end + 1} = a{i};
                end
            end
            for i = 1:length(b)
                ismember = false;
                for j = 1:length(S)
                    if b{i}.index == S{j}.index
                        ismember = true;
                    end
                end
                if ismember == false
                    S{end + 1} = b{i};
                end
            end
        end

        function [S] = diff(a,b)
            S = {};
            for i = 1:length(a)
                ismember = false;
                for j = 1:length(b)
                    if a{i}.index == b{j}.index
                        ismember = true;
                    end
                end
                if ismember == false
                    S{end + 1} = a{i};
                end
            end
        end
    end
end