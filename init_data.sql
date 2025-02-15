DO $$
BEGIN
DROP TABLE IF EXISTS PersonTsv;
DROP TABLE IF EXISTS ProgramTsv;
DROP TABLE IF EXISTS PuzzleTsv;
DROP TABLE IF EXISTS SolveTsv;

CREATE TEMPORARY TABLE IF NOT EXISTS PersonTsv (
    old_id TEXT NOT NULL,
    display_name TEXT,
    discord_id BIGINT,
    moderator BOOL
);

CREATE TEMPORARY TABLE IF NOT EXISTS ProgramTsv (
    abbreviation TEXT NOT NULL,
    name TEXT NOT NULL
);

CREATE TEMPORARY TABLE IF NOT EXISTS PuzzleTsv (
    hsc_id TEXT NOT NULL,
    name TEXT NOT NULL,
    primary_filters BOOLEAN NOT NULL,
    primary_macros BOOLEAN NOT NULL
);

CREATE TEMPORARY TABLE IF NOT EXISTS SolveTsv (
    hsc_id TEXT NOT NULL,
    speed_cs INT,
    blind BOOLEAN NOT NULL,
    uses_filters BOOLEAN NOT NULL,
    uses_macros BOOLEAN NOT NULL,
    video_url TEXT,
    program TEXT NOT NULL,
    user_name TEXT NOT NULL,
    fake_id INT,
    solve_date DATE NOT NULL
);

INSERT INTO PersonTsv (old_id, display_name, discord_id, moderator) VALUES
    ('alvin','Alvin',421506992360914955,FALSE),
('grant','Grant Staten',518576186817773568,TRUE),
('hactar','Andrew Farkas (Hactar)',216295379895844865,TRUE),
('hyperespy','Hyperespy',807732155491811400,FALSE),
('luna','Luna Harran',404738612652146691,TRUE),
('rowan','Rowan Fortier',285967485289889792,TRUE),
('tetrian','Tetrian',234569125152686081,FALSE),
('weill','Freya',672522970979237901,FALSE),
('adam','Adam Marcellus Kelly',NULL,FALSE),
('koen','Koen R.',NULL,FALSE),
('cubedude','The Cube Dude',490301229302415360,FALSE),
('kevin','K3v1N',1011412013844529162,FALSE),
('asa','Asa Kaplan',344331003810152448,FALSE),
('yuste','Sebastian Yuste',NULL,FALSE),
('gray','TheGrayCuber',NULL,FALSE),
('connor','Connor Lindsay',NULL,FALSE),
('olaf','Olaf Niechcial',262590024380317697,FALSE),
('void','The Void',714935224009490462,FALSE),
('markk','Markk',1134170236132790302,FALSE),
('origamist','Normal Origamist',850073984077922374,FALSE),
('tymofro','Tymon Fro',1008336255035121775,FALSE),
('edan','Edan Maor',300343121508827136,FALSE),
('battistin','Emanuele Battistin',139872028114026496,FALSE),
('myigiter','Murat Emre Yiğiter',742508849776558212,FALSE),
('danielcohen','Daniel Cohen',1001314045447651418,FALSE),
('ethandavis','Ethan Davis',432960409788481547,FALSE),
('pkearth','PKEarth',855997575772372993,FALSE),
('milojacquet','Milo Jacquet',186553034439000064,TRUE),
('akkei','Akkei',264111982385430528,FALSE),
('godly','Godly',459126084428890113,FALSE),
('jackcai','Jack Cai',263268617066512384,FALSE),
('bilal','Bilal Mourad',691307699589087262,FALSE),
('stella','Stella',784212812125306970,FALSE),
('vin','Vin',811877120212598787,FALSE),
('rayzchen','Ray Chen',663139761128603651,FALSE),
('saturnb','Saturnb',630183529287778314,FALSE),
('pistelli','Vincent Pistelli',387370360494096394,FALSE),
('hana','Henry Rutland (Curun1r)',1245248032967233548,FALSE),
('lorenzo','Lorenzo1098',909646118093205535,FALSE),
('starry','Starryninja',927387342661124146,FALSE),
('lopidoff','lopidoff',255399050822549504,TRUE);

INSERT INTO ProgramTsv (abbreviation, name) VALUES
    ('MC4D','Magic Cube 4D'),
    ('-','Physical'),
    ('HSC','Hyperspeedcube'),
    ('MT','MagicTile'),
    ('MPU','MagicPuzzleUltimate'),
    ('AKKEI-SIM','Akkei’s physical 3^4 program'),
    ('MC3D','Magic Cube 3D'),
    ('MC7D','Magic Cube 7D'),
    ('MC5D','Magic Cube 5D');

INSERT INTO PuzzleTsv (hsc_id, name, primary_filters, primary_macros) VALUES
    ('2x2x2x2','2×2×2×2',TRUE,FALSE),
    ('3x3x3x3','3×3×3×3',TRUE,FALSE),
    ('4x4x4x4','4×4×4×4',TRUE,FALSE),
    ('5x5x5x5','5×5×5×5',TRUE,FALSE),
    ('6x6x6x6','6×6×6×6',TRUE,FALSE),
    ('7x7x7x7','7×7×7×7',TRUE,FALSE),


    ('1x3x3x3','1×3×3×3',TRUE,FALSE),
    ('2x2x2x3','2×2×2×3',TRUE,FALSE),
    ('2x2x3x3','2×2×3×3',TRUE,FALSE),


    ('phys_2x2x2x2','Physical 2×2×2×2',FALSE,FALSE),
    ('virt_phys_3x3x3x3','Physical Virtual 3×3×3×3',FALSE,FALSE),


    ('3-layer_simplex','3-Layer Simplex',TRUE,FALSE),


    ('2x2x2x2x2','2×2×2×2×2',TRUE,FALSE),
    ('3x3x3x3x3','3×3×3×3×3',TRUE,FALSE),
    ('4x4x4x4x4','4×4×4×4×4',TRUE,FALSE),


    ('hemimegaminx','Hemimegaminx',FALSE,FALSE),
    ('klein_quartic','Canon-Cut Klein Quartic',FALSE,FALSE),


    ('3x3x3_1d','3×3×3 in 2D projection with 1D Vision',FALSE,FALSE);

INSERT INTO SolveTsv (hsc_id,speed_cs,blind,uses_filters,uses_macros,video_url,program,user_name,fake_id,solve_date) VALUES

('3x3x3x3',61187,FALSE,FALSE,FALSE,'https://youtu.be/qyaYU6AV5Sg','MC4D','tetrian',10001,'2019-05-04'),
('4x4x4x4',432765,FALSE,FALSE,FALSE,'https://youtu.be/TPaW0RUJrFk','MC4D','tetrian',10002,'2019-05-19'),
('phys_2x2x2x2',14600,FALSE,FALSE,FALSE,'https://youtu.be/aZ6GQOmgYD8','-','connor',10003,'2019-08-11'),
('3-layer_simplex',10344,FALSE,FALSE,FALSE,'https://youtu.be/z__CuN5CgAY','MC4D','tetrian',10004,'2021-07-24'),
('2x2x2x2',6080,FALSE,FALSE,FALSE,'https://youtu.be/s8Kj2h8YCkY','MC4D','tetrian',10005,'2021-07-24'),
('phys_2x2x2x2',13654,FALSE,FALSE,FALSE,'https://youtu.be/mgfhSL2fi7E','-','rowan',10006,'2021-11-15'),
('phys_2x2x2x2',12527,FALSE,FALSE,FALSE,'https://youtu.be/tOaBQs34oB0','-','rowan',10007,'2021-12-06'),
('phys_2x2x2x2',12358,FALSE,FALSE,FALSE,'https://youtu.be/I9hnsif4ImE','-','rowan',10008,'2021-12-09'),
('phys_2x2x2x2',12066,FALSE,FALSE,FALSE,'https://youtu.be/2SWo0zMlg8I','-','rowan',10009,'2021-12-11'),
('phys_2x2x2x2',11675,FALSE,FALSE,FALSE,'https://youtu.be/JJPJ7hgNLJU','-','rowan',10010,'2021-12-11'),
('phys_2x2x2x2',10624,FALSE,FALSE,FALSE,'https://youtu.be/RuUc26S5xpw','-','rowan',10011,'2022-05-07'),
('phys_2x2x2x2',8814,FALSE,FALSE,FALSE,'https://youtu.be/FSpuv9FJorw','-','rowan',10012,'2022-06-20'),

('phys_2x2x2x2',8717,FALSE,FALSE,FALSE,'https://youtu.be/XDW7wi4ryPE','-','rowan',10014,'2022-08-02'),
('phys_2x2x2x2',8328,FALSE,FALSE,FALSE,'https://youtu.be/uEnk2yrJN7I','-','grant',10015,'2022-08-07'),
('phys_2x2x2x2',6757,FALSE,FALSE,FALSE,'https://youtu.be/X_FY-CUfvUI','-','grant',10016,'2022-08-12'),
('phys_2x2x2x2',7824,FALSE,FALSE,FALSE,'https://youtu.be/i8Dkpk6QEpE','-','rowan',10017,'2022-09-17'),
('phys_2x2x2x2',6604,FALSE,FALSE,FALSE,'https://youtu.be/_qqXVKOVkAI','-','grant',10018,'2022-09-18'),

