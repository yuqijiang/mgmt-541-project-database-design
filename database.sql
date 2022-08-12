CREATE TABLE KATICLE_AGENCY
   (    
      AGENCY_ID NUMBER(10) NOT NULL ENABLE, 
      AGENCY_NAME VARCHAR2(120),
      CONSTRAINT KATICLE_AGENCY_PK PRIMARY KEY (AGENCY_ID)
    );


CREATE TABLE KATICLE_BRANCH 
  ( 
    BRANCH_ID NUMBER (10) NOT NULL ENABLE, 
    BRANCH_AGENCY_ID NUMBER(10) NOT NULL ENABLE, 
    BRANCH_NAME VARCHAR2 (120), 
    CONSTRAINT BRANCH_PK PRIMARY KEY (BRANCH_ID, BRANCH_AGENCY_ID),
    CONSTRAINT BRANCH_AGENCY_FK FOREIGN KEY (BRANCH_AGENCY_ID) REFERENCES KATICLE_AGENCY (AGENCY_ID) 
  );

CREATE TABLE KATICLE_SOLICITATION  
  (  
    SOLICITATION_ID NUMBER (10) NOT NULL ENABLE,
    SOLICITATION_NUMBER VARCHAR2(50), 
    SOLICITATION_YEAR NUMBER(38),
    SOLICITATION_AGENCY_ID NUMBER(10),  
    CONSTRAINT SOLICITATION_PK PRIMARY KEY (SOLICITATION_ID), 
    CONSTRAINT SOLICITATION_AGENCY_FK FOREIGN KEY (SOLICITATION_AGENCY_ID) REFERENCES KATICLE_AGENCY (AGENCY_ID)  
  );



CREATE TABLE KATICLE_TPOC
  (
    TPOC_ID NUMBER(10) NOT NULL ENABLE PRIMARY KEY,
    TPOC_AGENCY_ID NUMBER(10),
    TPOC_NAME VARCHAR2 (50),
    TPOC_EMAIL VARCHAR2 (50),
    TPOC_PHONE VARCHAR2 (20),
    CONSTRAINT TPOC_AGENCY_PK FOREIGN KEY (TPOC_AGENCY_ID) REFERENCES KATICLE_AGENCY (AGENCY_ID)
  );



CREATE TABLE KATICLE_TOPIC    
  (    
    TOPIC_NUMBER VARCHAR2 (20) NOT NULL ENABLE,    
    TOPIC_SOLICITATION_ID NUMBER (10) NOT NULL ENABLE, 
    TOPIC_TITLE VARCHAR2 (256),    
    TOPIC_PROGRAM VARCHAR2 (9),    
    TOPIC_RELEASE_DATE DATE,     
    TOPIC_APPLICAITON_DUE_DATE DATE,      
    TOPIC_DURATION VARCHAR2 (50),    
    TOPIC_DESCRIPTION CLOB,    
    TOPIC_TPOC_ID NUMBER (10),    
    TOPIC_BRANCH_ID NUMBER (10),  
    TOPIC_BRANCH_AGENCY_ID NUMBER (10), 
    TOPIC_FUNDING_TOPIC_ID VARCHAR2 (20),
    CONSTRAINT TOPIC_PK PRIMARY KEY (TOPIC_NUMBER, TOPIC_SOLICITATION_ID),   
    CONSTRAINT TOPIC_SOLICITATION_FK FOREIGN KEY (TOPIC_SOLICITATION_ID)    
      REFERENCES KATICLE_SOLICITATION (SOLICITATION_ID),    
    CONSTRAINT TOPIC_TOPC_FK FOREIGN KEY (TOPIC_TPOC_ID)    
      REFERENCES KATICLE_TPOC (TPOC_ID), 
    CONSTRAINT TOPIC_BRANCH_FK FOREIGN KEY (TOPIC_BRANCH_ID, TOPIC_BRANCH_AGENCY_ID)    
      REFERENCES KATICLE_BRANCH (BRANCH_ID, BRANCH_AGENCY_ID)    
  );




CREATE TABLE KATICLE_TOPIC_KEYWORD  
  (  
    TOPIC_KEYWORD_TOPIC_NUMBER VARCHAR2 (20) NOT NULL,  
    TOPIC_KEYWORD_KEYWORD VARCHAR2 (50),
   CONSTRAINT KEYWORD_PK PRIMARY KEY (TOPIC_KEYWORD_TOPIC_NUMBER, TOPIC_KEYWORD_KEYWORD)  
  );  

