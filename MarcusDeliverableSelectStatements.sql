/* The following SQL query generates the Project Information shown in Part C of Exhibit B */
Select ProjectId, ProjectLocation, Description
from Project
where ProjectId = 'IN-PIK-335-005';

/* The following SQL query generates the Hours by Job, Gender, Minority Information shown in Part D of Exhibit B */
/*Note We assume the front end application which generates the Form will calculate the % hours Worked by Minority and Female by Dividing the appropriate totals below*/
select 
JOBCODE.JobCode || '-' ||JOBCODE.JobClassification As "Job-Classification",
EMPLOYEE.Gender,
EEO_CODE.Minority,
SUM(COALESCE(RegHours,0)) +  SUM(COALESCE(OTHours,0)) as Hours
From PROJECT 
JOIN OVERTIME_RATE 
ON PROJECT.ProjectId = OVERTIME_RATE.ProjectId
JOIN PAY_SCALE
ON PROJECT.ProjectId = PAY_SCALE.ProjectId
JOIN JOBCODE
ON PAY_SCALE.JobCode = JOBCODE.JobCode
JOIN TIMECARD
ON PROJECT.ProjectId = TIMECARD.ProjectId AND PAY_SCALE.JobCode = TIMECARD.JobCode
JOIN EMPLOYEE
ON TIMECARD.EmployeeId = EMPLOYEE.EmployeeId
JOIN EEO_CODE
ON EMPLOYEE.EEOCode = EEO_CODE.EEOCode
where PROJECT.ProjectId = 'IN-PIK-335-005'
and TIMECARD.PAYPERIODENDDATE = '13-DEC-2019'
Group By JOBCODE.JobCode, JOBCODE.JobClassification, EMPLOYEE.Gender,EEO_CODE.Minority
;

/* The following SQL query generates the Total by Gender, Minority Information shown in Part D of Exhibit B */
select 
EMPLOYEE.Gender,
EEO_CODE.Minority,
SUM(COALESCE(RegHours,0)) +  SUM(COALESCE(OTHours,0)) as Hours
From PROJECT 
JOIN OVERTIME_RATE 
ON PROJECT.ProjectId = OVERTIME_RATE.ProjectId
JOIN PAY_SCALE
ON PROJECT.ProjectId = PAY_SCALE.ProjectId
JOIN JOBCODE
ON PAY_SCALE.JobCode = JOBCODE.JobCode
JOIN TIMECARD
ON PROJECT.ProjectId = TIMECARD.ProjectId AND PAY_SCALE.JobCode = TIMECARD.JobCode
JOIN EMPLOYEE
ON TIMECARD.EmployeeId = EMPLOYEE.EmployeeId
JOIN EEO_CODE
ON EMPLOYEE.EEOCode = EEO_CODE.EEOCode
where PROJECT.ProjectId = 'IN-PIK-335-005'
and TIMECARD.PAYPERIODENDDATE = '13-DEC-2019'
Group By EMPLOYEE.Gender,EEO_CODE.Minority
;

/* The following SQL query generates the Total by Job shown in Part D of Exhibit B */
select 
JOBCODE.JobCode || '-' ||JOBCODE.JobClassification As "Job-Classification",
SUM(COALESCE(RegHours,0)) +  SUM(COALESCE(OTHours,0)) as Hours
From PROJECT 
JOIN OVERTIME_RATE 
ON PROJECT.ProjectId = OVERTIME_RATE.ProjectId
JOIN PAY_SCALE
ON PROJECT.ProjectId = PAY_SCALE.ProjectId
JOIN JOBCODE
ON PAY_SCALE.JobCode = JOBCODE.JobCode
JOIN TIMECARD
ON PROJECT.ProjectId = TIMECARD.ProjectId AND PAY_SCALE.JobCode = TIMECARD.JobCode
JOIN EMPLOYEE
ON TIMECARD.EmployeeId = EMPLOYEE.EmployeeId
JOIN EEO_CODE
ON EMPLOYEE.EEOCode = EEO_CODE.EEOCode
where PROJECT.ProjectId = 'IN-PIK-335-005'
and TIMECARD.PAYPERIODENDDATE = '13-DEC-2019'
Group By JOBCODE.JobCode, JOBCODE.JobClassification
;

