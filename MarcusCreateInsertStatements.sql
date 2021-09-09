/*
CREATE table COMPANY
*/

CREATE TABLE COMPANY
                (
             	ContractorNumber char(20)       NOT NULL,
		Name             varchar(100)   NOT NULL,
              	Address1         varchar(50)    NOT NULL,
               	Address2         varchar(50)    NULL,
              	City             varchar(50)    NOT NULL,
              	State            char(2)        NOT NULL,
              	ZIP              char(5)        NOT NULL,
               	County           varchar(50)    NOT NULL,
		Phone		 char(12)       NOT NULL,
		Fax		 char(12)       NOT NULL,
              	CONSTRAINT PK_COMPANY PRIMARY KEY (ContractorNumber)
                );


/*
CREATE table PROJECT
*/

CREATE TABLE PROJECT 
                (
                ProjectId           varchar(20)     NOT NULL,
                ProjectLocation     varchar(100)    NOT NULL, 
                Description         varchar(100)    NOT NULL,
                Job                 varchar(20)     NOT NULL, 
                Stage               varchar(10)     DEFAULT 'Planning' NOT NULL CHECK(Stage IN ('Planning','Active','Review','Complete')),  
                CONSTRAINT   PK_PROJECT  PRIMARY KEY (ProjectId)
                );



/*
CREATE table EEO_CODE
*/

CREATE TABLE EEO_CODE 
                (
                EEOCode     	int            	NOT NULL,
                Description 	varchar(100)   	NOT NULL,      
                Minority    	char(1)        	NOT NULL CHECK (Minority IN ('Y', 'N')),
                CONSTRAINT PK_EEO_CODE PRIMARY KEY (EEOCode)
                );


/*
CREATE table JOBCODE
*/

CREATE TABLE JOBCODE
                (
		JobCode		        char(3)       NOT NULL,
		JobClassification   	varchar(20)   NOT NULL,
		CONSTRAINT   PK_JOBCODE   PRIMARY KEY (JobCode)
                );


/*
CREATE table EMPLOYEE
*/

CREATE TABLE EMPLOYEE
                (
              	EmployeeId      char(9)      	NOT NULL,
               	FirstName       varchar(30)  	NOT NULL,
               	LastName        varchar(30)  	NOT NULL,
               	MI              char(1)      	NULL,
              	SocialSecurity  varchar(9)   	NOT NULL 	UNIQUE,
              	UnionStatus     char(1)      	NOT NULL 	CHECK(UnionStatus IN ('Y','N')),
              	Gender 	        char(1)      	NOT NULL 	CHECK(Gender IN ('M','F')),
             	EEOCode         int          	NOT NULL,
              	Address1        varchar(100) 	NOT NULL,
              	Address2        varchar(100) 	NULL,
            	City            varchar(100) 	NOT NULL,
              	State           char(2)      	NOT NULL,
               	ZIP             char(5)      	NOT NULL,
              	Phone           char(12)     	NULL,
              	BirthDate       date         	NOT NULL,
              	MaritalStatus   char(1)      	NOT NULL,
             	Manager         char (9)     	NULL,
              	CONSTRAINT PK_EMPLOYEE  PRIMARY KEY (EmployeeId),
		CONSTRAINT FK_EmployeeManager FOREIGN KEY (Manager) REFERENCES EMPLOYEE(EmployeeId),
             	CONSTRAINT FK_EEOCode FOREIGN KEY (EEOCode) REFERENCES EEO_CODE(EEOCode)
                );


/*
CREATE table OVERTIME_RATE
*/

CREATE TABLE OVERTIME_RATE
                (
            	ProjectId 	varchar(20)                   NOT NULL,
              	OTRate    	decimal(10,2) DEFAULT(1.5)    NOT NULL,
		CONSTRAINT PK_OVERTIMERATE PRIMARY KEY (ProjectId),
		CONSTRAINT FK_OVERTIMERATE FOREIGN KEY (ProjectId) REFERENCES PROJECT (ProjectId)
                );


/*
CREATE table PAY_SCALE
*/

CREATE	TABLE  PAY_SCALE	
                (	 
                ProjectId	   	varchar(20)		NOT NULL, 
                JobCode			char(3)		    	NOT NULL, 
                Rate			decimal(10,2)		NOT NULL, 
                FringeBenefits		decimal(10,2)		NOT NULL, 
                CONSTRAINT PK_PAYSCALE		PRIMARY KEY(ProjectID, JobCode), 
                CONSTRAINT FK_PAYSCALE		FOREIGN KEY(ProjectID) REFERENCES PROJECT(ProjectID),
                CONSTRAINT FK_PAYSCALEJOBCODE   FOREIGN KEY(JobCode)  REFERENCES  JOBCODE(JobCode)
                );


