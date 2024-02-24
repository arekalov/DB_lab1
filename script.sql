BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS nationality
(
    name        TEXT PRIMARY KEY,
    description TEXT NULL
);

CREATE TABLE IF NOT EXISTS position
(
    id          SERIAL PRIMARY KEY,
    name        TEXT NOT NULL,
    description TEXT NULL
);

CREATE TABLE IF NOT EXISTS project_type
(
    name        TEXT PRIMARY KEY,
    description TEXT NULL
);

CREATE TABLE IF NOT EXISTS location
(
    id           SERIAL PRIMARY KEY,
    coordinate_x REAL NOT NULL,
    coordinate_y REAL NOT NULL,
    underground  BOOLEAN DEFAULT false
);

CREATE TABLE IF NOT EXISTS laboratory
(
    id                  SERIAL PRIMARY KEY,
    name                TEXT                                          NOT NULL,
    location            INTEGER REFERENCES location ON DELETE CASCADE NOT NULL,
    number_of_employees INTEGER                                       NOT NULL CHECK ( number_of_employees >= 0 ),
    is_secret           BOOLEAN DEFAULT false
);

CREATE TABLE IF NOT EXISTS employee
(
    id       SERIAL PRIMARY KEY,
    name     TEXT                                          NOT NULL,
    age      INTEGER                                       NOT NULL CHECK ( age > 0 and age < 100 ),
    nationality     TEXT REFERENCES nationality ON DELETE CASCADE NOT NULL,
    position INTEGER REFERENCES position ON DELETE CASCADE NOT NULL,
    salary   BIGINT                                        NULL CHECK ( salary >= 0 )
);

CREATE TABLE IF NOT EXISTS problem
(
    id          SERIAL PRIMARY KEY,
    date        DATE NOT NULL,
    description TEXT NOT NULL,
    is_resolved BOOLEAN DEFAULT false
);

CREATE TABLE IF NOT EXISTS project
(
    name       TEXT PRIMARY KEY,
    employee   INTEGER REFERENCES employee ON DELETE CASCADE   NOT NULL,
    laboratory INTEGER REFERENCES laboratory ON DELETE CASCADE NOT NULL,
    type       TEXT REFERENCES project_type ON DELETE CASCADE  NOT NULL,
    start_date DATE                                            NOT NULL,
    end_date   DATE                                            NOT NULL,
    done       BOOLEAN DEFAULT false
);

CREATE TABLE IF NOT EXISTS project_problems
(
    projectID TEXT REFERENCES project ON DELETE CASCADE    NOT NULL,
    problemID INTEGER REFERENCES problem ON DELETE CASCADE NOT NULL,
    PRIMARY KEY (problemID, projectID)
);


INSERT INTO nationality (name)
VALUES ('russian')
ON CONFLICT DO NOTHING;
INSERT INTO nationality (name)
VALUES ('belorussian')
ON CONFLICT DO NOTHING;
INSERT INTO nationality (name)
VALUES ('american')
ON CONFLICT DO NOTHING;
INSERT INTO nationality (name)
VALUES ('bulgarian')
ON CONFLICT DO NOTHING;
INSERT INTO nationality (name)
VALUES ('spanish')
ON CONFLICT DO NOTHING;


INSERT INTO position (name, description)
VALUES ('engineer', 'Engineers innovate, design, and problem-solve to create solutions that shape the world around us')
ON CONFLICT DO NOTHING;
INSERT INTO position (name, description)
VALUES ('programmer',
        'Programmers use their expertise in coding languages to craft intricate digital systems and bring innovative ideas to life in the realm of technology')
ON CONFLICT DO NOTHING;
INSERT INTO position (name, description)
VALUES ('manager',
        'Managers coordinate and empower teams, navigate challenges, and drive success by fostering collaboration and strategic decision-making within organizations')
ON CONFLICT DO NOTHING;
INSERT INTO position (name, description)
VALUES ('doctor',
        'Doctors dedicate themselves to healing, compassionately caring for patients, diagnosing ailments, and continually advancing medical knowledge to enhance human health and well-being')
ON CONFLICT DO NOTHING;
INSERT INTO position (name, description)
VALUES ('chemist',
        'Chemists explore the properties and interactions of substances at the molecular level, unlocking insights that fuel advancements in medicine, materials science, and countless other fields.')
ON CONFLICT DO NOTHING;

INSERT INTO project_type (name, description)
VALUES ('research',
        'Research is the systematic exploration of questions, hypotheses, and phenomena, aiming to expand knowledge, solve problems, and drive progress across various disciplines and industries.')
ON CONFLICT DO NOTHING;
INSERT INTO project_type (name, description)
VALUES ('meetup',
        'Meetups are informal gatherings where like-minded individuals come together to share interests, hobbies, or professional pursuits, fostering community, learning, and networking opportunities in a relaxed setting.')
