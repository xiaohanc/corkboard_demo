SELECT t0.name, Public_CorkBoards, Public_PushPins,Private_CorkBoards, Private_PushPins From

    (SELECT email, name from user) t0
    LEFT JOIN
    (SELECT email, count(*) as Public_CorkBoards FROM `corkboard` c, publiccorkboard p where c.corkBoardID=p.corkBoardID group by email) t4 on t0.email= t4.email
    LEFT JOIN
    (SELECT email, Public_PushPins from
                    (SELECT User.email, Count(DISTINCT corkboard.CorkBoardID) AS Public_CorkBoards, Count(Pushpin.pushPinID ) AS Public_PushPins
            FROM  (USER Inner JOIN (PublicCorkboard INNER JOIN Corkboard on PublicCorkboard.CorkboardID= Corkboard.CorkboardID) on User.email= Corkboard.email Inner Join PushPin on Corkboard.CorkboardID=PushPin.CorkboardID )
            group by user.email) as a) t1 on t0.email=t1.email
    LEFT JOIN
    (SELECT email, count(*) as Private_CorkBoards FROM `corkboard` c, privatecorkboard pr where c.corkBoardID=pr.corkBoardID group by email) t5 on t0.email= t5.email
    LEFT JOIN
    (SELECT email, Private_PushPins from
            (SELECT User.email, Count(DISTINCT corkboard.CorkBoardID) AS Private_CorkBoards, Count(Pushpin.pushPinID ) AS Private_PushPins
            FROM  (USER Inner JOIN (PrivateCorkBoard INNER JOIN Corkboard on PrivateCorkBoard.CorkboardID= Corkboard.CorkboardID) on User.email= Corkboard.email Inner Join PushPin on Corkboard.CorkboardID=PushPin.CorkboardID )
            group by user.email) as b) t2
     on t1.email=t2.email
    ORDER BY Public_CorkBoards DESC, Private_CorkBoards DESC, Private_CorkBoards DESC, Private_PushPins DESC;
    SELECT email, count(*) FROM `corkboard` c, publiccorkboard p where c.corkBoardID=p.corkBoardID group by email;