/*
CREATE tablee TIMECARD
*/

CREATE TABLE TIMECARD 
                (
                ProjectId           VarChar(20) 	NOT NULL, 
                EmployeeId          Char(9)     	NOT NULL,
                JobCode		    Char(3) 		NOT NULL,     
                WorkDate            Date        	NOT NULL,
                PayPeriodEndDate    Date        	NOT NULL,
                RegHours            Number(4,2) 	NULL,
                OTHours             Number(4,2) 	NULL,
                CONSTRAINT PK_TimecardTable 	PRIMARY KEY (ProjectId, EmployeeId, JobCode, WorkDate),
                CONSTRAINT FK_TimecardPayScale 	FOREIGN KEY (ProjectId, JobCode) REFERENCES PAY_SCALE (ProjectId,JobCode),
                CONSTRAINT FK_TimecardEmployee 	FOREIGN KEY (EmployeeId) REFERENCES EMPLOYEE (EmployeeId)
                );
		
/*
INSERTs for COMPANY table (some examples taken from Exhibits)
*/

INSERT INTO COMPANY VALUES
                (
                '310646843', 'Marcus Company', '8088 Baron St.', NULL,   
                'Lillydale', 'CA', '80286', 'Baker County', '6145550386', '6145550486'
                );


/*
INSERTs for PROJECT table (some examples taken from Exhibits)
*/

INSERT  INTO PROJECT VALUES
                (
                'WA-PIN-335-005', 
                '5 miles south of Washington, California on SR 675 (Pine County)', 
                'Replacement of single-span two-lane bridge (pre-stressed beam type)', 
                'Pine', 
                'Planning'
                );

INSERT INTO PROJECT VALUES
                (
                'NB-SCO-567-009', '10 miles west of New Braxton, Bridge on River Scenic Byway (Scotts county)', 
                'Restorative maintenance of the bridge (sealing deck joints, cracks, lubricating bearings)', 
                'Scotts', 
                'Active'
                );


/*
INSERTs for EEO_CODE table (some examples taken from Exhibits)
*/

INSERT INTO EEO_CODE VALUES
                (
                1, 'Black not of Hispanic Origin', 'Y'
                );

INSERT INTO EEO_CODE VALUES
                (
                2, 'Hispanic', 'Y'
                );

INSERT INTO EEO_CODE VALUES
                (
                3, 'Asian/Pacific Islander', 'Y'
                );

INSERT INTO EEO_CODE VALUES
                (4, 'American Indian or Alaskan Native', 'Y'
                );

INSERT INTO EEO_CODE VALUES
                (
                5, 'Non-Minority (White)', 'N'
                );


/*
INSERTs for JOBCODE table (some examples taken from Exhibits)
*/

INSERT INTO JOBCODE VALUES
                (
                'CAR', 'Carpentry'
                );

INSERT INTO JOBCODE VALUES
                (
                'EQP', 'Equipment Operation'
                );

INSERT INTO JOBCODE VALUES
                (
                'IRN', 'Iron Work'
                );

INSERT INTO JOBCODE VALUES
                (
                'LAB', 'Labor'
                );

INSERT INTO JOBCODE VALUES
                (
                'MAS', 'Masonry'
                );


/*
INSERTs for EMPLOYEE table (some examples taken from Exhibits)
*/

INSERT INTO EMPLOYEE VALUES
                (
                '390054489', 'James', 'Wendel', 'E', '555555555', 'Y', 'M', 5, 
                '1253 Champlin St.', NULL, 'Kent', 'CA', 
                '80286', '555-4897', to_date('16/Nov/83', 'DD/MM/YY'), 'S', NULL			 
                );

INSERT INTO EMPLOYEE VALUES
                (
                '275506921', 'Erick', 'Richards', 'J', '123456789', 'N', 'M', 1, 
                '9876 Blooming Avenue S', NULL, 'Indianapolis', 'CA', 
                '46241', '357-1598', to_date('05/May/80', 'DD/MM/YY'), 'M', '390054489'			 
                );

INSERT INTO EMPLOYEE VALUES
                ('390054515', 'Elissa', 'Nguyen', NULL, '987659876', 'Y', 'F', 3, 
                '6500 American Street', NULL, 'New Braxton', 'CA', 
                '48225', '321-4566', to_date('31/Dec/88', 'DD/MM/YY'), 'M', '390054489'			 
                );


/*
INSERTs for OVERTIME_RATE table (some examples taken from Exhibits)
*/

INSERT INTO OVERTIME_RATE (ProjectID, OTRate) VALUES
                ( 
                'WA-PIN-335-005', DEFAULT 
                );

INSERT INTO OVERTIME_RATE(ProjectID, OTRate) VALUES
                ( 
                'NB-SCO-567-009', 1.5 
                );