('phys_2x2x2x2',5665,FALSE,FALSE,FALSE,'https://youtu.be/eIEu38wsjtM','-','grant',10020,'2022-10-03'),
('3x3x3x3',54582,FALSE,TRUE,FALSE,'https://youtu.be/U7AgKxkaG0U','HSC','hactar',10021,'2022-11-06'),
('phys_2x2x2x2',5484,FALSE,FALSE,FALSE,'https://youtu.be/Ba4fZIL9sWs','-','grant',10022,'2022-11-08'),
('phys_2x2x2x2',13147,FALSE,FALSE,FALSE,'https://youtu.be/ehmibXcJnpw','-','hyperespy',10023,'2022-11-15'),
('3x3x3x3',53882,FALSE,TRUE,FALSE,'https://youtu.be/FCvn9-JvXgY','HSC','rowan',10024,'2022-11-18'),
('3x3x3x3',50359,FALSE,TRUE,FALSE,'https://youtu.be/j8rhsXzyP78','HSC','hactar',10025,'2022-11-18'),
('3x3x3x3',49535,FALSE,TRUE,FALSE,'https://youtu.be/L43wlyaoyAM','HSC','hactar',10026,'2022-11-19'),
('3x3x3x3',48253,FALSE,TRUE,FALSE,'https://youtu.be/otPqH-m22Xg','HSC','hactar',10027,'2022-11-19'),
('3x3x3x3',46333,FALSE,TRUE,FALSE,'https://youtu.be/gRWemTTFSik','HSC','hactar',10028,'2022-11-19'),
('3x3x3x3',45632,FALSE,TRUE,FALSE,'https://youtu.be/NwRLRdkJBF8','HSC','grant',10029,'2022-11-21'),
('3x3x3x3',42217,FALSE,TRUE,FALSE,'https://youtu.be/26fvxDQPNwE','HSC','hactar',10030,'2022-11-21'),
('3x3x3x3',40621,FALSE,TRUE,FALSE,'https://youtu.be/UTISMKUW06I','HSC','grant',10031,'2022-11-22'),
('3x3x3x3',39892,FALSE,TRUE,FALSE,'https://youtu.be/p6_hGg7liLg','HSC','hactar',10032,'2022-11-22'),
('4x4x4x4',268042,FALSE,TRUE,FALSE,'https://youtu.be/5SeTzLDTb2g','HSC','luna',10033,'2022-11-23'),
('3x3x3x3',39638,FALSE,TRUE,FALSE,'https://youtu.be/aQAGH2g7It8','HSC','grant',10034,'2022-11-23'),
('3x3x3x3',33298,FALSE,TRUE,FALSE,'https://youtu.be/Cr9FnV1HOSE','HSC','hactar',10035,'2022-11-23'),
('3x3x3x3',73326,FALSE,TRUE,FALSE,'https://youtu.be/m1Itso7nOM8','HSC','alvin',10036,'2022-11-24'),
('3x3x3x3',32514,FALSE,TRUE,FALSE,'https://youtu.be/licHhb2R_EE','HSC','grant',10037,'2022-11-25'),
('3x3x3x3',32382,FALSE,TRUE,FALSE,'https://youtu.be/st7bV8y_vUY','HSC','grant',10038,'2022-11-25'),
('3x3x3x3',30192,FALSE,TRUE,FALSE,'https://youtu.be/nzpLgx_x3bs','HSC','grant',10039,'2022-11-26'),
('3x3x3x3',29814,FALSE,TRUE,FALSE,'https://youtu.be/8NamawdeMXU','HSC','hactar',10040,'2022-11-26'),
('3x3x3x3',29294,FALSE,TRUE,FALSE,'https://youtu.be/GEr2keT4cB8','HSC','grant',10041,'2022-11-27'),
('3x3x3x3',29073,FALSE,TRUE,FALSE,'https://youtu.be/4_8RjkUkv-g','HSC','hactar',10042,'2022-11-29'),
('3x3x3x3',28386,FALSE,TRUE,FALSE,'https://youtu.be/gFkfXyHy-QA','HSC','grant',10043,'2022-11-30'),
('3x3x3x3',27088,FALSE,TRUE,FALSE,'https://youtu.be/FmJYI0IImyI','HSC','hactar',10044,'2022-12-01'),
('3x3x3x3',39102,FALSE,TRUE,FALSE,'https://youtu.be/JSH4FH5cv-w','HSC','rowan',10045,'2022-12-01'),
('3x3x3x3',25084,FALSE,TRUE,FALSE,'https://youtu.be/S6mFXj9HnXA','HSC','grant',10046,'2022-12-02'),
('3x3x3x3',148695,FALSE,TRUE,FALSE,'https://youtu.be/s8l4jnMz6p4','HSC','weill',10047,'2022-12-02'),
('3x3x3x3',24919,FALSE,TRUE,FALSE,'https://youtu.be/xk4IUAtKEo8','HSC','grant',10048,'2022-12-03'),
('3x3x3x3',24260,FALSE,TRUE,FALSE,'https://youtu.be/QDabSnE1I4A','HSC','grant',10049,'2022-12-03'),
('4x4x4x4',196655,FALSE,TRUE,FALSE,'https://youtu.be/k6nSP8EPU7I','HSC','grant',10050,'2022-12-04'),
('4x4x4x4',179482,FALSE,TRUE,FALSE,'https://youtu.be/QWvQvvbNS2c','HSC','luna',10051,'2022-12-04'),
('5x5x5x5',549850,FALSE,TRUE,FALSE,'https://youtu.be/1t2P3CL-glo','HSC','luna',10052,'2022-12-07'),
('3x3x3x3',23829,FALSE,TRUE,FALSE,'https://youtu.be/hjn7iu6zs4E','HSC','grant',10053,'2022-12-07'),
('3x3x3x3',23532,FALSE,TRUE,FALSE,'https://youtu.be/VlGilGp8SCg','HSC','grant',10054,'2022-12-10'),
('3x3x3x3',22569,FALSE,TRUE,FALSE,'https://youtu.be/w_-06L6oCdE','HSC','grant',10055,'2022-12-13'),
('3x3x3x3',21443,FALSE,TRUE,FALSE,'https://youtu.be/MkhTQHIlDcQ','HSC','grant',10056,'2022-12-14'),
('3x3x3x3',20326,FALSE,TRUE,FALSE,'https://youtu.be/QdTa7Be-Iw8','HSC','grant',10057,'2022-12-14'),
('3x3x3x3',20152,FALSE,TRUE,FALSE,'https://youtu.be/Al8w9-Xk3n8','HSC','grant',10058,'2022-12-15'),

('4x4x4x4',143075,FALSE,TRUE,FALSE,'https://youtu.be/2k7Gz8avg0E','HSC','grant',10060,'2022-12-17'),
('3x3x3x3',19644,FALSE,TRUE,FALSE,'https://youtu.be/peONIUD98wk','HSC','grant',10061,'2022-12-20'),
('4x4x4x4',129707,FALSE,TRUE,FALSE,'https://youtu.be/QNjG5DUqn8g','HSC','grant',10062,'2022-12-20'),
('3x3x3x3',19397,FALSE,TRUE,FALSE,'https://youtu.be/W0efQkhPSzY','HSC','grant',10063,'2022-12-21'),
('3x3x3x3',18606,FALSE,TRUE,FALSE,'https://youtu.be/h2hTGc5Vztk','HSC','grant',10064,'2022-12-21'),
('2x2x2x2',5095,FALSE,TRUE,FALSE,'https://youtu.be/4tqXxtdtXms','HSC','grant',10065,'2022-12-21'),
('3x3x3x3',17997,FALSE,TRUE,FALSE,'https://youtu.be/kRBj6ScH8Ng','HSC','hactar',10066,'2022-12-22'),
('3x3x3x3',17934,FALSE,TRUE,FALSE,'https://youtu.be/9lMbBnA0tVE','HSC','grant',10067,'2022-12-23'),
('4x4x4x4',121848,FALSE,TRUE,FALSE,'https://youtu.be/B-VdP5h3fKo','HSC','grant',10068,'2022-12-23'),
('4x4x4x4',121848,FALSE,TRUE,FALSE,'https://youtu.be/B-VdP5h3fKo','HSC','grant',10069,'2022-12-23'),
('4x4x4x4',119708,FALSE,TRUE,FALSE,'https://youtu.be/EPAof7Hwrak','HSC','grant',10070,'2022-12-24'),
('4x4x4x4',115770,FALSE,TRUE,FALSE,'https://youtu.be/YRzjvrPVq7Q','HSC','grant',10071,'2022-12-28'),
('4x4x4x4',113384,FALSE,TRUE,FALSE,'https://youtu.be/bJndxs7QGyg','HSC','grant',10072,'2022-12-29'),
('5x5x5x5',346365,FALSE,TRUE,FALSE,'https://youtu.be/XwBNgjB9ZQI','HSC','grant',10073,'2022-12-30'),
('3x3x3x3',16281,FALSE,TRUE,FALSE,'https://youtu.be/pabZjfrsC-8','HSC','hactar',10074,'2022-12-30'),

