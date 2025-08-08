CREATE TABLE Movie (
    movie_ID INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255),
    production_company VARCHAR(255),
    category VARCHAR(50)
);

CREATE TABLE Series (
    series_ID INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255),
    production_company VARCHAR(255),
    category VARCHAR(50)
);

CREATE TABLE Genres_Movie (
    ID INT PRIMARY KEY IDENTITY(1,1),  
    movie_ID INT,
    genre VARCHAR(50),
    FOREIGN KEY (movie_ID) REFERENCES Movie(movie_ID)
);

CREATE TABLE Genres_Series (
    ID INT PRIMARY KEY IDENTITY(1,1), 
    series_ID INT,
    genre VARCHAR(50),
    FOREIGN KEY (series_ID) REFERENCES Series(series_ID)
);

CREATE TABLE Platform (
    name VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Streams_Movie (
    movie_ID INT,
    ordinal_number INT,
    platform_name VARCHAR(50),
    PRIMARY KEY (movie_ID, platform_name),
    FOREIGN KEY (movie_ID) REFERENCES Movie(movie_ID),
    FOREIGN KEY (platform_name) REFERENCES Platform(name)
);

CREATE TABLE Streams_Series (
    series_ID INT,
    ordinal_number INT,
    platform_name VARCHAR(50),
    PRIMARY KEY (series_ID, platform_name),
    FOREIGN KEY (series_ID) REFERENCES Series(series_ID),
    FOREIGN KEY (platform_name) REFERENCES Platform(name)
);

CREATE TABLE Subscriber (
    ID INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50),
    start_date DATE,
    email VARCHAR(100),
    password VARCHAR(255)
);

CREATE TABLE Favorite_List_Movie (
    ordinal_number INT,
    movie_ID INT,
    user_ID INT,
    PRIMARY KEY (user_ID, ordinal_number),
    FOREIGN KEY (movie_ID) REFERENCES Movie(movie_ID),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID)
);

CREATE TABLE Favorite_List_Series (
    ordinal_number INT,
    series_ID INT,
    user_ID INT,
    PRIMARY KEY (user_ID, ordinal_number),
    FOREIGN KEY (series_ID) REFERENCES Series(series_ID),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID)
);

CREATE TABLE To_Watch_List_Movie (
    ordinal_number INT,
    movie_ID INT,
    user_ID INT,
    PRIMARY KEY (user_ID, ordinal_number),
    FOREIGN KEY (movie_ID) REFERENCES Movie(movie_ID),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID)
);

CREATE TABLE To_Watch_List_Series (
    ordinal_number INT,
    series_ID INT,
    user_ID INT,
    PRIMARY KEY (user_ID, ordinal_number),
    FOREIGN KEY (series_ID) REFERENCES Series(series_ID),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID)
);

CREATE TABLE Watched_List_Movie (
    ordinal_number INT,
    movie_ID INT,
    user_ID INT,
    PRIMARY KEY (user_ID, ordinal_number),
    FOREIGN KEY (movie_ID) REFERENCES Movie(movie_ID),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID)
);

CREATE TABLE Watched_List_Series (
    ordinal_number INT,
    series_ID INT,
    user_ID INT,
    PRIMARY KEY (user_ID, ordinal_number),
    FOREIGN KEY (series_ID) REFERENCES Series(series_ID),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID)
);

CREATE TABLE Comment_Movie (
    comment_id INT PRIMARY KEY IDENTITY(1,1), 
    movie_ID INT NOT NULL,  
    season_ordinal_number INT,
    user_ID INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID),
    FOREIGN KEY (movie_ID) REFERENCES Movie(movie_ID)
);

CREATE TABLE Comment_Series (
    comment_id INT PRIMARY KEY IDENTITY(1,1),  
    series_ID INT NOT NULL, 
    season_ordinal_number INT,
    user_ID INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID),
    FOREIGN KEY (series_ID) REFERENCES Series(series_ID)
);

CREATE TABLE Reply_Movie (
    reply_id INT PRIMARY KEY IDENTITY(1,1),  
    movie_ID INT NOT NULL,
    season_ordinal_number INT,
    comment_id INT NOT NULL, 
    user_ID INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (movie_ID) REFERENCES Movie(movie_ID),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID),
    FOREIGN KEY (comment_id) REFERENCES Comment_Movie(comment_id) 
);

CREATE TABLE Reply_Series (
    reply_id INT PRIMARY KEY IDENTITY(1,1), 
    series_ID INT NOT NULL,
    season_ordinal_number INT,
    comment_id INT NOT NULL,  
    user_ID INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (series_ID) REFERENCES Series(series_ID),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID),
    FOREIGN KEY (comment_id) REFERENCES Comment_Series(comment_id) 
);

CREATE TABLE Rate_Movie (
    ordinal_number INT,
    movie_ID INT,
    user_ID INT,
    rating INT CHECK (rating BETWEEN 1 AND 10),
    rated_at DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (user_ID, movie_ID),
    FOREIGN KEY (movie_ID) REFERENCES Movie(movie_ID),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID)
);

CREATE TABLE Rate_Series (
    ordinal_number INT,
    series_ID INT,
    user_ID INT,
    rating INT CHECK (rating BETWEEN 1 AND 10),
    rated_at DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (user_ID, series_ID),
    FOREIGN KEY (series_ID) REFERENCES Series(series_ID),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID)
);

CREATE TABLE Can_Like_Comment_Movie (
    user_ID INT,
    comment_id INT,
    liked_at DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (user_ID, comment_id),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID),
    FOREIGN KEY (comment_id) REFERENCES Comment_Movie(comment_id)
);

CREATE TABLE Can_Like_Comment_Series (
    user_ID INT,
    comment_id INT,
    liked_at DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (user_ID, comment_id),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID),
    FOREIGN KEY (comment_id) REFERENCES Comment_Series(comment_id)
);

CREATE TABLE Can_Like_Reply_Movie (
    user_ID INT,
    reply_id INT,
    liked_at DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (user_ID, reply_id),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID),
    FOREIGN KEY (reply_id) REFERENCES Reply_Movie(reply_id)
);

CREATE TABLE Can_Like_Reply_Series (
    user_ID INT,
    reply_id INT,
    liked_at DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (user_ID, reply_id),
    FOREIGN KEY (user_ID) REFERENCES Subscriber(ID),
    FOREIGN KEY (reply_id) REFERENCES Reply_Series(reply_id)
);

CREATE TABLE Movie_Season (
    movie_ID INT PRIMARY KEY,
    length INT,
    ordinal_number INT NOT NULL,
    release_date DATE NOT NULL,
    season_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (movie_ID) REFERENCES Movie(movie_ID)
);

CREATE TABLE Series_Season (
    series_ID INT,
    ordinal_number INT,
    season_name VARCHAR(50) NOT NULL,
    release_date DATE NOT NULL,
    PRIMARY KEY (series_ID, ordinal_number), 
    FOREIGN KEY (series_ID) REFERENCES Series(series_ID)
);

CREATE TABLE Episode (
    series_ID INT,
    season_ordinal_number INT,
    episode_ordinal_number INT,
    title VARCHAR(255) NOT NULL,
    length INT NOT NULL,
    description TEXT,
    release_date DATE NOT NULL,
    PRIMARY KEY (series_ID, season_ordinal_number, episode_ordinal_number),
    FOREIGN KEY (series_ID, season_ordinal_number) REFERENCES Series_Season(series_ID, ordinal_number)
);
