%% Wygeneruj przykladowe dane.

rng(0,'twister');
values = rand(30, 1);

%% Ustaw wartosci konfiguracyjne histogramu.

bin_width = 0.1;  % szerokosc przedzialu klasowego
edges_init = 0.2:bin_width:0.6;  % krawedzie przedzialow klasowych

% Liczac wystapienia uwzglednij WSZYSTKIE wartosci - takze spoza krancow
% przedzialow klasowych.
edges_mod = [min(values), edges_init(2:end-1), max(values)];

counts = histcounts(values, edges_mod);

y_max = 25;  % maksymalna wartosc na osi Y

%% Wyswietl histogram w MATLAB-ie.

figure(1)
bar(edges_init(1:end-1), counts')
xlabel('value')
ylabel('# of cases')
ylim([0, y_max])
legend off

%% Zapisz wyswietlony wykres w postaci pliku TikZ.

write_to_tikz = false;
if write_to_tikz
    matlab2tikz(fullfile(results_dir, 'histogram_simple.tikz'))
end

%% Zapisz dane konfiguracyjne histogramu do pliku.

fileID = fopen(fullfile('data', 'histogram_simple_fp.tex'), 'w');
%
fprintf(fileID, '\\FPeval{\\xmin}{(%.3f)}  %% lewy kraniec przedzialu wartosci\n', edges_init(1));
fprintf(fileID, '\\FPeval{\\xmax}{(%.3f)}  %% prawy kraniec przedzialu wartosci\n', edges_init(end));
fprintf(fileID, '\\FPeval{\\binwidth}{(%.3f)}  %% szerokosc przedzialu klasowego\n', bin_width);
fprintf(fileID, '\n');
fprintf(fileID, '\\FPeval{\\ymaxaxis}{(%d)}  %% maksymalna wartosc wyswietlana na osi Y\n', y_max);
%
fclose(fileID);

%% Zapisz dane o czestosci wystepowania do pliku.

fileID = fopen(fullfile('data', 'histogram_simple_data.tsv'), 'w');
for bin_inx = 1:numel(counts)
    % Wysrodkuj przedzialy klasowe.
    fprintf(fileID, '%.3f\t%d\n', ...
        edges_init(bin_inx) + bin_width / 2, ...
        counts(bin_inx));
end
fclose(fileID);
