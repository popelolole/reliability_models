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
                A = a{i};
                if isa(A, "cell")
                    diff_elements = {};
                    for m = 1:length(A)
                        ismember = false;
                        for j = 1:length(S)
                            s = S{j};
                            if isa(s, "cell")
                                for n = 1:length(s)
                                    if A{m}.index == s{n}.index
                                        ismember = true;
                                    end
                                end
                            else
                                if A{m}.index == s.index
                                    ismember = true;
                                end
                            end
                        end
                        if ismember == false
                            diff_elements{end + 1} = A{m};
                        end
                    end
                    if length(diff_elements) == 1
                        S{end + 1} = diff_elements{1};
                    elseif ~isempty(diff_elements)
                        S{end + 1} = diff_elements;
                    end

                else
                    ismember = false;
                    for j = 1:length(S)
                        s = S{j};
                        if isa(s, "cell")
                            for n = 1:length(s)
                                if A.index == s{n}.index
                                    ismember = true;
                                end
                            end
                        else
                            if A.index == s.index
                                ismember = true;
                            end
                        end
                    end
                    if ismember == false
                        S{end + 1} = A;
                    end
                end
            end
            for i = 1:length(b)
                B = b{i};
                if isa(B, "cell")
                    diff_elements = {};
                    for m = 1:length(B)
                        ismember = false;
                        for j = 1:length(S)
                            s = S{j};
                            if isa(s, "cell")
                                for n = 1:length(s)
                                    if B{m}.index == s{n}.index
                                        ismember = true;
                                    end
                                end
                            else
                                if B{m}.index == s.index
                                    ismember = true;
                                end
                            end
                        end
                        if ismember == false
                            diff_elements{end + 1} = B{m};
                        end
                    end
                    if length(diff_elements) == 1
                        S{end + 1} = diff_elements{1};
                    elseif ~isempty(diff_elements)
                        S{end + 1} = diff_elements;
                    end
                else
                    ismember = false;
                    for j = 1:length(S)
                        s = S{j};
                        if isa(s, "cell")
                            for n = 1:length(s)
                                if B.index == s{n}.index
                                    ismember = true;
                                end
                            end
                        else
                            if B.index == s.index
                                ismember = true;
                            end
                        end
                    end
                    if ismember == false
                        S{end + 1} = B;
                    end
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