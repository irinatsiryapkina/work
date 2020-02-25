wwtp.out <- out[grep('tot', out$factor), ]
wwtp.out <- wwtp.out[grep('WWTP', wwtp.out$factor), ]
wwtp.out <- wwtp.out[-grep('potential', wwtp.out$factor), ]
wwtp.out.tot <- aggregate(wwtp.out$value, by=list(run_id=wwtp.out$run_id), FUN=sum)

colnames(wwtp.out.tot)[colnames(wwtp.out.tot) == 'x'] <- 'value'
wwtp.out.tot['factor'] <- 'wwtp.total'
wwtp.out.tot['time'] <- 2040

wwtp.results <- rbind(wwtp.out, wwtp.out.tot)