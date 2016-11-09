function idx = revolverWheel(fts)

fts = cumsum(fts / sum( fts ));

idx = sum( fts < rand(1))+1;