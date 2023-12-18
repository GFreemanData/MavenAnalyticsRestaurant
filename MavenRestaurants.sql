/*
Restaurant Investment Data Analysis


*/

-- Step 1: Restaurant Count per City
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


-- Step 2: Total Cuisine Types in Each City
-- Determines the diversity of cuisines in each city, indicating market variety or oversaturation of certain cuisines.

SELECT 
    res.City AS City, 
    COUNT(DISTINCT rc.Cuisine) AS CuisineTypes
FROM 
    restaurant_cuisines AS rc
JOIN 
    restaurants AS res ON rc.Restaurant_ID = res.Restaurant_ID
GROUP BY 
    City
ORDER BY 
    CuisineTypes DESC;


-- Step 3: Highest Rated Cuisine in Each City
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


-- Step 4: Top Rated Cuisines Excluding Mexican and with More Than One Restaurant
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


-- Insights and Recommendations:
-- Analysis indicates San Luis Potosi has a high concentration of restaurants, suggesting market saturation. In contrast, Jiutepec has fewer restaurants, indicating room for new ventures. Mexican cuisine is prevalent but also oversaturated. Alternative cuisines such as Family, International, Japanese, Brewery, and Contemporary, being the top 5 non-Mexican cuisines with more than one restaurant, present safer investment opportunities. These choices are supported by popularity and high average ratings, indicative of demand and customer satisfaction.
