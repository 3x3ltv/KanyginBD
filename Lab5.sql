-- таблицы-партиции download
CREATE TABLE operator_telecom.InternetTraffic_download (
    CHECK (traffic_type = 'download')
) INHERITS (operator_telecom.InternetTraffic);

-- таблицы-партиции upload
CREATE TABLE operator_telecom.InternetTraffic_upload (
    CHECK (traffic_type = 'upload')
) INHERITS (operator_telecom.InternetTraffic);

-- таблицы-партиции для третьего мая
CREATE TABLE operator_telecom.InternetTraffic_may_third (
    CHECK (date = '2024-05-03')
) INHERITS (operator_telecom.InternetTraffic);


CREATE OR REPLACE FUNCTION partition_internet_traffic()
RETURNS TRIGGER AS $$
BEGIN
    BEGIN
        IF (NEW.date = '2024-05-03') THEN
            INSERT INTO operator_telecom.InternetTraffic_may_third VALUES (NEW.*);
        ELSIF (NEW.traffic_type = 'download') THEN
            INSERT INTO operator_telecom.InternetTraffic_download VALUES (NEW.*);
        ELSIF (NEW.traffic_type = 'upload') THEN
            INSERT INTO operator_telecom.InternetTraffic_upload VALUES (NEW.*);
        ELSE
            RAISE EXCEPTION 'Invalid traffic type';
        END IF;
    END;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- триггер
CREATE TRIGGER internet_traffic_partition_trigger
BEFORE INSERT ON operator_telecom.InternetTraffic
FOR EACH ROW EXECUTE FUNCTION partition_internet_traffic();

TRUNCATE TABLE operator_telecom.InternetTraffic;

INSERT INTO operator_telecom.InternetTraffic (user_id, volume, date, traffic_type)
VALUES
    (5, 100, '2024-05-03', 'download'),
    (7, 200, '2024-05-02', 'download'),
    (8, 150, '2024-05-02', 'upload'),
    (9, 300, '2024-05-01', 'upload');