/* The following SQL query generates the Sum Total Hours shown in Part D of Exhibit B */
select 
SUM(COALESCE(RegHours,0)) +  SUM(COALESCE(OTHours,0)) as Hours
From PROJECT 
JOIN OVERTIME_RATE 
ON PROJECT.ProjectId = OVERTIME_RATE.ProjectId
JOIN PAY_SCALE
ON PROJECT.ProjectId = PAY_SCALE.ProjectId
JOIN JOBCODE
ON PAY_SCALE.JobCode = JOBCODE.JobCode
JOIN TIMECARD
ON PROJECT.ProjectId = TIMECARD.ProjectId AND PAY_SCALE.JobCode = TIMECARD.JobCode
JOIN EMPLOYEE
ON TIMECARD.EmployeeId = EMPLOYEE.EmployeeId
JOIN EEO_CODE
ON EMPLOYEE.EEOCode = EEO_CODE.EEOCode
where PROJECT.ProjectId = 'IN-PIK-335-005'
and TIMECARD.PAYPERIODENDDATE = '13-DEC-2019'
;

/* The following SQL query generates the Detailed Pay Scale Breakdown shown in Part C of Exhibit C */
Select PAY_SCALE.JobCode, JOBCODE.JobClassification, Rate, FringeBenefits, Rate + FringeBenefits as "Total Compensation"
From PAY_SCALE 
JOIN JOBCODE 
ON PAY_SCALE.JobCode = JOBCODE.JobCode
where ProjectId = 'IN-PIK-335-005'
ORDER BY "Total Compensation" ASC;

/* The following SQL query generates the Information in the Regular Hours Worked Form shown in Part D of Exhibit D */
select EMPLOYEE.EmployeeId, JOBCODE.JobCode, PAY_SCALE.Rate, PAY_SCALE.FringeBenefits, Rate + FringeBenefits as "Total", TIMECARD.RegHours, (Rate + FringeBenefits) * RegHours as "Gross"
From  PAY_SCALE
JOIN JOBCODE
ON PAY_SCALE.JobCode = JOBCODE.JobCode
JOIN TIMECARD
ON PAY_SCALE.ProjectId = TIMECARD.ProjectId AND PAY_SCALE.JobCode = TIMECARD.JobCode
JOIN EMPLOYEE
ON TIMECARD.EmployeeId = EMPLOYEE.EmployeeId
where TIMECARD.ProjectId = 'IN-PIK-335-005'
and TIMECARD.PayPeriodEndDate = '13-DEC-19'
and TIMECARD.RegHours is not null
;

/* The following SQL query generates the Information in the Overtime Hours Worked Form shown in Part E of Exhibit D */
select EMPLOYEE.EmployeeId, JOBCODE.JobCode, PAY_SCALE.Rate, PAY_SCALE.FringeBenefits, Rate* OTRate + FringeBenefits as "Total", 
TIMECARD.OTHours, (Rate * OTRate + FringeBenefits) * OTHours as "Gross"
From  PAY_SCALE
JOIN JOBCODE
ON PAY_SCALE.JobCode = JOBCODE.JobCode
JOIN TIMECARD
ON PAY_SCALE.ProjectId = TIMECARD.ProjectId AND PAY_SCALE.JobCode = TIMECARD.JobCode
JOIN EMPLOYEE
ON TIMECARD.EmployeeId = EMPLOYEE.EmployeeId
JOIN OVERTIME_RATE 
ON TIMECARD.ProjectId = OVERTIME_RATE.ProjectId
where TIMECARD.ProjectId = 'IN-PIK-335-005'
and TIMECARD.PayPeriodEndDate = '13-DEC-19'
AND TIMECARD.OTHours IS NOT NULL
;

/* The following SQL query generates the Information in the Total Hours Worked Per Skill Classification Form shown in Part F of Exhibit D*/
select  JOBCODE.JobCode, SUM(RegHours), SUM(OTHOURS), SUM(COALESCE(RegHours,0)) + SUM (COALESCE(OTHours,0)) as Total
From  PAY_SCALE
JOIN JOBCODE
ON PAY_SCALE.JobCode = JOBCODE.JobCode
JOIN TIMECARD
ON PAY_SCALE.ProjectId = TIMECARD.ProjectId AND PAY_SCALE.JobCode = TIMECARD.JobCode
JOIN EMPLOYEE
ON TIMECARD.EmployeeId = EMPLOYEE.EmployeeId
where TIMECARD.ProjectId = 'IN-PIK-335-005'
and TIMECARD.PayPeriodEndDate = '13-DEC-19'
Group by JOBCODE.JobCode
;