CREATE TABLE KATICLE_COMPANY_ADDRESS
  (
    COMPANY_ADDRESS_ID NUMBER (10) NOT NULL ENABLE PRIMARY KEY,
    COMPANY_ADDRESS_CITY VARCHAR2 (120),
    COMPANY_ADDRESS_STATE VARCHAR2 (120),
    COMPANY_ADDRESS_ZIP_CODE VARCHAR2 (10),
    COMPANY_ADDRESS1 VARCHAR2 (120),
    COMPANY_ADDRESS2 VARCHAR2 (120)
  );


CREATE TABLE KATICLE_COMPANY  
  (  
    COMPANY_ID NUMBER (10) NOT NULL ENABLE PRIMARY KEY,
    COMPANY_DUNS VARCHAR2 (20), 
    COMPANY_NAME VARCHAR2 (120),  
    COMPANY_WEBSITE VARCHAR2 (120), 
    COMPANY_EARNED_AWARDS_NUMBER NUMBER (20),
    COMPANY_ADDRESS_ID NUMBER(10),
    COMPANY_HUBZONE_OWNED VARCHAR2(5),
    COMPANY_SED VARCHAR2(5),
    COMPANY_WOMAN_OWNED VARCHAR2(5),
    COMPANY_EMPLOYEE_COUNT NUMBER(38),
    CONSTRAINT COMPANY_ADDRESS_FK FOREIGN KEY (COMPANY_ADDRESS_ID)
      REFERENCES KATICLE_COMPANY_ADDRESS (COMPANY_ADDRESS_ID)
  ); 


CREATE TABLE KATICLE_RI_ADDRESS
  (
    RI_ADDRESS_ID NUMBER(20) NOT NULL ENABLE PRIMARY KEY,
    RI_ADDRESS_CITY VARCHAR2 (120),
    RI_ADDRESS_STATE VARCHAR2 (120),
    RI_ADDRESS_ZIP_CODE VARCHAR2 (10),
    RI_ADDRESS1 VARCHAR2 (120),
    RI_ADDRESS2 VARCHAR2 (120)
  );


CREATE TABLE KATICLE_RESEARCH_INSTITUTION 
  ( 
    RI_ID NUMBER(10) NOT NULL ENABLE PRIMARY KEY, 
    RI_NAME VARCHAR2 (120), 
    RI_ADDRESS_ID NUMBER(10), 
    CONSTRAINT RI_ADDRESS_FK FOREIGN KEY (RI_ADDRESS_ID)  
      REFERENCES KATICLE_RI_ADDRESS (RI_ADDRESS_ID)
  ); 



CREATE TABLE KATICLE_EMPLOYEE 
  ( 
    EMPLOYEE_ID NUMBER(10) NOT NULL ENABLE PRIMARY KEY, 
    EMPLOYEE_NAME VARCHAR2 (120), 
    EMPLOYEE_EMAIL VARCHAR2 (120),
    EMPLOYEE_PHONE_NUMBER VARCHAR2 (20),
    EMPLOYEE_JOB_TITLE VARCHAR2 (50),
    EMPLOYEE_TITLE VARCHAR2 (50)
    );


CREATE TABLE KATICLE_EMPLOYMENT
  (
    EMPLOYMENT_ID NUMBER(20) NOT NULL ENABLE PRIMARY KEY,
    EMPLOYMENT_JOB_TITLE VARCHAR2 (50),
    EMPLOYMENT_START_DATE DATE,
    EMPLOYMENT_END_DATE DATE,
    EMPLOYMENT_DATE_RANGE VARCHAR2 (255),
    EMPLOYMENT_COMPANY_ID NUMBER (10),
    EMPLOYMENT_RI_ID NUMBER (10),
    EMPLOYMENT_EMPLOYEE_ID NUMBER (10),
    CONSTRAINT EMPLOYMENT_COMPANY_FK FOREIGN KEY (EMPLOYMENT_COMPANY_ID)
      REFERENCES KATICLE_COMPANY (COMPANY_ID),
    CONSTRAINT EMPLOYMENT_RI_FK FOREIGN KEY (EMPLOYMENT_RI_ID)
      REFERENCES KATICLE_RESEARCH_INSTITUTION (RI_ID),
    CONSTRAINT EMPLOYMENT_EMPLOYEE_FK FOREIGN KEY (EMPLOYMENT_EMPLOYEE_ID)
      REFERENCES KATICLE_EMPLOYEE (EMPLOYEE_ID)
  );

