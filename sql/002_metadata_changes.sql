ALTER TABLE Material ALTER COLUMN MaterialLanguageKey TYPE TEXT;

ALTER TABLE IF EXISTS isbasedon DROP CONSTRAINT constraint_isbasedon;
ALTER TABLE isbasedon ADD CONSTRAINT constraint_isbasedon UNIQUE (materialname,educationalmaterialid);

CREATE TABLE IsBasedOnAuthor (
  Id           BIGSERIAL NOT NULL, 
  AuthorName  text NOT NULL, 
  IsBasedOnId int8 NOT NULL, 
  PRIMARY KEY (Id));
ALTER TABLE IsBasedOnAuthor ADD CONSTRAINT FKIsBasedOnAuthor FOREIGN KEY (IsBasedOnId) REFERENCES IsBasedOn (Id);