('6x6x6x6',1174611,FALSE,TRUE,FALSE,'https://youtu.be/Pf0RPEprHDQ','HSC','luna',10076,'2022-12-31'),
('4x4x4x4',104134,FALSE,TRUE,FALSE,'https://youtu.be/4pjy5EwFSJg','HSC','grant',10077,'2022-12-31'),
('4x4x4x4',140672,FALSE,TRUE,FALSE,'https://youtu.be/KsRoTcOQ-IY','HSC','hactar',10078,'2023-01-01'),
('2x2x2x2',4998,FALSE,TRUE,FALSE,'https://youtu.be/n3R2qIP2yPU','HSC','grant',10079,'2023-01-01'),
('2x2x2x2',4852,FALSE,TRUE,FALSE,'https://youtu.be/BJh_CMfkMtI','HSC','grant',10080,'2023-01-01'),
('2x2x2x2',4475,FALSE,TRUE,FALSE,'https://youtu.be/d1beXWPKQaI','HSC','grant',10081,'2023-01-02'),
('3x3x3x3',16122,FALSE,TRUE,FALSE,'https://youtu.be/H9oFcK3paz0','HSC','hactar',10082,'2023-01-03'),
('4x4x4x4',103476,FALSE,TRUE,FALSE,'https://youtu.be/EEapFcWRnU8','HSC','hactar',10083,'2023-01-03'),
('5x5x5x5',384318,FALSE,TRUE,FALSE,'https://youtu.be/6PPG-ewLYfM','HSC','hactar',10084,'2023-01-03'),
('4x4x4x4',95975,FALSE,TRUE,FALSE,'https://youtu.be/ksJ9v262T5w','HSC','grant',10085,'2023-01-03'),
('4x4x4x4',94492,FALSE,TRUE,FALSE,'https://youtu.be/mLV8gsbr84A','HSC','grant',10086,'2023-01-03'),
('5x5x5x5',331304,FALSE,TRUE,FALSE,'https://youtu.be/olpjEnRlBbw','HSC','hactar',10087,'2023-01-04'),
('4x4x4x4',100707,FALSE,TRUE,FALSE,'https://youtu.be/2Tp8HZw2GZw','HSC','hactar',10088,'2023-01-04'),
('4x4x4x4',92821,FALSE,TRUE,FALSE,'https://youtu.be/1WFIZHuxhYE','HSC','hactar',10089,'2023-01-04'),
('5x5x5x5',299250,FALSE,TRUE,FALSE,'https://youtu.be/b4zOy7xk4uA','HSC','grant',10090,'2023-01-04'),
('4x4x4x4',91884,FALSE,TRUE,FALSE,'https://youtu.be/FwZUAQaqdnM','HSC','grant',10091,'2023-01-04'),
('4x4x4x4',87913,FALSE,TRUE,FALSE,'https://youtu.be/UF02k5xkEPU','HSC','grant',10092,'2023-01-04'),
('3x3x3x3',38504,FALSE,TRUE,FALSE,'https://youtu.be/mXQj55mNyA4','HSC','rowan',10093,'2023-01-04'),
('3x3x3x3',35830,FALSE,TRUE,FALSE,'https://youtu.be/bEffS6BZ6Wo','HSC','rowan',10094,'2023-01-04'),
('4x4x4x4',87891,FALSE,TRUE,FALSE,'https://youtu.be/f1KrsWIvMYc','HSC','hactar',10095,'2023-01-05'),
('4x4x4x4',87913,FALSE,TRUE,FALSE,'https://youtu.be/UF02k5xkEPU','HSC','grant',10096,'2023-01-05'),
('4x4x4x4',85044,FALSE,TRUE,FALSE,'https://youtu.be/Oqu6DjCHZbo','HSC','grant',10097,'2023-01-05'),
('4x4x4x4',84076,FALSE,TRUE,FALSE,'https://youtu.be/4ehj0gmGoV8','HSC','grant',10098,'2023-01-05'),
('3x3x3x3',35133,FALSE,TRUE,FALSE,'https://youtu.be/cukrSjxYWTk','HSC','rowan',10099,'2023-01-05'),
('3x3x3x3',34812,FALSE,TRUE,FALSE,'https://youtu.be/FQ036hBDQR4','HSC','rowan',10100,'2023-01-05'),
('3x3x3x3',34518,FALSE,TRUE,FALSE,'https://youtu.be/Bs4p1E3hZRQ','HSC','rowan',10101,'2023-01-05'),
('3x3x3x3',32717,FALSE,TRUE,FALSE,'https://youtu.be/LU89AsL2pow','HSC','rowan',10102,'2023-01-05'),
('5x5x5x5',251932,FALSE,TRUE,FALSE,'https://youtu.be/xTt-x6Jz8j4','HSC','grant',10103,'2023-01-05'),
('3x3x3x3',34873,FALSE,TRUE,FALSE,'https://youtu.be/ojT5uEyHYns','HSC','luna',10104,'2023-01-06'),
('4x4x4x4',80136,FALSE,TRUE,FALSE,'https://youtu.be/i8EMQ8okio4','HSC','grant',10105,'2023-01-06'),
('3x3x3x3',32188,FALSE,TRUE,FALSE,'https://youtu.be/99_DW8wPMzg','HSC','rowan',10106,'2023-01-06'),
('3x3x3x3',30229,FALSE,TRUE,FALSE,'https://youtu.be/XJBWLuSSv_I','HSC','rowan',10107,'2023-01-06'),
('4x4x4x4',83865,FALSE,TRUE,FALSE,'https://youtu.be/zWNz4V2bbpQ','HSC','hactar',10108,'2023-01-08'),
('3x3x3x3',15947,FALSE,TRUE,FALSE,'https://youtu.be/q9G5S3d6DFI','HSC','hactar',10109,'2023-01-08'),
('4x4x4x4',79778,FALSE,TRUE,FALSE,'https://youtu.be/B4x2dvRQrlw','HSC','grant',10110,'2023-01-08'),
('3x3x3x3',41867,FALSE,TRUE,FALSE,'https://youtu.be/ic-dY64zG_I','HSC','adam',10111,'2023-01-09'),
('3x3x3x3',34486,FALSE,TRUE,FALSE,'https://youtu.be/0cDdBok5cIw','HSC','adam',10112,'2023-01-09'),
('3x3x3x3',29527,FALSE,TRUE,FALSE,'https://youtu.be/9iROTxt2dN8','HSC','rowan',10113,'2023-01-09'),
('3x3x3x3',29097,FALSE,TRUE,FALSE,'https://youtu.be/QiOto9BDpig','HSC','rowan',10114,'2023-01-09'),
('3x3x3x3',28219,FALSE,TRUE,FALSE,'https://youtu.be/52O0SrN1XOQ','HSC','rowan',10115,'2023-01-11'),
('3x3x3x3',27462,FALSE,TRUE,FALSE,'https://youtu.be/g6za1EUXxE0','HSC','adam',10116,'2023-01-10'),
('3x3x3x3',134549,FALSE,TRUE,FALSE,'https://youtu.be/AyDDKsxcZqg','HSC','koen',10117,'2023-01-09'),
('3x3x3x3',14973,FALSE,TRUE,FALSE,'https://youtu.be/nozw5QzImrA','HSC','hactar',10118,'2023-01-11'),
('4x4x4x4',81455,FALSE,TRUE,FALSE,'https://youtu.be/GOCw_7XFYk4','HSC','hactar',10119,'2023-01-12'),
('4x4x4x4',79365,FALSE,TRUE,FALSE,'https://youtu.be/KbK1WwdBysk','HSC','hactar',10120,'2023-01-12'),
('3x3x3x3',27875,FALSE,TRUE,FALSE,'https://youtu.be/swLbg8NAx3Q','HSC','rowan',10121,'2023-01-12'),
('6x6x6x6',818654,FALSE,TRUE,FALSE,'https://youtu.be/O4OIobwI5oY','HSC','grant',10122,'2023-01-12'),
('4x4x4x4',75375,FALSE,TRUE,FALSE,'https://youtu.be/H_PjS1kTLmg','HSC','grant',10123,'2023-01-12'),
('5x5x5x5',266504,FALSE,TRUE,FALSE,'https://youtu.be/-ONUyJeTFSg','HSC','hactar',10124,'2023-01-12'),
('5x5x5x5',234351,FALSE,TRUE,FALSE,'https://youtu.be/ZFRuk_oSjKM','HSC','grant',10125,'2023-01-12'),
('3x3x3x3',22930,FALSE,TRUE,FALSE,'https://youtu.be/QSCIGmSABVY','HSC','adam',10126,'2023-01-12'),
('4x4x4x4',74814,FALSE,TRUE,FALSE,'https://youtu.be/_bMkaHA4ZFs','HSC','hactar',10127,'2023-01-13'),
('4x4x4x4',74522,FALSE,TRUE,FALSE,'https://youtu.be/eHDN2TicLcE','HSC','hactar',10128,'2023-01-13'),
('4x4x4x4',70285,FALSE,TRUE,FALSE,'https://youtu.be/rqbR5I43G4M','HSC','hactar',10129,'2023-01-13'),
('4x4x4x4',69960,FALSE,TRUE,FALSE,'https://youtu.be/-L43UAoGNmk','HSC','hactar',10130,'2023-01-13'),
('4x4x4x4',68235,FALSE,TRUE,FALSE,'https://youtu.be/7CTL0pjRG4w','HSC','hactar',10131,'2023-01-13'),
('5x5x5x5',259578,FALSE,TRUE,FALSE,'https://youtu.be/xUU8CC7xmGY','HSC','hactar',10132,'2023-01-13'),
('4x4x4x4',71453,FALSE,TRUE,FALSE,'https://youtu.be/AJh3AOKyX1E','HSC','grant',10133,'2023-01-14'),
('4x4x4x4',70456,FALSE,TRUE,FALSE,'https://youtu.be/GCybCB9PC8o','HSC','grant',10134,'2023-01-14'),
('2x2x2x2',4354,FALSE,TRUE,FALSE,'https://youtu.be/llaOZYJ4cUw','HSC','adam',10135,'2023-01-16'),
('2x2x2x2',3940,FALSE,TRUE,FALSE,'https://youtu.be/RiQJhLsLo6Q','HSC','adam',10136,'2023-01-16'),
('3x3x3x3',26770,FALSE,TRUE,FALSE,'https://youtu.be/brIlUqm8StQ','HSC','rowan',10137,'2023-01-12'),
('3x3x3x3',26002,FALSE,TRUE,FALSE,'https://youtu.be/3U3wqyxmBM4','HSC','rowan',10138,'2023-01-12'),
('4x4x4x4',67671,FALSE,TRUE,FALSE,'https://youtu.be/62HWyvdgTEA','HSC','grant',10139,'2023-01-17'),
('5x5x5x5',207354,FALSE,TRUE,FALSE,'https://youtu.be/rxnMhbPmf-E','HSC','grant',10140,'2023-01-17'),
('5x5x5x5',240476,FALSE,TRUE,FALSE,'https://youtu.be/i92ywhxPUW4','HSC','hactar',10141,'2023-01-18'),
('6x6x6x6',592528,FALSE,TRUE,FALSE,'https://youtu.be/UDj1Z8f6GkQ','HSC','grant',10142,'2023-01-18'),
('3-layer_simplex',49542,FALSE,FALSE,FALSE,'https://youtu.be/yh_VfAj0JZM','MC4D','grant',10143,'2023-01-19'),
('5x5x5x5',202721,FALSE,TRUE,FALSE,'https://youtu.be/EnTw_0gIjAM','HSC','grant',10144,'2023-01-20'),
('7x7x7x7',1679994,FALSE,TRUE,FALSE,'https://youtu.be/JRBA1wgwrGE','HSC','hactar',10145,'2023-01-21'),
('7x7x7x7',1243751,FALSE,TRUE,FALSE,'https://youtu.be/x46AeM3WZt0','HSC','grant',10146,'2023-01-22'),
('5x5x5x5',186698,FALSE,TRUE,FALSE,'https://youtu.be/LgQn5VwOOTE','HSC','grant',10147,'2023-01-23'),
('3-layer_simplex',13404,FALSE,FALSE,FALSE,'https://youtu.be/yWhzox9UowA','MC4D','rowan',10148,'2023-01-23'),
('3-layer_simplex',37101,FALSE,FALSE,FALSE,'https://youtu.be/LD5QMmJ59ZA','MC4D','grant',10149,'2023-01-24'),
('3-layer_simplex',10345,FALSE,FALSE,FALSE,'https://youtu.be/pj9wdn2N2-k','MC4D','rowan',10150,'2023-01-25'),
('3-layer_simplex',9046,FALSE,FALSE,FALSE,'https://youtu.be/6bK_JCjptKA','MC4D','rowan',10151,'2023-01-26'),
('4x4x4x4',67368,FALSE,TRUE,FALSE,'https://youtu.be/DiKVlWnkLMA','HSC','grant',10152,'2023-01-29'),
('4x4x4x4',64423,FALSE,TRUE,FALSE,'https://youtu.be/fUQDZrJc7fA','HSC','grant',10153,'2023-01-30'),
('5x5x5x5',179851,FALSE,TRUE,FALSE,'https://youtu.be/5qKbs4vMg5s','HSC','grant',10154,'2023-02-01'),
('6x6x6x6',536990,FALSE,TRUE,FALSE,'https://youtu.be/070wpxcYv8Q','HSC','grant',10155,'2023-02-02'),
('4x4x4x4',63321,FALSE,TRUE,FALSE,'https://youtu.be/G36FdhIFykE','HSC','grant',10156,'2023-02-16'),
('3x3x3x3',14646,FALSE,TRUE,FALSE,'https://youtu.be/hQA0LWWAZPI','HSC','hactar',10157,'2023-02-18'),

