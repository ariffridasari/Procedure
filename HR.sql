select * from countries

insert into countries (country_id,country_name, region_id) values ('AJ','Ajax','2')  


CREATE OR REPLACE PROCEDURE ins_country (
    c_id     IN   VARCHAR,
    c_name   IN   VARCHAR,
    r_id     IN   NUMBER
) IS
BEGIN
    INSERT INTO countries (
        country_id,
        country_name,
        region_id
    ) VALUES (
        c_id,
        c_name,
        r_id
    );

EXCEPTION
    WHEN OTHERS THEN
        raise_application_error(-20001, 'An error was encountered - '
                                        || sqlcode
                                        || ' -ERROR- '
                                        || sqlerrm);
END ins_country;
exec ins_country('AC','Arvt','2');


CREATE OR REPLACE PROCEDURE auto_ins_job (
    j_title        IN   VARCHAR,
    max_salary_a   IN   NUMBER,
    min_salary_a   IN   NUMBER
) IS
    last_value_job   NUMBER;
    numb_job         NUMBER;
BEGIN
    SELECT
        MAX(job_id)
    INTO last_value_job
    FROM
        jobs;

    numb_job := last_value_job + 1;
    INSERT INTO jobs (
        job_id,
        job_title,
        max_salary,
        min_salary
    ) VALUES (
        numb_job,
        j_title,
        max_salary_a,
        min_salary_a
    );

EXCEPTION
    WHEN OTHERS THEN
        raise_application_error(-20001, 'An error was encountered - '
                                        || sqlcode
                                        || ' -ERROR- '
                                        || sqlerrm);
END auto_ins_job;

exec auto_ins_job('Supiran',800,900);


-- NEWWWWWW



