use first_db;

drop table if exists t;

create table t ( i integer );

insert into t values (1);

commit;

