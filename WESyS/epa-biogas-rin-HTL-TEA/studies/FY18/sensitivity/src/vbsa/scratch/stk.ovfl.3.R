rm(list=ls())
library (data.table)

> df_new %>%  
  +          mutate(unix_t = from_utc_timestamp(timestamp(t) ,'UTC'),
                    +          date_str = date_format(unix_t, 'yyyy-MM-dd HH:mm:ss z'),
                    +          date_alt = to_date(from_utc_timestamp(timestamp(t) ,'UTC'))) %>% 
  +   select(t, unix_t, date_str, date_alt) %>% head(5)
# Source:   lazy query [?? x 4]
# Database: spark_connection