/* The following SQL query generates the Information on the General Employee Information Form shown in  Exhibit E*/
select EMPLOYEE.SocialSecurity, EMPLOYEE.LastName, EMPLOYEE.FirstName, EMPLOYEE.MI,
EMPLOYEE.Address1, EMPLOYEE.City, EMPLOYEE.State, EMPLOYEE.Zip,
EMPLOYEE.Phone, EMPLOYEE.BirthDate, EMPLOYEE.Gender, EMPLOYEE.MaritalStatus, EEO_CODE.EEOCode
from EMPLOYEE
JOIN EEO_CODE
ON EMPLOYEE.EEOCode = EEO_CODE.EEOCode
Where EMPLOYEE.EmployeeId = '390054489'
;

/* The following 2 SQL queries generates the Information as shown in Weekly Pay Information Exhibit F Regular Pay*/
select PROJECT.Job, JOBCODE.JobClassification, PAY_SCALE.Rate, PAY_SCALE.FringeBenefits, PAY_SCALE.Rate + PAY_SCALE.FringeBenefits As Total, 
TIMECARD.RegHours, (PAY_SCALE.Rate + PAY_SCALE.FringeBenefits)*TIMECARD.RegHours as Gross
From PROJECT 
JOIN OVERTIME_RATE 
ON PROJECT.ProjectId = OVERTIME_RATE.ProjectId
JOIN PAY_SCALE
ON PROJECT.ProjectId = PAY_SCALE.ProjectId
JOIN JOBCODE
ON PAY_SCALE.JobCode = JOBCODE.JobCode
JOIN TIMECARD
ON PROJECT.ProjectId = TIMECARD.ProjectId AND PAY_SCALE.JobCode = TIMECARD.JobCode
Where TIMECARD.EmployeeId = '390054515'
AND TIMECARD.PayPeriodEndDate = '06-DEC-19';

Select SUM(TIMECARD.RegHours) as "Total Regular Pay Hours", SUM((PAY_SCALE.Rate + PAY_SCALE.FringeBenefits)*TIMECARD.RegHours) as "Total Regular Pay"
From PROJECT 
JOIN OVERTIME_RATE 
ON PROJECT.ProjectId = OVERTIME_RATE.ProjectId
JOIN PAY_SCALE
ON PROJECT.ProjectId = PAY_SCALE.ProjectId
JOIN JOBCODE
ON PAY_SCALE.JobCode = JOBCODE.JobCode
JOIN TIMECARD
ON PROJECT.ProjectId = TIMECARD.ProjectId AND PAY_SCALE.JobCode = TIMECARD.JobCode
where TIMECARD.EmployeeId = '390054515'
AND TIMECARD.PayPeriodEndDate = '06-DEC-19';

/* The following 2 SQL queries generates the Information as shown in Weekly Pay Information Exhibit F Overtime Pay*/
select PROJECT.Job, JOBCODE.JobClassification, PAY_SCALE.Rate, PAY_SCALE.FringeBenefits, PAY_SCALE.Rate*OVERTIME_RATE.OTRate + PAY_SCALE.FringeBenefits As "Total*", 
TIMECARD.OTHours, (PAY_SCALE.Rate*OVERTIME_RATE.OTRate + PAY_SCALE.FringeBenefits)*TIMECARD.OTHours as Gross 
From PROJECT 
JOIN OVERTIME_RATE 
ON PROJECT.ProjectId = OVERTIME_RATE.ProjectId
JOIN PAY_SCALE
ON PROJECT.ProjectId = PAY_SCALE.ProjectId
JOIN JOBCODE
ON PAY_SCALE.JobCode = JOBCODE.JobCode
JOIN TIMECARD
ON PROJECT.ProjectId = TIMECARD.ProjectId AND PAY_SCALE.JobCode = TIMECARD.JobCode
where TIMECARD.OTHours > 0
AND TIMECARD.EmployeeId = '390054515'
AND TIMECARD.PayPeriodEndDate = '06-DEC-19';

Select SUM(TIMECARD.OTHours) as "Total Overtime Pay Hours", SUM((PAY_SCALE.Rate*OVERTIME_RATE.OTRate + PAY_SCALE.FringeBenefits)*TIMECARD.OTHours) as "Total Overtime Pay"
From PROJECT 
JOIN OVERTIME_RATE 
ON PROJECT.ProjectId = OVERTIME_RATE.ProjectId
JOIN PAY_SCALE
ON PROJECT.ProjectId = PAY_SCALE.ProjectId
JOIN JOBCODE
ON PAY_SCALE.JobCode = JOBCODE.JobCode
JOIN TIMECARD
ON PROJECT.ProjectId = TIMECARD.ProjectId AND PAY_SCALE.JobCode = TIMECARD.JobCode
where  TIMECARD.OTHours > 0
AND TIMECARD.EmployeeId = '390054515'
AND TIMECARD.PayPeriodEndDate = '06-DEC-19'
;