CREATE TABLE KATICLE_AWARD     
  (     
    AWARD_ID NUMBER (10) NOT NULL ENABLE PRIMARY KEY, 
    AWARD_AGENCY_TRACKING_NUMBER VARCHAR2(50), 
    AWARD_AMOUNT NUMBER,     
    AWARD_YEAR NUMBER (5),     
    AWARD_PHASE NUMBER,     
    AWARD_PROJECT_TITLE VARCHAR2 (256),     
    AWARD_SUMMARY CLOB,     
    AWARD_TOPIC_NUMBER VARCHAR2 (20),   
    AWARD_OPEN_DATE DATE,      
    AWARD_CLOSED_DATE DATE,   
    AWARD_SOLICITATION_ID NUMBER (10), 
    AWARD_CONTRACT_ID VARCHAR2 (50),
   CONSTRAINT AWARD_TOPIC_FK FOREIGN KEY (AWARD_TOPIC_NUMBER,  AWARD_SOLICITATION_ID)    
      REFERENCES KATICLE_TOPIC (TOPIC_NUMBER, TOPIC_SOLICITATION_ID)
  );  











INSERT INTO KATICLE_AGENCY
SELECT ROWNUM, AGENCY
FROM ( 
    SELECT DISTINCT AGENCY
    FROM ADMIN03.SBIR_AWARDS_DUMP 
    WHERE AGENCY IS NOT NULL 
      );
 
 
INSERT INTO KATICLE_BRANCH
SELECT ROWNUM, AGENCY_ID, BRANCH
FROM (
    SELECT DISTINCT KATICLE_AGENCY.AGENCY_ID, BRANCH
    FROM KATICLE_AGENCY, ADMIN03.SBIR_AWARDS_DUMP
    WHERE KATICLE_AGENCY.AGENCY_NAME = ADMIN03.SBIR_AWARDS_DUMP.AGENCY
    AND BRANCH IS NOT NULL
      );


INSERT INTO KATICLE_SOLICITATION
SELECT ROWNUM, SOLICITATION, SOLICITATION_YEAR, AGENCY_ID
FROM (
      SELECT DISTINCT SOLICITATION, SOLICITATION_YEAR, AGENCY_ID
      FROM ADMIN03.SBIR_AWARDS_DUMP, KATICLE_AGENCY
      WHERE KATICLE_AGENCY.AGENCY_NAME = ADMIN03.SBIR_AWARDS_DUMP.AGENCY 
      );
      

INSERT INTO KATICLE_TPOC (TPOC_ID, TPOC_AGENCY_ID, TPOC_NAME) 
SELECT ROWNUM, AGENCY_ID, CONCAT ('Mr. ',SOLICITATION_NUMBER) 
FROM KATICLE_AGENCY, KATICLE_SOLICITATION 
WHERE KATICLE_AGENCY.AGENCY_ID = KATICLE_SOLICITATION.SOLICITATION_AGENCY_ID;



INSERT INTO KATICLE_TOPIC (TOPIC_NUMBER, TOPIC_SOLICITATION_ID, TOPIC_PROGRAM, TOPIC_TPOC_ID,  TOPIC_BRANCH_ID,  TOPIC_BRANCH_AGENCY_ID,  TOPIC_FUNDING_TOPIC_ID) 
SELECT ROWNUM, funding.* 
FROM  
    (SELECT DISTINCT SOLICITATION_ID, PROGRAM, TPOC_ID, BRANCH_ID, BRANCH_AGENCY_ID, FUNDING_TOPIC_ID 
      FROM ADMIN03.SBIR_AWARDS_DUMP, KATICLE_SOLICITATION, KATICLE_BRANCH, KATICLE_TPOC, KATICLE_AGENCY 
      WHERE FUNDING_TOPIC_ID IS NOT NULL 
        AND KATICLE_SOLICITATION.SOLICITATION_NUMBER = ADMIN03.SBIR_AWARDS_DUMP.SOLICITATION 
        AND KATICLE_BRANCH.BRANCH_NAME = ADMIN03.SBIR_AWARDS_DUMP.BRANCH 
        AND KATICLE_AGENCY.AGENCY_NAME = ADMIN03.SBIR_AWARDS_DUMP.AGENCY 
        AND KATICLE_AGENCY.AGENCY_ID = KATICLE_SOLICITATION.SOLICITATION_AGENCY_ID 
        AND KATICLE_TPOC.TPOC_AGENCY_ID = KATICLE_AGENCY.AGENCY_ID
    )funding;