('4x4x4x4',60355,FALSE,TRUE,FALSE,'https://youtu.be/Q_N8O_hAOlY','HSC','grant',10159,'2023-02-18'),
('3x3x3x3',25292,FALSE,TRUE,FALSE,'https://youtu.be/l6aL7oAFOLk','HSC','rowan',10160,'2023-02-21'),
('5x5x5x5',173895,FALSE,TRUE,FALSE,'https://youtu.be/vPiTyP2ZMtk','HSC','grant',10161,'2023-02-21'),
('4x4x4x4',59070,FALSE,TRUE,FALSE,'https://youtu.be/BmqDHmlsGec','HSC','grant',10162,'2023-02-23'),
('3x3x3x3',16126,FALSE,TRUE,FALSE,'https://youtu.be/6xT1PNnTNEI','HSC','grant',10163,'2023-02-24'),

('3x3x3x3',15788,FALSE,TRUE,FALSE,'https://youtu.be/z1rYqGrCvyQ','HSC','grant',10165,'2023-02-25'),
('3x3x3x3',15068,FALSE,TRUE,FALSE,'https://youtu.be/7nFmTgpqsxo','HSC','grant',10166,'2023-02-25'),
('6x6x6x6',500552,FALSE,TRUE,FALSE,'https://youtu.be/1EJOe_MSHbI','HSC','grant',10167,'2023-03-03'),
('3x3x3x3',14101,FALSE,TRUE,FALSE,'https://youtu.be/NErcg6OBdyE','HSC','grant',10168,'2023-03-08'),
('2x2x2x2',3623,FALSE,TRUE,FALSE,'https://youtu.be/SXp8wnUnKYM','HSC','grant',10169,'2023-03-08'),
('3-layer_simplex',20974,FALSE,FALSE,FALSE,'https://youtu.be/kf1ARFimzDY','MC4D','grant',10170,'2023-03-09'),

('3-layer_simplex',15642,FALSE,FALSE,FALSE,'https://youtu.be/qn4XTJHJoR8','MC4D','grant',10172,'2023-03-10'),
('3x3x3x3',13797,FALSE,TRUE,FALSE,'https://youtu.be/AWJ5TOo9-w8','HSC','hactar',10173,'2023-03-11'),


('3-layer_simplex',13637,FALSE,FALSE,FALSE,'https://youtu.be/IX03Z-FtdnE','MC4D','grant',10176,'2023-03-14'),
('3-layer_simplex',10876,FALSE,FALSE,FALSE,'https://youtu.be/d39sWJ7yAfM','MC4D','grant',10177,'2023-03-14'),
('3-layer_simplex',10319,FALSE,FALSE,FALSE,'https://youtu.be/OrwPbHLGLO0','MC4D','grant',10178,'2023-03-15'),
('3-layer_simplex',9416,FALSE,FALSE,FALSE,'https://youtu.be/RTyC-Gmm-9s','MC4D','grant',10179,'2023-03-15'),
('3-layer_simplex',9111,FALSE,FALSE,FALSE,'https://youtu.be/MD18ru7nAVI','MC4D','grant',10180,'2023-03-15'),
('3-layer_simplex',7770,FALSE,FALSE,FALSE,'https://youtu.be/fFJVEfFA-uo','MC4D','grant',10181,'2023-03-15'),
('3x3x3x3',13133,FALSE,TRUE,FALSE,'https://youtu.be/SCkKA-ua2AQ','HSC','grant',10182,'2023-03-16'),
('5x5x5x5',169431,FALSE,TRUE,FALSE,'https://youtu.be/QkFR1WzMCzc','HSC','grant',10183,'2023-03-17'),
('hemimegaminx',27057,FALSE,FALSE,FALSE,'https://youtu.be/nFOb5ueM6sQ','MT','luna',10184,'2023-03-18'),
('hemimegaminx',17405,FALSE,FALSE,FALSE,'https://youtu.be/uk_I82NLuwY','MT','luna',10185,'2023-03-18'),
('hemimegaminx',21586,FALSE,FALSE,FALSE,'https://youtu.be/8ldHKvKunyw','MT','grant',10186,'2023-03-18'),
('hemimegaminx',13999,FALSE,FALSE,FALSE,'https://youtu.be/o5Xa6v0y9J8','MT','grant',10187,'2023-03-18'),
('hemimegaminx',13157,FALSE,FALSE,FALSE,'https://youtu.be/ktjpFhnArHE','MT','luna',10188,'2023-03-18'),
('hemimegaminx',12652,FALSE,FALSE,FALSE,'https://youtu.be/Jry6rXRHgmc','MT','luna',10189,'2023-03-18'),
('hemimegaminx',11194,FALSE,FALSE,FALSE,'https://youtu.be/hKelDJ4rkLI','MT','grant',10190,'2023-03-19'),
('1x3x3x3',8739,FALSE,FALSE,FALSE,'https://youtu.be/1GfM06GsWp4','MPU','grant',10191,'2023-03-20'),
('phys_2x2x2x2',10240,FALSE,FALSE,FALSE,'https://youtu.be/Nty_vtso5Pk','-','cubedude',10192,'2023-03-30'),
('virt_phys_3x3x3x3',103175,FALSE,FALSE,FALSE,'https://youtu.be/P8AG5AGeu40','AKKEI-SIM','grant',10193,'2023-03-29'),
('virt_phys_3x3x3x3',286381,FALSE,FALSE,FALSE,'https://youtu.be/23dSS3ojZoE','AKKEI-SIM','hyperespy',10194,'2023-04-04'),
('virt_phys_3x3x3x3',87306,FALSE,FALSE,FALSE,'https://youtu.be/M6Jb5v-xAuE','AKKEI-SIM','grant',10195,'2023-04-04'),

('3x3x3x3',12730,FALSE,TRUE,FALSE,'https://youtu.be/4Ai_cuY6XSs','HSC','hactar',10197,'2023-04-08'),

('virt_phys_3x3x3x3',72525,FALSE,FALSE,FALSE,'https://youtu.be/lOsFAVkSxKc','AKKEI-SIM','grant',10199,'2023-04-09'),

('virt_phys_3x3x3x3',268149,FALSE,FALSE,FALSE,'https://youtu.be/RbxinDf2wv8','AKKEI-SIM','hyperespy',10201,'2023-04-12'),
('virt_phys_3x3x3x3',69066,FALSE,FALSE,FALSE,'https://youtu.be/zLmOY8gM1zs','AKKEI-SIM','grant',10202,'2023-04-12'),
('virt_phys_3x3x3x3',65878,FALSE,FALSE,FALSE,'https://youtu.be/OXPmZOEf9IE','AKKEI-SIM','grant',10203,'2023-04-18'),
('virt_phys_3x3x3x3',65421,FALSE,FALSE,FALSE,'https://youtu.be/R15N-WjDwU4','AKKEI-SIM','grant',10204,'2023-04-20'),
('virt_phys_3x3x3x3',63007,FALSE,FALSE,FALSE,'https://youtu.be/oDCqOAPATgA','AKKEI-SIM','grant',10205,'2023-04-20'),
('3x3x3x3',12383,FALSE,TRUE,FALSE,'https://youtu.be/-uFD_WwX4po','HSC','grant',10206,'2023-04-21'),

('3x3x3x3',12530,FALSE,TRUE,FALSE,'https://youtu.be/PtXvGfoezWs','HSC','hactar',10208,'2023-04-22'),

('4x4x4x4',58742,FALSE,TRUE,FALSE,'https://youtu.be/64fP1z2m6Jc','HSC','grant',10210,'2023-04-25'),
('4x4x4x4',53568,FALSE,TRUE,FALSE,'https://youtu.be/fmCI0vlKTrU','HSC','grant',10211,'2023-04-25'),
('4x4x4x4',53297,FALSE,TRUE,FALSE,'https://youtu.be/iWuBfNMeoWE','HSC','grant',10212,'2023-04-26'),
('5x5x5x5',162897,FALSE,TRUE,FALSE,'https://youtu.be/oyYFe5GSEUE','HSC','grant',10213,'2023-04-27'),
('virt_phys_3x3x3x3',59895,FALSE,FALSE,FALSE,'https://youtu.be/c4vTxQZcmDk','AKKEI-SIM','grant',10214,'2023-05-03'),
('virt_phys_3x3x3x3',330600,FALSE,FALSE,FALSE,'https://www.loom.com/share/a0e16bba46eb49b097ffe8657595eed4','AKKEI-SIM','kevin',10215,'2023-05-05'),
('5x5x5x5',151108,FALSE,TRUE,FALSE,'https://youtu.be/ejbcyheNJiU','HSC','grant',10216,'2023-05-06'),
('phys_2x2x2x2',283400,TRUE,FALSE,FALSE,'https://youtu.be/lBssOimXaFE','-','asa',10217,'2022-08-08'),
('3x3x3x3',487768,TRUE,FALSE,FALSE,'https://youtu.be/zJS5bn7Hmto','MC4D','yuste',10218,'2022-03-17'),
('2x2x2x2',88155,TRUE,FALSE,FALSE,'https://youtu.be/b1r6sBgTIoE','MC4D','gray',10219,'2019-10-12'),
('6x6x6x6',477089,FALSE,TRUE,FALSE,'https://youtu.be/JCRQsKqWL-o','HSC','grant',10220,'2023-05-09'),
('6x6x6x6',434258,FALSE,TRUE,FALSE,'https://youtu.be/AejkKnh2ut4','HSC','grant',10221,'2023-05-10'),
('2x2x2x2',3495,FALSE,TRUE,FALSE,'https://youtu.be/ahKlBFZmkYk','HSC','grant',10222,'2023-05-11'),