/*
INSERTs for PAY_SCALE table (some examples taken from Exhibits)
*/

INSERT INTO PAY_SCALE VALUES
                ( 
                'WA-PIN-335-005', 'CAR', 16.00, 3.00 
                );

INSERT INTO PAY_SCALE VALUES
                ( 
                'NB-SCO-567-009', 'LAB', 15.00, 3.00 
                );

INSERT INTO PAY_SCALE VALUES
                ( 
                'WA-PIN-335-005', 'MAS', 17.00, 3.00 
                );

INSERT INTO PAY_SCALE VALUES
                ( 
                'WA-PIN-335-005', 'IRN', 17.00, 3.00 
                );

INSERT INTO PAY_SCALE VALUES
                ( 
                'WA-PIN-335-005', 'EQP', 20.00, 3.00 
                );

INSERT INTO PAY_SCALE VALUES
                ( 
                'NB-SCO-567-009', 'CAR', 16.00, 3.00 
                );

INSERT INTO PAY_SCALE VALUES
                ( 
                'NB-SCO-567-009', 'LAB', 15.00, 3.00 
                );

INSERT INTO PAY_SCALE VALUES
                ( 
                'NB-SCO-567-009', 'MAS', 17.00, 3.00 
                );

INSERT INTO PAY_SCALE VALUES
                ( 
                'NB-SCO-567-009', 'IRN', 17.00, 3.00 
                );

INSERT INTO PAY_SCALE VALUES
                ( 
                'NB-SCO-567-009', 'EQP', 20.00, 3.00 
                );

/*
INSERTs for TIMECARD table (some examples taken from Exhibits)
*/

INSERT INTO TIMECARD VALUES
                ( 
                'WA-PIN-335-005', '390054515', 'CAR', 
                to_date('12/06/2019', 'MM/DD/YYYY'), to_date('12/13/2019', 'MM/DD/YYYY'), 17.8, NULL 
                );

INSERT INTO TIMECARD VALUES
                ( 
                'NB-SCO-567-009', '390054489', 'LAB', 
                to_date('12/06/2019', 'MM/DD/YYYY'), to_date('12/13/2019', 'MM/DD/YYYY'), 25.00, NULL 
                );

INSERT INTO TIMECARD VALUES
                ( 
                'NB-SCO-567-009', '390054489', 'MAS', 
                to_date('12/06/2019', 'MM/DD/YYYY'), to_date('12/13/2019', 'MM/DD/YYYY'), 5, NULL 
                );

INSERT INTO TIMECARD VALUES
                ( 
                'NB-SCO-567-009', '275506921', 'EQP', 
                to_date('12/06/2019', 'MM/DD/YYYY'), to_date('12/13/2019', 'MM/DD/YYYY'), NULL, 3 
                );

INSERT INTO TIMECARD VALUES
                ( 
                'WA-PIN-335-005', '390054515', 'MAS', 
                to_date('11/29/2019', 'MM/DD/YYYY'), to_date('12/06/2019', 'MM/DD/YYYY'), 7.42, 2.73 
                );

INSERT INTO TIMECARD VALUES
                ( 
                'WA-PIN-335-005', '390054515', 'IRN', 
                to_date('12/06/2019', 'MM/DD/YYYY'), to_date('12/13/2019', 'MM/DD/YYYY'), 3.5, NULL 
                );

INSERT INTO TIMECARD VALUES
                ( 
                'NB-SCO-567-009', '390054515', 'LAB', 
                to_date('12/06/2019', 'MM/DD/YYYY'), to_date('12/13/2019', 'MM/DD/YYYY'), 25.00, NULL 
                );

INSERT INTO TIMECARD VALUES
                ( 
                'WA-PIN-335-005', '390054489', 'EQP', 
                to_date('12/06/2019', 'MM/DD/YYYY'), to_date('12/13/2019', 'MM/DD/YYYY'), 15, 5.68 
                );

INSERT INTO TIMECARD VALUES
                ( 
                'WA-PIN-335-005', '275506921', 'LAB', 
                to_date('12/08/2019', 'MM/DD/YYYY'), to_date('12/13/2019', 'MM/DD/YYYY'), 15.23, NULL 
                );

INSERT INTO TIMECARD VALUES
                ( 
                'WA-PIN-335-005', '275506921', 'MAS', 
                to_date('12/08/2019', 'MM/DD/YYYY'), to_date('12/13/2019', 'MM/DD/YYYY'), 24.77, NULL 
                );

INSERT INTO TIMECARD VALUES
                ( 
                'WA-PIN-335-005', '275506921', 'EQP', 
                to_date('12/08/2019', 'MM/DD/YYYY'), to_date('12/13/2019', 'MM/DD/YYYY'), NULL, 5.6 
                );



