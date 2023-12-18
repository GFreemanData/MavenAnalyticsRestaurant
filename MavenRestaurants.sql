/*
Restaurant Investment Data Analysis

*/

-- Restaurant Count per City
-- Identifies the number of restaurants in each city, highlighting potential market saturation or opportunities.

SELECT 
    res.City AS City, 
    COUNT(DISTINCT res.Restaurant_ID) AS RestaurantCount
FROM 
    restaurants AS res
GROUP BY 
    City
ORDER BY 
    RestaurantCount DESC;

-- Total Cuisine Types in Each City
-- Determines the diversity of cuisines in each city, indicating market variety or oversaturation of certain cuisines.

SELECT 
    res.City AS City, 
    COUNT(DISTINCT rc.Cuisine) AS DifferentCuisines
FROM 
    restaurant_cuisines AS rc
JOIN 
    restaurants AS res ON rc.Restaurant_ID = res.Restaurant_ID
GROUP BY 
    City
ORDER BY 
    DifferentCuisines DESC;

-- Highest Rated Cuisine in Each City
-- Finds the top-rated cuisine in each city to identify potential high performers.

SELECT 
    res.City AS City,
    rc.Cuisine AS Cuisine, 
    AVG(r.Overall_Rating) AS AverageRating
FROM 
    restaurant_cuisines AS rc
JOIN 
    ratings AS r ON rc.Restaurant_ID = r.Restaurant_ID
JOIN 
    restaurants AS res ON rc.Restaurant_ID = res.Restaurant_ID
GROUP BY 
    City, Cuisine
ORDER BY 
    City, AverageRating DESC;

-- Top Rated Cuisines Excluding Mexican and with More Than One Restaurant
-- Filters out Mexican cuisine and focuses on cuisines with more than one restaurant to avoid flukes.

SELECT 
    rc.Cuisine AS Cuisine, 
    COUNT(DISTINCT rc.Restaurant_ID) AS NumberOfRestaurants, 
    AVG(r.Overall_Rating) AS AverageRating
FROM 
    restaurant_cuisines AS rc
JOIN 
    ratings AS r ON rc.Restaurant_ID = r.Restaurant_ID
WHERE 
    rc.Cuisine <> 'Mexican'
GROUP BY 
    Cuisine
HAVING 
    COUNT(DISTINCT rc.Restaurant_ID) > 1
ORDER BY 
    AverageRating DESC, NumberOfRestaurants DESC;

-- Consumer Cuisine Preferences
-- Assesses the most preferred cuisines among consumers in each city.

SELECT 
    c.City AS City, 
    cp.Preferred_Cuisine AS PreferredCuisine, 
    COUNT(*) AS PreferenceCount
FROM 
    consumer_preferences AS cp
JOIN 
    consumers AS c ON cp.Consumer_ID = c.Consumer_ID
GROUP BY 
    City, PreferredCuisine
ORDER BY 
    City, PreferenceCount DESC;

-- Analysis of Oversaturated Cuisines
-- Identifies cuisines that are overly common in each city, potentially indicating market saturation.

SELECT 
    res.City AS City,
    rc.Cuisine AS Cuisine, 
    COUNT(DISTINCT rc.Restaurant_ID) AS RestaurantCount
FROM 
    restaurant_cuisines AS rc
JOIN 
    restaurants AS res ON rc.Restaurant_ID = res.Restaurant_ID
GROUP BY 
    City, Cuisine
HAVING 
    RestaurantCount > (SELECT AVG(Count) FROM (SELECT COUNT(*) AS Count FROM restaurant_cuisines GROUP BY Cuisine) AS AverageCount)
ORDER BY 
    City, RestaurantCount DESC;

--The analysis indicates optimal investment opportunities in cities like Ciudad Victoria and Cuernavaca, where restaurant markets are less saturated. San Luis Potosi shows a high density of restaurants, particularly Mexican cuisine, suggesting market saturation. Diversifying into underrepresented cuisines such as Family, International, Japanese, Brewery, and Contemporary, which are popular but less common, presents a promising strategy for new restaurant ventures.