('3x3x3x3',11642,FALSE,TRUE,FALSE,'https://youtu.be/SrrmSdtOt14','HSC','hactar',10224,'2023-05-13'),
('5x5x5x5',142258,FALSE,TRUE,FALSE,'https://youtu.be/rq448vFu1dM','HSC','grant',10225,'2023-05-13'),
('6x6x6x6',389788,FALSE,TRUE,FALSE,'https://youtu.be/BTBhZZSYFpY','HSC','grant',10226,'2023-05-15'),
('2x2x2x2',3459,FALSE,TRUE,FALSE,'https://youtu.be/ED-CxpM76yU','HSC','grant',10227,'2023-05-16'),
('2x2x2x2',3417,FALSE,TRUE,FALSE,'https://youtu.be/ecIo0eD7BxU','HSC','grant',10228,'2023-05-20'),
('2x2x2x2',3334,FALSE,TRUE,FALSE,'https://youtu.be/lg4Rm_Wh9Qw','HSC','grant',10229,'2023-05-20'),
('6x6x6x6',380350,FALSE,TRUE,FALSE,'https://youtu.be/bPVrqBQmRQk','HSC','grant',10230,'2023-05-23'),
('2x2x2x2',3164,FALSE,TRUE,FALSE,'https://youtu.be/RDFJSIQ8uJ0','HSC','grant',10231,'2023-05-23'),
('2x2x2x2',2851,FALSE,TRUE,FALSE,'https://youtu.be/KhEzYs9vwuo','HSC','grant',10232,'2023-05-24'),
('5x5x5x5',139910,FALSE,TRUE,FALSE,'https://youtu.be/sL20osNa5I8','HSC','grant',10233,'2023-05-27'),
('5x5x5x5',133178,FALSE,TRUE,FALSE,'https://youtu.be/uHhPlIZ2PGU','HSC','grant',10234,'2023-05-29'),
('6x6x6x6',363115,FALSE,TRUE,FALSE,'https://youtu.be/3aSo8sjhBUs','HSC','grant',10235,'2023-05-29'),
('7x7x7x7',790197,FALSE,TRUE,FALSE,'https://youtu.be/b4ChatHg8AM','HSC','grant',10236,'2023-05-31'),
('1x3x3x3',8434,FALSE,FALSE,FALSE,'https://youtu.be/1-W78yF5eHM','MPU','luna',10237,'2023-05-31'),
('1x3x3x3',6291,FALSE,FALSE,FALSE,'https://youtu.be/bfXTiTIip-k','MPU','luna',10238,'2023-05-31'),
('1x3x3x3',6093,FALSE,FALSE,FALSE,'https://youtu.be/RKoZfNSLCGs','MPU','hactar',10239,'2023-05-31'),
('1x3x3x3',7558,FALSE,FALSE,FALSE,'https://youtu.be/iwFQTZnhqhk','MPU','rowan',10240,'2023-05-31'),
('5x5x5x5',130412,FALSE,TRUE,FALSE,'https://youtu.be/fljQSZgPTUg','HSC','grant',10241,'2023-06-02'),
('6x6x6x6',336394,FALSE,TRUE,FALSE,'https://youtu.be/Ri0eBwzbRJE','HSC','grant',10242,'2023-06-02'),
('3x3x3x3',121386,FALSE,TRUE,FALSE,'https://youtu.be/ADe3-T-hkmo','HSC','olaf',10243,'2023-06-06'),
('3x3x3x3',106664,FALSE,TRUE,FALSE,'https://youtu.be/cL5RmBX-XQg','HSC','olaf',10244,'2023-06-06'),
('3x3x3x3',83631,FALSE,TRUE,FALSE,'https://youtu.be/UjJEtBTvR9E','HSC','olaf',10245,'2023-06-07'),
('3x3x3x3',67075,FALSE,TRUE,FALSE,'https://youtu.be/YRNwPoReYz0','HSC','olaf',10246,'2023-06-08'),
('3x3x3x3',63356,FALSE,TRUE,FALSE,'https://youtu.be/PxqEWMKzHSw','HSC','olaf',10247,'2023-06-09'),
('3x3x3x3',58425,FALSE,TRUE,FALSE,'https://youtu.be/HAU44_mZPn8','HSC','olaf',10248,'2023-06-10'),
('3x3x3x3',51836,FALSE,TRUE,FALSE,'https://youtu.be/06FYcnJ2_6g','HSC','olaf',10249,'2023-06-11'),
('3x3x3x3',121292,FALSE,TRUE,FALSE,'https://youtu.be/wpXmJrI48R8','HSC','void',10250,'2023-06-11'),
('3x3x3x3',47560,FALSE,TRUE,FALSE,'https://youtu.be/CvX6ozCVKys','HSC','olaf',10251,'2023-06-12'),
('3x3x3x3',103992,FALSE,TRUE,FALSE,'https://youtu.be/t2sK39vuSmk','HSC','void',10252,'2023-06-28'),
('3x3x3x3',103992,FALSE,TRUE,FALSE,'https://youtu.be/t2sK39vuSmk','HSC','void',10253,'2023-06-28'),
('3x3x3_1d',94539,FALSE,FALSE,FALSE,'https://youtu.be/TPbJAP82Fno','MC3D','markk',10254,'2022-12-02'),
('3x3x3_1d',45418,FALSE,FALSE,FALSE,'https://youtu.be/XeRAYpf8Tqw','MC3D','grant',10255,'2023-07-03'),
('3x3x3x3',33339,FALSE,FALSE,FALSE,'https://youtu.be/RCO9Fawp7Y4','HSC','grant',10256,'2023-07-03'),
('3x3x3x3',31601,FALSE,FALSE,FALSE,'https://youtu.be/35VjKjeWSCg','HSC','grant',10257,'2023-07-03'),
('3x3x3_1d',38439,FALSE,FALSE,FALSE,'https://youtu.be/ULlDZxWC7mk','MC3D','grant',10258,'2023-07-04'),
('3x3x3_1d',31071,FALSE,FALSE,FALSE,'https://youtu.be/txgOhBHjKaY','MC3D','grant',10259,'2023-07-04'),
('3x3x3_1d',26021,FALSE,FALSE,FALSE,'https://youtu.be/dwYodrQgKHg','MC3D','grant',10260,'2023-07-04'),
('3x3x3_1d',20220,FALSE,FALSE,FALSE,'https://youtu.be/lsCk5keMWLU','MC3D','grant',10261,'2023-07-05'),
('3x3x3x3',25039,FALSE,TRUE,FALSE,'https://youtu.be/roZdgUpJfvY','HSC','rowan',10262,'2023-07-06'),
('phys_2x2x2x2',10030,FALSE,FALSE,FALSE,'https://youtu.be/_Z8qO2i1FlE','-','origamist',10263,'2023-07-08'),
('3x3x3x3',92262,FALSE,TRUE,FALSE,'https://youtu.be/4L-gCZlWAaU','HSC','tymofro',10264,'2023-07-17'),
('7x7x7x7',710123,FALSE,TRUE,FALSE,'https://youtu.be/WJf4uhtQEMI','HSC','grant',10265,'2023-07-18'),
('3x3x3x3',24783,FALSE,TRUE,FALSE,'https://youtu.be/R2ngXs9dVLQ','HSC','rowan',10266,'2023-07-13'),
('5x5x5x5',130087,FALSE,TRUE,FALSE,'https://youtu.be/oGPEnVKT9-c','HSC','grant',10267,'2023-07-20'),
('3x3x3x3',76846,FALSE,TRUE,FALSE,'https://youtu.be/Zyyt7J1eVDs','HSC','tymofro',10268,'2023-07-21'),
('3x3x3x3',64157,FALSE,TRUE,FALSE,'https://youtu.be/bjILjlmZoio','HSC','tymofro',10269,'2023-07-22'),
('3x3x3x3',54877,FALSE,TRUE,FALSE,'https://youtu.be/zaTLgeDAOFw','HSC','tymofro',10270,'2023-07-22'),
('5x5x5x5',124893,FALSE,TRUE,FALSE,'https://youtu.be/tvVuZFT3jU8','HSC','grant',10271,'2023-07-22'),
('4x4x4x4',204012,FALSE,TRUE,FALSE,'https://youtu.be/xhS16iej5Ok','HSC','tymofro',10272,'2023-07-25'),
('5x5x5x5',121728,FALSE,TRUE,FALSE,'https://youtu.be/F9i6o3k5ABA','HSC','grant',10273,'2023-07-26'),
('3x3x3x3',43972,FALSE,TRUE,FALSE,'https://youtu.be/wlWdlq_a05U','HSC','tymofro',10274,'2023-07-27'),
('5x5x5x5',119761,FALSE,TRUE,FALSE,'https://youtu.be/gaBJShR4u8w','HSC','grant',10275,'2023-07-27'),
('4x4x4x4',51256,FALSE,TRUE,FALSE,'https://youtu.be/CDrpyEjgrOg','HSC','grant',10276,'2023-07-27'),
('3x3x3x3',41454,FALSE,TRUE,FALSE,'https://youtu.be/TU5S5TPDbog','HSC','tymofro',10277,'2023-07-31'),
('4x4x4x4',51066,FALSE,TRUE,FALSE,'https://youtu.be/Py-piV263Mg','HSC','grant',10278,'2023-07-31'),
('4x4x4x4',47577,FALSE,TRUE,FALSE,'https://youtu.be/Bc3gRz48i5c','HSC','grant',10279,'2023-08-01'),
('4x4x4x4',156996,FALSE,TRUE,FALSE,'https://youtu.be/8O0YmAdJstg','HSC','tymofro',10280,'2023-08-02'),
('3x3x3x3',24282,FALSE,TRUE,FALSE,'https://youtu.be/OfmH62is4Dc','HSC','rowan',10281,'2023-08-12'),
('3x3x3x3',20822,FALSE,TRUE,FALSE,'https://youtu.be/VZl_iApw7W0','HSC','adam',10282,'2023-08-15'),

