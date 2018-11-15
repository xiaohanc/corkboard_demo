SELECT recent.corkBoardID, recent.email, recent.cat_name, recent.title, recent.last_update, recent.password, recent.name
    FROM
    ((SELECT CorkBoard.corkBoardID, CorkBoard.email, CorkBoard.cat_name, CorkBoard.title, CorkBoard.last_update, PrivateCorkboard.password, User.name
    FROM Follow, CorkBoard, PrivateCorkboard, User
    WHERE Follow.email= '""" + current_user.email + """' AND Follow.owner_email=CorkBoard.email and PrivateCorkboard.corkBoardID=Corkboard.corkBoardID and User.email= Follow.owner_email)
    UNION
    (SELECT CorkBoard.corkBoardID, CorkBoard.email, CorkBoard.cat_name, CorkBoard.title, CorkBoard.last_update, NULL as password, User.name
    FROM Follow, CorkBoard, User
    WHERE Follow.email= '""" + current_user.email + """' AND Follow.owner_email=CorkBoard.email and User.email= Follow.owner_email and Corkboard.corkBoardID not in (SELECT corkBoardID from PrivateCorkboard))
    UNION
    (SELECT CorkBoard.corkBoardID,corkBoard.email, CorkBoard.cat_name, CorkBoard.title, CorkBoard.last_update, NULL as password, User.name
    FROM Watch, corkBoard, User
    WHERE Watch.email='""" + current_user.email + """' and Watch.corkBoardID = corkBoard.corkBoardID and User.email= corkBoard.email)) recent
    ORDER BY recent.last_update DESC LIMIT 4


    (SELECT email, Public_PushPins from
    (SELECT User.email, Count(DISTINCT corkboard.CorkBoardID) AS Public_CorkBoards, Count(Pushpin.pushPinID ) AS Public_PushPins
    FROM  (USER Inner JOIN (SELECT * from corkboard where corkboard.corkBoardID not in (SELECT corkBoardID from PrivateCorkboard) t on User.email= t.email Inner Join PushPin on Corkboard.CorkboardID=PushPin.CorkboardID )
    group by user.email) as a) t1 on t0.email=t1.email



    SELECT t0.name, IFNULL(Public_CorkBoards, 0 ), IFNULL(Public_PushPins, 0 ),IFNULL(Private_CorkBoards, 0 ), IFNULL(Private_PushPins, 0 ) From
    (SELECT email, name from user) t0
    LEFT JOIN
    (SELECT email, count(*) as Public_CorkBoards FROM `corkboard` c where c.corkBoardID not in (SELECT corkBoardID from PrivateCorkboard) group by email) t4 on t0.email= t4.email
    LEFT JOIN
    (SELECT email, Public_PushPins from
            (SELECT User.email, Count(DISTINCT t.CorkBoardID) AS Public_CorkBoards, Count(Pushpin.pushPinID ) AS Public_PushPins
            FROM  (USER Inner JOIN(SELECT * from corkboard where corkboard.corkBoardID not in (SELECT corkBoardID from PrivateCorkboard)) t on User.email= t.email Inner Join PushPin on t.CorkboardID=PushPin.CorkboardID )
    group by user.email) as a) t1 on t0.email=t1.email
    LEFT JOIN
    (SELECT email, count(*) as Private_CorkBoards FROM `corkboard` c, privatecorkboard pr where c.corkBoardID=pr.corkBoardID group by email) t5 on t0.email= t5.email
    LEFT JOIN
    (SELECT email, Private_PushPins from
            (SELECT User.email, Count(DISTINCT corkboard.CorkBoardID) AS Private_CorkBoards, Count(Pushpin.pushPinID ) AS Private_PushPins
            FROM  (USER Inner JOIN (PrivateCorkBoard INNER JOIN Corkboard on PrivateCorkBoard.CorkboardID= Corkboard.CorkboardID) on User.email= Corkboard.email Inner Join PushPin on Corkboard.CorkboardID=PushPin.CorkboardID )
            group by user.email) as b) t2
    on t0.email=t2.email
    ORDER BY Public_CorkBoards DESC, Private_CorkBoards DESC, Private_CorkBoards DESC, Private_PushPins DESC;
    SELECT email, count(*) FROM `corkboard` c, publiccorkboard p where c.corkBoardID=p.corkBoardID group by email;