INSERT INTO KATICLE_TOPIC_KEYWORD
SELECT ROWNUM, dbms_lob.SUBSTR(KEYWORDS,50,1)
FROM ADMIN03.SBIR_AWARDS_DUMP
WHERE KEYWORDS IS NOT NULL;



INSERT INTO KATICLE_COMPANY_ADDRESS 
SELECT ROWNUM, companya.* 
FROM
  ( 
    SELECT DISTINCT AWARDEE_CITY, AWARDEE_STATE, AWARDEE_ZIP, AWARDEE_ADDRESS1 , AWARDEE_ADDRESS2
    FROM ADMIN03.SBIR_AWARDS_DUMP 
    WHERE AWARDEE_DUNS IS NOT NULL 
  ) companya;



INSERT INTO KATICLE_COMPANY (COMPANY_ID, COMPANY_DUNS, COMPANY_NAME, COMPANY_WEBSITE, COMPANY_ADDRESS_ID, COMPANY_HUBZONE_OWNED, COMPANY_SED, COMPANY_WOMAN_OWNED, COMPANY_EMPLOYEE_COUNT) 
SELECT ROWNUM, company.* 
FROM  
  (  
    SELECT DISTINCT AWARDEE_DUNS, AWARDEE_NAME, AWARDEE_URL, COMPANY_ADDRESS_ID, AWARDEE_HUBZONE_OWNED, AWARDEE_SED, AWARDEE_WOMAN_OWNED, AWARDEE_EMPLOYEE_COUNT
    FROM ADMIN03.SBIR_AWARDS_DUMP, KATICLE_COMPANY_ADDRESS 
    WHERE AWARDEE_DUNS IS NOT NULL 
      AND ADMIN03.SBIR_AWARDS_DUMP.AWARDEE_CITY = KATICLE_COMPANY_ADDRESS.COMPANY_ADDRESS_CITY 
      AND ADMIN03.SBIR_AWARDS_DUMP.AWARDEE_STATE = KATICLE_COMPANY_ADDRESS.COMPANY_ADDRESS_STATE 
      AND ADMIN03.SBIR_AWARDS_DUMP.AWARDEE_ZIP = KATICLE_COMPANY_ADDRESS.COMPANY_ADDRESS_ZIP_CODE 
  ) company;



INSERT INTO KATICLE_RI_ADDRESS  
SELECT ROWNUM, ria.*  
FROM 
  (  
    SELECT DISTINCT AWARDEE_CITY, AWARDEE_STATE, AWARDEE_ZIP,  AWARDEE_ADDRESS1 , AWARDEE_ADDRESS2
    FROM ADMIN03.SBIR_AWARDS_DUMP  
    WHERE AWARDEE_DUNS IS NULL
  ) ria;


INSERT INTO KATICLE_RESEARCH_INSTITUTION
SELECT ROWNUM, ri.*
FROM
  (
    SELECT DISTINCT RESEARCH_INSTITUTE_NAME, RI_ADDRESS_ID
    FROM ADMIN03.SBIR_AWARDS_DUMP, KATICLE_RI_ADDRESS
    WHERE RESEARCH_INSTITUTE_NAME IS NOT NULL
      AND ADMIN03.SBIR_AWARDS_DUMP.AWARDEE_CITY = KATICLE_RI_ADDRESS.RI_ADDRESS_CITY 
      AND ADMIN03.SBIR_AWARDS_DUMP.AWARDEE_STATE = KATICLE_RI_ADDRESS.RI_ADDRESS_STATE 
      AND ADMIN03.SBIR_AWARDS_DUMP.AWARDEE_ZIP = KATICLE_RI_ADDRESS.RI_ADDRESS_ZIP_CODE
  )ri;



