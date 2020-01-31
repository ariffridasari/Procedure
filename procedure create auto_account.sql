CREATE OR REPLACE PROCEDURE auto_account (
    a_nama     IN   VARCHAR,
    a_alamat   IN   VARCHAR
) IS

    a_id         NUMBER(2);
    name_p       VARCHAR(999);
    a_username   VARCHAR(20);
    a_pass       VARCHAR(15);
    is_act       NUMBER(2);
BEGIN
    add_pegawai(a_nama, a_alamat);
    SELECT
        pegawai.id,
        pegawai.is_active
    INTO
        a_id,
        is_act
    FROM
        pegawai
    WHERE
        nama = a_nama;

    SELECT
        (substr(replace (nama,' ' ,''),1,6)|| id ),
        (replace(substr(nama, 3, 5),' ','')
          || id
          || substr(alamat, 1, 4) )
    INTO
        a_username,
        a_pass
    FROM
        pegawai
    WHERE
        id = a_id;

    SELECT
        COUNT(username)
    INTO name_p
    FROM
        account
    WHERE
        id = a_id;

IF name_p < 1 then
    INSERT INTO account (
        id,
        username,
        password,
        is_active
    ) VALUES (
        a_id,
        a_username,
        a_pass,
        is_act
    );
    else dbms_output.put_line('Nama tidak boleh sama !!');
end if;
EXCEPTION
    WHEN OTHERS THEN
        raise_application_error(-20001, 'An error was encountered - '
                                        || sqlcode
                                        || ' -ERROR- '
                                        || sqlerrm);
END auto_account;

exec auto_account('Arif Fridasari','Semarang');
exec auto_account('Fikri Maulana Najib','Semarang');
exec auto_account('Sukamad Ridho','Semarang');
exec auto_account('Rahmad Sujito','Yogyakarta');
exec auto_account('Elis Syafira Akmal','Yogyakarta');
exec auto_account('Bran Syakila Sujono','Salatiga');
exec auto_account('Adam Bruno Fernandes','Salatiga');

SELECT (replace(substr(nama, 3, 5),' ','')
          || id
          || substr(alamat, 1, 4) ) from pegawai where id=22


