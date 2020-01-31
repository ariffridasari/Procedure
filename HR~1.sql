CREATE OR REPLACE PROCEDURE auto_ins_job2 (
    j_title        IN   VARCHAR,
    max_salary_a   IN   NUMBER,
    min_salary_a   IN   NUMBER
) IS
    last_value_job   NUMBER;
    numb_job         NUMBER;
    job_name         VARCHAR(999) ;
    t_job number;
BEGIN
    SELECT
        MAX(job_id)
    INTO last_value_job
    FROM
        jobs;

    numb_job := last_value_job + 1;
    
    SELECT count (job_title) into t_job 
    from jobs
    where job_title = j_title;
    
    if t_job < 1 THEN
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
    else
    dbms_output.put_line('Nama Job tidak boleh sama !!');   
    end if;

EXCEPTION
    WHEN OTHERS THEN
        raise_application_error(-20001, 'An error was encountered - '
                                        || sqlcode
                                        || ' -ERROR- '
                                        || sqlerrm);
END auto_ins_job2;

exec auto_ins_job2('Supiraasn',800,900);

insert into pegawai(nama,alamat) values ('Arif','Jakarta')


CREATE OR REPLACE TRIGGER insert_pegawai
  BEFORE INSERT ON PEGAWAI
  FOR EACH ROW
BEGIN
  SELECT AUTO_ID.nextval
  INTO :new.id
  FROM dual;
END;


CREATE OR REPLACE PROCEDURE add_pegawai (
    p_nama     IN   VARCHAR,
    p_alamat   IN   VARCHAR
) IS
    name_p VARCHAR(999);
BEGIN SELECT
          COUNT(nama)
      INTO name_p
      FROM
          pegawai
      WHERE
          nama = p_nama;
    
    IF name_p < 1 then
    INSERT INTO pegawai (
        nama,
        alamat
    ) VALUES (
        p_nama,
        p_alamat
    );
else dbms_output.put_line('Nama tidak boleh sama !!');
end if;
EXCEPTION
    WHEN OTHERS THEN
        raise_application_error(-20001, 'An error was encountered - '
                                        || sqlcode
                                        || ' -ERROR- '
                                        || sqlerrm);
END add_pegawai;

exec add_pegawai('Makan ','bawena');

CREATE OR REPLACE PROCEDURE del_pegawai (
    p_key IN VARCHAR
) IS
    p_numb NUMBER(2);
BEGIN
    SELECT
        COUNT(*)
    INTO p_numb
    FROM
        pegawai
    WHERE
         nama LIKE '%p_key%';

    IF p_numb >= 1 then
    delete pegawai
        WHERE
             nama LIKE '%p_key%';
    ELSE
        dbms_output.put_line('Tidak ada data yang dihapus !');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        raise_application_error(-20001, 'Error'
                                        || sqlcode
                                        || '--'
                                        || sqlerrm);
END del_pegawai;

CREATE OR REPLACE PROCEDURE soft_del_pegawai (
    p_key IN VARCHAR
) IS
    p_numb NUMBER(2);
BEGIN
    SELECT
        COUNT(*)
    INTO p_numb
    FROM
        pegawai
    WHERE
    nama = 'p_key' OR ID = p_key;

    IF p_numb >= 1 then
    update pegawai set is_active ='0' 
        WHERE
         (nama = 'p_key' OR ID = p_key)
             and is_active = '1';
    ELSE
        dbms_output.put_line('Tidak ada data yang dihapus !');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        raise_application_error(-20001, 'Error'
                                        || sqlcode
                                        || '--'
                                        || sqlerrm);
END soft_del_pegawai;



exec soft_del_pegawai('1')




SELECT
    COUNT(*)
--    INTO p_numb
FROM
    pegawai
WHERE
    nama LIKE '%Sarimi%'
    OR id LIKE '%Sarimi%'

select * from pegawai where nama like '%sukiran%'

exec del_pegawai('Sukamadak')

create or replace TRIGGER insert_pegawai
  BEFORE INSERT ON PEGAWAI
  FOR EACH ROW
BEGIN
  SELECT AUTO_ID.nextval
  INTO :new.id
  FROM dual;
  SELECT 1 
  INTO :NEW.IS_ACTIVE
  FROM DUAL;
END;

CREATE OR REPLACE PROCEDURE auto_active (
    p_id IN VARCHAR
) IS BEGIN UPDATE pegawai
SET is_active = 1
WHERE
    id = p_id;
end
auto_active;

exec auto_active ('2')

 BEGIN
    FOR loop_emp IN (
        SELECT
            *
        FROM
            employees
        WHERE
            salary > 15000
    ) LOOP
    dbms_output.put_line('Number of rows processed: '
                             || nvl(TO_CHAR(SQL%rowcount), 'Null'));
    END LOOP loop_emp;
END;