('3x3x3x3',38238,FALSE,TRUE,FALSE,'https://youtu.be/c3L8RSbqnnI','HSC','tymofro',10284,'2023-08-16'),
('phys_2x2x2x2',12193,FALSE,FALSE,FALSE,'https://youtu.be/ABPm1N1F_Vk','-','tymofro',10285,'2023-08-16'),
('2x2x2x2',5452,FALSE,TRUE,FALSE,'https://youtu.be/s_yGYpFB8R4','HSC','tymofro',10286,'2023-08-17'),
('3x3x3x3',34188,FALSE,TRUE,FALSE,'https://youtu.be/LyAuoZqpGfY','HSC','tymofro',10287,'2023-08-21'),
('3x3x3x3',27315,FALSE,TRUE,FALSE,'https://youtu.be/x-aMzC9gHqQ','HSC','tymofro',10288,'2023-08-22'),
('6x6x6x6',1031400,FALSE,TRUE,FALSE,'https://youtu.be/uZpmCn9iGJE?t=1h13m30s','HSC','hactar',10289,'2023-08-30'),
('phys_2x2x2x2',8610,FALSE,FALSE,FALSE,'https://youtu.be/RJ7e1_PxeW0','-','tymofro',10290,'2023-09-17'),
('3x3x3x3',29439,FALSE,TRUE,FALSE,'https://youtu.be/D7sZl_bAtMU','HSC','edan',10291,'2023-09-20'),
('2x2x2x2',2649,FALSE,TRUE,FALSE,'https://youtu.be/rTgxBHHt0Ak','HSC','adam',10292,'2023-09-23'),
('5x5x5x5',523078,FALSE,TRUE,FALSE,'https://youtu.be/evhr87J66zo','HSC','tymofro',10293,'2023-10-01'),

('3x3x3x3',23323,FALSE,TRUE,FALSE,'https://youtu.be/71EeEOsXyVo','HSC','edan',10295,'2023-10-12'),

('3x3x3x3',57268,FALSE,TRUE,FALSE,'https://youtu.be/T1MVA03HSBw?t=1346s','HSC','myigiter',10297,'2023-10-25'),
('3x3x3x3',59404,FALSE,TRUE,FALSE,'https://youtu.be/Pu-wDjYdz5U','HSC','battistin',10298,'2023-10-29'),
('3x3x3x3',51899,FALSE,TRUE,FALSE,'https://youtu.be/_nGfPD-YGnk','HSC','battistin',10299,'2023-10-31'),
('3x3x3x3',49863,FALSE,TRUE,FALSE,'https://youtu.be/kzRoWZc2j9Q','HSC','battistin',10300,'2023-11-02'),
('3x3x3x3',47479,FALSE,TRUE,FALSE,'https://youtu.be/hNWsKQmArkM','HSC','battistin',10301,'2023-11-04'),
('1x3x3x3',7964,FALSE,FALSE,FALSE,'https://youtu.be/gOdrzT-7MAk','MPU','tymofro',10302,'2023-11-04'),
('3x3x3x3',44484,FALSE,TRUE,FALSE,'https://youtu.be/l-wY_SiH2Og','HSC','battistin',10303,'2023-11-05'),
('3x3x3x3',37969,FALSE,TRUE,FALSE,'https://youtu.be/bs6oIkKCQeE','HSC','battistin',10304,'2023-11-06'),
('1x3x3x3',6671,FALSE,FALSE,FALSE,'https://youtu.be/2YDTJ6pPwi0','MPU','tymofro',10305,'2023-11-10'),
('phys_2x2x2x2',7968,FALSE,FALSE,FALSE,'https://youtu.be/lvTLmdc1YQM','-','tymofro',10306,'2023-11-07'),
('1x3x3x3',5746,FALSE,FALSE,FALSE,'https://youtu.be/q3nDUfcsmAk','MPU','tymofro',10307,'2023-11-11'),
('4x4x4x4',359581,FALSE,TRUE,FALSE,'https://youtu.be/ZIgGori6nFM','HSC','battistin',10308,'2023-11-10'),
('phys_2x2x2x2',9146,FALSE,FALSE,FALSE,'https://youtu.be/UrGPHa6K4Kk','-','danielcohen',10309,'2024-01-21'),
('3x3x3x3',24237,FALSE,TRUE,FALSE,'https://youtu.be/NzdnhFx4fuc','HSC','rowan',10310,'2024-01-22'),
('3x3x3x3',23565,FALSE,TRUE,FALSE,'https://youtu.be/aNKQOBKEPUM','HSC','rowan',10311,'2024-01-24'),
('3x3x3x3',24870,FALSE,TRUE,FALSE,'https://youtu.be/RkuC2oPCKdE','HSC','tymofro',10312,'2024-01-25'),
('3x3x3x3',87968,FALSE,TRUE,FALSE,'https://youtu.be/_UzbQ9PNDz8','HSC','ethandavis',10313,'2024-01-27'),
('3x3x3x3',22538,FALSE,TRUE,FALSE,'https://youtu.be/MqDiqdas_0I','HSC','rowan',10314,'2024-01-28'),
('3x3x3x3',51114,FALSE,TRUE,FALSE,'https://youtu.be/Cc89UGu-ha4','HSC','pkearth',10315,'2024-01-30'),
('3x3x3x3',23345,FALSE,TRUE,FALSE,'https://youtu.be/GqGpEgfqIRk','HSC','tymofro',10316,'2024-02-12'),
('3x3x3x3',20280,FALSE,TRUE,FALSE,'https://youtu.be/u-gcnW_ZQmU','HSC','edan',10317,'2024-02-13'),
('hemimegaminx',10769,FALSE,FALSE,FALSE,'https://youtu.be/6Tez6T6YJqE','MT','milojacquet',10318,'2024-03-06'),
('4x4x4x4',67284,FALSE,TRUE,FALSE,'https://youtu.be/aUTQ8tLEZoA','HSC','hactar',10319,'2024-03-11'),
('4x4x4x4',60547,FALSE,TRUE,FALSE,'https://youtu.be/MCBQJOjkBpg','HSC','hactar',10320,'2024-03-15'),
('4x4x4x4',58450,FALSE,TRUE,FALSE,'https://youtu.be/2laArWGh5tY','HSC','hactar',10321,'2024-03-17'),
('2x2x2x2',4537,FALSE,TRUE,FALSE,'https://youtu.be/bf__m479QjY','HSC','tymofro',10322,'2024-03-19'),
('4x4x4x4',140181,FALSE,TRUE,FALSE,'https://youtu.be/j4OZFwm2cGc','HSC','tymofro',10323,'2024-03-19'),
('4x4x4x4',52521,FALSE,TRUE,FALSE,'https://youtu.be/su6L9XZ5aWE','HSC','hactar',10324,'2024-03-20'),
('4x4x4x4',107281,FALSE,TRUE,FALSE,'https://youtu.be/YAiat68eqpY','HSC','tymofro',10325,'2024-03-21'),
('hemimegaminx',112712,FALSE,FALSE,FALSE,'https://youtu.be/bxekDe2pWH8','-','akkei',10326,'2024-03-21'),
('3x3x3x3x3',1314124,FALSE,TRUE,FALSE,'https://youtu.be/Byl0Wz6gdf4','MC7D','luna',10327,'2024-03-22'),
('2x2x2x2x2',652350,FALSE,FALSE,FALSE,'https://youtu.be/Eqgq2g6fZy8','MPU','luna',10328,'2024-03-23'),

('hemimegaminx',32297,FALSE,FALSE,FALSE,'https://youtu.be/lipNaShkSd4','MT','battistin',10330,'2024-03-26'),
('3x3x3x3',35099,FALSE,TRUE,FALSE,'https://youtu.be/4akee0AGdoA','HSC','battistin',10331,'2024-03-29'),
('hemimegaminx',9167,FALSE,FALSE,FALSE,'https://youtu.be/m4Cu4xVmWhU','MT','milojacquet',10332,'2024-03-31'),
('2x2x2x2x2',438726,FALSE,FALSE,FALSE,'https://youtu.be/3WXFnsGD8oM','MPU','tymofro',10333,'2024-04-01'),
('klein_quartic',145441,FALSE,FALSE,FALSE,'https://youtu.be/0CUggoK9i3g','MT','milojacquet',10334,'2024-04-04'),
('3x3x3x3',32978,FALSE,TRUE,FALSE,'https://youtu.be/w7WkA3RaAok','HSC','battistin',10335,'2024-04-06'),
('3x3x3x3x3',1187966,FALSE,TRUE,FALSE,'https://youtu.be/Ai0P58dWNLY','MC7D','luna',10336,'2024-04-07'),
('4x4x4x4',49282,FALSE,TRUE,FALSE,'https://youtu.be/GqojR2pRlOM','HSC','hactar',10337,'2024-04-06'),
('1x3x3x3',7335,FALSE,FALSE,FALSE,'https://youtu.be/76to6wms_04','MPU','rowan',10338,'2024-03-31'),
('3x3x3x3x3',2845960,FALSE,TRUE,FALSE,'https://youtu.be/z9WT6wnmdDM','MC7D','rowan',10339,'2024-04-06'),
('3x3x3x3',21444,FALSE,TRUE,FALSE,'https://youtu.be/b6a2QIcrZg8','HSC','rowan',10340,'2024-04-08'),
('phys_2x2x2x2',7199,FALSE,FALSE,FALSE,'https://youtu.be/uCpi3Fbje0s','-','cubedude',10341,'2024-04-17'),
('phys_2x2x2x2',5814,FALSE,FALSE,FALSE,'https://youtu.be/hW6bVavOc-I','-','cubedude',10342,'2024-04-18'),

('4x4x4x4',47518,FALSE,TRUE,FALSE,'https://youtu.be/pMOW7a2U6SE','HSC','hactar',10344,'2024-04-22'),
('4x4x4x4',145512,FALSE,TRUE,FALSE,'https://youtu.be/xmOiIFoLQ_I','HSC','luna',10345,'2024-04-24'),
('4x4x4x4',47261,FALSE,TRUE,FALSE,'https://youtu.be/bgWOYE3e7pM','HSC','hactar',10346,'2024-04-24'),
('4x4x4x4',277915,FALSE,TRUE,FALSE,'https://youtu.be/NJHYnPmOq3c','HSC','rowan',10347,'2024-04-24'),
('4x4x4x4',202290,FALSE,TRUE,FALSE,'https://youtu.be/dIphYAbQ3BU','HSC','rowan',10348,'2024-04-24'),
('5x5x5x5',174738,FALSE,TRUE,FALSE,'https://youtu.be/GGKOSVbxZlA','HSC','hactar',10349,'2024-04-26'),
('4x4x4x4x4',5522449,FALSE,FALSE,FALSE,'https://youtu.be/GlBOvjiA028','MPU','luna',10350,'2024-04-26'),
('5x5x5x5',157151,FALSE,TRUE,FALSE,'https://youtu.be/iJXl5mew5YU','HSC','hactar',10351,'2024-04-29'),
('3x3x3x3',34196,FALSE,TRUE,FALSE,'https://youtu.be/yC3VmIp3jJQ','HSC','koen',10352,'2024-05-02'),
('5x5x5x5',136349,FALSE,TRUE,FALSE,'https://youtu.be/KKoIoJWRf2s','HSC','hactar',10353,'2024-05-05'),
('5x5x5x5',133214,FALSE,TRUE,FALSE,'https://youtu.be/wkZIQs0Ll-Q','HSC','hactar',10354,'2024-05-08'),
('5x5x5x5',129979,FALSE,TRUE,FALSE,'https://youtu.be/tAuYkESScRY','HSC','hactar',10355,'2024-05-09'),
('5x5x5x5',128687,FALSE,TRUE,FALSE,'https://youtu.be/0D09Opu08Rc','HSC','hactar',10356,'2024-05-13'),
('5x5x5x5',117575,FALSE,TRUE,FALSE,'https://youtu.be/h4qHy86rlgk','HSC','hactar',10357,'2024-05-16'),
('3x3x3x3',74834,FALSE,TRUE,FALSE,'https://youtu.be/SwdhFsdlRP4','HSC','godly',10358,'2024-05-18'),
('3x3x3x3',59538,FALSE,TRUE,FALSE,'https://youtu.be/A7X3T8Qddgg','HSC','godly',10359,'2024-05-22'),
('2x2x2x2',157543,TRUE,TRUE,FALSE,'https://youtu.be/cOitk0E8Mxk','HSC','jackcai',10360,'2024-05-20'),
('2x2x2x2',13506,FALSE,TRUE,FALSE,'https://youtu.be/69cHdMngklw','HSC','bilal',10361,'2024-05-31'),
('2x2x2x3',35272,FALSE,FALSE,FALSE,'https://youtu.be/PZqqKiQeHN4','MPU','battistin',10362,'2024-05-26'),

