CREATE TABLE reg_tab( text varchar2(20) );

INSERT INTO reg_tab VALUES('TIGER');

INSERT INTO reg_tab VALUES('TIGGER');

INSERT INTO reg_tab VALUES('elephant');

INSERT INTO reg_tab VALUES('tiger');

INSERT INTO reg_tab VALUES('tiger2');

INSERT INTO reg_tab VALUES('tiger3');

INSERT INTO reg_tab VALUES('doggy');

INSERT INTO reg_tab VALUES('5doggy');

INSERT INTO reg_tab VALUES('DOG');

INSERT INTO reg_tab VALUES('DOG2');

INSERT INTO reg_tab VALUES('°³');

INSERT INTO reg_tab VALUES('cat');

INSERT INTO reg_tab VALUES('catty');

INSERT INTO reg_tab VALUES('9catty');

INSERT INTO reg_tab VALUES('catwoman');

INSERT INTO reg_tab VALUES('°í¾çÀÌ');

INSERT INTO reg_tab VALUES('BAT');

INSERT INTO reg_tab VALUES('BATMAN');

INSERT INTO reg_tab VALUES('BATGIRL'); 

INSERT INTO reg_tab VALUES('0BATGIRL'); 

INSERT INTO reg_tab VALUES('¹ÚÁã');

COMMIT;

--'^'´Â ½ÃÀÛ, '$' Àº ³¡À» ÀÇ¹Ì
-- 1.  text ÄÃ·³ÀÇ ¹®ÀÚ¿­¿¡¼­ 't'·Î ½ÃÀÛÇÏ´Â µ¥ÀÌÅÍ °Ë»ö
SELECT*
FROM reg_tab
WHERE text LIKE 't%';

SELECT *
FROM reg_tab
WHERE REGEXP_LIKE(text,'^t');


-- 2.  text ÄÃ·³ÀÇ ¹®ÀÚ¿­¿¡¼­ 't'·Î ³¡³ª´Â µ¥ÀÌÅÍ °Ë»ö
SELECT*
FROM reg_tab
WHERE REGEXP_LIKE(TEXT, 't$');

SELECT*
FROM reg_tab
WHERE text LIKE '_%t';

-- 3. Ã¹¹øÂ° 't'·Î ½ÃÀÛÇÏ¿© 5¹øÂ° 'r'ÀÌ ÀÖ´Â µ¥ÀÌÅÍ °Ë»ö
SELECT*
FROM reg_tab
WHERE REGEXP_LIKE(TEXT, '^t...r');
?

-- 4. ¼ýÀÚ·Î ³¡³ª´Â µ¥ÀÌÅÍ °Ë»ö
SELECT*
FROM reg_tab
WHERE REGEXP_LIKE(TEXT, '[0-9]$');
?

-- 5. ¼ýÀÚ·Î ½ÃÀÛÇÏ´Â µ¥ÀÌÅ¸ °Ë»ö
SELECT*
FROM reg_tab
WHERE REGEXP_LIKE(TEXT, '^[0-9]');
?

-- 6. ¼ýÀÚ°¡ ¾Æ´Ñ ¹®ÀÚ·Î ½ÃÀÛÇÏ´Â µ¥ÀÌÅÍ °Ë»ö
SELECT*
FROM reg_tab
WHERE NOT REGEXP_LIKE(TEXT, '^[0-9]');

SELECT *
FROM reg_tab
WHERE REGEXP_LIKE(text,'^[^0-9]');

-- 7. ´ë¹®ÀÚ·Î ½ÃÀÛÇÏ´Â µ¥ÀÌÅÍ °Ë»ö
SELECT*
FROM reg_tab
WHERE REGEXP_LIKE(TEXT, '^[A-Z]');

SELECT*
FROM reg_tab
WHERE TEXT BETWEEN 'A'and 'Z';
?

-- 8. ¼Ò¹®ÀÚ ¿ÜÀÇ ¹®ÀÚ·Î ½ÃÀÛÇÏ´Â µ¥ÀÌÅÍ °Ë»ö
SELECT*
FROM reg_tab
WHERE NOT REGEXP_LIKE(TEXT, '^[a-z]');

SELECT *
FROM reg_tab
WHERE REGEXP_LIKE(text,'^[^a-z]');

SELECT*
FROM reg_tab
WHERE not TEXT BETWEEN 'a'and 'z';

?

-- 9. ÇÑ±Û·Î ½ÃÀÛÇÏ´Â µ¥ÀÌÅÍ °Ë»ö
SELECT*
FROM reg_tab
WHERE REGEXP_LIKE(TEXT, '^[°¡-ÆR]');

SELECT*
FROM reg_tab
WHERE TEXT BETWEEN '°¡'and 'ÆR';
?

-- 10. µ¥ÀÌÅÍ Áß 'gg'³ª 'GG'°¡ µé¾îÀÖ´Â µ¥ÀÌÅÍ °Ë»ö
SELECT*
FROM reg_tab
WHERE REGEXP_LIKE(TEXT, 'gg')or  REGEXP_LIKE(TEXT, 'GG');

SELECT *
FROM reg_tab
WHERE REGEXP_LIKE(text,'gg|GG');

SELECT * FROM reg_tab WHERE text LIKE '%gg%' or text  LIKE '%GG%';




