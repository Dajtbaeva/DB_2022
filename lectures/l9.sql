select *
from nut_data;



explain analyze
select *
from nut_data
where nutr_val > 5.5;

create index nut_data_nutr_val_idx on nut_data (nutr_val);


explain analyze
select *
from nut_data
where nutr_val > 5.5
   or num_data_pts > 17;

create index nut_data_num_data_pts_idx on nut_data (num_data_pts);

create index nut_data_nutr_val_num_data_pts_idx on nut_data (nutr_val, num_data_pts);



explain analyze
select *
from actor
where lower(first_name) = 'johnny';

create index actor_lower_first_name_idx on actor (lower(first_name));



explain analyze
select *
from nut_data
where nutr_val < 1000;


create index nut_data_nutr_val_idx_partial on nut_data (nutr_val) where nutr_val > 5.5;




