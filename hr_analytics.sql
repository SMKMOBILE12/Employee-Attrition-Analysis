select * from hr_analytics_dataset;
-- Overall Attrition Rate
CREATE VIEW overall_att_rate as 
SELECT 
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM hr_analytics_dataset;

-- Attrition by Department
CREATE VIEW attrition_by_dept as 
SELECT 
    Department,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM hr_analytics_dataset
GROUP BY Department
ORDER BY AttritionRate DESC;

-- Attrition by Gender and Age Group
CREATE VIEW attrition_by_gender_agegroup as 
SELECT 
    Gender,
    CASE 
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50+'
    END AS AgeGroup,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM hr_analytics_dataset
GROUP BY Gender, AgeGroup;

-- Income by Job Role and Education Level
CREATE VIEW income_by_jobrole as
SELECT 
    JobRole,
    EducationLevel,
    ROUND(AVG(MonthlyIncome), 2) AS AvgIncome
FROM hr_analytics_dataset
GROUP BY JobRole, EducationLevel
ORDER BY AvgIncome DESC;

-- Avg Tenure by Department
CREATE VIEW avg_tenure_dept as
SELECT 
    Department,
    ROUND(AVG(YearsAtCompany), 2) AS AvgYearsAtCompany,
    ROUND(AVG(YearsInCurrentRole), 2) AS AvgYearsInCurrentRole
FROM hr_analytics_dataset
GROUP BY Department
ORDER BY AvgYearsAtCompany DESC;

-- Training vs Attrition
CREATE VIEW training_vs_attrition as
SELECT 
    TrainingTimesLastYear,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM hr_analytics_dataset
GROUP BY TrainingTimesLastYear
ORDER BY TrainingTimesLastYear;

-- Performance vs Attrition
CREATE VIEW performance_vs_attrition as
SELECT 
    PerformanceRating,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM hr_analytics_dataset
GROUP BY PerformanceRating
ORDER BY PerformanceRating;