('2x2x2x2',7481,FALSE,TRUE,FALSE,'https://youtu.be/9x55QI0l5wE','HSC','bilal',10364,'2024-05-31'),
('2x2x2x2',8517,FALSE,TRUE,FALSE,'https://youtu.be/dItE0M72lq8','HSC','battistin',10365,'2024-06-01'),
('3x3x3x3',257354,FALSE,TRUE,FALSE,'https://youtu.be/bYKki5nx0dE','HSC','stella',10366,'2024-06-02'),

('2x2x2x2',6922,FALSE,TRUE,FALSE,'https://youtu.be/qR_b7b_Mr0M','HSC','bilal',10368,'2024-06-02'),
('3x3x3x3',131707,FALSE,TRUE,FALSE,'https://youtu.be/dIwNaS_1V88','HSC','stella',10369,'2024-06-02'),

('2x2x2x2',6271,FALSE,TRUE,FALSE,'https://youtu.be/yIb0Y4KnZxU','HSC','rowan',10371,'2024-06-02'),
('2x2x2x2',5002,FALSE,TRUE,FALSE,'https://youtu.be/pCIt2U1ju8o','HSC','luna',10372,'2024-06-02'),
('2x2x2x2',6078,FALSE,TRUE,FALSE,'https://youtu.be/Nfc640Pt478','HSC','bilal',10373,'2024-06-02'),



('2x2x2x2',5963,FALSE,TRUE,FALSE,'https://youtu.be/NbVYRCEqxqQ','HSC','bilal',10377,'2024-06-03'),


('2x2x2x2',4787,FALSE,TRUE,FALSE,'https://youtu.be/JXu5d9OvW6E','HSC','bilal',10380,'2024-06-04'),
('3x3x3x3',47642,FALSE,TRUE,FALSE,'https://youtu.be/TozqKcVpa98','HSC','godly',10381,'2024-06-04'),
('3x3x3x3',44863,FALSE,TRUE,FALSE,'https://youtu.be/c7swBy3r0j4','HSC','godly',10382,'2024-06-06'),
('3x3x3x3',92997,FALSE,TRUE,FALSE,'https://youtu.be/sHj2sSrpLxE','HSC','stella',10383,'2024-06-08'),
('3x3x3x3',82986,FALSE,TRUE,FALSE,'https://youtu.be/WC_tdW3fAT0','HSC','stella',10384,'2024-06-08'),
('3x3x3x3',35919,FALSE,TRUE,FALSE,'https://youtu.be/7171J-gKcb4','HSC','godly',10385,'2024-06-08'),



('2x2x2x2',4350,FALSE,TRUE,FALSE,'https://youtu.be/j-SSh4NS9Ak','HSC','bilal',10389,'2024-06-07'),

('3x3x3x3',99394,FALSE,TRUE,FALSE,'https://youtu.be/RpZ44eJvdBI','HSC','vin',10391,'2024-06-09'),
('2x2x2x2x2',509844,FALSE,TRUE,FALSE,'https://youtu.be/I2rFoHhA_Zw','MC5D','hyperespy',10392,'2024-06-10'),
('2x2x2x2',4017,FALSE,TRUE,FALSE,'https://youtu.be/f897BXHcAvw','HSC','bilal',10393,'2024-06-10'),
('3x3x3x3',31712,FALSE,TRUE,FALSE,'https://youtu.be/i9lDpnbZ9NQ','HSC','godly',10394,'2024-06-09'),
('3x3x3x3',84468,FALSE,TRUE,FALSE,'https://youtu.be/yKViHBY17iA','HSC','bilal',10395,'2024-06-11'),

('2x2x2x3',26258,FALSE,FALSE,FALSE,'https://youtu.be/T_X7AKA5ZUg','MPU','tymofro',10397,'2024-06-11'),
('2x2x3x3',133269,FALSE,FALSE,FALSE,'https://youtu.be/FrCRqctg4nw','MPU','battistin',10398,'2024-06-12'),

('2x2x2x2',4083,FALSE,TRUE,FALSE,'https://youtu.be/dAEltrZnRIw','HSC','hactar',10400,'2024-06-02'),



('2x2x2x2',3484,FALSE,TRUE,FALSE,'https://youtu.be/jov_penjjzs','HSC','hactar',10404,'2024-06-14'),
('3x3x3x3',28550,FALSE,TRUE,FALSE,'https://youtu.be/SMta2Fae3HE','HSC','godly',10405,'2024-06-15'),
('3x3x3x3',121154,FALSE,TRUE,FALSE,'https://youtu.be/4MD50jkGF5A','HSC','rayzchen',10406,'2024-06-13'),
('3x3x3x3',76187,FALSE,TRUE,FALSE,'https://youtu.be/56n9-W5OgGc','HSC','rayzchen',10407,'2024-06-16'),
('3x3x3x3',73064,FALSE,TRUE,FALSE,'https://youtu.be/gfqwhGqyqE0','HSC','rayzchen',10408,'2024-06-17'),
('3x3x3x3',66594,FALSE,TRUE,FALSE,'https://youtu.be/2DTaqDy47oc','HSC','rayzchen',10409,'2024-06-17'),
('3x3x3x3',64496,FALSE,TRUE,FALSE,'https://youtu.be/9E27ObgFBQ8','HSC','rayzchen',10410,'2024-06-18'),
('3x3x3x3',52526,FALSE,TRUE,FALSE,'https://youtu.be/dyZfAEup8Gk','HSC','rayzchen',10411,'2024-06-18'),
('2x2x2x2',3951,FALSE,TRUE,FALSE,'https://youtu.be/BT4Ho35arTU','HSC','bilal',10412,'2024-06-18'),

('2x2x2x3',19970,FALSE,FALSE,FALSE,'https://youtu.be/IULGT6GgC68','MPU','rowan',10414,'2024-06-20'),
('2x2x2x3',17890,FALSE,FALSE,FALSE,'https://youtu.be/07nA8sQqHDY','MPU','rowan',10415,'2024-06-20'),
('klein_quartic',563402,FALSE,FALSE,FALSE,'https://youtu.be/LdWEvuAQy_w','MT','battistin',10416,'2024-06-20'),
('2x2x2x2',3765,FALSE,TRUE,FALSE,'https://youtu.be/qQKz5D7Jyqk','HSC','bilal',10417,'2024-06-20'),
('klein_quartic',442138,FALSE,FALSE,FALSE,'https://youtu.be/clWYAJeWMNM','MT','tymofro',10418,'2024-06-21'),

('2x2x2x2',3433,FALSE,TRUE,FALSE,'https://youtu.be/FSpLGQLZkJY','HSC','bilal',10420,'2024-06-21'),

('2x2x2x2',3348,FALSE,TRUE,FALSE,'https://youtu.be/6lVqfuLqbXI&t=56','HSC','hactar',10422,'2024-06-25'),

('2x2x2x2',3267,FALSE,TRUE,FALSE,'https://youtu.be/zAr0RXLH6Do&t=202','HSC','bilal',10424,'2024-06-25'),

('3x3x3x3x3',1090863,FALSE,TRUE,FALSE,'https://youtu.be/pRtvWojcFCM','MC7D','rowan',10426,'2024-06-25'),

('3x3x3x3',51653,FALSE,TRUE,FALSE,'https://youtu.be/D26k9okZ6CA','HSC','bilal',10428,'2024-06-26'),
('3x3x3x3x3',983943,FALSE,TRUE,FALSE,'https://youtu.be/gqyE_F3td3g','MC7D','luna',10429,'2024-06-26'),
('3x3x3x3x3',2403476,FALSE,TRUE,FALSE,'https://youtu.be/uBNmmY7pTsE','MC7D','vin',10430,'2024-06-26'),
('3x3x3x3x3',903048,FALSE,TRUE,FALSE,'https://youtu.be/31Y2ljf3R1M','MC7D','rowan',10431,'2024-06-26'),
('2x2x2x2',2997,FALSE,TRUE,FALSE,'https://youtu.be/4MoNVxJlJIo&t=43','HSC','hactar',10432,'2024-06-27'),

('3x3x3x3x3',1583891,FALSE,TRUE,FALSE,'https://youtu.be/OQrKRlC-l1s','MC7D','vin',10434,'2024-06-27'),
('3x3x3x3',52907,FALSE,TRUE,FALSE,'https://youtu.be/FdaXJfFHy4Q','HSC','stella',10435,'2024-06-29'),
('2x2x2x2',2637,FALSE,TRUE,FALSE,'https://youtu.be/EuuU2ILISC4','HSC','adam',10436,'2024-06-29'),
('2x2x2x2',2579,FALSE,TRUE,FALSE,'https://youtu.be/6AkLFo3OWyQ','HSC','adam',10437,'2024-06-29'),
('3x3x3x3x3',805658,FALSE,TRUE,FALSE,'https://youtu.be/DhS9G_ZvbzE','MC7D','rowan',10438,'2024-06-29'),
('3x3x3x3',38708,FALSE,TRUE,FALSE,'https://youtu.be/1_S1MSQpVwE','HSC','pkearth',10439,'2024-06-29'),
('2x2x2x2',4751,FALSE,TRUE,FALSE,'https://youtu.be/a8Bhn6oq6Ws','HSC','pkearth',10440,'2024-06-30'),
('3x3x3x3x3',1444045,FALSE,TRUE,FALSE,'https://youtu.be/0WSXcEAu76M','MC7D','vin',10441,'2024-07-01'),