ON CONFLICT DO NOTHING;
INSERT INTO project_type (name, description)
VALUES ('product',
        'Product IT encompasses the technology solutions, including software, hardware, networks, and services, tailored to meet specific business or consumer needs, driving efficiency and digital transformation.')
ON CONFLICT DO NOTHING;
INSERT INTO project_type (name, description)
VALUES ('conference', '
Conferences are gatherings where professionals convene to share knowledge, discuss industry trends, network, and collaborate, fostering innovation and driving progress within their respective fields.')
ON CONFLICT DO NOTHING;

INSERT INTO location (coordinate_x, coordinate_y)
VALUES (12.1, 12.2)
ON CONFLICT DO NOTHING;
INSERT INTO location (coordinate_x, coordinate_y)
VALUES (65.21, 12.123)
ON CONFLICT DO NOTHING;
INSERT INTO location (coordinate_x, coordinate_y)
VALUES (40, 30)
ON CONFLICT DO NOTHING;
INSERT INTO location (coordinate_x, coordinate_y, underground)
VALUES (43.1, 12.2, true)
ON CONFLICT DO NOTHING;
INSERT INTO location (coordinate_x, coordinate_y, underground)
VALUES (41, 12, true)
ON CONFLICT DO NOTHING;

INSERT INTO laboratory (name, location, number_of_employees, is_secret)
VALUES ('lab1', 1, 10, false)
ON CONFLICT DO NOTHING;
INSERT INTO laboratory (name, location, number_of_employees, is_secret)
VALUES ('lab2', 2, 20, true)
ON CONFLICT DO NOTHING;
INSERT INTO laboratory (name, location, number_of_employees, is_secret)
VALUES ('lab3', 3, 30, false)
ON CONFLICT DO NOTHING;
INSERT INTO laboratory (name, location, number_of_employees, is_secret)
VALUES ('lab4', 4, 40, true)
ON CONFLICT DO NOTHING;
INSERT INTO laboratory (name, location, number_of_employees, is_secret)
VALUES ('lab5', 5, 50, false)
ON CONFLICT DO NOTHING;

-- INSERT INTO employee (name, age, nationality, position, salary)
-- VALUES ('Ivan', 25, 'russian', 1, 1000) ON CONFLICT DO NOTHING;
INSERT INTO employee (name, age, nationality, position, salary)
VALUES ('Petr', 30, 'belorussian', 2, 2000) ON CONFLICT DO NOTHING;
INSERT INTO employee (name, age, nationality, position)
VALUES ('John', 35, 'american', 3) ON CONFLICT DO NOTHING;
INSERT INTO employee (name,age, nationality, position, salary)
VALUES ('Vladimir', 40, 'bulgarian', 4, 4000) ON CONFLICT DO NOTHING;
INSERT INTO employee (name, age, nationality, position, salary)
VALUES ('Antonio', 45, 'spanish', 5, 5000) ON CONFLICT DO NOTHING;
INSERT INTO employee (name, age, nationality, position, salary)
VALUES ('Igor', 21, 'russian', 1, 5000) ON CONFLICT DO NOTHING;
INSERT INTO employee (name, age,nationality,position)
VALUES ('Pavel', 22, 'belorussian', 2) ON CONFLICT DO NOTHING;

INSERT INTO problem (date, description, is_resolved)
VALUES ('2021-01-01', 'problem1', false) ON CONFLICT DO NOTHING;
INSERT INTO problem (date, description, is_resolved)
VALUES ('2021-01-02', 'problem2', false) ON CONFLICT DO NOTHING;
INSERT INTO problem (date, description, is_resolved)
VALUES ('2021-01-03', 'problem3', false) ON CONFLICT DO NOTHING;

INSERT INTO project (name, employee, laboratory, type, start_date, end_date, done)
VALUES ('main pro', 1, 1, 'research', '2021-01-01', '2021-01-02', false) ON CONFLICT DO NOTHING;
INSERT INTO project (name, employee, laboratory, type, start_date, end_date)
VALUES ('project', 2, 5, 'meetup', '2021-01-01', '2021-01-02') ON CONFLICT DO NOTHING;
INSERT INTO project (name, employee, laboratory, type, start_date, end_date, done)
VALUES ('project2', 3, 4, 'product', '2021-01-01', '2021-01-02', false) ON CONFLICT DO NOTHING;
INSERT INTO project (name, employee, laboratory, type, start_date, end_date, done)
VALUES ('project3', 4, 3, 'conference', '2021-01-01', '2021-01-02', false) ON CONFLICT DO NOTHING;

INSERT INTO project_problems (projectID, problemID)
VALUES ('main pro', 1) ON CONFLICT DO NOTHING;
INSERT INTO project_problems (projectID, problemID)
VALUES ('main pro', 2) ON CONFLICT DO NOTHING;
INSERT INTO project_problems (projectID, problemID)
VALUES ('project', 3) ON CONFLICT DO NOTHING;

COMMIT;