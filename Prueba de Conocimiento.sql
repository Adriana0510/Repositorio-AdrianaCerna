/*CREACION DE LAS TABLAS*/
create table teams (
      team_id integer not null,
      team_name varchar(30) not null,
      unique(team_id)
  );

  create table matches (
      match_id integer not null,
      host_team integer not null,
      guest_team integer not null,
      host_goals integer not null,
      guest_goals integer not null,
      unique(match_id)
  );

 /*LLAVES PIMARIAS*/
 alter table teams
 add primary key (team_id);

 alter table matches
 add primary key (match_id);

/*INSERTAR VALORES EN LA TABLA TEAMS*/
INSERT INTO teams (team_id,team_name)
VALUES (10,'Give');

INSERT INTO teams (team_id,team_name)
VALUES (20,'Never');

INSERT INTO teams (team_id,team_name)
VALUES (30,'You');

INSERT INTO teams (team_id,team_name)
VALUES (40,'Up');

INSERT INTO teams (team_id,team_name)
VALUES (50,'Gonna');

/*REVISAR LOS VALORES DE LA TABLA TEAMS*/
SELECT *FROM teams;

/*INSERTAR VALORES EN LA TABLA MATCHES*/
INSERT INTO matches (match_id, host_team, guest_team, host_goals, guest_goals)
VALUES (1,30,20,1,0);

INSERT INTO matches (match_id, host_team, guest_team, host_goals, guest_goals)
VALUES (2,10,20,1,2);

INSERT INTO matches (match_id, host_team, guest_team, host_goals, guest_goals)
VALUES (3,20,50,2,2);

INSERT INTO matches (match_id, host_team, guest_team, host_goals, guest_goals)
VALUES (4,10,30,1,0);

INSERT INTO matches (match_id, host_team, guest_team, host_goals, guest_goals)
VALUES (5,30,50,0,1);

/*REVISAR LOS VALORES DE LA TABLA TEAMS*/
SELECT *FROM matches;

/*SUMA DE LOS PUNTOS*/
SELECT team_id, team_name,
COALESCE (SUM(CASE WHEN team_id = host_team THEN
(CASE WHEN host_goals > guest_goals THEN 3 WHEN host_goals = guest_goals THEN 1 WHEN host_goals < guest_goals THEN 0 END)
WHEN team_id = guest_team THEN
(CASE WHEN guest_goals > host_goals THEN 3 WHEN guest_goals = host_goals THEN 1	WHEN guest_goals < host_goals THEN 0 END)
END),0) AS num_points
	
/*CREACION DE LEFT JOIN*/
FROM teams
LEFT JOIN matches
ON
teams.team_id = matches.host_team
OR teams.team_id = matches.guest_team
GROUP BY team_id, team_name
ORDER BY num_points desc, team_id;