('2x2x2x2',8492,FALSE,TRUE,FALSE,'https://youtu.be/UaqXt4X-3GE&t=8','HSC','saturnb',10443,'2024-07-01'),
('3x3x3x3x3',674973,FALSE,TRUE,FALSE,'https://youtu.be/ClT2G84Ypnw','MC7D','rowan',10444,'2024-07-01'),
('2x2x2x2x2',352141,FALSE,FALSE,FALSE,'https://youtu.be/w-ILUWNdAcg','MPU','tymofro',10445,'2024-07-02'),
('2x2x2x2x2',290231,FALSE,FALSE,FALSE,'https://youtu.be/qi5cOaLuIrA','MPU','tymofro',10446,'2024-07-02'),

('2x2x2x2',5364,FALSE,TRUE,FALSE,'https://youtu.be/7fbwTWp-nc0','HSC','saturnb',10448,'2024-07-05'),
('3x3x3x3',79848,FALSE,TRUE,FALSE,'https://youtu.be/56CPMYv5dM0','HSC','pistelli',10449,'2024-07-05'),
('3x3x3x3',27644,FALSE,TRUE,FALSE,'https://youtu.be/d3m67muJG_s','HSC','pkearth',10450,'2024-07-07'),
('2x2x2x2',4415,FALSE,TRUE,FALSE,'https://youtu.be/NtMFnvXRk-s','HSC','pkearth',10451,'2024-07-07'),
('2x2x2x2',3145,FALSE,TRUE,FALSE,'https://youtu.be/SZ9shDSkGN4','HSC','bilal',10452,'2024-07-08'),
('3x3x3x3',49159,FALSE,TRUE,FALSE,'https://youtu.be/y0zs-Bs2B3k','HSC','bilal',10453,'2024-07-10'),


('3x3x3x3',54499,FALSE,TRUE,FALSE,'https://youtu.be/YJqOGqYyWQg','HSC','saturnb',10456,'2024-07-12'),
('3x3x3x3',169786,FALSE,TRUE,FALSE,'https://youtu.be/ck0cLsGr15A','HSC','hana',10457,'2024-07-12'),
('2x2x2x2',2877,FALSE,TRUE,FALSE,'https://youtu.be/oapOYiZq5s8','HSC','bilal',10458,'2024-07-12'),
('3x3x3x3',22520,FALSE,TRUE,FALSE,'https://youtu.be/-X9FTfoYhHA','HSC','pkearth',10459,'2024-07-13'),
('3x3x3x3',46719,FALSE,TRUE,FALSE,'https://youtu.be/CqE7ZtiSBPs','HSC','bilal',10460,'2024-07-13'),
('3x3x3x3',47735,FALSE,TRUE,FALSE,'https://youtu.be/lyHWt9QsW8c','HSC','saturnb',10461,'2024-07-13'),
('3x3x3x3',65361,FALSE,TRUE,FALSE,'https://youtu.be/pJf0bxkLZLI','HSC','hana',10462,'2024-07-14'),

('3x3x3x3',50871,FALSE,TRUE,FALSE,'https://youtu.be/vthdD9N0pTA','HSC','hana',10464,'2024-07-15'),

('3x3x3x3',37424,FALSE,TRUE,FALSE,'https://youtu.be/dDyKKDErIGY','HSC','bilal',10466,'2024-07-15'),
('4x4x4x4',611248,FALSE,TRUE,FALSE,'https://youtu.be/zGyDcGgajnI','HSC','bilal',10467,'2024-07-15'),
('3x3x3x3x3',1200068,FALSE,TRUE,FALSE,'https://youtu.be/8qVCwe0bNhw','MC7D','vin',10468,'2024-07-16'),
('3x3x3x3',36735,FALSE,TRUE,FALSE,'https://youtu.be/EBrEaT5E9AQ','HSC','bilal',10469,'2024-07-15'),
('3x3x3x3',34992,FALSE,TRUE,FALSE,'https://youtu.be/mQhNSxCzymo','HSC','bilal',10470,'2024-07-15'),


('3x3x3x3',34874,FALSE,TRUE,FALSE,'https://youtu.be/QEBsGnrnS7c','HSC','bilal',10473,'2024-07-16'),
('3x3x3x3',48451,FALSE,TRUE,FALSE,'https://youtu.be/IiRHpCcxw7s','HSC','hana',10474,'2024-07-16'),
('3x3x3x3x3',990953,FALSE,TRUE,FALSE,'https://youtu.be/zgz6YSwTQIc','MC7D','vin',10475,'2024-07-16'),
('3x3x3x3',43988,FALSE,TRUE,FALSE,'https://youtu.be/iPO63vJB3Bo','HSC','hana',10476,'2024-07-16'),

('3x3x3x3',40921,FALSE,TRUE,FALSE,'https://youtu.be/p_8YYJoUjpI','HSC','hana',10478,'2024-07-16'),
('2x2x2x2',4466,FALSE,TRUE,FALSE,'https://youtu.be/xv8DWpEKQ54','HSC','saturnb',10479,'2024-07-16'),

('3x3x3x3',39353,FALSE,TRUE,FALSE,'https://youtu.be/5Jv0O7NDi_g','HSC','hana',10481,'2024-07-16'),
('3x3x3x3',38875,FALSE,TRUE,FALSE,'https://youtu.be/a60UsmBgdeU','HSC','hana',10482,'2024-07-16'),
('3x3x3x3',35866,FALSE,TRUE,FALSE,'https://youtu.be/MjVRk5Mjf9Q','HSC','hana',10483,'2024-07-16'),
('3x3x3x3x3',940785,FALSE,TRUE,FALSE,'https://youtu.be/6yK6GolNGZ8','MC7D','vin',10484,'2024-07-18'),
('3x3x3x3',34634,FALSE,TRUE,FALSE,'https://youtu.be/tRlsaOCOJu4','HSC','hana',10485,'2024-07-19'),
('3x3x3x3',114567,FALSE,TRUE,FALSE,'https://youtu.be/yyRPL-k-ros','HSC','lorenzo',10486,'2024-07-19'),

('3x3x3x3',32085,FALSE,TRUE,FALSE,'https://youtu.be/1PIPDzXTs68','HSC','hana',10488,'2024-07-19'),
('3x3x3x3',25904,FALSE,TRUE,FALSE,'https://youtu.be/KzRrqXvWgwc','HSC','hana',10489,'2024-07-20'),
('3x3x3x3',121751,FALSE,TRUE,FALSE,'https://youtu.be/qmcfAbxlUgc','HSC','starry',10490,'2024-07-20'),
('3x3x3x3',20449,FALSE,TRUE,FALSE,'https://youtu.be/38WawBldyV4','HSC','pkearth',10491,'2024-07-21');



INSERT INTO UserAccount (discord_id, display_name, moderator_notes, moderator)
    SELECT discord_id, display_name, ('previous id: ' || old_id), moderator FROM PersonTsv;


--\set myvariable (INSERT INTO PersonTsv (display_name, moderator_notes)
--    VALUES ('Legacy verification', 'Solve was present in GitHub leaderboard')
--    RETURNING id)

--\set legacy_id
INSERT INTO UserAccount (display_name, moderator_notes, dummy)
    VALUES ('Legacy verification', 'Solve was present in GitHub leaderboard', TRUE);
    --RETURNING id;

INSERT INTO UserAccount (display_name, moderator_notes, dummy)
    VALUES ('HSC verification', 'Log file was verified automatically by HSC', TRUE);
    --RETURNING id;



INSERT INTO Program (name, abbreviation)
    SELECT name, abbreviation
    FROM ProgramTsv;

INSERT INTO ProgramVersion (program_id)
    SELECT id
    FROM Program;


INSERT INTO Puzzle (name, primary_filters, primary_macros)
    SELECT name, primary_filters, primary_macros
    FROM PuzzleTsv;


INSERT INTO HscPuzzle (hsc_id, puzzle_id)
    SELECT PuzzleTsv.hsc_id, Puzzle.id
    FROM PuzzleTsv
    JOIN Puzzle ON Puzzle.name = PuzzleTsv.name;


-- FOR row IN SELECT * FROM SolveTsv LOOP
--     \set id INSERT INTO Solve (puzzle_id, speed_cs, blind, uses_filters, uses_macros, program_version_id, user_id)
--         SELECT Puzzle.id, row.speed_cs, row.blind, row.uses_filters, row.uses_macros, ProgramVersion.id, UserAccount.id
--         Program
--         ON Program.abbreviation = row.program
--         JOIN ProgramVersion
--         ON ProgramVersion.program_id = Program.id
--         JOIN Puzzle
--         ON Puzzle.hsc_id = row.hsc_id
--         JOIN PersonTsv
--         ON row.user_name = PersonTsv.old_id
--         JOIN UserAccount
--         ON PersonTsv.display_name = UserAccount.display_name
--         RETURNING id;

--     INSERT INTO SpeedEvidence (solve_id, video_url, verified, verified_by)
--         SELECT
--         FROM SolveTsv
-- END LOOP

INSERT INTO Solve (puzzle_id, blind, uses_filters, uses_macros, computer_assisted, program_version_id, user_id, upload_time, speed_cs, video_url, speed_verified, speed_verified_by)
    SELECT HscPuzzle.puzzle_id, SolveTsv.blind, SolveTsv.uses_filters, SolveTsv.uses_macros, FALSE,
        ProgramVersion.id, UserAccount.id, (SolveTsv.solve_date::TIMESTAMP AT TIME ZONE 'UTC'),
        SolveTsv.speed_cs, SolveTsv.video_url, TRUE, (
        SELECT id
            FROM UserAccount
            WHERE display_name = 'Legacy verification'
        )
    FROM SolveTsv
    JOIN Program ON Program.abbreviation = SolveTsv.program
    JOIN ProgramVersion ON ProgramVersion.program_id = Program.id
    JOIN HscPuzzle ON HscPuzzle.hsc_id = SolveTsv.hsc_id
    JOIN PersonTsv ON SolveTsv.user_name = PersonTsv.old_id
    JOIN UserAccount ON PersonTsv.display_name = UserAccount.display_name;


END$$