INSERT INTO KATICLE_EMPLOYEE 
SELECT ROWNUM, employee.*   
FROM    
  (   
    SELECT DISTINCT AWARDEE_PI_NAME, AWARDEE_PI_EMAIL, AWARDEE_PI_PHONE, 'PI' as ROLE, AWARDEE_CONTACT_TITLE
    FROM ADMIN03.SBIR_AWARDS_DUMP  
    WHERE AWARDEE_PI_NAME IS NOT NULL  
      UNION  
    SELECT DISTINCT AWARDEE_CONTACT_NAME, AWARDEE_CONTACT_EMAIL, AWARDEE_CONTACT_PHONE, 'CONTACT' as ROLE, AWARDEE_CONTACT_TITLE
    FROM ADMIN03.SBIR_AWARDS_DUMP  
    WHERE AWARDEE_CONTACT_NAME IS NOT NULL  
      UNION  
    SELECT DISTINCT RESEARCH_INSTITUTE_POC_NAME, NULL, RESEARCH_INSTITUTE_POC_PHONE, 'RI_ROC' as ROLE, AWARDEE_CONTACT_TITLE
    FROM ADMIN03.SBIR_AWARDS_DUMP   
    WHERE RESEARCH_INSTITUTE_POC_NAME IS NOT NULL   
  )employee;


INSERT INTO KATICLE_AWARD (AWARD_ID, AWARD_AGENCY_TRACKING_NUMBER, AWARD_AMOUNT, AWARD_PHASE, AWARD_PROJECT_TITLE, AWARD_SUMMARY, AWARD_TOPIC_NUMBER, AWARD_SOLICITATION_ID, AWARD_OPEN_DATE, AWARD_CLOSED_DATE, AWARD_CONTRACT_ID) 
SELECT ROWNUM, awards.*  
FROM  
  (  
    SELECT DISTINCT AGENCY_TRACKING_NUMBER, AMOUNT, PHASE, TITLE, dbms_lob.SUBSTR(ABSTRACT,1000,1), TOPIC_NUMBER, SOLICITATION_ID, START_DATE, END_DATE, CONTRACT_ID
    FROM ADMIN03.SBIR_AWARDS_DUMP, KATICLE_TOPIC, KATICLE_SOLICITATION, KATICLE_COMPANY 
    WHERE ADMIN03.SBIR_AWARDS_DUMP.FUNDING_TOPIC_ID = KATICLE_TOPIC.TOPIC_FUNDING_TOPIC_ID  
      AND ADMIN03.SBIR_AWARDS_DUMP.AWARDEE_NAME = KATICLE_COMPANY.COMPANY_NAME  
      AND ADMIN03.SBIR_AWARDS_DUMP.SOLICITATION = KATICLE_SOLICITATION.SOLICITATION_NUMBER 
      AND KATICLE_TOPIC.TOPIC_SOLICITATION_ID = KATICLE_SOLICITATION.SOLICITATION_ID 
      AND ADMIN03.SBIR_AWARDS_DUMP.FUNDING_TOPIC_ID IS NOT NULL 
  )awards;


INSERT INTO KATICLE_EMPLOYMENT (EMPLOYMENT_ID, EMPLOYMENT_JOB_TITLE, EMPLOYMENT_COMPANY_ID, EMPLOYMENT_RI_ID, EMPLOYMENT_EMPLOYEE_ID) 
SELECT ROWNUM, employment.* 
FROM 
  ( 
  SELECT DISTINCT EMPLOYEE_JOB_TITLE, COMPANY_ID, NULL, EMPLOYEE_ID
  FROM ADMIN03.SBIR_AWARDS_DUMP, KATICLE_COMPANY, KATICLE_EMPLOYEE 
  WHERE ADMIN03.SBIR_AWARDS_DUMP.AWARDEE_DUNS = KATICLE_COMPANY.COMPANY_DUNS
    AND ADMIN03.SBIR_AWARDS_DUMP.AWARDEE_PI_NAME = KATICLE_EMPLOYEE.EMPLOYEE_NAME 
      UNION
  SELECT DISTINCT EMPLOYEE_JOB_TITLE, NULL, RI_ID, EMPLOYEE_ID
  FROM ADMIN03.SBIR_AWARDS_DUMP, KATICLE_RESEARCH_INSTITUTION, KATICLE_EMPLOYEE
  WHERE ADMIN03.SBIR_AWARDS_DUMP.RESEARCH_INSTITUTE_NAME = KATICLE_RESEARCH_INSTITUTION.RI_NAME
    AND ADMIN03.SBIR_AWARDS_DUMP.AWARDEE_PI_NAME = KATICLE_EMPLOYEE.EMPLOYEE_NAME 
  )employment; 
