%% Wygeneruj przykladowe dane.

rng(0,'twister');
values_group1 = rand(30, 1);
values_group2 = rand(30, 1);

%% Ustaw wartosci konfiguracyjne histogramu.

bin_width = 0.1;  % szerokosc przedzialu klasowego
edges_init = 0.2:bin_width:0.6;  % krawedzie przedzialow klasowych

% Liczac wystapienia uwzglednij WSZYSTKIE wartosci - takze spoza krancow
% przedzialow klasowych.
edges_mod = [min([values_group1; values_group2]), ...
    edges_init(2:end-1), max([values_group1; values_group2])];

counts_group1 = histcounts(values_group1, edges_mod);
counts_group2 = histcounts(values_group2, edges_mod);
counts_aggregated = [counts_group1; counts_group2]';

bin_labels_matlab = arrayfun(@(v) sprintf('%.0f%%', v), ...
    (sum(counts_aggregated(:,2), 2) ./ sum(counts_aggregated, 2)) * 100, ...
    'UniformOutput',false);

% Procenty w LaTeX-u wymagaja innego formatowania...
bin_labels_latex = arrayfun(@(v) sprintf('%.0f\\%%', v), ...
    (sum(counts_aggregated(:,2), 2) ./ sum(counts_aggregated, 2)) * 100, ...
    'UniformOutput',false);

y_max = 40;  % maksymalna wartosc na osi Y

%% Wyswietl histogram w MATLAB-ie.

figure(1)
bar(edges_init(1:end-1), counts_aggregated, 'stacked')
xlabel('value')
ylabel('# of cases')
ylim([0, y_max])
legend('group 1', 'group 2')

text(edges_init(1:end-1), sum(counts_aggregated, 2), ...
    bin_labels_matlab, ...
    'VerticalAlignment','bottom','HorizontalAlignment','center'); 
box off

%% Zapisz wyswietlony wykres w postaci pliku TikZ.

write_to_tikz = false;
if write_to_tikz
    matlab2tikz(fullfile(results_dir, 'histogram_groupped.tikz'))
end

%% Zapisz dane konfiguracyjne histogramu do pliku.

fileID = fopen(fullfile('data', 'histogram_groupped_fp.tex'), 'w');
%
fprintf(fileID, '\\FPeval{\\xmin}{(%.3f)}  %% lewy kraniec przedzialu wartosci\n', edges_init(1));
fprintf(fileID, '\\FPeval{\\xmax}{(%.3f)}  %% prawy kraniec przedzialu wartosci\n', edges_init(end));
fprintf(fileID, '\\FPeval{\\binwidth}{(%.3f)}  %% szerokosc przedzialu klasowego\n', bin_width);
fprintf(fileID, '\n');
fprintf(fileID, '\\FPeval{\\ymaxaxis}{(%d)}  %% maksymalna wartosc wyswietlana na osi Y\n', y_max);
%
fclose(fileID);

%% Zapisz etykiety ponad slupkami histogramu do pliku.

fileID = fopen(fullfile('data', 'histogram_groupped_labels.tex'), 'w');
%
for bin_inx = 1:size(counts_aggregated, 1)
    x = edges_init(bin_inx) + bin_width / 2;
    y = sum(counts_aggregated(bin_inx,:));
    s = bin_labels_latex{bin_inx};
    %
    fprintf(fileID, '\\node[above, align=center]\n');
    fprintf(fileID, 'at (axis cs:%.3f,%d) {%s};\n', x, y, s);
    fprintf(fileID, '\n');
end
%
fclose(fileID);

%% Zapisz dane o czestosci wystepowania do pliku (dla kazdej grupy do osobnego pliku).

for group_inx = 1:size(counts_aggregated, 2)
    fileID = fopen(fullfile('data', sprintf('histogram_groupped_data%d.tsv', group_inx)), 'w');
    for bin_inx = 1:size(counts_aggregated, 1)
        % Wysrodkuj przedzialy klasowe.
        fprintf(fileID, '%.3f\t%d\n', ...
            edges_init(bin_inx) + bin_width / 2, ...
            counts_aggregated(bin_inx, group_inx));
    end
    fclose(fileID);
end
