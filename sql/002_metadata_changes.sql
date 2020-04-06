ALTER TABLE isbasedon ALTER COLUMN author DROP not null;
ALTER TABLE Material ALTER COLUMN MaterialLanguageKey TYPE TEXT;

ALTER TABLE IF EXISTS isbasedon DROP CONSTRAINT constraint_isbasedon;
ALTER TABLE isbasedon ADD CONSTRAINT constraint_isbasedon UNIQUE (materialname,educationalmaterialid);

CREATE TABLE IsBasedOnAuthor (
  Id           BIGSERIAL NOT NULL, 
  AuthorName  text NOT NULL, 
  IsBasedOnId int8 NOT NULL, 
  PRIMARY KEY (Id));
ALTER TABLE IsBasedOnAuthor ADD CONSTRAINT FKIsBasedOnAuthor FOREIGN KEY (IsBasedOnId) REFERENCES IsBasedOn (Id);

ALTER TABLE isbasedon DROP COLUMN author;

ALTER TABLE attachment ADD COLUMN Obsoleted int4 DEFAULT 0 NOT NULL;

--24.3.2020 feat-582
ALTER TABLE educationalmaterial ADD COLUMN SuitsAllUpperSecondarySubjectsNew bool DEFAULT 'false' NOT NULL;

--feat 592
CREATE TABLE Rating (
  Id                     BIGSERIAL NOT NULL, 
  RatingContent         int4, 
  RatingVisual          int4, 
  FeedbackPositive      varchar(1000), 
  FeedbackSuggest       varchar(1000), 
  FeedbackPurpose       varchar(1000), 
  EducationalMaterialId int8 NOT NULL, 
  UsersUserName         text NOT NULL,
  UpdatedAt        timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (Id));
ALTER TABLE Rating ADD CONSTRAINT FKRatingUsers FOREIGN KEY (UsersUserName) REFERENCES Users (UserName);
ALTER TABLE Rating ADD CONSTRAINT FKRatingEducationalMaterial FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id);
ALTER TABLE Rating ADD CONSTRAINT constraint_Rating UNIQUE (UsersUserName,educationalmaterialid);
ALTER TABLE educationalmaterial ADD COLUMN RatingContentAverage NUMERIC (2, 1);
ALTER TABLE educationalmaterial ADD COLUMN RatingVisualAverage NUMERIC (2, 1);
